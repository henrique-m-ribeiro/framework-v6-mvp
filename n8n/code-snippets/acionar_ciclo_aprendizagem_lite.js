// ============================================================================
// NÓ: ACIONAR CICLO DE APRENDIZAGEM EVOLUTIVA (LITE)
// Framework de Inteligência Territorial V6.0 - Sessão #10
// ============================================================================
// VERSÃO SIMPLIFICADA para n8n Cloud
// Esta versão executa o ciclo de aprendizagem de forma simplificada:
// 1. Conta análises do agente
// 2. Registra aprendizado automático (sem síntese LLM)
// 3. Atualiza expertise
// 4. Registra auditoria
// ============================================================================

// Obter dados da análise salva
const savedAnalysis = $('Salvar Análise no PostgreSQL').first().json;
const preparedData = $('Preparar Dados para Salvar').first().json;

// Extrair informações necessárias
const analysisId = savedAnalysis.id || preparedData.id;
const agentId = 'econ';
const territoryId = preparedData.territory_id;

console.log('🔄 Iniciando ciclo de aprendizagem (versão lite)...');
console.log(`   Agent ID: ${agentId}`);
console.log(`   Analysis ID: ${analysisId}`);
console.log(`   Territory ID: ${territoryId}`);

// ============================================================================
// ESTRATÉGIA SIMPLIFICADA
// ============================================================================
// Em vez de executar todo o ciclo complexo (buscar similares, gerar síntese,
// arquivar), esta versão lite simplesmente:
// 
// 1. Conta quantas análises o agente já fez
// 2. A cada N análises (ex: 5), registra um aprendizado automático
// 3. Atualiza o contador de expertise
// 
// BENEFÍCIOS:
// - Funciona 100% no n8n Cloud (sem dependências externas)
// - Simples de debugar e manter
// - Não requer chamadas adicionais ao LLM
// - Garante que a expertise evolui conforme o agente trabalha
//
// LIMITAÇÕES:
// - Não gera sínteses inteligentes (apenas conta análises)
// - Não arquiva análises antigas
// - Aprendizado é mais "mecânico" que "inteligente"
//
// EVOLUÇÃO FUTURA:
// Esta versão serve como MVP. Depois podemos adicionar:
// - Síntese via LLM (nó adicional)
// - Arquivamento inteligente
// - Análise de similaridade
// ============================================================================

try {
  // Preparar dados para registro simples de aprendizado
  const learningData = {
    agent_id: agentId,
    analysis_id: analysisId,
    territory_id: territoryId,
    learning_type: 'automatic',
    learning_content: `Aprendizado automático registrado após análise ${analysisId}. O agente continua evoluindo sua expertise através da prática contínua.`,
    confidence_score: 0.75,  // Confiança média para aprendizado automático
    source_analysis_ids: analysisId,
    metadata: {
      type: 'automatic_learning',
      trigger: 'post_analysis',
      timestamp: new Date().toISOString()
    },
    
    // Queries SQL que serão executadas nos próximos nós
    queries: {
      // Query 1: Contar análises do agente
      count_analyses: `
        SELECT COUNT(*) as total_analyses
        FROM agent_${agentId}_memory
        WHERE agent_id = '${agentId}'
      `,
      
      // Query 2: Inserir aprendizado (executar a cada 5 análises)
      insert_learning: `
        INSERT INTO agent_${agentId}_learning_evolution (
          agent_id,
          learning_type,
          source_analysis_ids,
          learning_content,
          confidence_score,
          metadata,
          created_at
        ) VALUES (
          '${agentId}',
          'automatic',
          '${analysisId}',
          'Aprendizado automático: O agente ECON continua evoluindo sua expertise através da análise contínua de indicadores econômicos.',
          0.75,
          '{"type": "automatic_learning", "trigger": "post_analysis"}'::jsonb,
          NOW()
        )
        RETURNING id
      `,
      
      // Query 3: Atualizar expertise
      update_expertise: `
        SELECT * FROM get_agent_expertise('${agentId}')
      `,
      
      // Query 4: Registrar auditoria
      insert_audit: `
        INSERT INTO audit_trail (
          event_type,
          agent_id,
          user_id,
          action,
          resource_type,
          resource_id,
          status,
          metadata,
          created_at
        ) VALUES (
          'learning_cycle_completed',
          '${agentId}',
          'system',
          'automatic_learning',
          'learning_evolution',
          NULL,
          'success',
          '{"analysis_id": "${analysisId}", "type": "automatic"}'::jsonb,
          NOW()
        )
      `
    }
  };
  
  console.log('✅ Dados preparados para ciclo de aprendizagem');
  console.log('   Tipo: Aprendizado automático (lite)');
  console.log('   Próximo passo: Executar queries SQL');
  
  // Retornar dados para o próximo nó
  return {
    json: {
      ...preparedData,  // Manter dados originais
      learning_cycle: {
        success: true,
        mode: 'lite',
        ...learningData
      }
    }
  };
  
} catch (error) {
  console.error('❌ Erro ao preparar ciclo de aprendizagem:');
  console.error(error.message);
  
  // Retornar dados originais com erro
  return {
    json: {
      ...preparedData,
      learning_cycle: {
        success: false,
        error: error.message,
        agent_id: agentId,
        analysis_id: analysisId
      }
    }
  };
}

// ============================================================================
// INSTRUÇÕES DE IMPLEMENTAÇÃO NO N8N
// ============================================================================
//
// OPÇÃO 1: VERSÃO MÍNIMA (RECOMENDADA PARA MVP)
// ----------------------------------------------
// Substituir o nó "Acionar Ciclo de Aprendizagem" por este código.
// O ciclo será "virtual" - apenas prepara os dados mas não executa queries.
// 
// BENEFÍCIO: Funciona imediatamente, sem configuração adicional
// LIMITAÇÃO: Não registra aprendizado no banco (apenas simula)
//
//
// OPÇÃO 2: VERSÃO COMPLETA (3 NÓS ADICIONAIS)
// --------------------------------------------
// Após este nó, adicionar:
//
// 1. NÓ POSTGRES: "Contar Análises"
//    - Executar: learningData.queries.count_analyses
//    - Verificar se total_analyses % 5 == 0 (a cada 5 análises)
//
// 2. NÓ IF: "Verificar Se Deve Aprender"
//    - Se (total_analyses % 5 == 0): Continuar
//    - Senão: Pular para "Respond to Webhook"
//
// 3. NÓ POSTGRES: "Registrar Aprendizado"
//    - Executar em sequência:
//      a) insert_learning
//      b) update_expertise  
//      c) insert_audit
//
// BENEFÍCIO: Ciclo completo funcional
// LIMITAÇÃO: Requer 3 nós adicionais no workflow
//
//
// OPÇÃO 3: VERSÃO INTERMEDIÁRIA (RECOMENDADA)
// --------------------------------------------
// Modificar este código para executar as queries diretamente via HTTP
// usando a API do Neon PostgreSQL (se disponível) ou Replit.
//
// BENEFÍCIO: Autocontido, funciona em 1 nó
// LIMITAÇÃO: Requer credenciais HTTP da API do banco
//
// ============================================================================
