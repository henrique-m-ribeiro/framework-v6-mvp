-- ============================================================================
-- MIGRAÇÃO: Atualizar Schema da Tabela economic_indicators
-- Framework V6.0 - Camada 0: Dados Estruturados
-- Data: 29/11/2025
-- Autor: Manus AI
-- ============================================================================
-- OBJETIVO: Atualizar a tabela economic_indicators para incluir os 5 indicadores
-- econômicos essenciais propostos, garantindo maior precisão, clareza e
-- capacidade analítica.
-- ============================================================================

BEGIN;

-- ============================================================================
-- PASSO 1: Criar tabela temporária com novo schema
-- ============================================================================

CREATE TABLE economic_indicators_new (
    id SERIAL PRIMARY KEY,
    territory_id INTEGER NOT NULL REFERENCES territories(id) ON DELETE CASCADE,
    year INTEGER NOT NULL,
    
    -- Indicador 1: PIB a preços correntes
    gdp_current_prices NUMERIC(20, 2),
    
    -- Indicador 2: PIB per capita
    gdp_per_capita NUMERIC(15, 2),
    
    -- Indicador 3: Massa Salarial
    total_wage_mass NUMERIC(20, 2),
    
    -- Indicador 4: Número de Empresas Ativas
    active_companies_count INTEGER,
    
    -- Indicador 5: Receita Tributária Própria
    municipal_tax_revenue NUMERIC(20, 2),
    
    -- Metadados
    source VARCHAR(255),
    metadata JSONB,
    
    -- Constraints
    UNIQUE(territory_id, year)
);

-- ============================================================================
-- PASSO 2: Migrar dados existentes (se houver)
-- ============================================================================
-- Nota: Esta migração assume que os dados existentes na tabela antiga
-- podem ser mapeados para os novos campos. Ajuste conforme necessário.

INSERT INTO economic_indicators_new (
    territory_id,
    year,
    gdp_current_prices,
    gdp_per_capita,
    source
)
SELECT 
    CAST(territory_id AS INTEGER),
    year,
    gdp,
    gdp_per_capita,
    'Migração de dados antigos'
FROM economic_indicators
WHERE territory_id ~ '^\d+$'; -- Apenas IDs numéricos válidos

-- ============================================================================
-- PASSO 3: Remover tabela antiga e renomear a nova
-- ============================================================================

DROP TABLE IF EXISTS economic_indicators CASCADE;

ALTER TABLE economic_indicators_new RENAME TO economic_indicators;

-- ============================================================================
-- PASSO 4: Criar índices para otimização de consultas
-- ============================================================================

CREATE INDEX idx_economic_indicators_territory_year 
    ON economic_indicators(territory_id, year DESC);

CREATE INDEX idx_economic_indicators_year 
    ON economic_indicators(year DESC);

CREATE INDEX idx_economic_indicators_gdp 
    ON economic_indicators(gdp_current_prices DESC);

-- ============================================================================
-- PASSO 5: Adicionar comentários para documentação
-- ============================================================================

COMMENT ON TABLE economic_indicators IS 
'Tabela de indicadores econômicos por território e ano. Contém os 5 indicadores essenciais para análise econômica territorial.';

COMMENT ON COLUMN economic_indicators.gdp_current_prices IS 
'PIB a preços correntes (em R$ mil). Fonte: IBGE - Contas Regionais.';

COMMENT ON COLUMN economic_indicators.gdp_per_capita IS 
'PIB per capita (em R$). Calculado como PIB total / população.';

COMMENT ON COLUMN economic_indicators.total_wage_mass IS 
'Massa salarial total (em R$ mil). Fonte: RAIS / CAGED.';

COMMENT ON COLUMN economic_indicators.active_companies_count IS 
'Número de empresas e outras organizações ativas. Fonte: RAIS / CNPJ.';

COMMENT ON COLUMN economic_indicators.municipal_tax_revenue IS 
'Receita tributária própria do município (em R$ mil). Fonte: SICONFI / FINBRA.';

COMMENT ON COLUMN economic_indicators.source IS 
'Fonte principal dos dados do registro (ex: "IBGE, RAIS").';

COMMENT ON COLUMN economic_indicators.metadata IS 
'Metadados adicionais em formato JSONB (ex: notas metodológicas, data de coleta).';

-- ============================================================================
-- FINALIZAÇÃO
-- ============================================================================

COMMIT;

-- ============================================================================
-- VERIFICAÇÃO PÓS-MIGRAÇÃO
-- ============================================================================
-- Execute as queries abaixo para verificar se a migração foi bem-sucedida:

-- 1. Verificar schema da nova tabela
-- SELECT column_name, data_type, is_nullable
-- FROM information_schema.columns
-- WHERE table_name = 'economic_indicators'
-- ORDER BY ordinal_position;

-- 2. Verificar dados migrados
-- SELECT COUNT(*) AS total_records FROM economic_indicators;

-- 3. Verificar índices criados
-- SELECT indexname, indexdef
-- FROM pg_indexes
-- WHERE tablename = 'economic_indicators';
