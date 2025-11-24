-- ========================================
-- FRAMEWORK DE INTELIGÊNCIA TERRITORIAL V6.0
-- SCRIPT DE CRIAÇÃO: MEMÓRIA DISTRIBUÍDA POR AGENTE
-- ========================================
-- Data: 24 de novembro de 2025
-- Autor: Manus AI
-- Versão: 1.0.0
--
-- OBJETIVO:
-- Criar estrutura de banco de dados para memória individual
-- de cada agente especialista, permitindo que evoluam como
-- especialistas humanos ao longo do tempo.
--
-- ARQUITETURA:
-- - 4 tabelas de memória individual (agent_*_memory)
-- - 4 tabelas de aprendizado (agent_*_learning)
-- - Índices IVFFlat para busca vetorial semântica
-- - Triggers para atualização automática de timestamps
-- ========================================

-- ========================================
-- EXTENSÕES NECESSÁRIAS
-- ========================================

-- Verificar se pgvector está instalado
CREATE EXTENSION IF NOT EXISTS vector;

-- Verificar se uuid-ossp está instalado
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ========================================
-- 1. AGENTE ECONÔMICO (ECON)
-- ========================================

-- 1.1 Tabela de Memória Individual
CREATE TABLE IF NOT EXISTS agent_econ_memory (
  -- Identificação
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  territory_id VARCHAR(20) NOT NULL,
  
  -- Conteúdo da análise
  analysis_content TEXT NOT NULL,
  analysis_summary TEXT NOT NULL,
  
  -- Embedding para busca semântica (1536 dimensões = text-embedding-3-small)
  embedding_vector vector(1536) NOT NULL,
  
  -- Metadados da análise
  metadata JSONB NOT NULL DEFAULT '{}',
  
  -- Aprendizado e evolução
  confidence_score NUMERIC(3,2) CHECK (confidence_score >= 0 AND confidence_score <= 1),
  user_feedback JSONB DEFAULT '{}',
  iterations INTEGER DEFAULT 1,
  
  -- Contexto temporal
  analysis_date DATE NOT NULL,
  time_range JSONB NOT NULL, -- {"start": "2019", "end": "2023"}
  
  -- Fontes e rastreabilidade
  data_sources JSONB NOT NULL,
  indicators_used JSONB NOT NULL,
  
  -- Versionamento
  version INTEGER DEFAULT 1,
  is_latest BOOLEAN DEFAULT true,
  superseded_by UUID REFERENCES agent_econ_memory(id),
  
  -- Auditoria
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  generated_by VARCHAR(100) DEFAULT 'WF-AGENT-ECON',
  
  -- Constraint de unicidade
  CONSTRAINT unique_econ_analysis UNIQUE (territory_id, analysis_date, version)
);

-- Comentários nas colunas
COMMENT ON TABLE agent_econ_memory IS 'Memória individual do Agente Econômico - armazena todas as análises econômicas geradas para busca semântica e aprendizado';
COMMENT ON COLUMN agent_econ_memory.embedding_vector IS 'Vetor de embedding (1536 dim) gerado por text-embedding-3-small para busca semântica';
COMMENT ON COLUMN agent_econ_memory.confidence_score IS 'Score de confiança da análise (0.0 a 1.0), aumenta com aprendizado';
COMMENT ON COLUMN agent_econ_memory.iterations IS 'Número de vezes que este território foi analisado (indica especialização)';

-- 1.2 Índices para Agente ECON
-- Índice para busca vetorial (IVFFlat - mais rápido para datasets médios)
CREATE INDEX IF NOT EXISTS idx_econ_memory_embedding 
ON agent_econ_memory 
USING ivfflat (embedding_vector vector_cosine_ops)
WITH (lists = 100);

-- Índice para busca por território
CREATE INDEX IF NOT EXISTS idx_econ_memory_territory 
ON agent_econ_memory (territory_id);

-- Índice para busca temporal
CREATE INDEX IF NOT EXISTS idx_econ_memory_date 
ON agent_econ_memory (analysis_date DESC);

-- Índice para busca em metadados
CREATE INDEX IF NOT EXISTS idx_econ_memory_metadata 
ON agent_econ_memory USING gin (metadata);

-- Índice para busca de versões mais recentes
CREATE INDEX IF NOT EXISTS idx_econ_memory_latest 
ON agent_econ_memory (is_latest) WHERE is_latest = true;

-- 1.3 Tabela de Aprendizado do Agente ECON
CREATE TABLE IF NOT EXISTS agent_econ_learning (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  
  -- Tipo de aprendizado
  learning_type VARCHAR(50) NOT NULL, 
  -- Valores possíveis: 'pattern', 'insight', 'methodology', 'error_correction', 'best_practice'
  
  -- Conteúdo do aprendizado
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  
  -- Contexto
  territories_analyzed INTEGER DEFAULT 0,
  confidence NUMERIC(3,2) CHECK (confidence >= 0 AND confidence <= 1),
  
  -- Aplicabilidade
  applicable_to JSONB DEFAULT '{}', -- Condições para aplicar este aprendizado
  
  -- Exemplos
  examples JSONB DEFAULT '[]', -- Lista de exemplos onde este aprendizado se aplica
  
  -- Embedding para busca semântica
  embedding_vector vector(1536),
  
  -- Auditoria
  created_at TIMESTAMP DEFAULT NOW(),
  last_applied TIMESTAMP,
  times_applied INTEGER DEFAULT 0,
  
  -- Status
  is_active BOOLEAN DEFAULT true
);

COMMENT ON TABLE agent_econ_learning IS 'Aprendizados acumulados pelo Agente Econômico ao longo do tempo';
COMMENT ON COLUMN agent_econ_learning.learning_type IS 'Tipo: pattern (padrão identificado), insight (insight único), methodology (melhoria de processo), error_correction (correção de erro), best_practice (boa prática)';

-- Índices para Aprendizado ECON
CREATE INDEX IF NOT EXISTS idx_econ_learning_embedding 
ON agent_econ_learning 
USING ivfflat (embedding_vector vector_cosine_ops)
WITH (lists = 50);

CREATE INDEX IF NOT EXISTS idx_econ_learning_type 
ON agent_econ_learning (learning_type);

CREATE INDEX IF NOT EXISTS idx_econ_learning_active 
ON agent_econ_learning (is_active) WHERE is_active = true;

-- ========================================
-- 2. AGENTE SOCIAL (SOCIAL)
-- ========================================

-- 2.1 Tabela de Memória Individual
CREATE TABLE IF NOT EXISTS agent_social_memory (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  territory_id VARCHAR(20) NOT NULL,
  analysis_content TEXT NOT NULL,
  analysis_summary TEXT NOT NULL,
  embedding_vector vector(1536) NOT NULL,
  metadata JSONB NOT NULL DEFAULT '{}',
  confidence_score NUMERIC(3,2) CHECK (confidence_score >= 0 AND confidence_score <= 1),
  user_feedback JSONB DEFAULT '{}',
  iterations INTEGER DEFAULT 1,
  analysis_date DATE NOT NULL,
  time_range JSONB NOT NULL,
  data_sources JSONB NOT NULL,
  indicators_used JSONB NOT NULL,
  version INTEGER DEFAULT 1,
  is_latest BOOLEAN DEFAULT true,
  superseded_by UUID REFERENCES agent_social_memory(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  generated_by VARCHAR(100) DEFAULT 'WF-AGENT-SOCIAL',
  CONSTRAINT unique_social_analysis UNIQUE (territory_id, analysis_date, version)
);

COMMENT ON TABLE agent_social_memory IS 'Memória individual do Agente Social - armazena análises sociais para busca semântica e aprendizado';

-- 2.2 Índices para Agente SOCIAL
CREATE INDEX IF NOT EXISTS idx_social_memory_embedding 
ON agent_social_memory 
USING ivfflat (embedding_vector vector_cosine_ops)
WITH (lists = 100);

CREATE INDEX IF NOT EXISTS idx_social_memory_territory 
ON agent_social_memory (territory_id);

CREATE INDEX IF NOT EXISTS idx_social_memory_date 
ON agent_social_memory (analysis_date DESC);

CREATE INDEX IF NOT EXISTS idx_social_memory_metadata 
ON agent_social_memory USING gin (metadata);

CREATE INDEX IF NOT EXISTS idx_social_memory_latest 
ON agent_social_memory (is_latest) WHERE is_latest = true;

-- 2.3 Tabela de Aprendizado do Agente SOCIAL
CREATE TABLE IF NOT EXISTS agent_social_learning (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  learning_type VARCHAR(50) NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  territories_analyzed INTEGER DEFAULT 0,
  confidence NUMERIC(3,2) CHECK (confidence >= 0 AND confidence <= 1),
  applicable_to JSONB DEFAULT '{}',
  examples JSONB DEFAULT '[]',
  embedding_vector vector(1536),
  created_at TIMESTAMP DEFAULT NOW(),
  last_applied TIMESTAMP,
  times_applied INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true
);

COMMENT ON TABLE agent_social_learning IS 'Aprendizados acumulados pelo Agente Social ao longo do tempo';

-- Índices para Aprendizado SOCIAL
CREATE INDEX IF NOT EXISTS idx_social_learning_embedding 
ON agent_social_learning 
USING ivfflat (embedding_vector vector_cosine_ops)
WITH (lists = 50);

CREATE INDEX IF NOT EXISTS idx_social_learning_type 
ON agent_social_learning (learning_type);

CREATE INDEX IF NOT EXISTS idx_social_learning_active 
ON agent_social_learning (is_active) WHERE is_active = true;

-- ========================================
-- 3. AGENTE TERRITORIAL (TERRA)
-- ========================================

-- 3.1 Tabela de Memória Individual
CREATE TABLE IF NOT EXISTS agent_terra_memory (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  territory_id VARCHAR(20) NOT NULL,
  analysis_content TEXT NOT NULL,
  analysis_summary TEXT NOT NULL,
  embedding_vector vector(1536) NOT NULL,
  metadata JSONB NOT NULL DEFAULT '{}',
  confidence_score NUMERIC(3,2) CHECK (confidence_score >= 0 AND confidence_score <= 1),
  user_feedback JSONB DEFAULT '{}',
  iterations INTEGER DEFAULT 1,
  analysis_date DATE NOT NULL,
  time_range JSONB NOT NULL,
  data_sources JSONB NOT NULL,
  indicators_used JSONB NOT NULL,
  version INTEGER DEFAULT 1,
  is_latest BOOLEAN DEFAULT true,
  superseded_by UUID REFERENCES agent_terra_memory(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  generated_by VARCHAR(100) DEFAULT 'WF-AGENT-TERRA',
  CONSTRAINT unique_terra_analysis UNIQUE (territory_id, analysis_date, version)
);

COMMENT ON TABLE agent_terra_memory IS 'Memória individual do Agente Territorial - armazena análises territoriais para busca semântica e aprendizado';

-- 3.2 Índices para Agente TERRA
CREATE INDEX IF NOT EXISTS idx_terra_memory_embedding 
ON agent_terra_memory 
USING ivfflat (embedding_vector vector_cosine_ops)
WITH (lists = 100);

CREATE INDEX IF NOT EXISTS idx_terra_memory_territory 
ON agent_terra_memory (territory_id);

CREATE INDEX IF NOT EXISTS idx_terra_memory_date 
ON agent_terra_memory (analysis_date DESC);

CREATE INDEX IF NOT EXISTS idx_terra_memory_metadata 
ON agent_terra_memory USING gin (metadata);

CREATE INDEX IF NOT EXISTS idx_terra_memory_latest 
ON agent_terra_memory (is_latest) WHERE is_latest = true;

-- 3.3 Tabela de Aprendizado do Agente TERRA
CREATE TABLE IF NOT EXISTS agent_terra_learning (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  learning_type VARCHAR(50) NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  territories_analyzed INTEGER DEFAULT 0,
  confidence NUMERIC(3,2) CHECK (confidence >= 0 AND confidence <= 1),
  applicable_to JSONB DEFAULT '{}',
  examples JSONB DEFAULT '[]',
  embedding_vector vector(1536),
  created_at TIMESTAMP DEFAULT NOW(),
  last_applied TIMESTAMP,
  times_applied INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true
);

COMMENT ON TABLE agent_terra_learning IS 'Aprendizados acumulados pelo Agente Territorial ao longo do tempo';

-- Índices para Aprendizado TERRA
CREATE INDEX IF NOT EXISTS idx_terra_learning_embedding 
ON agent_terra_learning 
USING ivfflat (embedding_vector vector_cosine_ops)
WITH (lists = 50);

CREATE INDEX IF NOT EXISTS idx_terra_learning_type 
ON agent_terra_learning (learning_type);

CREATE INDEX IF NOT EXISTS idx_terra_learning_active 
ON agent_terra_learning (is_active) WHERE is_active = true;

-- ========================================
-- 4. AGENTE AMBIENTAL (AMBIENT)
-- ========================================

-- 4.1 Tabela de Memória Individual
CREATE TABLE IF NOT EXISTS agent_ambient_memory (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  territory_id VARCHAR(20) NOT NULL,
  analysis_content TEXT NOT NULL,
  analysis_summary TEXT NOT NULL,
  embedding_vector vector(1536) NOT NULL,
  metadata JSONB NOT NULL DEFAULT '{}',
  confidence_score NUMERIC(3,2) CHECK (confidence_score >= 0 AND confidence_score <= 1),
  user_feedback JSONB DEFAULT '{}',
  iterations INTEGER DEFAULT 1,
  analysis_date DATE NOT NULL,
  time_range JSONB NOT NULL,
  data_sources JSONB NOT NULL,
  indicators_used JSONB NOT NULL,
  version INTEGER DEFAULT 1,
  is_latest BOOLEAN DEFAULT true,
  superseded_by UUID REFERENCES agent_ambient_memory(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  generated_by VARCHAR(100) DEFAULT 'WF-AGENT-AMBIENT',
  CONSTRAINT unique_ambient_analysis UNIQUE (territory_id, analysis_date, version)
);

COMMENT ON TABLE agent_ambient_memory IS 'Memória individual do Agente Ambiental - armazena análises ambientais para busca semântica e aprendizado';

-- 4.2 Índices para Agente AMBIENT
CREATE INDEX IF NOT EXISTS idx_ambient_memory_embedding 
ON agent_ambient_memory 
USING ivfflat (embedding_vector vector_cosine_ops)
WITH (lists = 100);

CREATE INDEX IF NOT EXISTS idx_ambient_memory_territory 
ON agent_ambient_memory (territory_id);

CREATE INDEX IF NOT EXISTS idx_ambient_memory_date 
ON agent_ambient_memory (analysis_date DESC);

CREATE INDEX IF NOT EXISTS idx_ambient_memory_metadata 
ON agent_ambient_memory USING gin (metadata);

CREATE INDEX IF NOT EXISTS idx_ambient_memory_latest 
ON agent_ambient_memory (is_latest) WHERE is_latest = true;

-- 4.3 Tabela de Aprendizado do Agente AMBIENT
CREATE TABLE IF NOT EXISTS agent_ambient_learning (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  learning_type VARCHAR(50) NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  territories_analyzed INTEGER DEFAULT 0,
  confidence NUMERIC(3,2) CHECK (confidence >= 0 AND confidence <= 1),
  applicable_to JSONB DEFAULT '{}',
  examples JSONB DEFAULT '[]',
  embedding_vector vector(1536),
  created_at TIMESTAMP DEFAULT NOW(),
  last_applied TIMESTAMP,
  times_applied INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true
);

COMMENT ON TABLE agent_ambient_learning IS 'Aprendizados acumulados pelo Agente Ambiental ao longo do tempo';

-- Índices para Aprendizado AMBIENT
CREATE INDEX IF NOT EXISTS idx_ambient_learning_embedding 
ON agent_ambient_learning 
USING ivfflat (embedding_vector vector_cosine_ops)
WITH (lists = 50);

CREATE INDEX IF NOT EXISTS idx_ambient_learning_type 
ON agent_ambient_learning (learning_type);

CREATE INDEX IF NOT EXISTS idx_ambient_learning_active 
ON agent_ambient_learning (is_active) WHERE is_active = true;

-- ========================================
-- 5. TRIGGERS PARA ATUALIZAÇÃO AUTOMÁTICA
-- ========================================

-- Função para atualizar timestamp automaticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers para cada tabela de memória
CREATE TRIGGER update_agent_econ_memory_updated_at
BEFORE UPDATE ON agent_econ_memory
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_agent_social_memory_updated_at
BEFORE UPDATE ON agent_social_memory
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_agent_terra_memory_updated_at
BEFORE UPDATE ON agent_terra_memory
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_agent_ambient_memory_updated_at
BEFORE UPDATE ON agent_ambient_memory
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ========================================
-- 6. VIEWS ÚTEIS PARA ANÁLISE
-- ========================================

-- View: Estatísticas de memória por agente
CREATE OR REPLACE VIEW v_agent_memory_stats AS
SELECT 
  'ECON' as agent,
  COUNT(*) as total_analyses,
  COUNT(DISTINCT territory_id) as territories_analyzed,
  AVG(confidence_score) as avg_confidence,
  MAX(analysis_date) as last_analysis_date
FROM agent_econ_memory
WHERE is_latest = true
UNION ALL
SELECT 
  'SOCIAL' as agent,
  COUNT(*) as total_analyses,
  COUNT(DISTINCT territory_id) as territories_analyzed,
  AVG(confidence_score) as avg_confidence,
  MAX(analysis_date) as last_analysis_date
FROM agent_social_memory
WHERE is_latest = true
UNION ALL
SELECT 
  'TERRA' as agent,
  COUNT(*) as total_analyses,
  COUNT(DISTINCT territory_id) as territories_analyzed,
  AVG(confidence_score) as avg_confidence,
  MAX(analysis_date) as last_analysis_date
FROM agent_terra_memory
WHERE is_latest = true
UNION ALL
SELECT 
  'AMBIENT' as agent,
  COUNT(*) as total_analyses,
  COUNT(DISTINCT territory_id) as territories_analyzed,
  AVG(confidence_score) as avg_confidence,
  MAX(analysis_date) as last_analysis_date
FROM agent_ambient_memory
WHERE is_latest = true;

-- View: Aprendizados ativos por agente
CREATE OR REPLACE VIEW v_agent_learning_stats AS
SELECT 
  'ECON' as agent,
  learning_type,
  COUNT(*) as total_learnings,
  AVG(confidence) as avg_confidence,
  SUM(times_applied) as total_applications
FROM agent_econ_learning
WHERE is_active = true
GROUP BY learning_type
UNION ALL
SELECT 
  'SOCIAL' as agent,
  learning_type,
  COUNT(*) as total_learnings,
  AVG(confidence) as avg_confidence,
  SUM(times_applied) as total_applications
FROM agent_social_learning
WHERE is_active = true
GROUP BY learning_type
UNION ALL
SELECT 
  'TERRA' as agent,
  learning_type,
  COUNT(*) as total_learnings,
  AVG(confidence) as avg_confidence,
  SUM(times_applied) as total_applications
FROM agent_terra_learning
WHERE is_active = true
GROUP BY learning_type
UNION ALL
SELECT 
  'AMBIENT' as agent,
  learning_type,
  COUNT(*) as total_learnings,
  AVG(confidence) as avg_confidence,
  SUM(times_applied) as total_applications
FROM agent_ambient_learning
WHERE is_active = true
GROUP BY learning_type;

-- ========================================
-- 7. FUNÇÕES AUXILIARES
-- ========================================

-- Função para buscar análises similares na memória de um agente
CREATE OR REPLACE FUNCTION search_agent_memory(
  p_agent VARCHAR(20),
  p_query_embedding vector(1536),
  p_limit INTEGER DEFAULT 5
)
RETURNS TABLE (
  id UUID,
  territory_id VARCHAR(20),
  analysis_summary TEXT,
  confidence_score NUMERIC,
  similarity FLOAT
) AS $$
BEGIN
  RETURN QUERY EXECUTE format(
    'SELECT 
      id,
      territory_id,
      analysis_summary,
      confidence_score,
      1 - (embedding_vector <=> $1) as similarity
    FROM agent_%s_memory
    WHERE is_latest = true
    ORDER BY embedding_vector <=> $1
    LIMIT $2',
    lower(p_agent)
  )
  USING p_query_embedding, p_limit;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION search_agent_memory IS 'Busca análises similares na memória de um agente específico usando busca vetorial';

-- ========================================
-- 8. VERIFICAÇÃO FINAL
-- ========================================

-- Listar todas as tabelas criadas
SELECT 
  tablename,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE tablename LIKE 'agent_%'
ORDER BY tablename;

-- Listar todos os índices criados
SELECT 
  indexname,
  tablename,
  indexdef
FROM pg_indexes
WHERE tablename LIKE 'agent_%'
ORDER BY tablename, indexname;

-- ========================================
-- FIM DO SCRIPT
-- ========================================

-- Mensagem de sucesso
DO $$
BEGIN
  RAISE NOTICE '✅ Estrutura de memória distribuída criada com sucesso!';
  RAISE NOTICE '📊 4 tabelas de memória individual (agent_*_memory)';
  RAISE NOTICE '🧠 4 tabelas de aprendizado (agent_*_learning)';
  RAISE NOTICE '🔍 Índices IVFFlat para busca vetorial configurados';
  RAISE NOTICE '⚡ Triggers de atualização automática ativados';
  RAISE NOTICE '📈 Views de estatísticas criadas';
  RAISE NOTICE '🚀 Sistema pronto para Fase 2!';
END $$;
