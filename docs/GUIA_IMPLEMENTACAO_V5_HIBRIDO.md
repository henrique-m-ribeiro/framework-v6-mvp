# Guia Híbrido de Implementação - Orquestrador V5.0

**Framework de Inteligência Territorial V6.0**  
**Data:** 08 de dezembro de 2025  
**Sessão:** #14  
**Abordagem:** Híbrida (Mais Eficiente)

---

## 🎯 ESTRATÉGIA HÍBRIDA

Após análise, a melhor abordagem para implementar o Orquestrador V5.0 é:

1. ✅ **Usar o Orquestrador V4.0 existente como base**
2. ✅ **Fazer modificações incrementais específicas**
3. ✅ **Testar cada modificação antes de prosseguir**

**Por quê?**
- Evita erros de importação de JSON complexo
- Aproveita configurações já funcionais (credenciais, conexões)
- Mais didático e controlável
- Tempo total: 1-2 horas vs 3-4 horas do zero

---

## 📋 MODIFICAÇÕES NECESSÁRIAS (V4.0 → V5.0)

### Resumo das Mudanças

| # | Ação | Tipo | Tempo |
|---|------|------|-------|
| 1 | Adicionar nó "PostgreSQL - Buscar Agentes Ativos" | Novo | 5 min |
| 2 | Adicionar nó "Code - Preparar Contexto Dinâmico" | Novo | 10 min |
| 3 | Modificar prompt do nó "OpenAI - Interpretar" | Editar | 5 min |
| 4 | Adicionar nó "Split In Batches" (Loop) | Novo | 5 min |
| 5 | Adicionar nó "Code - Buscar URL do Agente" | Novo | 10 min |
| 6 | Modificar nó "HTTP Request" para URL dinâmica | Editar | 10 min |
| 7 | Remover nós IF e HTTP antigos | Deletar | 5 min |
| 8 | Ajustar nó "Code - Agregar Respostas" | Editar | 10 min |
| 9 | Testar workflow completo | Teste | 20 min |

**Total:** ~80 minutos

---

## 🚀 PASSO A PASSO DETALHADO

### PREPARAÇÃO

1. Abra o n8n Cloud
2. Localize "WF-AGENT-ORCHESTRATOR - Orquestrador Central V4.0"
3. Clique em **Duplicate**
4. Renomeie para: "WF-AGENT-ORCHESTRATOR - Orquestrador Central V5.0 (Agent Registry)"
5. Abra o workflow duplicado

---

### MODIFICAÇÃO 1: Adicionar "PostgreSQL - Buscar Agentes Ativos"

**Posição:** Após o nó "Set - Criar Payload V4"

**Passos:**

1. Clique no **+** após "Set - Criar Payload V4"
2. Procure por **"Postgres"**
3. Selecione **"Postgres"**
4. Configure:
   - **Operation:** Execute Query
   - **Query:**
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
   - **Credentials:** Selecione "Postgres Replit" (ou suas credenciais)
5. **Rename** o nó para: `PostgreSQL - Buscar Agentes Ativos`
6. Adicione **Notes:**
   ```
   ═══════════════════════════════════════════════════════════════
   DESCOBERTA DINÂMICA DE AGENTES (NOVO EM V5.0)
   ═══════════════════════════════════════════════════════════════
   
   Busca todos os agentes ativos no agent_registry.
   
   RETORNA:
   - agent_id: Identificador único
   - name: Nome legível
   - description: Descrição da especialidade
   - webhook_url: URL do webhook
   - version: Versão do agente
   ```
7. Clique em **Execute Node** para testar
8. **Resultado esperado:** 4 registros (ambient, economic, social, terra)

---

### MODIFICAÇÃO 2: Adicionar "Code - Preparar Contexto Dinâmico"

**Posição:** Após "PostgreSQL - Buscar Agentes Ativos"

**Passos:**

1. Clique no **+** após "PostgreSQL - Buscar Agentes Ativos"
2. Procure por **"Code"**
3. Selecione **"Code"**
4. Configure:
   - **Mode:** Run Once for All Items
   - **JavaScript Code:**
   
```javascript
// ═══════════════════════════════════════════════════════════════
// PREPARAR CONTEXTO DINÂMICO PARA A IA (NOVO EM V5.0)
// ═══════════════════════════════════════════════════════════════

// 1. Buscar agentes do nó anterior
const agents = $input.all().map(item => item.json);

console.log(`[V5.0] Agentes descobertos: ${agents.length}`);

// 2. Gerar lista de dimensões dinamicamente para o prompt da IA
const dimensionsList = agents.map(agent => 
  `- ${agent.agent_id}: ${agent.description}`
).join('\n');

// 3. Extrair agent_ids para referência
const agentIds = agents.map(agent => agent.agent_id);

// 4. Criar contexto dinâmico
const dynamicContext = {
  agents: agents,
  dimensions_list: dimensionsList,
  agent_ids: agentIds,
  agent_count: agents.length
};

// 5. Buscar dados da requisição original
const originalData = $('Set - Criar Payload V4').first().json;

// 6. Mesclar tudo
return [{
  json: {
    ...originalData,
    dynamic_context: dynamicContext
  }
}];
```

5. **Rename** o nó para: `Code - Preparar Contexto Dinâmico`
6. Adicione **Notes:**
   ```
   ═══════════════════════════════════════════════════════════════
   PREPARAR CONTEXTO DINÂMICO (NOVO EM V5.0)
   ═══════════════════════════════════════════════════════════════
   
   Prepara o prompt dinâmico para a IA com base nos agentes disponíveis.
   
   SAÍDA:
   - dynamic_context.agents: Array de agentes
   - dynamic_context.dimensions_list: String formatada para o prompt
   - dynamic_context.agent_ids: Array de IDs
   - dynamic_context.agent_count: Número de agentes
   ```
7. Clique em **Execute Node** para testar
8. **Resultado esperado:** Objeto com `dynamic_context` preenchido

---

### MODIFICAÇÃO 3: Modificar "OpenAI - Interpretar Requisição"

**Localização:** Nó existente

**Passos:**

1. Localize o nó "OpenAI - Interpretar Requisição"
2. **Desconecte** a entrada atual
3. **Conecte** a saída de "Code - Preparar Contexto Dinâmico" a este nó
4. Clique no nó para editar
5. Modifique o **System Message:**

**ANTES (V4.0):**
```
Você é um especialista em análise de dados territoriais e políticas públicas...

Base de territórios disponíveis:
- Palmas: 1721000
- Araguaína: 1702109
...

RESPONDA APENAS COM UM OBJETO JSON NO SEGUINTE FORMATO:
{
  "analysis_scope": "unidimensional" ou "multidimensional",
  "territory_scope": "uniterritorial" ou "multiterritorial",
  "dimensions": ["economic", "social", ...],
  "territories": [{...}]
}
```

**DEPOIS (V5.0):**
```
Você é um especialista em análise de dados territoriais e políticas públicas. Sua função é interpretar perguntas de usuários e identificar quais agentes especialistas devem ser acionados.

AGENTES DISPONÍVEIS NO SISTEMA:
{{ $json.dynamic_context.dimensions_list }}

Base de territórios disponíveis:
- Palmas: 1721000
- Araguaína: 1702109
- Gurupi: 1709500
- Porto Nacional: 1718204
- Paraíso do Tocantins: 1716109

TAREFA:
Analise a pergunta do usuário e identifique:
1. Quais agentes devem ser acionados (escolha um ou mais dos agent_ids disponíveis acima)
2. Se a análise é unidimensional (1 agente) ou multidimensional (2+ agentes)
3. Se envolve um território (uniterritorial) ou múltiplos territórios (multiterritorial)
4. Extraia os territórios mencionados

RESPONDA APENAS COM UM OBJETO JSON NO SEGUINTE FORMATO:
{
  "agent_ids": ["agent_id1", "agent_id2"],
  "analysis_scope": "unidimensional" ou "multidimensional",
  "territory_scope": "uniterritorial" ou "multiterritorial",
  "territories": [{"id": "1721000", "name": "Palmas"}]
}

IMPORTANTE: Use APENAS agent_ids que existem na lista de AGENTES DISPONÍVEIS acima.
```

6. Modifique o **User Message** para:
```
{{ $json.question }}
```

7. **Salve** as modificações
8. Atualize as **Notes:**
```
═══════════════════════════════════════════════════════════════
INTERPRETAÇÃO INTELIGENTE COM PROMPT DINÂMICO (V5.0)
═══════════════════════════════════════════════════════════════

Usa GPT-4.1-mini para analisar a pergunta e identificar:
- agent_ids: Quais agentes acionar (DINÂMICO)
- analysis_scope: unidimensional ou multidimensional
- territory_scope: uniterritorial ou multiterritorial
- territories: Array de territórios envolvidos

NOVO EM V5.0:
- Prompt é gerado dinamicamente com base no agent_registry
- IA escolhe entre os agent_ids disponíveis no sistema
- Sistema se adapta automaticamente a novos agentes
```

---

### MODIFICAÇÃO 4: Adicionar "Split In Batches" (Loop)

**Posição:** Após "Set - Criar Payload V4" (que processa a resposta da IA)

**Passos:**

1. Localize o nó "Set - Criar Payload V4"
2. Clique no **+** após este nó
3. Procure por **"Split In Batches"**
4. Configure:
   - **Batch Size:** 1
   - **Options → Reset:** true
5. **Rename** para: `Loop Over Items (agent_ids)`
6. Adicione **Notes:**
```
═══════════════════════════════════════════════════════════════
LOOP DINÂMICO SOBRE AGENTES (NOVO EM V5.0)
═══════════════════════════════════════════════════════════════

Itera sobre cada agent_id retornado pela IA.

SUBSTITUI: Os 4 nós IF da V4.0
VANTAGEM: Funciona com qualquer número de agentes
```

---

### MODIFICAÇÃO 5: Adicionar "Code - Buscar URL do Agente"

**Posição:** Dentro do loop, após "Split In Batches"

**Passos:**

1. Clique no **+** após "Loop Over Items"
2. Adicione um nó **Code**
3. Configure:
   - **Mode:** Run Once for Each Item
   - **JavaScript Code:**

```javascript
// ═══════════════════════════════════════════════════════════════
// BUSCAR URL DO AGENTE DINAMICAMENTE (NOVO EM V5.0)
// ═══════════════════════════════════════════════════════════════

// 1. Obter dados da interpretação da IA
const interpretationData = $('Set - Criar Payload V4').first().json;
const agentIds = interpretationData.dimensions; // Array de agent_ids

// 2. Identificar qual agente estamos processando no loop atual
const currentIndex = $itemIndex;
const currentAgentId = agentIds[currentIndex];

console.log(`[V5.0 Loop] Processando agente ${currentIndex + 1}/${agentIds.length}: ${currentAgentId}`);

// 3. Buscar informações do agente no contexto dinâmico
const dynamicContext = $('Code - Preparar Contexto Dinâmico').first().json.dynamic_context;
const agents = dynamicContext.agents;
const agentInfo = agents.find(agent => agent.agent_id === currentAgentId);

// 4. Validar se o agente foi encontrado
if (!agentInfo) {
  throw new Error(`[V5.0 ERRO] Agente '${currentAgentId}' não encontrado no agent_registry. Agentes disponíveis: ${agents.map(a => a.agent_id).join(', ')}`);
}

console.log(`[V5.0 Loop] Agente encontrado: ${agentInfo.name} (${agentInfo.webhook_url})`);

// 5. Retornar dados completos para o próximo nó
return [{
  json: {
    ...interpretationData,
    current_agent: {
      agent_id: agentInfo.agent_id,
      name: agentInfo.name,
      webhook_url: agentInfo.webhook_url,
      version: agentInfo.version,
      description: agentInfo.description
    },
    loop_index: currentIndex,
    total_agents: agentIds.length
  }
}];
```

4. **Rename** para: `Code - Buscar URL do Agente`
5. Adicione **Notes:**
```
═══════════════════════════════════════════════════════════════
BUSCAR URL DINÂMICA DO AGENTE (NOVO EM V5.0)
═══════════════════════════════════════════════════════════════

Para cada agent_id no loop, busca:
- webhook_url: URL do webhook do agente
- name: Nome do agente
- version: Versão do agente

SAÍDA:
- current_agent: Objeto com informações do agente atual
```

---

### MODIFICAÇÃO 6: Modificar "HTTP Request" para URL Dinâmica

**Localização:** Reutilizar um dos nós HTTP existentes

**Passos:**

1. Localize um dos nós "HTTP Request - Chamar Agente ECON" (ou qualquer outro)
2. **Desconecte** todas as entradas antigas
3. **Conecte** a saída de "Code - Buscar URL do Agente" a este nó
4. Clique no nó para editar
5. **Rename** para: `HTTP Request - Chamar Agente (Dinâmico)`
6. Modifique a **URL:**
   - **ANTES:** `https://galactic-ai.app.n8n.cloud/webhook/agent-econ`
   - **DEPOIS:** `{{ $json.current_agent.webhook_url }}`
7. Modifique o **Body (JSON):**

```json
{
  "territory_id": "{{ $json.territories[0].id }}",
  "question": "{{ $json.question }}",
  "request_id": "{{ $json.request_id }}",
  "analysis_scope": "{{ $json.analysis_scope }}",
  "territory_scope": "{{ $json.territory_scope }}",
  "dimensions": {{ $json.dimensions }},
  "territories": {{ $json.territories }},
  "current_agent": {
    "agent_id": "{{ $json.current_agent.agent_id }}",
    "name": "{{ $json.current_agent.name }}"
  }
}
```

8. **Salve** as modificações
9. Atualize as **Notes:**
```
═══════════════════════════════════════════════════════════════
CHAMAR AGENTE COM URL DINÂMICA (V5.0)
═══════════════════════════════════════════════════════════════

Chama o agente usando a URL buscada dinamicamente do agent_registry.

ANTES (V4.0): URL hard-coded, 1 nó por agente
DEPOIS (V5.0): URL dinâmica, 1 nó para todos os agentes

VANTAGEM: Adicionar novo agente não requer modificar este nó
```

---

### MODIFICAÇÃO 7: Remover Nós Antigos

**Nós a Deletar:**

1. `IF - Rotear para Economic`
2. `IF - Rotear para Social`
3. `IF - Rotear para Terra`
4. `IF - Rotear para Ambient`
5. `HTTP Request - Chamar Agente SOCIAL` (se não reutilizou)
6. `HTTP Request - Chamar Agente TERRA` (se não reutilizou)
7. `HTTP Request - Chamar Agente AMBIENT` (se não reutilizou)

**Como Deletar:**

1. Selecione cada nó
2. Pressione **Delete** ou clique com botão direito → **Delete**

---

### MODIFICAÇÃO 8: Ajustar "Code - Agregar Respostas"

**Localização:** Nó existente após os HTTP Requests

**Passos:**

1. Localize o nó "Code - Agregar Respostas"
2. **Desconecte** as entradas antigas (dos 4 nós HTTP antigos)
3. **Conecte** a saída de "HTTP Request - Chamar Agente (Dinâmico)" a este nó
4. Clique no nó para editar
5. Modifique o **JavaScript Code:**

```javascript
// ═══════════════════════════════════════════════════════════════
// AGREGAR RESPOSTAS DOS AGENTES (ATUALIZADO PARA V5.0)
// ═══════════════════════════════════════════════════════════════

// 1. Coletar todas as respostas dos agentes
const agentResponses = $input.all().map(item => ({
  agent_id: item.json.current_agent.agent_id,
  agent_name: item.json.current_agent.name,
  agent_version: item.json.current_agent.version,
  analysis: item.json.body.analysis || item.json.body.content || item.json.body,
  timestamp: new Date().toISOString()
}));

console.log(`[V5.0] Agregando ${agentResponses.length} respostas de agentes`);

// 2. Buscar metadados da interpretação
const interpretationData = $('Set - Criar Payload V4').first().json;

// 3. Retornar dados agregados
return [{
  json: {
    ...interpretationData,
    agent_responses: agentResponses,
    response_count: agentResponses.length
  }
}];
```

6. **Salve** as modificações
7. Atualize as **Notes:**
```
═══════════════════════════════════════════════════════════════
AGREGAR RESPOSTAS (ATUALIZADO PARA V5.0)
═══════════════════════════════════════════════════════════════

Coleta todas as respostas dos agentes chamados no loop.

ATUALIZAÇÃO V5.0:
- Agora processa respostas de qualquer número de agentes
- Inclui metadados do agente (id, name, version)
```

---

### MODIFICAÇÃO 9: Testar Workflow Completo

**Teste 1: Análise Simples**

1. **Ative** o workflow
2. Copie a URL do webhook
3. Execute:

```bash
curl -X POST [SUA_URL_WEBHOOK] \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "question": "Qual o PIB de Palmas?"
  }'
```

**Resultado Esperado:**
- ✅ Busca 4 agentes do agent_registry
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

**Teste 3: Extensibilidade (Novo Agente)**

**Passo 1:** Adicionar agente de teste
```sql
INSERT INTO agent_registry (agent_id, name, description, webhook_url, is_active, version)
VALUES (
  'test_agent',
  'Agente de Teste',
  'Agente de teste para validar extensibilidade do sistema V5.0',
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

## 📊 CHECKLIST FINAL

- [ ] Workflow V5.0 duplicado do V4.0
- [ ] Nó "PostgreSQL - Buscar Agentes Ativos" adicionado
- [ ] Nó "Code - Preparar Contexto Dinâmico" adicionado
- [ ] Nó "OpenAI - Interpretar" modificado (prompt dinâmico)
- [ ] Nó "Split In Batches" (Loop) adicionado
- [ ] Nó "Code - Buscar URL do Agente" adicionado
- [ ] Nó "HTTP Request" tornado dinâmico
- [ ] Nós IF e HTTP antigos removidos
- [ ] Nó "Code - Agregar Respostas" atualizado
- [ ] Teste 1 (unidimensional) passou
- [ ] Teste 2 (multidimensional) passou
- [ ] Teste 3 (extensibilidade) passou

---

## 🎯 PRÓXIMOS PASSOS

Após implementar o Orquestrador V5.0:

1. **Atualizar os 4 Agentes para V4** (adicionar salvamento na memória + metadados)
2. **Testes End-to-End** (validar sistema completo)
3. **Validação no Banco de Dados** (verificar salvamento correto)
4. **Documentação** (registrar a sessão)

---

**Tempo Total Estimado:** 1-2 horas  
**Complexidade:** Média  
**Resultado:** Orquestrador V5.0 totalmente funcional e extensível

---

**Fim do Guia**
