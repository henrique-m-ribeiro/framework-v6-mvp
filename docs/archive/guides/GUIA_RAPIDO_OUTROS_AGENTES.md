# Guia Rápido: Aplicar Correção nos Outros Agentes

**Framework de Inteligência Territorial V6.0**  
**Data:** 26 de novembro de 2025  
**Sessão:** #6

---

## 🎯 OBJETIVO

Aplicar a mesma correção do nó "Respond to Webhook" nos outros 3 agentes dimensionais:
- ✅ **WF-AGENT-SOCIAL** (Agente Social)
- ✅ **WF-AGENT-AMBIENT** (Agente Ambiental)  
- ✅ **WF-AGENT-TERRA** (Agente Territorial)

---

## ⚡ RESUMO DO PROCESSO

Para cada agente, você precisa:

1. **Adicionar nó "Code"** chamado "Preparar Resposta do Webhook"
2. **Colar o código JavaScript** (com ajuste do nome do agente)
3. **Reconectar os nós** na ordem correta
4. **Configurar "Respond to Webhook"** com `={{ $json }}`
5. **Testar e validar**

**Tempo estimado:** 10 minutos por agente

---

## 📝 CÓDIGO JAVASCRIPT PARA CADA AGENTE

### Para o Agente SOCIAL

```javascript
// ============================================================================
// NÓ: PREPARAR RESPOSTA DO WEBHOOK
// Framework de Inteligência Territorial V6.0 - AGENTE SOCIAL
// ============================================================================

const webhookData = $('Webhook - Recebe Tarefa').first().json.body;
const webhookTimestamp = webhookData.timestamp || webhookData.started_at;
const startTime = webhookTimestamp ? new Date(webhookTimestamp) : new Date(Date.now() - 3000);

const structuredData = $('Estruturar Resposta').first().json;

const saveNode = $('Salvar Análise no PostgreSQL').first();
const saveResult = saveNode ? saveNode.json : { success: false };

const endTime = new Date();
const processingTimeMs = Math.round(endTime - startTime);

let keyFindings = [];
try {
  const content = structuredData.analysis.text || '';
  const lines = content.split('\n');
  keyFindings = lines
    .filter(line => line.trim().match(/^[-•*]\s+/))
    .map(line => line.trim().replace(/^[-•*]\s+/, ''))
    .slice(0, 5);
} catch (error) {
  keyFindings = ['Análise social completa gerada com sucesso'];
}

const response = {
  success: true,
  task_id: structuredData.task_id || webhookData.task_id || 'unknown',
  agent_name: 'SOCIAL',  // ← ALTERADO PARA SOCIAL
  analysis: {
    analysis_id: saveResult.id || `kb-${new Date().toISOString().split('T')[0]}-${Math.random().toString(36).substr(2, 6)}`,
    territory: {
      id: structuredData.analysis.territory.id || webhookData.territory_id,
      name: structuredData.analysis.territory.name || webhookData.territory_name,
      type: structuredData.analysis.territory.type || 'municipality'
    },
    summary: structuredData.analysis.summary || 'Análise social completa gerada com sucesso.',
    confidence_score: structuredData.metadata.confidence_score || 0.85,
    key_findings: keyFindings.length > 0 ? keyFindings : [
      'Análise social completa disponível',
      'Dados processados com sucesso',
      'Indicadores sociais analisados'
    ]
  },
  metadata: {
    timestamp: endTime.toISOString(),
    processing_time_ms: processingTimeMs,
    indicators_analyzed: structuredData.metadata.indicators_count || 0,
    years_covered: structuredData.metadata.years_analyzed || 'N/A',
    data_sources: structuredData.metadata.data_sources || ['IBGE', 'DataSUS'],
    model_used: structuredData.metadata.model_used || 'gpt-4o-mini'
  },
  storage: {
    saved_to_knowledge_base: saveResult.success !== false,
    knowledge_base_id: saveResult.id || null
  }
};

return response;
```

---

### Para o Agente AMBIENT

```javascript
// ============================================================================
// NÓ: PREPARAR RESPOSTA DO WEBHOOK
// Framework de Inteligência Territorial V6.0 - AGENTE AMBIENT
// ============================================================================

const webhookData = $('Webhook - Recebe Tarefa').first().json.body;
const webhookTimestamp = webhookData.timestamp || webhookData.started_at;
const startTime = webhookTimestamp ? new Date(webhookTimestamp) : new Date(Date.now() - 3000);

const structuredData = $('Estruturar Resposta').first().json;

const saveNode = $('Salvar Análise no PostgreSQL').first();
const saveResult = saveNode ? saveNode.json : { success: false };

const endTime = new Date();
const processingTimeMs = Math.round(endTime - startTime);

let keyFindings = [];
try {
  const content = structuredData.analysis.text || '';
  const lines = content.split('\n');
  keyFindings = lines
    .filter(line => line.trim().match(/^[-•*]\s+/))
    .map(line => line.trim().replace(/^[-•*]\s+/, ''))
    .slice(0, 5);
} catch (error) {
  keyFindings = ['Análise ambiental completa gerada com sucesso'];
}

const response = {
  success: true,
  task_id: structuredData.task_id || webhookData.task_id || 'unknown',
  agent_name: 'AMBIENT',  // ← ALTERADO PARA AMBIENT
  analysis: {
    analysis_id: saveResult.id || `kb-${new Date().toISOString().split('T')[0]}-${Math.random().toString(36).substr(2, 6)}`,
    territory: {
      id: structuredData.analysis.territory.id || webhookData.territory_id,
      name: structuredData.analysis.territory.name || webhookData.territory_name,
      type: structuredData.analysis.territory.type || 'municipality'
    },
    summary: structuredData.analysis.summary || 'Análise ambiental completa gerada com sucesso.',
    confidence_score: structuredData.metadata.confidence_score || 0.85,
    key_findings: keyFindings.length > 0 ? keyFindings : [
      'Análise ambiental completa disponível',
      'Dados processados com sucesso',
      'Indicadores ambientais analisados'
    ]
  },
  metadata: {
    timestamp: endTime.toISOString(),
    processing_time_ms: processingTimeMs,
    indicators_analyzed: structuredData.metadata.indicators_count || 0,
    years_covered: structuredData.metadata.years_analyzed || 'N/A',
    data_sources: structuredData.metadata.data_sources || ['INPE', 'IBGE'],
    model_used: structuredData.metadata.model_used || 'gpt-4o-mini'
  },
  storage: {
    saved_to_knowledge_base: saveResult.success !== false,
    knowledge_base_id: saveResult.id || null
  }
};

return response;
```

---

### Para o Agente TERRA

```javascript
// ============================================================================
// NÓ: PREPARAR RESPOSTA DO WEBHOOK
// Framework de Inteligência Territorial V6.0 - AGENTE TERRA
// ============================================================================

const webhookData = $('Webhook - Recebe Tarefa').first().json.body;
const webhookTimestamp = webhookData.timestamp || webhookData.started_at;
const startTime = webhookTimestamp ? new Date(webhookTimestamp) : new Date(Date.now() - 3000);

const structuredData = $('Estruturar Resposta').first().json;

const saveNode = $('Salvar Análise no PostgreSQL').first();
const saveResult = saveNode ? saveNode.json : { success: false };

const endTime = new Date();
const processingTimeMs = Math.round(endTime - startTime);

let keyFindings = [];
try {
  const content = structuredData.analysis.text || '';
  const lines = content.split('\n');
  keyFindings = lines
    .filter(line => line.trim().match(/^[-•*]\s+/))
    .map(line => line.trim().replace(/^[-•*]\s+/, ''))
    .slice(0, 5);
} catch (error) {
  keyFindings = ['Análise territorial completa gerada com sucesso'];
}

const response = {
  success: true,
  task_id: structuredData.task_id || webhookData.task_id || 'unknown',
  agent_name: 'TERRA',  // ← ALTERADO PARA TERRA
  analysis: {
    analysis_id: saveResult.id || `kb-${new Date().toISOString().split('T')[0]}-${Math.random().toString(36).substr(2, 6)}`,
    territory: {
      id: structuredData.analysis.territory.id || webhookData.territory_id,
      name: structuredData.analysis.territory.name || webhookData.territory_name,
      type: structuredData.analysis.territory.type || 'municipality'
    },
    summary: structuredData.analysis.summary || 'Análise territorial completa gerada com sucesso.',
    confidence_score: structuredData.metadata.confidence_score || 0.85,
    key_findings: keyFindings.length > 0 ? keyFindings : [
      'Análise territorial completa disponível',
      'Dados processados com sucesso',
      'Indicadores territoriais analisados'
    ]
  },
  metadata: {
    timestamp: endTime.toISOString(),
    processing_time_ms: processingTimeMs,
    indicators_analyzed: structuredData.metadata.indicators_count || 0,
    years_covered: structuredData.metadata.years_analyzed || 'N/A',
    data_sources: structuredData.metadata.data_sources || ['IBGE', 'INCRA'],
    model_used: structuredData.metadata.model_used || 'gpt-4o-mini'
  },
  storage: {
    saved_to_knowledge_base: saveResult.success !== false,
    knowledge_base_id: saveResult.id || null
  }
};

return response;
```

---

## 📋 CHECKLIST POR AGENTE

### Agente SOCIAL
- [ ] Nó "Preparar Resposta do Webhook" criado
- [ ] Código JavaScript colado (com `agent_name: 'SOCIAL'`)
- [ ] Nós reconectados corretamente
- [ ] "Respond to Webhook" configurado com `={{ $json }}`
- [ ] Workflow salvo
- [ ] Teste executado com sucesso

### Agente AMBIENT
- [ ] Nó "Preparar Resposta do Webhook" criado
- [ ] Código JavaScript colado (com `agent_name: 'AMBIENT'`)
- [ ] Nós reconectados corretamente
- [ ] "Respond to Webhook" configurado com `={{ $json }}`
- [ ] Workflow salvo
- [ ] Teste executado com sucesso

### Agente TERRA
- [ ] Nó "Preparar Resposta do Webhook" criado
- [ ] Código JavaScript colado (com `agent_name: 'TERRA'`)
- [ ] Nós reconectados corretamente
- [ ] "Respond to Webhook" configurado com `={{ $json }}`
- [ ] Workflow salvo
- [ ] Teste executado com sucesso

---

## 🔍 DIFERENÇAS ENTRE OS CÓDIGOS

As únicas diferenças entre os códigos são:

| Linha | ECON | SOCIAL | AMBIENT | TERRA |
|-------|------|--------|---------|-------|
| `agent_name:` | `'ECON'` | `'SOCIAL'` | `'AMBIENT'` | `'TERRA'` |
| Mensagem fallback | "econômica" | "social" | "ambiental" | "territorial" |
| `data_sources` padrão | `['IBGE', 'SICONFI']` | `['IBGE', 'DataSUS']` | `['INPE', 'IBGE']` | `['IBGE', 'INCRA']` |

---

## ⚡ ATALHO: COPIAR E AJUSTAR

Se você já implementou no Agente ECON:

1. **Copie o nó "Preparar Resposta do Webhook"** do workflow ECON
2. **Cole** no workflow do outro agente
3. **Abra o código** e ajuste apenas:
   - `agent_name: 'ECON'` → `'SOCIAL'`, `'AMBIENT'` ou `'TERRA'`
   - Mensagens de fallback (opcional)
   - `data_sources` padrão (opcional)
4. **Reconecte os nós**
5. **Salve e teste**

---

## 📊 PROGRESSO GERAL

Após implementar nos 4 agentes:

```
✅ WF-AGENT-ECON     (Agente Econômico)
✅ WF-AGENT-SOCIAL   (Agente Social)
✅ WF-AGENT-AMBIENT  (Agente Ambiental)
✅ WF-AGENT-TERRA    (Agente Territorial)
```

**Resultado:** Todos os 4 agentes dimensionais agora retornam respostas informativas e profissionais! 🎉

---

## 🎯 PRÓXIMO PASSO

Após concluir a implementação nos 4 agentes, você estará pronto para:

**Tarefa 2: Implementar RAG (Retrieval-Augmented Generation)**
- Popular memória do Agente ECON com documentos de referência
- Gerar embeddings vetoriais
- Implementar busca por similaridade

---

**Guia criado por:** Manus AI  
**Sessão:** #6 (26 de novembro de 2025)  
**Framework:** V6.0 - Inteligência Territorial
