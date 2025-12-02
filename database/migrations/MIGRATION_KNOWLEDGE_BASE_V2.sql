-- ============================================================================
-- MIGRATION: Atualização da Tabela knowledge_base para Arquitetura V2
-- ============================================================================
-- Data: 02/12/2025
-- Objetivo: Adicionar colunas para suportar consolidação multidimensional
-- Responsável: Sistema de IA Territorial - Tocantins
-- ============================================================================

-- ============================================================================
-- FASE 1: BACKUP DE SEGURANÇA
-- ============================================================================

-- Criar tabela de backup antes da migration
CREATE TABLE IF NOT EXISTS knowledge_base_backup_20251202 AS 
SELECT * FROM knowledge_base;

-- Verificar quantidade de registros copiados
DO $$
DECLARE
    original_count INTEGER;
    backup_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO original_count FROM knowledge_base;
    SELECT COUNT(*) INTO backup_count FROM knowledge_base_backup_20251202;
    
    RAISE NOTICE 'Backup criado: % registros copiados de % originais', backup_count, original_count;
    
    IF backup_count != original_count THEN
        RAISE EXCEPTION 'ERRO: Backup incompleto! Abortar migration.';
    END IF;
END $$;

-- ============================================================================
-- FASE 2: ADICIONAR NOVAS COLUNAS
-- ============================================================================

-- 1. Adicionar coluna: original_question
-- Armazena a pergunta original do usuário
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS original_question TEXT;

COMMENT ON COLUMN knowledge_base.original_question IS 
'Pergunta original do usuário que gerou esta análise';

-- 2. Adicionar coluna: question_type
-- Tipo de pergunta: 'single_dimension' ou 'multidimensional'
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS question_type VARCHAR(50);

COMMENT ON COLUMN knowledge_base.question_type IS 
'Tipo de pergunta: single_dimension (1 agente) ou multidimensional (múltiplos agentes)';

-- 3. Adicionar coluna: dimensions_analyzed
-- Array com as dimensões analisadas: ['economic', 'social', 'territorial', 'environmental']
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS dimensions_analyzed VARCHAR(50)[];

COMMENT ON COLUMN knowledge_base.dimensions_analyzed IS 
'Array com as dimensões analisadas: economic, social, territorial, environmental';

-- 4. Adicionar coluna: source_analyses
-- JSON com referências aos IDs das análises dimensionais em agent_*_memory
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS source_analyses JSONB;

COMMENT ON COLUMN knowledge_base.source_analyses IS 
'JSON com IDs das análises dimensionais. Exemplo: {"economic": "uuid-123", "social": "uuid-456"}';

-- 5. Adicionar coluna: integrated_analysis
-- Análise integrada consolidada pelo Orquestrador (para perguntas multidimensionais)
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS integrated_analysis TEXT;

COMMENT ON COLUMN knowledge_base.integrated_analysis IS 
'Análise integrada consolidada pelo Orquestrador (apenas para perguntas multidimensionais)';

-- 6. Adicionar coluna: executive_summary
-- Resumo executivo da análise consolidada
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS executive_summary TEXT;

COMMENT ON COLUMN knowledge_base.executive_summary IS 
'Resumo executivo da análise consolidada';

-- 7. Adicionar coluna: key_insights
-- Insights principais de cada dimensão analisada
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS key_insights JSONB;

COMMENT ON COLUMN knowledge_base.key_insights IS 
'Insights principais de cada dimensão. Exemplo: {"economic": "PIB cresceu 3.2%", "social": "IDH melhorou"}';

-- 8. Adicionar coluna: overall_confidence_score
-- Renomear confidence_score existente para overall_confidence_score (média ponderada)
-- Nota: Mantemos a coluna antiga por compatibilidade e criamos a nova
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS overall_confidence_score NUMERIC;

COMMENT ON COLUMN knowledge_base.overall_confidence_score IS 
'Score de confiança geral (média ponderada dos scores dimensionais)';

-- 9. Adicionar coluna: total_indicators_analyzed
-- Total de indicadores analisados em todas as dimensões
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS total_indicators_analyzed INTEGER;

COMMENT ON COLUMN knowledge_base.total_indicators_analyzed IS 
'Total de indicadores analisados em todas as dimensões';

-- 10. Adicionar coluna: orchestrator_version
-- Versão do workflow do orquestrador que gerou esta análise
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS orchestrator_version VARCHAR(20);

COMMENT ON COLUMN knowledge_base.orchestrator_version IS 
'Versão do workflow do orquestrador. Exemplo: v2.0, v2.1';

-- 11. Adicionar coluna: execution_time_seconds
-- Tempo total de execução da análise em segundos
ALTER TABLE knowledge_base 
ADD COLUMN IF NOT EXISTS execution_time_seconds NUMERIC;

COMMENT ON COLUMN knowledge_base.execution_time_seconds IS 
'Tempo total de execução da análise em segundos';

-- ============================================================================
-- FASE 3: MIGRAR DADOS EXISTENTES
-- ============================================================================

-- Atualizar registros existentes com valores padrão baseados na estrutura antiga
UPDATE knowledge_base
SET 
    -- Se a coluna 'dimension' existe, usá-la para inferir question_type
    question_type = CASE 
        WHEN dimension IS NOT NULL THEN 'single_dimension'
        ELSE 'unknown'
    END,
    
    -- Criar array de dimensões baseado na coluna 'dimension' existente
    dimensions_analyzed = CASE 
        WHEN dimension = 'economic' THEN ARRAY['economic']::VARCHAR(50)[]
        WHEN dimension = 'social' THEN ARRAY['social']::VARCHAR(50)[]
        WHEN dimension = 'territorial' THEN ARRAY['territorial']::VARCHAR(50)[]
        WHEN dimension = 'environmental' THEN ARRAY['environmental']::VARCHAR(50)[]
        ELSE ARRAY[]::VARCHAR(50)[]
    END,
    
    -- Copiar confidence_score existente para overall_confidence_score
    overall_confidence_score = COALESCE(confidence_score, 0.80),
    
    -- Marcar como gerado por versão legada
    orchestrator_version = 'v1.0-legacy',
    
    -- Copiar summary existente para executive_summary
    executive_summary = summary,
    
    -- Copiar content existente para integrated_analysis (se não houver análise dimensional específica)
    integrated_analysis = content,
    
    -- Adicionar nota sobre migração no metadata
    metadata = COALESCE(metadata, '{}'::jsonb) || 
               jsonb_build_object(
                   'migrated_at', NOW()::text,
                   'migration_version', 'v2.0',
                   'migration_note', 'Dados migrados da estrutura v1.0'
               )

WHERE 
    -- Aplicar apenas a registros que ainda não foram migrados
    question_type IS NULL;

-- ============================================================================
-- FASE 4: ADICIONAR ÍNDICES PARA PERFORMANCE
-- ============================================================================

-- Índice para busca por tipo de pergunta
CREATE INDEX IF NOT EXISTS idx_knowledge_base_question_type 
ON knowledge_base(question_type);

-- Índice para busca por dimensões analisadas (usando GIN para arrays)
CREATE INDEX IF NOT EXISTS idx_knowledge_base_dimensions_analyzed 
ON knowledge_base USING GIN(dimensions_analyzed);

-- Índice para busca por territory_id + question_type (queries comuns)
CREATE INDEX IF NOT EXISTS idx_knowledge_base_territory_question 
ON knowledge_base(territory_id, question_type);

-- Índice para busca em source_analyses (usando GIN para JSONB)
CREATE INDEX IF NOT EXISTS idx_knowledge_base_source_analyses 
ON knowledge_base USING GIN(source_analyses);

-- Índice para busca por data de criação (análises recentes)
CREATE INDEX IF NOT EXISTS idx_knowledge_base_created_at 
ON knowledge_base(created_at DESC);

-- Índice para busca por versão do orquestrador
CREATE INDEX IF NOT EXISTS idx_knowledge_base_orchestrator_version 
ON knowledge_base(orchestrator_version);

-- ============================================================================
-- FASE 5: ADICIONAR CONSTRAINTS E VALIDAÇÕES
-- ============================================================================

-- Constraint: question_type deve ser um valor válido
ALTER TABLE knowledge_base
ADD CONSTRAINT chk_knowledge_base_question_type 
CHECK (question_type IN ('single_dimension', 'multidimensional', 'unknown'));

-- Constraint: dimensions_analyzed não pode ser vazio se question_type != 'unknown'
ALTER TABLE knowledge_base
ADD CONSTRAINT chk_knowledge_base_dimensions_not_empty 
CHECK (
    (question_type = 'unknown') OR 
    (dimensions_analyzed IS NOT NULL AND array_length(dimensions_analyzed, 1) > 0)
);

-- Constraint: overall_confidence_score deve estar entre 0 e 1
ALTER TABLE knowledge_base
ADD CONSTRAINT chk_knowledge_base_confidence_range 
CHECK (overall_confidence_score IS NULL OR (overall_confidence_score >= 0 AND overall_confidence_score <= 1));

-- Constraint: total_indicators_analyzed deve ser positivo
ALTER TABLE knowledge_base
ADD CONSTRAINT chk_knowledge_base_indicators_positive 
CHECK (total_indicators_analyzed IS NULL OR total_indicators_analyzed > 0);

-- Constraint: execution_time_seconds deve ser positivo
ALTER TABLE knowledge_base
ADD CONSTRAINT chk_knowledge_base_execution_time_positive 
CHECK (execution_time_seconds IS NULL OR execution_time_seconds > 0);

-- ============================================================================
-- FASE 6: CRIAR FUNÇÃO AUXILIAR PARA INSERÇÃO
-- ============================================================================

-- Função para facilitar inserção de novos registros com a estrutura v2.0
CREATE OR REPLACE FUNCTION insert_knowledge_base_v2(
    p_territory_id VARCHAR,
    p_original_question TEXT,
    p_question_type VARCHAR(50),
    p_dimensions_analyzed VARCHAR(50)[],
    p_integrated_analysis TEXT,
    p_executive_summary TEXT,
    p_key_insights JSONB,
    p_source_analyses JSONB,
    p_overall_confidence_score NUMERIC,
    p_total_indicators_analyzed INTEGER,
    p_orchestrator_version VARCHAR(20),
    p_execution_time_seconds NUMERIC,
    p_generated_by VARCHAR(100) DEFAULT 'WF-AGENT-ORCHESTRATOR',
    p_metadata JSONB DEFAULT '{}'::jsonb
)
RETURNS UUID AS $$
DECLARE
    v_new_id UUID;
BEGIN
    INSERT INTO knowledge_base (
        territory_id,
        original_question,
        question_type,
        dimensions_analyzed,
        integrated_analysis,
        executive_summary,
        key_insights,
        source_analyses,
        overall_confidence_score,
        total_indicators_analyzed,
        orchestrator_version,
        execution_time_seconds,
        generated_by,
        metadata,
        
        -- Colunas legadas (manter compatibilidade)
        dimension,
        content,
        summary,
        confidence_score,
        embedding,
        
        -- Timestamps
        created_at,
        updated_at
    ) VALUES (
        p_territory_id,
        p_original_question,
        p_question_type,
        p_dimensions_analyzed,
        p_integrated_analysis,
        p_executive_summary,
        p_key_insights,
        p_source_analyses,
        p_overall_confidence_score,
        p_total_indicators_analyzed,
        p_orchestrator_version,
        p_execution_time_seconds,
        p_generated_by,
        p_metadata,
        
        -- Colunas legadas (preencher com valores padrão)
        CASE 
            WHEN array_length(p_dimensions_analyzed, 1) = 1 THEN p_dimensions_analyzed[1]
            ELSE 'multidimensional'
        END,
        p_integrated_analysis,
        p_executive_summary,
        p_overall_confidence_score,
        '', -- embedding vazio por padrão
        
        NOW(),
        NOW()
    )
    RETURNING id INTO v_new_id;
    
    RETURN v_new_id;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION insert_knowledge_base_v2 IS 
'Função auxiliar para inserir registros na knowledge_base com a estrutura v2.0';

-- ============================================================================
-- FASE 7: CRIAR VIEW PARA CONSULTAS SIMPLIFICADAS
-- ============================================================================

-- View para facilitar consultas de análises multidimensionais
CREATE OR REPLACE VIEW v_knowledge_base_multidimensional AS
SELECT 
    kb.id,
    kb.territory_id,
    t.name AS territory_name,
    kb.original_question,
    kb.question_type,
    kb.dimensions_analyzed,
    kb.integrated_analysis,
    kb.executive_summary,
    kb.key_insights,
    kb.source_analyses,
    kb.overall_confidence_score,
    kb.total_indicators_analyzed,
    kb.orchestrator_version,
    kb.execution_time_seconds,
    kb.generated_by,
    kb.created_at,
    
    -- Calcular quantidade de dimensões analisadas
    array_length(kb.dimensions_analyzed, 1) AS dimensions_count,
    
    -- Verificar se tem análise econômica
    'economic' = ANY(kb.dimensions_analyzed) AS has_economic,
    
    -- Verificar se tem análise social
    'social' = ANY(kb.dimensions_analyzed) AS has_social,
    
    -- Verificar se tem análise territorial
    'territorial' = ANY(kb.dimensions_analyzed) AS has_territorial,
    
    -- Verificar se tem análise ambiental
    'environmental' = ANY(kb.dimensions_analyzed) AS has_environmental

FROM knowledge_base kb
LEFT JOIN territories t ON t.id = '' || kb.territory_id
WHERE kb.question_type = 'multidimensional'
ORDER BY kb.created_at DESC;

COMMENT ON VIEW v_knowledge_base_multidimensional IS 
'View para consultas simplificadas de análises multidimensionais';

-- ============================================================================
-- FASE 8: ESTATÍSTICAS E VERIFICAÇÃO
-- ============================================================================

-- Gerar estatísticas sobre a migration
DO $$
DECLARE
    v_total_records INTEGER;
    v_migrated_records INTEGER;
    v_single_dimension INTEGER;
    v_multidimensional INTEGER;
    v_unknown INTEGER;
BEGIN
    -- Contar registros totais
    SELECT COUNT(*) INTO v_total_records FROM knowledge_base;
    
    -- Contar registros migrados
    SELECT COUNT(*) INTO v_migrated_records 
    FROM knowledge_base 
    WHERE question_type IS NOT NULL;
    
    -- Contar por tipo
    SELECT COUNT(*) INTO v_single_dimension 
    FROM knowledge_base 
    WHERE question_type = 'single_dimension';
    
    SELECT COUNT(*) INTO v_multidimensional 
    FROM knowledge_base 
    WHERE question_type = 'multidimensional';
    
    SELECT COUNT(*) INTO v_unknown 
    FROM knowledge_base 
    WHERE question_type = 'unknown';
    
    -- Exibir estatísticas
    RAISE NOTICE '========================================';
    RAISE NOTICE 'MIGRATION CONCLUÍDA COM SUCESSO!';
    RAISE NOTICE '========================================';
    RAISE NOTICE 'Total de registros: %', v_total_records;
    RAISE NOTICE 'Registros migrados: %', v_migrated_records;
    RAISE NOTICE '  - Single dimension: %', v_single_dimension;
    RAISE NOTICE '  - Multidimensional: %', v_multidimensional;
    RAISE NOTICE '  - Unknown: %', v_unknown;
    RAISE NOTICE '========================================';
    RAISE NOTICE 'Backup criado em: knowledge_base_backup_20251202';
    RAISE NOTICE '========================================';
END $$;

-- ============================================================================
-- FASE 9: EXEMPLO DE USO
-- ============================================================================

-- Exemplo de inserção usando a nova função
/*
SELECT insert_knowledge_base_v2(
    p_territory_id := '1721000',
    p_original_question := 'Como está a situação geral de Palmas?',
    p_question_type := 'multidimensional',
    p_dimensions_analyzed := ARRAY['economic', 'social', 'territorial']::VARCHAR(50)[],
    p_integrated_analysis := 'Palmas apresenta crescimento econômico moderado (PIB +3.2%), melhoria nos indicadores sociais (IDH +0.05) e expansão territorial significativa (+12%). A cidade demonstra desenvolvimento equilibrado nas três dimensões analisadas.',
    p_executive_summary := 'Desenvolvimento equilibrado em três dimensões',
    p_key_insights := '{
        "economic": "Crescimento moderado (PIB +3.2%)",
        "social": "Melhoria no IDH (+0.05)",
        "territorial": "Expansão urbana (+12%)"
    }'::jsonb,
    p_source_analyses := '{
        "economic": "uuid-econ-123",
        "social": "uuid-social-456",
        "territorial": "uuid-terra-789"
    }'::jsonb,
    p_overall_confidence_score := 0.88,
    p_total_indicators_analyzed := 15,
    p_orchestrator_version := 'v2.0',
    p_execution_time_seconds := 35.2,
    p_generated_by := 'WF-AGENT-ORCHESTRATOR'
);
*/

-- ============================================================================
-- FASE 10: ROLLBACK (SE NECESSÁRIO)
-- ============================================================================

-- Para reverter a migration, execute:
/*
-- 1. Restaurar dados do backup
TRUNCATE TABLE knowledge_base;
INSERT INTO knowledge_base SELECT * FROM knowledge_base_backup_20251202;

-- 2. Remover colunas adicionadas
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS original_question;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS question_type;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS dimensions_analyzed;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS source_analyses;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS integrated_analysis;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS executive_summary;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS key_insights;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS overall_confidence_score;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS total_indicators_analyzed;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS orchestrator_version;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS execution_time_seconds;

-- 3. Remover índices
DROP INDEX IF EXISTS idx_knowledge_base_question_type;
DROP INDEX IF EXISTS idx_knowledge_base_dimensions_analyzed;
DROP INDEX IF EXISTS idx_knowledge_base_territory_question;
DROP INDEX IF EXISTS idx_knowledge_base_source_analyses;
DROP INDEX IF EXISTS idx_knowledge_base_created_at;
DROP INDEX IF EXISTS idx_knowledge_base_orchestrator_version;

-- 4. Remover função e view
DROP FUNCTION IF EXISTS insert_knowledge_base_v2;
DROP VIEW IF EXISTS v_knowledge_base_multidimensional;

-- 5. Remover tabela de backup
DROP TABLE IF EXISTS knowledge_base_backup_20251202;
*/

-- ============================================================================
-- FIM DA MIGRATION
-- ============================================================================
