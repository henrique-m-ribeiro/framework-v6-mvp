"""
Script para executar a migração das tabelas de aprendizagem evolutiva
"""

import psycopg2
from config import Config


def run_migration():
    """Executa a migração para criar as tabelas de aprendizagem evolutiva"""
    
    print("=" * 80)
    print("MIGRAÇÃO: Criar Tabelas de Aprendizagem Evolutiva")
    print("=" * 80)
    
    # Ler o arquivo SQL
    with open('../database/migrations/create_learning_evolution_tables.sql', 'r') as f:
        sql_script = f.read()
    
    # Conectar ao banco
    print("\n1. Conectando ao banco de dados...")
    conn = psycopg2.connect(
        host=Config.DB_HOST,
        port=Config.DB_PORT,
        database=Config.DB_NAME,
        user=Config.DB_USER,
        password=Config.DB_PASSWORD
    )
    
    cursor = conn.cursor()
    
    try:
        print("   ✓ Conexão estabelecida")
        
        # Executar o script SQL
        print("\n2. Executando script de migração...")
        cursor.execute(sql_script)
        
        conn.commit()
        print("   ✓ Migração executada com sucesso")
        
        # Validar que as tabelas foram criadas
        print("\n3. Validando tabelas criadas...")
        cursor.execute("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_name LIKE '%learning_evolution'
            ORDER BY table_name
        """)
        
        tables = cursor.fetchall()
        for table in tables:
            print(f"   ✓ {table[0]}")
        
        # Testar a função get_agent_expertise
        print("\n4. Testando função get_agent_expertise...")
        cursor.execute("SELECT * FROM get_agent_expertise('econ')")
        result = cursor.fetchone()
        print(f"   ✓ Agente ECON: {result[2]} (nível {result[3]}, {result[1]} ciclos)")
        
        print("\n" + "=" * 80)
        print("✅ MIGRAÇÃO CONCLUÍDA COM SUCESSO!")
        print("=" * 80)
        
    except Exception as e:
        conn.rollback()
        print(f"\n❌ ERRO NA MIGRAÇÃO: {str(e)}")
        raise
    
    finally:
        cursor.close()
        conn.close()


if __name__ == "__main__":
    run_migration()
