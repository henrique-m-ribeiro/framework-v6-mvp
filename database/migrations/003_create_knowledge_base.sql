-- Migration: 003_create_knowledge_base
-- Framework de Inteligência Territorial V6.0
--
-- Este script cria a tabela `knowledge_base` com otimizações para busca vetorial (pgvector) e JSONB.

-- Passo 1: Habilitar a extensão pgvector (se ainda não estiver habilitada)
-- No Replit, isso geralmente é feito na configuração do banco de dados.
-- Se precisar executar manualmente, descomente a linha abaixo.
-- CREATE EXTENSION IF NOT EXISTS vector;

-- Passo 2: Habilitar a extensão para UUIDs (se necessário)
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Passo 3: Criar a tabela `knowledge_base`
CREATE TABLE IF NOT EXISTS knowledge_base (
    -- Identificação
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    territory_id VARCHAR(10) NOT NULL REFERENCES territories(id) ON DELETE CASCADE,
    dimension VARCHAR(50) NOT NULL,
    analysis_type VARCHAR(50) NOT NULL,
    
    -- Conteúdo
    content TEXT NOT NULL,
    summary TEXT,  -- Resumo de 2-3 frases para preview
    
    -- Embeddings para RAG (requer extensão pgvector)
    embedding VECTOR(1536),  -- OpenAI text-embedding-ada-002
    
    -- Metadados estruturados
    metadata JSONB,
    
    -- Versionamento
    version INTEGER DEFAULT 1,
    is_latest BOOLEAN DEFAULT TRUE,
    
    -- Qualidade e confiança
    confidence_score DECIMAL(3,2),  -- 0.00 a 1.00
    sources JSONB,  -- Lista de fontes usadas na análise
    
    -- Auditoria
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    generated_by VARCHAR(100),  -- Nome do agente que gerou
    
    -- Constraint única (território + dimensão + tipo + versão)
    UNIQUE(territory_id, dimension, analysis_type, version)
);

-- Passo 4: Adicionar comentários para documentação
COMMENT ON TABLE knowledge_base IS 'Armazena análises de IA, embeddings e metadados sobre os territórios.';
COMMENT ON COLUMN knowledge_base.embedding IS 'Vetor de embedding (1536 dimensões) para busca semântica (RAG).';
COMMENT ON COLUMN knowledge_base.metadata IS 'Metadados estruturados em JSONB para filtragem avançada.';
COMMENT ON COLUMN knowledge_base.is_latest IS 'Flag para identificar a versão mais recente de uma análise.';

-- Passo 5: Criar índices para otimização de performance

-- Índice composto para busca rápida por território e dimensão (principal caso de uso)
CREATE INDEX IF NOT EXISTS idx_kb_territory_dimension 
    ON knowledge_base(territory_id, dimension);

-- Índice para buscar rapidamente a versão mais recente de todas as análises
CREATE INDEX IF NOT EXISTS idx_kb_latest 
    ON knowledge_base(is_latest) 
    WHERE is_latest = TRUE;

-- Índice GIN para busca eficiente dentro do campo JSONB `metadata`
CREATE INDEX IF NOT EXISTS idx_kb_metadata 
    ON knowledge_base USING GIN(metadata);

-- Índice vetorial para busca semântica (RAG)
-- Usando IVFFlat, que é um bom equilíbrio entre velocidade e precisão para até ~1M de vetores.
-- `lists` é um parâmetro de ajuste. Regra geral: `rows / 1000`.
-- Para 1.680 análises, 100 listas é um valor seguro e eficiente.
CREATE INDEX IF NOT EXISTS idx_kb_embedding 
    ON knowledge_base USING ivfflat(embedding vector_cosine_ops)
    WITH (lists = 100);

-- Passo 6: Criar trigger para atualizar `updated_at` automaticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_knowledge_base_updated_at
BEFORE UPDATE ON knowledge_base
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Fim da migração

