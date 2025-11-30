#!/usr/bin/env python3
"""
Script de Validação da Arquitetura do Banco de Dados Neon
Sessão #10 - Framework de Inteligência Territorial V6.0

Este script valida:
1. Conectividade com o banco Neon
2. Existência das 4 camadas da arquitetura RAG
3. Presença do campo agent_id nas tabelas de memória (Camada 1)
4. Estrutura das tabelas de aprendizagem evolutiva (Camada 2)
5. Contagem de registros em cada tabela
"""

import psycopg2
from psycopg2 import sql
from typing import Dict, List, Tuple
import sys

# Credenciais do banco Neon
DB_CONFIG = {
    'host': 'ep-noisy-math-aeyq5dvn.c-2.us-east-2.aws.neon.tech',
    'port': 5432,
    'database': 'neondb',
    'user': 'neondb_owner',
    'password': 'npg_HPRVKaYAT4E5'
}

def connect_to_db() -> psycopg2.extensions.connection:
    """Conecta ao banco de dados Neon."""
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        print("✅ Conexão com Neon estabelecida com sucesso!")
        return conn
    except Exception as e:
        print(f"❌ Erro ao conectar ao banco: {e}")
        sys.exit(1)

def check_table_exists(cursor, table_name: str) -> bool:
    """Verifica se uma tabela existe no banco."""
    cursor.execute("""
        SELECT EXISTS (
            SELECT FROM information_schema.tables 
            WHERE table_schema = 'public' 
            AND table_name = %s
        );
    """, (table_name,))
    return cursor.fetchone()[0]

def get_table_columns(cursor, table_name: str) -> List[str]:
    """Retorna a lista de colunas de uma tabela."""
    cursor.execute("""
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = %s
        ORDER BY ordinal_position;
    """, (table_name,))
    return [row[0] for row in cursor.fetchall()]

def count_records(cursor, table_name: str) -> int:
    """Conta o número de registros em uma tabela."""
    cursor.execute(sql.SQL("SELECT COUNT(*) FROM {}").format(
        sql.Identifier(table_name)
    ))
    return cursor.fetchone()[0]

def validate_layer_0(cursor) -> Dict:
    """Valida a Camada 0: Dados Estruturados."""
    print("\n" + "="*60)
    print("CAMADA 0: DADOS ESTRUTURADOS")
    print("="*60)
    
    tables = [
        'economic_indicators',
        'social_indicators',
        'territorial_indicators',
        'environmental_indicators',
        'institutional_indicators',
        'territories',
        'spatial_relations',
        'indicator_metadata'
    ]
    
    results = {}
    for table in tables:
        exists = check_table_exists(cursor, table)
        count = count_records(cursor, table) if exists else 0
        results[table] = {'exists': exists, 'count': count}
        
        status = "✅" if exists else "❌"
        print(f"{status} {table:30s} | {count:6d} registros")
    
    return results

def validate_layer_1(cursor) -> Dict:
    """Valida a Camada 1: Memória Especializada."""
    print("\n" + "="*60)
    print("CAMADA 1: MEMÓRIA ESPECIALIZADA")
    print("="*60)
    
    tables = [
        'agent_econ_memory',
        'agent_social_memory',
        'agent_terra_memory',
        'agent_ambient_memory'
    ]
    
    results = {}
    for table in tables:
        exists = check_table_exists(cursor, table)
        count = count_records(cursor, table) if exists else 0
        
        # Verificar se o campo agent_id existe
        has_agent_id = False
        if exists:
            columns = get_table_columns(cursor, table)
            has_agent_id = 'agent_id' in columns
        
        results[table] = {
            'exists': exists,
            'count': count,
            'has_agent_id': has_agent_id
        }
        
        status = "✅" if exists else "❌"
        agent_id_status = "✅" if has_agent_id else "❌"
        print(f"{status} {table:30s} | {count:6d} registros | agent_id: {agent_id_status}")
    
    return results

def validate_layer_2(cursor) -> Dict:
    """Valida a Camada 2: Aprendizado Evolutivo."""
    print("\n" + "="*60)
    print("CAMADA 2: APRENDIZADO EVOLUTIVO")
    print("="*60)
    
    tables = [
        'agent_econ_learning_evolution',
        'agent_social_learning_evolution',
        'agent_terra_learning_evolution',
        'agent_ambient_learning_evolution'
    ]
    
    results = {}
    for table in tables:
        exists = check_table_exists(cursor, table)
        count = count_records(cursor, table) if exists else 0
        
        # Verificar campos críticos
        critical_fields = []
        if exists:
            columns = get_table_columns(cursor, table)
            critical_fields = [
                'agent_id' in columns,
                'learning_content' in columns,
                'source_analysis_ids' in columns,
                'confidence_score' in columns
            ]
        
        results[table] = {
            'exists': exists,
            'count': count,
            'has_critical_fields': all(critical_fields) if exists else False
        }
        
        status = "✅" if exists else "❌"
        fields_status = "✅" if all(critical_fields) else "❌"
        print(f"{status} {table:25s} | {count:6d} registros | Campos críticos: {fields_status}")
    
    return results

def validate_layer_3(cursor) -> Dict:
    """Valida a Camada 3: Memória Organizacional."""
    print("\n" + "="*60)
    print("CAMADA 3: MEMÓRIA ORGANIZACIONAL")
    print("="*60)
    
    table = 'knowledge_base'
    exists = check_table_exists(cursor, table)
    count = count_records(cursor, table) if exists else 0
    
    results = {
        table: {'exists': exists, 'count': count}
    }
    
    status = "✅" if exists else "❌"
    print(f"{status} {table:30s} | {count:6d} registros")
    
    return results

def check_expertise_function(cursor) -> bool:
    """Verifica se a função get_agent_expertise existe."""
    cursor.execute("""
        SELECT EXISTS (
            SELECT FROM pg_proc 
            WHERE proname = 'get_agent_expertise'
        );
    """)
    return cursor.fetchone()[0]

def validate_infrastructure(cursor) -> Dict:
    """Valida a infraestrutura de suporte."""
    print("\n" + "="*60)
    print("INFRAESTRUTURA DE SUPORTE")
    print("="*60)
    
    # Verificar extensões
    cursor.execute("SELECT extname, extversion FROM pg_extension WHERE extname IN ('pgvector', 'postgis');")
    extensions = {row[0]: row[1] for row in cursor.fetchall()}
    
    print(f"{'✅' if 'pgvector' in extensions else '❌'} pgvector: {extensions.get('pgvector', 'NÃO INSTALADO')}")
    print(f"{'✅' if 'postgis' in extensions else '❌'} PostGIS: {extensions.get('postgis', 'NÃO INSTALADO')}")
    
    # Verificar tabela de auditoria
    audit_exists = check_table_exists(cursor, 'audit_trail')
    audit_count = count_records(cursor, 'audit_trail') if audit_exists else 0
    print(f"{'✅' if audit_exists else '❌'} audit_trail: {audit_count} eventos registrados")
    
    # Verificar função de expertise
    expertise_func_exists = check_expertise_function(cursor)
    print(f"{'✅' if expertise_func_exists else '❌'} Função get_agent_expertise()")
    
    return {
        'extensions': extensions,
        'audit_trail': {'exists': audit_exists, 'count': audit_count},
        'expertise_function': expertise_func_exists
    }

def main():
    """Função principal."""
    print("\n" + "="*60)
    print("VALIDAÇÃO DA ARQUITETURA DO BANCO DE DADOS NEON")
    print("Framework de Inteligência Territorial V6.0 - Sessão #10")
    print("="*60)
    
    conn = connect_to_db()
    cursor = conn.cursor()
    
    try:
        # Validar cada camada
        layer_0 = validate_layer_0(cursor)
        layer_1 = validate_layer_1(cursor)
        layer_2 = validate_layer_2(cursor)
        layer_3 = validate_layer_3(cursor)
        infra = validate_infrastructure(cursor)
        
        # Resumo final
        print("\n" + "="*60)
        print("RESUMO DA VALIDAÇÃO")
        print("="*60)
        
        # Verificar se todas as tabelas de memória têm agent_id
        all_memory_have_agent_id = all(
            layer_1[table]['has_agent_id'] 
            for table in layer_1 
            if layer_1[table]['exists']
        )
        
        # Verificar se todas as tabelas de aprendizagem existem
        all_learning_exist = all(
            layer_2[table]['exists'] 
            for table in layer_2
        )
        
        print(f"{'✅' if all_memory_have_agent_id else '❌'} Camada 1: Campo agent_id presente em todas as tabelas de memória")
        print(f"{'✅' if all_learning_exist else '❌'} Camada 2: Todas as tabelas de aprendizagem evolutiva existem")
        print(f"{'✅' if layer_3['knowledge_base']['exists'] else '❌'} Camada 3: Tabela knowledge_base existe")
        print(f"{'✅' if infra['expertise_function'] else '❌'} Infraestrutura: Função get_agent_expertise() existe")
        
        # Status geral
        all_ok = (
            all_memory_have_agent_id and
            all_learning_exist and
            layer_3['knowledge_base']['exists'] and
            infra['expertise_function']
        )
        
        print("\n" + "="*60)
        if all_ok:
            print("✅ VALIDAÇÃO CONCLUÍDA COM SUCESSO!")
            print("A arquitetura está 100% alinhada com o esperado.")
        else:
            print("⚠️ VALIDAÇÃO CONCLUÍDA COM RESSALVAS")
            print("Alguns componentes precisam de atenção.")
        print("="*60 + "\n")
        
    except Exception as e:
        print(f"\n❌ Erro durante a validação: {e}")
        import traceback
        traceback.print_exc()
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    main()
