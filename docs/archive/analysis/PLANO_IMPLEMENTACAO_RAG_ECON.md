# 🧠 PLANO DE IMPLEMENTAÇÃO: RAG no Agente ECON

**Framework de Inteligência Territorial V6.0**  
**Sessão:** #6  
**Data:** 26 de novembro de 2025  
**Agente:** ECON (Especialista Econômico)

---

## 🎯 OBJETIVO ESTRATÉGICO

Implementar um sistema de **Retrieval-Augmented Generation (RAG)** no Agente ECON para:

✅ **Enriquecer análises** com conhecimento especializado de fontes acadêmicas  
✅ **Reduzir alucinações** da LLM com contexto factual  
✅ **Evoluir continuamente** através de memória de longo prazo  
✅ **Fundamentar insights** com referências bibliográficas  
✅ **Escalar conhecimento** sem re-treinar modelos

---

## 📊 ARQUITETURA DO RAG

### Visão Geral

```
┌─────────────────────────────────────────────────────────┐
│                    WORKFLOW ECON                        │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  1. Webhook Recebe Tarefa                              │
│           ↓                                             │
│  2. Consultar Dados PostgreSQL                         │
│           ↓                                             │
│  3. Preparar Contexto para LLM                         │
│           ↓                                             │
│  ┌───────────────────────────────────────┐            │
│  │  4. BUSCA RAG (NOVO)                  │            │
│  │  ┌─────────────────────────────────┐  │            │
│  │  │ a) Gerar embedding da query     │  │            │
│  │  │ b) Buscar similaridade vetorial │  │            │
│  │  │ c) Recuperar top-k documentos   │  │            │
│  │  │ d) Adicionar ao contexto        │  │            │
│  │  └─────────────────────────────────┘  │            │
│  └───────────────────────────────────────┘            │
│           ↓                                             │
│  5. Gerar Análise com OpenAI (contexto enriquecido)   │
│           ↓                                             │
│  6. Estruturar Resposta                                │
│           ↓                                             │
│  7. Salvar Análise no PostgreSQL                       │
│           ↓                                             │
│  8. Preparar Resposta do Webhook                       │
│           ↓                                             │
│  9. Respond to Webhook                                 │
│                                                         │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│              BANCO DE DADOS POSTGRESQL                  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Tabela: agent_econ_memory                             │
│  ┌───────────────────────────────────────────────┐    │
│  │ id (PK)                                       │    │
│  │ document_title                                │    │
│  │ document_source                               │    │
│  │ document_type (academic_paper, report, etc.)  │    │
│  │ content_text                                  │    │
│  │ content_embedding (vector)                    │    │
│  │ metadata (JSONB)                              │    │
│  │ created_at                                    │    │
│  │ updated_at                                    │    │
│  └───────────────────────────────────────────────┘    │
│                                                         │
│  Índice: vector_similarity (pgvector)                  │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 📋 ETAPAS DE IMPLEMENTAÇÃO

### **ETAPA 1: Preparação da Infraestrutura** 🏗️

**Duração estimada:** 30-45 minutos  
**Tokens estimados:** 8.000 tokens

#### 1.1. Instalar Extensão pgvector no PostgreSQL

**Ação:**
```sql
CREATE EXTENSION IF NOT EXISTS vector;
```

**Verificação:**
```sql
SELECT * FROM pg_extension WHERE extname = 'vector';
```

#### 1.2. Criar Tabela de Memória

**Script SQL:**
```sql
CREATE TABLE IF NOT EXISTS agent_econ_memory (
    id SERIAL PRIMARY KEY,
    document_title VARCHAR(500) NOT NULL,
    document_source VARCHAR(500) NOT NULL,
    document_type VARCHAR(100) NOT NULL,
    content_text TEXT NOT NULL,
    content_embedding vector(1536),  -- OpenAI text-embedding-3-small
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índice para busca por similaridade
CREATE INDEX IF NOT EXISTS agent_econ_memory_embedding_idx 
ON agent_econ_memory 
USING ivfflat (content_embedding vector_cosine_ops)
WITH (lists = 100);

-- Índice para busca por tipo de documento
CREATE INDEX IF NOT EXISTS agent_econ_memory_type_idx 
ON agent_econ_memory (document_type);

-- Índice para busca por fonte
CREATE INDEX IF NOT EXISTS agent_econ_memory_source_idx 
ON agent_econ_memory (document_source);
```

#### 1.3. Criar Função de Busca por Similaridade

**Script SQL:**
```sql
CREATE OR REPLACE FUNCTION search_similar_documents(
    query_embedding vector(1536),
    match_threshold float DEFAULT 0.7,
    match_count int DEFAULT 5
)
RETURNS TABLE (
    id int,
    document_title varchar,
    document_source varchar,
    document_type varchar,
    content_text text,
    similarity float,
    metadata jsonb
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        m.id,
        m.document_title,
        m.document_source,
        m.document_type,
        m.content_text,
        1 - (m.content_embedding <=> query_embedding) as similarity,
        m.metadata
    FROM agent_econ_memory m
    WHERE 1 - (m.content_embedding <=> query_embedding) > match_threshold
    ORDER BY m.content_embedding <=> query_embedding
    LIMIT match_count;
END;
$$;
```

**Tokens desta etapa:** ~8.000 tokens

---

### **ETAPA 2: Popular Memória com Documentos de Referência** 📚

**Duração estimada:** 1-2 horas  
**Tokens estimados:** 12.000 tokens

#### 2.1. Selecionar Documentos de Referência

**Critérios de seleção:**
- ✅ Artigos acadêmicos de economia regional
- ✅ Publicações do IPEA sobre desenvolvimento econômico
- ✅ Relatórios do IBGE sobre indicadores econômicos
- ✅ Estudos sobre economia do Tocantins

**Documentos sugeridos (1-2 para MVP):**

1. **"Desenvolvimento Econômico Regional no Brasil"** (IPEA)
   - Fonte: https://www.ipea.gov.br
   - Tipo: academic_paper
   - Relevância: Alta (contexto nacional e regional)

2. **"Indicadores Econômicos Municipais: Metodologia e Aplicações"** (IBGE)
   - Fonte: https://www.ibge.gov.br
   - Tipo: technical_report
   - Relevância: Alta (metodologia de análise)

#### 2.2. Processar Documentos

**Workflow de processamento:**

```
1. Download do PDF
   ↓
2. Extrair texto (poppler-utils)
   ↓
3. Limpar e normalizar
   ↓
4. Chunking (dividir em blocos de ~500 tokens)
   ↓
5. Gerar embeddings (OpenAI text-embedding-3-small)
   ↓
6. Salvar no PostgreSQL
```

**Script Python (exemplo):**
```python
import os
from openai import OpenAI
import psycopg2
from pdf2image import convert_from_path
import pytesseract

client = OpenAI()  # API key já configurada

def process_document(pdf_path, title, source, doc_type):
    # 1. Extrair texto do PDF
    text = extract_text_from_pdf(pdf_path)
    
    # 2. Dividir em chunks
    chunks = chunk_text(text, max_tokens=500)
    
    # 3. Gerar embeddings e salvar
    conn = psycopg2.connect(os.getenv('DATABASE_URL'))
    cur = conn.cursor()
    
    for i, chunk in enumerate(chunks):
        # Gerar embedding
        response = client.embeddings.create(
            model="text-embedding-3-small",
            input=chunk
        )
        embedding = response.data[0].embedding
        
        # Salvar no banco
        cur.execute("""
            INSERT INTO agent_econ_memory 
            (document_title, document_source, document_type, 
             content_text, content_embedding, metadata)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (
            f"{title} (Parte {i+1})",
            source,
            doc_type,
            chunk,
            embedding,
            {'chunk_index': i, 'total_chunks': len(chunks)}
        ))
    
    conn.commit()
    cur.close()
    conn.close()
    
    print(f"✅ Documento '{title}' processado: {len(chunks)} chunks")

def extract_text_from_pdf(pdf_path):
    # Implementação de extração de texto
    pass

def chunk_text(text, max_tokens=500):
    # Implementação de chunking
    pass
```

**Tokens desta etapa:** ~12.000 tokens

---

### **ETAPA 3: Criar Nó de Busca RAG no Workflow** 🔍

**Duração estimada:** 45-60 minutos  
**Tokens estimados:** 10.000 tokens

#### 3.1. Adicionar Nó "Buscar Conhecimento RAG"

**Posição no workflow:**
- **Após:** "Preparar Contexto para LLM"
- **Antes:** "Gerar Análise com OpenAI"

**Tipo de nó:** Code (JavaScript)

**Código JavaScript:**
```javascript
// ===============================================
// NÓ: BUSCAR CONHECIMENTO RAG
// Framework de Inteligência Territorial V6.0
// ===============================================
// FUNÇÃO: Buscar documentos relevantes na memória
//         do agente para enriquecer o contexto
// ===============================================

const { OpenAI } = require('openai');
const { Client } = require('pg');

// 1. EXTRAIR DADOS DO NÓ ANTERIOR
const contextData = $input.first().json;
const territoryName = contextData.territory_name;
const focusAreas = contextData.parameters.focus_areas.join(', ');

// 2. CONSTRUIR QUERY PARA RAG
const ragQuery = `
Análise econômica de ${territoryName} focando em: ${focusAreas}.
Contexto: indicadores econômicos, PIB, emprego, renda, setores produtivos.
`;

console.log('🔍 Query RAG:', ragQuery);

// 3. GERAR EMBEDDING DA QUERY
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY
});

const embeddingResponse = await openai.embeddings.create({
  model: 'text-embedding-3-small',
  input: ragQuery
});

const queryEmbedding = embeddingResponse.data[0].embedding;
console.log('✅ Embedding gerado:', queryEmbedding.length, 'dimensões');

// 4. BUSCAR DOCUMENTOS SIMILARES NO POSTGRESQL
const client = new Client({
  connectionString: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false }
});

await client.connect();

const result = await client.query(`
  SELECT * FROM search_similar_documents(
    $1::vector,
    0.7,  -- threshold de similaridade
    3     -- top-3 documentos
  )
`, [[queryEmbedding]]);

await client.end();

console.log('📚 Documentos encontrados:', result.rows.length);

// 5. FORMATAR CONTEXTO RAG
let ragContext = '';

if (result.rows.length > 0) {
  ragContext = '\n\n## 📚 CONHECIMENTO DE REFERÊNCIA\n\n';
  
  result.rows.forEach((doc, index) => {
    ragContext += `### Referência ${index + 1}: ${doc.document_title}\n`;
    ragContext += `**Fonte:** ${doc.document_source}\n`;
    ragContext += `**Similaridade:** ${(doc.similarity * 100).toFixed(1)}%\n\n`;
    ragContext += `${doc.content_text}\n\n`;
    ragContext += `---\n\n`;
  });
  
  console.log('✅ Contexto RAG construído:', ragContext.length, 'caracteres');
} else {
  console.log('⚠️ Nenhum documento relevante encontrado');
  ragContext = '\n\n## ℹ️ Nenhuma referência específica encontrada na base de conhecimento.\n\n';
}

// 6. RETORNAR DADOS ENRIQUECIDOS
return {
  ...contextData,
  rag_context: ragContext,
  rag_documents_found: result.rows.length,
  rag_documents: result.rows.map(doc => ({
    title: doc.document_title,
    source: doc.document_source,
    similarity: doc.similarity
  }))
};
```

#### 3.2. Atualizar Nó "Preparar Contexto para LLM"

**Modificação:**
Incluir o `rag_context` no prompt enviado para a OpenAI.

**Antes:**
```javascript
const prompt = `
Você é um especialista econômico...

## DADOS DO TERRITÓRIO
${territoryData}

## TAREFA
Analise os dados e gere insights...
`;
```

**Depois:**
```javascript
const prompt = `
Você é um especialista econômico...

## DADOS DO TERRITÓRIO
${territoryData}

${ragContext}  // ← NOVO: Contexto RAG

## TAREFA
Analise os dados, considerando as referências fornecidas, e gere insights...
`;
```

**Tokens desta etapa:** ~10.000 tokens

---

### **ETAPA 4: Testar e Validar** 🧪

**Duração estimada:** 30-45 minutos  
**Tokens estimados:** 8.000 tokens

#### 4.1. Teste Básico (Sem RAG)

**Objetivo:** Estabelecer baseline

**POST Request:**
```json
{
  "task_id": "test-rag-baseline",
  "agent_name": "ECON",
  "territory_id": "1721000",
  "territory_name": "Palmas",
  "territory_type": "municipality",
  "analysis_type": "economic",
  "parameters": {
    "focus_areas": ["PIB", "emprego"],
    "time_period": "2019-2023",
    "detail_level": "comprehensive"
  }
}
```

**Resultado esperado:**
- Análise sem referências bibliográficas
- Tempo de processamento: ~30-40s

#### 4.2. Teste com RAG

**Objetivo:** Validar enriquecimento

**POST Request:** (mesmo do teste básico)

**Resultado esperado:**
- Análise com referências bibliográficas
- Seção "Conhecimento de Referência" no contexto
- Insights mais fundamentados
- Tempo de processamento: ~35-45s (overhead de ~5-10s)

#### 4.3. Validação de Qualidade

**Critérios:**
- ✅ Documentos relevantes são recuperados (similaridade > 70%)
- ✅ Contexto RAG é incluído no prompt
- ✅ Análise menciona ou reflete o conhecimento recuperado
- ✅ Tempo de processamento aceitável (< 60s)
- ✅ Sem erros no workflow

**Tokens desta etapa:** ~8.000 tokens

---

### **ETAPA 5: Documentação** 📝

**Duração estimada:** 45-60 minutos  
**Tokens estimados:** 10.000 tokens

#### 5.1. Documentos a Criar

1. **IMPLEMENTACAO_RAG_ECON.md**
   - Arquitetura detalhada
   - Scripts SQL completos
   - Código JavaScript completo
   - Exemplos de uso

2. **GUIA_POPULAR_MEMORIA_ECON.md**
   - Como adicionar novos documentos
   - Critérios de seleção
   - Script Python de processamento

3. **TESTE_RAG_ECON.md**
   - Casos de teste
   - Resultados esperados
   - Comparação antes/depois

4. **FAQ_RAG_ECON.md**
   - Perguntas frequentes
   - Troubleshooting
   - Otimizações

**Tokens desta etapa:** ~10.000 tokens

---

### **ETAPA 6: Diário Reflexivo** 📔

**Duração estimada:** 30 minutos  
**Tokens estimados:** 5.000 tokens

#### Conteúdo

- Reflexão sobre a implementação
- Desafios encontrados
- Aprendizados
- Próximos passos
- Implicações para o projeto

**Tokens desta etapa:** ~5.000 tokens

---

## 📊 RESUMO DE TOKENS

| Etapa | Descrição | Tokens Estimados |
|-------|-----------|------------------|
| 1 | Preparação da Infraestrutura | 8.000 |
| 2 | Popular Memória com Documentos | 12.000 |
| 3 | Criar Nó de Busca RAG | 10.000 |
| 4 | Testar e Validar | 8.000 |
| 5 | Documentação | 10.000 |
| 6 | Diário Reflexivo | 5.000 |
| **TOTAL** | **Implementação Completa** | **53.000 tokens** |

### Margem de Segurança

- **Tokens disponíveis:** 123.518 tokens
- **Tokens estimados:** 53.000 tokens
- **Margem de segurança:** 70.518 tokens (57% do disponível)
- **Viabilidade:** ✅ **MUITO ALTA**

---

## 🎯 BENEFÍCIOS ESPERADOS

### Imediatos

✅ **Análises mais fundamentadas** - Baseadas em literatura acadêmica  
✅ **Redução de alucinações** - Contexto factual da memória  
✅ **Rastreabilidade** - Referências bibliográficas nas análises  
✅ **Credibilidade** - Insights apoiados por fontes confiáveis

### Médio Prazo

✅ **Evolução contínua** - Memória cresce com novos documentos  
✅ **Especialização** - Agente se torna expert em economia regional  
✅ **Consistência** - Análises alinhadas com conhecimento consolidado  
✅ **Escalabilidade** - Modelo replicável para outros agentes

---

## 🚀 PRÓXIMOS PASSOS (PÓS-IMPLEMENTAÇÃO)

### Otimizações Futuras

1. **Chunking Inteligente**
   - Usar técnicas de semantic chunking
   - Preservar contexto entre chunks

2. **Re-ranking**
   - Adicionar camada de re-ranking dos documentos
   - Melhorar relevância dos resultados

3. **Feedback Loop**
   - Coletar feedback sobre qualidade das análises
   - Ajustar threshold de similaridade

4. **Expansão da Memória**
   - Adicionar mais documentos de referência
   - Incluir análises anteriores bem-sucedidas

### Escalabilidade

1. **Replicar para outros agentes**
   - SOCIAL: Artigos de sociologia e políticas sociais
   - AMBIENT: Estudos ambientais e sustentabilidade
   - TERRA: Planejamento urbano e territorial

2. **RAG Corporativo**
   - Memória compartilhada entre agentes
   - Conhecimento interdisciplinar

---

## 💡 DECISÕES TÉCNICAS

### Por que OpenAI text-embedding-3-small?

- ✅ **Custo-benefício:** $0.02 / 1M tokens
- ✅ **Performance:** 1536 dimensões, alta qualidade
- ✅ **Compatibilidade:** Integração nativa com n8n
- ✅ **Velocidade:** ~100ms por embedding

### Por que pgvector?

- ✅ **Integração:** Já usamos PostgreSQL
- ✅ **Performance:** Índices IVFFlat eficientes
- ✅ **Simplicidade:** Sem infraestrutura adicional
- ✅ **Escalabilidade:** Suporta milhões de vetores

### Por que Chunking de 500 tokens?

- ✅ **Contexto:** Suficiente para manter coerência
- ✅ **Relevância:** Evita chunks muito genéricos
- ✅ **Performance:** Balanço entre precisão e velocidade

---

## 📚 REFERÊNCIAS

### Técnicas

- [pgvector Documentation](https://github.com/pgvector/pgvector)
- [OpenAI Embeddings Guide](https://platform.openai.com/docs/guides/embeddings)
- [RAG Best Practices](https://www.pinecone.io/learn/retrieval-augmented-generation/)

### Acadêmicas

- Lewis et al. (2020) - "Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks"
- Gao et al. (2023) - "Retrieval-Augmented Generation for Large Language Models: A Survey"

---

## ✅ CHECKLIST DE IMPLEMENTAÇÃO

### Pré-requisitos

- [ ] PostgreSQL com extensão pgvector instalada
- [ ] OpenAI API key configurada
- [ ] Documentos de referência selecionados
- [ ] Ambiente de teste preparado

### Etapa 1: Infraestrutura

- [ ] Extensão pgvector instalada
- [ ] Tabela `agent_econ_memory` criada
- [ ] Índices criados
- [ ] Função `search_similar_documents` criada
- [ ] Testes de conexão realizados

### Etapa 2: Popular Memória

- [ ] Documentos baixados
- [ ] Texto extraído dos PDFs
- [ ] Chunks gerados
- [ ] Embeddings criados
- [ ] Dados salvos no PostgreSQL
- [ ] Validação de inserção

### Etapa 3: Workflow

- [ ] Nó "Buscar Conhecimento RAG" criado
- [ ] Nó "Preparar Contexto para LLM" atualizado
- [ ] Workflow salvo
- [ ] Testes de sintaxe realizados

### Etapa 4: Testes

- [ ] Teste baseline (sem RAG) realizado
- [ ] Teste com RAG realizado
- [ ] Comparação de resultados
- [ ] Validação de qualidade
- [ ] Ajustes realizados

### Etapa 5: Documentação

- [ ] IMPLEMENTACAO_RAG_ECON.md criado
- [ ] GUIA_POPULAR_MEMORIA_ECON.md criado
- [ ] TESTE_RAG_ECON.md criado
- [ ] FAQ_RAG_ECON.md criado
- [ ] Commits no GitHub

### Etapa 6: Reflexão

- [ ] Diário reflexivo criado
- [ ] Aprendizados documentados
- [ ] Próximos passos definidos

---

## 🎉 CONCLUSÃO

Este plano fornece um roteiro completo e detalhado para implementar RAG no Agente ECON, com:

✅ **Arquitetura clara** e bem documentada  
✅ **Estimativas realistas** de tempo e tokens  
✅ **Scripts prontos** para uso  
✅ **Testes definidos** para validação  
✅ **Documentação completa** para manutenção  
✅ **Margem de segurança** confortável (57%)

**Pronto para começar?** 🚀

---

**Documento criado por:** Manus AI  
**Sessão:** #6 (26 de novembro de 2025)  
**Framework:** V6.0 - Inteligência Territorial  
**Status:** Plano aprovado, aguardando execução
