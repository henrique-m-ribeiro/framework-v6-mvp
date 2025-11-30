// ============================================================================
// NÓ: PREPARAR DADOS PARA SALVAR (V2 - RESILIENTE)
// Framework de Inteligência Territorial V6.0 - Workflow V5
// ============================================================================
// FUNÇÃO: Preparar dados da análise para salvar no PostgreSQL
// INPUT: Estruturar Resposta + Normalizar Entrada
// OUTPUT: Objeto com todos os campos necessários para INSERT
// ============================================================================

// Pega os dados do nó "Estruturar Resposta" (nó anterior)
const structuredData = $input.first().json;

// Pega os dados normalizados do webhook
const normalizedData = $items("Normalizar Entrada")[0].json;

// ============================================================================
// EXTRAÇÃO SEGURA DE DADOS
// ============================================================================

// Dados da análise estruturada
const taskId = structuredData.task_id || "unknown";
const agentName = structuredData.agent_name || "ECON";
const analysisText = structuredData.analysis?.text || "";
const analysisSummary = structuredData.analysis?.summary || "Análise gerada";
const territoryId = structuredData.analysis?.territory?.id || normalizedData.territory_id;
const territoryName = structuredData.analysis?.territory?.name || normalizedData.territory_name;

// Metadados da análise
const metadata = structuredData.metadata || {};
const modelUsed = metadata.model_used || "gpt-4o-mini";
const generatedAt = metadata.generated_at || new Date().toISOString();
const confidenceScore = metadata.confidence_score || 0.85;
const processingTimeMs = metadata.processing_time_ms || 0;
const yearsAnalyzed = metadata.years_analyzed || normalizedData.parameters.time_period;

// Dados normalizados do webhook
const agentId = normalizedData.agent_id;
const analysisType = normalizedData.analysis_type;
const userId = normalizedData.user_id;
const parameters = normalizedData.parameters || {};

// ============================================================================
// MONTAGEM DE OBJETOS JSON PARA O BANCO
// ============================================================================

// Objeto de metadados completo
const metadataObject = {
  task_id: taskId,
  model_used: modelUsed,
  generated_at: generatedAt,
  processing_time_ms: processingTimeMs,
  years_analyzed: yearsAnalyzed,
  analysis_type: analysisType,
  user_id: userId,
  confidence_score: confidenceScore
};

// Time range (extrair anos do time_period)
const timePeriod = parameters.time_period || "2019-2023";
const [startYear, endYear] = timePeriod.split("-").map(y => y.trim());

const timeRangeObject = {
  start: startYear || "2019",
  end: endYear || "2023"
};

// Data sources
const dataSourcesObject = [
  {
    type: "internal_db",
    source: "economic_indicators",
    query_date: new Date().toISOString()
  }
];

// Indicators used (baseado em focus_areas ou padrão)
const focusAreas = parameters.focus_areas || ["PIB", "emprego", "renda"];
const indicatorsUsedObject = focusAreas.map(area => ({
  name: area,
  source: "economic_indicators"
}));

// ============================================================================
// MONTAGEM DO OBJETO FINAL PARA SALVAR
// ============================================================================

const finalData = {
  agent_id: agentId,
  territory_id: territoryId,
  analysis_content: analysisText,
  analysis_summary: analysisSummary,
  confidence_score: confidenceScore,
  metadata: JSON.stringify(metadataObject),
  time_range: JSON.stringify(timeRangeObject),
  data_sources: JSON.stringify(dataSourcesObject),
  indicators_used: JSON.stringify(indicatorsUsedObject)
};

// ============================================================================
// VALIDAÇÃO FINAL
// ============================================================================

// Verificar se campos críticos estão presentes
const criticalFields = ['agent_id', 'territory_id', 'analysis_content'];
const missingCritical = criticalFields.filter(field => !finalData[field]);

if (missingCritical.length > 0) {
  throw new Error(`Campos críticos ausentes para salvar: ${missingCritical.join(', ')}`);
}

// ============================================================================
// RETORNO
// ============================================================================

return {
  json: finalData
};
