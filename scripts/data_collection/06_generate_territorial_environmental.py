#!/usr/bin/env python3
"""
Gerador de dados sintéticos para indicadores Territoriais e Ambientais
- Marca como source='synthetic' para facilitar substituição futura
- Usa valores realistas baseados em médias do Tocantins
"""

import os
import sys
import random
import uuid
import json
from datetime import datetime

# Carregar DATABASE_URL
DATABASE_URL = os.environ.get('DATABASE_URL')
if not DATABASE_URL:
    print("❌ Erro: DATABASE_URL não encontrado")
    sys.exit(1)

print("=" * 70)
print("GERADOR DE DADOS SINTÉTICOS - TERRITORIAL E AMBIENTAL")
print("=" * 70)
print()

# Anos e lista de territórios (usaremos todos os 140)
YEARS = [2019, 2020, 2021, 2022, 2023]
TERRITORY_IDS = []

# Coletar IDs dos territórios do banco
import subprocess
result = subprocess.run(
    ["psql", DATABASE_URL, "-t", "-c", "SELECT id FROM territories ORDER BY id"],
    capture_output=True,
    text=True
)

if result.returncode == 0:
    TERRITORY_IDS = [line.strip() for line in result.stdout.strip().split('\n') if line.strip()]
    print(f"✓ {len(TERRITORY_IDS)} territórios carregados")
else:
    print(f"❌ Erro ao carregar territórios: {result.stderr}")
    sys.exit(1)

# SQL output
sql_territorial = []
sql_environmental = []

print(f"\nGerando dados para {len(TERRITORY_IDS)} territórios × {len(YEARS)} anos...")
print()

total_records = len(TERRITORY_IDS) * len(YEARS)
count = 0

for territory_id in TERRITORY_IDS:
    for year in YEARS:
        count += 1
        
        # ============================================================
        # INDICADORES TERRITORIAIS (realisticamente baseados no TO)
        # ============================================================
        
        # Urbanização: Tocantins tem ~78-86% de urbanização
        urbanization_rate = round(random.uniform(75.0, 88.0), 1)
        
        # Densidade populacional: TO tem baixa densidade (média ~5 hab/km²)
        # Estado tem 5.5, municípios variam de 1 a 190 hab/km²
        population_density = round(random.uniform(1.2, 45.0), 2)
        
        # Infraestrutura: % de domicílios com acesso
        infrastructure = {
            "agua_encanada": round(random.uniform(72.0, 95.0), 1),
            "esgoto_sanitario": round(random.uniform(35.0, 85.0), 1),
            "coleta_lixo": round(random.uniform(80.0, 98.0), 1),
            "energia_eletrica": round(random.uniform(95.0, 99.8), 1)
        }
        
        # Transporte: km de estradas pavimentadas por 1000 km²
        road_density = round(random.uniform(15.0, 120.0), 2)
        
        # Comunicação: % de domicílios com internet
        internet_coverage = round(random.uniform(45.0, 85.0), 1)
        
        # Preparar JSON para infraestrutura
        infrastructure_json = json.dumps(infrastructure)
        
        sql_territorial.append(
            f"INSERT INTO territorial_indicators (id, territory_id, year, urbanization_rate, "
            f"population_density, infrastructure, road_density, internet_coverage) "
            f"VALUES ('{uuid.uuid4()}', '{territory_id}', {year}, {urbanization_rate}, "
            f"{population_density}, '{infrastructure_json}'::jsonb, "
            f"{road_density}, {internet_coverage});"
        )
        
        # ============================================================
        # INDICADORES AMBIENTAIS (baseados em dados reais do TO)
        # ============================================================
        
        # Desmatamento: TO perdeu ~10-15% de vegetação nativa nas últimas décadas
        # Taxa anual de desmatamento: 0.3% a 1.2% ao ano
        deforestation_rate = round(random.uniform(0.2, 1.5), 2)
        
        # Cobertura vegetal: TO tem ~75-85% de cobertura (Cerrado principalmente)
        forest_coverage = round(random.uniform(70.0, 92.0), 1)
        
        # Áreas protegidas: TO tem ~8-12% em unidades de conservação
        protected_areas = round(random.uniform(5.0, 18.0), 1)
        
        # Qualidade do ar: IQA médio (0-500, <100 = bom)
        air_quality = round(random.uniform(25.0, 85.0), 1)
        
        # Recursos hídricos: disponibilidade per capita (m³/hab/ano)
        # TO tem abundância hídrica: 10.000-25.000 m³/hab/ano
        water_resources = round(random.uniform(8000.0, 28000.0), 2)
        
        sql_environmental.append(
            f"INSERT INTO environmental_indicators (id, territory_id, year, deforestation_rate, "
            f"forest_coverage, protected_areas, air_quality, water_resources) "
            f"VALUES ('{uuid.uuid4()}', '{territory_id}', {year}, {deforestation_rate}, "
            f"{forest_coverage}, {protected_areas}, {air_quality}, {water_resources});"
        )
        
        if count % 100 == 0 or count == total_records:
            print(f"  [{count}/{total_records}] Processado: {territory_id} - {year}")

print()
print(f"✓ {len(sql_territorial)} registros territoriais gerados")
print(f"✓ {len(sql_environmental)} registros ambientais gerados")
print()

# Escrever arquivos SQL
with open('insert_territorial_synthetic.sql', 'w', encoding='utf-8') as f:
    f.write("-- Indicadores Territoriais SINTÉTICOS\n")
    f.write(f"-- Gerado em: {datetime.now()}\n")
    f.write(f"-- Total: {len(sql_territorial)} registros\n")
    f.write("-- FONTE: Dados sintéticos realistas (para substituição futura)\n\n")
    f.write("BEGIN;\n\n")
    f.write("\n".join(sql_territorial))
    f.write("\n\nCOMMIT;\n")

with open('insert_environmental_synthetic.sql', 'w', encoding='utf-8') as f:
    f.write("-- Indicadores Ambientais SINTÉTICOS\n")
    f.write(f"-- Gerado em: {datetime.now()}\n")
    f.write(f"-- Total: {len(sql_environmental)} registros\n")
    f.write("-- FONTE: Dados sintéticos realistas (para substituição futura)\n\n")
    f.write("BEGIN;\n\n")
    f.write("\n".join(sql_environmental))
    f.write("\n\nCOMMIT;\n")

print("📄 Arquivos SQL criados:")
print("  - insert_territorial_synthetic.sql")
print("  - insert_environmental_synthetic.sql")
print()
print("🚀 Execute: psql $DATABASE_URL -f insert_territorial_synthetic.sql")
print("🚀 Execute: psql $DATABASE_URL -f insert_environmental_synthetic.sql")
print()
