-- ========================================
-- QUERY MULTIDIMENSIONAL PARA ANÁLISE ECONÔMICA
-- Versão: 1.0
-- Data: 30/11/2025
-- Descrição: Consulta dados econômicos, sociais, territoriais e ambientais
--            para enriquecer análise econômica com contexto multidimensional
-- ========================================

-- Parâmetro de entrada (substituído pelo n8n):
-- {{ $('Normalizar Entrada').first().json.territory_id }}

WITH 
-- 1. DADOS TERRITORIAIS (Base geográfica e infraestrutura)
territory_data AS (
  SELECT 
    t.id AS territory_id,
    t.name AS territory_name,
    t.type AS territory_type,
    t.area AS territory_area_km2,
    t.population AS population,
    t.geometry,
    ti.year AS territorial_year,
    ti.urban_area_km2,
    ti.rural_area_km2,
    ti.road_network_km,
    ti.paved_roads_km,
    ti.unpaved_roads_km,
    ti.distance_to_capital_km,
    ti.distance_to_nearest_port_km,
    ti.has_airport,
    ti.has_railway,
    ti.has_waterway,
    ti.internet_coverage_pct,
    ti.mobile_coverage_pct,
    ti.electricity_coverage_pct
  FROM territories t
  LEFT JOIN territorial_indicators ti ON t.id = ti.territory_id
  WHERE t.id = '{{ $('Normalizar Entrada').first().json.territory_id }}'
    AND (ti.year IS NULL OR ti.year >= 2019)
),

-- 2. DADOS ECONÔMICOS (Indicadores econômicos principais)
economic_data AS (
  SELECT 
    ei.territory_id,
    ei.year AS economic_year,
    ei.gdp AS gdp_millions,
    ei.gdp_per_capita,
    ei.employment_rate,
    ei.formal_employment_count,
    ei.informal_employment_est_pct,
    ei.average_salary,
    ei.revenue AS municipal_revenue,
    ei.own_revenue,
    ei.transfer_revenue,
    ei.fiscal_dependency_pct,
    ei.sector_distribution,
    ei.agriculture_gdp_pct,
    ei.industry_gdp_pct,
    ei.services_gdp_pct,
    ei.public_admin_gdp_pct,
    ei.exports_usd,
    ei.imports_usd,
    ei.trade_balance_usd,
    ei.credit_volume_millions,
    ei.business_count,
    ei.micro_business_pct,
    ei.small_business_pct,
    ei.medium_business_pct,
    ei.large_business_pct
  FROM economic_indicators ei
  WHERE ei.territory_id = '{{ $('Normalizar Entrada').first().json.territory_id }}'
    AND ei.year >= 2019
    AND ei.year <= 2023
),

-- 3. DADOS SOCIAIS (Educação, saúde, pobreza - impactam economia)
social_data AS (
  SELECT 
    si.territory_id,
    si.year AS social_year,
    si.ideb_initial_years,
    si.ideb_final_years,
    si.illiteracy_rate_pct,
    si.higher_education_pct,
    si.poverty_rate_pct,
    si.extreme_poverty_rate_pct,
    si.gini_index,
    si.unemployment_rate_pct,
    si.informal_work_pct,
    si.child_mortality_per_1000,
    si.life_expectancy_years,
    si.basic_sanitation_coverage_pct,
    si.treated_water_coverage_pct,
    si.sewage_coverage_pct,
    si.solid_waste_collection_pct,
    si.bolsa_familia_families,
    si.bolsa_familia_coverage_pct
  FROM social_indicators si
  WHERE si.territory_id = '{{ $('Normalizar Entrada').first().json.territory_id }}'
    AND si.year >= 2019
    AND si.year <= 2023
),

-- 4. DADOS AMBIENTAIS (Uso do solo, desmatamento - afetam agropecuária)
environmental_data AS (
  SELECT 
    ei.territory_id,
    ei.year AS environmental_year,
    ei.forest_cover_km2,
    ei.forest_cover_pct,
    ei.deforestation_km2_year,
    ei.deforestation_rate_pct,
    ei.agricultural_area_km2,
    ei.pasture_area_km2,
    ei.permanent_crops_area_km2,
    ei.temporary_crops_area_km2,
    ei.protected_areas_km2,
    ei.protected_areas_pct,
    ei.water_bodies_km2,
    ei.rainfall_mm_year,
    ei.avg_temperature_celsius,
    ei.drought_risk_index,
    ei.fire_hotspots_count,
    ei.environmental_fines_count,
    ei.environmental_fines_value_brl
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
  td.population,
  
  -- Ano de referência
  COALESCE(ed.economic_year, sd.social_year, td.territorial_year, envd.environmental_year) AS year,
  
  -- DIMENSÃO ECONÔMICA
  ed.gdp_millions,
  ed.gdp_per_capita,
  ed.employment_rate,
  ed.formal_employment_count,
  ed.informal_employment_est_pct,
  ed.average_salary,
  ed.municipal_revenue,
  ed.own_revenue,
  ed.transfer_revenue,
  ed.fiscal_dependency_pct,
  ed.sector_distribution,
  ed.agriculture_gdp_pct,
  ed.industry_gdp_pct,
  ed.services_gdp_pct,
  ed.public_admin_gdp_pct,
  ed.exports_usd,
  ed.imports_usd,
  ed.trade_balance_usd,
  ed.credit_volume_millions,
  ed.business_count,
  ed.micro_business_pct,
  ed.small_business_pct,
  ed.medium_business_pct,
  ed.large_business_pct,
  
  -- DIMENSÃO SOCIAL (Contexto para economia)
  sd.ideb_initial_years,
  sd.ideb_final_years,
  sd.illiteracy_rate_pct,
  sd.higher_education_pct,
  sd.poverty_rate_pct,
  sd.extreme_poverty_rate_pct,
  sd.gini_index,
  sd.unemployment_rate_pct AS social_unemployment_rate_pct,
  sd.informal_work_pct AS social_informal_work_pct,
  sd.child_mortality_per_1000,
  sd.life_expectancy_years,
  sd.basic_sanitation_coverage_pct,
  sd.treated_water_coverage_pct,
  sd.sewage_coverage_pct,
  sd.solid_waste_collection_pct,
  sd.bolsa_familia_families,
  sd.bolsa_familia_coverage_pct,
  
  -- DIMENSÃO TERRITORIAL (Infraestrutura para economia)
  td.urban_area_km2,
  td.rural_area_km2,
  td.road_network_km,
  td.paved_roads_km,
  td.unpaved_roads_km,
  td.distance_to_capital_km,
  td.distance_to_nearest_port_km,
  td.has_airport,
  td.has_railway,
  td.has_waterway,
  td.internet_coverage_pct,
  td.mobile_coverage_pct,
  td.electricity_coverage_pct,
  
  -- DIMENSÃO AMBIENTAL (Impacto na agropecuária)
  envd.forest_cover_km2,
  envd.forest_cover_pct,
  envd.deforestation_km2_year,
  envd.deforestation_rate_pct,
  envd.agricultural_area_km2,
  envd.pasture_area_km2,
  envd.permanent_crops_area_km2,
  envd.temporary_crops_area_km2,
  envd.protected_areas_km2,
  envd.protected_areas_pct,
  envd.water_bodies_km2,
  envd.rainfall_mm_year,
  envd.avg_temperature_celsius,
  envd.drought_risk_index,
  envd.fire_hotspots_count,
  envd.environmental_fines_count,
  envd.environmental_fines_value_brl,
  
  -- Metadados
  'multidimensional' AS data_type,
  'IBGE, SICONFI, RAIS, INPE, ANA, ICMBio' AS data_sources

FROM territory_data td
LEFT JOIN economic_data ed ON td.territory_id = ed.territory_id
LEFT JOIN social_data sd ON td.territory_id = sd.territory_id 
  AND COALESCE(ed.economic_year, sd.social_year) = sd.social_year
LEFT JOIN environmental_data envd ON td.territory_id = envd.territory_id
  AND COALESCE(ed.economic_year, envd.environmental_year) = envd.environmental_year

WHERE COALESCE(ed.economic_year, sd.social_year, td.territorial_year, envd.environmental_year) >= 2019
  AND COALESCE(ed.economic_year, sd.social_year, td.territorial_year, envd.environmental_year) <= 2023

ORDER BY year DESC;

-- ========================================
-- JUSTIFICATIVA DA ABORDAGEM MULTIDIMENSIONAL
-- ========================================
--
-- Esta query expande significativamente o contexto para análise econômica:
--
-- 1. DIMENSÃO SOCIAL → ECONOMIA:
--    - IDEB e escolaridade → Qualidade da força de trabalho
--    - Pobreza e Gini → Desigualdade e poder de compra
--    - Saneamento → Saúde e produtividade
--
-- 2. DIMENSÃO TERRITORIAL → ECONOMIA:
--    - Infraestrutura logística → Custos de transporte e competitividade
--    - Conectividade digital → Acesso a mercados e serviços
--    - Distância a portos → Viabilidade de exportações
--
-- 3. DIMENSÃO AMBIENTAL → ECONOMIA:
--    - Área agrícola e pastagens → Base produtiva agropecuária
--    - Desmatamento → Sustentabilidade e riscos regulatórios
--    - Clima e chuvas → Produtividade agrícola
--
-- RESULTADO: Análise econômica contextualizada e profunda, identificando
-- fatores estruturais que explicam desempenho econômico e oportunidades
-- de desenvolvimento sustentável.
