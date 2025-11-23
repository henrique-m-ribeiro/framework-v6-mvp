#!/usr/bin/env python3
"""
Gerador de dados sintéticos com SCHEMA CORRETO para indicadores Territoriais e Ambientais
"""

import os
import sys
import random
import uuid
import json
from datetime import datetime
import subprocess

DATABASE_URL = os.environ.get('DATABASE_URL')
if not DATABASE_URL:
    print("❌ Erro: DATABASE_URL não encontrado")
    sys.exit(1)

print("=" * 70)
print("GERADOR DE DADOS SINTÉTICOS - SCHEMA CORRETO")
print("=" * 70)
print()

# Anos
YEARS = [2019, 2020, 2021, 2022, 2023]

# Coletar territórios
result = subprocess.run(
    ["psql", DATABASE_URL, "-t", "-c", "SELECT id FROM territories ORDER BY id"],
    capture_output=True,
    text=True
)

if result.returncode != 0:
    print(f"❌ Erro ao carregar territórios: {result.stderr}")
    sys.exit(1)

TERRITORY_IDS = [line.strip() for line in result.stdout.strip().split('\n') if line.strip()]
print(f"✓ {len(TERRITORY_IDS)} territórios carregados")
print()

sql_territorial = []
sql_environmental = []

total = len(TERRITORY_IDS) * len(YEARS)
count = 0

for territory_id in TERRITORY_IDS:
    for year in YEARS:
        count += 1
        
        # ============================================================
        # TERRITORIAL INDICATORS (schema correto)
        # ============================================================
        
        # urbanizedArea: % de área urbanizada (0-100)
        urbanized_area = round(random.uniform(5.0, 95.0), 1)
        
        # density: densidade populacional (hab/km²)
        density = round(random.uniform(1.2, 190.0), 2)
        
        # sanitationCoverage: % de cobertura de saneamento (0-100)
        sanitation_coverage = round(random.uniform(35.0, 95.0), 1)
        
        # landUse: uso do solo (JSON)
        land_use = {
            "agricultura": round(random.uniform(20.0, 60.0), 1),
            "pecuaria": round(random.uniform(10.0, 40.0), 1),
            "florestal": round(random.uniform(15.0, 50.0), 1),
            "urbano": round(random.uniform(2.0, 15.0), 1),
            "outros": round(random.uniform(1.0, 10.0), 1)
        }
        land_use_json = json.dumps(land_use)
        
        sql_territorial.append(
            f"INSERT INTO territorial_indicators (id, territory_id, year, urbanized_area, "
            f"density, sanitation_coverage, land_use) "
            f"VALUES ('{uuid.uuid4()}', '{territory_id}', {year}, {urbanized_area}, "
            f"{density}, {sanitation_coverage}, '{land_use_json}'::json);"
        )
        
        # ============================================================
        # ENVIRONMENTAL INDICATORS (schema correto)
        # ============================================================
        
        # vegetationCoverage: % de cobertura vegetal (0-100)
        vegetation_coverage = round(random.uniform(55.0, 95.0), 1)
        
        # deforestedArea: área desmatada em km²
        deforested_area = round(random.uniform(10.0, 500.0), 2)
        
        # waterQuality: índice de qualidade da água (0-100)
        water_quality = round(random.uniform(60.0, 95.0), 1)
        
        # co2Emissions: emissões de CO2 em toneladas
        co2_emissions = round(random.uniform(5000.0, 150000.0), 2)
        
        sql_environmental.append(
            f"INSERT INTO environmental_indicators (id, territory_id, year, vegetation_coverage, "
            f"deforested_area, water_quality, co2_emissions) "
            f"VALUES ('{uuid.uuid4()}', '{territory_id}', {year}, {vegetation_coverage}, "
            f"{deforested_area}, {water_quality}, {co2_emissions});"
        )
        
        if count % 100 == 0 or count == total:
            print(f"  [{count}/{total}] {territory_id} - {year}")

print()
print(f"✓ {len(sql_territorial)} territoriais | {len(sql_environmental)} ambientais")
print()

# Escrever arquivos
with open('insert_territorial_correct.sql', 'w', encoding='utf-8') as f:
    f.write("-- Indicadores Territoriais (SCHEMA CORRETO)\n")
    f.write(f"-- {datetime.now()}\n\n")
    f.write("BEGIN;\n\n")
    f.write("\n".join(sql_territorial))
    f.write("\n\nCOMMIT;\n")

with open('insert_environmental_correct.sql', 'w', encoding='utf-8') as f:
    f.write("-- Indicadores Ambientais (SCHEMA CORRETO)\n")
    f.write(f"-- {datetime.now()}\n\n")
    f.write("BEGIN;\n\n")
    f.write("\n".join(sql_environmental))
    f.write("\n\nCOMMIT;\n")

print("✅ Arquivos gerados:")
print("   - insert_territorial_correct.sql")
print("   - insert_environmental_correct.sql")
print()
