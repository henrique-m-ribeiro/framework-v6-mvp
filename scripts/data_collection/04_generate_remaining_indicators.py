#!/usr/bin/env python3
"""
Gerador de Indicadores Sintéticos - Dimensões Social, Territorial e Ambiental
Gera dados realistas para 140 territórios × 5 anos (2019-2023)
"""

import json
import random
import uuid
from datetime import datetime

# Seed para reprodutibilidade
random.seed(42)

def generate_social_indicators(territory_id: str, territory_name: str, years: list) -> list:
    """Gera indicadores sociais sintéticos mas realistas."""
    # Palmas é a capital, municípios maiores têm melhores indicadores
    is_capital = "Palmas" in territory_name
    is_large_city = any(city in territory_name for city in 
                       ["Araguaína", "Gurupi", "Porto Nacional", "Paraíso do Tocantins"])
    
    # Base de população (crescimento anual de ~1.2%)
    base_population = {
        "capital": 310000,
        "large_city": random.randint(80000, 180000),
        "medium_city": random.randint(20000, 80000),
        "small_city": random.randint(3000, 20000)
    }
    
    if is_capital:
        base_pop = base_population["capital"]
        base_idhm = random.uniform(0.780, 0.800)
        base_literacy = random.uniform(92, 95)
        base_income = random.uniform(1200, 1500)
    elif is_large_city:
        base_pop = base_population["large_city"]
        base_idhm = random.uniform(0.700, 0.750)
        base_literacy = random.uniform(85, 92)
        base_income = random.uniform(800, 1200)
    else:
        # Municípios médios e pequenos
        size_factor = random.random()
        if size_factor > 0.5:  # Médio
            base_pop = base_population["medium_city"]
            base_idhm = random.uniform(0.600, 0.700)
            base_literacy = random.uniform(75, 85)
            base_income = random.uniform(600, 800)
        else:  # Pequeno
            base_pop = base_population["small_city"]
            base_idhm = random.uniform(0.550, 0.650)
            base_literacy = random.uniform(65, 78)
            base_income = random.uniform(400, 650)
    
    indicators = []
    
    for idx, year in enumerate(years):
        # Crescimento gradual
        growth_factor = 1 + (idx * 0.012)  # 1.2% ao ano
        idhm_growth = 1 + (idx * 0.008)    # 0.8% ao ano (IDHM cresce lentamente)
        income_growth = 1 + (idx * 0.015)  # 1.5% ao ano
        
        population = int(base_pop * growth_factor)
        idhm = round(min(base_idhm * idhm_growth, 0.999), 3)
        literacy_rate = round(min(base_literacy + (idx * 0.5), 99.9), 1)
        income_per_capita = round(base_income * income_growth, 2)
        
        # Métricas de educação (IDEB, taxa de conclusão, etc.)
        education_metrics = {
            "ideb_anos_iniciais": round(random.uniform(4.5, 6.5), 1),
            "ideb_anos_finais": round(random.uniform(3.8, 5.5), 1),
            "taxa_conclusao_fundamental": round(random.uniform(75, 95), 1),
            "taxa_conclusao_medio": round(random.uniform(65, 88), 1)
        }
        
        # Métricas de saúde
        health_metrics = {
            "expectativa_vida": round(random.uniform(71, 78), 1),
            "mortalidade_infantil": round(random.uniform(8, 18), 1),
            "cobertura_vacinal": round(random.uniform(85, 98), 1),
            "leitos_por_mil_habitantes": round(random.uniform(1.5, 3.5), 2)
        }
        
        indicators.append({
            "id": str(uuid.uuid4()),
            "territory_id": territory_id,
            "year": year,
            "idhm": idhm,
            "population": population,
            "literacy_rate": literacy_rate,
            "income_per_capita": income_per_capita,
            "education_metrics": education_metrics,
            "health_metrics": health_metrics
        })
    
    return indicators


def generate_territorial_indicators(territory_id: str, territory_name: str, years: list) -> list:
    """Gera indicadores territoriais sintéticos mas realistas."""
    is_capital = "Palmas" in territory_name
    
    # Área urbanizada (km²) - cresce lentamente
    base_urbanized = random.uniform(20, 100) if is_capital else random.uniform(5, 50)
    
    # Densidade populacional (hab/km²)
    base_density = random.uniform(50, 200) if is_capital else random.uniform(5, 80)
    
    # Cobertura de saneamento (%) - melhora com o tempo
    base_sanitation = random.uniform(70, 90) if is_capital else random.uniform(40, 70)
    
    indicators = []
    
    for idx, year in enumerate(years):
        # Crescimento urbano lento
        urbanized_area = round(base_urbanized * (1 + idx * 0.02), 2)
        density = round(base_density * (1 + idx * 0.012), 2)
        sanitation_coverage = round(min(base_sanitation + (idx * 1.5), 99.9), 1)
        
        # Uso do solo (%)
        land_use = {
            "urbano": round(random.uniform(5, 25), 1),
            "agricola": round(random.uniform(30, 50), 1),
            "pecuaria": round(random.uniform(20, 40), 1),
            "vegetacao_natural": round(random.uniform(10, 30), 1)
        }
        
        indicators.append({
            "id": str(uuid.uuid4()),
            "territory_id": territory_id,
            "year": year,
            "urbanized_area": urbanized_area,
            "density": density,
            "sanitation_coverage": sanitation_coverage,
            "land_use": land_use
        })
    
    return indicators


def generate_environmental_indicators(territory_id: str, territory_name: str, years: list) -> list:
    """Gera indicadores ambientais sintéticos mas realistas."""
    # Tocantins tem Cerrado e Amazônia
    base_vegetation = random.uniform(45, 75)  # % de cobertura vegetal
    base_deforested = random.uniform(0.5, 2.5)  # km² desmatados/ano
    base_water_quality = random.uniform(65, 85)  # índice de qualidade
    base_co2 = random.uniform(100, 500)  # toneladas CO2/ano
    
    indicators = []
    
    for idx, year in enumerate(years):
        # Desmatamento cumulativo (vegetação diminui)
        vegetation_coverage = round(max(base_vegetation - (idx * 0.8), 20), 1)
        deforested_area = round(base_deforested * (1 + idx * 0.15), 2)
        
        # Qualidade da água melhora com investimentos
        water_quality = round(min(base_water_quality + (idx * 0.5), 95), 1)
        
        # Emissões variam
        co2_emissions = round(base_co2 * (1 + random.uniform(-0.1, 0.1)), 2)
        
        indicators.append({
            "id": str(uuid.uuid4()),
            "territory_id": territory_id,
            "year": year,
            "vegetation_coverage": vegetation_coverage,
            "deforested_area": deforested_area,
            "water_quality": water_quality,
            "co2_emissions": co2_emissions
        })
    
    return indicators


def generate_sql_inserts(table_name: str, indicators: list) -> str:
    """Gera comandos SQL INSERT."""
    sql_lines = []
    
    for indicator in indicators:
        # Extrair campos JSON
        if table_name == "social_indicators":
            fields = f"""(
    '{indicator["id"]}',
    '{indicator["territory_id"]}',
    {indicator["year"]},
    {indicator["idhm"]},
    {indicator["population"]},
    {indicator["literacy_rate"]},
    {indicator["income_per_capita"]},
    '{json.dumps(indicator["education_metrics"])}'::jsonb,
    '{json.dumps(indicator["health_metrics"])}'::jsonb
)"""
        elif table_name == "territorial_indicators":
            fields = f"""(
    '{indicator["id"]}',
    '{indicator["territory_id"]}',
    {indicator["year"]},
    {indicator["urbanized_area"]},
    {indicator["density"]},
    {indicator["sanitation_coverage"]},
    '{json.dumps(indicator["land_use"])}'::jsonb
)"""
        elif table_name == "environmental_indicators":
            fields = f"""(
    '{indicator["id"]}',
    '{indicator["territory_id"]}',
    {indicator["year"]},
    {indicator["vegetation_coverage"]},
    {indicator["deforested_area"]},
    {indicator["water_quality"]},
    {indicator["co2_emissions"]}
)"""
        
        sql_lines.append(f"INSERT INTO {table_name} VALUES {fields};")
    
    return "\n".join(sql_lines)


def main():
    print("🚀 Gerando indicadores sociais, territoriais e ambientais...")
    
    # Carregar territórios via API HTTP
    import urllib.request
    try:
        with urllib.request.urlopen("http://localhost:5000/api/territories") as response:
            territories_data = json.loads(response.read().decode())
            territories = [{"id": t["id"], "name": t["name"]} for t in territories_data]
            print(f"✅ Carregados {len(territories)} territórios da API")
    except Exception as e:
        print(f"❌ Erro ao carregar territórios: {e}")
        print("⚠️  Certifique-se de que o servidor está rodando em http://localhost:5000")
        return
    
    years = [2019, 2020, 2021, 2022, 2023]
    
    all_social = []
    all_territorial = []
    all_environmental = []
    
    for territory in territories:
        tid = territory["id"]
        tname = territory["name"]
        
        all_social.extend(generate_social_indicators(tid, tname, years))
        all_territorial.extend(generate_territorial_indicators(tid, tname, years))
        all_environmental.extend(generate_environmental_indicators(tid, tname, years))
    
    print(f"✅ Gerados {len(all_social)} indicadores sociais")
    print(f"✅ Gerados {len(all_territorial)} indicadores territoriais")
    print(f"✅ Gerados {len(all_environmental)} indicadores ambientais")
    
    # Gerar SQLs
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    
    # Social
    with open("insert_social_indicators.sql", "w", encoding="utf-8") as f:
        f.write(f"""-- SQL INSERTs para popular a tabela social_indicators
-- Gerado automaticamente em: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
-- Total de registros: {len(territories)} territórios × 5 anos = {len(all_social)} registros
-- Dados: Sintéticos mas realistas (baseados em padrões reais)

BEGIN;

""")
        f.write(generate_sql_inserts("social_indicators", all_social))
        f.write("\n\nCOMMIT;\n\n")
        f.write(f"-- Verificação: SELECT COUNT(*) FROM social_indicators;\n")
        f.write(f"-- Esperado: {len(all_social)} registros\n")
    
    # Territorial
    with open("insert_territorial_indicators.sql", "w", encoding="utf-8") as f:
        f.write(f"""-- SQL INSERTs para popular a tabela territorial_indicators
-- Gerado automaticamente em: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
-- Total de registros: {len(territories)} territórios × 5 anos = {len(all_territorial)} registros
-- Dados: Sintéticos mas realistas (baseados em padrões reais)

BEGIN;

""")
        f.write(generate_sql_inserts("territorial_indicators", all_territorial))
        f.write("\n\nCOMMIT;\n\n")
        f.write(f"-- Verificação: SELECT COUNT(*) FROM territorial_indicators;\n")
        f.write(f"-- Esperado: {len(all_territorial)} registros\n")
    
    # Environmental
    with open("insert_environmental_indicators.sql", "w", encoding="utf-8") as f:
        f.write(f"""-- SQL INSERTs para popular a tabela environmental_indicators
-- Gerado automaticamente em: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
-- Total de registros: {len(territories)} territórios × 5 anos = {len(all_environmental)} registros
-- Dados: Sintéticos mas realistas (baseados em padrões reais)

BEGIN;

""")
        f.write(generate_sql_inserts("environmental_indicators", all_environmental))
        f.write("\n\nCOMMIT;\n\n")
        f.write(f"-- Verificação: SELECT COUNT(*) FROM environmental_indicators;\n")
        f.write(f"-- Esperado: {len(all_environmental)} registros\n")
    
    print(f"\n📄 Arquivos SQL gerados:")
    print(f"  - insert_social_indicators.sql ({len(all_social)} registros)")
    print(f"  - insert_territorial_indicators.sql ({len(all_territorial)} registros)")
    print(f"  - insert_environmental_indicators.sql ({len(all_environmental)} registros)")
    print(f"\n✨ Total: {len(all_social) + len(all_territorial) + len(all_environmental)} indicadores!")


if __name__ == "__main__":
    main()
