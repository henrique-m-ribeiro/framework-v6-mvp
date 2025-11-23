/**
 * Script de Teste Automatizado - Integração Dashboard ↔ n8n
 * Framework de Inteligência Territorial V6.0
 * 
 * Este script testa todos os webhooks do n8n para garantir que a integração
 * está funcionando corretamente.
 * 
 * Uso:
 *   node test-n8n-integration.js
 * 
 * @author Manus AI
 * @version 1.0.0
 * @date 2025-11-16
 */

// ============================================
// CONFIGURAÇÃO
// ============================================

const N8N_BASE_URL = 'https://galactic-ai.app.n8n.cloud';

const TESTS = [
  {
    name: 'Teste 1: Integração Básica',
    endpoint: '/webhook/test-integration',
    payload: {
      territory_id: 1,
      territory_name: 'Tocantins',
      test_message: 'Teste automatizado de integração'
    },
    expectedFields: ['success', 'message', 'received_data', 'n8n_info']
  },
  {
    name: 'Teste 2: Receptor Principal - Análise Econômica',
    endpoint: '/webhook/dashboard-request',
    payload: {
      request_type: 'analysis',
      territory_id: 1,
      territory_name: 'Palmas',
      dimension: 'economic',
      parameters: { year: 2023 }
    },
    expectedFields: ['request_id', 'status', 'message', 'territory', 'dimension']
  },
  {
    name: 'Teste 3: Receptor Principal - Coleta de Dados',
    endpoint: '/webhook/dashboard-request',
    payload: {
      request_type: 'data_collection',
      territory_id: 1,
      territory_name: 'Palmas',
      dimension: 'social',
      parameters: { year: 2023 }
    },
    expectedFields: ['request_id', 'status', 'message']
  },
  {
    name: 'Teste 4: Receptor Principal - Comparação',
    endpoint: '/webhook/dashboard-request',
    payload: {
      request_type: 'comparison',
      territory_id: 1,
      territory_name: 'Palmas',
      dimension: 'economic',
      parameters: {
        comparison_territories: [2, 3],
        year: 2023
      }
    },
    expectedFields: ['request_id', 'status', 'comparison_territories']
  },
  {
    name: 'Teste 5: Análise Territorial Completa',
    endpoint: '/webhook/analise-territorial',
    payload: {
      territory_id: 1,
      territory_name: 'Palmas',
      year: 2023
    },
    expectedFields: ['success', 'territory', 'analysis', 'indicators_analyzed'],
    timeout: 90000 // 90 segundos (análise com LLM demora mais)
  },
  {
    name: 'Teste 6: Validação - Request Type Inválido',
    endpoint: '/webhook/dashboard-request',
    payload: {
      request_type: 'invalid_type',
      territory_id: 1,
      territory_name: 'Palmas',
      dimension: 'economic'
    },
    expectedFields: ['error', 'message'],
    expectError: true
  },
  {
    name: 'Teste 7: Validação - Campos Obrigatórios Ausentes',
    endpoint: '/webhook/dashboard-request',
    payload: {
      request_type: 'analysis'
      // Faltando territory_id e dimension
    },
    expectedFields: ['error', 'message'],
    expectError: true
  }
];

// ============================================
// FUNÇÕES AUXILIARES
// ============================================

/**
 * Faz requisição HTTP POST
 */
async function makeRequest(endpoint, payload, timeout = 30000) {
  const url = `${N8N_BASE_URL}${endpoint}`;
  
  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), timeout);

  try {
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

    const data = await response.json();
    
    return {
      status: response.status,
      ok: response.ok,
      data: data
    };
  } catch (error) {
    clearTimeout(timeoutId);
    throw error;
  }
}

/**
 * Valida se os campos esperados estão presentes na resposta
 */
function validateFields(data, expectedFields) {
  const missingFields = [];
  
  for (const field of expectedFields) {
    if (!(field in data)) {
      missingFields.push(field);
    }
  }
  
  return {
    valid: missingFields.length === 0,
    missingFields: missingFields
  };
}

/**
 * Formata duração em ms para string legível
 */
function formatDuration(ms) {
  if (ms < 1000) return `${ms}ms`;
  return `${(ms / 1000).toFixed(2)}s`;
}

/**
 * Cores para terminal
 */
const colors = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  gray: '\x1b[90m'
};

// ============================================
// EXECUTOR DE TESTES
// ============================================

async function runTests() {
  console.log(`${colors.blue}╔════════════════════════════════════════════════════════════╗${colors.reset}`);
  console.log(`${colors.blue}║  Teste de Integração Dashboard ↔ n8n Cloud                ║${colors.reset}`);
  console.log(`${colors.blue}║  Framework de Inteligência Territorial V6.0                ║${colors.reset}`);
  console.log(`${colors.blue}╚════════════════════════════════════════════════════════════╝${colors.reset}`);
  console.log('');
  console.log(`${colors.gray}Base URL: ${N8N_BASE_URL}${colors.reset}`);
  console.log(`${colors.gray}Total de testes: ${TESTS.length}${colors.reset}`);
  console.log('');

  let passedTests = 0;
  let failedTests = 0;
  const results = [];

  for (let i = 0; i < TESTS.length; i++) {
    const test = TESTS[i];
    const testNumber = i + 1;
    
    console.log(`${colors.blue}[${testNumber}/${TESTS.length}]${colors.reset} ${test.name}`);
    console.log(`${colors.gray}  Endpoint: ${test.endpoint}${colors.reset}`);
    
    const startTime = Date.now();
    
    try {
      // Fazer requisição
      const response = await makeRequest(
        test.endpoint, 
        test.payload, 
        test.timeout || 30000
      );
      
      const duration = Date.now() - startTime;
      
      // Validar resposta
      let testPassed = true;
      let errorMessage = null;
      
      // Se esperamos erro
      if (test.expectError) {
        if (response.data.error || response.data.status === 400) {
          testPassed = true;
        } else {
          testPassed = false;
          errorMessage = 'Esperava erro mas recebeu sucesso';
        }
      } else {
        // Validar campos esperados
        const validation = validateFields(response.data, test.expectedFields);
        
        if (!validation.valid) {
          testPassed = false;
          errorMessage = `Campos ausentes: ${validation.missingFields.join(', ')}`;
        }
        
        // Validar status HTTP
        if (!response.ok && !response.data.error) {
          testPassed = false;
          errorMessage = `HTTP ${response.status}`;
        }
      }
      
      // Exibir resultado
      if (testPassed) {
        console.log(`  ${colors.green}✓ PASSOU${colors.reset} (${formatDuration(duration)})`);
        passedTests++;
      } else {
        console.log(`  ${colors.red}✗ FALHOU${colors.reset} (${formatDuration(duration)})`);
        console.log(`  ${colors.red}  Erro: ${errorMessage}${colors.reset}`);
        failedTests++;
      }
      
      // Armazenar resultado
      results.push({
        test: test.name,
        passed: testPassed,
        duration: duration,
        error: errorMessage,
        response: response.data
      });
      
    } catch (error) {
      const duration = Date.now() - startTime;
      
      console.log(`  ${colors.red}✗ ERRO${colors.reset} (${formatDuration(duration)})`);
      console.log(`  ${colors.red}  ${error.message}${colors.reset}`);
      
      failedTests++;
      
      results.push({
        test: test.name,
        passed: false,
        duration: duration,
        error: error.message,
        response: null
      });
    }
    
    console.log('');
    
    // Aguardar 1 segundo entre testes para não sobrecarregar
    if (i < TESTS.length - 1) {
      await new Promise(resolve => setTimeout(resolve, 1000));
    }
  }

  // ============================================
  // RESUMO FINAL
  // ============================================

  console.log(`${colors.blue}╔════════════════════════════════════════════════════════════╗${colors.reset}`);
  console.log(`${colors.blue}║  RESUMO DOS TESTES                                         ║${colors.reset}`);
  console.log(`${colors.blue}╚════════════════════════════════════════════════════════════╝${colors.reset}`);
  console.log('');
  
  const totalTests = TESTS.length;
  const successRate = ((passedTests / totalTests) * 100).toFixed(1);
  
  console.log(`Total de testes:    ${totalTests}`);
  console.log(`${colors.green}Testes aprovados:   ${passedTests}${colors.reset}`);
  console.log(`${colors.red}Testes falhados:    ${failedTests}${colors.reset}`);
  console.log(`Taxa de sucesso:    ${successRate}%`);
  console.log('');

  // Calcular tempo total
  const totalDuration = results.reduce((sum, r) => sum + r.duration, 0);
  console.log(`Tempo total:        ${formatDuration(totalDuration)}`);
  console.log('');

  // Listar testes falhados
  if (failedTests > 0) {
    console.log(`${colors.red}TESTES FALHADOS:${colors.reset}`);
    results
      .filter(r => !r.passed)
      .forEach((r, i) => {
        console.log(`  ${i + 1}. ${r.test}`);
        console.log(`     ${colors.red}${r.error}${colors.reset}`);
      });
    console.log('');
  }

  // Status final
  if (failedTests === 0) {
    console.log(`${colors.green}╔════════════════════════════════════════════════════════════╗${colors.reset}`);
    console.log(`${colors.green}║  ✓ TODOS OS TESTES PASSARAM!                               ║${colors.reset}`);
    console.log(`${colors.green}║  Integração dashboard ↔ n8n funcionando perfeitamente.     ║${colors.reset}`);
    console.log(`${colors.green}╚════════════════════════════════════════════════════════════╝${colors.reset}`);
    process.exit(0);
  } else {
    console.log(`${colors.red}╔════════════════════════════════════════════════════════════╗${colors.reset}`);
    console.log(`${colors.red}║  ✗ ALGUNS TESTES FALHARAM                                  ║${colors.reset}`);
    console.log(`${colors.red}║  Verifique os erros acima e corrija antes de prosseguir.   ║${colors.reset}`);
    console.log(`${colors.red}╚════════════════════════════════════════════════════════════╝${colors.reset}`);
    process.exit(1);
  }
}

// ============================================
// EXECUTAR
// ============================================

runTests().catch(error => {
  console.error(`${colors.red}Erro fatal ao executar testes:${colors.reset}`, error);
  process.exit(1);
});
