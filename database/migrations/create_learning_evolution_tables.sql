-- ============================================================================
-- Migração: Criar Tabelas de Aprendizagem Evolutiva (Ciclo de Aprendizagem)
-- Data: 2025-11-30
-- Fase: 2 - Implementação do Ciclo de Aprendizagem Evolutiva
-- ============================================================================

-- Descrição:
-- Este script cria as tabelas necessárias para o Ciclo de Aprendizagem Evolutiva,
-- permitindo que os agentes aprendam e evoluam com base em novas análises.
-- 
-- Decisão: Criar novas tabelas específicas para o ciclo evolutivo, mantendo
-- as tabelas originais intactas para evitar quebras no aplicativo existente.

-- ============================================================================
-- 1. Tabela de Aprendizagem Evolutiva do Agente ECON
-- ============================================================================

CREATE TABLE IF NOT EXISTS agent_econ_learning_evolution (
    -- Identificação
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    agent_id VARCHAR(50) NOT NULL DEFAULT 'econ',
    
    -- Tipo de aprendizado
    learning_type VARCHAR(50) NOT NULL,
    -- Valores possíveis: 'synthesis', 'correction', 'refinement', 'pattern_detection'
    
    -- Rastreabilidade
    source_analysis_ids TEXT NOT NULL,
    -- IDs das análises que geraram este aprendizado (separados por vírgula)
    
    -- Conteúdo
    learning_content TEXT NOT NULL,
    -- A síntese ou insight gerado pelo ciclo de aprendizagem
    
    -- Qualidade
    confidence_score NUMERIC(3, 2) NOT NULL CHECK (confidence_score >= 0 AND confidence_score <= 1),
    -- Nível de confiança do aprendizado (0.0 a 1.0)
    
    -- Metadados estruturados
    metadata JSONB DEFAULT '{}'::jsonb,
    -- Estrutura esperada:
    -- {
    --   "redundancias": "...",
    --   "novidades": "...",
    --   "contradicoes": "...",
    --   "territories_affected": ["TO-PALMAS", "TO-ARAGUAINA"],
    --   "indicators_involved": ["PIB", "turismo"],
    --   "archived_analyses_count": 3
    -- }
    
    -- Embedding para busca semântica
    embedding_vector vector(1536),
    -- Embedding do learning_content para busca por similaridade
    
    -- Controle temporal
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    
    -- Status
    is_active BOOLEAN NOT NULL DEFAULT true,
    -- Permite desativar aprendizados que se tornaram obsoletos
    
    -- Aplicação
    times_applied INTEGER NOT NULL DEFAULT 0,
    -- Contador de quantas vezes este aprendizado foi usado em novas análises
    
    last_applied TIMESTAMP
    -- Última vez que este aprendizado foi aplicado
);

-- Índices para otimização de queries
CREATE INDEX IF NOT EXISTS idx_econ_learning_evolution_agent 
    ON agent_econ_learning_evolution(agent_id);

CREATE INDEX IF NOT EXISTS idx_econ_learning_evolution_type 
    ON agent_econ_learning_evolution(learning_type);

CREATE INDEX IF NOT EXISTS idx_econ_learning_evolution_confidence 
    ON agent_econ_learning_evolution(confidence_score DESC);

CREATE INDEX IF NOT EXISTS idx_econ_learning_evolution_created 
    ON agent_econ_learning_evolution(created_at DESC);

CREATE INDEX IF NOT EXISTS idx_econ_learning_evolution_active 
    ON agent_econ_learning_evolution(is_active) 
    WHERE is_active = true;

-- Índice para busca por similaridade de embedding
CREATE INDEX IF NOT EXISTS idx_econ_learning_evolution_embedding 
    ON agent_econ_learning_evolution 
    USING ivfflat (embedding_vector vector_cosine_ops)
    WITH (lists = 100);

-- Índice GIN para busca em metadados JSONB
CREATE INDEX IF NOT EXISTS idx_econ_learning_evolution_metadata 
    ON agent_econ_learning_evolution 
    USING gin (metadata);

-- Comentários na tabela e colunas
COMMENT ON TABLE agent_econ_learning_evolution IS 
'Armazena aprendizados gerados automaticamente pelo Ciclo de Aprendizagem Evolutiva do Agente ECON';

COMMENT ON COLUMN agent_econ_learning_evolution.learning_type IS 
'Tipo de aprendizado: synthesis (síntese de múltiplas análises), correction (correção de análise anterior), refinement (refinamento de conhecimento), pattern_detection (detecção de padrão temporal)';

COMMENT ON COLUMN agent_econ_learning_evolution.source_analysis_ids IS 
'IDs das análises da Camada 1 que foram comparadas para gerar este aprendizado';

COMMENT ON COLUMN agent_econ_learning_evolution.learning_content IS 
'Síntese ou insight gerado pelo LLM após comparar as análises';

COMMENT ON COLUMN agent_econ_learning_evolution.confidence_score IS 
'Nível de confiança do aprendizado, calculado pelo LLM baseado na qualidade e consistência das evidências';

COMMENT ON COLUMN agent_econ_learning_evolution.metadata IS 
'Metadados estruturados incluindo redundâncias, novidades, contradições e territórios afetados';

-- ============================================================================
-- 2. Tabelas para outros agentes (SOCIAL, TERRA, AMBIENT)
-- ============================================================================

-- Tabela para Agente SOCIAL
CREATE TABLE IF NOT EXISTS agent_social_learning_evolution (
    LIKE agent_econ_learning_evolution INCLUDING ALL
);

ALTER TABLE agent_social_learning_evolution 
    ALTER COLUMN agent_id SET DEFAULT 'social';

COMMENT ON TABLE agent_social_learning_evolution IS 
'Armazena aprendizados gerados automaticamente pelo Ciclo de Aprendizagem Evolutiva do Agente SOCIAL';

-- Tabela para Agente TERRA
CREATE TABLE IF NOT EXISTS agent_terra_learning_evolution (
    LIKE agent_econ_learning_evolution INCLUDING ALL
);

ALTER TABLE agent_terra_learning_evolution 
    ALTER COLUMN agent_id SET DEFAULT 'terra';

COMMENT ON TABLE agent_terra_learning_evolution IS 
'Armazena aprendizados gerados automaticamente pelo Ciclo de Aprendizagem Evolutiva do Agente TERRA';

-- Tabela para Agente AMBIENT
CREATE TABLE IF NOT EXISTS agent_ambient_learning_evolution (
    LIKE agent_econ_learning_evolution INCLUDING ALL
);

ALTER TABLE agent_ambient_learning_evolution 
    ALTER COLUMN agent_id SET DEFAULT 'ambient';

COMMENT ON TABLE agent_ambient_learning_evolution IS 
'Armazena aprendizados gerados automaticamente pelo Ciclo de Aprendizagem Evolutiva do Agente AMBIENT';

-- ============================================================================
-- 3. View para consolidar aprendizados de todos os agentes
-- ============================================================================

CREATE OR REPLACE VIEW all_learning_evolution AS
SELECT 'econ' as agent, * FROM agent_econ_learning_evolution
UNION ALL
SELECT 'social' as agent, * FROM agent_social_learning_evolution
UNION ALL
SELECT 'terra' as agent, * FROM agent_terra_learning_evolution
UNION ALL
SELECT 'ambient' as agent, * FROM agent_ambient_learning_evolution;

COMMENT ON VIEW all_learning_evolution IS 
'View consolidada de todos os aprendizados evolutivos de todos os agentes';

-- ============================================================================
-- 4. Função para calcular expertise de um agente
-- ============================================================================

CREATE OR REPLACE FUNCTION get_agent_expertise(p_agent_id VARCHAR)
RETURNS TABLE (
    agent_id VARCHAR,
    learning_count INTEGER,
    expertise_level VARCHAR,
    expertise_value INTEGER
) AS $$
DECLARE
    v_count INTEGER;
    v_level VARCHAR;
    v_value INTEGER;
BEGIN
    -- Contar aprendizados do agente
    EXECUTE format(
        'SELECT COUNT(*) FROM agent_%s_learning_evolution WHERE agent_id = $1',
        p_agent_id
    ) INTO v_count USING p_agent_id;
    
    -- Determinar nível de expertise
    IF v_count <= 10 THEN
        v_level := 'NOVATO';
        v_value := 1;
    ELSIF v_count <= 30 THEN
        v_level := 'COMPETENTE';
        v_value := 2;
    ELSIF v_count <= 60 THEN
        v_level := 'PROFICIENTE';
        v_value := 3;
    ELSIF v_count <= 100 THEN
        v_level := 'AVANCADO';
        v_value := 4;
    ELSE
        v_level := 'ESPECIALISTA';
        v_value := 5;
    END IF;
    
    RETURN QUERY SELECT p_agent_id, v_count, v_level, v_value;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION get_agent_expertise IS 
'Calcula o nível de expertise de um agente baseado no número de ciclos de aprendizagem completados';

-- ============================================================================
-- 5. Validação e Mensagens de Sucesso
-- ============================================================================

DO $$
BEGIN
    RAISE NOTICE '✅ Tabelas de aprendizagem evolutiva criadas com sucesso!';
    RAISE NOTICE '   - agent_econ_learning_evolution';
    RAISE NOTICE '   - agent_social_learning_evolution';
    RAISE NOTICE '   - agent_terra_learning_evolution';
    RAISE NOTICE '   - agent_ambient_learning_evolution';
    RAISE NOTICE '✅ View all_learning_evolution criada';
    RAISE NOTICE '✅ Função get_agent_expertise() criada';
    RAISE NOTICE '';
    RAISE NOTICE '📊 Próximo passo: Executar testes de validação';
END $$;
