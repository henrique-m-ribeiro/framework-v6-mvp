/**
 * N8N Client - Módulo de Integração Dashboard ↔ n8n Cloud
 * Framework de Inteligência Territorial V6.0
 * 
 * Este módulo facilita a comunicação entre o dashboard Replit e os workflows
 * do sistema multi-agentes no n8n Cloud.
 * 
 * @author Manus AI
 * @version 1.0.0
 * @date 2025-11-16
 */

// ============================================
// CONFIGURAÇÃO
// ============================================

const N8N_CONFIG = {
  baseUrl: 'https://galactic-ai.app.n8n.cloud',
  webhooks: {
    test: '/webhook/test-integration',
    dashboardRequest: '/webhook/dashboard-request',
    territorialAnalysis: '/webhook/analise-territorial'
  },
  timeout: 60000, // 60 segundos
  retries: 3
};

// ============================================
// CLASSE PRINCIPAL
// ============================================

class N8NClient {
  constructor(config = N8N_CONFIG) {
    this.config = config;
    this.requestId = 0;
  }

  /**
   * Gera um ID único para cada requisição
   * @returns {string} ID único no formato req_timestamp_random
   */
  generateRequestId() {
    this.requestId++;
    const timestamp = Date.now();
    const random = Math.random().toString(36).substr(2, 9);
    return `req_${timestamp}_${random}`;
  }

  /**
   * Faz requisição HTTP POST para um webhook do n8n
   * @param {string} endpoint - Caminho do webhook (ex: '/webhook/test-integration')
   * @param {object} payload - Dados a serem enviados
   * @param {object} options - Opções adicionais (timeout, retries)
   * @returns {Promise<object>} Resposta do webhook
   */
  async request(endpoint, payload, options = {}) {
    const url = `${this.config.baseUrl}${endpoint}`;
    const timeout = options.timeout || this.config.timeout;
    const retries = options.retries !== undefined ? options.retries : this.config.retries;

    // Adicionar request_id ao payload se não existir
    if (!payload.request_id) {
      payload.request_id = this.generateRequestId();
    }

    // Adicionar timestamp se não existir
    if (!payload.timestamp) {
      payload.timestamp = new Date().toISOString();
    }

    // Tentar requisição com retries
    for (let attempt = 1; attempt <= retries; attempt++) {
      try {
        console.log(`[N8NClient] Tentativa ${attempt}/${retries} - POST ${url}`);
        
        const controller = new AbortController();
        const timeoutId = setTimeout(() => controller.abort(), timeout);

        const response = await fetch(url, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: JSON.stringify(payload),
          signal: controller.signal
        });

        clearTimeout(timeoutId);

        // Verificar status HTTP
        if (!response.ok) {
          const errorText = await response.text();
          throw new Error(`HTTP ${response.status}: ${errorText}`);
        }

        // Parse JSON
        const data = await response.json();
        
        console.log(`[N8NClient] Sucesso - Request ID: ${payload.request_id}`);
        return {
          success: true,
          data: data,
          request_id: payload.request_id,
          timestamp: new Date().toISOString()
        };

      } catch (error) {
        console.error(`[N8NClient] Erro na tentativa ${attempt}:`, error.message);

        // Se foi o último retry, lançar erro
        if (attempt === retries) {
          return {
            success: false,
            error: error.message,
            request_id: payload.request_id,
            timestamp: new Date().toISOString()
          };
        }

        // Aguardar antes de tentar novamente (backoff exponencial)
        const waitTime = Math.pow(2, attempt) * 1000; // 2s, 4s, 8s...
        console.log(`[N8NClient] Aguardando ${waitTime}ms antes de tentar novamente...`);
        await new Promise(resolve => setTimeout(resolve, waitTime));
      }
    }
  }

  // ============================================
  // MÉTODOS DE CONVENIÊNCIA
  // ============================================

  /**
   * Testa a integração com o n8n
   * @param {number} territoryId - ID do território (opcional)
   * @param {string} territoryName - Nome do território (opcional)
   * @returns {Promise<object>} Resposta do teste
   */
  async testIntegration(territoryId = 1, territoryName = 'Tocantins') {
    return this.request(this.config.webhooks.test, {
      territory_id: territoryId,
      territory_name: territoryName,
      test_message: 'Teste de integração dashboard → n8n'
    });
  }

  /**
   * Envia requisição genérica ao receptor principal
   * @param {string} requestType - Tipo de requisição ('analysis', 'data_collection', 'comparison')
   * @param {number} territoryId - ID do território
   * @param {string} territoryName - Nome do território
   * @param {string} dimension - Dimensão ('economic', 'social', 'territorial', 'environmental')
   * @param {object} parameters - Parâmetros adicionais
   * @param {string} userId - ID do usuário (opcional)
   * @param {string} sessionId - ID da sessão (opcional)
   * @returns {Promise<object>} Resposta da requisição
   */
  async sendDashboardRequest(requestType, territoryId, territoryName, dimension, parameters = {}, userId = 'anonymous', sessionId = null) {
    return this.request(this.config.webhooks.dashboardRequest, {
      request_type: requestType,
      territory_id: territoryId,
      territory_name: territoryName,
      dimension: dimension,
      parameters: parameters,
      user_id: userId,
      session_id: sessionId || this.generateRequestId()
    });
  }

  /**
   * Solicita análise territorial completa
   * @param {number} territoryId - ID do território
   * @param {string} territoryName - Nome do território
   * @param {number} year - Ano de referência (padrão: 2023)
   * @param {array} indicators - Lista de indicadores (opcional)
   * @returns {Promise<object>} Resposta com análise completa
   */
  async requestTerritorialAnalysis(territoryId, territoryName, year = 2023, indicators = []) {
    return this.request(this.config.webhooks.territorialAnalysis, {
      territory_id: territoryId,
      territory_name: territoryName,
      year: year,
      indicators: indicators
    });
  }

  /**
   * Solicita análise econômica
   * @param {number} territoryId - ID do território
   * @param {string} territoryName - Nome do território
   * @param {number} year - Ano de referência
   * @returns {Promise<object>} Resposta da análise econômica
   */
  async requestEconomicAnalysis(territoryId, territoryName, year = 2023) {
    return this.sendDashboardRequest(
      'analysis',
      territoryId,
      territoryName,
      'economic',
      { year: year }
    );
  }

  /**
   * Solicita análise social
   * @param {number} territoryId - ID do território
   * @param {string} territoryName - Nome do território
   * @param {number} year - Ano de referência
   * @returns {Promise<object>} Resposta da análise social
   */
  async requestSocialAnalysis(territoryId, territoryName, year = 2023) {
    return this.sendDashboardRequest(
      'analysis',
      territoryId,
      territoryName,
      'social',
      { year: year }
    );
  }

  /**
   * Solicita análise ambiental
   * @param {number} territoryId - ID do território
   * @param {string} territoryName - Nome do território
   * @param {number} year - Ano de referência
   * @returns {Promise<object>} Resposta da análise ambiental
   */
  async requestEnvironmentalAnalysis(territoryId, territoryName, year = 2023) {
    return this.sendDashboardRequest(
      'analysis',
      territoryId,
      territoryName,
      'environmental',
      { year: year }
    );
  }

  /**
   * Solicita comparação entre territórios
   * @param {number} territoryId - ID do território principal
   * @param {string} territoryName - Nome do território principal
   * @param {array} comparisonTerritories - Lista de IDs dos territórios para comparar
   * @param {string} dimension - Dimensão da comparação
   * @param {number} year - Ano de referência
   * @returns {Promise<object>} Resposta da comparação
   */
  async requestComparison(territoryId, territoryName, comparisonTerritories, dimension, year = 2023) {
    return this.sendDashboardRequest(
      'comparison',
      territoryId,
      territoryName,
      dimension,
      {
        comparison_territories: comparisonTerritories,
        year: year
      }
    );
  }

  /**
   * Solicita coleta de dados
   * @param {number} territoryId - ID do território
   * @param {string} territoryName - Nome do território
   * @param {string} dimension - Dimensão dos dados
   * @param {number} year - Ano de referência
   * @returns {Promise<object>} Resposta da coleta de dados
   */
  async requestDataCollection(territoryId, territoryName, dimension, year = 2023) {
    return this.sendDashboardRequest(
      'data_collection',
      territoryId,
      territoryName,
      dimension,
      { year: year }
    );
  }
}

// ============================================
// EXPORTAR
// ============================================

// Para uso em Node.js (backend)
if (typeof module !== 'undefined' && module.exports) {
  module.exports = N8NClient;
}

// Para uso no navegador (frontend)
if (typeof window !== 'undefined') {
  window.N8NClient = N8NClient;
}

// ============================================
// EXEMPLO DE USO
// ============================================

/*

// 1. CRIAR INSTÂNCIA DO CLIENT
const n8nClient = new N8NClient();

// 2. TESTAR INTEGRAÇÃO
const testResult = await n8nClient.testIntegration(1, 'Tocantins');
console.log('Teste:', testResult);

// 3. SOLICITAR ANÁLISE TERRITORIAL COMPLETA
const analysisResult = await n8nClient.requestTerritorialAnalysis(1, 'Palmas', 2023);
console.log('Análise:', analysisResult.data.analysis.text);

// 4. SOLICITAR ANÁLISE ECONÔMICA
const economicResult = await n8nClient.requestEconomicAnalysis(1, 'Palmas', 2023);
console.log('Análise Econômica:', economicResult);

// 5. SOLICITAR COMPARAÇÃO
const comparisonResult = await n8nClient.requestComparison(
  1, 
  'Palmas', 
  [2, 3], // Comparar com Araguaína e Gurupi
  'economic', 
  2023
);
console.log('Comparação:', comparisonResult);

// 6. TRATAMENTO DE ERROS
const result = await n8nClient.requestTerritorialAnalysis(999, 'Território Inexistente', 2023);
if (!result.success) {
  console.error('Erro:', result.error);
} else {
  console.log('Sucesso:', result.data);
}

*/
