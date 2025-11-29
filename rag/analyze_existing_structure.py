"""
Análise da Estrutura RAG Existente no Banco de Dados
Framework V6.0 - Integração com Estrutura Replit

Este script examina a estrutura existente no banco de dados e compara
com o Modelo Conceitual RAG Evolutivo v3.0 da Sessão #6.
"""

import json
from database import get_db_manager
from typing import Dict, List, Any


def analyze_table_structure(db, table_name: str) -> Dict[str, Any]:
    """Analisa a estrutura de uma tabela específica."""
    
    # Obter schema da tabela
    schema = db.get_table_schema(table_name)
    
    # Contar registros
    count_query = f"SELECT COUNT(*) as count FROM {table_name};"
    count_result = db.execute_query(count_query)
    record_count = count_result[0]['count'] if count_result else 0
    
    # Identificar colunas de embedding
    embedding_cols = [col['column_name'] for col in schema if 'vector' in col['data_type'].lower()]
    
    # Identificar colunas JSONB
    jsonb_cols = [col['column_name'] for col in schema if col['data_type'] == 'jsonb']
    
    return {
        'name': table_name,
        'columns': len(schema),
        'records': record_count,
        'embedding_columns': embedding_cols,
        'jsonb_columns': jsonb_cols,
        'schema': schema
    }


def categorize_tables(tables: List[str]) -> Dict[str, List[str]]:
    """Categoriza as tabelas por tipo."""
    
    categories = {
        'memory': [],
        'learning': [],
        'indicators': [],
        'infrastructure': [],
        'other': []
    }
    
    for table in tables:
        if '_memory' in table:
            categories['memory'].append(table)
        elif '_learning' in table:
            categories['learning'].append(table)
        elif '_indicators' in table or table == 'indicator_metadata':
            categories['indicators'].append(table)
        elif table in ['territories', 'spatial_relations', 'audit_trail', 'knowledge_base']:
            categories['infrastructure'].append(table)
        else:
            categories['other'].append(table)
    
    return categories


def compare_with_conceptual_model(analysis: Dict[str, Any]) -> Dict[str, Any]:
    """Compara a estrutura existente com o modelo conceitual v3.0."""
    
    expected_structure = {
        'layer_1_memory': [
            'agent_econ_memory',
            'agent_social_memory',
            'agent_terra_memory',
            'agent_ambient_memory'
        ],
        'layer_2_learning': [
            'agent_econ_learning',
            'agent_social_learning',
            'agent_terra_learning',
            'agent_ambient_learning'
        ],
        'layer_3_organizational': [
            'knowledge_base'
        ],
        'infrastructure': [
            'territories',
            'spatial_relations',
            'audit_trail'
        ]
    }
    
    comparison = {
        'aligned': [],
        'extra': [],
        'missing': []
    }
    
    # Verificar tabelas esperadas
    all_expected = []
    for category, tables in expected_structure.items():
        all_expected.extend(tables)
    
    existing_tables = list(analysis.keys())
    
    for table in all_expected:
        if table in existing_tables:
            comparison['aligned'].append(table)
        else:
            comparison['missing'].append(table)
    
    for table in existing_tables:
        if table not in all_expected:
            comparison['extra'].append(table)
    
    return comparison


def generate_report(db) -> Dict[str, Any]:
    """Gera relatório completo da análise."""
    
    print("\n" + "=" * 80)
    print("ANÁLISE DA ESTRUTURA RAG EXISTENTE")
    print("=" * 80)
    
    # Listar todas as tabelas
    tables_query = """
        SELECT tablename 
        FROM pg_tables 
        WHERE schemaname = 'public' 
        AND tablename NOT LIKE 'spatial_ref_sys'
        ORDER BY tablename;
    """
    
    tables_result = db.execute_query(tables_query)
    all_tables = [t['tablename'] for t in tables_result]
    
    print(f"\n📊 Total de tabelas encontradas: {len(all_tables)}")
    
    # Categorizar tabelas
    categories = categorize_tables(all_tables)
    
    print("\n📁 CATEGORIZAÇÃO DAS TABELAS:")
    for category, tables in categories.items():
        if tables:
            print(f"\n  {category.upper()} ({len(tables)} tabelas):")
            for table in tables:
                print(f"    - {table}")
    
    # Analisar cada tabela
    print("\n" + "=" * 80)
    print("ANÁLISE DETALHADA POR TABELA")
    print("=" * 80)
    
    table_analysis = {}
    
    for table in all_tables:
        print(f"\n📋 Analisando: {table}")
        analysis = analyze_table_structure(db, table)
        table_analysis[table] = analysis
        
        print(f"   Colunas: {analysis['columns']}")
        print(f"   Registros: {analysis['records']}")
        
        if analysis['embedding_columns']:
            print(f"   Embeddings: {', '.join(analysis['embedding_columns'])}")
        
        if analysis['jsonb_columns']:
            print(f"   JSONB: {', '.join(analysis['jsonb_columns'])}")
    
    # Comparar com modelo conceitual
    print("\n" + "=" * 80)
    print("COMPARAÇÃO COM MODELO CONCEITUAL V3.0")
    print("=" * 80)
    
    comparison = compare_with_conceptual_model(table_analysis)
    
    print(f"\n✅ ALINHADAS ({len(comparison['aligned'])} tabelas):")
    for table in comparison['aligned']:
        print(f"   - {table}")
    
    if comparison['extra']:
        print(f"\n➕ EXTRAS ({len(comparison['extra'])} tabelas):")
        print("   (Tabelas que existem mas não estão no modelo conceitual)")
        for table in comparison['extra']:
            print(f"   - {table}")
    
    if comparison['missing']:
        print(f"\n⚠️  FALTANDO ({len(comparison['missing'])} tabelas):")
        for table in comparison['missing']:
            print(f"   - {table}")
    
    # Gerar sumário
    report = {
        'total_tables': len(all_tables),
        'categories': {k: len(v) for k, v in categories.items()},
        'tables': table_analysis,
        'comparison': comparison
    }
    
    return report


if __name__ == "__main__":
    """Executa a análise da estrutura existente."""
    
    try:
        db = get_db_manager()
        report = generate_report(db)
        
        # Salvar relatório em JSON
        report_file = "/home/ubuntu/framework-v6-mvp/docs/sessao7/analise_estrutura_existente.json"
        with open(report_file, 'w', encoding='utf-8') as f:
            json.dump(report, f, indent=2, ensure_ascii=False, default=str)
        
        print(f"\n💾 Relatório salvo em: {report_file}")
        
        db.close()
        
        print("\n✅ Análise concluída com sucesso!")
        
    except Exception as e:
        print(f"\n❌ Erro durante análise: {e}")
        raise
