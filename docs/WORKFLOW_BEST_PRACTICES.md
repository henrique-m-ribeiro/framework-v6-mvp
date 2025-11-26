# Melhores Práticas para Workflows de Agentes

**Baseado no Workflow Validado do Agente ECON V2**

**Data:** 26 de novembro de 2025

---

## 1. Padrão de Query PostgreSQL

### ✅ Correção Crítica: Acessar Dados do Body

**Problema Comum:**
```sql
WHERE t.id = '{{ $json.territory_id }}'  -- ❌ ERRADO
```

**Solução Validada:**
```sql
WHERE t.id = '{{ $('Webhook - Recebe Tarefa').first().json.body.territory_id }}'  -- ✅ CORRETO
```

**Explicação:** O nó Webhook coloca todos os dados da requisição dentro de um objeto `body`. É necessário acessar explicitamente `body.campo` para obter os valores.

### Configurações Recomendadas

```json
{
  "options": {
    "queryBatching": "transaction"
  },
  "onError": "continueErrorOutput"
}
```

---

## 2. Nó "Preparar Dados para Salvar"

### Código JavaScript Validado

Este nó é **crítico** para o salvamento correto dos dados no PostgreSQL.

```javascript
// Pega os dados do nó "Estruturar Resposta" (nó anterior)
const structuredData = $input.first().json;

// Pega os dados do webhook original
const webhookData = $items("Webhook - Recebe Tarefa")[0].json.body;

// Monta o objeto de metadados
const metadata = {
  task_id: structuredData.task_id || webhookData.task_id,
  model_used: structuredData.metadata.model_used,
  generated_at: structuredData.metadata.generated_at,
  original_parameters: webhookData.parameters
};

// Monta o objeto final com TODOS os campos necessários
const finalData = {
  territory_id: structuredData.analysis.territory.id,
  analysis_content: structuredData.analysis.text,
  analysis_summary: structuredData.analysis.summary,
  confidence_score: structuredData.metadata.confidence_score,
  metadata: JSON.stringify(metadata),
  time_range: JSON.stringify({ 
    start: webhookData.parameters.time_period.split("-")[0],
    end: webhookData.parameters.time_period.split("-")[1]
  }),
  data_sources: JSON.stringify([{ 
    type: "internal_db", 
    source: "economic_indicators"  // Ajustar conforme dimensão
  }]),
  indicators_used: JSON.stringify(webhookData.parameters.focus_areas)
};

return { json: finalData };
```

### Campos Obrigatórios

| Campo | Origem | Tipo | Exemplo |
| :--- | :--- | :--- | :--- |
| `territory_id` | `structuredData.analysis.territory.id` | String | `"1721000"` |
| `analysis_content` | `structuredData.analysis.text` | String | `"# ANÁLISE..."` |
| `analysis_summary` | `structuredData.analysis.summary` | String | `"Análise completa..."` |
| `confidence_score` | `structuredData.metadata.confidence_score` | Number | `0.92` |
| `metadata` | Montado manualmente | JSON String | `"{\"task_id\":...}"` |
| `time_range` | `webhookData.parameters.time_period` | JSON String | `"{\"start\":\"2019\"...}"` |
| `data_sources` | Fixo | JSON String | `"[{\"type\":...}]"` |
| `indicators_used` | `webhookData.parameters.focus_areas` | JSON String | `"[\"PIB\",...]"` |

---

## 3. Query de Salvamento no PostgreSQL

### ✅ Solução Validada: Dollar-Quoted Strings

**Problema:** Caracteres especiais (como `#` do Markdown) causam erro de sintaxe SQL.

**Solução:** Usar `$$` para escapar o conteúdo.

```sql
INSERT INTO knowledge_base (
  territory_id,
  dimension,
  content,
  summary,
  confidence_score,
  metadata,
  analysis_type,
  embedding,
  generated_by
)
VALUES (
  '{{ $json.territory_id }}',
  'economic',  -- Ajustar conforme dimensão: 'social', 'environmental', 'territorial'
  $${{ $json.analysis_content }}$$,  -- ✅ Dollar-quoted strings
  $${{ $json.analysis_summary }}$$,  -- ✅ Dollar-quoted strings
  {{ $json.confidence_score }},      -- ❌ SEM aspas (é número)
  '{{ $json.metadata }}'::jsonb,
  'diagnostic',
  '',
  'WF-AGENT-ECON'  -- Ajustar conforme agente
);
```

### ⚠️ Pontos de Atenção

1.  **Dollar-quoted strings (`$$`):** Essenciais para campos de texto que podem conter caracteres especiais.
2.  **Sem aspas em números:** `confidence_score` é numérico, não usar aspas.
3.  **Cast para JSONB:** Usar `::jsonb` para campos JSON.
4.  **Embedding vazio:** Pode ser string vazia (`''`) temporariamente.

---

## 4. Estratégia de Memória do Agente

### Decisão Validada

**NÃO** salvar análises geradas na tabela `agent_xxx_memory`.

**Justificativa:**
-   A tabela `agent_xxx_memory` deve ser reservada para **documentos de referência** (artigos acadêmicos, publicações do IPEA/IBGE, etc.).
-   Estes documentos servirão como base de conhecimento para **RAG (Retrieval-Augmented Generation)**.
-   As análises geradas são salvas apenas em `knowledge_base`.

### Próximos Passos (RAG)

1.  Popular `agent_xxx_memory` com documentos de alta qualidade.
2.  Gerar embeddings para esses documentos.
3.  Implementar busca semântica antes da chamada à OpenAI.
4.  Injetar documentos relevantes como contexto adicional.

---

## 5. Configuração da OpenAI

### Parâmetros Recomendados

```json
{
  "modelId": "gpt-4o-mini",
  "options": {
    "maxTokens": 2000,
    "temperature": 0.7
  }
}
```

### System Prompt Essencial

```
Você é um especialista em análise [DIMENSÃO] de municípios brasileiros.

REGRAS FUNDAMENTAIS:
1. NUNCA crie dados sintéticos ou invente informações
2. Se um dado não estiver disponível, indique: "Dado não disponível"
3. Base TODAS as afirmações nos dados fornecidos
4. Cite sempre: ano, indicador e valor exato
5. Use Markdown para formatação
6. Destaque números importantes em **negrito**
```

---

## 6. Checklist de Implementação

Ao criar ou atualizar um workflow de agente, verifique:

- [ ] Query PostgreSQL acessa `body.territory_id` corretamente
- [ ] Nó "Preparar Dados para Salvar" retorna **todos os 8 campos**
- [ ] Query de salvamento usa `$$` para campos de texto
- [ ] Query de salvamento **não** usa aspas em `confidence_score`
- [ ] Dimensão correta em `dimension` e `data_sources`
- [ ] Nome do agente correto em `generated_by`
- [ ] System prompt adaptado para a dimensão
- [ ] Configuração da OpenAI com `maxTokens` e `temperature`

---

## 7. Adaptação para Outras Dimensões

### Campos a Ajustar

| Campo | ECON | SOCIAL | AMBIENT | TERRA |
| :--- | :--- | :--- | :--- | :--- |
| `dimension` | `'economic'` | `'social'` | `'environmental'` | `'territorial'` |
| `data_sources` | `economic_indicators` | `social_indicators` | `environmental_indicators` | `territorial_indicators` |
| `generated_by` | `WF-AGENT-ECON` | `WF-AGENT-SOCIAL` | `WF-AGENT-AMBIENT` | `WF-AGENT-TERRA` |
| System Prompt | Análise econômica | Análise social | Análise ambiental | Análise territorial |

---

## 8. Erros Comuns e Soluções

| Erro | Causa | Solução |
| :--- | :--- | :--- |
| `column "undefined" does not exist` | Nó "Preparar Dados" não retorna todos os campos | Usar código JavaScript validado |
| `Syntax error near "##"` | Caractere `#` interpretado como comentário SQL | Usar `$$` ao redor do conteúdo |
| `null value in column "embedding_vector"` | Tentativa de inserir em `agent_xxx_memory` | Remover INSERT em `agent_xxx_memory` |
| Nó PostgreSQL travado sem output | Query tenta acessar `$json.territory_id` sem `body` | Corrigir para `body.territory_id` |

---

**Documento criado por:** Manus AI  
**Baseado em:** Workflow WF-AGENT-ECON V2 (Validado em 26/11/2025)
