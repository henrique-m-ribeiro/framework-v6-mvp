-- ============================================================================
-- FRAMEWORK V6.0 - SISTEMA UNIFICADO DE AUDITORIA
-- Fase 1: Infraestrutura e Curadoria
-- ============================================================================
-- 
-- Esta migração cria a tabela audit_trail para rastreabilidade completa
-- de todas as ações do sistema, garantindo governança e transparência.
--
-- Baseado no Modelo Conceitual RAG Evolutivo v3.0 (Sessão #6)
-- ============================================================================

-- Criar tabela de auditoria se não existir
CREATE TABLE IF NOT EXISTS audit_trail (
    -- Identificação
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id VARCHAR(100) UNIQUE NOT NULL,
    
    -- Tipo e categoria do evento
    event_type VARCHAR(50) NOT NULL,  -- 'generation', 'learning', 'maintenance', 'query', etc.
    event_category VARCHAR(50) NOT NULL,  -- 'rag', 'agent', 'system', 'user', etc.
    
    -- Contexto do evento
    agent_id VARCHAR(50),  -- Agente que executou a ação (econ, social, terra, ambient)
    territory_id VARCHAR(20),  -- Território relacionado (se aplicável)
    user_id VARCHAR(100),  -- Usuário que iniciou a ação (se aplicável)
    
    -- Detalhes da ação
    action VARCHAR(100) NOT NULL,  -- Ação específica executada
    description TEXT,  -- Descrição detalhada do evento
    
    -- Dados do evento
    input_data JSONB,  -- Dados de entrada
    output_data JSONB,  -- Dados de saída
    metadata JSONB,  -- Metadados adicionais
    
    -- Rastreabilidade
    parent_event_id VARCHAR(100),  -- ID do evento pai (para rastrear cadeias)
    root_event_id VARCHAR(100),  -- ID do evento raiz (primeira ação da cadeia)
    
    -- Métricas
    duration_ms INTEGER,  -- Duração da operação em milissegundos
    tokens_used INTEGER,  -- Tokens consumidos (se aplicável)
    cost_usd NUMERIC(10, 6),  -- Custo da operação em USD
    
    -- Status e resultado
    status VARCHAR(20) NOT NULL DEFAULT 'success',  -- 'success', 'error', 'warning'
    error_message TEXT,  -- Mensagem de erro (se aplicável)
    
    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Índices para performance
    CONSTRAINT fk_parent_event FOREIGN KEY (parent_event_id) 
        REFERENCES audit_trail(event_id) ON DELETE SET NULL
);

-- Criar índices para otimizar queries comuns
CREATE INDEX IF NOT EXISTS idx_audit_trail_event_type ON audit_trail(event_type);
CREATE INDEX IF NOT EXISTS idx_audit_trail_event_category ON audit_trail(event_category);
CREATE INDEX IF NOT EXISTS idx_audit_trail_agent_id ON audit_trail(agent_id);
CREATE INDEX IF NOT EXISTS idx_audit_trail_territory_id ON audit_trail(territory_id);
CREATE INDEX IF NOT EXISTS idx_audit_trail_user_id ON audit_trail(user_id);
CREATE INDEX IF NOT EXISTS idx_audit_trail_status ON audit_trail(status);
CREATE INDEX IF NOT EXISTS idx_audit_trail_created_at ON audit_trail(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_audit_trail_parent_event_id ON audit_trail(parent_event_id);
CREATE INDEX IF NOT EXISTS idx_audit_trail_root_event_id ON audit_trail(root_event_id);

-- Criar índice GIN para busca em campos JSONB
CREATE INDEX IF NOT EXISTS idx_audit_trail_metadata_gin ON audit_trail USING GIN (metadata);
CREATE INDEX IF NOT EXISTS idx_audit_trail_input_data_gin ON audit_trail USING GIN (input_data);
CREATE INDEX IF NOT EXISTS idx_audit_trail_output_data_gin ON audit_trail USING GIN (output_data);

-- Comentários para documentação
COMMENT ON TABLE audit_trail IS 'Sistema Unificado de Auditoria - Rastreabilidade completa de todas as ações do Framework V6.0';
COMMENT ON COLUMN audit_trail.event_id IS 'Identificador único do evento (formato: {event_type}_{timestamp}_{uuid})';
COMMENT ON COLUMN audit_trail.event_type IS 'Tipo do evento: generation, learning, maintenance, query, etc.';
COMMENT ON COLUMN audit_trail.event_category IS 'Categoria do evento: rag, agent, system, user, etc.';
COMMENT ON COLUMN audit_trail.parent_event_id IS 'ID do evento pai para rastrear cadeias de eventos';
COMMENT ON COLUMN audit_trail.root_event_id IS 'ID do evento raiz (primeira ação da cadeia)';

-- ============================================================================
-- FIM DA MIGRAÇÃO
-- ============================================================================
