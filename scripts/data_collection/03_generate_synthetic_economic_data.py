#!/usr/bin/env python3
"""
Script 03: Geração de Dados Econômicos Sintéticos Realistas
============================================================

Descrição:
----------
Gera dados econômicos sintéticos mas realistas para todos os 140 territórios
do Tocantins, baseados em padrões reais de municípios brasileiros.

Dados Gerados:
--------------
- gdp: PIB do município (R$ milhões)
- gdp_per_capita: PIB per capita (R$)
- employment_rate: Taxa de emprego (%)
- revenue: Receitas totais do município (R$)
- sector_distribution: Distribuição setorial do PIB (JSON)
- Período: 2019-2023 (5 anos)

Metodologia:
------------
- Municípios categorizados por tamanho (população estimada)
- Valores baseados em médias reais do IBGE e Tesouro Nacional
- Crescimento anual realista (2-5% ao ano)
- Proporcionalidade entre indicadores

Autor: Manus AI (IA Mediadora)
Data: 23 de novembro de 2025
Framework: Inteligência Territorial V6.0
"""

import uuid
import random
import os
from datetime import datetime

# ============================================================================
# CONFIGURAÇÕES
# ============================================================================

# Anos a gerar
YEARS = [2019, 2020, 2021, 2022, 2023]

# Arquivo de saída (SQL)
OUTPUT_SQL = "insert_economic_indicators.sql"

# Arquivo de log
OUTPUT_LOG = "generate_economic.log"

# ============================================================================
# DADOS DE REFERÊNCIA
# ============================================================================

# População estimada dos principais municípios do Tocantins (2023)
POPULACAO = {
    "Palmas": 313349,
    "Araguaína": 183381,
    "Gurupi": 87545,
    "Porto Nacional": 53010,
    "Paraíso do Tocantins": 51257,
    "Colinas do Tocantins": 37213,
    "Guaraí": 24487,
    "Miracema do Tocantins": 19411,
    "Tocantinópolis": 24428,
    "Araguatins": 32888,
}

# Valores médios por faixa (em milhões de R$)
VALORES_MEDIOS = {
    "capital": {
        "receita_total": 1500.0,
        "gdp": 12000.0,
        "population": 313349,
    },
    "grande": {
        "receita_total": 450.0,
        "gdp": 4000.0,
        "population": 180000,
    },
    "medio": {
        "receita_total": 200.0,
        "gdp": 2000.0,
        "population": 70000,
    },
    "pequeno": {
        "receita_total": 80.0,
        "gdp": 600.0,
        "population": 30000,
    },
    "muito_pequeno": {
        "receita_total": 35.0,
        "gdp": 250.0,
        "population": 10000,
    },
}

# Estado do Tocantins (agregado)
ESTADO_TO = {
    "receita_total": 8500.0,  # R$ 8,5 bilhões
    "gdp": 45000.0,  # R$ 45 bilhões
    "population": 1607363,  # População total estimada
}

# Taxa de crescimento anual (%)
CRESCIMENTO_ANUAL = {
    2019: 1.00,   # Base
    2020: 1.03,   # +3%
    2021: 1.06,   # +6%
    2022: 1.09,   # +9%
    2023: 1.12,   # +12%
}

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

def get_territorios_from_db():
    """Busca territórios diretamente do banco de dados PostgreSQL"""
    import subprocess
    
    log("Consultando territórios no banco de dados...")
    
    try:
        database_url = os.environ.get("DATABASE_URL")
        if not database_url:
            log("✗ ERRO: DATABASE_URL não encontrada")
            return []
        
        # Consulta SQL
        sql = "SELECT id, name, type FROM territories ORDER BY type, name;"
        
        # Executar via psql
        result = subprocess.run(
            ["psql", database_url, "-t", "-A", "-F", "|", "-c", sql],
            capture_output=True,
            text=True,
            timeout=30
        )
        
        if result.returncode != 0:
            log(f"✗ Erro ao consultar banco: {result.stderr}")
            return []
        
        # Processar resultados
        territorios = []
        for line in result.stdout.strip().split("\n"):
            if not line.strip():
                continue
            
            parts = line.split("|")
            if len(parts) >= 3:
                territorios.append({
                    "id": parts[0].strip(),
                    "name": parts[1].strip(),
                    "type": parts[2].strip(),
                })
        
        log(f"✓ {len(territorios)} territórios encontrados")
        return territorios
        
    except Exception as e:
        log(f"✗ Erro ao consultar banco: {e}")
        return []

def classificar_municipio(nome, tipo):
    """Classifica município por faixa de população"""
    
    # Estado
    if tipo == "Estado":
        return "estado"
    
    # Capital
    if nome == "Palmas":
        return "capital"
    
    # Municípios conhecidos
    if nome in POPULACAO:
        pop = POPULACAO[nome]
        if pop >= 100000:
            return "grande"
        elif pop >= 50000:
            return "medio"
        elif pop >= 20000:
            return "pequeno"
        else:
            return "muito_pequeno"
    
    # Classificação padrão (consistente por nome)
    hash_nome = sum(ord(c) for c in nome)
    faixas = ["muito_pequeno", "muito_pequeno", "pequeno", "pequeno", "medio"]
    return faixas[hash_nome % len(faixas)]

def gerar_dados_economicos(territorio_id, territorio_nome, territorio_tipo, ano):
    """Gera dados econômicos sintéticos para um território/ano"""
    
    # Classificar território
    faixa = classificar_municipio(territorio_nome, territorio_tipo)
    
    # Valores base
    if faixa == "estado":
        valores = ESTADO_TO
    else:
        valores = VALORES_MEDIOS[faixa]
    
    # Aplicar crescimento anual
    fator_crescimento = CRESCIMENTO_ANUAL[ano]
    
    # Adicionar variação aleatória (-10% a +15%)
    random.seed(int(territorio_id) + ano)  # Seed para consistência
    variacao = random.uniform(0.90, 1.15)
    
    # Calcular indicadores
    receita_total = valores["receita_total"] * fator_crescimento * variacao * 1_000_000  # Converter para R$
    
    gdp = valores["gdp"] * fator_crescimento * variacao * 1_000_000  # Converter para R$
    population = int(valores["population"] * random.uniform(0.95, 1.05))  # Variação populacional
    gdp_per_capita = gdp / population
    
    employment_rate = random.uniform(55, 70)  # Taxa de emprego: 55-70%
    
    # Distribuição setorial do PIB (%)
    setor_agro = random.uniform(5, 25)
    setor_industria = random.uniform(15, 35)
    setor_servicos = 100 - setor_agro - setor_industria
    
    sector_distribution = {
        "agricultura": round(setor_agro, 1),
        "industria": round(setor_industria, 1),
        "servicos": round(setor_servicos, 1)
    }
    
    return {
        "gdp": round(gdp / 1_000_000, 2),  # Retornar em milhões
        "gdp_per_capita": round(gdp_per_capita, 2),
        "employment_rate": round(employment_rate, 1),
        "revenue": round(receita_total, 2),
        "sector_distribution": sector_distribution,
    }

def gerar_sql_insert(territorio_id, ano, dados):
    """Gera SQL INSERT para indicadores econômicos"""
    
    record_id = str(uuid.uuid4())
    
    sector_json = str(dados["sector_distribution"]).replace("'", '"')
    
    sql = f"""INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '{record_id}',
    '{territorio_id}',
    {ano},
    {dados['gdp']},
    {dados['gdp_per_capita']},
    {dados['employment_rate']},
    {dados['revenue']},
    '{sector_json}'::jsonb
);
"""
    
    return sql

# ============================================================================
# FUNÇÃO PRINCIPAL
# ============================================================================

def main():
    """Função principal do script"""
    
    log("=" * 80)
    log("GERAÇÃO DE DADOS ECONÔMICOS SINTÉTICOS REALISTAS")
    log("=" * 80)
    log("")
    
    # Limpar arquivos anteriores
    with open(OUTPUT_LOG, "w", encoding="utf-8") as f:
        f.write("")
    
    with open(OUTPUT_SQL, "w", encoding="utf-8") as f:
        f.write("-- SQL INSERTs para popular a tabela economic_indicators\n")
        f.write("-- Gerado automaticamente em: " + datetime.now().strftime("%Y-%m-%d %H:%M:%S") + "\n")
        f.write("-- Total de registros: 140 territórios × 5 anos = 700 registros\n")
        f.write("-- Dados: Sintéticos mas realistas (baseados em padrões reais)\n")
        f.write("\n")
        f.write("BEGIN;\n\n")
    
    # Buscar territórios do banco
    territorios = get_territorios_from_db()
    
    if not territorios:
        log("✗ ERRO: Não foi possível buscar territórios")
        return
    
    log(f"Total de territórios: {len(territorios)}")
    log(f"Anos: {YEARS}")
    log(f"Total de registros a gerar: {len(territorios) * len(YEARS)}")
    log("")
    
    # Gerar dados
    total_gerados = 0
    
    for i, territorio in enumerate(territorios, 1):
        log(f"[{i}/{len(territorios)}] Gerando dados para {territorio['name']}...")
        
        for ano in YEARS:
            dados = gerar_dados_economicos(territorio['id'], territorio['name'], territorio['type'], ano)
            sql = gerar_sql_insert(territorio['id'], ano, dados)
            
            with open(OUTPUT_SQL, "a", encoding="utf-8") as f:
                f.write(sql)
                f.write("\n")
            
            total_gerados += 1
    
    # Commit
    with open(OUTPUT_SQL, "a", encoding="utf-8") as f:
        f.write("\n-- Finalizar transação\n")
        f.write("COMMIT;\n")
        f.write(f"\n-- Verificação: Total de registros inseridos\n")
        f.write("SELECT COUNT(*) AS total_indicadores FROM economic_indicators;\n")
    
    log("")
    log("=" * 80)
    log("GERAÇÃO FINALIZADA COM SUCESSO!")
    log("=" * 80)
    log(f"Total de registros gerados: {total_gerados}")
    log("")
    log(f"Arquivo SQL: {OUTPUT_SQL}")
    log(f"Arquivo de log: {OUTPUT_LOG}")
    log("")

# ============================================================================
# EXECUÇÃO
# ============================================================================

if __name__ == "__main__":
    main()
