# Base de Conhecimento - Framework V6.0
**Data:** 16 de novembro de 2025  
**Versão:** 1.0.0

---

## 🎯 VISÃO GERAL

A **Base de Conhecimento** é o sistema de cache e memória do Framework V6.0. Ela armazena todas as análises geradas pelos agentes dimensionais (ECON, SOCIAL, TERRA, AMBIENT) e permite:

1. **Cache de análises:** Evita gerar mesma análise múltiplas vezes
2. **RAG (Retrieval-Augmented Generation):** Análises anteriores servem de contexto para novas
3. **Histórico:** Rastreamento de evolução das análises ao longo do tempo
4. **Performance:** Dashboard consulta análises rapidamente (< 2 segundos)

---

## 📊 ESTRUTURA DA TABELA `knowledge_base`

```sql
CREATE TABLE knowledge_base (
  id SERIAL PRIMARY KEY,
  territory_id INTEGER REFERENCES territories(id),
  dimension VARCHAR(50),  -- 'economic', 'social', 'territorial', 'environmental'
  analysis_type VARCHAR(50),  -- 'single', 'comparative', 'temporal', 'integrated'
  content TEXT,  -- Análise completa em Markdown
  summary TEXT,  -- Resumo executivo (2-3 frases)
  key_insights JSONB,  -- Insights estruturados
  metadata JSONB,  -- Metadados (fontes, modelo, confiança, etc.)
  embedding VECTOR(1536),  -- Embedding vetorial para RAG
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  UNIQUE (territory_id, dimension, analysis_type)
);
```

---

## 🔑 CAMPOS PRINCIPAIS

### 1. `id` (SERIAL PRIMARY KEY)
- ID único da análise
- Gerado automaticamente

### 2. `territory_id` (INTEGER)
- ID do território analisado
- Foreign Key para `territories(id)`
- Exemplo: `1` (Palmas)

### 3. `dimension` (VARCHAR)
- Dimensão da análise
- Valores permitidos:
  - `'economic'` - Análise econômica (Agente ECON)
  - `'social'` - Análise social (Agente SOCIAL)
  - `'territorial'` - Análise territorial (Agente TERRA)
  - `'environmental'` - Análise ambiental (Agente AMBIENT)

### 4. `analysis_type` (VARCHAR)
- Tipo de análise
- Valores permitidos:
  - `'single'` - Análise de 1 território
  - `'comparative'` - Comparação entre 2+ territórios
  - `'temporal'` - Evolução temporal de 1 território
  - `'integrated'` - Análise integrando múltiplas dimensões

### 5. `content` (TEXT)
- Texto completo da análise em Markdown
- Formato estruturado com seções:
  - **RESUMO EXECUTIVO**
  - **PRINCIPAIS TENDÊNCIAS** (ou AVANÇOS, PADRÕES, RISCOS)
  - **PONTOS FORTES** (ou DESAFIOS, OPORTUNIDADES)
  - **DESAFIOS** (ou GRUPOS VULNERÁVEIS, ÁREAS DE ATENÇÃO)
  - **RECOMENDAÇÕES PRIORITÁRIAS**

### 6. `summary` (TEXT)
- Resumo executivo (2-3 frases)
- Extraído automaticamente da seção "RESUMO EXECUTIVO"
- Usado para listagens rápidas no dashboard

### 7. `key_insights` (JSONB)
- Insights principais em formato JSON estruturado
- Exemplo (ECON):
```json
{
  "gdp_growth": 13.6,
  "gdp_per_capita_growth": 8.3,
  "unemployment_change": -1.7,
  "sector_composition": {
    "agriculture": 10,
    "industry": 22,
    "services": 68
  },
  "transfer_dependence": 45,
  "investment_capacity": 12
}
```

### 8. `metadata` (JSONB)
- Metadados sobre a análise
- Exemplo:
```json
{
  "data_sources": ["IBGE", "SICONFI", "RAIS"],
  "time_range": "2019-2023",
  "years_analyzed": 5,
  "last_data_update": 2023,
  "model_used": "gpt-4o-mini",
  "confidence_score": 0.92,
  "processing_time_ms": 7500,
  "generated_at": "2025-11-16T21:30:00.000Z"
}
```

### 9. `embedding` (VECTOR(1536))
- Embedding vetorial para busca semântica (RAG)
- 1536 dimensões (OpenAI text-embedding-3-small)
- Permite buscar análises similares por conteúdo
- **Futuro:** Será gerado automaticamente após cada análise

### 10. `created_at` / `updated_at` (TIMESTAMP)
- Timestamps de criação e última atualização
- `updated_at` é atualizado automaticamente via trigger

---

## 🔒 CONSTRAINT DE UNICIDADE

```sql
UNIQUE (territory_id, dimension, analysis_type)
```

**Significado:**
- Apenas **1 análise** por combinação de (território, dimensão, tipo)
- Exemplo: Apenas 1 análise econômica simples de Palmas
- Se tentar inserir novamente, faz **UPSERT** (atualiza a existente)

**Exemplos de chaves únicas:**
- `(1, 'economic', 'single')` - Análise econômica de Palmas
- `(1, 'social', 'single')` - Análise social de Palmas
- `(1, 'economic', 'comparative')` - Comparação econômica de Palmas com outros

---

## 📈 ÍNDICES PARA PERFORMANCE

### 1. Busca por território e dimensão
```sql
CREATE INDEX idx_knowledge_base_territory_dimension 
ON knowledge_base(territory_id, dimension);
```
**Uso:** Consulta mais comum - "Análise econômica de Palmas"

### 2. Busca por tipo de análise
```sql
CREATE INDEX idx_knowledge_base_analysis_type 
ON knowledge_base(analysis_type);
```
**Uso:** Listar todas as análises comparativas

### 3. Busca por data de atualização
```sql
CREATE INDEX idx_knowledge_base_updated_at 
ON knowledge_base(updated_at DESC);
```
**Uso:** Listar análises mais recentes

### 4. Busca em key_insights (JSONB)
```sql
CREATE INDEX idx_knowledge_base_key_insights 
ON knowledge_base USING GIN (key_insights);
```
**Uso:** Buscar análises com insights específicos
```sql
-- Exemplo: Territórios com crescimento do PIB > 10%
SELECT * FROM knowledge_base
WHERE key_insights->>'gdp_growth' > '10';
```

### 5. Busca em metadata (JSONB)
```sql
CREATE INDEX idx_knowledge_base_metadata 
ON knowledge_base USING GIN (metadata);
```
**Uso:** Buscar análises por fonte de dados, modelo, etc.

### 6. Busca de similaridade vetorial (RAG)
```sql
CREATE INDEX idx_knowledge_base_embedding 
ON knowledge_base USING ivfflat (embedding vector_cosine_ops);
```
**Uso:** Buscar análises similares por conteúdo (RAG)
**Nota:** Criado manualmente após popular a tabela

---

## 🔍 VIEWS ÚTEIS

### 1. `v_latest_analyses` - Análises mais recentes

```sql
SELECT * FROM v_latest_analyses LIMIT 10;
```

**Colunas:**
- `id`, `territory_name`, `dimension`, `analysis_type`
- `summary`, `updated_at`, `model_used`, `confidence_score`

**Uso:** Listar análises recentes no dashboard

---

### 2. `v_knowledge_base_stats` - Estatísticas

```sql
SELECT * FROM v_knowledge_base_stats;
```

**Colunas:**
- `dimension`, `analysis_type`, `total_analyses`
- `analyses_with_embedding`, `avg_confidence`, `last_update`

**Uso:** Monitorar cobertura da base de conhecimento

---

## 🛠️ FUNÇÕES ÚTEIS

### 1. `search_similar_analyses()` - Busca por similaridade (RAG)

```sql
SELECT * FROM search_similar_analyses(
  query_embedding := '[0.1, 0.2, ...]'::VECTOR(1536),
  similarity_threshold := 0.7,
  max_results := 5
);
```

**Parâmetros:**
- `query_embedding`: Embedding da pergunta do usuário
- `similarity_threshold`: Mínimo de similaridade (0-1)
- `max_results`: Número máximo de resultados

**Retorna:**
- `id`, `territory_id`, `territory_name`, `dimension`, `summary`, `similarity`

**Uso:** RAG - Buscar análises similares para contextualizar novas

---

### 2. `get_territory_analysis()` - Análises de um território

```sql
-- Todas as análises de Palmas
SELECT * FROM get_territory_analysis(1);

-- Apenas análises econômicas de Palmas
SELECT * FROM get_territory_analysis(1, 'economic');
```

**Parâmetros:**
- `p_territory_id`: ID do território
- `p_dimension`: Dimensão (opcional)

**Retorna:**
- `id`, `dimension`, `analysis_type`, `content`, `summary`, `key_insights`, `updated_at`

**Uso:** Dashboard - Exibir análises de um território

---

## 📝 OPERAÇÕES COMUNS

### 1. Inserir nova análise (UPSERT)

```sql
INSERT INTO knowledge_base (
  territory_id,
  dimension,
  analysis_type,
  content,
  summary,
  key_insights,
  metadata
) VALUES (
  1,  -- Palmas
  'economic',
  'single',
  '**RESUMO EXECUTIVO**...',
  'Palmas apresentou crescimento...',
  '{"gdp_growth": 13.6}'::JSONB,
  '{"model_used": "gpt-4o-mini"}'::JSONB
)
ON CONFLICT (territory_id, dimension, analysis_type)
DO UPDATE SET
  content = EXCLUDED.content,
  summary = EXCLUDED.summary,
  key_insights = EXCLUDED.key_insights,
  metadata = EXCLUDED.metadata,
  updated_at = NOW();
```

**Comportamento:**
- Se análise já existe, **atualiza**
- Se não existe, **insere nova**

---

### 2. Buscar análise específica

```sql
SELECT * FROM knowledge_base
WHERE territory_id = 1
  AND dimension = 'economic'
  AND analysis_type = 'single';
```

---

### 3. Listar análises de um território

```sql
SELECT 
  dimension,
  summary,
  updated_at
FROM knowledge_base
WHERE territory_id = 1
ORDER BY updated_at DESC;
```

---

### 4. Buscar análises com crescimento do PIB > 10%

```sql
SELECT 
  t.name AS territory_name,
  kb.summary,
  kb.key_insights->>'gdp_growth' AS gdp_growth
FROM knowledge_base kb
JOIN territories t ON kb.territory_id = t.id
WHERE kb.dimension = 'economic'
  AND (kb.key_insights->>'gdp_growth')::FLOAT > 10
ORDER BY (kb.key_insights->>'gdp_growth')::FLOAT DESC;
```

---

### 5. Estatísticas da base de conhecimento

```sql
SELECT 
  dimension,
  COUNT(*) AS total,
  AVG((metadata->>'confidence_score')::FLOAT) AS avg_confidence
FROM knowledge_base
GROUP BY dimension;
```

---

## 🚀 FLUXO DE USO

### Cenário 1: Usuário solicita análise existente

```
1. Dashboard recebe requisição: "Análise econômica de Palmas"
2. Dashboard consulta knowledge_base:
   SELECT * FROM knowledge_base
   WHERE territory_id = 1 AND dimension = 'economic'
3. Se encontrou, retorna análise (< 2 segundos) ✅
4. Se não encontrou, aciona n8n para gerar nova análise
```

---

### Cenário 2: Agente gera nova análise

```
1. Agente ECON gera análise de Palmas
2. Agente salva na knowledge_base (UPSERT)
3. Análise fica disponível para:
   - Dashboard (consulta rápida)
   - RAG (contexto para futuras análises)
   - Outros agentes (aprendizado contínuo)
```

---

### Cenário 3: RAG - Contextualizar nova análise

```
1. Agente ECON vai gerar análise de Araguaína
2. Antes, busca análises similares:
   SELECT * FROM search_similar_analyses(embedding_araguaina)
3. Encontra análise de Palmas (cidade similar)
4. Usa análise de Palmas como contexto
5. Gera análise de Araguaína mais consistente
```

---

## 📊 MONITORAMENTO

### Verificar cobertura

```sql
-- Quantas análises por dimensão?
SELECT dimension, COUNT(*) 
FROM knowledge_base 
GROUP BY dimension;

-- Quantos territórios têm análises?
SELECT COUNT(DISTINCT territory_id) 
FROM knowledge_base;

-- Qual % dos territórios tem análise econômica?
SELECT 
  (SELECT COUNT(DISTINCT territory_id) FROM knowledge_base WHERE dimension = 'economic') * 100.0 /
  (SELECT COUNT(*) FROM territories) AS coverage_percentage;
```

---

### Verificar qualidade

```sql
-- Confiança média por dimensão
SELECT 
  dimension,
  AVG((metadata->>'confidence_score')::FLOAT) AS avg_confidence,
  MIN((metadata->>'confidence_score')::FLOAT) AS min_confidence,
  MAX((metadata->>'confidence_score')::FLOAT) AS max_confidence
FROM knowledge_base
GROUP BY dimension;
```

---

### Verificar atualização

```sql
-- Análises mais antigas (precisam atualização?)
SELECT 
  t.name,
  kb.dimension,
  kb.updated_at,
  NOW() - kb.updated_at AS age
FROM knowledge_base kb
JOIN territories t ON kb.territory_id = t.id
ORDER BY kb.updated_at ASC
LIMIT 10;
```

---

## 🔮 FUTURO - RAG COMPLETO

### Fase 1: Gerar embeddings (Atual)

Atualmente, os agentes salvam análises **sem embeddings**:
```sql
embedding = NULL
```

### Fase 2: Gerar embeddings automaticamente (Próxima)

Criar workflow n8n que:
1. Detecta análises sem embedding (`WHERE embedding IS NULL`)
2. Gera embedding com OpenAI Embeddings API
3. Atualiza registro com embedding

```javascript
// Pseudocódigo
const response = await openai.embeddings.create({
  model: "text-embedding-3-small",
  input: analysis.content
});

const embedding = response.data[0].embedding;

await db.query(`
  UPDATE knowledge_base 
  SET embedding = $1 
  WHERE id = $2
`, [embedding, analysis.id]);
```

### Fase 3: Usar RAG nas análises (Futuro)

Agentes consultam análises similares antes de gerar novas:

```javascript
// 1. Gerar embedding da pergunta
const questionEmbedding = await openai.embeddings.create({
  input: "Como está a economia de Araguaína?"
});

// 2. Buscar análises similares
const similarAnalyses = await db.query(`
  SELECT * FROM search_similar_analyses($1, 0.7, 3)
`, [questionEmbedding]);

// 3. Incluir no prompt do LLM
const prompt = `
CONTEXTO (análises similares):
${similarAnalyses.map(a => a.summary).join('\n\n')}

TAREFA:
Analise a economia de Araguaína...
`;
```

**Benefícios:**
- Análises mais consistentes
- Aprendizado contínuo
- Redução de custos (menos tokens no prompt)

---

## 📚 REFERÊNCIAS

- **pgvector:** https://github.com/pgvector/pgvector
- **OpenAI Embeddings:** https://platform.openai.com/docs/guides/embeddings
- **PostgreSQL JSONB:** https://www.postgresql.org/docs/current/datatype-json.html

---

**Autor:** Manus AI  
**Data:** 16 de novembro de 2025  
**Versão:** 1.0.0
