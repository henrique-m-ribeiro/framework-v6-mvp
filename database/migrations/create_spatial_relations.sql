-- ============================================================================
-- FRAMEWORK V6.0 - RELAÇÕES ESPACIAIS PRÉ-COMPUTADAS
-- Fase 1: Infraestrutura e Curadoria
-- ============================================================================
-- 
-- Esta migração cria a tabela spatial_relations para armazenar relações
-- espaciais pré-computadas entre territórios, otimizando consultas do
-- Agente TERRA.
--
-- Baseado no Modelo Conceitual RAG Evolutivo v3.0 (Sessão #6)
-- ============================================================================

-- Criar tabela de relações espaciais se não existir
CREATE TABLE IF NOT EXISTS spatial_relations (
    -- Identificação
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Territórios relacionados
    territory_id_a VARCHAR(20) NOT NULL,
    territory_id_b VARCHAR(20) NOT NULL,
    
    -- Tipo de relação
    relation_type VARCHAR(50) NOT NULL,  -- 'neighbor', 'contains', 'within', 'distance'
    
    -- Métricas espaciais
    distance_km NUMERIC(10, 2),  -- Distância entre centroides em km
    shared_border_length_km NUMERIC(10, 2),  -- Comprimento da fronteira compartilhada
    
    -- Metadados
    metadata JSONB,  -- Informações adicionais sobre a relação
    
    -- Timestamps
    computed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT unique_spatial_relation UNIQUE (territory_id_a, territory_id_b, relation_type),
    CONSTRAINT check_different_territories CHECK (territory_id_a != territory_id_b)
);

-- Criar índices para otimizar queries
CREATE INDEX IF NOT EXISTS idx_spatial_relations_territory_a ON spatial_relations(territory_id_a);
CREATE INDEX IF NOT EXISTS idx_spatial_relations_territory_b ON spatial_relations(territory_id_b);
CREATE INDEX IF NOT EXISTS idx_spatial_relations_type ON spatial_relations(relation_type);
CREATE INDEX IF NOT EXISTS idx_spatial_relations_distance ON spatial_relations(distance_km);
CREATE INDEX IF NOT EXISTS idx_spatial_relations_metadata_gin ON spatial_relations USING GIN (metadata);

-- Criar índice composto para queries de vizinhança
CREATE INDEX IF NOT EXISTS idx_spatial_relations_neighbor_lookup 
    ON spatial_relations(territory_id_a, relation_type) 
    WHERE relation_type = 'neighbor';

-- Comentários para documentação
COMMENT ON TABLE spatial_relations IS 'Relações espaciais pré-computadas entre territórios para otimização de consultas do Agente TERRA';
COMMENT ON COLUMN spatial_relations.relation_type IS 'Tipo de relação espacial: neighbor (vizinho), contains (contém), within (está dentro), distance (distância)';
COMMENT ON COLUMN spatial_relations.distance_km IS 'Distância entre centroides dos territórios em quilômetros';
COMMENT ON COLUMN spatial_relations.shared_border_length_km IS 'Comprimento da fronteira compartilhada em quilômetros (para vizinhos)';

-- ============================================================================
-- FIM DA MIGRAÇÃO
-- ============================================================================
