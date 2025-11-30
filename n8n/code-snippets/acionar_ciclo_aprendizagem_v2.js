// ============================================================================
// NÓ: ACIONAR CICLO DE APRENDIZAGEM EVOLUTIVA V2
// Framework de Inteligência Territorial V6.0 - Sessão #10
// ============================================================================
// FUNÇÃO: Executar o ciclo de aprendizagem após salvar análise com sucesso
// VERSÃO: 2.0 - Implementação JavaScript nativa (sem dependências externas)
// INPUT: Dados da análise salva (ID, agent_id, territory_id)
// OUTPUT: Resultado do ciclo de aprendizagem
// ============================================================================

// ============================================================================
// PASSO 1: EXTRAIR DADOS DA ANÁLISE SALVA
// ============================================================================

const savedAnalysis = $('Salvar Análise no PostgreSQL').first().json;
const preparedData = $('Preparar Dados para Salvar').first().json;

// Extrair informações necessárias
const analysisId = savedAnalysis.id || preparedData.id;
const agentId = 'econ';  // ID do agente (minúsculo, sem prefixo)
const territoryId = preparedData.territory_id;
const analysisContent = preparedData.analysis_content || preparedData.content;

console.log('🔄 Iniciando ciclo de aprendizagem...');
console.log(`   Agent ID: ${agentId}`);
console.log(`   Analysis ID: ${analysisId}`);
console.log(`   Territory ID: ${territoryId}`);

// ============================================================================
// CONFIGURAÇÃO: LIMITES E THRESHOLDS
// ============================================================================

const MIN_ANALYSES_FOR_LEARNING = 3;  // Mínimo de análises similares para criar aprendizado
const MAX_SIMILAR_ANALYSES = 5;       // Máximo de análises a comparar

// ============================================================================
// PASSO 2: BUSCAR ANÁLISES SIMILARES (NÃO ARQUIVADAS)
// ============================================================================
// Esta query busca análises anteriores do mesmo agente que não foram arquivadas
// Limita a 5 análises mais recentes para não sobrecarregar o LLM
// ============================================================================

console.log('\n📊 Buscando análises similares...');

// Preparar dados para o próximo nó (PostgreSQL)
return {
  json: {
    agent_id: agentId,
    analysis_id: analysisId,
    territory_id: territoryId,
    analysis_content: analysisContent,
    min_analyses: MIN_ANALYSES_FOR_LEARNING,
    max_similar: MAX_SIMILAR_ANALYSES,
    
    // Query para buscar análises similares (será executada no próximo nó)
    search_query: `
      SELECT 
        id,
        content,
        confidence_score,
        time_range,
        analysis_date,
        created_at
      FROM agent_${agentId}_memory
      WHERE agent_id = '${agentId}'
        AND id != '${analysisId}'
        AND (metadata->>'archived' IS NULL OR metadata->>'archived' = 'false')
      ORDER BY created_at DESC
      LIMIT ${MAX_SIMILAR_ANALYSES}
    `,
    
    metadata: {
      step: 'prepare_search',
      timestamp: new Date().toISOString()
    }
  }
};

// ============================================================================
// OBSERVAÇÕES IMPORTANTES
// ============================================================================
// 
// Este nó prepara os dados para o ciclo de aprendizagem.
// O fluxo completo requer nós adicionais:
//
// 1. [ESTE NÓ] Preparar Busca de Análises Similares
// 2. [PRÓXIMO NÓ] Executar Query PostgreSQL (buscar análises)
// 3. [PRÓXIMO NÓ] Verificar Se Há Análises Suficientes
// 4. [PRÓXIMO NÓ] Gerar Síntese com OpenAI
// 5. [PRÓXIMO NÓ] Arquivar Análises Antigas
// 6. [PRÓXIMO NÓ] Salvar Aprendizado
// 7. [PRÓXIMO NÓ] Atualizar Expertise
// 8. [PRÓXIMO NÓ] Registrar Auditoria
//
// ALTERNATIVA MAIS SIMPLES:
// Se preferir uma implementação mais simples (mas menos robusta),
// podemos criar um único nó que faz tudo, mas isso pode ser mais
// difícil de debugar e manter.
//
// RECOMENDAÇÃO:
// Para o MVP, sugiro uma abordagem intermediária:
// - Combinar passos 2-3 em um nó
// - Combinar passos 5-6-7-8 em outro nó
// - Total: 3 nós adicionais (mais gerenciável)
// ============================================================================
