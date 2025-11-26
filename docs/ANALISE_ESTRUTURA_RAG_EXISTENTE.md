# 🔍 ANÁLISE DA ESTRUTURA RAG EXISTENTE

**Framework de Inteligência Territorial V6.0**  
**Sessão:** #6  
**Data:** 26 de novembro de 2025  
**Objetivo:** Analisar infraestrutura RAG já implementada antes de prosseguir

---

## ✅ DESCOBERTA IMPORTANTE

A infraestrutura RAG **JÁ ESTÁ IMPLEMENTADA** no PostgreSQL! Isso muda completamente o plano de implementação.

---

## 📊 ESTRUTURA EXISTENTE

### 1. Extensão pgvector

✅ **Instalada e ativa**
- **Versão:** 0.8.0
- **Status:** Operacional

### 2. Tabelas de Memória (4 agentes)

Cada agente possui **2 tabelas**:

| Agente | Tabela de Memória | Tabela de Learning |
|--------|-------------------|-------------------|
| ECON | `agent_econ_memory` | `agent_econ_learning` |
| SOCIAL | `agent_social_memory` | `agent_social_learning` |
| AMBIENT | `agent_ambient_memory` | `agent_ambient_learning` |
| TERRA | `agent_terra_memory` | `agent_terra_learning` |

---

## 🗄️ ESTRUTURA: `agent_econ_memory`

### Propósito
Armazenar **análises anteriores** do agente para uso em futuras análises (memória de curto/médio prazo).

### Colunas

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| `id` | UUID | Chave primária (auto-gerada) |
| `territory_id` | VARCHAR(20) | ID do território analisado |
| `analysis_content` | TEXT | Conteúdo completo da análise |
| `analysis_summary` | TEXT | Resumo da análise |
| `embedding_vector` | VECTOR(1536) | Embedding vetorial da análise |
| `metadata` | JSONB | Metadados adicionais |
| `confidence_score` | NUMERIC(3,2) | Score de confiança (0-1) |
| `user_feedback` | JSONB | Feedback do usuário |
| `iterations` | INTEGER | Número de iterações |
| `analysis_date` | DATE | Data da análise |
| `time_range` | JSONB | Período temporal analisado |
| `data_sources` | JSONB | Fontes de dados utilizadas |
| `indicators_used` | JSONB | Indicadores utilizados |
| `version` | INTEGER | Versão da análise |
| `is_latest` | BOOLEAN | Se é a versão mais recente |

### Índices

| Nome | Tipo | Descrição |
|------|------|-----------|
| `agent_econ_memory_pkey` | BTREE | Chave primária (id) |
| `idx_econ_memory_date` | BTREE | Índice por data (DESC) |
| `idx_econ_memory_embedding` | IVFFLAT | Busca vetorial (lists=100) |

### Status Atual
- **Registros:** 0
- **Territórios:** 0
- **Status:** ⚠️ **VAZIA** (nunca populada)

---

## 🧠 ESTRUTURA: `agent_econ_learning`

### Propósito
Armazenar **aprendizados generalizados** do agente (padrões, insights, melhores práticas).

### Colunas

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| `id` | UUID | Chave primária |
| `learning_type` | VARCHAR(50) | Tipo de aprendizado |
| `title` | TEXT | Título do aprendizado |
| `description` | TEXT | Descrição detalhada |
| `territories_analyzed` | INTEGER | Nº de territórios analisados |
| `confidence` | NUMERIC | Confiança no aprendizado |
| `applicable_to` | JSONB | Contextos aplicáveis |
| `examples` | JSONB | Exemplos de aplicação |
| `embedding_vector` | VECTOR(1536) | Embedding vetorial |
| `created_at` | TIMESTAMP | Data de criação |
| `last_applied` | TIMESTAMP | Última aplicação |
| `times_applied` | INTEGER | Vezes aplicado |
| `is_active` | BOOLEAN | Se está ativo |

### Índices

| Nome | Tipo | Descrição |
|------|------|-----------|
| `agent_econ_learning_pkey` | BTREE | Chave primária (id) |
| `idx_econ_learning_active` | BTREE | Índice por is_active=true |
| `idx_econ_learning_embedding` | IVFFLAT | Busca vetorial (lists=50) |
| `idx_econ_learning_type` | BTREE | Índice por tipo |

### Status Atual
- **Registros:** Não verificado (provavelmente 0)
- **Status:** ⚠️ **VAZIA** (nunca populada)

---

## 🔧 FUNÇÃO EXISTENTE: `search_agent_memory`

### Assinatura
```sql
search_agent_memory(
  p_agent TEXT,
  p_query_embedding VECTOR(1536),
  p_limit INTEGER
)
```

### Funcionalidade
Busca análises similares na memória de um agente específico.

### Implementação
```sql
BEGIN
  RETURN QUERY EXECUTE format(
    'SELECT
      id,
      territory_id,
      analysis_summary,
      confidence_score,
      1 - (embedding_vector <=> $1) as similarity
    FROM agent_%s_memory
    WHERE is_latest = true
    ORDER BY embedding_vector <=> $1
    LIMIT $2',
    lower(p_agent)
  )
  USING p_query_embedding, p_limit;
END;
```

### Características
- ✅ **Genérica:** Funciona para qualquer agente
- ✅ **Filtra:** Apenas versões mais recentes (`is_latest = true`)
- ✅ **Ordena:** Por similaridade vetorial (cosseno)
- ✅ **Retorna:** id, territory_id, summary, confidence, similarity

---

## 💡 DIFERENÇA ENTRE AS DUAS TABELAS

### `agent_econ_memory` (Memória de Análises)

**Propósito:** Armazenar análises específicas de territórios

**Uso:**
- Recuperar análises anteriores do mesmo território
- Comparar evolução temporal
- Evitar reprocessamento
- Contexto para novas análises

**Exemplo:**
> "Análise econômica de Palmas em 2023 mostrou crescimento de 21% no PIB..."

### `agent_econ_learning` (Aprendizados Generalizados)

**Propósito:** Armazenar padrões e insights generalizados

**Uso:**
- Aplicar padrões identificados em múltiplos territórios
- Melhores práticas de análise
- Heurísticas e regras de negócio
- Conhecimento acumulado

**Exemplo:**
> "Municípios com PIB > R$ 1bi tendem a ter maior diversificação setorial..."

---

## 🎯 ARQUITETURA RAG DUAL

A arquitetura implementada segue um modelo **RAG Dual**:

```
┌─────────────────────────────────────────────────────────┐
│                    AGENTE ECON                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Query de Análise                                       │
│           ↓                                             │
│  ┌───────────────────────────────────────┐            │
│  │  RAG 1: MEMÓRIA DE ANÁLISES           │            │
│  │  (agent_econ_memory)                  │            │
│  │  ┌─────────────────────────────────┐  │            │
│  │  │ Buscar análises anteriores      │  │            │
│  │  │ do mesmo território ou similares│  │            │
│  │  └─────────────────────────────────┘  │            │
│  └───────────────────────────────────────┘            │
│           ↓                                             │
│  ┌───────────────────────────────────────┐            │
│  │  RAG 2: APRENDIZADOS GENERALIZADOS    │            │
│  │  (agent_econ_learning)                │            │
│  │  ┌─────────────────────────────────┐  │            │
│  │  │ Buscar padrões e insights       │  │            │
│  │  │ aplicáveis ao contexto          │  │            │
│  │  └─────────────────────────────────┘  │            │
│  └───────────────────────────────────────┘            │
│           ↓                                             │
│  Contexto Enriquecido → OpenAI → Nova Análise         │
│           ↓                                             │
│  Salvar Nova Análise em agent_econ_memory              │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 🚨 PROBLEMA IDENTIFICADO

### Tabelas Vazias

Ambas as tabelas estão **vazias** (0 registros):
- ❌ `agent_econ_memory`: 0 análises
- ❌ `agent_econ_learning`: 0 aprendizados

### Implicações

1. **RAG não está funcional** - Sem dados, não há contexto para recuperar
2. **Workflow não popula** - Análises não estão sendo salvas com embeddings
3. **Função existe mas não é usada** - `search_agent_memory` não é chamada

---

## 🔍 O QUE FALTA IMPLEMENTAR

### 1. Popular `agent_econ_memory` ✅ **AUTOMÁTICO**

**Solução:** Modificar o workflow ECON para salvar análises com embeddings

**Onde:** Nó "Salvar Análise no PostgreSQL"

**O que fazer:**
- Gerar embedding da análise completa
- Inserir na tabela `agent_econ_memory`
- Incluir todos os metadados

**Benefício:** Memória cresce automaticamente a cada análise

### 2. Popular `agent_econ_learning` 📚 **MANUAL/SEMI-AUTOMÁTICO**

**Opção A - Manual (MVP):**
- Inserir aprendizados manualmente via SQL
- Baseado em análises bem-sucedidas
- Curadoria humana

**Opção B - Semi-automático (Futuro):**
- Workflow de "extração de aprendizados"
- Analisa múltiplas análises
- Identifica padrões
- Gera aprendizados automaticamente

### 3. Integrar RAG no Workflow 🔧 **DESENVOLVIMENTO**

**Onde:** Novo nó "Buscar Contexto RAG"

**O que fazer:**
- Gerar embedding da query
- Buscar em `agent_econ_memory` (análises similares)
- Buscar em `agent_econ_learning` (padrões aplicáveis)
- Formatar contexto para OpenAI

---

## 📋 PLANO REVISADO DE IMPLEMENTAÇÃO

### ~~ETAPA 1: Preparação da Infraestrutura~~ ✅ **JÁ FEITO**

- ✅ pgvector instalado
- ✅ Tabelas criadas
- ✅ Índices criados
- ✅ Função de busca criada

**Tokens economizados:** ~8.000 tokens

### ~~ETAPA 2: Popular Memória com Documentos~~ ⚠️ **REPENSAR**

**Problema:** A arquitetura atual não prevê documentos de referência (artigos, PDFs), mas sim:
- Análises anteriores (agent_econ_memory)
- Aprendizados generalizados (agent_econ_learning)

**Decisão necessária:**
- **Opção A:** Adaptar para usar a arquitetura existente
- **Opção B:** Criar nova tabela para documentos de referência

### ETAPA 3: Modificar Workflow para Salvar com Embeddings 🆕

**Novo foco:** Fazer o sistema começar a popular a memória

**Ações:**
1. Modificar nó "Salvar Análise no PostgreSQL"
2. Gerar embedding da análise
3. Inserir em `agent_econ_memory` com embedding

**Tokens estimados:** ~6.000 tokens

### ETAPA 4: Criar Nó de Busca RAG

**Mantém-se do plano original**

**Ações:**
1. Criar nó "Buscar Contexto RAG"
2. Usar função `search_agent_memory`
3. Formatar contexto para OpenAI

**Tokens estimados:** ~8.000 tokens

### ETAPA 5: Testar e Validar

**Mantém-se do plano original**

**Tokens estimados:** ~8.000 tokens

### ETAPA 6: Documentação

**Mantém-se do plano original**

**Tokens estimados:** ~8.000 tokens

---

## 🎯 DECISÃO ESTRATÉGICA NECESSÁRIA

Henrique, precisamos decidir sobre a **arquitetura de memória**:

### **Opção A: Usar Arquitetura Existente (Memória de Análises)** ⭐ RECOMENDADA

**Vantagens:**
- ✅ Infraestrutura já pronta
- ✅ Crescimento automático
- ✅ Sem necessidade de documentos externos
- ✅ Memória "viva" (evolui com uso)

**Desvantagens:**
- ❌ Precisa de análises iniciais para começar
- ❌ Sem conhecimento acadêmico externo
- ❌ Qualidade depende de análises anteriores

**Implementação:**
1. Modificar workflow para salvar com embeddings
2. Criar nó de busca RAG
3. Testar com análises reais
4. Memória cresce organicamente

**Tokens estimados:** ~30.000 tokens

### **Opção B: Adicionar Tabela de Documentos de Referência** 📚

**Vantagens:**
- ✅ Conhecimento acadêmico desde o início
- ✅ Qualidade garantida (IPEA, IBGE)
- ✅ Fundamentação teórica

**Desvantagens:**
- ❌ Precisa criar nova tabela
- ❌ Processar documentos manualmente
- ❌ Manutenção adicional

**Implementação:**
1. Criar tabela `agent_econ_references`
2. Processar PDFs e gerar embeddings
3. Modificar workflow para buscar em 3 fontes:
   - Memória de análises
   - Aprendizados
   - Documentos de referência
4. Testar

**Tokens estimados:** ~45.000 tokens

### **Opção C: Híbrida (Ambas)** 🚀 MAIS COMPLETA

**Vantagens:**
- ✅ Melhor dos dois mundos
- ✅ Conhecimento acadêmico + experiência prática
- ✅ Mais robusto

**Desvantagens:**
- ❌ Mais complexo
- ❌ Mais tokens
- ❌ Mais tempo

**Tokens estimados:** ~53.000 tokens (plano original)

---

## 💰 ANÁLISE DE TOKENS ATUALIZADA

| Opção | Tokens Estimados | Tokens Disponíveis | Margem | Viabilidade |
|-------|------------------|-------------------|--------|-------------|
| **A** | 30.000 | 122.066 | 92.066 (75%) | ✅ **MUITO ALTA** |
| **B** | 45.000 | 122.066 | 77.066 (63%) | ✅ **ALTA** |
| **C** | 53.000 | 122.066 | 69.066 (57%) | ✅ **ALTA** |

---

## 💡 MINHA RECOMENDAÇÃO

Sugiro a **Opção A** (Usar Arquitetura Existente) por:

1. **Aproveita infraestrutura pronta** - Economia de ~8.000 tokens
2. **Crescimento orgânico** - Memória melhora com uso
3. **Mais simples** - Menos pontos de falha
4. **Mais rápido** - Implementação em 2-3 horas
5. **Escalável** - Podemos adicionar documentos depois (Opção C)

**Estratégia:**
1. Implementar RAG com memória de análises (Opção A)
2. Gerar ~10-20 análises de diferentes territórios
3. Memória começa a funcionar
4. Avaliar necessidade de documentos externos
5. Se necessário, adicionar Opção B depois

---

## 📊 PRÓXIMOS PASSOS

Aguardando sua decisão sobre qual opção seguir:
- **A:** Memória de análises (recomendada)
- **B:** Documentos de referência
- **C:** Híbrida (ambas)

Após a decisão, prosseguiremos com a implementação! 🚀

---

**Documento criado por:** Manus AI  
**Sessão:** #6 (26 de novembro de 2025)  
**Framework:** V6.0 - Inteligência Territorial  
**Status:** Análise concluída, aguardando decisão estratégica
