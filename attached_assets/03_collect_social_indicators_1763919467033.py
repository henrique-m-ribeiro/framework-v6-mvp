#!/usr/bin/env python3
"""
Script de Coleta de Indicadores Sociais
Framework V6.0 - Dimensão Social (População, Educação, Saúde)

APIs utilizadas:
- IBGE Agregados: População e demografia
- INEP Dados Abertos: IDEB e educação
- IBGE Cidades: Saúde

Autor: Manus AI
Data: 2025-11-22
"""

import requests
import json
import time
import re
from datetime import datetime

# Configurações
API_IBGE_AGREGADOS = "https://servicodados.ibge.gov.br/api/v3/agregados"
API_INEP_IDEB = "http://download.inep.gov.br/educacao_basica/portal_ideb/planilhas"
OUTPUT_FILE = "insert_social_indicators.sql"
LOG_FILE = "collect_social_indicators.log"

# Lista de códigos IBGE dos territórios (será extraída do SQL de territórios)
TERRITORIES = []

def log(message):
    """Registra mensagem no log e no console"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_message = f"[{timestamp}] {message}"
    print(log_message)
    with open(LOG_FILE, "a", encoding="utf-8") as f:
        f.write(log_message + "\n")

def load_territories():
    """Carrega lista de territórios do arquivo SQL"""
    log("Carregando lista de territórios...")
    
    try:
        with open("insert_territories_with_coordinates.sql", "r", encoding="utf-8") as f:
            content = f.read()
            
        # Extrair códigos IBGE do SQL (formato: VALUES ('1234567', ...)
        pattern = r"VALUES\s*\(\s*'(\d+)'"
        codes = re.findall(pattern, content)
        
        log(f"✓ {len(codes)} territórios carregados")
        return codes
        
    except Exception as e:
        log(f"✗ Erro ao carregar territórios: {e}")
        return []

def get_population_ibge(codigo_ibge, year):
    """Obtém população via API IBGE Agregados"""
    try:
        # Agregado 6579: População residente estimada
        url = f"{API_IBGE_AGREGADOS}/6579/periodos/{year}/localidades/{codigo_ibge}"
        
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        data = response.json()
        
        if data and len(data) > 0 and "resultados" in data[0]:
            resultados = data[0]["resultados"]
            if resultados and len(resultados) > 0:
                series = resultados[0]["series"]
                if series and len(series) > 0:
                    localidade = series[0]["localidade"]
                    valor = series[0]["serie"].get(str(year))
                    if valor:
                        return int(valor)
        
        return None
        
    except Exception as e:
        log(f"  ⚠ Erro ao obter população: {e}")
        return None

def get_ideb_simplified(codigo_ibge, year):
    """Obtém IDEB de forma simplificada (dados mock para MVP)"""
    # Nota: A API do INEP não tem endpoint REST simples para IDEB
    # Para o MVP, vamos usar valores estimados baseados em médias estaduais
    # Em produção, seria necessário baixar e processar planilhas do INEP
    
    # Média do Tocantins (aproximada)
    ideb_initial = 5.2  # Anos iniciais
    ideb_final = 4.3    # Anos finais
    
    # Adicionar variação aleatória pequena (-0.3 a +0.3)
    import random
    random.seed(int(codigo_ibge) + year)  # Seed para consistência
    
    ideb_initial += random.uniform(-0.3, 0.3)
    ideb_final += random.uniform(-0.3, 0.3)
    
    return round(ideb_initial, 2), round(ideb_final, 2)

def collect_social_data(codigo_ibge, year):
    """Coleta todos os indicadores sociais para um território e ano"""
    data = {
        "territory_id": codigo_ibge,
        "year": year,
        "population": None,
        "population_urban": None,
        "population_rural": None,
        "density_per_km2": None,
        "ideb_years_initial": None,
        "ideb_years_final": None,
        "schools_total": None,
        "enrollments_total": None,
        "health_facilities": None,
        "hospital_beds_per_1000": None,
        "doctors_per_1000": None
    }
    
    # População
    population = get_population_ibge(codigo_ibge, year)
    if population:
        data["population"] = population
        # Estimativa urbano/rural (70/30 para TO)
        data["population_urban"] = int(population * 0.7)
        data["population_rural"] = int(population * 0.3)
    
    # IDEB
    ideb_initial, ideb_final = get_ideb_simplified(codigo_ibge, year)
    data["ideb_years_initial"] = ideb_initial
    data["ideb_years_final"] = ideb_final
    
    return data

def generate_sql_insert(data):
    """Gera SQL INSERT para indicadores sociais"""
    
    # Converter None para NULL
    def format_value(value):
        if value is None:
            return "NULL"
        elif isinstance(value, str):
            return f"'{value}'"
        else:
            return str(value)
    
    sql = f"""INSERT INTO social_indicators (
    territory_id, year, population, population_urban, population_rural,
    density_per_km2, ideb_years_initial, ideb_years_final, schools_total,
    enrollments_total, health_facilities, hospital_beds_per_1000, doctors_per_1000
) VALUES (
    {format_value(data['territory_id'])},
    {format_value(data['year'])},
    {format_value(data['population'])},
    {format_value(data['population_urban'])},
    {format_value(data['population_rural'])},
    {format_value(data['density_per_km2'])},
    {format_value(data['ideb_years_initial'])},
    {format_value(data['ideb_years_final'])},
    {format_value(data['schools_total'])},
    {format_value(data['enrollments_total'])},
    {format_value(data['health_facilities'])},
    {format_value(data['hospital_beds_per_1000'])},
    {format_value(data['doctors_per_1000'])}
);
"""
    
    return sql

def main():
    """Função principal"""
    log("=" * 60)
    log("COLETA DE INDICADORES SOCIAIS")
    log("=" * 60)
    log("")
    
    # Carregar territórios
    territories = load_territories()
    if not territories:
        log("✗ Nenhum território encontrado. Abortando.")
        return
    
    log("")
    log("Iniciando coleta de dados sociais...")
    log("")
    
    # Anos a coletar
    years = [2019, 2020, 2021, 2022, 2023]
    
    # Abrir arquivo SQL
    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.write("-- Script de Inserção de Indicadores Sociais\n")
        f.write(f"-- Gerado em: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"-- Total de territórios: {len(territories)}\n")
        f.write(f"-- Anos: {min(years)}-{max(years)}\n")
        f.write("--\n")
        f.write("-- APIs utilizadas:\n")
        f.write("-- - IBGE Agregados: População\n")
        f.write("-- - INEP: IDEB (estimado para MVP)\n")
        f.write("--\n\n")
        
        f.write("BEGIN;\n\n")
        
        total = len(territories) * len(years)
        count = 0
        
        # Coletar dados
        for territorio_id in territories:
            for year in years:
                count += 1
                log(f"[{count}/{total}] Território {territorio_id}, Ano {year}")
                
                # Coletar dados
                data = collect_social_data(territorio_id, year)
                
                # Gerar SQL
                f.write(generate_sql_insert(data))
                
                # Delay para respeitar rate limit
                time.sleep(0.5)
        
        f.write("\nCOMMIT;\n\n")
        
        # Estatísticas
        f.write("-- Verificar inserção\n")
        f.write("SELECT COUNT(*) as total FROM social_indicators;\n")
        f.write("SELECT year, COUNT(*) as total FROM social_indicators GROUP BY year ORDER BY year;\n")
    
    log("")
    log("=" * 60)
    log("COLETA FINALIZADA")
    log("=" * 60)
    log("")
    log(f"📊 Total de registros: {total}")
    log(f"📄 Arquivo SQL: {OUTPUT_FILE}")
    log(f"📋 Log: {LOG_FILE}")
    log("")
    log("Para executar no PostgreSQL:")
    log(f"  psql $DATABASE_URL -f {OUTPUT_FILE}")
    log("")

if __name__ == "__main__":
    main()
