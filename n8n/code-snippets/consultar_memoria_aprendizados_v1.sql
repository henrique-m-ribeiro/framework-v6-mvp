-- ============================================================================
-- NÓ: CONSULTAR MEMÓRIA E APRENDIZADOS
-- Framework de Inteligência Territorial V6.0 - Workflow V6
-- ============================================================================
-- FUNÇÃO: Consultar as 4 Camadas do RAG Evolutivo
-- INPUT: territory_id do webhook normalizado
-- OUTPUT: Análises anteriores, aprendizados, expertise atual
-- ============================================================================

-- CAMADA 1: MEMÓRIA ESPECIALIZADA (Análises Anteriores)
-- Busca as últimas 5 análises NÃO ARQUIVADAS do mesmo território
SELECT 
  'memory' AS source_layer,
  id AS memory_id,
  analysis_content,
  analysis_summary,
  confidence_score,
  created_at,
  metadata,
  time_range,
  indicators_used
FROM agent_econ_memory
WHERE territory_id = '{{ $('Normalizar Entrada').first().json.territory_id }}'
  AND archived_at IS NULL
ORDER BY created_at DESC
LIMIT 5

UNION ALL

-- CAMADA 2: APRENDIZADO EVOLUTIVO (Sínteses e Padrões)
-- Busca os últimos 10 aprendizados do agente ECON
SELECT 
  'learning' AS source_layer,
  id AS learning_id,
  synthesis AS analysis_content,
  'Aprendizado acumulado' AS analysis_summary,
  confidence_score,
  created_at,
  NULL AS metadata,
  NULL AS time_range,
  NULL AS indicators_used
FROM agent_econ_learning_evolution
WHERE agent_id = 'econ'
ORDER BY created_at DESC
LIMIT 10

UNION ALL

-- CAMADA 4: EXPERTISE DINÂMICA (Nível Atual)
-- Busca o nível de expertise atual do agente
SELECT 
  'expertise' AS source_layer,
  NULL AS memory_id,
  expertise_level AS analysis_content,
  CAST(analysis_count AS TEXT) || ' análises realizadas' AS analysis_summary,
  avg_confidence AS confidence_score,
  last_analysis_date AS created_at,
  NULL AS metadata,
  NULL AS time_range,
  NULL AS indicators_used
FROM get_agent_expertise('econ')

ORDER BY created_at DESC;
