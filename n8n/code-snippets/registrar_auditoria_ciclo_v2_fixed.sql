-- ========================================
-- REGISTRAR AUDITORIA DO CICLO DE APRENDIZAGEM (V2 - CORRIGIDO)
-- ========================================
-- Registra evento de ciclo de aprendizagem completo na auditoria

INSERT INTO audit_trail (
  event_id,
  event_type,
  event_category,
  agent_id,
  user_id,
  action,
  description,
  metadata,
  status,
  created_at
) VALUES (
  gen_random_uuid()::text,
  'learning_cycle_completed',
  'learning',
  '{{ $('Normalizar Entrada').first().json.agent_id }}',
  '{{ $('Normalizar Entrada').first().json.user_id }}',
  'automatic_learning',
  'Ciclo de aprendizagem evolutiva completado com sucesso',
  jsonb_build_object(
    'analysis_id', '{{ $('Salvar Análise no PostgreSQL').first().json.analysis_id || "undefined" }}',
    'learning_id', '{{ $('Registrar Aprendizado Automático').first().json.learning_id || "undefined" }}',
    'expertise_level', '{{ $('Atualizar Expertise').first().json.expertise_level || "NOVATO" }}',
    'learning_count', {{ $('Atualizar Expertise').first().json.learning_count || 1 }},
    'territory_id', '{{ $('Normalizar Entrada').first().json.territory_id }}',
    'territory_name', '{{ $('Normalizar Entrada').first().json.territory_name }}',
    'type', 'automatic'
  ),
  'success',
  NOW()
);

-- ========================================
-- CORREÇÕES APLICADAS (V2)
-- ========================================
-- 1. REMOVIDO: resource_type (coluna não existe)
-- 2. ADICIONADO: event_id (obrigatório)
-- 3. ADICIONADO: event_category (obrigatório)
-- 4. ADICIONADO: description (para melhor rastreabilidade)
-- 5. CORRIGIDO: Usa dados reais dos nós anteriores
-- 6. ADICIONADO: Fallbacks para campos opcionais
--
-- SCHEMA REAL VALIDADO:
-- - event_id, event_type, event_category (obrigatórios)
-- - agent_id, territory_id, user_id (opcionais)
-- - action, description (action obrigatório, description opcional)
-- - metadata (JSON com dados adicionais)
-- - status, created_at
