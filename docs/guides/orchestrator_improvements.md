# 🔧 Melhorias no Orquestrador Central V5.0

## Filosofia da Mudança
Delegar à OpenAI a responsabilidade de interpretar e validar requisições, tornando o sistema mais inteligente e menos dependente de validações rígidas pré-programadas.

---

## Mudança 1: Remover o Nó "IF - Validar Payload"

### Justificativa
- A validação rígida de campos específicos limita a flexibilidade do sistema
- A OpenAI é capaz de interpretar requisições em linguagem natural e identificar informações faltantes
- Permite que o usuário faça perguntas de forma mais livre

### Ação
1. **Deletar** o nó "IF - Validar Payload"
2. **Conectar diretamente** o nó "Webhook - Recebe Requisição" ao próximo nó do fluxo

---

## Mudança 2: Transformar "Buscar Território" em "Listar Territórios"

### Nó Atual: "PostgreSQL - Buscar Território"
```sql
-- QUERY ANTIGA (REMOVE)
SELECT id, name FROM territories
WHERE id = '{{ $('Webhook - Recebe Requisição').first().json.body.territory_id }}'
LIMIT 1;
```

### Novo Nó: "PostgreSQL - Listar Territórios Disponíveis"

**Renomeie o nó para**: `PostgreSQL - Listar Territórios Disponíveis`

**Nova Query SQL**:
```sql
-- QUERY NOVA
SELECT id, name, type, parent_id 
FROM territories
ORDER BY name ASC;
```

### Justificativa
- Fornece contexto completo para a OpenAI decidir qual território está sendo referenciado
- Permite que a OpenAI identifique territórios mesmo com nomes aproximados ou variações
- Alinha com o padrão do nó "PostgreSQL - Buscar Agentes Ativos"

---

## Mudança 3: Ajustar o Nó "Código - Preparar Contexto Dinâmico"

### Objetivo
Preparar um contexto rico para a OpenAI com:
- Lista de territórios disponíveis
- Lista de agentes ativos
- Requisição do usuário

### Código JavaScript Atualizado

```javascript
// ============================================================================
// NÓ: PREPARAR CONTEXTO DINÂMICO (V6 - SIMPLIFICADO)
// ============================================================================

const webhookData = $('Webhook - Recebe Requisição').first().json;
const territoriesData = $('PostgreSQL - Listar Territórios Disponíveis').all();
const agentsData = $('PostgreSQL - Buscar Agentes Ativos').all();

// Extrair dados da requisição
const requestBody = webhookData.body || {};
const taskId = requestBody.task_id || `task_${Date.now()}`;
const question = requestBody.question || '';
const parameters = requestBody.parameters || {};

// Montar lista de territórios disponíveis
const territoriesList = territoriesData.map(item => ({
  id: item.json.id,
  name: item.json.name,
  type: item.json.type || 'unknown',
  parent_id: item.json.parent_id || null
}));

// Montar lista de agentes disponíveis
const agentsList = agentsData.map(item => ({
  id: item.json.id,
  name: item.json.name,
  description: item.json.description,
  capabilities: item.json.capabilities,
  webhook_url: item.json.webhook_url
}));

// Preparar contexto para a OpenAI
const context = {
  task_id: taskId,
  request: {
    question: question,
    parameters: parameters,
    suggested_territory_id: requestBody.territory_id || null,
    suggested_territory_name: requestBody.territory_name || null
  },
  available_territories: territoriesList,
  available_agents: agentsList,
  system_info: {
    timestamp: new Date().toISOString(),
    orchestrator_version: '5.0'
  }
};

return { json: context };
```

---

## Mudança 4: Atualizar o Prompt da OpenAI

### Nó: "OpenAI - Interpretar Requisição"

**Novo Prompt do Sistema**:
```
Você é o Orquestrador Central de um sistema de inteligência territorial para o Estado do Tocantins.

Sua função é:
1. VALIDAR a requisição do usuário
2. IDENTIFICAR o território referenciado (usando a lista de territórios disponíveis)
3. SELECIONAR os agentes especializados necessários para responder à pergunta
4. PREPARAR as tarefas específicas para cada agente

TERRITÓRIOS DISPONÍVEIS:
{{ JSON.stringify($json.available_territories, null, 2) }}

AGENTES DISPONÍVEIS:
{{ JSON.stringify($json.available_agents, null, 2) }}

REQUISIÇÃO DO USUÁRIO:
Pergunta: {{ $json.request.question }}
Território sugerido (ID): {{ $json.request.suggested_territory_id }}
Território sugerido (Nome): {{ $json.request.suggested_territory_name }}
Parâmetros: {{ JSON.stringify($json.request.parameters, null, 2) }}

INSTRUÇÕES:
1. Se a requisição for inválida ou incompleta, retorne um JSON com "status": "invalid" e explique o problema em "error_message"
2. Se o território não for identificado, retorne "status": "invalid" e peça mais informações
3. Se tudo estiver válido, retorne um JSON com:
   - "status": "valid"
   - "territory": { "id": "...", "name": "..." }
   - "selected_agents": [ lista de IDs dos agentes necessários ]
   - "agent_tasks": { "agent_id": "tarefa específica para este agente", ... }
   - "synthesis_strategy": "como sintetizar as respostas dos agentes"

FORMATO DE RESPOSTA (JSON):
{
  "status": "valid" | "invalid",
  "error_message": "...", // apenas se status = invalid
  "territory": {
    "id": "TO",
    "name": "Tocantins"
  },
  "selected_agents": ["econ", "social"],
  "agent_tasks": {
    "econ": "Analise os principais indicadores econômicos do Tocantins entre 2019-2023",
    "social": "Analise os principais desafios sociais do Tocantins entre 2019-2023"
  },
  "synthesis_strategy": "Relacione os desafios econômicos com os desafios sociais, identificando causas e consequências mútuas"
}
```

---

## Mudança 5: Adicionar Tratamento de Requisições Inválidas

### Novo Nó: "IF - Requisição Válida?"

**Adicione após o nó "OpenAI - Interpretar Requisição"**

**Condição**:
- Value 1: `$json.status`
- Operation: `is equal to` (String)
- Value 2: `valid`

**True Branch**: Continua o fluxo normal (Split Out, HTTP Request para agentes, etc.)

**False Branch**: Novo nó "Respond to Webhook - Erro de Validação"

### Novo Nó: "Respond to Webhook - Erro de Validação"

**Tipo**: Respond to Webhook

**Response Body**:
```javascript
{
  "status": "error",
  "error_type": "invalid_request",
  "message": "{{ $json.error_message }}",
  "task_id": "{{ $json.task_id }}",
  "timestamp": "{{ new Date().toISOString() }}"
}
```

---

## Fluxo Atualizado

```
Webhook - Recebe Requisição
  ↓
PostgreSQL - Listar Territórios Disponíveis
  ↓
PostgreSQL - Buscar Agentes Ativos
  ↓
Código - Preparar Contexto Dinâmico
  ↓
OpenAI - Interpretar Requisição
  ↓
IF - Requisição Válida?
  ├─ TRUE → Split Out → HTTP Request (agentes) → ...
  └─ FALSE → Respond to Webhook - Erro de Validação
```

---

## Benefícios das Mudanças

1. ✅ **Maior flexibilidade**: Aceita requisições em linguagem natural
2. ✅ **Validação inteligente**: OpenAI identifica problemas e sugere correções
3. ✅ **Menos dependências**: Não precisa de `territory_id` exato no payload
4. ✅ **Melhor experiência**: Usuário pode fazer perguntas de forma mais livre
5. ✅ **Mais robusto**: Sistema se adapta a variações nos dados de entrada
6. ✅ **Alinhamento arquitetural**: Todos os nós de contexto seguem o mesmo padrão

---

## Próximos Passos

1. ✅ Remover nó "IF - Validar Payload"
2. ✅ Renomear e atualizar query do nó de territórios
3. ✅ Atualizar código do nó "Preparar Contexto Dinâmico"
4. ✅ Atualizar prompt da OpenAI
5. ✅ Adicionar nó "IF - Requisição Válida?"
6. ✅ Adicionar nó "Respond to Webhook - Erro de Validação"
7. ✅ Testar com requisições válidas e inválidas
