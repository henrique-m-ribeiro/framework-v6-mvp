-- ============================================
-- MIGRAÇÃO 004: Tabela knowledge_base
-- Framework de Inteligência Territorial V6.0
-- Data: 16 de novembro de 2025
-- ============================================

-- FUNÇÃO: Criar tabela para armazenar análises geradas pelos agentes
-- Esta tabela é o coração do sistema de cache e RAG do Framework

-- ============================================
-- 1. CRIAR EXTENSÃO PGVECTOR (se não existir)
-- ============================================
-- pgvector permite armazenar embeddings vetoriais para busca semântica

CREATE EXTENSION IF NOT EXISTS vector;

COMMENT ON EXTENSION vector IS 'Extensão para armazenar e consultar embeddings vetoriais (RAG)';

-- ============================================
-- 2. CRIAR TABELA knowledge_base
-- ============================================

CREATE TABLE IF NOT EXISTS knowledge_base (
  -- Identificação
  id SERIAL PRIMARY KEY,
  territory_id INTEGER NOT NULL REFERENCES territories(id) ON DELETE CASCADE,
  
  -- Classificação da análise
  dimension VARCHAR(50) NOT NULL CHECK (dimension IN ('economic', 'social', 'territorial', 'environmental')),
  analysis_type VARCHAR(50) NOT NULL CHECK (analysis_type IN ('single', 'comparative', 'temporal', 'integrated')),
  
  -- Conteúdo da análise
  content TEXT NOT NULL,
  summary TEXT NOT NULL,
  key_insights JSONB,
  
  -- Metadados
  metadata JSONB,
  
  -- Embedding vetorial para RAG (1536 dimensões = OpenAI text-embedding-3-small)
  embedding VECTOR(1536),
  
  -- Auditoria
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  
  -- Constraint de unicidade: apenas 1 análise por (território, dimensão, tipo)
  CONSTRAINT unique_analysis UNIQUE (territory_id, dimension, analysis_type)
);

-- ============================================
-- 3. COMENTÁRIOS DESCRITIVOS
-- ============================================

COMMENT ON TABLE knowledge_base IS 'Armazena análises geradas pelos agentes dimensionais (ECON, SOCIAL, TERRA, AMBIENT)';

COMMENT ON COLUMN knowledge_base.id IS 'ID único da análise';
COMMENT ON COLUMN knowledge_base.territory_id IS 'ID do território analisado (FK para territories)';
COMMENT ON COLUMN knowledge_base.dimension IS 'Dimensão da análise: economic, social, territorial, environmental';
COMMENT ON COLUMN knowledge_base.analysis_type IS 'Tipo de análise: single (1 território), comparative (2+), temporal (evolução), integrated (múltiplas dimensões)';
COMMENT ON COLUMN knowledge_base.content IS 'Texto completo da análise em Markdown';
COMMENT ON COLUMN knowledge_base.summary IS 'Resumo executivo da análise (2-3 frases)';
COMMENT ON COLUMN knowledge_base.key_insights IS 'Insights principais em formato JSON estruturado';
COMMENT ON COLUMN knowledge_base.metadata IS 'Metadados da análise (fontes, modelo, confiança, tempo de processamento, etc.)';
COMMENT ON COLUMN knowledge_base.embedding IS 'Embedding vetorial (1536 dimensões) para busca semântica (RAG)';
COMMENT ON COLUMN knowledge_base.created_at IS 'Data/hora de criação da análise';
COMMENT ON COLUMN knowledge_base.updated_at IS 'Data/hora da última atualização';

-- ============================================
-- 4. ÍNDICES PARA PERFORMANCE
-- ============================================

-- Índice para busca por território e dimensão (consulta mais comum)
CREATE INDEX IF NOT EXISTS idx_knowledge_base_territory_dimension 
ON knowledge_base(territory_id, dimension);

-- Índice para busca por tipo de análise
CREATE INDEX IF NOT EXISTS idx_knowledge_base_analysis_type 
ON knowledge_base(analysis_type);

-- Índice para busca por data de atualização (análises mais recentes)
CREATE INDEX IF NOT EXISTS idx_knowledge_base_updated_at 
ON knowledge_base(updated_at DESC);

-- Índice GIN para busca em key_insights (JSONB)
CREATE INDEX IF NOT EXISTS idx_knowledge_base_key_insights 
ON knowledge_base USING GIN (key_insights);

-- Índice GIN para busca em metadata (JSONB)
CREATE INDEX IF NOT EXISTS idx_knowledge_base_metadata 
ON knowledge_base USING GIN (metadata);

-- Índice IVFFLAT para busca de similaridade vetorial (RAG)
-- NOTA: Este índice só funciona após inserir alguns embeddings
-- Será criado manualmente após popular a tabela
-- CREATE INDEX idx_knowledge_base_embedding ON knowledge_base 
-- USING ivfflat (embedding vector_cosine_ops) WITH (lists = 100);

-- ============================================
-- 5. FUNÇÃO PARA ATUALIZAR updated_at AUTOMATICAMENTE
-- ============================================

CREATE OR REPLACE FUNCTION update_knowledge_base_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para atualizar updated_at em cada UPDATE
DROP TRIGGER IF EXISTS trigger_update_knowledge_base_updated_at ON knowledge_base;
CREATE TRIGGER trigger_update_knowledge_base_updated_at
BEFORE UPDATE ON knowledge_base
FOR EACH ROW
EXECUTE FUNCTION update_knowledge_base_updated_at();

-- ============================================
-- 6. VIEWS ÚTEIS
-- ============================================

-- View: Análises mais recentes por dimensão
CREATE OR REPLACE VIEW v_latest_analyses AS
SELECT 
  kb.id,
  t.name AS territory_name,
  kb.dimension,
  kb.analysis_type,
  kb.summary,
  kb.updated_at,
  kb.metadata->>'model_used' AS model_used,
  kb.metadata->>'confidence_score' AS confidence_score
FROM knowledge_base kb
JOIN territories t ON kb.territory_id = t.id
ORDER BY kb.updated_at DESC;

COMMENT ON VIEW v_latest_analyses IS 'Lista as análises mais recentes com informações básicas';

-- View: Estatísticas da base de conhecimento
CREATE OR REPLACE VIEW v_knowledge_base_stats AS
SELECT 
  dimension,
  analysis_type,
  COUNT(*) AS total_analyses,
  COUNT(embedding) AS analyses_with_embedding,
  AVG((metadata->>'confidence_score')::FLOAT) AS avg_confidence,
  MAX(updated_at) AS last_update
FROM knowledge_base
GROUP BY dimension, analysis_type
ORDER BY dimension, analysis_type;

COMMENT ON VIEW v_knowledge_base_stats IS 'Estatísticas agregadas da base de conhecimento por dimensão e tipo';

-- ============================================
-- 7. FUNÇÕES ÚTEIS PARA RAG
-- ============================================

-- Função: Buscar análises similares por embedding (similaridade de cosseno)
CREATE OR REPLACE FUNCTION search_similar_analyses(
  query_embedding VECTOR(1536),
  similarity_threshold FLOAT DEFAULT 0.7,
  max_results INTEGER DEFAULT 5
)
RETURNS TABLE (
  id INTEGER,
  territory_id INTEGER,
  territory_name VARCHAR,
  dimension VARCHAR,
  summary TEXT,
  similarity FLOAT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    kb.id,
    kb.territory_id,
    t.name AS territory_name,
    kb.dimension,
    kb.summary,
    1 - (kb.embedding <=> query_embedding) AS similarity
  FROM knowledge_base kb
  JOIN territories t ON kb.territory_id = t.id
  WHERE kb.embedding IS NOT NULL
    AND 1 - (kb.embedding <=> query_embedding) >= similarity_threshold
  ORDER BY kb.embedding <=> query_embedding
  LIMIT max_results;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION search_similar_analyses IS 'Busca análises similares usando similaridade de cosseno de embeddings';

-- Função: Buscar análises por território e dimensão
CREATE OR REPLACE FUNCTION get_territory_analysis(
  p_territory_id INTEGER,
  p_dimension VARCHAR DEFAULT NULL
)
RETURNS TABLE (
  id INTEGER,
  dimension VARCHAR,
  analysis_type VARCHAR,
  content TEXT,
  summary TEXT,
  key_insights JSONB,
  updated_at TIMESTAMP
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    kb.id,
    kb.dimension,
    kb.analysis_type,
    kb.content,
    kb.summary,
    kb.key_insights,
    kb.updated_at
  FROM knowledge_base kb
  WHERE kb.territory_id = p_territory_id
    AND (p_dimension IS NULL OR kb.dimension = p_dimension)
  ORDER BY kb.updated_at DESC;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION get_territory_analysis IS 'Retorna análises de um território, opcionalmente filtradas por dimensão';

-- ============================================
-- 8. DADOS DE EXEMPLO (OPCIONAL - APENAS PARA TESTES)
-- ============================================

-- Inserir análise de exemplo para Palmas (apenas se não existir)
INSERT INTO knowledge_base (
  territory_id,
  dimension,
  analysis_type,
  content,
  summary,
  key_insights,
  metadata
)
SELECT 
  1, -- Palmas
  'economic',
  'single',
  '**RESUMO EXECUTIVO**

Palmas apresentou crescimento econômico consistente nos últimos 5 anos, com PIB aumentando 13,6% e desemprego caindo 1,7 p.p. A economia é fortemente baseada em serviços (68%), refletindo o papel da capital como centro administrativo e comercial.

**PRINCIPAIS TENDÊNCIAS**
• PIB cresceu 13,6% no período 2019-2023
• Desemprego caiu de 8,2% para 6,5%
• Setor de serviços domina com 68% do PIB

**PONTOS FORTES**
• Crescimento acima da média estadual
• Redução do desemprego em período pós-pandemia
• Diversificação setorial superior a municípios do interior

**DESAFIOS E VULNERABILIDADES**
• Dependência excessiva do setor público (28% do PIB)
• Indústria incipiente (22% do PIB)
• Salário médio 15% abaixo da média nacional

**RECOMENDAÇÕES PRIORITÁRIAS**
1. Atrair investimentos industriais (incentivos fiscais, infraestrutura)
2. Diversificar economia para reduzir dependência do setor público
3. Investir em qualificação profissional para aumentar produtividade',
  'Palmas apresentou crescimento econômico consistente nos últimos 5 anos, com PIB aumentando 13,6% e desemprego caindo 1,7 p.p.',
  '{"gdp_growth": 13.6, "gdp_per_capita_growth": 8.3, "unemployment_change": -1.7, "sector_composition": {"agriculture": 10, "industry": 22, "services": 68}, "transfer_dependence": 45, "investment_capacity": 12}'::JSONB,
  '{"data_sources": ["IBGE", "SICONFI", "RAIS"], "time_range": "2019-2023", "years_analyzed": 5, "last_data_update": 2023, "model_used": "gpt-4o-mini", "confidence_score": 0.92}'::JSONB
WHERE NOT EXISTS (
  SELECT 1 FROM knowledge_base 
  WHERE territory_id = 1 AND dimension = 'economic' AND analysis_type = 'single'
);

-- ============================================
-- 9. GRANTS (PERMISSÕES)
-- ============================================

-- Conceder permissões ao usuário da aplicação (ajustar conforme necessário)
-- GRANT SELECT, INSERT, UPDATE ON knowledge_base TO app_user;
-- GRANT USAGE, SELECT ON SEQUENCE knowledge_base_id_seq TO app_user;

-- ============================================
-- 10. VERIFICAÇÃO FINAL
-- ============================================

-- Verificar se tabela foi criada corretamente
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'knowledge_base') THEN
    RAISE NOTICE '✅ Tabela knowledge_base criada com sucesso!';
  ELSE
    RAISE EXCEPTION '❌ Erro ao criar tabela knowledge_base';
  END IF;
END $$;

-- Contar registros
DO $$
DECLARE
  record_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO record_count FROM knowledge_base;
  RAISE NOTICE 'Total de análises na base de conhecimento: %', record_count;
END $$;

-- ============================================
-- FIM DA MIGRAÇÃO 004
-- ============================================
