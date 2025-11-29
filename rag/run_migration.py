"""
Script de Migração - Framework V6.0
Executa migrações SQL no banco de dados PostgreSQL
"""

import sys
from pathlib import Path
from database import get_db_manager
from config import Config


def run_migration(migration_file: str) -> bool:
    """Executa um arquivo de migração SQL."""
    
    migration_path = Path(migration_file)
    
    if not migration_path.exists():
        print(f"❌ Arquivo de migração não encontrado: {migration_file}")
        return False
    
    print(f"📄 Lendo migração: {migration_path.name}")
    
    with open(migration_path, 'r', encoding='utf-8') as f:
        sql_content = f.read()
    
    print(f"📝 Conteúdo: {len(sql_content)} caracteres")
    
    db = get_db_manager()
    
    try:
        print("\n🚀 Executando migração...")
        
        with db.get_cursor(dict_cursor=False) as cursor:
            cursor.execute(sql_content)
        
        print("✅ Migração executada com sucesso!")
        
        # Verificar se a tabela foi criada
        if 'audit_trail' in migration_path.name:
            if db.table_exists('audit_trail'):
                print("✅ Tabela 'audit_trail' criada com sucesso")
                
                # Contar índices criados
                index_query = """
                    SELECT indexname 
                    FROM pg_indexes 
                    WHERE tablename = 'audit_trail';
                """
                indexes = db.execute_query(index_query)
                print(f"✅ {len(indexes)} índices criados")
                for idx in indexes:
                    print(f"   - {idx['indexname']}")
            else:
                print("⚠️  Tabela 'audit_trail' não foi criada")
                return False
        
        db.close()
        return True
        
    except Exception as e:
        print(f"❌ Erro ao executar migração: {e}")
        db.close()
        return False


if __name__ == "__main__":
    print("=" * 80)
    print("EXECUÇÃO DE MIGRAÇÃO - FRAMEWORK V6.0")
    print("=" * 80)
    
    try:
        Config.validate()
        
        # Caminho da migração
        migration_file = "/home/ubuntu/framework-v6-mvp/database/migrations/create_audit_trail.sql"
        
        success = run_migration(migration_file)
        
        if success:
            print("\n✅ Migração concluída com sucesso!")
            sys.exit(0)
        else:
            print("\n❌ Migração falhou!")
            sys.exit(1)
            
    except Exception as e:
        print(f"\n❌ Erro: {e}")
        sys.exit(1)
