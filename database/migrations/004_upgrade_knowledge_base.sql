-- Migration: 004_upgrade_knowledge_base
-- Framework de Inteligência Territorial V6.0
--
-- Este script atualiza a tabela `knowledge_base` existente, adicionando campos e índices faltantes.

-- Análise da estrutura atual:
-- ✓ id (UUID)
-- ✓ territory_id (VARCHAR)
-- ✓ dimension (TEXT)
-- ✓ content (TEXT)
-- ✓ embedding (TEXT) - campo legado, será mantido
-- ✓ metadata (JSON) - será convertido para JSONB
-- ✓ embedding_vector (VECTOR(1536)) - campo correto para RAG
--
-- Campos a adicionar:
-- - analysis_type
-- - summary
-- - version
-- - is_latest
-- - confidence_score
-- - sources
-- - created_at
-- - updated_at
-- - generated_by

BEGIN;

-- Passo 1: Adicionar campos faltantes (se não existirem)

-- analysis_type
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS analysis_type VARCHAR(50) DEFAULT 'diagnostic';

-- summary
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS summary TEXT;

-- version
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS version INTEGER DEFAULT 1;

-- is_latest
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS is_latest BOOLEAN DEFAULT TRUE;

-- confidence_score
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS confidence_score DECIMAL(3,2) DEFAULT 0.80;

-- sources
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS sources JSONB;

-- created_at
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();

-- updated_at
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();

-- generated_by
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS generated_by VARCHAR(100);

-- Passo 2: Converter metadata de JSON para JSONB (melhor performance)
-- Nota: Isso pode falhar se já for JSONB, por isso usamos DO block com exception handling

DO $$
BEGIN
    -- Tentar converter metadata de JSON para JSONB
    ALTER TABLE knowledge_base 
    ALTER COLUMN metadata TYPE JSONB USING metadata::jsonb;
    
    RAISE NOTICE 'Metadata convertido de JSON para JSONB com sucesso.';
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Metadata já é JSONB ou conversão não necessária.';
END $$;

-- Passo 3: Adicionar constraints e índices faltantes

-- Constraint única (território + dimensão + tipo + versão)
-- Nota: Pode falhar se já existir, por isso usamos IF NOT EXISTS (PostgreSQL 15+) ou DO block

DO $$
BEGIN
    ALTER TABLE knowledge_base 
    ADD CONSTRAINT unique_kb_analysis UNIQUE(territory_id, dimension, analysis_type, version);
    
    RAISE NOTICE 'Constraint única adicionada com sucesso.';
EXCEPTION
    WHEN duplicate_table THEN
        RAISE NOTICE 'Constraint única já existe.';
END $$;

-- Índice para buscar versões mais recentes (parcial, mais eficiente)
CREATE INDEX IF NOT EXISTS idx_kb_latest 
    ON knowledge_base(is_latest) 
    WHERE is_latest = TRUE;

-- Índice GIN para busca eficiente dentro do campo JSONB `metadata`
-- Nota: Agora deve funcionar porque metadata é JSONB
DROP INDEX IF EXISTS idx_kb_metadata;  -- Remove índice antigo se existir
CREATE INDEX idx_kb_metadata 
    ON knowledge_base USING GIN(metadata jsonb_path_ops);

-- Atualizar índice vetorial com mais listas para melhor performance
-- Nota: Para ~1.680 análises, 100 listas é ideal (regra: rows/1000, mínimo 10)
DROP INDEX IF EXISTS idx_knowledge_base_embedding;  -- Remove índice antigo
CREATE INDEX idx_kb_embedding_vector 
    ON knowledge_base USING ivfflat(embedding_vector vector_cosine_ops)
    WITH (lists = 100);

-- Passo 4: Atualizar comentários da tabela
COMMENT ON TABLE knowledge_base IS 'Armazena análises de IA, embeddings e metadados sobre os territórios. Suporta busca semântica (RAG) e versionamento.';
COMMENT ON COLUMN knowledge_base.embedding_vector IS 'Vetor de embedding (1536 dimensões) para busca semântica (RAG). Usar este campo para queries vetoriais.';
COMMENT ON COLUMN knowledge_base.embedding IS 'Campo legado de embedding (texto). Manter para compatibilidade, mas usar embedding_vector para RAG.';
COMMENT ON COLUMN knowledge_base.metadata IS 'Metadados estruturados em JSONB para filtragem avançada (indicadores, tendências, alertas, etc.).';
COMMENT ON COLUMN knowledge_base.is_latest IS 'Flag para identificar a versão mais recente de uma análise. Usar em queries para obter sempre a versão atual.';
COMMENT ON COLUMN knowledge_base.version IS 'Número da versão da análise (1, 2, 3...). Permite manter histórico completo.';
COMMENT ON COLUMN knowledge_base.confidence_score IS 'Nível de confiança da análise (0.00 a 1.00). Valores acima de 0.80 indicam alta qualidade.';

-- Passo 5: Atualizar registros existentes (se houver)
-- Define valores padrão para campos novos em registros antigos

UPDATE knowledge_base
SET 
    analysis_type = COALESCE(analysis_type, 'diagnostic'),
    is_latest = COALESCE(is_latest, TRUE),
    version = COALESCE(version, 1),
    confidence_score = COALESCE(confidence_score, 0.80),
    created_at = COALESCE(created_at, NOW()),
    updated_at = COALESCE(updated_at, NOW())
WHERE analysis_type IS NULL 
   OR is_latest IS NULL 
   OR version IS NULL;

COMMIT;

-- Passo 6: Verificar resultado
SELECT 
    'knowledge_base' as table_name,
    COUNT(*) as total_records,
    COUNT(DISTINCT territory_id) as territories,
    COUNT(DISTINCT dimension) as dimensions,
    COUNT(*) FILTER (WHERE is_latest = TRUE) as latest_versions
FROM knowledge_base;

-- Fim da migração
