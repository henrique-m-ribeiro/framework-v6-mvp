#!/usr/bin/env python3
"""
Script 1: Extrair Lista de Indicadores
Framework V6.0 - Popular indicator_metadata

Este script extrai a lista completa de indicadores das 4 dimensões
e salva em um arquivo JSON para processamento posterior.

Uso: python3 01_extract_indicators.py
"""

import json
import os

# Lista completa de indicadores
indicators = [
    # ========== DIMENSÃO ECONÔMICA ==========
    {
        "code": "gdp",
        "name": "PIB",
        "dimension": "economic",
        "unit": "milhões R$"
    },
    {
        "code": "gdp_per_capita",
        "name": "PIB per capita",
        "dimension": "economic",
        "unit": "R$"
    },
    {
        "code": "employment_rate",
        "name": "Taxa de emprego",
        "dimension": "economic",
        "unit": "%"
    },
    {
        "code": "revenue",
        "name": "Receita total",
        "dimension": "economic",
        "unit": "R$"
    },
    {
        "code": "sector_servicos",
        "name": "Setor de Serviços",
        "dimension": "economic",
        "unit": "%"
    },
    {
        "code": "sector_industria",
        "name": "Setor Industrial",
        "dimension": "economic",
        "unit": "%"
    },
    {
        "code": "sector_agricultura",
        "name": "Setor Agrícola",
        "dimension": "economic",
        "unit": "%"
    },
    
    # ========== DIMENSÃO SOCIAL ==========
    {
        "code": "idhm",
        "name": "IDH-M",
        "dimension": "social",
        "unit": "índice (0-1)"
    },
    {
        "code": "population",
        "name": "População",
        "dimension": "social",
        "unit": "habitantes"
    },
    {
        "code": "literacy_rate",
        "name": "Taxa de alfabetização",
        "dimension": "social",
        "unit": "%"
    },
    {
        "code": "income_per_capita",
        "name": "Renda per capita",
        "dimension": "social",
        "unit": "R$"
    },
    {
        "code": "ideb_anos_finais",
        "name": "IDEB (Anos Finais)",
        "dimension": "social",
        "unit": "nota (0-10)"
    },
    {
        "code": "ideb_anos_iniciais",
        "name": "IDEB (Anos Iniciais)",
        "dimension": "social",
        "unit": "nota (0-10)"
    },
    {
        "code": "taxa_conclusao_medio",
        "name": "Taxa de Conclusão (Ensino Médio)",
        "dimension": "social",
        "unit": "%"
    },
    {
        "code": "taxa_conclusao_fundamental",
        "name": "Taxa de Conclusão (Ensino Fundamental)",
        "dimension": "social",
        "unit": "%"
    },
    {
        "code": "expectativa_vida",
        "name": "Expectativa de Vida",
        "dimension": "social",
        "unit": "anos"
    },
    {
        "code": "cobertura_vacinal",
        "name": "Cobertura Vacinal",
        "dimension": "social",
        "unit": "%"
    },
    {
        "code": "mortalidade_infantil",
        "name": "Mortalidade Infantil",
        "dimension": "social",
        "unit": "por 1.000 nascidos vivos"
    },
    {
        "code": "leitos_por_mil_habitantes",
        "name": "Leitos por Mil Habitantes",
        "dimension": "social",
        "unit": "leitos/1.000 hab"
    },
    
    # ========== DIMENSÃO TERRITORIAL ==========
    {
        "code": "area_km2",
        "name": "Área Territorial",
        "dimension": "territorial",
        "unit": "km²"
    },
    {
        "code": "density_per_km2",
        "name": "Densidade Demográfica",
        "dimension": "territorial",
        "unit": "hab/km²"
    },
    {
        "code": "water_supply_pct",
        "name": "Abastecimento de Água",
        "dimension": "territorial",
        "unit": "%"
    },
    {
        "code": "sewage_pct",
        "name": "Esgotamento Sanitário",
        "dimension": "territorial",
        "unit": "%"
    },
    {
        "code": "garbage_collection_pct",
        "name": "Coleta de Lixo",
        "dimension": "territorial",
        "unit": "%"
    },
    {
        "code": "paved_roads_pct",
        "name": "Vias Pavimentadas",
        "dimension": "territorial",
        "unit": "%"
    },
    {
        "code": "street_lighting_pct",
        "name": "Iluminação Pública",
        "dimension": "territorial",
        "unit": "%"
    },
    {
        "code": "internet_access_pct",
        "name": "Acesso à Internet",
        "dimension": "territorial",
        "unit": "%"
    },
    {
        "code": "mobile_coverage_pct",
        "name": "Cobertura de Telefonia Móvel",
        "dimension": "territorial",
        "unit": "%"
    },
    
    # ========== DIMENSÃO AMBIENTAL ==========
    {
        "code": "deforestation_km2",
        "name": "Desmatamento",
        "dimension": "environmental",
        "unit": "km²"
    },
    {
        "code": "fire_spots",
        "name": "Focos de Calor",
        "dimension": "environmental",
        "unit": "quantidade"
    },
    {
        "code": "native_vegetation_pct",
        "name": "Vegetação Nativa",
        "dimension": "environmental",
        "unit": "%"
    },
    {
        "code": "pasture_pct",
        "name": "Pastagem",
        "dimension": "environmental",
        "unit": "%"
    },
    {
        "code": "agriculture_pct",
        "name": "Agricultura",
        "dimension": "environmental",
        "unit": "%"
    },
    {
        "code": "protected_areas_pct",
        "name": "Áreas Protegidas",
        "dimension": "environmental",
        "unit": "%"
    },
    {
        "code": "water_bodies_pct",
        "name": "Corpos d'Água",
        "dimension": "environmental",
        "unit": "%"
    }
]

# Criar diretório de saída se não existir
output_dir = os.path.dirname(os.path.abspath(__file__))
output_file = os.path.join(output_dir, "indicators_list.json")

# Salvar
with open(output_file, "w", encoding="utf-8") as f:
    json.dump(indicators, f, indent=2, ensure_ascii=False)

# Estatísticas
dimensions = {}
for indicator in indicators:
    dim = indicator["dimension"]
    dimensions[dim] = dimensions.get(dim, 0) + 1

print("=" * 50)
print("EXTRAÇÃO DE INDICADORES CONCLUÍDA")
print("=" * 50)
print(f"\n✓ Total de indicadores: {len(indicators)}")
print(f"\n📊 Por dimensão:")
for dim, count in sorted(dimensions.items()):
    print(f"  • {dim}: {count} indicadores")
print(f"\n💾 Arquivo salvo: {output_file}")
print("=" * 50)
