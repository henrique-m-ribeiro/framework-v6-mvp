-- Script de Limpeza do Banco de Dados
-- Framework V6.0 - Remover dados mock antes de inserir dados reais
-- 
-- ATENÇÃO: Este script APAGA TODOS OS DADOS das tabelas!
-- Certifique-se de ter feito backup antes de executar!
--
-- Para executar: psql $DATABASE_URL -f 00_clean_database.sql

BEGIN;

-- Desabilitar triggers temporariamente (se houver)
SET session_replication_role = replica;

-- Limpar tabela de indicadores ambientais
DELETE FROM environmental_indicators;

-- Limpar tabela de indicadores territoriais
DELETE FROM territorial_indicators;

-- Limpar tabela de indicadores sociais
DELETE FROM social_indicators;

-- Limpar tabela de indicadores econômicos
DELETE FROM economic_indicators;

-- Limpar tabela de territórios (por último, pois outras tabelas dependem dela)
DELETE FROM territories;

-- Limpar tabela de conhecimento (se existir)
DELETE FROM knowledge_base WHERE 1=1;

-- Limpar tabela de metadados
DELETE FROM indicator_metadata;

-- Reabilitar triggers
SET session_replication_role = DEFAULT;

COMMIT;

-- Verificar se as tabelas estão vazias
SELECT 'territories' AS tabela, COUNT(*) AS registros FROM territories
UNION ALL
SELECT 'economic_indicators', COUNT(*) FROM economic_indicators
UNION ALL
SELECT 'social_indicators', COUNT(*) FROM social_indicators
UNION ALL
SELECT 'territorial_indicators', COUNT(*) FROM territorial_indicators
UNION ALL
SELECT 'environmental_indicators', COUNT(*) FROM environmental_indicators
UNION ALL
SELECT 'indicator_metadata', COUNT(*) FROM indicator_metadata
UNION ALL
SELECT 'knowledge_base', COUNT(*) FROM knowledge_base;
