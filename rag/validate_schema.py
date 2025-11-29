"""
Script de Validação de Schema - Framework V6.0
Fase 1: Infraestrutura e Curadoria

Valida e documenta o schema das tabelas das 3 camadas de memória:
- Camada 1: Memória Especializada (agent_xxx_memory)
- Camada 2: Aprendizado Evolutivo (agent_xxx_learning)
- Camada 3: Memória Organizacional (knowledge_base)
"""

from database import get_db_manager
from config import Config
from typing import List, Dict, Any
import json


def validate_memory_tables() -> Dict[str, Any]:
    """Valida as tabelas de memória das 3 camadas."""
    
    db = get_db_manager()
    
    # Tabelas esperadas para cada camada
    agents = ['econ', 'social', 'terra', 'ambient']
    
    results = {
        'camada_1_memory': {},
        'camada_2_learning': {},
        'camada_3_knowledge_base': {},
        'summary': {
            'total_tables': 0,
            'existing_tables': 0,
            'missing_tables': []
        }
    }
    
    print("=" * 80)
    print("VALIDAÇÃO DE SCHEMA - ARQUITETURA RAG DE 3 CAMADAS")
    print("=" * 80)
    
    # Camada 1: Memória Especializada (agent_xxx_memory)
    print("\n📚 CAMADA 1: MEMÓRIA ESPECIALIZADA (agent_xxx_memory)")
    print("-" * 80)
    
    for agent in agents:
        table_name = f"agent_{agent}_memory"
        results['summary']['total_tables'] += 1
        
        if db.table_exists(table_name):
            schema = db.get_table_schema(table_name)
            results['camada_1_memory'][table_name] = {
                'exists': True,
                'columns': schema
            }
            results['summary']['existing_tables'] += 1
            
            print(f"\n✅ Tabela: {table_name}")
            print(f"   Colunas ({len(schema)}):")
            for col in schema:
                nullable = "NULL" if col['is_nullable'] == 'YES' else "NOT NULL"
                print(f"     - {col['column_name']}: {col['data_type']} {nullable}")
        else:
            results['camada_1_memory'][table_name] = {'exists': False}
            results['summary']['missing_tables'].append(table_name)
            print(f"\n❌ Tabela: {table_name} (NÃO EXISTE)")
    
    # Camada 2: Aprendizado Evolutivo (agent_xxx_learning)
    print("\n\n🧠 CAMADA 2: APRENDIZADO EVOLUTIVO (agent_xxx_learning)")
    print("-" * 80)
    
    for agent in agents:
        table_name = f"agent_{agent}_learning"
        results['summary']['total_tables'] += 1
        
        if db.table_exists(table_name):
            schema = db.get_table_schema(table_name)
            results['camada_2_learning'][table_name] = {
                'exists': True,
                'columns': schema
            }
            results['summary']['existing_tables'] += 1
            
            print(f"\n✅ Tabela: {table_name}")
            print(f"   Colunas ({len(schema)}):")
            for col in schema:
                nullable = "NULL" if col['is_nullable'] == 'YES' else "NOT NULL"
                print(f"     - {col['column_name']}: {col['data_type']} {nullable}")
        else:
            results['camada_2_learning'][table_name] = {'exists': False}
            results['summary']['missing_tables'].append(table_name)
            print(f"\n❌ Tabela: {table_name} (NÃO EXISTE)")
    
    # Camada 3: Memória Organizacional (knowledge_base)
    print("\n\n🏢 CAMADA 3: MEMÓRIA ORGANIZACIONAL (knowledge_base)")
    print("-" * 80)
    
    table_name = "knowledge_base"
    results['summary']['total_tables'] += 1
    
    if db.table_exists(table_name):
        schema = db.get_table_schema(table_name)
        results['camada_3_knowledge_base'][table_name] = {
            'exists': True,
            'columns': schema
        }
        results['summary']['existing_tables'] += 1
        
        print(f"\n✅ Tabela: {table_name}")
        print(f"   Colunas ({len(schema)}):")
        for col in schema:
            nullable = "NULL" if col['is_nullable'] == 'YES' else "NOT NULL"
            print(f"     - {col['column_name']}: {col['data_type']} {nullable}")
    else:
        results['camada_3_knowledge_base'][table_name] = {'exists': False}
        results['summary']['missing_tables'].append(table_name)
        print(f"\n❌ Tabela: {table_name} (NÃO EXISTE)")
    
    # Verificar extensão pgvector
    print("\n\n🔌 EXTENSÕES DO POSTGRESQL")
    print("-" * 80)
    
    extensions_query = """
        SELECT extname, extversion 
        FROM pg_extension 
        WHERE extname IN ('vector', 'postgis');
    """
    extensions = db.execute_query(extensions_query)
    
    for ext in extensions:
        print(f"✅ {ext['extname']} (versão {ext['extversion']})")
    
    if not any(ext['extname'] == 'vector' for ext in extensions):
        print("⚠️  Extensão 'vector' (pgvector) não encontrada")
    
    # Resumo
    print("\n\n📊 RESUMO DA VALIDAÇÃO")
    print("=" * 80)
    print(f"Total de tabelas esperadas: {results['summary']['total_tables']}")
    print(f"Tabelas existentes: {results['summary']['existing_tables']}")
    print(f"Tabelas faltando: {len(results['summary']['missing_tables'])}")
    
    if results['summary']['missing_tables']:
        print(f"\n⚠️  Tabelas faltando:")
        for table in results['summary']['missing_tables']:
            print(f"   - {table}")
    
    if results['summary']['existing_tables'] == results['summary']['total_tables']:
        print("\n✅ TODAS AS TABELAS ESTÃO PRESENTES!")
    else:
        print(f"\n⚠️  ATENÇÃO: {len(results['summary']['missing_tables'])} tabela(s) faltando")
    
    print("=" * 80)
    
    return results


def check_vector_columns() -> None:
    """Verifica se as tabelas têm colunas de embedding (vector)."""
    
    db = get_db_manager()
    
    print("\n\n🔍 VERIFICAÇÃO DE COLUNAS DE EMBEDDING (VECTOR)")
    print("=" * 80)
    
    # Buscar todas as colunas do tipo 'vector' ou 'USER-DEFINED' (pgvector)
    query = """
        SELECT 
            table_name,
            column_name,
            data_type,
            udt_name
        FROM information_schema.columns
        WHERE table_schema = 'public'
        AND (data_type = 'USER-DEFINED' OR column_name LIKE '%embedding%' OR column_name LIKE '%vector%')
        ORDER BY table_name, column_name;
    """
    
    vector_columns = db.execute_query(query)
    
    if vector_columns:
        print(f"\n✅ Encontradas {len(vector_columns)} colunas de embedding:\n")
        for col in vector_columns:
            print(f"   {col['table_name']}.{col['column_name']}: {col['udt_name']}")
    else:
        print("\n⚠️  Nenhuma coluna de embedding encontrada")
        print("   As tabelas podem precisar de migração para adicionar suporte a embeddings")


if __name__ == "__main__":
    try:
        Config.validate()
        
        # Validar schema das tabelas
        results = validate_memory_tables()
        
        # Verificar colunas de embedding
        check_vector_columns()
        
        # Salvar resultados em JSON
        output_file = "/home/ubuntu/framework-v6-mvp/rag/schema_validation_results.json"
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(results, f, indent=2, default=str)
        
        print(f"\n💾 Resultados salvos em: {output_file}")
        
        # Fechar conexão
        db = get_db_manager()
        db.close()
        
    except Exception as e:
        print(f"\n❌ Erro durante validação: {e}")
        raise
