# Orquestrador V5.0 - Explicação Detalhada

**Framework de Inteligência Territorial V6.0**  
**Data:** 08 de dezembro de 2025  
**Sessão:** #14 - Materialização da Superinteligência com Agent Registry  
**Versão:** 5.0.0

---

## 📋 ÍNDICE

1. [Visão Geral](#1-visão-geral)
2. [Diferenças V4.0 vs V5.0](#2-diferenças-v40-vs-v50)
3. [Fluxo de Trabalho Completo](#3-fluxo-de-trabalho-completo)
4. [Nós do Workflow (Detalhados)](#4-nós-do-workflow-detalhados)
5. [Exemplos de Execução](#5-exemplos-de-execução)
6. [Como Testar](#6-como-testar)
7. [Troubleshooting](#7-troubleshooting)

---

## 1. VISÃO GERAL

### O Que É o Orquestrador V5.0?

O **Orquestrador V5.0** é a evolução do V4.0 que adiciona **descoberta dinâmica de agentes** através do `agent_registry`. Ele mantém todas as capacidades da V4.0 (metadados estruturados, IDs semânticos, síntese multidimensional) e adiciona extensibilidade total.

### Principais Características

- ✅ **Descoberta Dinâmica:** Consulta `agent_registry` para descobrir agentes disponíveis
- ✅ **Prompt Adaptativo:** Gera prompt da IA baseado nos agentes ativos
- ✅ **Roteamento Flexível:** Loop dinâmico em vez de nós `IF` fixos
- ✅ **URLs Dinâmicas:** Busca URLs dos webhooks do banco de dados
- ✅ **Extensível:** Adicionar novo agente = INSERT SQL (2 minutos)
- ✅ **Compatível:** Mantém toda a estrutura de metadados V4.0

---

## 2. DIFERENÇAS V4.0 vs V5.0

### Arquitetura de Roteamento

**V4.0 (Estático):**
```
Interpretar Pergunta
    ↓
    ├─→ IF (economic?) → HTTP Request (URL fixa)
    ├─→ IF (social?) → HTTP Request (URL fixa)
    ├─→ IF (terra?) → HTTP Request (URL fixa)
    └─→ IF (ambient?) → HTTP Request (URL fixa)
```

**V5.0 (Dinâmico):**
```
Buscar Agentes Ativos (PostgreSQL)
    ↓
Preparar Contexto Dinâmico (Code)
    ↓
Interpretar Pergunta (Prompt Dinâmico)
    ↓
Loop Over Items (agent_ids)
    ├─→ Buscar URL do Agente (Code)
    └─→ HTTP Request (URL dinâmica)
```

### Tabela Comparativa

| Aspecto | V4.0 | V5.0 |
|---------|------|------|
| **Agentes** | Hard-coded (4 fixos) | Dinâmicos (via agent_registry) |
| **Prompt da IA** | Lista fixa de dimensões | Gerado dinamicamente |
| **Roteamento** | Nós IF (1 por agente) | Loop único |
| **URLs** | Hard-coded em cada nó | Buscadas do banco |
| **Adicionar Agente** | 30-45 min (modificar workflow) | 2 min (INSERT SQL) |
| **Complexidade** | Média (20+ nós) | Média-Alta (25+ nós) |
| **Metadados V4** | ✅ Sim | ✅ Sim (mantidos) |

---

## 3. FLUXO DE TRABALHO COMPLETO

### Visão Macro

```
┌─────────────────────────────────────────────────────────────┐
│ FASE 1: ENTRADA E VALIDAÇÃO                                 │
├─────────────────────────────────────────────────────────────┤
│ 1. Webhook - Recebe Requisição                              │
│ 2. IF - Validar Payload                                     │
│ 3. PostgreSQL - Buscar Território                           │
│ 4. IF - Território Existe?                                  │
│ 5. Code - Gerar request_id                                  │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ FASE 2: DESCOBERTA DINÂMICA DE AGENTES (NOVO V5.0)          │
├─────────────────────────────────────────────────────────────┤
│ 6. PostgreSQL - Buscar Agentes Ativos                       │
│ 7. Code - Preparar Contexto Dinâmico                        │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ FASE 3: INTERPRETAÇÃO INTELIGENTE                           │
├─────────────────────────────────────────────────────────────┤
│ 8. OpenAI - Interpretar Pergunta (Prompt Dinâmico)          │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ FASE 4: ROTEAMENTO DINÂMICO (NOVO V5.0)                     │
├─────────────────────────────────────────────────────────────┤
│ 9. Loop Over Items (agent_ids)                              │
│    ├─→ 10. Code - Buscar URL do Agente                      │
│    └─→ 11. HTTP Request - Chamar Agente (URL dinâmica)      │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ FASE 5: SÍNTESE E SALVAMENTO (MANTIDO V4.0)                 │
├─────────────────────────────────────────────────────────────┤
│ 12. Code - Agregar Respostas                                │
│ 13. IF - Análise Multidimensional?                          │
│ 14. OpenAI - Sintetizar Análises                            │
│ 15. PostgreSQL - Salvar na Knowledge Base                   │
│ 16. Responder ao Usuário                                    │
└─────────────────────────────────────────────────────────────┘
```

---

## 4. NÓS DO WORKFLOW (DETALHADOS)

### FASE 1: ENTRADA E VALIDAÇÃO

#### 1. Webhook - Recebe Requisição

**Tipo:** `n8n-nodes-base.webhook`  
**Método:** POST  
**Path:** `/orchestrator`

**Payload Esperado:**
```json
{
  "territory_id": "1721000",
  "question": "Como está a economia de Palmas?"
}
```

**Novo em V5.0:** Nenhuma mudança (mantido da V4.0)

---

#### 2. IF - Validar Payload

**Tipo:** `n8n-nodes-base.if`  
**Condições:**
- `territory_id` existe
- `question` existe

**Saídas:**
- **TRUE:** Prossegue para buscar território
- **FALSE:** Retorna erro 400

**Novo em V5.0:** Nenhuma mudança (mantido da V4.0)

---

#### 3. PostgreSQL - Buscar Território

**Tipo:** `n8n-nodes-base.postgres`  
**Query:**
```sql
SELECT id, name 
FROM territories 
WHERE id = '{{ $json.body.territory_id }}' 
LIMIT 1;
```

**Retorna:**
- `id`: Código IBGE
- `name`: Nome do município

**Novo em V5.0:** Nenhuma mudança (mantido da V4.0)

---

#### 4. IF - Território Existe?

**Tipo:** `n8n-nodes-base.if`  
**Condição:** Resultado da query não está vazio

**Saídas:**
- **TRUE:** Prossegue para gerar request_id
- **FALSE:** Retorna erro 404

**Novo em V5.0:** Nenhuma mudança (mantido da V4.0)

---

#### 5. Code - Gerar request_id

**Tipo:** `n8n-nodes-base.code`  
**Função:** Gera ID semântico no formato `YYYYMMDDHHmmss-req-{territory_id}`

**Código:**
```javascript
const now = new Date();
const timestamp = now.toISOString()
  .replace(/[-:T]/g, '')
  .slice(0, 14);

const territoryId = $input.first().json.body.territory_id;
const requestId = `${timestamp}-req-${territoryId}`;

return [{
  json: {
    ...$ input.first().json,
    request_id: requestId,
    timestamp: now.toISOString()
  }
}];
```

**Novo em V5.0:** Nenhuma mudança (mantido da V4.0)

---

### FASE 2: DESCOBERTA DINÂMICA DE AGENTES (NOVO V5.0)

#### 6. PostgreSQL - Buscar Agentes Ativos

**Tipo:** `n8n-nodes-base.postgres`  
**Query:**
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

**Retorna:** Lista de todos os agentes ativos

**Exemplo de Retorno:**
```json
[
  {
    "agent_id": "ambient",
    "name": "Agente Ambiental",
    "description": "Especializado em análises ambientais...",
    "webhook_url": "https://galactic-ai.app.n8n.cloud/webhook/agent-ambient",
    "version": "6.1.0"
  },
  {
    "agent_id": "economic",
    "name": "Agente Econômico",
    "description": "Especializado em análises econômicas...",
    "webhook_url": "https://galactic-ai.app.n8n.cloud/webhook/agent-econ",
    "version": "6.1.0"
  },
  ...
]
```

**🆕 NOVO EM V5.0:** Este nó não existia na V4.0. É o coração da descoberta dinâmica.

---

#### 7. Code - Preparar Contexto Dinâmico

**Tipo:** `n8n-nodes-base.code`  
**Função:** Prepara o prompt dinâmico para a IA com base nos agentes disponíveis

**Código:**
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

// Mesclar com dados da requisição original
const originalData = $('Code - Gerar request_id').first().json;

return [{
  json: {
    ...originalData,
    dynamic_context: dynamicContext
  }
}];
```

**Saída:**
```json
{
  "body": {
    "territory_id": "1721000",
    "question": "Como está a economia de Palmas?"
  },
  "request_id": "20251208153000-req-1721000",
  "dynamic_context": {
    "agents": [...],
    "dimensions_list": "- ambient: Especializado em...\n- economic: Especializado em...",
    "agent_ids": ["ambient", "economic", "social", "terra"],
    "agent_count": 4
  }
}
```

**🆕 NOVO EM V5.0:** Este nó não existia na V4.0. Prepara o contexto dinâmico para a IA.

---

### FASE 3: INTERPRETAÇÃO INTELIGENTE

#### 8. OpenAI - Interpretar Pergunta (Prompt Dinâmico)

**Tipo:** `n8n-nodes-base.openAi`  
**Modelo:** gpt-4.1-mini  
**Temperatura:** 0.3

**Prompt (DINÂMICO):**
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

RESPONDA EM JSON:
{
  "agent_ids": ["agent_id1", "agent_id2"],
  "analysis_scope": "unidimensional" ou "multidimensional",
  "territory_scope": "uniterritorial" ou "multiterritorial",
  "territories": [{"id": "1721000", "name": "Palmas"}]
}
```

**🔄 MODIFICADO EM V5.0:** 
- O prompt agora é gerado dinamicamente com base nos agentes disponíveis
- A lista de dimensões não é mais hard-coded
- A IA escolhe entre os `agent_ids` disponíveis no sistema

---

### FASE 4: ROTEAMENTO DINÂMICO (NOVO V5.0)

#### 9. Loop Over Items (agent_ids)

**Tipo:** `n8n-nodes-base.splitInBatches`  
**Modo:** Loop sobre `agent_ids`

**Função:** Itera sobre cada `agent_id` retornado pela IA

**Entrada:**
```json
{
  "agent_ids": ["economic", "social"]
}
```

**Saída:** Executa o loop 2 vezes (uma para cada agent_id)

**🆕 NOVO EM V5.0:** Substitui os múltiplos nós `IF` da V4.0

---

#### 10. Code - Buscar URL do Agente

**Tipo:** `n8n-nodes-base.code`  
**Função:** Busca a URL do webhook do agente atual no contexto dinâmico

**Código:**
```javascript
// Obter o agent_id atual do loop
const currentAgentId = $json.agent_ids[$itemIndex];

// Buscar informações do agente no contexto dinâmico
const agents = $('Code - Preparar Contexto Dinâmico').first().json.dynamic_context.agents;
const agentInfo = agents.find(agent => agent.agent_id === currentAgentId);

if (!agentInfo) {
  throw new Error(`Agente ${currentAgentId} não encontrado no agent_registry`);
}

return [{
  json: {
    ...$ json,
    current_agent: {
      agent_id: agentInfo.agent_id,
      name: agentInfo.name,
      webhook_url: agentInfo.webhook_url,
      version: agentInfo.version
    }
  }
}];
```

**Saída:**
```json
{
  "current_agent": {
    "agent_id": "economic",
    "name": "Agente Econômico",
    "webhook_url": "https://galactic-ai.app.n8n.cloud/webhook/agent-econ",
    "version": "6.1.0"
  }
}
```

**🆕 NOVO EM V5.0:** Este nó não existia na V4.0. Busca a URL dinamicamente.

---

#### 11. HTTP Request - Chamar Agente (URL Dinâmica)

**Tipo:** `n8n-nodes-base.httpRequest`  
**Método:** POST  
**URL:** `{{ $json.current_agent.webhook_url }}`

**Payload:**
```json
{
  "territory_id": "{{ $('Code - Gerar request_id').first().json.body.territory_id }}",
  "question": "{{ $('Code - Gerar request_id').first().json.body.question }}",
  "request_id": "{{ $('Code - Gerar request_id').first().json.request_id }}",
  "analysis_scope": "{{ $('OpenAI - Interpretar Pergunta').first().json.analysis_scope }}",
  "territory_scope": "{{ $('OpenAI - Interpretar Pergunta').first().json.territory_scope }}",
  "dimensions": "{{ $('OpenAI - Interpretar Pergunta').first().json.agent_ids }}",
  "territories": "{{ $('OpenAI - Interpretar Pergunta').first().json.territories }}"
}
```

**🔄 MODIFICADO EM V5.0:** 
- URL agora é dinâmica (`{{ $json.current_agent.webhook_url }}`)
- Na V4.0, cada agente tinha seu próprio nó HTTP com URL hard-coded

---

### FASE 5: SÍNTESE E SALVAMENTO (MANTIDO V4.0)

#### 12-16. Nós Finais

Os nós finais (agregação, síntese, salvamento, resposta) permanecem **idênticos à V4.0**:

- **Code - Agregar Respostas:** Coleta todas as respostas dos agentes
- **IF - Análise Multidimensional?:** Verifica se precisa sintetizar
- **OpenAI - Sintetizar Análises:** Cria síntese integrada
- **PostgreSQL - Salvar na Knowledge Base:** Salva com metadados V4
- **Responder ao Usuário:** Retorna resultado

**Novo em V5.0:** Nenhuma mudança (mantidos da V4.0)

---

## 5. EXEMPLOS DE EXECUÇÃO

### Exemplo 1: Análise Unidimensional

**Entrada:**
```json
{
  "territory_id": "1721000",
  "question": "Qual o PIB de Palmas?"
}
```

**Fluxo:**
1. Busca agentes ativos → Retorna 4 agentes
2. Prepara contexto dinâmico → Lista de 4 dimensões
3. IA interpreta → `agent_ids: ["economic"]`
4. Loop executa 1 vez → Chama Agente ECON
5. Responde diretamente (sem síntese)

---

### Exemplo 2: Análise Multidimensional

**Entrada:**
```json
{
  "territory_id": "1721000",
  "question": "Como estão a economia e a educação de Palmas?"
}
```

**Fluxo:**
1. Busca agentes ativos → Retorna 4 agentes
2. Prepara contexto dinâmico → Lista de 4 dimensões
3. IA interpreta → `agent_ids: ["economic", "social"]`
4. Loop executa 2 vezes → Chama ECON e SOCIAL
5. Sintetiza as duas análises
6. Salva síntese na knowledge_base

---

### Exemplo 3: Novo Agente Adicionado (Demographic)

**Passo 1:** Adicionar agente ao registro
```sql
INSERT INTO agent_registry (agent_id, name, description, webhook_url, is_active, version)
VALUES (
  'demographic',
  'Agente Demográfico',
  'Especializado em análises de dinâmica populacional...',
  'https://galactic-ai.app.n8n.cloud/webhook/agent-demographic',
  TRUE,
  '1.0.0'
);
```

**Passo 2:** Fazer pergunta
```json
{
  "territory_id": "1721000",
  "question": "Qual a densidade populacional de Palmas?"
}
```

**Fluxo:**
1. Busca agentes ativos → Retorna **5 agentes** (incluindo demographic)
2. Prepara contexto dinâmico → Lista de **5 dimensões**
3. IA interpreta → `agent_ids: ["demographic"]`
4. Loop executa 1 vez → Chama Agente DEMOGRAPHIC
5. Responde com análise demográfica

**✨ MAGIA DA V5.0:** O Orquestrador descobriu e usou o novo agente automaticamente, sem modificação de código!

---

## 6. COMO TESTAR

### Teste 1: Validar Descoberta de Agentes

**Query SQL:**
```sql
SELECT agent_id, name, is_active 
FROM agent_registry 
WHERE is_active = TRUE;
```

**Resultado Esperado:** 4 agentes ativos

---

### Teste 2: Análise Simples

**cURL:**
```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/orchestrator \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "question": "Qual o PIB de Palmas?"
  }'
```

**Resultado Esperado:**
- Análise econômica gerada
- Salva na `knowledge_base` com metadados V4

---

### Teste 3: Análise Multidimensional

**cURL:**
```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/orchestrator \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "question": "Como estão a economia e a educação de Palmas?"
  }'
```

**Resultado Esperado:**
- 2 análises geradas (ECON + SOCIAL)
- Síntese criada
- Todas salvas com mesmo `request_id`

---

### Teste 4: Extensibilidade (Adicionar Novo Agente)

**Passo 1:** Adicionar agente de teste
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

**Passo 2:** Fazer pergunta que acione o agente
```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/orchestrator \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "question": "Execute o agente de teste"
  }'
```

**Resultado Esperado:**
- Orquestrador descobre o novo agente
- Chama o webhook do agente de teste
- Sistema funciona sem modificações

---

## 7. TROUBLESHOOTING

### Problema: "Agente não encontrado no agent_registry"

**Causa:** A IA retornou um `agent_id` que não existe no banco

**Solução:**
1. Verificar se o agente está ativo: `SELECT * FROM agent_registry WHERE agent_id = 'xxx';`
2. Se não existe, adicionar ao registro
3. Se existe mas está inativo, ativar: `UPDATE agent_registry SET is_active = TRUE WHERE agent_id = 'xxx';`

---

### Problema: "Query ao agent_registry retorna vazio"

**Causa:** Nenhum agente ativo no registro

**Solução:**
1. Verificar agentes: `SELECT * FROM agent_registry;`
2. Ativar pelo menos um agente: `UPDATE agent_registry SET is_active = TRUE WHERE agent_id = 'economic';`

---

### Problema: "Loop não executa"

**Causa:** `agent_ids` retornado pela IA está vazio

**Solução:**
1. Verificar resposta da IA no nó "OpenAI - Interpretar Pergunta"
2. Ajustar prompt se necessário
3. Verificar se a pergunta é clara o suficiente

---

### Problema: "URL do agente está incorreta"

**Causa:** URL no `agent_registry` está desatualizada

**Solução:**
```sql
UPDATE agent_registry 
SET webhook_url = 'https://galactic-ai.app.n8n.cloud/webhook/agent-econ',
    updated_at = NOW()
WHERE agent_id = 'economic';
```

---

## 📊 COMPARAÇÃO FINAL V4.0 vs V5.0

| Métrica | V4.0 | V5.0 |
|---------|------|------|
| **Nós no Workflow** | 22 | 25 |
| **Agentes Suportados** | 4 (fixos) | Ilimitado (dinâmico) |
| **Tempo para Adicionar Agente** | 30-45 min | 2 min |
| **Modificação de Código** | Sim | Não |
| **Latência Adicional** | 0ms | ~10ms (query agent_registry) |
| **Complexidade de Manutenção** | Alta | Baixa |
| **Extensibilidade** | Limitada | Total |
| **Metadados V4** | ✅ Sim | ✅ Sim |
| **Rastreabilidade** | ✅ Sim | ✅ Sim |

---

**Fim do Documento**
