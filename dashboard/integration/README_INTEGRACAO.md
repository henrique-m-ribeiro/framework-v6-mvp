# Guia de Integração: Dashboard Replit ↔ n8n Cloud
**Framework de Inteligência Territorial V6.0**  
**Data:** 16 de novembro de 2025  
**Autor:** Manus AI  
**Versão:** 1.0.0

---

## 🎯 OBJETIVO

Este guia ensina como integrar o código JavaScript de comunicação com n8n no dashboard Replit existente.

---

## 📁 ARQUIVOS CRIADOS

### 1. `n8n-client.js`
**Descrição:** Módulo JavaScript que facilita a comunicação com webhooks do n8n  
**Tamanho:** ~8 KB  
**Funcionalidades:**
- Classe `N8NClient` com métodos para cada tipo de requisição
- Tratamento automático de erros e retries
- Geração de request_id único
- Timeout configurável
- Suporte a Node.js (backend) e navegador (frontend)

### 2. `exemplo-integracao.html`
**Descrição:** Página HTML de demonstração da integração  
**Tamanho:** ~10 KB  
**Funcionalidades:**
- Interface visual para testar todos os webhooks
- 5 seções de teste (Integração, Análise, Dimensões, Comparação, Coleta)
- Exibição de resultados em tempo real
- Loading states e tratamento de erros

### 3. `README_INTEGRACAO.md` (este arquivo)
**Descrição:** Guia passo-a-passo de integração

---

## 🚀 PASSO 1: ADICIONAR N8N CLIENT AO DASHBOARD

### Opção A: Adicionar como Arquivo Separado (Recomendado)

1. **Acesse seu projeto Replit:**
   - URL: https://replit.com/@seu-usuario/framework-v6-dashboard

2. **Criar pasta `public/js/` (se não existir):**
   - No painel lateral esquerdo (Files), clique com botão direito na pasta `public`
   - Selecione "New folder"
   - Nome: `js`

3. **Adicionar arquivo `n8n-client.js`:**
   - Clique com botão direito na pasta `public/js/`
   - Selecione "New file"
   - Nome: `n8n-client.js`
   - Copie todo o conteúdo do arquivo `n8n-client.js` deste repositório
   - Cole no arquivo criado
   - Salve (Ctrl+S)

4. **Importar no HTML principal:**
   - Abra o arquivo `public/index.html` (ou similar)
   - Adicione antes do fechamento de `</body>`:
   ```html
   <script src="/js/n8n-client.js"></script>
   ```

### Opção B: Adicionar Inline no HTML

Se preferir não criar arquivo separado:

1. Abra `public/index.html`
2. Adicione antes do fechamento de `</body>`:
   ```html
   <script>
   // Cole aqui todo o conteúdo de n8n-client.js
   </script>
   ```

---

## 🔧 PASSO 2: INICIALIZAR O CLIENT

Após importar o `n8n-client.js`, inicialize o client em seu código JavaScript:

```javascript
// Criar instância global do N8NClient
const n8nClient = new N8NClient();

// Opcional: Configurar URLs customizadas
const n8nClient = new N8NClient({
  baseUrl: 'https://galactic-ai.app.n8n.cloud',
  webhooks: {
    test: '/webhook/test-integration',
    dashboardRequest: '/webhook/dashboard-request',
    territorialAnalysis: '/webhook/analise-territorial'
  },
  timeout: 60000, // 60 segundos
  retries: 3
});
```

---

## 💡 PASSO 3: USAR NO CÓDIGO DO DASHBOARD

### Exemplo 1: Botão "Gerar Análise Territorial"

Localize o botão no HTML:

```html
<button id="btnGenerateAnalysis">Gerar Análise Territorial</button>
```

Adicione o event listener:

```javascript
document.getElementById('btnGenerateAnalysis').addEventListener('click', async () => {
  // Obter dados do formulário
  const territoryId = parseInt(document.getElementById('territorySelect').value);
  const territoryName = document.getElementById('territorySelect').options[document.getElementById('territorySelect').selectedIndex].text;
  const year = parseInt(document.getElementById('yearSelect').value);

  // Mostrar loading
  const button = document.getElementById('btnGenerateAnalysis');
  button.disabled = true;
  button.textContent = 'Gerando análise...';

  try {
    // Chamar n8n
    const result = await n8nClient.requestTerritorialAnalysis(territoryId, territoryName, year);

    if (result.success) {
      // Exibir análise no dashboard
      const analysisText = result.data.analysis.text;
      document.getElementById('analysisContainer').innerHTML = marked.parse(analysisText); // Se usar marked.js para Markdown
      
      // Ou simplesmente:
      document.getElementById('analysisContainer').textContent = analysisText;
      
      // Mostrar notificação de sucesso
      showNotification('Análise gerada com sucesso!', 'success');
    } else {
      // Mostrar erro
      showNotification(`Erro: ${result.error}`, 'error');
    }
  } catch (error) {
    showNotification(`Erro de conexão: ${error.message}`, 'error');
  } finally {
    // Esconder loading
    button.disabled = false;
    button.textContent = 'Gerar Análise Territorial';
  }
});
```

### Exemplo 2: Chat IA - Integrar com n8n

Se o dashboard tem um chat IA, você pode integrá-lo com o n8n:

```javascript
async function handleChatMessage(userMessage) {
  // Identificar intenção do usuário
  const intent = identifyIntent(userMessage); // Sua lógica de NLP

  if (intent.type === 'request_analysis') {
    // Usuário pediu análise
    const territoryId = intent.territoryId || getCurrentTerritoryId();
    const territoryName = intent.territoryName || getCurrentTerritoryName();
    
    // Chamar n8n
    const result = await n8nClient.requestTerritorialAnalysis(territoryId, territoryName, 2023);
    
    if (result.success) {
      // Retornar análise ao chat
      return {
        type: 'analysis',
        text: result.data.analysis.text,
        metadata: result.data.metadata
      };
    } else {
      return {
        type: 'error',
        text: 'Desculpe, não consegui gerar a análise. Tente novamente.'
      };
    }
  }
  
  // Outras intenções...
}
```

### Exemplo 3: Aba "Comparação" - Comparar Territórios

```javascript
async function compareTerritoriesHandler() {
  const mainTerritoryId = parseInt(document.getElementById('mainTerritory').value);
  const mainTerritoryName = document.getElementById('mainTerritory').options[document.getElementById('mainTerritory').selectedIndex].text;
  
  const comparisonIds = Array.from(document.querySelectorAll('.comparison-territory:checked'))
    .map(checkbox => parseInt(checkbox.value));
  
  const dimension = document.getElementById('dimensionSelect').value;
  const year = parseInt(document.getElementById('yearSelect').value);

  // Mostrar loading
  showLoadingOverlay('Comparando territórios...');

  try {
    const result = await n8nClient.requestComparison(
      mainTerritoryId,
      mainTerritoryName,
      comparisonIds,
      dimension,
      year
    );

    if (result.success) {
      // Renderizar comparação
      renderComparisonChart(result.data);
      showNotification('Comparação gerada!', 'success');
    } else {
      showNotification(`Erro: ${result.error}`, 'error');
    }
  } catch (error) {
    showNotification(`Erro: ${error.message}`, 'error');
  } finally {
    hideLoadingOverlay();
  }
}
```

### Exemplo 4: Coleta Automática de Dados (Background)

Executar coleta de dados automaticamente quando o dashboard carregar:

```javascript
// Ao carregar a página
window.addEventListener('DOMContentLoaded', async () => {
  console.log('Dashboard carregado. Verificando atualizações...');

  // Verificar se há dados desatualizados
  const lastUpdate = await checkLastDataUpdate();
  const now = new Date();
  const hoursSinceUpdate = (now - lastUpdate) / (1000 * 60 * 60);

  if (hoursSinceUpdate > 24) {
    // Dados desatualizados, acionar coleta
    console.log('Dados desatualizados. Acionando Data Collector...');
    
    const result = await n8nClient.requestDataCollection(1, 'Tocantins', 'economic', 2023);
    
    if (result.success) {
      console.log('Coleta de dados iniciada:', result.data);
      showNotification('Atualizando dados...', 'info');
    }
  }
});
```

---

## 🧪 PASSO 4: TESTAR A INTEGRAÇÃO

### Teste Rápido no Console do Navegador

1. Abra o dashboard no navegador
2. Abra o Console (F12 → Console)
3. Execute:

```javascript
// Teste 1: Integração básica
const test1 = await n8nClient.testIntegration();
console.log('Teste 1:', test1);

// Teste 2: Análise territorial
const test2 = await n8nClient.requestTerritorialAnalysis(1, 'Palmas', 2023);
console.log('Teste 2:', test2);

// Teste 3: Análise econômica
const test3 = await n8nClient.requestEconomicAnalysis(1, 'Palmas', 2023);
console.log('Teste 3:', test3);
```

### Teste com Interface Visual

1. Abra o arquivo `exemplo-integracao.html` em um navegador
2. Clique nos botões de teste
3. Verifique os resultados exibidos

---

## 📊 PASSO 5: MONITORAR REQUISIÇÕES

### No Console do Navegador

O `N8NClient` já loga automaticamente:

```
[N8NClient] Tentativa 1/3 - POST https://galactic-ai.app.n8n.cloud/webhook/analise-territorial
[N8NClient] Sucesso - Request ID: req_1700000000000_abc123
```

### No n8n Cloud

1. Acesse: https://galactic-ai.app.n8n.cloud
2. Menu lateral → **"Executions"**
3. Veja todas as requisições recebidas
4. Clique em uma execução para ver detalhes

---

## 🔒 PASSO 6: SEGURANÇA E BOAS PRÁTICAS

### 1. Não Expor Credenciais no Frontend

❌ **NUNCA faça isso:**
```javascript
const apiKey = 'sk-abc123...'; // API Key exposta no código frontend
```

✅ **Faça isso:**
- As credenciais (OpenAI, PostgreSQL) ficam no n8n (backend)
- O dashboard só chama webhooks públicos
- O n8n valida e processa as requisições

### 2. Validar Dados no Frontend

Antes de enviar ao n8n, valide:

```javascript
function validateTerritoryId(id) {
  if (!id || id < 1 || id > 21) {
    throw new Error('ID de território inválido');
  }
}

function validateYear(year) {
  if (year < 2019 || year > 2023) {
    throw new Error('Ano deve estar entre 2019 e 2023');
  }
}
```

### 3. Implementar Rate Limiting

Evite spam de requisições:

```javascript
let lastRequestTime = 0;
const MIN_INTERVAL = 2000; // 2 segundos

async function rateLimitedRequest(fn) {
  const now = Date.now();
  const timeSinceLastRequest = now - lastRequestTime;
  
  if (timeSinceLastRequest < MIN_INTERVAL) {
    throw new Error('Aguarde alguns segundos antes de fazer outra requisição');
  }
  
  lastRequestTime = now;
  return await fn();
}

// Uso
await rateLimitedRequest(() => n8nClient.requestTerritorialAnalysis(1, 'Palmas', 2023));
```

### 4. Implementar Cache Local

Evite requisições duplicadas:

```javascript
const analysisCache = new Map();

async function getCachedAnalysis(territoryId, year) {
  const cacheKey = `${territoryId}_${year}`;
  
  if (analysisCache.has(cacheKey)) {
    console.log('Retornando análise do cache');
    return analysisCache.get(cacheKey);
  }
  
  const result = await n8nClient.requestTerritorialAnalysis(territoryId, 'Palmas', year);
  
  if (result.success) {
    analysisCache.set(cacheKey, result);
  }
  
  return result;
}
```

---

## 🐛 SOLUÇÃO DE PROBLEMAS

### Problema 1: `N8NClient is not defined`

**Causa:** Script não foi importado corretamente  
**Solução:**
1. Verifique se `<script src="/js/n8n-client.js"></script>` está no HTML
2. Verifique se o caminho está correto
3. Abra o Console e veja se há erro de carregamento

### Problema 2: CORS Error

**Causa:** Replit bloqueando requisições para n8n  
**Solução:**
1. Verifique se os headers CORS estão configurados no n8n (já estão nos workflows)
2. Se persistir, adicione proxy no backend Replit:

```javascript
// server.js (backend Replit)
app.post('/api/n8n-proxy', async (req, res) => {
  const response = await fetch('https://galactic-ai.app.n8n.cloud/webhook/analise-territorial', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(req.body)
  });
  
  const data = await response.json();
  res.json(data);
});
```

Então no frontend:
```javascript
// Mudar baseUrl para usar proxy
const n8nClient = new N8NClient({
  baseUrl: '', // Vazio = mesma origem
  webhooks: {
    territorialAnalysis: '/api/n8n-proxy'
  }
});
```

### Problema 3: Timeout

**Causa:** Análise demorando muito  
**Solução:**
1. Aumentar timeout:
```javascript
const result = await n8nClient.requestTerritorialAnalysis(1, 'Palmas', 2023);
// Ou com timeout customizado:
const result = await n8nClient.request('/webhook/analise-territorial', payload, { timeout: 120000 }); // 2 minutos
```

2. Implementar requisição assíncrona (webhook retorna imediatamente, análise é processada em background)

### Problema 4: Erro 404 no Webhook

**Causa:** Workflow não está ativo no n8n  
**Solução:**
1. Acesse n8n Cloud
2. Abra o workflow
3. Ative o toggle "Active"

---

## 📚 REFERÊNCIAS

### Métodos Disponíveis no N8NClient

```javascript
// Teste
await n8nClient.testIntegration(territoryId, territoryName)

// Análise territorial completa
await n8nClient.requestTerritorialAnalysis(territoryId, territoryName, year, indicators)

// Análises por dimensão
await n8nClient.requestEconomicAnalysis(territoryId, territoryName, year)
await n8nClient.requestSocialAnalysis(territoryId, territoryName, year)
await n8nClient.requestEnvironmentalAnalysis(territoryId, territoryName, year)

// Comparação
await n8nClient.requestComparison(territoryId, territoryName, comparisonIds, dimension, year)

// Coleta de dados
await n8nClient.requestDataCollection(territoryId, territoryName, dimension, year)

// Genérico
await n8nClient.sendDashboardRequest(requestType, territoryId, territoryName, dimension, parameters, userId, sessionId)
```

### Estrutura de Resposta

```javascript
{
  success: true,
  data: {
    // Dados específicos de cada endpoint
  },
  request_id: "req_1700000000000_abc123",
  timestamp: "2025-11-16T12:00:00.000Z"
}
```

---

## ✅ CHECKLIST DE INTEGRAÇÃO

- [ ] Arquivo `n8n-client.js` adicionado ao projeto Replit
- [ ] Script importado no HTML principal
- [ ] Instância `n8nClient` criada no código JavaScript
- [ ] Botões do dashboard conectados aos métodos do client
- [ ] Teste de integração executado com sucesso
- [ ] Análise territorial testada e funcionando
- [ ] Tratamento de erros implementado
- [ ] Loading states implementados
- [ ] Cache local implementado (opcional)
- [ ] Rate limiting implementado (opcional)
- [ ] Documentação interna atualizada

---

## 🎉 CONCLUSÃO

Parabéns! Seu dashboard agora está integrado com o sistema multi-agentes n8n Cloud.

**Próximos passos:**
1. Testar todas as funcionalidades integradas
2. Ajustar UI/UX conforme necessário
3. Implementar workflows adicionais (agentes ECON, SOCIAL, TERRA, AMBIENT)
4. Adicionar monitoramento e analytics

---

**Autor:** Manus AI  
**Data:** 16 de novembro de 2025  
**Versão:** 1.0.0
