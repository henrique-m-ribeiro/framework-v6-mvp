-- ========================================
-- SALVAR ANÁLISE EM knowledge_base (V2 - UPSERT)
-- ========================================
-- Insere nova análise ou atualiza se já existir

INSERT INTO knowledge_base (
  territory_id,
  dimension,
  content,
  summary,
  confidence_score,
  metadata,
  analysis_type,
  embedding,
  generated_by,
  version,
  is_latest
)
VALUES (
  '{{ $('Preparar Dados para Salvar').first().json.territory_id }}',
  'economic',
  $${{ $('Preparar Dados para Salvar').first().json.analysis_content }}$$,
  $${{ $('Preparar Dados para Salvar').first().json.analysis_summary }}$$,
  {{ $('Preparar Dados para Salvar').first().json.confidence_score }},
  '{{ $('Preparar Dados para Salvar').first().json.metadata }}'::jsonb,
  'diagnostic',
  '',
  'WF-AGENT-ECON',
  1,
  true
)
ON CONFLICT (territory_id, dimension, analysis_type, version)
DO UPDATE SET
  content = EXCLUDED.content,
  summary = EXCLUDED.summary,
  confidence_score = EXCLUDED.confidence_score,
  metadata = EXCLUDED.metadata,
  embedding = EXCLUDED.embedding,
  generated_by = EXCLUDED.generated_by,
  is_latest = EXCLUDED.is_latest,
  updated_at = NOW()
RETURNING id, territory_id, dimension, analysis_type, created_at, updated_at;

-- ========================================
-- CORREÇÕES APLICADAS (V2)
-- ========================================
-- 1. ADICIONADO: ON CONFLICT ... DO UPDATE (UPSERT)
-- 2. ADICIONADO: version e is_latest (campos obrigatórios)
-- 3. CORRIGIDO: Usa $('Nome do Nó').first().json em vez de $json
-- 4. ADICIONADO: RETURNING para retornar dados da análise salva
--
-- O QUE FAZ:
-- - Se análise NÃO existe: INSERE nova
-- - Se análise JÁ existe: ATUALIZA com novos dados
-- - Garante que sempre temos a versão mais recente
--
-- CONSTRAINT ÚNICA:
-- - (territory_id, dimension, analysis_type, version)
-- - Exemplo: ('1721000', 'economic', 'diagnostic', 1)
-- - Garante que não duplicamos análises
