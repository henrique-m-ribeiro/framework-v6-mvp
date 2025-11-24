#!/usr/bin/env python3
"""
Framework de Inteligência Territorial V6.0
Script: Criar Estrutura de Memória Distribuída por Agente

Data: 24 de novembro de 2025
Autor: Manus AI
Versão: 1.0.0

OBJETIVO:
Executar o script SQL que cria a estrutura de banco de dados
para memória individual de cada agente especialista.

ARQUITETURA:
- 4 tabelas de memória individual (agent_*_memory)
- 4 tabelas de aprendizado (agent_*_learning)
- Índices IVFFlat para busca vetorial
- Triggers, views e funções auxiliares

USO:
    python3 scripts/create_agent_memory_structure.py

REQUISITOS:
    - psycopg2-binary
    - python-dotenv
    - Variável de ambiente DATABASE_URL configurada
"""

import os
import sys
import psycopg2
from psycopg2 import sql
from datetime import datetime
from pathlib import Path

# Adicionar diretório raiz ao path
ROOT_DIR = Path(__file__).parent.parent
sys.path.insert(0, str(ROOT_DIR))

# Cores para output
class Colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def print_header(text):
    """Imprime cabeçalho formatado"""
    print(f"\n{Colors.HEADER}{Colors.BOLD}{'='*70}{Colors.ENDC}")
    print(f"{Colors.HEADER}{Colors.BOLD}{text.center(70)}{Colors.ENDC}")
    print(f"{Colors.HEADER}{Colors.BOLD}{'='*70}{Colors.ENDC}\n")

def print_success(text):
    """Imprime mensagem de sucesso"""
    print(f"{Colors.OKGREEN}✅ {text}{Colors.ENDC}")

def print_error(text):
    """Imprime mensagem de erro"""
    print(f"{Colors.FAIL}❌ {text}{Colors.ENDC}")

def print_warning(text):
    """Imprime mensagem de aviso"""
    print(f"{Colors.WARNING}⚠️  {text}{Colors.ENDC}")

def print_info(text):
    """Imprime mensagem informativa"""
    print(f"{Colors.OKCYAN}ℹ️  {text}{Colors.ENDC}")

def get_database_url():
    """Obtém a URL de conexão do banco de dados"""
    # Tentar obter de variável de ambiente
    database_url = os.getenv('DATABASE_URL')
    
    if not database_url:
        print_error("Variável de ambiente DATABASE_URL não encontrada!")
        print_info("Configure DATABASE_URL no arquivo .env ou nas variáveis de ambiente do Replit")
        sys.exit(1)
    
    return database_url

def read_sql_file():
    """Lê o arquivo SQL com o script de criação"""
    sql_file_path = ROOT_DIR / 'scripts' / 'create_agent_memory_structure.sql'
    
    if not sql_file_path.exists():
        print_error(f"Arquivo SQL não encontrado: {sql_file_path}")
        sys.exit(1)
    
    print_info(f"Lendo arquivo SQL: {sql_file_path}")
    
    with open(sql_file_path, 'r', encoding='utf-8') as f:
        sql_content = f.read()
    
    print_success(f"Arquivo SQL lido com sucesso ({len(sql_content)} caracteres)")
    return sql_content

def connect_to_database(database_url):
    """Conecta ao banco de dados PostgreSQL"""
    print_info("Conectando ao PostgreSQL...")
    
    try:
        conn = psycopg2.connect(database_url)
        print_success("Conexão estabelecida com sucesso!")
        return conn
    except Exception as e:
        print_error(f"Erro ao conectar ao banco de dados: {e}")
        sys.exit(1)

def execute_sql(conn, sql_content):
    """Executa o script SQL"""
    print_info("Executando script SQL...")
    
    cursor = conn.cursor()
    
    try:
        # Executar o script completo
        cursor.execute(sql_content)
        conn.commit()
        print_success("Script SQL executado com sucesso!")
        return True
    except Exception as e:
        conn.rollback()
        print_error(f"Erro ao executar script SQL: {e}")
        return False
    finally:
        cursor.close()

def verify_tables(conn):
    """Verifica se as tabelas foram criadas corretamente"""
    print_info("Verificando tabelas criadas...")
    
    cursor = conn.cursor()
    
    try:
        # Listar tabelas de memória
        cursor.execute("""
            SELECT tablename, 
                   pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
            FROM pg_tables
            WHERE tablename LIKE 'agent_%'
            ORDER BY tablename;
        """)
        
        tables = cursor.fetchall()
        
        if not tables:
            print_warning("Nenhuma tabela encontrada!")
            return False
        
        print_success(f"{len(tables)} tabelas criadas:")
        for table_name, size in tables:
            print(f"  • {table_name} ({size})")
        
        return True
    except Exception as e:
        print_error(f"Erro ao verificar tabelas: {e}")
        return False
    finally:
        cursor.close()

def verify_indexes(conn):
    """Verifica se os índices foram criados corretamente"""
    print_info("Verificando índices criados...")
    
    cursor = conn.cursor()
    
    try:
        cursor.execute("""
            SELECT indexname, tablename
            FROM pg_indexes
            WHERE tablename LIKE 'agent_%'
            ORDER BY tablename, indexname;
        """)
        
        indexes = cursor.fetchall()
        
        if not indexes:
            print_warning("Nenhum índice encontrado!")
            return False
        
        print_success(f"{len(indexes)} índices criados:")
        
        # Agrupar por tabela
        indexes_by_table = {}
        for index_name, table_name in indexes:
            if table_name not in indexes_by_table:
                indexes_by_table[table_name] = []
            indexes_by_table[table_name].append(index_name)
        
        for table_name, table_indexes in indexes_by_table.items():
            print(f"  • {table_name}: {len(table_indexes)} índices")
        
        return True
    except Exception as e:
        print_error(f"Erro ao verificar índices: {e}")
        return False
    finally:
        cursor.close()

def verify_views(conn):
    """Verifica se as views foram criadas corretamente"""
    print_info("Verificando views criadas...")
    
    cursor = conn.cursor()
    
    try:
        cursor.execute("""
            SELECT viewname
            FROM pg_views
            WHERE viewname LIKE 'v_agent_%'
            ORDER BY viewname;
        """)
        
        views = cursor.fetchall()
        
        if not views:
            print_warning("Nenhuma view encontrada!")
            return False
        
        print_success(f"{len(views)} views criadas:")
        for (view_name,) in views:
            print(f"  • {view_name}")
        
        return True
    except Exception as e:
        print_error(f"Erro ao verificar views: {e}")
        return False
    finally:
        cursor.close()

def show_statistics(conn):
    """Mostra estatísticas das tabelas criadas"""
    print_info("Consultando estatísticas iniciais...")
    
    cursor = conn.cursor()
    
    try:
        # Usar a view criada pelo script SQL
        cursor.execute("SELECT * FROM v_agent_memory_stats;")
        
        stats = cursor.fetchall()
        
        if stats:
            print_success("Estatísticas de memória por agente:")
            print(f"\n{'Agente':<10} {'Análises':<12} {'Territórios':<15} {'Confidence':<12} {'Última Análise':<20}")
            print("-" * 70)
            for agent, total, territories, confidence, last_date in stats:
                conf_str = f"{confidence:.2f}" if confidence else "N/A"
                date_str = str(last_date) if last_date else "N/A"
                print(f"{agent:<10} {total:<12} {territories:<15} {conf_str:<12} {date_str:<20}")
        else:
            print_info("Nenhuma análise ainda (tabelas vazias - OK para início)")
        
        return True
    except Exception as e:
        print_warning(f"Não foi possível consultar estatísticas: {e}")
        return False
    finally:
        cursor.close()

def main():
    """Função principal"""
    print_header("FRAMEWORK V6.0 - CRIAR ESTRUTURA DE MEMÓRIA DISTRIBUÍDA")
    
    print(f"{Colors.BOLD}Data:{Colors.ENDC} {datetime.now().strftime('%d/%m/%Y %H:%M:%S')}")
    print(f"{Colors.BOLD}Objetivo:{Colors.ENDC} Criar tabelas de memória individual para os 4 agentes\n")
    
    # 1. Obter URL do banco de dados
    database_url = get_database_url()
    
    # 2. Ler arquivo SQL
    sql_content = read_sql_file()
    
    # 3. Conectar ao banco de dados
    conn = connect_to_database(database_url)
    
    try:
        # 4. Executar script SQL
        if not execute_sql(conn, sql_content):
            print_error("Falha ao executar script SQL!")
            sys.exit(1)
        
        # 5. Verificar tabelas
        if not verify_tables(conn):
            print_warning("Verificação de tabelas falhou!")
        
        # 6. Verificar índices
        if not verify_indexes(conn):
            print_warning("Verificação de índices falhou!")
        
        # 7. Verificar views
        if not verify_views(conn):
            print_warning("Verificação de views falhou!")
        
        # 8. Mostrar estatísticas
        show_statistics(conn)
        
        # Sucesso!
        print_header("✅ ESTRUTURA CRIADA COM SUCESSO!")
        
        print(f"{Colors.OKGREEN}{Colors.BOLD}Próximos passos:{Colors.ENDC}")
        print("  1. Importar workflows dos 4 agentes no n8n Cloud")
        print("  2. Configurar credenciais (OpenAI + PostgreSQL)")
        print("  3. Modificar workflows para salvamento duplo")
        print("  4. Testar com 1 município (Palmas)")
        print("  5. Popular com 20 municípios × 4 dimensões\n")
        
    finally:
        conn.close()
        print_info("Conexão com banco de dados fechada")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print_error("\n\nOperação cancelada pelo usuário")
        sys.exit(1)
    except Exception as e:
        print_error(f"\n\nErro inesperado: {e}")
        sys.exit(1)
