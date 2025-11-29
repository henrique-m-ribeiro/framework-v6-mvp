-- ============================================================================
-- MIGRAÇÃO ETAPA 1: Adicionar Novos Campos à Tabela economic_indicators
-- Framework V6.0 - Camada 0: Dados Estruturados
-- Data: 29/11/2025
-- Autor: Manus AI
-- ============================================================================
-- OBJETIVO: Adicionar novos campos à tabela economic_indicators SEM remover
-- os campos existentes, garantindo compatibilidade total com o aplicativo.
-- ============================================================================

BEGIN;

-- ============================================================================
-- PASSO 1: Adicionar novos campos (se não existirem)
-- ============================================================================

ALTER TABLE economic_indicators
ADD COLUMN IF NOT EXISTS gdp_current_prices NUMERIC(20, 2),
ADD COLUMN IF NOT EXISTS total_wage_mass NUMERIC(20, 2),
ADD COLUMN IF NOT EXISTS active_companies_count INTEGER,
ADD COLUMN IF NOT EXISTS municipal_tax_revenue NUMERIC(20, 2),
ADD COLUMN IF NOT EXISTS source VARCHAR(255),
ADD COLUMN IF NOT EXISTS metadata JSONB;

-- ============================================================================
-- PASSO 2: Migrar dados existentes para o novo campo de PIB
-- ============================================================================
-- Copiar valores de 'gdp' para 'gdp_current_prices' (apenas onde ainda é NULL)

UPDATE economic_indicators
SET gdp_current_prices = gdp
WHERE gdp_current_prices IS NULL AND gdp IS NOT NULL;

-- ============================================================================
-- PASSO 3: Adicionar comentários para documentação
-- ============================================================================

COMMENT ON COLUMN economic_indicators.gdp_current_prices IS 
'PIB a preços correntes (em milhões de R$). Fonte: IBGE - Contas Regionais. Campo novo adicionado na migração v4.0.';

COMMENT ON COLUMN economic_indicators.total_wage_mass IS 
'Massa salarial total (em milhões de R$). Fonte: RAIS / CAGED. Campo novo adicionado na migração v4.0.';

COMMENT ON COLUMN economic_indicators.active_companies_count IS 
'Número de empresas e outras organizações ativas. Fonte: RAIS / CNPJ. Campo novo adicionado na migração v4.0.';

COMMENT ON COLUMN economic_indicators.municipal_tax_revenue IS 
'Receita tributária própria do município (em milhões de R$). Fonte: SICONFI / FINBRA. Campo novo adicionado na migração v4.0.';

COMMENT ON COLUMN economic_indicators.source IS 
'Fonte principal dos dados do registro (ex: "IBGE, RAIS"). Campo novo adicionado na migração v4.0.';

COMMENT ON COLUMN economic_indicators.metadata IS 
'Metadados adicionais em formato JSONB (ex: notas metodológicas, data de coleta). Campo novo adicionado na migração v4.0.';

-- ============================================================================
-- FINALIZAÇÃO
-- ============================================================================

COMMIT;

-- ============================================================================
-- VERIFICAÇÃO PÓS-MIGRAÇÃO
-- ============================================================================
-- Execute as queries abaixo para verificar se a migração foi bem-sucedida:

-- 1. Verificar se os novos campos foram adicionados
-- SELECT column_name, data_type, is_nullable
-- FROM information_schema.columns
-- WHERE table_name = 'economic_indicators'
-- ORDER BY ordinal_position;

-- 2. Verificar se os dados foram copiados corretamente
-- SELECT 
--     territory_id,
--     year,
--     gdp AS gdp_antigo,
--     gdp_current_prices AS gdp_novo
-- FROM economic_indicators
-- LIMIT 10;

-- 3. Contar registros com dados migrados
-- SELECT 
--     COUNT(*) AS total_registros,
--     COUNT(gdp) AS registros_com_gdp_antigo,
--     COUNT(gdp_current_prices) AS registros_com_gdp_novo
-- FROM economic_indicators;
