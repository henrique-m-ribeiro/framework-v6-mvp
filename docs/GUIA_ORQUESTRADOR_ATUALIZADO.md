# 🎯 Guia Atualizado: Alterações no Orquestrador V2.0

**Data:** 02/12/2025  
**Workflow:** WF-AGENT-ORCHESTRATOR - Orquestrador Central V2.0

---

## 📌 Estrutura Atual do Workflow

O orquestrador possui **12 nós**:

| # | Nome do Nó | Tipo | Ação |
| :--- | :--- | :--- | :--- |
| 1 | Webhook - Recebe Requisição | Webhook | ✅ Manter |
| 2 | Validar Entrada | Code | ✏️ Modificar (adicionar timestamp) |
| 3 | Enriquecer Dados | PostgreSQL | ✅ Manter |
| 4 | Normalizar Dados | Code | ✅ Manter |
| 5 | Classificar Pergunta (OpenAI) | OpenAI | ✅ Manter |
| 6 | Preparar Payload | Code | ✅ Manter |
| 7 | Rotear para Especialista | Switch/Rules | ✅ Manter |
| 8 | Chamar Agente ECON | HTTP Request | ✏️ Modificar (timeout) |
| 9 | Chamar Agente SOCIAL | HTTP Request | ✏️ Modificar (timeout) |
| 10 | Chamar Agente TERRA | HTTP Request | ✏️ Modificar (timeout) |
| 11 | Chamar Agente AMBIENT | HTTP Request | ✏️ Modificar (timeout) |
| 12 | Responder ao Usuário | Webhook Response | ✅ Manter (por enquanto) |

**Novos nós a adicionar:**
- **Extrair Análise Retornada** (Code)
- **Calcular Tempo de Execução** (Code)
- **Salvar em knowledge_base** (PostgreSQL)
- **Buscar Análise Completa** (PostgreSQL)
- **Preparar Resposta Rica** (Code)

---

## 🔧 ALTERAÇÃO 1: Modificar "Validar Entrada" - Adicionar Timestamp

### Objetivo
Capturar o timestamp inicial para calcular o tempo de execução da análise.

### Passo a Passo

1. **Abrir o nó "Validar Entrada"**
   - Dê duplo clique no nó

2. **Localizar o código JavaScript**
   - Você verá o código atual que valida os campos obrigatórios

3. **Adicionar timestamp ao retorno**
   - Localize a linha `return {` no final do código
   - Modifique o retorno para incluir o timestamp:

**Código atual (final):**
```javascript
// Retornar dados validados
return {
  territory_id,
  question,
  territory_name: webhookData.territory_name || null,
  analysis_type: webhookData.analysis_type || null
};
```

**Novo código (com timestamp):**
```javascript
// Retornar dados validados
return {
  territory_id,
  question,
  territory_name: webhookData.territory_name || null,
  analysis_type: webhookData.analysis_type || null,
  timestamp: new Date().toISOString() // ⭐ ADICIONAR ESTA LINHA
};
```

4. **Salvar o nó**

---

## 🔧 ALTERAÇÃO 2: Modificar Nós "Chamar Agente *" - Aumentar Timeout

### Objetivo
Garantir que o orquestrador aguarde a resposta completa dos agentes (até 60 segundos).

### Aplicar em TODOS os 4 nós:
- Chamar Agente ECON
- Chamar Agente SOCIAL
- Chamar Agente TERRA
- Chamar Agente AMBIENT

### Passo a Passo (para cada nó)

1. **Abrir o nó "Chamar Agente ECON"** (depois repita para os outros 3)
   - Dê duplo clique no nó

2. **Configurar Timeout**
   - Procure a seção **"Options"** ou **"Advanced Options"**
   - Localize o campo **"Timeout"**
   - Altere para: **60000** (60 segundos em milissegundos)

3. **Configurar Response Format**
   - No campo **"Response Format"**, selecione: **JSON**
   - (Se já estiver em JSON, deixe como está)

4. **Salvar o nó**

5. **Repetir para os outros 3 agentes**

---

## ➕ ALTERAÇÃO 3: Adicionar Nó "Extrair Análise Retornada"

### Objetivo
Fazer parse da resposta do agente e preparar dados para salvamento.

### Passo a Passo

1. **Adicionar novo nó Code**
   - Clique no **+** após os nós "Chamar Agente *"
   - **IMPORTANTE**: Este nó deve receber a saída de TODOS os 4 agentes
   - Selecione **Code** → **Run JavaScript Code**
   - Renomeie para: **"Extrair Análise Retornada"**

2. **Adicionar código JavaScript**

```javascript
// ============================================================================
// EXTRAIR ANÁLISE RETORNADA PELO AGENTE
// Arquitetura V2.0 - Orquestrador
// ============================================================================

// Obter resposta do agente
const agentResponse = $input.first().json;

// Validar se a resposta contém os campos necessários
if (!agentResponse || !agentResponse.analysis_id) {
  throw new Error('Resposta do agente inválida ou incompleta');
}

// Extrair informações da análise
const analysisData = {
  // IDs e referências
  analysis_id: agentResponse.analysis_id,
  dimension: agentResponse.dimension,
  
  // Conteúdo da análise
  analysis_content: agentResponse.analysis_content,
  summary: agentResponse.summary || agentResponse.analysis_content.substring(0, 500),
  
  // Métricas
  confidence_score: agentResponse.confidence_score || 0.80,
  indicators_used: agentResponse.indicators_used || [],
  
  // Metadados
  created_at: agentResponse.created_at || new Date().toISOString(),
  
  // Dados da pergunta original (do webhook)
  original_question: $('Validar Entrada').first().json.question,
  territory_id: $('Validar Entrada').first().json.territory_id
};

// Calcular total de indicadores analisados
const indicatorsCount = Array.isArray(analysisData.indicators_used) 
  ? analysisData.indicators_used.length 
  : 0;

// Preparar dados para salvamento em knowledge_base V2.0
return {
  json: {
    // Dados da análise dimensional
    ...analysisData,
    
    // Novos campos para knowledge_base V2.0
    question_type: 'single_dimension',
    dimensions_analyzed: [analysisData.dimension],
    source_analyses: {
      [analysisData.dimension]: analysisData.analysis_id
    },
    integrated_analysis: analysisData.analysis_content,
    executive_summary: analysisData.summary,
    key_insights: {
      [analysisData.dimension]: analysisData.summary
    },
    overall_confidence_score: analysisData.confidence_score,
    total_indicators_analyzed: indicatorsCount,
    orchestrator_version: 'v2.0',
    execution_time_seconds: null // Será calculado no próximo nó
  }
};
```

3. **Conectar os nós**
   - Conecte a saída de **todos os 4 agentes** (ECON, SOCIAL, TERRA, AMBIENT) para este novo nó
   - No n8n, você pode ter múltiplas entradas em um mesmo nó

4. **Salvar o nó**

---

## ➕ ALTERAÇÃO 4: Adicionar Nó "Calcular Tempo de Execução"

### Objetivo
Calcular o tempo total desde o recebimento da requisição até a conclusão da análise.

### Passo a Passo

1. **Adicionar novo nó Code**
   - Clique no **+** após "Extrair Análise Retornada"
   - Selecione **Code** → **Run JavaScript Code**
   - Renomeie para: **"Calcular Tempo de Execução"**

2. **Adicionar código JavaScript**

```javascript
// ============================================================================
// CALCULAR TEMPO DE EXECUÇÃO
// Arquitetura V2.0 - Orquestrador
// ============================================================================

// Obter timestamp do início (do nó Validar Entrada)
const startTime = new Date($('Validar Entrada').first().json.timestamp);
const endTime = new Date();

// Calcular tempo de execução em segundos
const executionTimeSeconds = (endTime - startTime) / 1000;

// Adicionar ao payload
const data = $input.first().json;
data.execution_time_seconds = executionTimeSeconds;

return {
  json: data
};
```

3. **Salvar o nó**

---

## ➕ ALTERAÇÃO 5: Adicionar Nó "Salvar em knowledge_base"

### Objetivo
Salvar a análise consolidada na tabela `knowledge_base` V2.0.

### Passo a Passo

1. **Adicionar novo nó PostgreSQL**
   - Clique no **+** após "Calcular Tempo de Execução"
   - Selecione **PostgreSQL**
   - Renomeie para: **"Salvar em knowledge_base"**

2. **Configurar credenciais**
   - Selecione: **"Postgres Replit"** (ou a credencial que você usa)

3. **Configurar Operation**
   - Selecione: **"Execute Query"**

4. **Adicionar query SQL**

```sql
INSERT INTO knowledge_base (
  -- Identificação
  territory_id,
  
  -- Pergunta original
  original_question,
  question_type,
  dimensions_analyzed,
  
  -- Análise consolidada
  integrated_analysis,
  executive_summary,
  key_insights,
  
  -- Referências às análises dimensionais
  source_analyses,
  
  -- Métricas
  overall_confidence_score,
  total_indicators_analyzed,
  
  -- Metadados do orquestrador
  orchestrator_version,
  execution_time_seconds,
  generated_by,
  
  -- Colunas legadas (compatibilidade)
  dimension,
  content,
  summary,
  confidence_score,
  embedding,
  
  -- Timestamps
  created_at,
  updated_at
) VALUES (
  -- Identificação
  '' || {{ $json.territory_id }},
  
  -- Pergunta original
  '{{ $json.original_question }}',
  '{{ $json.question_type }}',
  ARRAY['{{ $json.dimensions_analyzed[0] }}']::VARCHAR(50)[],
  
  -- Análise consolidada
  $${{ $json.integrated_analysis }}$$,
  $${{ $json.executive_summary }}$$,
  '{{ JSON.stringify($json.key_insights) }}'::jsonb,
  
  -- Referências às análises dimensionais
  '{{ JSON.stringify($json.source_analyses) }}'::jsonb,
  
  -- Métricas
  {{ $json.overall_confidence_score }},
  {{ $json.total_indicators_analyzed }},
  
  -- Metadados do orquestrador
  '{{ $json.orchestrator_version }}',
  {{ $json.execution_time_seconds }},
  'WF-AGENT-ORCHESTRATOR',
  
  -- Colunas legadas (compatibilidade)
  '{{ $json.dimension }}',
  $${{ $json.integrated_analysis }}$$,
  $${{ $json.executive_summary }}$$,
  {{ $json.overall_confidence_score }},
  '', -- embedding vazio
  
  -- Timestamps
  NOW(),
  NOW()
)
RETURNING id, created_at;
```

5. **Salvar o nó**

---

## ➕ ALTERAÇÃO 6: Adicionar Nó "Buscar Análise Completa"

### Objetivo
Buscar a análise recém-salva com dados enriquecidos do território.

### Passo a Passo

1. **Adicionar novo nó PostgreSQL**
   - Clique no **+** após "Salvar em knowledge_base"
   - Selecione **PostgreSQL**
   - Renomeie para: **"Buscar Análise Completa"**

2. **Configurar credenciais**
   - Selecione: **"Postgres Replit"**

3. **Configurar Operation**
   - Selecione: **"Execute Query"**

4. **Adicionar query SQL**

```sql
SELECT 
  kb.id as knowledge_base_id,
  kb.territory_id,
  kb.original_question,
  kb.question_type,
  kb.dimensions_analyzed,
  kb.integrated_analysis,
  kb.executive_summary,
  kb.key_insights,
  kb.source_analyses,
  kb.overall_confidence_score,
  kb.total_indicators_analyzed,
  kb.orchestrator_version,
  kb.execution_time_seconds,
  kb.created_at,
  
  -- Informações do território
  t.name as territory_name,
  t.type as territory_type
  
FROM knowledge_base kb
LEFT JOIN territories t ON t.id = '' || kb.territory_id
WHERE kb.id = '{{ $('Salvar em knowledge_base').first().json.id }}'
LIMIT 1;
```

5. **Salvar o nó**

---

## ➕ ALTERAÇÃO 7: Adicionar Nó "Preparar Resposta Rica"

### Objetivo
Preparar uma resposta estruturada e rica para o usuário.

### Passo a Passo

1. **Adicionar novo nó Code**
   - Clique no **+** após "Buscar Análise Completa"
   - Selecione **Code** → **Run JavaScript Code**
   - Renomeie para: **"Preparar Resposta Rica"**

2. **Adicionar código JavaScript**

```javascript
// ============================================================================
// PREPARAR RESPOSTA RICA PARA O USUÁRIO
// Arquitetura V2.0 - Orquestrador
// ============================================================================

// Obter dados da análise completa
const analysis = $input.first().json;

// Preparar resposta estruturada
const response = {
  status: "success",
  message: "Análise concluída com sucesso",
  
  // Metadados da consulta
  query: {
    original_question: analysis.original_question,
    territory_id: analysis.territory_id,
    territory_name: analysis.territory_name,
    question_type: analysis.question_type,
    dimensions_analyzed: analysis.dimensions_analyzed
  },
  
  // Análise consolidada
  analysis: {
    integrated_analysis: analysis.integrated_analysis,
    executive_summary: analysis.executive_summary,
    key_insights: analysis.key_insights,
    knowledge_base_id: analysis.knowledge_base_id
  },
  
  // Métricas
  metrics: {
    overall_confidence_score: analysis.overall_confidence_score,
    total_indicators_analyzed: analysis.total_indicators_analyzed,
    execution_time_seconds: analysis.execution_time_seconds
  },
  
  // Referências
  references: {
    source_analyses: analysis.source_analyses,
    orchestrator_version: analysis.orchestrator_version
  },
  
  // Timestamp
  timestamp: analysis.created_at
};

return {
  json: response
};
```

3. **Salvar o nó**

---

## 🔧 ALTERAÇÃO 8: Modificar "Responder ao Usuário"

### Objetivo
Configurar para retornar o JSON preparado no nó anterior.

### Passo a Passo

1. **Abrir o nó "Responder ao Usuário"**
   - Dê duplo clique no nó

2. **Configurar modo de resposta**
   - **Respond With**: "Using 'Respond to Webhook' Node"
   - **Response Mode**: **JSON**
   - **Response Data**: Deixe vazio (usará o JSON do nó anterior)

3. **Conectar o nó**
   - Certifique-se de que "Preparar Resposta Rica" está conectado a "Responder ao Usuário"

4. **Salvar o nó**

---

## 🔗 Fluxo Completo Atualizado

```
1. Webhook - Recebe Requisição
   ↓
2. Validar Entrada (✏️ modificado: + timestamp)
   ↓
3. Enriquecer Dados
   ↓
4. Normalizar Dados
   ↓
5. Classificar Pergunta (OpenAI)
   ↓
6. Preparar Payload
   ↓
7. Rotear para Especialista
   ↓
8-11. Chamar Agente * (✏️ modificado: timeout 60s)
   ↓
12. Extrair Análise Retornada (➕ novo)
   ↓
13. Calcular Tempo de Execução (➕ novo)
   ↓
14. Salvar em knowledge_base (➕ novo)
   ↓
15. Buscar Análise Completa (➕ novo)
   ↓
16. Preparar Resposta Rica (➕ novo)
   ↓
17. Responder ao Usuário (✏️ modificado)
```

---

## ✅ CHECKLIST DE VALIDAÇÃO

Após fazer todas as alterações:

- [ ] Nó "Validar Entrada" captura timestamp
- [ ] Todos os 4 nós "Chamar Agente *" têm timeout de 60s
- [ ] Nó "Extrair Análise Retornada" foi adicionado
- [ ] Nó "Calcular Tempo de Execução" foi adicionado
- [ ] Nó "Salvar em knowledge_base" foi adicionado
- [ ] Nó "Buscar Análise Completa" foi adicionado
- [ ] Nó "Preparar Resposta Rica" foi adicionado
- [ ] Nó "Responder ao Usuário" foi modificado
- [ ] Todas as conexões estão corretas
- [ ] Workflow foi salvo

---

## 🧪 TESTE END-TO-END

### Payload de Teste

```json
{
  "territory_id": "1721000",
  "question": "Como está o PIB de Palmas?",
  "analysis_type": "diagnostic"
}
```

### Resultado Esperado

```json
{
  "status": "success",
  "message": "Análise concluída com sucesso",
  "query": {
    "original_question": "Como está o PIB de Palmas?",
    "territory_id": "1721000",
    "territory_name": "Palmas",
    "question_type": "single_dimension",
    "dimensions_analyzed": ["economic"]
  },
  "analysis": {
    "integrated_analysis": "# ANÁLISE ECONÔMICA...",
    "executive_summary": "Resumo...",
    "key_insights": {...},
    "knowledge_base_id": "uuid-123"
  },
  "metrics": {
    "overall_confidence_score": 0.92,
    "total_indicators_analyzed": 15,
    "execution_time_seconds": 12.5
  },
  "references": {
    "source_analyses": {"economic": "uuid-456"},
    "orchestrator_version": "v2.0"
  },
  "timestamp": "2025-12-02T10:00:00Z"
}
```

---

**Implementação completa! 🚀**
