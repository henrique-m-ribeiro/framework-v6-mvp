-- ============================================================================
-- NÓ: CONSULTAR MEMÓRIA E APRENDIZADOS (V2 - CORRIGIDO)
-- Framework de Inteligência Territorial V6.0 - Workflow V6.1
-- ============================================================================
-- FUNÇÃO: Consultar as 4 Camadas do RAG Evolutivo
-- INPUT: territory_id do webhook normalizado
-- OUTPUT: Análises anteriores, aprendizados, expertise atual
-- CORREÇÃO: Usa CTEs para aplicar ORDER BY e LIMIT antes do UNION ALL
-- ============================================================================

WITH 
-- CAMADA 1: MEMÓRIA ESPECIALIZADA (Análises Anteriores)
-- Busca as últimas 5 análises NÃO ARQUIVADAS do mesmo território
memory_layer AS (
  SELECT 
    'memory' AS source_layer,
    id::TEXT AS record_id,
    analysis_content,
    analysis_summary,
    confidence_score,
    created_at,
    metadata::TEXT AS metadata_text,
    time_range::TEXT AS time_range_text,
    indicators_used::TEXT AS indicators_used_text
  FROM agent_econ_memory
  WHERE territory_id = '{{ $('Normalizar Entrada').first().json.territory_id }}'
    AND is_latest = true
  ORDER BY created_at DESC
  LIMIT 5
),

-- CAMADA 2: APRENDIZADO EVOLUTIVO (Sínteses e Padrões)
-- Busca os últimos 10 aprendizados do agente ECON
learning_layer AS (
  SELECT 
    'learning' AS source_layer,
    id::TEXT AS record_id,
    learning_content AS analysis_content,
    'Aprendizado acumulado' AS analysis_summary,
    confidence_score,
    created_at,
    NULL AS metadata_text,
    NULL AS time_range_text,
    NULL AS indicators_used_text
  FROM agent_econ_learning_evolution
  WHERE agent_id = 'econ'
  ORDER BY created_at DESC
  LIMIT 10
),

-- CAMADA 4: EXPERTISE DINÂMICA (Nível Atual)
-- Busca o nível de expertise atual do agente
expertise_layer AS (
  SELECT 
    'expertise' AS source_layer,
    'expertise_current' AS record_id,
    expertise_level AS analysis_content,
    CAST(analysis_count AS TEXT) || ' análises realizadas' AS analysis_summary,
    avg_confidence AS confidence_score,
    last_analysis_date AS created_at,
    NULL AS metadata_text,
    NULL AS time_range_text,
    NULL AS indicators_used_text
  FROM get_agent_expertise('econ')
)

-- UNIÃO DAS 3 CAMADAS
SELECT * FROM memory_layer
UNION ALL
SELECT * FROM learning_layer
UNION ALL
SELECT * FROM expertise_layer

-- Ordenação final por data (mais recentes primeiro)
ORDER BY created_at DESC;

-- ============================================================================
-- NOTAS TÉCNICAS
-- ============================================================================
-- 
-- 1. CORREÇÃO DO ERRO DE SINTAXE:
--    - Não é possível usar ORDER BY/LIMIT em subconsultas de UNION ALL
--    - Solução: Usar CTEs (WITH) para aplicar ORDER BY/LIMIT antes do UNION
--
-- 2. CONVERSÃO DE TIPOS:
--    - Todos os campos são convertidos para TEXT para garantir compatibilidade
--    - JSONB → TEXT usando ::TEXT
--    - INTEGER → TEXT usando CAST() ou ::TEXT
--
-- 3. RESULTADO ESPERADO:
--    - Até 16 registros (5 memórias + 10 aprendizados + 1 expertise)
--    - Ordenados por data (mais recentes primeiro)
--    - Identificados pela coluna source_layer
--
-- 4. USO NO NÓ "PREPARAR CONTEXTO PARA LLM":
--    - Filtrar por source_layer para separar as camadas
--    - memory → Análises anteriores
--    - learning → Aprendizados acumulados
--    - expertise → Nível atual de expertise
-- ============================================================================
