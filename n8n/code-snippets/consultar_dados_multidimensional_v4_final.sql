-- ========================================
-- QUERY MULTIDIMENSIONAL PARA ANÁLISE ECONÔMICA (V4 - FINAL)
-- Versão: 4.0
-- Data: 30/11/2025
-- Descrição: Query com colunas EXATAS validadas no schema real
-- ========================================

-- Parâmetro de entrada (substituído pelo n8n):
-- {{ $('Normalizar Entrada').first().json.territory_id }}

WITH 
-- 1. DADOS TERRITORIAIS
territory_data AS (
  SELECT 
    t.id AS territory_id,
    t.name AS territory_name,
    t.type AS territory_type,
    t.area AS territory_area_km2,
    ti.year AS territorial_year,
    ti.urbanized_area,
    ti.density,
    ti.sanitation_coverage,
    ti.land_use
  FROM territories t
  LEFT JOIN territorial_indicators ti ON t.id = ti.territory_id
  WHERE t.id = '{{ $('Normalizar Entrada').first().json.territory_id }}'
    AND (ti.year IS NULL OR ti.year >= 2019)
),

-- 2. DADOS ECONÔMICOS
economic_data AS (
  SELECT 
    ei.territory_id,
    ei.year AS economic_year,
    ei.gdp,
    ei.gdp_per_capita,
    ei.employment_rate,
    ei.revenue AS municipal_revenue,
    ei.sector_distribution,
    ei.gdp_current_prices,
    ei.total_wage_mass,
    ei.active_companies_count,
    ei.municipal_tax_revenue
  FROM economic_indicators ei
  WHERE ei.territory_id = '{{ $('Normalizar Entrada').first().json.territory_id }}'
    AND ei.year >= 2019
    AND ei.year <= 2023
),

-- 3. DADOS SOCIAIS
social_data AS (
  SELECT 
    si.territory_id,
    si.year AS social_year,
    si.population,
    si.idhm,
    si.literacy_rate,
    si.income_per_capita,
    si.education_metrics,
    si.health_metrics
  FROM social_indicators si
  WHERE si.territory_id = '{{ $('Normalizar Entrada').first().json.territory_id }}'
    AND si.year >= 2019
    AND si.year <= 2023
),

-- 4. DADOS AMBIENTAIS
environmental_data AS (
  SELECT 
    ei.territory_id,
    ei.year AS environmental_year,
    ei.vegetation_coverage,
    ei.deforested_area,
    ei.water_quality,
    ei.co2_emissions
  FROM environmental_indicators ei
  WHERE ei.territory_id = '{{ $('Normalizar Entrada').first().json.territory_id }}'
    AND ei.year >= 2019
    AND ei.year <= 2023
)

-- 5. UNIÃO DE TODAS AS DIMENSÕES
SELECT 
  -- Identificação do território
  td.territory_id,
  td.territory_name,
  td.territory_type,
  td.territory_area_km2,
  
  -- População (vem de social_indicators)
  sd.population,
  
  -- Ano de referência
  COALESCE(ed.economic_year, sd.social_year, td.territorial_year, envd.environmental_year) AS year,
  
  -- DIMENSÃO ECONÔMICA
  ed.gdp,
  ed.gdp_per_capita,
  ed.employment_rate,
  ed.municipal_revenue,
  ed.sector_distribution,
  ed.gdp_current_prices,
  ed.total_wage_mass,
  ed.active_companies_count,
  ed.municipal_tax_revenue,
  
  -- DIMENSÃO SOCIAL
  sd.idhm,
  sd.literacy_rate,
  sd.income_per_capita,
  sd.education_metrics,
  sd.health_metrics,
  
  -- DIMENSÃO TERRITORIAL
  td.urbanized_area,
  td.density,
  td.sanitation_coverage,
  td.land_use,
  
  -- DIMENSÃO AMBIENTAL
  envd.vegetation_coverage,
  envd.deforested_area,
  envd.water_quality,
  envd.co2_emissions,
  
  -- Metadados
  'multidimensional' AS data_type,
  'IBGE, SICONFI, RAIS, INPE' AS data_sources

FROM territory_data td
LEFT JOIN economic_data ed ON td.territory_id = ed.territory_id
  AND td.territorial_year = ed.economic_year
LEFT JOIN social_data sd ON td.territory_id = sd.territory_id 
  AND COALESCE(ed.economic_year, sd.social_year) = sd.social_year
LEFT JOIN environmental_data envd ON td.territory_id = envd.territory_id
  AND COALESCE(ed.economic_year, envd.environmental_year) = envd.environmental_year

WHERE COALESCE(ed.economic_year, sd.social_year, td.territorial_year, envd.environmental_year) >= 2019
  AND COALESCE(ed.economic_year, sd.social_year, td.territorial_year, envd.environmental_year) <= 2023

ORDER BY year DESC;

-- ========================================
-- SCHEMA REAL VALIDADO (30/11/2025 20:35 UTC)
-- ========================================
--
-- TERRITORIES:
--   - id, name, type, parent_id, area, metadata, coordinates
--
-- TERRITORIAL_INDICATORS:
--   - id, territory_id, year, urbanized_area, density, sanitation_coverage, land_use (JSON)
--
-- ECONOMIC_INDICATORS:
--   - id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue,
--     sector_distribution (JSON), gdp_current_prices, total_wage_mass,
--     active_companies_count, municipal_tax_revenue, source, metadata
--
-- SOCIAL_INDICATORS:
--   - id, territory_id, year, idhm, population, literacy_rate, income_per_capita,
--     education_metrics (JSON), health_metrics (JSON)
--
-- ENVIRONMENTAL_INDICATORS:
--   - id, territory_id, year, vegetation_coverage, deforested_area,
--     water_quality, co2_emissions
--
-- DADOS DISPONÍVEIS PARA PALMAS (1721000):
--   - territorial_indicators: 5 anos (2019-2023)
--   - economic_indicators: 5 anos (2019-2023)
--   - social_indicators: 8 registros (2019-2023)
--   - environmental_indicators: 10 registros (2019-2023)
