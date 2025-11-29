"""
Módulo de Conexão com Banco de Dados - Framework V6.0
Fase 1: Infraestrutura e Curadoria

Gerencia conexões com PostgreSQL e operações básicas de banco de dados.
"""

import psycopg2
from psycopg2 import pool
from psycopg2.extras import RealDictCursor
from typing import Optional, List, Dict, Any
from contextlib import contextmanager
from config import Config


class DatabaseManager:
    """Gerenciador de conexões com PostgreSQL."""
    
    def __init__(self):
        """Inicializa o pool de conexões."""
        self.connection_pool: Optional[pool.SimpleConnectionPool] = None
        self._initialize_pool()
    
    def _initialize_pool(self) -> None:
        """Cria o pool de conexões com o banco de dados."""
        try:
            self.connection_pool = pool.SimpleConnectionPool(
                minconn=1,
                maxconn=10,
                host=Config.DB_HOST,
                port=Config.DB_PORT,
                database=Config.DB_NAME,
                user=Config.DB_USER,
                password=Config.DB_PASSWORD,
                sslmode='require'
            )
            print("✅ Pool de conexões PostgreSQL inicializado com sucesso")
        except Exception as e:
            print(f"❌ Erro ao inicializar pool de conexões: {e}")
            raise
    
    @contextmanager
    def get_connection(self):
        """Context manager para obter uma conexão do pool."""
        conn = None
        try:
            conn = self.connection_pool.getconn()
            yield conn
        finally:
            if conn:
                self.connection_pool.putconn(conn)
    
    @contextmanager
    def get_cursor(self, dict_cursor: bool = True):
        """Context manager para obter um cursor."""
        with self.get_connection() as conn:
            cursor_factory = RealDictCursor if dict_cursor else None
            cursor = conn.cursor(cursor_factory=cursor_factory)
            try:
                yield cursor
                conn.commit()
            except Exception as e:
                conn.rollback()
                raise e
            finally:
                cursor.close()
    
    def execute_query(self, query: str, params: Optional[tuple] = None) -> List[Dict[str, Any]]:
        """Executa uma query SELECT e retorna os resultados."""
        with self.get_cursor() as cursor:
            cursor.execute(query, params)
            return cursor.fetchall()
    
    def execute_update(self, query: str, params: Optional[tuple] = None) -> int:
        """Executa uma query INSERT/UPDATE/DELETE e retorna o número de linhas afetadas."""
        with self.get_cursor(dict_cursor=False) as cursor:
            cursor.execute(query, params)
            return cursor.rowcount
    
    def table_exists(self, table_name: str) -> bool:
        """Verifica se uma tabela existe no banco de dados."""
        query = """
            SELECT EXISTS (
                SELECT FROM information_schema.tables 
                WHERE table_schema = 'public' 
                AND table_name = %s
            );
        """
        result = self.execute_query(query, (table_name,))
        return result[0]['exists'] if result else False
    
    def get_table_schema(self, table_name: str) -> List[Dict[str, Any]]:
        """Retorna o schema de uma tabela."""
        query = """
            SELECT 
                column_name,
                data_type,
                character_maximum_length,
                is_nullable,
                column_default
            FROM information_schema.columns
            WHERE table_schema = 'public' 
            AND table_name = %s
            ORDER BY ordinal_position;
        """
        return self.execute_query(query, (table_name,))
    
    def test_connection(self) -> bool:
        """Testa a conexão com o banco de dados."""
        try:
            with self.get_cursor() as cursor:
                cursor.execute("SELECT version();")
                version = cursor.fetchone()
                print(f"✅ Conexão bem-sucedida: {version['version']}")
                return True
        except Exception as e:
            print(f"❌ Erro ao testar conexão: {e}")
            return False
    
    def close(self) -> None:
        """Fecha o pool de conexões."""
        if self.connection_pool:
            self.connection_pool.closeall()
            print("✅ Pool de conexões fechado")


# Singleton global
_db_manager: Optional[DatabaseManager] = None


def get_db_manager() -> DatabaseManager:
    """Retorna a instância singleton do DatabaseManager."""
    global _db_manager
    if _db_manager is None:
        _db_manager = DatabaseManager()
    return _db_manager


if __name__ == "__main__":
    # Teste de conexão
    print("=" * 60)
    print("TESTE DE CONEXÃO COM BANCO DE DADOS")
    print("=" * 60)
    
    try:
        Config.validate()
        db = get_db_manager()
        db.test_connection()
        
        # Listar algumas tabelas
        query = """
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' 
            ORDER BY table_name
            LIMIT 10;
        """
        tables = db.execute_query(query)
        print(f"\n📋 Primeiras 10 tabelas no banco:")
        for table in tables:
            print(f"  - {table['table_name']}")
        
        db.close()
        print("\n✅ Teste concluído com sucesso!")
        
    except Exception as e:
        print(f"\n❌ Erro no teste: {e}")
