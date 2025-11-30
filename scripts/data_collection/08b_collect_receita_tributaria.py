#!/usr/bin/env python3
"""
Script 08b: Coleta de Receita Tributária Própria dos Municípios do Tocantins
==============================================================================

Descrição:
----------
Este script coleta dados de Receita Tributária Própria via SICONFI para todos
os municípios do Tocantins e atualiza a tabela `economic_indicators`.

API Utilizada:
--------------
- SICONFI: Receita Tributária Própria
  https://apidatalake.tesouro.gov.br/docs/siconfi/

Autor: Manus AI
Data: 29 de novembro de 2025
Framework: Inteligência Territorial V6.0
"""

import os
import sys
import requests
import time
from datetime import datetime
import psycopg2
from psycopg2.extras import RealDictCursor
from dotenv import load_dotenv

# Carregar variáveis de ambiente
load_dotenv()

# ============================================================================
# CONFIGURAÇÕES
# ============================================================================

# Conexão com banco de dados
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

# URLs das APIs
SICONFI_BASE = "https://apidatalake.tesouro.gov.br/ords/siconfi/tt/dca"

# Anos a coletar
YEARS = [2020, 2021, 2022]  # Últimos 3 anos disponíveis

# Delay entre requisições
REQUEST_DELAY = 1.5  # segundos (SICONFI é mais lento)

# Timeout para requisições
REQUEST_TIMEOUT = 30  # segundos

# ============================================================================
# FUNÇÕES AUXILIARES
# ============================================================================

def log(message):
    """Registra mensagem no log"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"[{timestamp}] {message}")

def get_db_connection():
    """Cria conexão com o banco de dados"""
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            port=DB_PORT,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD
        )
        return conn
    except Exception as e:
        log(f"✗ Erro ao conectar ao banco de dados: {e}")
        sys.exit(1)

def get_municipios():
    """Busca todos os municípios do Tocantins no banco de dados"""
    conn = get_db_connection()
    cursor = conn.cursor(cursor_factory=RealDictCursor)
    
    try:
        cursor.execute("""
            SELECT id, name
            FROM territories
            WHERE type = 'Município'
            ORDER BY name
        """)
        municipios = cursor.fetchall()
        log(f"✓ {len(municipios)} municípios encontrados no banco de dados")
        return municipios
    except Exception as e:
        log(f"✗ Erro ao buscar municípios: {e}")
        return []
    finally:
        cursor.close()
        conn.close()

def collect_receita_tributaria(codigo_ibge, ano):
    """
    Coleta Receita Tributária Própria via SICONFI
    
    Fonte: Tesouro Nacional - SICONFI
    Anexo I-C: Demonstrativo da Receita Corrente Líquida
    """
    url = f"{SICONFI_BASE}?an_exercicio={ano}&co_tipo_demonstrativo=DCA&no_anexo=I-C&co_esfera=M&co_poder=E&id_ente={codigo_ibge}"
    
    try:
        response = requests.get(url, timeout=REQUEST_TIMEOUT)
        response.raise_for_status()
        data = response.json()
        
        if not data or "items" not in data or not data["items"]:
            return None
        
        receita_tributaria = 0.0
        
        for item in data["items"]:
            conta = item.get("conta", "").upper()
            valor = float(item.get("valor", 0))
            
            # Identificar receita tributária (IPTU, ISS, ITBI, etc.)
            if any(keyword in conta for keyword in ["RECEITA TRIBUTÁRIA", "RECEITAS TRIBUTÁRIAS", "IPTU", "ISS", "ITBI", "IRRF"]):
                receita_tributaria += valor
        
        return receita_tributaria if receita_tributaria > 0 else None
        
    except Exception as e:
        log(f"  ⚠ Erro ao coletar receita tributária de {codigo_ibge} ({ano}): {e}")
        return None

def update_receita_tributaria(territorio_id, ano, receita_tributaria):
    """Atualiza a receita tributária no banco de dados"""
    conn = get_db_connection()
    cursor = conn.cursor()
    
    try:
        query = """
            UPDATE economic_indicators
            SET own_tax_revenue = %s
            WHERE territory_id = %s AND year = %s
        """
        
        cursor.execute(query, [receita_tributaria, territorio_id, ano])
        conn.commit()
        
        return cursor.rowcount > 0
        
    except Exception as e:
        log(f"✗ Erro ao atualizar receita tributária: {e}")
        conn.rollback()
        return False
    finally:
        cursor.close()
        conn.close()

# ============================================================================
# FUNÇÃO PRINCIPAL
# ============================================================================

def main():
    """Função principal do script"""
    
    log("=" * 80)
    log("INICIANDO COLETA DE RECEITA TRIBUTÁRIA DO TOCANTINS")
    log("=" * 80)
    log("")
    
    # 1. Buscar municípios do banco de dados
    municipios = get_municipios()
    
    if not municipios:
        log("✗ Nenhum município encontrado. Encerrando.")
        return
    
    # 2. Coletar dados para cada município e ano
    total = len(municipios) * len(YEARS)
    sucesso = 0
    falha = 0
    contador = 0
    
    for municipio in municipios:
        territorio_id = municipio["id"]
        nome = municipio["name"]
        
        log(f"Processando {nome} ({territorio_id})...")
        
        for ano in YEARS:
            contador += 1
            log(f"  [{contador}/{total}] Ano {ano}...")
            
            # Coletar receita tributária
            receita_tributaria = collect_receita_tributaria(territorio_id, ano)
            
            if receita_tributaria:
                log(f"    ✓ Receita Tributária: R$ {receita_tributaria:,.2f}")
                
                # Atualizar banco de dados
                if update_receita_tributaria(territorio_id, ano, receita_tributaria):
                    sucesso += 1
                    log(f"    ✓ Banco de dados atualizado")
                else:
                    falha += 1
                    log(f"    ✗ Falha ao atualizar banco de dados")
            else:
                falha += 1
                log(f"    ⚠ Nenhum dado coletado")
            
            # Delay entre requisições
            time.sleep(REQUEST_DELAY)
    
    # 3. Sumário final
    log("")
    log("=" * 80)
    log("COLETA FINALIZADA")
    log("=" * 80)
    log(f"Total de registros processados: {total}")
    log(f"Sucesso: {sucesso}")
    log(f"Falha: {falha}")
    log(f"Taxa de sucesso: {(sucesso/total*100):.1f}%")
    log("")

if __name__ == "__main__":
    main()
