"""
Script de Migração - Relações Espaciais
Framework V6.0 - Fase 1: Infraestrutura e Curadoria
"""

import sys
from pathlib import Path
from database import get_db_manager
from config import Config


def run_spatial_migration() -> bool:
    """Executa a migração para criar tabela de relações espaciais."""
    
    migration_file = "/home/ubuntu/framework-v6-mvp/database/migrations/create_spatial_relations.sql"
    migration_path = Path(migration_file)
    
    if not migration_path.exists():
        print(f"❌ Arquivo de migração não encontrado: {migration_file}")
        return False
    
    print(f"📄 Lendo migração: {migration_path.name}")
    
    with open(migration_path, 'r', encoding='utf-8') as f:
        sql_content = f.read()
    
    db = get_db_manager()
    
    try:
        print("\n🚀 Executando migração...")
        
        with db.get_cursor(dict_cursor=False) as cursor:
            cursor.execute(sql_content)
        
        print("✅ Migração executada com sucesso!")
        
        # Verificar se a tabela foi criada
        if db.table_exists('spatial_relations'):
            print("✅ Tabela 'spatial_relations' criada com sucesso")
            
            # Contar índices criados
            index_query = """
                SELECT indexname 
                FROM pg_indexes 
                WHERE tablename = 'spatial_relations';
            """
            indexes = db.execute_query(index_query)
            print(f"✅ {len(indexes)} índices criados")
            for idx in indexes:
                print(f"   - {idx['indexname']}")
        else:
            print("⚠️  Tabela 'spatial_relations' não foi criada")
            return False
        
        db.close()
        return True
        
    except Exception as e:
        print(f"❌ Erro ao executar migração: {e}")
        db.close()
        return False


if __name__ == "__main__":
    print("=" * 80)
    print("MIGRAÇÃO: RELAÇÕES ESPACIAIS")
    print("=" * 80)
    
    try:
        Config.validate()
        
        success = run_spatial_migration()
        
        if success:
            print("\n✅ Migração concluída com sucesso!")
            sys.exit(0)
        else:
            print("\n❌ Migração falhou!")
            sys.exit(1)
            
    except Exception as e:
        print(f"\n❌ Erro: {e}")
        sys.exit(1)
