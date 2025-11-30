// ========================================
// ESTRUTURAR RESPOSTA FINAL (V2 - CORRIGIDO)
// ========================================
// Este nó consolida a análise do LLM com metadados e prepara resposta estruturada.

const items = $input.all();
const llmResponse = items[0].json.message.content;

// Recuperar dados dos nós anteriores (SINTAXE CORRIGIDA)
const contextData = $('Preparar Contexto para LLM (V4 Multidimensional)').first().json;
const webhookData = $('Webhook - Recebe Tarefa').first().json;
const normalizedData = $('Normalizar Entrada').first().json;

// Timestamp de processamento
const requestTime = webhookData.headers?.['x-request-time'] 
  ? new Date(webhookData.headers['x-request-time']).getTime() 
  : Date.now();
const processingTime = Date.now() - requestTime;

// Extrair resumo executivo da análise
let summary = 'Análise econômica completa gerada.';
try {
  const resumoMatch = llmResponse.match(/##?\s*Resumo Executivo\s*\n\n([\s\S]*?)(?=\n##|\n\*\*|$)/i);
  if (resumoMatch) {
    summary = resumoMatch[1].trim().substring(0, 500); // Primeiros 500 caracteres
  }
} catch (e) {
  console.log('Erro ao extrair resumo:', e.message);
}

// Estruturar resposta final
const response = {
  // Identificação da tarefa
  task_id: normalizedData.task_id || `task_${Date.now()}`,
  agent_name: 'ECON',
  status: 'success',
  
  // Análise gerada
  analysis: {
    text: llmResponse,
    summary: summary,
    territory: {
      id: normalizedData.territory_id,
      name: normalizedData.territory_name
    }
  },
  
  // Metadados
  metadata: {
    processing_time_ms: processingTime,
    time_period: normalizedData.parameters?.time_period || '2019-2023',
    analysis_type: normalizedData.analysis_type || 'economic_comprehensive',
    detail_level: normalizedData.parameters?.detail_level || 'comprehensive',
    model_used: 'gpt-4o-mini',
    confidence_score: 0.92, // Score fixo para MVP
    generated_at: new Date().toISOString(),
    agent_id: normalizedData.agent_id
  }
};

return [{ json: response }];

// ========================================
// CORREÇÕES APLICADAS (V2)
// ========================================
// 1. CORRIGIDO: $node['Nome'] → $('Nome').first()
// 2. CORRIGIDO: Acesso seguro a campos opcionais com ?.
// 3. CORRIGIDO: Extração de resumo mais robusta com regex
// 4. CORRIGIDO: Usa dados de normalizedData em vez de contextData
//    (contextData só tem prompt e metadata, não tem task_id, territory_id, etc.)
// 5. ADICIONADO: Try-catch para extração de resumo
// 6. ADICIONADO: Fallback para task_id se não existir
