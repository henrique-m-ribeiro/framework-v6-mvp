// ============================================================================
// NÓ: NORMALIZAR ENTRADA
// Framework de Inteligência Territorial V6.0 - Workflow V5
// ============================================================================
// FUNÇÃO: Validar e normalizar o payload recebido do webhook
// INPUT: Webhook (body)
// OUTPUT: Objeto normalizado com valores padrão para campos opcionais
// ============================================================================

// Receber dados do webhook
const webhookData = $input.first().json.body || {};

// ============================================================================
// VALIDAÇÃO DE CAMPOS OBRIGATÓRIOS
// ============================================================================

const requiredFields = ['agent_id', 'territory_id', 'analysis_type'];
const missingFields = [];

for (const field of requiredFields) {
  if (!webhookData[field]) {
    missingFields.push(field);
  }
}

// Se houver campos obrigatórios faltando, retornar erro
if (missingFields.length > 0) {
  throw new Error(`Campos obrigatórios ausentes: ${missingFields.join(', ')}`);
}

// ============================================================================
// NORMALIZAÇÃO DE CAMPOS OPCIONAIS
// ============================================================================

// Campos simples com valores padrão
const territory_name = webhookData.territory_name || "Território Desconhecido";
const user_id = webhookData.user_id || "system";

// Objeto parameters com valores padrão
const parameters = webhookData.parameters || {};
const time_period = parameters.time_period || "2019-2023";
const focus_areas = parameters.focus_areas || ["PIB", "emprego", "renda"];
const detail_level = parameters.detail_level || "comprehensive";

// ============================================================================
// MONTAGEM DO OBJETO NORMALIZADO
// ============================================================================

const normalizedData = {
  // Campos obrigatórios (já validados)
  agent_id: webhookData.agent_id,
  territory_id: webhookData.territory_id,
  analysis_type: webhookData.analysis_type,
  
  // Campos opcionais (com valores padrão)
  territory_name: territory_name,
  user_id: user_id,
  
  // Objeto parameters normalizado
  parameters: {
    time_period: time_period,
    focus_areas: focus_areas,
    detail_level: detail_level
  },
  
  // Metadados de normalização
  _normalized: {
    timestamp: new Date().toISOString(),
    fields_added: [],
    original_payload: webhookData
  }
};

// Registrar quais campos foram adicionados
if (!webhookData.territory_name) normalizedData._normalized.fields_added.push('territory_name');
if (!webhookData.user_id) normalizedData._normalized.fields_added.push('user_id');
if (!webhookData.parameters) normalizedData._normalized.fields_added.push('parameters');
if (!parameters.time_period) normalizedData._normalized.fields_added.push('parameters.time_period');
if (!parameters.focus_areas) normalizedData._normalized.fields_added.push('parameters.focus_areas');
if (!parameters.detail_level) normalizedData._normalized.fields_added.push('parameters.detail_level');

// ============================================================================
// RETORNO
// ============================================================================

return {
  json: normalizedData
};
