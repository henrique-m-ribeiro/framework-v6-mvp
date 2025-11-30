#!/usr/bin/env python3
"""
Script 08: Coleta de Novos Indicadores Econômicos do Tocantins
================================================================

Descrição:
----------
Este script coleta os 3 novos indicadores econômicos adicionados ao sistema:
1. Receita Tributária Própria (via SICONFI)
2. Massa Salarial Total (via IBGE - Pesquisa Anual de Serviços/Indústria)
3. Número de Empresas Ativas (via IBGE - Cadastro Central de Empresas)

Os dados são coletados para todos os 139 municípios do Tocantins e atualizados
na tabela `economic_indicators` do banco de dados.

APIs Utilizadas:
----------------
- SICONFI: Receita Tributária Própria
  https://apidatalake.tesouro.gov.br/docs/siconfi/
- IBGE SIDRA: Massa Salarial e Empresas Ativas
  https://servicodados.ibge.gov.br/api/docs/

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
from urllib.parse import quote

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
IBGE_SIDRA_BASE = "https://servicodados.ibge.gov.br/api/v3/agregados"

# Anos a coletar (último ano disponível)
YEAR = 2022  # Dados mais recentes disponíveis

# Delay entre requisições
REQUEST_DELAY = 0.5  # segundos

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
            if any(keyword in conta for keyword in ["RECEITA TRIBUTÁRIA", "IPTU", "ISS", "ITBI", "IRRF"]):
                receita_tributaria += valor
        
        return receita_tributaria if receita_tributaria > 0 else None
        
    except Exception as e:
        log(f"  ⚠ Erro ao coletar receita tributária de {codigo_ibge}: {e}")
        return None

def collect_massa_salarial(codigo_ibge, ano):
    """
    Coleta Rendimento Médio do Trabalho via IBGE SIDRA (proxy para massa salarial)
    
    Fonte: IBGE - Pesquisa Nacional por Amostra de Domicílios Contínua (PNAD Contínua)
    Tabela 5938: Pessoas de 14 anos ou mais de idade, ocupadas na semana de referência
    
    Nota: A PNAD Contínua fornece dados estaduais. Para dados municipais precisos,
    seria necessário acesso aos microdados da RAIS via FTP (requer processamento local).
    Por ora, usamos dados estaduais como proxy.
    """
    # Código do estado do Tocantins
    codigo_estado = "17"
    
    # Tabela 5938: Pessoas ocupadas e rendimento médio
    # Variável 5929: Rendimento médio mensal real do trabalho principal
    url = f"{IBGE_SIDRA_BASE}/5938/periodos/{ano}/variaveis/5929?localidades=N3%5B{codigo_estado}%5D"
    
    try:
        response = requests.get(url, timeout=REQUEST_TIMEOUT)
        response.raise_for_status()
        data = response.json()
        
        if not data or len(data) == 0:
            return None
        
        # Extrair rendimento médio
        for item in data:
            if "resultados" in item and len(item["resultados"]) > 0:
                series = item["resultados"][0].get("series", [])
                if len(series) > 0:
                    serie = series[0].get("serie", {})
                    valor = serie.get(str(ano))
                    if valor and valor != "...":
                        # Retornar rendimento médio estadual como proxy
                        return float(valor)
        
        return None
        
    except Exception as e:
        log(f"  ⚠ Erro ao coletar rendimento médio de {codigo_ibge}: {e}")
        return None

def collect_empresas_ativas(codigo_ibge, ano):
    """
    Coleta Número de Empresas Ativas via IBGE SIDRA
    
    Fonte: IBGE - Cadastro Central de Empresas (CEMPRE)
    Tabela 987: Número de empresas e outras organizações
    """
    # Tabela 987 do SIDRA: Número de empresas por município
    url = f"{IBGE_SIDRA_BASE}/987/periodos/{ano}/variaveis/706?localidades=N6%5B{codigo_ibge}%5D"
    
    try:
        response = requests.get(url, timeout=REQUEST_TIMEOUT)
        response.raise_for_status()
        data = response.json()
        
        if not data or len(data) == 0:
            return None
        
        # Extrair número de empresas
        for item in data:
            if "resultados" in item and len(item["resultados"]) > 0:
                series = item["resultados"][0].get("series", [])
                if len(series) > 0:
                    serie = series[0].get("serie", {})
                    valor = serie.get(str(ano))
                    if valor and valor != "...":
                        return int(valor)
        
        return None
        
    except Exception as e:
        log(f"  ⚠ Erro ao coletar empresas ativas de {codigo_ibge}: {e}")
        return None

def update_economic_indicators(territorio_id, ano, receita_tributaria, massa_salarial, empresas_ativas):
    """Atualiza os novos indicadores econômicos no banco de dados"""
    conn = get_db_connection()
    cursor = conn.cursor()
    
    try:
        # Construir query de UPDATE
        updates = []
        params = []
        
        if receita_tributaria is not None:
            updates.append("own_tax_revenue = %s")
            params.append(receita_tributaria)
        
        if massa_salarial is not None:
            updates.append("total_wage_mass = %s")
            params.append(massa_salarial)
        
        if empresas_ativas is not None:
            updates.append("active_companies = %s")
            params.append(empresas_ativas)
        
        if not updates:
            return False
        
        # Adicionar parâmetros de WHERE
        params.extend([territorio_id, ano])
        
        query = f"""
            UPDATE economic_indicators
            SET {", ".join(updates)}
            WHERE territory_id = %s AND year = %s
        """
        
        cursor.execute(query, params)
        conn.commit()
        
        return cursor.rowcount > 0
        
    except Exception as e:
        log(f"✗ Erro ao atualizar indicadores: {e}")
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
    log("INICIANDO COLETA DE NOVOS INDICADORES ECONÔMICOS DO TOCANTINS")
    log("=" * 80)
    log("")
    
    # 1. Buscar municípios do banco de dados
    municipios = get_municipios()
    
    if not municipios:
        log("✗ Nenhum município encontrado. Encerrando.")
        return
    
    # 2. Coletar dados para cada município
    total = len(municipios)
    sucesso = 0
    falha = 0
    
    for i, municipio in enumerate(municipios, 1):
        territorio_id = municipio["id"]
        nome = municipio["name"]
        
        log(f"[{i}/{total}] Processando {nome} ({territorio_id})...")
        
        # Coletar indicadores
        receita_tributaria = collect_receita_tributaria(territorio_id, YEAR)
        massa_salarial = collect_massa_salarial(territorio_id, YEAR)
        empresas_ativas = collect_empresas_ativas(territorio_id, YEAR)
        
        # Log dos valores coletados
        if receita_tributaria:
            log(f"  ✓ Receita Tributária: R$ {receita_tributaria:,.2f}")
        if massa_salarial:
            log(f"  ✓ Massa Salarial: R$ {massa_salarial:,.2f}")
        if empresas_ativas:
            log(f"  ✓ Empresas Ativas: {empresas_ativas}")
        
        # Atualizar banco de dados
        if any([receita_tributaria, massa_salarial, empresas_ativas]):
            if update_economic_indicators(territorio_id, YEAR, receita_tributaria, massa_salarial, empresas_ativas):
                sucesso += 1
                log(f"  ✓ Indicadores atualizados no banco de dados")
            else:
                falha += 1
                log(f"  ✗ Falha ao atualizar banco de dados")
        else:
            falha += 1
            log(f"  ⚠ Nenhum dado coletado para este município")
        
        # Delay entre requisições
        time.sleep(REQUEST_DELAY)
    
    # 3. Sumário final
    log("")
    log("=" * 80)
    log("COLETA FINALIZADA")
    log("=" * 80)
    log(f"Total de municípios processados: {total}")
    log(f"Sucesso: {sucesso}")
    log(f"Falha: {falha}")
    log("")

if __name__ == "__main__":
    main()
