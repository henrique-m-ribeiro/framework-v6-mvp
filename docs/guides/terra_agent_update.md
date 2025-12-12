## ✅ Plano de Atualização para o Agente TERRA

Este guia contém todos os códigos e queries corrigidos e prontos para serem copiados e colados no workflow do Agente TERRA.

---

### **1. Nó "Preparar Dados para Salvar" (JavaScript)**

**Substitua o código JavaScript por:**

```javascript
// ============================================================================
// NÓ: PREPARAR DADOS PARA SALVAR (V4 - SCHEMA-COMPATÍVEL)
// ============================================================================

const structuredResponse = $input.first().json;
const normalizedData = $("Normalizar Entrada").first().json;

function uuidv4() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
}

const analysisDate = new Date().toISOString().split('T')[0];

const dataToSave = {
  id: uuidv4(),
  territory_id: structuredResponse.analysis.territory.id,
  analysis_date: analysisDate,
  analysis_content: structuredResponse.analysis.text,
  analysis_summary: structuredResponse.analysis.summary,
  confidence_score: structuredResponse.metadata.confidence_score,
  time_range: { "period": structuredResponse.metadata.time_period },
  indicators_used: structuredResponse.metadata.indicators_used || [],
  data_sources: structuredResponse.metadata.data_sources || [],
  is_latest: true,
  metadata: JSON.stringify({
    llm_model: structuredResponse.metadata.model_used,
    processing_time_ms: structuredResponse.metadata.processing_time_ms
  })
};

return {
  json: dataToSave
};
```

---

### **2. Nó "Salvar na Memória" (SQL)**

**Substitua a query SQL por:**

```sql
-- V3 - SCHEMA-COMPATÍVEL
-- ATENÇÃO: Altere para 'agent_terra_memory'
UPDATE agent_terra_memory SET is_latest = false WHERE territory_id = '{{ $json.territory_id }}';

INSERT INTO agent_terra_memory (id, territory_id, analysis_date, analysis_content, analysis_summary, confidence_score, time_range, indicators_used, data_sources, is_latest, metadata)
VALUES ('{{ $json.id }}', '{{ $json.territory_id }}', '{{ $json.analysis_date }}'::date, '{{ $json.analysis_content }}', '{{ $json.analysis_summary }}', {{ $json.confidence_score }}, '{{ JSON.stringify($json.time_range) }}'::jsonb, '{{ JSON.stringify($json.indicators_used) }}'::jsonb, '{{ JSON.stringify($json.data_sources) }}'::jsonb, true, '{{ $json.metadata }}'::jsonb)
RETURNING id;
```

---

### **3. Nó "Atualizar Expertise" (SQL)**

**Substitua a query SQL por:**

```sql
-- ATENÇÃO: Altere para 'terra'
SELECT * FROM get_agent_expertise('terra');
```

---

### **4. Nó "Registrar Aprendizado Automático" (SQL)**

**Substitua a query SQL por:**

```sql
-- V2 - CORRIGIDO
-- ATENÇÃO: Altere para 'agent_terra_learning_evolution' e 'terra'
INSERT INTO agent_terra_learning_evolution (agent_id, learning_type, source_analysis_ids, learning_content, confidence_score, metadata)
SELECT
  'terra' AS agent_id,
  'automatic_synthesis' AS learning_type,
  '{{ $("Salvar na Memória").first().json.id }}' AS source_analysis_ids,
  'Síntese automática de nova análise sobre o território.' AS learning_content,
  0.80 AS confidence_score,
  jsonb_build_object(
    'trigger', 'post_analysis_synthesis',
    'source_analysis_id', '{{ $("Salvar na Memória").first().json.id }}',
    'territory_id', '{{ $("Salvar na Memória").first().json.territory_id }}'
  ) AS metadata
WHERE '{{ $("Salvar na Memória").first().json.id }}' IS NOT NULL
RETURNING id, agent_id, learning_type;
```

---

### **5. Nó "Registrar Auditoria do Ciclo" (SQL)**

Este nó não precisa de alterações.

---

### **6. Nó "Respond to Webhook"**

Lembre-se de aplicar a alteração na arquitetura:

1.  **Conecte** a saída do nó **"Estruturar Resposta"** à entrada do nó **"Respond to Webhook"**.

---

### **7. Nó "Estruturar Resposta" (JavaScript)**

**Substitua o código JavaScript por:**

```javascript
// ========================================
// ESTRUTURAR RESPOSTA FINAL (V2 - CORRIGIDO)
// ========================================
// Este nó consolida a análise do LLM com metadados e prepara resposta estruturada.

const items = $input.all();
const llmResponse = items[0].json.message.content;

// Recuperar dados dos nós anteriores (SINTAXE CORRIGIDA)
const contextData = $('Preparar Contexto para LLM (V4 Multidimensional)').first().json;
const webhookData = $('Webhook - Recebe Tarefa').first().json;
const normalizedData = $('Normalizar Entrada').first().json;

// Timestamp de processamento
const requestTime = webhookData.headers?.['x-request-time'] 
  ? new Date(webhookData.headers['x-request-time']).getTime() 
  : Date.now();
const processingTime = Date.now() - requestTime;

// Extrair resumo executivo da análise
let summary = 'Análise territorial completa gerada.';
try {
  const resumoMatch = llmResponse.match(/##?\s*Resumo Executivo\s*\n\n([\s\S]*?)(?=\n##|\n\*\*|$)/i);
  if (resumoMatch) {
    summary = resumoMatch[1].trim().substring(0, 500); // Primeiros 500 caracteres
  }
} catch (e) {
  console.log('Erro ao extrair resumo:', e.message);
}

// Estruturar resposta final
const response = {
  // Identificação da tarefa
  task_id: normalizedData.task_id || `task_${Date.now()}`,
  agent_name: 'TERRA',
  status: 'success',
  
  // Análise gerada
  analysis: {
    text: llmResponse,
    summary: summary,
    territory: {
      id: normalizedData.territory_id,
      name: normalizedData.territory_name
    }
  },
  
  // Metadados
  metadata: {
    processing_time_ms: processingTime,
    time_period: normalizedData.parameters?.time_period || '2019-2023',
    analysis_type: 'territorial_comprehensive',
    detail_level: normalizedData.parameters?.detail_level || 'comprehensive',
    model_used: 'gpt-4o-mini',
    confidence_score: 0.92, // Score fixo para MVP
    generated_at: new Date().toISOString(),
    agent_id: normalizedData.agent_id
  }
};

return [{ json: response }];
```
