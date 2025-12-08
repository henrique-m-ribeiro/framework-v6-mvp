-- ========================================
-- MIGRAÇÃO V3: Adicionar Campos de Metadados Estruturados
-- ========================================
-- Data: 08/12/2025
-- Sessão: #13
-- Objetivo: Enriquecer as tabelas com metadados para análises futuras do sistema.
-- Arquitetura: V4 (IDs Semânticos + Metadados Estruturados)
-- ========================================

-- Adicionar colunas à tabela knowledge_base
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS request_id character varying;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS analysis_scope character varying;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS territory_scope character varying;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS dimensions text[];
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS territories jsonb;

-- Adicionar colunas à tabela agent_econ_memory
ALTER TABLE agent_econ_memory ADD COLUMN IF NOT EXISTS request_id character varying;
ALTER TABLE agent_econ_memory ADD COLUMN IF NOT EXISTS analysis_scope character varying;
ALTER TABLE agent_econ_memory ADD COLUMN IF NOT EXISTS territory_scope character varying;
ALTER TABLE agent_econ_memory ADD COLUMN IF NOT EXISTS dimensions text[];
ALTER TABLE agent_econ_memory ADD COLUMN IF NOT EXISTS territories jsonb;

-- Adicionar colunas à tabela agent_social_memory
ALTER TABLE agent_social_memory ADD COLUMN IF NOT EXISTS request_id character varying;
ALTER TABLE agent_social_memory ADD COLUMN IF NOT EXISTS analysis_scope character varying;
ALTER TABLE agent_social_memory ADD COLUMN IF NOT EXISTS territory_scope character varying;
ALTER TABLE agent_social_memory ADD COLUMN IF NOT EXISTS dimensions text[];
ALTER TABLE agent_social_memory ADD COLUMN IF NOT EXISTS territories jsonb;

-- Adicionar colunas à tabela agent_terra_memory
ALTER TABLE agent_terra_memory ADD COLUMN IF NOT EXISTS request_id character varying;
ALTER TABLE agent_terra_memory ADD COLUMN IF NOT EXISTS analysis_scope character varying;
ALTER TABLE agent_terra_memory ADD COLUMN IF NOT EXISTS territory_scope character varying;
ALTER TABLE agent_terra_memory ADD COLUMN IF NOT EXISTS dimensions text[];
ALTER TABLE agent_terra_memory ADD COLUMN IF NOT EXISTS territories jsonb;

-- Adicionar colunas à tabela agent_ambient_memory
ALTER TABLE agent_ambient_memory ADD COLUMN IF NOT EXISTS request_id character varying;
ALTER TABLE agent_ambient_memory ADD COLUMN IF NOT EXISTS analysis_scope character varying;
ALTER TABLE agent_ambient_memory ADD COLUMN IF NOT EXISTS territory_scope character varying;
ALTER TABLE agent_ambient_memory ADD COLUMN IF NOT EXISTS dimensions text[];
ALTER TABLE agent_ambient_memory ADD COLUMN IF NOT EXISTS territories jsonb;

-- ========================================
-- VERIFICAÇÃO PÓS-MIGRAÇÃO
-- ========================================

-- Verificar as novas colunas na tabela knowledge_base
SELECT column_name, data_type FROM information_schema.columns
WHERE table_name = 'knowledge_base'
  AND column_name IN ('request_id', 'analysis_scope', 'territory_scope', 'dimensions', 'territories');

-- Verificar as novas colunas na tabela agent_econ_memory
SELECT column_name, data_type FROM information_schema.columns
WHERE table_name = 'agent_econ_memory'
  AND column_name IN ('request_id', 'analysis_scope', 'territory_scope', 'dimensions', 'territories');
