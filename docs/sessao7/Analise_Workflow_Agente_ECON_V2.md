# Análise do Workflow: Agente ECON V2 (n8n)

**Data:** 29/11/2025  
**Autor:** Manus AI  
**Workflow:** WF-AGENT-ECON - Especialista Econômico V2

---

## 1. Visão Geral

O Agente ECON V2 é um workflow implementado no n8n que funciona como um **especialista econômico autônomo** para análise territorial. Ele recebe requisições via webhook, consulta dados econômicos no banco PostgreSQL, gera análises usando LLM (GPT-4o-mini) e armazena os resultados de volta no banco.

### Estatísticas do Workflow

| Métrica | Valor |
|---------|-------|
| **Total de Nós** | 10 |
| **Conexões** | 8 |
| **Pontos de Entrada** | 1 (Webhook POST) |
| **Pontos de Saída** | 2 (Sucesso + Erro) |
| **Operações de Leitura (DB)** | 1 |
| **Operações de Escrita (DB)** | 1 |
| **Modelo LLM** | GPT-4o-mini |

---

## 2. Arquitetura do Workflow

### 2.1. Fluxo Principal (Happy Path)

```
1. Webhook - Recebe Tarefa (POST /agent-econ)
   ↓
2. Consultar Dados PostgreSQL (SELECT territories + economic_indicators)
   ↓
3. Preparar Contexto para LLM (174 linhas de código JS)
   ↓
4. Gerar Análise com OpenAI (GPT-4o-mini)
   ↓
5. Estruturar Resposta (66 linhas de código JS)
   ↓
6. Preparar Dados para Salvar (38 linhas de código JS)
   ↓
7. Salvar Análise no PostgreSQL (INSERT INTO knowledge_base)
   ↓
8. Preparar Resposta do Webhook (112 linhas de código JS)
   ↓
9. Respond to Webhook (Retorna análise ao orquestrador)
```

### 2.2. Fluxo de Erro

Três nós possuem tratamento de erro (`onError: continueErrorOutput`):
- **Consultar Dados PostgreSQL** → Responder Erro
- **Gerar Análise com OpenAI** → Responder Erro
- **Salvar Análise no PostgreSQL** → Responder Erro

---

## 3. Análise Detalhada dos Nós

### 3.1. Webhook - Recebe Tarefa

**Tipo:** `n8n-nodes-base.webhook`  
**Função:** Ponto de entrada do agente via requisição HTTP POST.

**Payload Esperado:**
```json
{
  "task_id": "uuid-12345",
  "territory_id": 1,
  "territory_name": "Palmas",
  "dimension": "economic",
  "task_description": "Analisar evolução econômica de Palmas (2019-2023)",
  "context": {
    "user_question": "Como está a economia de Palmas?",
    "comparison_territories": [],
    "time_period": "2019-2023"
  }
}
```

**Configurações:**
- **Método:** POST
- **Path:** `/agent-econ`
- **Response Mode:** `responseNode` (resposta será enviada por nó específico)
- **CORS:** Permitido de qualquer origem

---

### 3.2. Consultar Dados PostgreSQL

**Tipo:** `n8n-nodes-base.postgres`  
**Função:** Buscar dados econômicos do território no banco.

**Query SQL:**
```sql
SELECT 
  t.id AS territory_id,
  t.name AS territory_name,
  t.type AS territory_type,
  t.area AS territory_area_km2,
  ei.year,
  ei.gdp AS gdp_millions,
  ei.gdp_per_capita,
  ei.employment_rate,
  ei.revenue AS municipal_revenue,
  ei.sector_distribution,
  'economic' AS dimension,
  'IBGE, SICONFI, RAIS' AS data_sources
FROM territories t
LEFT JOIN economic_indicators ei ON t.id = ei.territory_id
WHERE t.id = '{{ $('Webhook - Recebe Tarefa').first().json.body.territory_id }}'
  AND ei.year >= 2019
  AND ei.year <= 2023
ORDER BY ei.year DESC;
```

**Tabelas Acessadas:**
- `territories` (dados básicos do território)
- `economic_indicators` (indicadores econômicos)

**Período:** 2019-2023 (últimos 5 anos)

**Tratamento de Erro:** `continueErrorOutput` (continua para nó de erro se falhar)

---

### 3.3. Preparar Contexto para LLM

**Tipo:** `n8n-nodes-base.code` (JavaScript)  
**Função:** Processar dados brutos do PostgreSQL e construir prompt estruturado para o LLM.

**Tamanho:** 174 linhas de código

**O que faz:**
1. Recebe dados do webhook e do PostgreSQL
2. Valida se há dados disponíveis
3. Extrai informações do webhook (task_id, territory_id, etc.)
4. Organiza dados por ano em estrutura limpa
5. Formata dados em texto legível para o LLM
6. Constrói prompt detalhado com:
   - Contexto da tarefa
   - Dados econômicos formatados
   - Instruções claras de formato
7. Retorna objeto estruturado com prompt + metadados

**Estrutura do Prompt:**
- Papel do agente (economista especializado)
- Tarefa específica
- Dados formatados e legíveis
- Instruções claras de formato de saída (9 seções obrigatórias)
- Tom desejado (profissional, acionável)

---

### 3.4. Gerar Análise com OpenAI

**Tipo:** `@n8n/n8n-nodes-langchain.openAi`  
**Função:** Gerar análise econômica usando LLM da OpenAI.

**Modelo:** `gpt-4o-mini`

**Input:** Prompt estruturado do nó anterior

**Output:** Análise econômica completa em Markdown

**Tratamento de Erro:** `continueErrorOutput` (continua para nó de erro se falhar)

---

### 3.5. Estruturar Resposta

**Tipo:** `n8n-nodes-base.code` (JavaScript)  
**Função:** Consolidar análise do LLM com metadados em resposta estruturada.

**Tamanho:** 66 linhas de código

**O que faz:**
1. Recebe análise do LLM
2. Extrai metadados (task_id, territory_id, etc.)
3. Calcula confidence_score (baseado em completude)
4. Gera resumo executivo (primeiros 500 caracteres)
5. Retorna objeto estruturado com:
   - Análise completa
   - Resumo executivo
   - Metadados
   - Confidence score
   - Timestamp

---

### 3.6. Preparar Dados para Salvar

**Tipo:** `n8n-nodes-base.code` (JavaScript)  
**Função:** Preparar dados para inserção no banco de dados.

**Tamanho:** 38 linhas de código

**O que faz:**
1. Recebe resposta estruturada do nó anterior
2. Formata dados para o schema da tabela `knowledge_base`
3. Serializa metadados em JSONB
4. Retorna objeto pronto para INSERT

---

### 3.7. Salvar Análise no PostgreSQL

**Tipo:** `n8n-nodes-base.postgres`  
**Função:** Salvar análise gerada na tabela `knowledge_base` do PostgreSQL.

**Query SQL:**
```sql
INSERT INTO knowledge_base (
  territory_id,
  dimension,
  content,
  summary,
  confidence_score,
  metadata,
  sources,
  created_at,
  updated_at
) VALUES (
  $1, $2, $3, $4, $5, $6, $7, NOW(), NOW()
);
```

**Tabela Acessada:** `knowledge_base`

**Tratamento de Erro:** `continueErrorOutput` (continua para nó de erro se falhar)

---

### 3.8. Preparar Resposta do Webhook

**Tipo:** `n8n-nodes-base.code` (JavaScript)  
**Função:** Preparar resposta final para o orquestrador.

**Tamanho:** 112 linhas de código

**O que faz:**
1. Recebe confirmação de salvamento no banco
2. Formata resposta final
3. Inclui análise completa + metadados
4. Retorna objeto JSON estruturado

---

### 3.9. Respond to Webhook

**Tipo:** `n8n-nodes-base.respondToWebhook`  
**Função:** Enviar resposta HTTP de sucesso ao orquestrador.

**Status Code:** 200 OK

**Body:** Análise completa + metadados

---

### 3.10. Responder Erro

**Tipo:** `n8n-nodes-base.respondToWebhook`  
**Função:** Enviar resposta HTTP de erro ao orquestrador.

**Status Code:** 500 Internal Server Error

**Body:** Mensagem de erro + detalhes

---

## 4. Interações com o Banco de Dados

### 4.1. Operações de Leitura

| Nó | Tabelas | Operação | Dados Retornados |
|----|---------|----------|------------------|
| **Consultar Dados PostgreSQL** | `territories`, `economic_indicators` | SELECT com LEFT JOIN | Dados econômicos de 2019-2023 |

### 4.2. Operações de Escrita

| Nó | Tabela | Operação | Dados Inseridos |
|----|--------|----------|-----------------|
| **Salvar Análise no PostgreSQL** | `knowledge_base` | INSERT | Análise completa + metadados |

### 4.3. Observação Crítica

⚠️ **GAP IDENTIFICADO:** O workflow salva a análise na tabela `knowledge_base` (Camada 3: Memória Organizacional), mas **não salva na tabela `agent_econ_memory`** (Camada 1: Memória Especializada).

**Impacto:**
- A análise não fica disponível na memória especializada do Agente ECON.
- Não há versionamento ou iteração da análise.
- Não há rastreamento de confidence_score evolutivo.
- O ciclo de aprendizagem não pode ser ativado.

**Recomendação:**
Adicionar um nó adicional para salvar também em `agent_econ_memory` após salvar em `knowledge_base`.

---

## 5. Alinhamento com o Modelo Conceitual RAG Evolutivo v3.0

### 5.1. Pontos de Alinhamento

✅ **Consulta de Dados Estruturados:** O workflow acessa a "Camada 0" (economic_indicators) corretamente.

✅ **Geração de Análise:** O workflow gera análises usando LLM, que é o núcleo da Camada 1 (Memória Especializada).

✅ **Armazenamento em Memória Organizacional:** O workflow salva em `knowledge_base` (Camada 3).

✅ **Tratamento de Erros:** O workflow possui tratamento robusto de erros em pontos críticos.

✅ **Metadados Estruturados:** O workflow captura metadados importantes (confidence_score, sources, timestamp).

### 5.2. Gaps Identificados

⚠️ **Não Salva em `agent_econ_memory`:** A análise não é armazenada na memória especializada do agente (Camada 1).

⚠️ **Não Gera Aprendizado:** Não há nenhum processo para extrair padrões e armazenar em `agent_econ_learning` (Camada 2).

⚠️ **Não Consulta Memória Prévia:** O workflow não busca análises anteriores na memória do agente para contexto.

⚠️ **Não Usa Embeddings:** Não há geração de embeddings para busca semântica.

⚠️ **Não Registra Auditoria:** Não há registro de eventos na tabela `audit_trail`.

⚠️ **Não Calcula Expertise:** Não há rastreamento do nível de expertise do agente.

### 5.3. Oportunidades de Evolução

🔗 **Integrar Camada 1:** Adicionar nó para salvar em `agent_econ_memory` com embeddings.

🔗 **Implementar Busca Semântica:** Antes de gerar análise, buscar análises similares na memória do agente.

🔗 **Ativar Ciclo de Aprendizagem:** Após N análises, extrair padrões e salvar em `agent_econ_learning`.

🔗 **Adicionar Auditoria:** Registrar todos os eventos significativos em `audit_trail`.

🔗 **Calcular Expertise:** Atualizar nível de expertise do agente após cada análise.

---

## 6. Comparação: Workflow Atual vs. Modelo Conceitual V3.0

| Aspecto | Workflow Atual | Modelo Conceitual V3.0 | Status |
|---------|----------------|------------------------|--------|
| **Consulta de Dados** | ✅ economic_indicators | ✅ Camada 0 | ✅ Alinhado |
| **Geração de Análise** | ✅ GPT-4o-mini | ✅ LLM | ✅ Alinhado |
| **Memória Especializada** | ❌ Não salva | ✅ agent_econ_memory | ⚠️ Gap |
| **Aprendizado Evolutivo** | ❌ Não implementado | ✅ agent_econ_learning | ⚠️ Gap |
| **Memória Organizacional** | ✅ knowledge_base | ✅ knowledge_base | ✅ Alinhado |
| **Busca Semântica** | ❌ Não implementado | ✅ Embeddings + pgvector | ⚠️ Gap |
| **Auditoria** | ❌ Não implementado | ✅ audit_trail | ⚠️ Gap |
| **Versionamento** | ❌ Não implementado | ✅ version, is_latest | ⚠️ Gap |
| **Expertise** | ❌ Não implementado | ✅ Níveis de expertise | ⚠️ Gap |

---

## 7. Recomendações de Evolução

### 7.1. Curto Prazo (Semana 3)

1.  **Adicionar Nó: Salvar em agent_econ_memory**
    - Após "Estruturar Resposta"
    - Gerar embedding sintético (temporário)
    - Inserir em `agent_econ_memory` com todos os campos obrigatórios

2.  **Adicionar Nó: Registrar Auditoria**
    - Após "Salvar Análise no PostgreSQL"
    - Inserir evento em `audit_trail` com metadados completos

### 7.2. Médio Prazo (Semana 4)

3.  **Adicionar Nó: Buscar Memória Prévia**
    - Antes de "Gerar Análise com OpenAI"
    - Buscar análises similares em `agent_econ_memory`
    - Incluir no contexto do LLM

4.  **Implementar Embeddings Semânticos**
    - Substituir embeddings sintéticos por embeddings reais
    - Usar modelo `text-embedding-3-small`

### 7.3. Longo Prazo (Semana 5-6)

5.  **Implementar Ciclo de Aprendizagem**
    - Criar workflow separado para análise periódica
    - Extrair padrões de `agent_econ_memory`
    - Armazenar em `agent_econ_learning`

6.  **Implementar Cálculo de Expertise**
    - Adicionar lógica para calcular nível de expertise
    - Atualizar após cada análise
    - Usar para adaptar comunicação

---

## 8. Conclusão

O Agente ECON V2 é um workflow **funcional e bem estruturado**, com tratamento robusto de erros e integração sólida com o banco de dados. No entanto, ele opera como um **gerador de análises isolado**, sem memória evolutiva ou aprendizado.

Para alinhar completamente com o Modelo Conceitual RAG Evolutivo v3.0, o workflow precisa:

1.  **Salvar análises na memória especializada** (`agent_econ_memory`)
2.  **Consultar memória prévia** antes de gerar novas análises
3.  **Extrair e armazenar aprendizados** (`agent_econ_learning`)
4.  **Registrar eventos de auditoria** (`audit_trail`)
5.  **Calcular e evoluir expertise** (níveis de expertise)

Com essas evoluções, o Agente ECON se transformará de um **gerador de análises** em um **especialista evolutivo**, capaz de aprender com suas experiências e aprimorar continuamente sua expertise.
