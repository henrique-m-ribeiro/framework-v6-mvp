"""
Validação das Entregas da Fase 1 - Framework V6.0
Infraestrutura e Curadoria

Verifica se todas as entregas da Fase 1 foram concluídas com sucesso.
"""

import sys
from database import get_db_manager
from config import Config


def validate_environment() -> bool:
    """Valida configuração do ambiente."""
    print("\n📦 1. VALIDAÇÃO DO AMBIENTE")
    print("=" * 60)
    
    try:
        Config.validate()
        print("✅ Variáveis de ambiente configuradas")
        print(f"   - DB_HOST: {Config.DB_HOST}")
        print(f"   - DB_NAME: {Config.DB_NAME}")
        print(f"   - EMBEDDING_MODEL: {Config.EMBEDDING_MODEL}")
        print(f"   - GENERATION_MODEL: {Config.GENERATION_MODEL}")
        return True
    except Exception as e:
        print(f"❌ Erro na configuração: {e}")
        return False


def validate_database_structure() -> bool:
    """Valida estrutura do banco de dados."""
    print("\n🗄️  2. VALIDAÇÃO DA ESTRUTURA DO BANCO")
    print("=" * 60)
    
    db = get_db_manager()
    
    # Tabelas esperadas
    expected_tables = [
        'agent_econ_memory',
        'agent_social_memory',
        'agent_terra_memory',
        'agent_ambient_memory',
        'agent_econ_learning',
        'agent_social_learning',
        'agent_terra_learning',
        'agent_ambient_learning',
        'knowledge_base',
        'audit_trail',
        'spatial_relations',
        'territories'
    ]
    
    missing_tables = []
    
    for table in expected_tables:
        if db.table_exists(table):
            print(f"✅ Tabela '{table}' existe")
        else:
            print(f"❌ Tabela '{table}' NÃO existe")
            missing_tables.append(table)
    
    # Não fechar o pool aqui - será fechado no final
    
    if missing_tables:
        print(f"\n❌ {len(missing_tables)} tabela(s) faltando")
        return False
    else:
        print(f"\n✅ Todas as {len(expected_tables)} tabelas estão presentes")
        return True


def validate_audit_system(db) -> bool:
    """Valida sistema de auditoria."""
    print("\n📋 3. VALIDAÇÃO DO SISTEMA DE AUDITORIA")
    print("=" * 60)
    
    try:
        # Verificar se há eventos registrados
        result = db.execute_query("""
            SELECT 
                COUNT(*) as total_events,
                COUNT(DISTINCT event_type) as event_types,
                COUNT(DISTINCT agent_id) as agents
            FROM audit_trail;
        """)
        
        stats = result[0]
        
        print(f"✅ Sistema de auditoria ativo")
        print(f"   - Total de eventos: {stats['total_events']}")
        print(f"   - Tipos de evento: {stats['event_types']}")
        print(f"   - Agentes registrados: {stats['agents']}")
        
        # Verificar eventos recentes
        recent = db.execute_query("""
            SELECT event_type, agent_id, action, status, created_at
            FROM audit_trail
            ORDER BY created_at DESC
            LIMIT 5;
        """)
        
        print(f"\n   Eventos recentes:")
        for event in recent:
            print(f"   - [{event['event_type']}] {event['action']} ({event['status']})")
        
        return stats['total_events'] > 0
        
    except Exception as e:
        print(f"❌ Erro ao validar auditoria: {e}")
        return False


def validate_curated_memory(db) -> bool:
    """Valida memória curada do Agente ECON."""
    print("\n📚 4. VALIDAÇÃO DA CURADORIA ASSISTIDA")
    print("=" * 60)
    
    try:
        # Verificar documentos em agent_econ_memory
        result = db.execute_query("""
            SELECT 
                COUNT(*) as total_docs,
                AVG(confidence_score) as avg_confidence,
                MIN(created_at) as first_doc,
                MAX(created_at) as last_doc
            FROM agent_econ_memory;
        """)
        
        stats = result[0]
        
        print(f"✅ Memória do Agente ECON populada")
        print(f"   - Total de documentos: {stats['total_docs']}")
        print(f"   - Confiança média: {stats['avg_confidence']:.2f}")
        print(f"   - Primeiro documento: {stats['first_doc']}")
        print(f"   - Último documento: {stats['last_doc']}")
        
        # Verificar documentos de maior relevância
        top_docs = db.execute_query("""
            SELECT analysis_summary, confidence_score
            FROM agent_econ_memory
            ORDER BY confidence_score DESC
            LIMIT 3;
        """)
        
        print(f"\n   Top 3 documentos por relevância:")
        for i, doc in enumerate(top_docs, 1):
            print(f"   {i}. {doc['analysis_summary'][:70]}... ({doc['confidence_score']:.2f})")
        
        # Critério: pelo menos 10 documentos
        return stats['total_docs'] >= 10
        
    except Exception as e:
        print(f"❌ Erro ao validar curadoria: {e}")
        return False


def validate_spatial_relations(db) -> bool:
    """Valida relações espaciais pré-computadas."""
    print("\n🗺️  5. VALIDAÇÃO DAS RELAÇÕES ESPACIAIS")
    print("=" * 60)
    
    try:
        # Verificar relações computadas
        result = db.execute_query("""
            SELECT 
                COUNT(*) as total_relations,
                COUNT(DISTINCT territory_id_a) as territories_a,
                COUNT(DISTINCT territory_id_b) as territories_b,
                AVG(distance_km) as avg_distance,
                MIN(distance_km) as min_distance,
                MAX(distance_km) as max_distance
            FROM spatial_relations;
        """)
        
        stats = result[0]
        
        print(f"✅ Relações espaciais computadas")
        print(f"   - Total de relações: {stats['total_relations']}")
        print(f"   - Territórios (origem): {stats['territories_a']}")
        print(f"   - Territórios (destino): {stats['territories_b']}")
        print(f"   - Distância média: {stats['avg_distance']:.2f} km")
        print(f"   - Distância mínima: {stats['min_distance']:.2f} km")
        print(f"   - Distância máxima: {stats['max_distance']:.2f} km")
        
        # Verificar relações mais próximas
        closest = db.execute_query("""
            SELECT metadata, distance_km
            FROM spatial_relations
            ORDER BY distance_km
            LIMIT 3;
        """)
        
        print(f"\n   Relações mais próximas:")
        for i, rel in enumerate(closest, 1):
            name_a = rel['metadata'].get('name_a', 'N/A')
            name_b = rel['metadata'].get('name_b', 'N/A')
            print(f"   {i}. {name_a} ↔ {name_b}: {rel['distance_km']} km")
        
        # Critério: pelo menos 100 relações (amostra)
        return stats['total_relations'] >= 100
        
    except Exception as e:
        print(f"❌ Erro ao validar relações espaciais: {e}")
        return False


def generate_summary() -> None:
    """Gera sumário final da validação."""
    print("\n" + "=" * 80)
    print("SUMÁRIO DA VALIDAÇÃO DA FASE 1")
    print("=" * 80)
    
    # Obter instância única do DB manager
    db = get_db_manager()
    
    results = {
        "Configuração do Ambiente": validate_environment(),
        "Estrutura do Banco de Dados": validate_database_structure(),
        "Sistema de Auditoria": validate_audit_system(db),
        "Curadoria Assistida": validate_curated_memory(db),
        "Relações Espaciais": validate_spatial_relations(db)
    }
    
    # Fechar conexão no final
    db.close()
    
    print("\n📊 RESULTADOS:")
    for check, passed in results.items():
        status = "✅ PASSOU" if passed else "❌ FALHOU"
        print(f"   {status} - {check}")
    
    total = len(results)
    passed = sum(results.values())
    percentage = (passed / total) * 100
    
    print(f"\n🎯 TAXA DE SUCESSO: {passed}/{total} ({percentage:.0f}%)")
    
    if all(results.values()):
        print("\n🎉 FASE 1 CONCLUÍDA COM SUCESSO!")
        print("   Todas as entregas foram validadas.")
        return True
    else:
        print("\n⚠️  FASE 1 PARCIALMENTE CONCLUÍDA")
        print("   Algumas entregas precisam de atenção.")
        return False


if __name__ == "__main__":
    print("=" * 80)
    print("VALIDAÇÃO DAS ENTREGAS DA FASE 1")
    print("Framework V6.0 - Infraestrutura e Curadoria")
    print("=" * 80)
    
    try:
        success = generate_summary()
        sys.exit(0 if success else 1)
        
    except Exception as e:
        print(f"\n❌ Erro durante validação: {e}")
        sys.exit(1)
