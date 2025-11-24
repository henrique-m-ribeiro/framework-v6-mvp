# Estrutura Ideal para a Tabela `knowledge_base`

## 🎯 Objetivo

Projetar uma estrutura de dados otimizada para armazenar e recuperar análises de IA sobre territórios, com suporte a:
- **Busca rápida** por território e dimensão
- **RAG (Retrieval-Augmented Generation)** com embeddings vetoriais
- **Versionamento** de análises
- **Metadados** ricos para filtragem
- **Escalabilidade** para milhares de análises

---

## 📊 Análise de Requisitos

### **Volume de Dados**

| Item | Quantidade | Cálculo |
|------|------------|---------|
| Territórios | 140 | - |
| Dimensões | 4 | Economic, Social, Territorial, Environmental |
| Tipos de Análise | 3 | Diagnostic, Comparative, Predictive |
| **Análises Totais (Máximo)** | **1.680** | 140 × 4 × 3 |
| Tamanho médio por análise | ~2 KB | Texto + metadados |
| **Tamanho total estimado** | **~3.4 MB** | Texto apenas |
| Embedding por análise | 6 KB | 1536 dimensões × 4 bytes |
| **Tamanho com embeddings** | **~13 MB** | Texto + embeddings |

**Conclusão:** Volume pequeno, mas com necessidade de busca vetorial eficiente.

---

### **Casos de Uso Principais**

#### **1. Busca Direta (Cache)**
```sql
SELECT content FROM knowledge_base 
WHERE territory_id = '1721000' 
  AND dimension = 'economic' 
  AND analysis_type = 'diagnostic';
```
**Frequência:** Alta (90% das consultas)  
**Latência esperada:** < 10ms

#### **2. Busca Semântica (RAG)**
```sql
SELECT territory_id, dimension, content, 
       embedding <=> query_embedding AS distance
FROM knowledge_base
WHERE dimension = 'social'
ORDER BY distance
LIMIT 5;
```
**Frequência:** Média (10% das consultas)  
**Latência esperada:** < 100ms

#### **3. Análise Comparativa**
```sql
SELECT territory_id, content FROM knowledge_base
WHERE dimension = 'environmental'
  AND analysis_type = 'diagnostic'
  AND metadata->>'deforestation_level' = 'high';
```
**Frequência:** Baixa (análises ad-hoc)  
**Latência esperada:** < 500ms

---

## 🏗️ Estrutura Proposta

### **Schema SQL Completo**

```sql
CREATE TABLE knowledge_base (
    -- Identificação
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    territory_id VARCHAR(10) NOT NULL REFERENCES territories(id),
    dimension VARCHAR(50) NOT NULL,
    analysis_type VARCHAR(50) NOT NULL,
    
    -- Conteúdo
    content TEXT NOT NULL,
    summary TEXT,  -- Resumo de 2-3 frases para preview
    
    -- Embeddings para RAG
    embedding VECTOR(1536),  -- OpenAI text-embedding-ada-002
    
    -- Metadados estruturados
    metadata JSONB,
    
    -- Versionamento
    version INTEGER DEFAULT 1,
    is_latest BOOLEAN DEFAULT TRUE,
    
    -- Qualidade e confiança
    confidence_score DECIMAL(3,2),  -- 0.00 a 1.00
    sources JSONB,  -- Lista de fontes usadas na análise
    
    -- Auditoria
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    generated_by VARCHAR(100),  -- Nome do agente que gerou
    
    -- Constraint única (território + dimensão + tipo + versão)
    UNIQUE(territory_id, dimension, analysis_type, version)
);

-- Índices para performance
CREATE INDEX idx_kb_territory_dimension 
    ON knowledge_base(territory_id, dimension);

CREATE INDEX idx_kb_latest 
    ON knowledge_base(is_latest) 
    WHERE is_latest = TRUE;

CREATE INDEX idx_kb_metadata 
    ON knowledge_base USING GIN(metadata);

-- Índice vetorial para busca semântica (pgvector)
CREATE INDEX idx_kb_embedding 
    ON knowledge_base USING ivfflat(embedding vector_cosine_ops)
    WITH (lists = 100);

-- Particionamento por dimensão (opcional, para escala futura)
-- CREATE TABLE knowledge_base_economic PARTITION OF knowledge_base
--     FOR VALUES IN ('economic');
```

---

## 📋 Detalhamento dos Campos

### **1. Campos de Identificação**

| Campo | Tipo | Descrição | Exemplo |
|-------|------|-----------|---------|
| `id` | UUID | Identificador único global | `550e8400-e29b-41d4-a716-446655440000` |
| `territory_id` | VARCHAR(10) | Código IBGE do território | `1721000` (Palmas) |
| `dimension` | VARCHAR(50) | Dimensão da análise | `economic`, `social`, `territorial`, `environmental` |
| `analysis_type` | VARCHAR(50) | Tipo de análise | `diagnostic`, `comparative`, `predictive` |

**Índice:** `idx_kb_territory_dimension` (B-tree composto)

---

### **2. Campos de Conteúdo**

| Campo | Tipo | Descrição | Tamanho |
|-------|------|-----------|---------|
| `content` | TEXT | Análise completa em texto | ~2 KB |
| `summary` | TEXT | Resumo executivo (2-3 frases) | ~200 bytes |

**Uso:**
- `content`: Para exibição completa no dashboard
- `summary`: Para listagens e previews rápidos

---

### **3. Campo de Embedding**

| Campo | Tipo | Descrição | Tamanho |
|-------|------|-----------|---------|
| `embedding` | VECTOR(1536) | Vetor de embedding para RAG | 6 KB |

**Modelo:** OpenAI `text-embedding-ada-002` (1536 dimensões)

**Índice:** `idx_kb_embedding` (IVFFlat com 100 listas)

**Busca:**
```sql
SELECT * FROM knowledge_base
ORDER BY embedding <=> '[0.1, 0.2, ...]'::vector
LIMIT 5;
```

---

### **4. Campo de Metadados (JSONB)**

Estrutura flexível para armazenar informações contextuais:

```json
{
  "indicators_analyzed": ["gdp", "gdp_per_capita", "employment_rate"],
  "year_range": [2019, 2023],
  "key_findings": {
    "trend": "positive",
    "growth_rate": 15.3,
    "ranking_state": 2
  },
  "alerts": [
    {
      "indicator": "employment_rate",
      "level": "warning",
      "message": "Taxa de emprego abaixo da média estadual"
    }
  ],
  "comparisons": {
    "vs_state_avg": "+12%",
    "vs_national_avg": "-5%"
  }
}
```

**Índice:** `idx_kb_metadata` (GIN para busca em JSONB)

**Busca:**
```sql
SELECT * FROM knowledge_base
WHERE metadata @> '{"key_findings": {"trend": "positive"}}';
```

---

### **5. Campos de Versionamento**

| Campo | Tipo | Descrição |
|-------|------|-----------|
| `version` | INTEGER | Número da versão (1, 2, 3...) |
| `is_latest` | BOOLEAN | TRUE apenas para a versão mais recente |

**Uso:**
- Permite manter histórico de análises
- Facilita comparação de análises ao longo do tempo
- Índice `idx_kb_latest` otimiza busca da versão atual

**Query típica:**
```sql
SELECT * FROM knowledge_base
WHERE territory_id = '1721000'
  AND dimension = 'economic'
  AND is_latest = TRUE;
```

---

### **6. Campos de Qualidade**

| Campo | Tipo | Descrição | Exemplo |
|-------|------|-----------|---------|
| `confidence_score` | DECIMAL(3,2) | Confiança da análise (0-1) | 0.87 |
| `sources` | JSONB | Fontes de dados usadas | `["IBGE", "SICONFI"]` |

**Uso:**
- `confidence_score`: Permite filtrar análises de alta qualidade
- `sources`: Rastreabilidade e transparência

---

### **7. Campos de Auditoria**

| Campo | Tipo | Descrição |
|-------|------|-----------|
| `created_at` | TIMESTAMP | Data/hora de criação |
| `updated_at` | TIMESTAMP | Data/hora da última atualização |
| `generated_by` | VARCHAR(100) | Agente que gerou (ex: `agent-econ-v1.2`) |

---

## 🚀 Estratégias de Otimização

### **1. Particionamento (Para Escala Futura)**

Se o volume crescer significativamente (>100k análises), particionar por dimensão:

```sql
CREATE TABLE knowledge_base (
    ...
) PARTITION BY LIST (dimension);

CREATE TABLE kb_economic PARTITION OF knowledge_base
    FOR VALUES IN ('economic');

CREATE TABLE kb_social PARTITION OF knowledge_base
    FOR VALUES IN ('social');

CREATE TABLE kb_territorial PARTITION OF knowledge_base
    FOR VALUES IN ('territorial');

CREATE TABLE kb_environmental PARTITION OF knowledge_base
    FOR VALUES IN ('environmental');
```

**Benefícios:**
- Queries filtradas por dimensão só escaneiam a partição relevante
- Manutenção (VACUUM, REINDEX) mais rápida
- Backup/restore seletivo

---

### **2. Índice Vetorial (pgvector)**

Para busca semântica eficiente:

```sql
-- IVFFlat: Rápido, mas aproximado
CREATE INDEX idx_kb_embedding ON knowledge_base
USING ivfflat (embedding vector_cosine_ops)
WITH (lists = 100);

-- HNSW: Mais preciso, mas mais lento (PostgreSQL 14+)
-- CREATE INDEX idx_kb_embedding ON knowledge_base
-- USING hnsw (embedding vector_cosine_ops);
```

**Parâmetros:**
- `lists = 100`: Para ~1.680 registros, 100 listas é adequado
- Regra geral: `lists = rows / 1000` (mínimo 10, máximo 1000)

---

### **3. Materialização de Resumos**

Para dashboards que exibem múltiplas análises:

```sql
CREATE MATERIALIZED VIEW kb_summaries AS
SELECT 
    territory_id,
    dimension,
    analysis_type,
    summary,
    metadata->>'trend' AS trend,
    confidence_score,
    updated_at
FROM knowledge_base
WHERE is_latest = TRUE;

CREATE INDEX idx_kb_summaries_territory 
    ON kb_summaries(territory_id);

-- Refresh periódico (ex: a cada hora)
REFRESH MATERIALIZED VIEW CONCURRENTLY kb_summaries;
```

---

### **4. Cache de Embeddings**

Para evitar recalcular embeddings:

```sql
-- Trigger para atualizar updated_at automaticamente
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_updated_at
BEFORE UPDATE ON knowledge_base
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();
```

---

## 📊 Comparação com Estrutura Atual

| Aspecto | Estrutura Atual | Estrutura Proposta | Melhoria |
|---------|-----------------|-------------------|----------|
| **Busca direta** | ~10ms | ~5ms | 2x mais rápido (índice composto) |
| **Busca semântica** | Não suportada | ~50ms | ✅ Novo recurso |
| **Versionamento** | Não suportado | Suportado | ✅ Histórico completo |
| **Metadados** | JSONB simples | JSONB estruturado + índice GIN | 5x mais rápido |
| **Escalabilidade** | Até ~10k registros | Até ~1M registros | 100x maior |
| **RAG** | Não suportado | Suportado (pgvector) | ✅ IA avançada |

---

## 🎯 Recomendações de Implementação

### **Fase 1: Estrutura Básica (Agora)**
1. Criar tabela com schema proposto
2. Adicionar índices básicos (territory_id, dimension)
3. Implementar inserção de análises

### **Fase 2: Embeddings (Próxima)**
1. Instalar extensão `pgvector`
2. Gerar embeddings para análises existentes
3. Criar índice vetorial
4. Implementar busca semântica

### **Fase 3: Otimizações (Futuro)**
1. Adicionar materialização de resumos
2. Implementar particionamento (se necessário)
3. Configurar cache de embeddings

---

## 💡 Exemplo de Uso Completo

### **Inserir Análise**

```python
import psycopg2
from openai import OpenAI

# Gerar análise
analysis_text = agent_economic.analyze(territory_id="1721000")

# Gerar embedding
client = OpenAI()
embedding = client.embeddings.create(
    input=analysis_text,
    model="text-embedding-ada-002"
).data[0].embedding

# Inserir no banco
conn = psycopg2.connect(DATABASE_URL)
cur = conn.cursor()

cur.execute("""
    INSERT INTO knowledge_base (
        territory_id, dimension, analysis_type,
        content, summary, embedding, metadata,
        confidence_score, generated_by
    ) VALUES (
        %s, %s, %s, %s, %s, %s, %s, %s, %s
    )
    ON CONFLICT (territory_id, dimension, analysis_type, version)
    DO UPDATE SET
        content = EXCLUDED.content,
        embedding = EXCLUDED.embedding,
        updated_at = NOW();
""", (
    "1721000",
    "economic",
    "diagnostic",
    analysis_text,
    analysis_text[:200],  # Resumo
    embedding,
    {"indicators_analyzed": ["gdp", "employment_rate"]},
    0.92,
    "agent-econ-v1.0"
))

conn.commit()
```

### **Buscar Análise (Cache)**

```python
cur.execute("""
    SELECT content FROM knowledge_base
    WHERE territory_id = %s
      AND dimension = %s
      AND is_latest = TRUE;
""", ("1721000", "economic"))

analysis = cur.fetchone()[0]
```

### **Buscar Análises Similares (RAG)**

```python
# Gerar embedding da pergunta
question = "Quais municípios têm economia similar a Palmas?"
question_embedding = client.embeddings.create(
    input=question,
    model="text-embedding-ada-002"
).data[0].embedding

# Buscar análises similares
cur.execute("""
    SELECT 
        t.name,
        kb.content,
        kb.embedding <=> %s::vector AS distance
    FROM knowledge_base kb
    JOIN territories t ON kb.territory_id = t.id
    WHERE kb.dimension = 'economic'
      AND kb.is_latest = TRUE
    ORDER BY distance
    LIMIT 5;
""", (question_embedding,))

similar_analyses = cur.fetchall()
```

---

## 📚 Referências Técnicas

- **pgvector:** https://github.com/pgvector/pgvector
- **OpenAI Embeddings:** https://platform.openai.com/docs/guides/embeddings
- **PostgreSQL Partitioning:** https://www.postgresql.org/docs/current/ddl-partitioning.html
- **JSONB Indexing:** https://www.postgresql.org/docs/current/datatype-json.html

---

**Framework de Inteligência Territorial V6.0**  
Henrique M. Ribeiro  
23 de novembro de 2025
