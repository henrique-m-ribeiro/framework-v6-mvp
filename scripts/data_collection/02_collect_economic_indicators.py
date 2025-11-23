#!/usr/bin/env python3
"""
Script 02: Coleta de Dados Econômicos dos Territórios do Tocantins
===================================================================

Descrição:
----------
Este script coleta dados econômicos (receitas e despesas) de TODOS os 140 territórios
do Tocantins via API SICONFI (Sistema de Informações Contábeis e Fiscais do Setor
Público Brasileiro) e gera SQL INSERTs para popular a tabela `economic_indicators`.

Dados Coletados:
----------------
- Receitas totais (R$)
- Receitas próprias (R$)
- Transferências FPM (R$)
- Despesas totais (R$)
- Despesas de investimento (R$)
- Despesas com pessoal (R$)
- PIB (será coletado do IBGE em outro script)
- Período: 2019-2023 (5 anos)

API Utilizada:
--------------
- SICONFI DCA (Declaração de Contas Anuais)
  https://apidatalake.tesouro.gov.br/docs/siconfi/

Fonte de Dados:
---------------
- Tesouro Nacional / Secretaria do Tesouro Nacional (STN)
- Dados oficiais e auditados

Autor: Manus AI (IA Mediadora)
Data: 22 de novembro de 2025
Framework: Inteligência Territorial V6.0
"""

import requests
import json
import time
from datetime import datetime
import uuid

# ============================================================================
# CONFIGURAÇÕES
# ============================================================================

# URL base da API SICONFI
API_BASE = "https://apidatalake.tesouro.gov.br/ords/siconfi/tt/dca"

# Anos a coletar
YEARS = [2019, 2020, 2021, 2022, 2023]

# Anexos do DCA (Declaração de Contas Anuais)
# Anexo I-C: Demonstrativo da Receita Corrente Líquida
# Anexo I-E: Demonstrativo das Receitas e Despesas com Ações e Serviços Públicos de Saúde
ANEXO_RECEITAS = "I-C"
ANEXO_DESPESAS = "I-E"

# Arquivo de entrada (lista de municípios)
INPUT_MUNICIPIOS = "insert_territories_with_coordinates.sql"  # Vamos extrair códigos IBGE daqui

# Arquivo de saída (SQL)
OUTPUT_SQL = "insert_economic_indicators.sql"

# Arquivo de log
OUTPUT_LOG = "collect_economic.log"

# Delay entre requisições (para não sobrecarregar a API)
REQUEST_DELAY = 1.0  # segundos (SICONFI é mais lento)

# Timeout para requisições
REQUEST_TIMEOUT = 30  # segundos

# ============================================================================
# FUNÇÕES AUXILIARES
# ============================================================================

def log(message):
    """Registra mensagem no log e exibe no console"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_message = f"[{timestamp}] {message}"
    print(log_message)
    with open(OUTPUT_LOG, "a", encoding="utf-8") as f:
        f.write(log_message + "\n")

def extract_codigos_ibge():
    """Extrai códigos IBGE do arquivo SQL de territórios"""
    log("Extraindo códigos IBGE dos territórios...")
    
    codigos = []
    
    try:
        with open(INPUT_MUNICIPIOS, "r", encoding="utf-8") as f:
            for line in f:
                # Procurar linhas com INSERT INTO territories
                if "INSERT INTO territories" in line:
                    continue
                # Procurar linhas com IDs (códigos IBGE)
                if line.strip().startswith("'") and "," in line:
                    # Extrair código IBGE (primeira string entre aspas)
                    parts = line.strip().split("'")
                    if len(parts) >= 2:
                        codigo = parts[1]
                        if codigo.isdigit() and len(codigo) in [2, 7]:  # 2 para estado, 7 para município
                            codigos.append(codigo)
        
        log(f"✓ {len(codigos)} códigos IBGE extraídos")
        return codigos
        
    except Exception as e:
        log(f"✗ Erro ao extrair códigos IBGE: {e}")
        return []

def get_receitas_municipio(codigo_ibge, ano):
    """Coleta receitas de um município via SICONFI"""
    
    url = f"{API_BASE}?an_exercicio={ano}&co_tipo_demonstrativo=DCA&no_anexo={ANEXO_RECEITAS}&co_esfera=M&co_poder=E&id_ente={codigo_ibge}"
    
    try:
        response = requests.get(url, timeout=REQUEST_TIMEOUT)
        response.raise_for_status()
        data = response.json()
        
        if not data or "items" not in data or not data["items"]:
            return None
        
        # Processar dados de receitas
        receitas = {
            "receita_total": 0.0,
            "receita_propria": 0.0,
            "transferencias_fpm": 0.0
        }
        
        for item in data["items"]:
            conta = item.get("conta", "").upper()
            valor = float(item.get("valor", 0))
            
            # Identificar tipos de receita
            if "RECEITA CORRENTE LÍQUIDA" in conta or "RCL" in conta:
                receitas["receita_total"] += valor
            elif "RECEITA TRIBUTÁRIA" in conta or "IPTU" in conta or "ISS" in conta:
                receitas["receita_propria"] += valor
            elif "FPM" in conta or "FUNDO DE PARTICIPAÇÃO" in conta:
                receitas["transferencias_fpm"] += valor
        
        return receitas
        
    except requests.exceptions.Timeout:
        log(f"  ⏱ Timeout ao coletar receitas de {codigo_ibge} ({ano})")
        return None
    except requests.exceptions.RequestException as e:
        log(f"  ✗ Erro HTTP ao coletar receitas de {codigo_ibge} ({ano}): {e}")
        return None
    except Exception as e:
        log(f"  ✗ Erro ao processar receitas de {codigo_ibge} ({ano}): {e}")
        return None

def get_despesas_municipio(codigo_ibge, ano):
    """Coleta despesas de um município via SICONFI"""
    
    url = f"{API_BASE}?an_exercicio={ano}&co_tipo_demonstrativo=DCA&no_anexo={ANEXO_DESPESAS}&co_esfera=M&co_poder=E&id_ente={codigo_ibge}"
    
    try:
        response = requests.get(url, timeout=REQUEST_TIMEOUT)
        response.raise_for_status()
        data = response.json()
        
        if not data or "items" not in data or not data["items"]:
            return None
        
        # Processar dados de despesas
        despesas = {
            "despesa_total": 0.0,
            "despesa_investimento": 0.0,
            "despesa_pessoal": 0.0
        }
        
        for item in data["items"]:
            conta = item.get("conta", "").upper()
            valor = float(item.get("valor", 0))
            
            # Identificar tipos de despesa
            if "DESPESA TOTAL" in conta or "DESPESAS EMPENHADAS" in conta:
                despesas["despesa_total"] += valor
            elif "INVESTIMENTO" in conta:
                despesas["despesa_investimento"] += valor
            elif "PESSOAL" in conta or "ENCARGOS" in conta:
                despesas["despesa_pessoal"] += valor
        
        return despesas
        
    except requests.exceptions.Timeout:
        log(f"  ⏱ Timeout ao coletar despesas de {codigo_ibge} ({ano})")
        return None
    except requests.exceptions.RequestException as e:
        log(f"  ✗ Erro HTTP ao coletar despesas de {codigo_ibge} ({ano}): {e}")
        return None
    except Exception as e:
        log(f"  ✗ Erro ao processar despesas de {codigo_ibge} ({ano}): {e}")
        return None

def generate_sql_insert(codigo_ibge, ano, dados_economicos):
    """Gera SQL INSERT para indicadores econômicos"""
    
    # Gerar UUID para o registro
    record_id = str(uuid.uuid4())
    
    # Extrair dados
    receita_total = dados_economicos.get("receita_total", 0.0)
    receita_propria = dados_economicos.get("receita_propria", 0.0)
    transferencias_fpm = dados_economicos.get("transferencias_fpm", 0.0)
    despesa_total = dados_economicos.get("despesa_total", 0.0)
    despesa_investimento = dados_economicos.get("despesa_investimento", 0.0)
    despesa_pessoal = dados_economicos.get("despesa_pessoal", 0.0)
    
    # PIB e outros serão NULL por enquanto
    gdp = "NULL"
    gdp_per_capita = "NULL"
    employment_rate = "NULL"
    sector_distribution = "NULL"
    
    sql = f"""INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '{record_id}',
    '{codigo_ibge}',
    {ano},
    {gdp},
    {gdp_per_capita},
    {employment_rate},
    {receita_total if receita_total > 0 else 'NULL'},
    {sector_distribution}
);
"""
    
    return sql

# ============================================================================
# FUNÇÃO PRINCIPAL
# ============================================================================

def main():
    """Função principal do script"""
    
    log("=" * 80)
    log("INICIANDO COLETA DE DADOS ECONÔMICOS DO TOCANTINS")
    log("=" * 80)
    log("")
    
    # Limpar arquivo de log anterior
    with open(OUTPUT_LOG, "w", encoding="utf-8") as f:
        f.write("")
    
    # Limpar arquivo SQL anterior
    with open(OUTPUT_SQL, "w", encoding="utf-8") as f:
        f.write("-- SQL INSERTs para popular a tabela economic_indicators\n")
        f.write("-- Gerado automaticamente em: " + datetime.now().strftime("%Y-%m-%d %H:%M:%S") + "\n")
        f.write("-- Total de registros: 140 territórios × 5 anos = 700 registros\n")
        f.write("-- Fonte: SICONFI (Tesouro Nacional)\n")
        f.write("\n")
        f.write("-- Iniciar transação\n")
        f.write("BEGIN;\n\n")
    
    # 1. Extrair códigos IBGE dos territórios
    codigos_ibge = extract_codigos_ibge()
    
    if not codigos_ibge:
        log("✗ ERRO CRÍTICO: Não foi possível extrair códigos IBGE")
        return
    
    log(f"Total de territórios a processar: {len(codigos_ibge)}")
    log(f"Anos: {YEARS}")
    log(f"Total de requisições: {len(codigos_ibge) * len(YEARS) * 2} (receitas + despesas)")
    log("")
    
    # 2. Coletar dados econômicos
    total_sucesso = 0
    total_erro = 0
    
    for i, codigo_ibge in enumerate(codigos_ibge, 1):
        log(f"[{i}/{len(codigos_ibge)}] Processando território {codigo_ibge}...")
        
        for ano in YEARS:
            # Coletar receitas
            receitas = get_receitas_municipio(codigo_ibge, ano)
            time.sleep(REQUEST_DELAY)
            
            # Coletar despesas
            despesas = get_despesas_municipio(codigo_ibge, ano)
            time.sleep(REQUEST_DELAY)
            
            # Consolidar dados
            if receitas or despesas:
                dados_economicos = {}
                
                if receitas:
                    dados_economicos.update(receitas)
                
                if despesas:
                    dados_economicos.update(despesas)
                
                # Gerar SQL INSERT
                sql = generate_sql_insert(codigo_ibge, ano, dados_economicos)
                
                with open(OUTPUT_SQL, "a", encoding="utf-8") as f:
                    f.write(sql)
                    f.write("\n")
                
                total_sucesso += 1
                log(f"  ✓ Dados coletados para {codigo_ibge} ({ano})")
            else:
                total_erro += 1
                log(f"  ⚠ Sem dados disponíveis para {codigo_ibge} ({ano})")
    
    # Commit da transação
    with open(OUTPUT_SQL, "a", encoding="utf-8") as f:
        f.write("\n-- Finalizar transação\n")
        f.write("COMMIT;\n")
    
    log("")
    log("=" * 80)
    log("COLETA FINALIZADA")
    log("=" * 80)
    log(f"Registros com sucesso: {total_sucesso}")
    log(f"Registros sem dados: {total_erro}")
    log(f"Total: {total_sucesso + total_erro}")
    log("")
    log(f"Arquivo SQL: {OUTPUT_SQL}")
    log(f"Arquivo de log: {OUTPUT_LOG}")
    log("")
    log("OBSERVAÇÃO:")
    log("- Alguns municípios podem não ter dados disponíveis no SICONFI")
    log("- Dados de PIB serão coletados do IBGE em outro script")
    log("- Taxa de emprego será coletada do IBGE em outro script")
    log("")

# ============================================================================
# EXECUÇÃO
# ============================================================================

if __name__ == "__main__":
    main()
