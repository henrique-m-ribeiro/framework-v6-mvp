## ✅ Plano de Atualização para o Agente SOCIAL

Analisei os códigos e queries do Agente SOCIAL. A estrutura é idêntica à do Agente ECON, então a atualização será direta. Abaixo estão todos os códigos e queries corrigidos e prontos para serem copiados e colados no workflow do Agente SOCIAL.

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
-- ATENÇÃO: Altere 'agent_econ_memory' para 'agent_social_memory'
UPDATE agent_social_memory SET is_latest = false WHERE territory_id = '{{ $json.territory_id }}';

INSERT INTO agent_social_memory (id, territory_id, analysis_date, analysis_content, analysis_summary, confidence_score, time_range, indicators_used, data_sources, is_latest, metadata)
VALUES ('{{ $json.id }}', '{{ $json.territory_id }}', '{{ $json.analysis_date }}'::date, '{{ $json.analysis_content }}', '{{ $json.analysis_summary }}', {{ $json.confidence_score }}, '{{ JSON.stringify($json.time_range) }}'::jsonb, '{{ JSON.stringify($json.indicators_used) }}'::jsonb, '{{ JSON.stringify($json.data_sources) }}'::jsonb, true, '{{ $json.metadata }}'::jsonb)
RETURNING id;
```

---

### **3. Nó "Atualizar Expertise" (SQL)**

**Substitua a query SQL por:**

```sql
-- ATENÇÃO: Altere 'econ' para 'social'
SELECT * FROM get_agent_expertise('social');
```

---

### **4. Nó "Registrar Aprendizado Automático" (SQL)**

**Substitua a query SQL por:**

```sql
-- V2 - CORRIGIDO
-- ATENÇÃO: Altere 'agent_econ_learning_evolution' para 'agent_social_learning_evolution' e 'econ' para 'social'
INSERT INTO agent_social_learning_evolution (agent_id, learning_type, source_analysis_ids, learning_content, confidence_score, metadata)
SELECT
  'social' AS agent_id,
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

Este nó não precisa de alterações, pois já é genérico o suficiente para buscar o `agent_id` do nó "Normalizar Entrada".

---

### **6. Nó "Respond to Webhook"**

Lembre-se de aplicar a alteração na arquitetura:

1.  **Conecte** a saída do nó **"Estruturar Resposta"** à entrada do nó **"Respond to Webhook"**.

---

Depois de aplicar todas essas atualizações no Agente SOCIAL, podemos prosseguir para os agentes AMBIENT e TERRA.
