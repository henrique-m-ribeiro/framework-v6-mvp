# Guia de Implementação - Orquestrador V5.0

**Framework de Inteligência Territorial V6.0**  
**Data:** 08 de dezembro de 2025  
**Sessão:** #14 - Materialização da Superinteligência com Agent Registry  
**Versão:** 5.0.0

---

## 📋 VISÃO GERAL

Este guia fornece instruções **passo a passo** para implementar o Orquestrador V5.0 no n8n Cloud. Como o workflow é complexo (25+ nós), vamos construí-lo **incrementalmente** em vez de importar um JSON gigante.

---

## ⏱️ TEMPO ESTIMADO

- **Abordagem 1 (Incremental):** 2-3 horas
- **Abordagem 2 (Importar V4.0 + Modificar):** 1-2 horas (RECOMENDADA)

---

## 🎯 ABORDAGEM RECOMENDADA

### Opção A: Construir do Zero (Incremental)
- Mais didático
- Maior controle
- Mais demorado

### Opção B: Modificar V4.0 Existente (RECOMENDADA)
- Mais rápido
- Aproveita estrutura existente
- Foco nas mudanças V5.0

**Vamos seguir a Opção B!**

---

## 📦 PRÉ-REQUISITOS

Antes de começar, certifique-se de que:

- [x] Migração 003 executada (`agent_registry` criada e populada)
- [x] Workflow V4.0 existe no n8n Cloud (ou está disponível para importação)
- [x] Credenciais do PostgreSQL configuradas no n8n
- [x] Acesso ao n8n Cloud com permissões de edição

---

## 🚀 PASSO A PASSO

### ETAPA 1: Duplicar Workflow V4.0

1. Abra o n8n Cloud
2. Localize o workflow "WF-AGENT-ORCHESTRATOR - Orquestrador Central V4.0"
3. Clique nos 3 pontos (⋮) → **Duplicate**
4. Renomeie para: **"WF-AGENT-ORCHESTRATOR - Orquestrador Central V5.0 (Agent Registry)"**
5. Abra o workflow duplicado

**✅ Checkpoint:** Você agora tem uma cópia do V4.0 para modificar

---

### ETAPA 2: Adicionar Nó "PostgreSQL - Buscar Agentes Ativos"

**Localização:** Após o nó "Code - Gerar request_id"

**Configuração:**

1. Adicione um novo nó **PostgreSQL**
2. **Nome:** `PostgreSQL - Buscar Agentes Ativos`
3. **Operation:** Execute Query
4. **Query:**
```sql
SELECT 
  agent_id,
  name,
  description,
  webhook_url,
  version
FROM agent_registry 
WHERE is_active = TRUE
ORDER BY agent_id;
```
5. **Credentials:** Selecione suas credenciais do PostgreSQL
6. Conecte o nó "Code - Gerar request_id" a este novo nó

**✅ Checkpoint:** Execute o workflow até este ponto. Deve retornar 4 agentes.

---

### ETAPA 3: Adicionar Nó "Code - Preparar Contexto Dinâmico"

**Localização:** Após "PostgreSQL - Buscar Agentes Ativos"

**Configuração:**

1. Adicione um novo nó **Code**
2. **Nome:** `Code - Preparar Contexto Dinâmico`
3. **Mode:** Run Once for All Items
4. **JavaScript Code:**

```javascript
// Buscar agentes do nó anterior
const agents = $input.all().map(item => item.json);

// Gerar lista de dimensões dinamicamente
const dimensionsList = agents.map(agent => 
  `- ${agent.agent_id}: ${agent.description}`
).join('\n');

// Gerar lista de agent_ids para o prompt
const agentIds = agents.map(agent => agent.agent_id);

// Preparar contexto
const dynamicContext = {
  agents: agents,
  dimensions_list: dimensionsList,
  agent_ids: agentIds,
  agent_count: agents.length
};

// Buscar dados da requisição original
const originalData = $('Code - Gerar request_id').first().json;

return [{
  json: {
    ...originalData,
    dynamic_context: dynamicContext
  }
}];
```

5. Conecte "PostgreSQL - Buscar Agentes Ativos" a este nó

**✅ Checkpoint:** Execute até aqui. Deve retornar um objeto com `dynamic_context`.

---

### ETAPA 4: Modificar Nó "OpenAI - Interpretar Pergunta"

**Localização:** Nó existente da V4.0

**Modificações:**

1. Localize o nó "OpenAI - Interpretar Pergunta"
2. **Desconecte** a entrada antiga
3. **Conecte** a saída de "Code - Preparar Contexto Dinâmico" a este nó
4. **Modifique o Prompt:**

**PROMPT ANTIGO (V4.0):**
```
Você é um assistente especializado em análise territorial.

DIMENSÕES DISPONÍVEIS:
- economic: Análises econômicas (PIB, emprego, renda)
- social: Análises sociais (educação, saúde, IDH)
- terra: Análises territoriais (urbanização, infraestrutura)
- ambient: Análises ambientais (desmatamento, recursos hídricos)

[... resto do prompt ...]
```

**PROMPT NOVO (V5.0):**
```
Você é um assistente especializado em análise territorial.

AGENTES DISPONÍVEIS:
{{ $json.dynamic_context.dimensions_list }}

PERGUNTA DO USUÁRIO:
"{{ $json.body.question }}"

TERRITÓRIO:
{{ $('PostgreSQL - Buscar Território').first().json.name }} (ID: {{ $json.body.territory_id }})

TAREFA:
Analise a pergunta e identifique:
1. Quais agentes devem ser acionados (escolha um ou mais dos agent_ids disponíveis)
2. Se a análise é unidimensional ou multidimensional
3. Se envolve um ou múltiplos territórios
4. Extraia os territórios mencionados

RESPONDA EM JSON ESTRITO (sem markdown, sem explicações):
{
  "agent_ids": ["agent_id1", "agent_id2"],
  "analysis_scope": "unidimensional" ou "multidimensional",
  "territory_scope": "uniterritorial" ou "multiterritorial",
  "territories": [{"id": "1721000", "name": "Palmas"}]
}
```

5. **Salve** as modificações

**✅ Checkpoint:** Execute até aqui. A IA deve retornar JSON com `agent_ids` dinâmicos.

---

### ETAPA 5: Remover Nós IF de Roteamento

**Nós a Remover:**

1. `IF - Rotear para Economic`
2. `IF - Rotear para Social`
3. `IF - Rotear para Terra`
4. `IF - Rotear para Ambient`

**Como Remover:**

1. Selecione cada nó IF
2. Pressione **Delete** ou clique com botão direito → **Delete**
3. **Não remova** os nós HTTP Request ainda (vamos reutilizar um deles)

**✅ Checkpoint:** Os 4 nós IF foram removidos.

---

### ETAPA 6: Adicionar Nó "Loop Over Items"

**Localização:** Após "OpenAI - Interpretar Pergunta"

**Configuração:**

1. Adicione um novo nó **Split In Batches**
2. **Nome:** `Loop Over Items (agent_ids)`
3. **Batch Size:** 1
4. **Options:**
   - Reset: `true`
5. Conecte "OpenAI - Interpretar Pergunta" a este nó

**✅ Checkpoint:** O loop está configurado.

---

### ETAPA 7: Adicionar Nó "Code - Buscar URL do Agente"

**Localização:** Dentro do loop, após "Loop Over Items"

**Configuração:**

1. Adicione um novo nó **Code**
2. **Nome:** `Code - Buscar URL do Agente`
3. **Mode:** Run Once for Each Item
4. **JavaScript Code:**

```javascript
// Obter o agent_id atual do loop
const interpretationData = $('OpenAI - Interpretar Pergunta').first().json;
const agentIds = interpretationData.agent_ids;
const currentIndex = $itemIndex;
const currentAgentId = agentIds[currentIndex];

// Buscar informações do agente no contexto dinâmico
const dynamicContext = $('Code - Preparar Contexto Dinâmico').first().json.dynamic_context;
const agents = dynamicContext.agents;
const agentInfo = agents.find(agent => agent.agent_id === currentAgentId);

if (!agentInfo) {
  throw new Error(`Agente ${currentAgentId} não encontrado no agent_registry`);
}

// Buscar dados originais da requisição
const originalData = $('Code - Gerar request_id').first().json;

return [{
  json: {
    ...originalData,
    ...interpretationData,
    current_agent: {
      agent_id: agentInfo.agent_id,
      name: agentInfo.name,
      webhook_url: agentInfo.webhook_url,
      version: agentInfo.version
    }
  }
}];
```

5. Conecte "Loop Over Items" a este nó

**✅ Checkpoint:** Execute o loop. Deve retornar informações do agente atual.

---

### ETAPA 8: Modificar Nó HTTP Request (Tornar Dinâmico)

**Opção A: Modificar um dos nós HTTP existentes**

1. Localize um dos nós HTTP Request (ex: "HTTP Request - Chamar Agente ECON")
2. **Renomeie** para: `HTTP Request - Chamar Agente (Dinâmico)`
3. **Desconecte** a entrada antiga
4. **Conecte** a saída de "Code - Buscar URL do Agente" a este nó
5. **Modifique a URL:**
   - **URL Antiga:** `https://galactic-ai.app.n8n.cloud/webhook/agent-econ`
   - **URL Nova:** `{{ $json.current_agent.webhook_url }}`
6. **Modifique o Body (JSON):**

```json
{
  "territory_id": "{{ $json.body.territory_id }}",
  "question": "{{ $json.body.question }}",
  "request_id": "{{ $json.request_id }}",
  "analysis_scope": "{{ $json.analysis_scope }}",
  "territory_scope": "{{ $json.territory_scope }}",
  "dimensions": {{ $json.agent_ids }},
  "territories": {{ $json.territories }}
}
```

7. **Salve** as modificações

**Opção B: Criar novo nó HTTP Request**

Se preferir criar do zero:

1. Adicione novo nó **HTTP Request**
2. **Nome:** `HTTP Request - Chamar Agente (Dinâmico)`
3. **Method:** POST
4. **URL:** `{{ $json.current_agent.webhook_url }}`
5. **Body Content Type:** JSON
6. **Specify Body:** Using JSON
7. **JSON:** (mesmo JSON acima)
8. Conecte "Code - Buscar URL do Agente" a este nó

**✅ Checkpoint:** O nó HTTP está configurado para usar URL dinâmica.

---

### ETAPA 9: Remover Nós HTTP Antigos

**Nós a Remover:**

1. `HTTP Request - Chamar Agente ECON` (se não reutilizou)
2. `HTTP Request - Chamar Agente SOCIAL`
3. `HTTP Request - Chamar Agente TERRA`
4. `HTTP Request - Chamar Agente AMBIENT`

**Como Remover:**

1. Selecione cada nó HTTP antigo
2. Pressione **Delete**

**✅ Checkpoint:** Apenas 1 nó HTTP Request dinâmico permanece.

---

### ETAPA 10: Conectar ao Nó de Agregação

**Localização:** Após "HTTP Request - Chamar Agente (Dinâmico)"

**Configuração:**

1. Localize o nó "Code - Agregar Respostas" (já existe da V4.0)
2. **Desconecte** as entradas antigas (dos 4 nós HTTP antigos)
3. **Conecte** a saída de "HTTP Request - Chamar Agente (Dinâmico)" a este nó
4. **Modifique o código de agregação** (se necessário):

**Código Atualizado:**
```javascript
// Coletar todas as respostas dos agentes
const agentResponses = $input.all().map(item => ({
  agent_id: item.json.current_agent.agent_id,
  agent_name: item.json.current_agent.name,
  analysis: item.json.body.analysis || item.json.body.content,
  timestamp: new Date().toISOString()
}));

// Buscar metadados da interpretação
const interpretationData = $('OpenAI - Interpretar Pergunta').first().json;
const originalData = $('Code - Gerar request_id').first().json;

return [{
  json: {
    ...originalData,
    ...interpretationData,
    agent_responses: agentResponses,
    response_count: agentResponses.length
  }
}];
```

5. **Salve** as modificações

**✅ Checkpoint:** O nó de agregação está conectado ao loop dinâmico.

---

### ETAPA 11: Validar Nós Finais (Mantidos da V4.0)

Os seguintes nós devem permanecer **inalterados**:

- ✅ `IF - Análise Multidimensional?`
- ✅ `OpenAI - Sintetizar Análises`
- ✅ `PostgreSQL - Salvar na Knowledge Base`
- ✅ `Responder ao Usuário`
- ✅ Todos os nós de erro (400, 404, 500)

**Ação:** Apenas verifique se as conexões estão corretas.

**✅ Checkpoint:** Nós finais estão intactos.

---

### ETAPA 12: Testar o Workflow Completo

**Teste 1: Análise Simples (Unidimensional)**

1. **Ative** o workflow
2. Copie a URL do webhook
3. Execute o teste:

```bash
curl -X POST [SUA_URL_WEBHOOK] \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "question": "Qual o PIB de Palmas?"
  }'
```

**Resultado Esperado:**
- ✅ Busca 4 agentes ativos
- ✅ Prepara contexto dinâmico
- ✅ IA identifica `agent_ids: ["economic"]`
- ✅ Loop executa 1 vez
- ✅ Chama Agente ECON
- ✅ Retorna análise econômica

---

**Teste 2: Análise Multidimensional**

```bash
curl -X POST [SUA_URL_WEBHOOK] \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "question": "Como estão a economia e a educação de Palmas?"
  }'
```

**Resultado Esperado:**
- ✅ IA identifica `agent_ids: ["economic", "social"]`
- ✅ Loop executa 2 vezes
- ✅ Chama ECON e SOCIAL
- ✅ Sintetiza as duas análises
- ✅ Retorna síntese integrada

---

**Teste 3: Extensibilidade (Adicionar Novo Agente)**

**Passo 1:** Adicionar agente de teste ao banco
```sql
INSERT INTO agent_registry (agent_id, name, description, webhook_url, is_active, version)
VALUES (
  'test_agent',
  'Agente de Teste',
  'Agente de teste para validar extensibilidade do sistema',
  'https://webhook.site/your-unique-id',
  TRUE,
  '1.0.0'
);
```

**Passo 2:** Fazer pergunta
```bash
curl -X POST [SUA_URL_WEBHOOK] \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "question": "Execute o agente de teste"
  }'
```

**Resultado Esperado:**
- ✅ Orquestrador descobre 5 agentes (incluindo test_agent)
- ✅ IA pode escolher o test_agent
- ✅ Sistema funciona sem modificações no workflow

**🎉 SE TODOS OS TESTES PASSARAM: ORQUESTRADOR V5.0 ESTÁ OPERACIONAL!**

---

## 🐛 TROUBLESHOOTING

### Problema: "dynamic_context is undefined"

**Causa:** Nó "Code - Preparar Contexto Dinâmico" não está conectado corretamente

**Solução:**
1. Verifique a conexão: "PostgreSQL - Buscar Agentes Ativos" → "Code - Preparar Contexto Dinâmico"
2. Execute o workflow passo a passo até este nó
3. Verifique se `dynamic_context` aparece na saída

---

### Problema: "current_agent is undefined"

**Causa:** Nó "Code - Buscar URL do Agente" não está encontrando o agente

**Solução:**
1. Verifique se `agent_ids` está sendo retornado pela IA
2. Verifique se o código está acessando corretamente o contexto dinâmico
3. Adicione `console.log()` no código para debug:
```javascript
console.log('Agent IDs:', agentIds);
console.log('Current Index:', currentIndex);
console.log('Current Agent ID:', currentAgentId);
console.log('Agents:', agents);
```

---

### Problema: "Loop não executa"

**Causa:** `agent_ids` está vazio ou não é um array

**Solução:**
1. Verifique a resposta da IA no nó "OpenAI - Interpretar Pergunta"
2. Certifique-se de que o prompt está correto
3. Teste com uma pergunta mais clara (ex: "Qual o PIB de Palmas?")

---

### Problema: "Webhook URL não encontrada"

**Causa:** Agente não está no `agent_registry` ou URL está incorreta

**Solução:**
```sql
-- Verificar agentes
SELECT * FROM agent_registry WHERE agent_id = 'economic';

-- Atualizar URL se necessário
UPDATE agent_registry 
SET webhook_url = 'https://galactic-ai.app.n8n.cloud/webhook/agent-econ'
WHERE agent_id = 'economic';
```

---

## 📊 CHECKLIST FINAL

Antes de considerar a implementação completa, verifique:

- [ ] Workflow V5.0 criado e ativado
- [ ] Nó "PostgreSQL - Buscar Agentes Ativos" adicionado
- [ ] Nó "Code - Preparar Contexto Dinâmico" adicionado
- [ ] Nó "OpenAI - Interpretar Pergunta" modificado (prompt dinâmico)
- [ ] Nós IF de roteamento removidos
- [ ] Nó "Loop Over Items" adicionado
- [ ] Nó "Code - Buscar URL do Agente" adicionado
- [ ] Nó "HTTP Request" tornado dinâmico
- [ ] Nós HTTP antigos removidos
- [ ] Nó "Code - Agregar Respostas" atualizado
- [ ] Teste 1 (unidimensional) passou
- [ ] Teste 2 (multidimensional) passou
- [ ] Teste 3 (extensibilidade) passou

---

## 🎉 PRÓXIMOS PASSOS

Após implementar o Orquestrador V5.0:

1. **Atualizar os 4 Agentes para V4** (adicionar salvamento na memória + metadados)
2. **Testes End-to-End** (validar sistema completo)
3. **Validação no Banco de Dados** (verificar salvamento correto)
4. **Documentação** (registrar a sessão)

---

**Fim do Guia**
