-- =====================================================
-- MIGRAÇÃO 003: CRIAÇÃO DO AGENT REGISTRY
-- Framework de Inteligência Territorial V6.0
-- Data: 08/12/2025
-- Versão: 1.0.0
-- Descrição: Cria a tabela agent_registry para descoberta
--            dinâmica de agentes pelo Orquestrador V5.0
-- =====================================================

-- Verificar se a tabela já existe antes de criar
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables 
                   WHERE table_schema = 'public' 
                   AND table_name = 'agent_registry') THEN
        
        -- Criar tabela agent_registry
        CREATE TABLE agent_registry (
            agent_id VARCHAR(50) PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            description TEXT NOT NULL,
            webhook_url VARCHAR(512) NOT NULL,
            is_active BOOLEAN DEFAULT TRUE,
            version VARCHAR(20) DEFAULT '1.0.0',
            created_at TIMESTAMP DEFAULT NOW(),
            updated_at TIMESTAMP DEFAULT NOW(),
            metadata JSONB DEFAULT '{}'::jsonb,
            
            CONSTRAINT unique_agent_id UNIQUE (agent_id)
        );
        
        -- Criar índices para otimização
        CREATE INDEX idx_agent_registry_active ON agent_registry(is_active);
        CREATE INDEX idx_agent_registry_version ON agent_registry(version);
        
        RAISE NOTICE 'Tabela agent_registry criada com sucesso!';
    ELSE
        RAISE NOTICE 'Tabela agent_registry já existe. Pulando criação.';
    END IF;
END $$;

-- Popular com os 4 agentes atuais
-- Usando INSERT ... ON CONFLICT para evitar duplicatas
INSERT INTO agent_registry (agent_id, name, description, webhook_url, is_active, version, metadata) 
VALUES
(
    'economic',
    'Agente Econômico',
    'Especializado em análises econômicas, incluindo PIB, PIB per capita, emprego, desemprego, renda, pobreza, estrutura setorial da economia, investimentos, finanças públicas e indicadores de desenvolvimento econômico.',
    'https://galactic-ai.app.n8n.cloud/webhook/agent-econ',
    TRUE,
    '6.1.0',
    '{"author": "Henrique M. Ribeiro", "tags": ["economy", "employment", "income"], "created_in_session": 13}'::jsonb
),
(
    'social',
    'Agente Social',
    'Especializado em análises sociais, incluindo educação (matrículas, IDEB, analfabetismo), saúde (mortalidade infantil, leitos hospitalares, cobertura vacinal), IDH, IDHM, desigualdade social, programas sociais e qualidade de vida.',
    'https://galactic-ai.app.n8n.cloud/webhook/agent-social',
    TRUE,
    '6.1.0',
    '{"author": "Henrique M. Ribeiro", "tags": ["education", "health", "social"], "created_in_session": 13}'::jsonb
),
(
    'terra',
    'Agente Territorial',
    'Especializado em análises territoriais e de infraestrutura, incluindo urbanização, saneamento básico, mobilidade urbana, habitação, uso e ocupação do solo, planejamento urbano e infraestrutura de transportes.',
    'https://galactic-ai.app.n8n.cloud/webhook/agent-terra',
    TRUE,
    '6.1.0',
    '{"author": "Henrique M. Ribeiro", "tags": ["urban", "infrastructure", "housing"], "created_in_session": 13}'::jsonb
),
(
    'ambient',
    'Agente Ambiental',
    'Especializado em análises ambientais, incluindo desmatamento, queimadas, recursos hídricos, unidades de conservação, biodiversidade, mudanças climáticas, gestão de resíduos e sustentabilidade ambiental.',
    'https://galactic-ai.app.n8n.cloud/webhook/agent-ambient',
    TRUE,
    '6.1.0',
    '{"author": "Henrique M. Ribeiro", "tags": ["environment", "sustainability", "conservation"], "created_in_session": 13}'::jsonb
)
ON CONFLICT (agent_id) 
DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    webhook_url = EXCLUDED.webhook_url,
    is_active = EXCLUDED.is_active,
    version = EXCLUDED.version,
    updated_at = NOW(),
    metadata = EXCLUDED.metadata;

-- Verificar dados inseridos
SELECT 
    agent_id,
    name,
    is_active,
    version,
    webhook_url
FROM agent_registry 
ORDER BY agent_id;

-- Exibir estatísticas
SELECT 
    COUNT(*) as total_agents,
    COUNT(*) FILTER (WHERE is_active = TRUE) as active_agents,
    COUNT(*) FILTER (WHERE is_active = FALSE) as inactive_agents
FROM agent_registry;

-- =====================================================
-- FIM DA MIGRAÇÃO 003
-- =====================================================
