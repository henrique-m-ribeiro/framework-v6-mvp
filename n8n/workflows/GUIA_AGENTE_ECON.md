# Guia do Agente ECON - Especialista Econômico
**Framework de Inteligência Territorial V6.0**  
**Data:** 16 de novembro de 2025  
**Versão:** 1.0.0

---

## 📋 VISÃO GERAL

O **Agente ECON** é o especialista econômico do núcleo de especialistas do Framework V6.0. Ele analisa indicadores econômicos, identifica tendências, compara territórios e gera recomendações acionáveis para gestores públicos.

### Responsabilidades

- Analisar evolução econômica de territórios (PIB, emprego, renda)
- Avaliar sustentabilidade fiscal (receitas, despesas, endividamento)
- Identificar potenciais econômicos e gargalos
- Gerar insights baseados em dados para políticas de desenvolvimento

---

## 🏗️ ARQUITETURA DO WORKFLOW

```
┌─────────────────────────────────────────────────────────────┐
│                    FLUXO DO AGENTE ECON                      │
└─────────────────────────────────────────────────────────────┘

1. [Webhook] Recebe tarefa do Orquestrador
   ↓
2. [PostgreSQL] Consulta dados econômicos (2019-2023)
   ↓
3. [Code] Prepara contexto e calcula estatísticas
   ↓
4. [OpenAI] Gera análise econômica (GPT-4o-mini)
   ↓
5. [Code] Estrutura resposta com metadados
   ↓
6. [PostgreSQL] Salva análise na base de conhecimento
   ↓
7. [Respond] Retorna resposta ao Orquestrador

   [Erro?] → [Respond Erro] (se não houver dados)
```

---

## 📥 IMPORTAÇÃO NO N8N

### Passo 1: Importar Workflow

1. Acesse seu n8n Cloud: `https://galactic-ai.app.n8n.cloud`
2. Menu lateral → **"Workflows"**
3. Botão **"Add workflow"** → **"Import from File"**
4. Selecione o arquivo: `WF-AGENT-ECON-Especialista-Economico.json`
5. Clique em **"Import"**

### Passo 2: Configurar Credenciais

O workflow precisa de **2 credenciais**:

#### Credencial 1: PostgreSQL (Replit)

1. No workflow, clique no nó **"Consultar Dados PostgreSQL"**
2. Em "Credential to connect with", clique em **"Select Credential"**
3. Se já configurou antes, selecione **"PostgreSQL - Replit - Framework V6.0"**
4. Se não, clique em **"Create New"** e preencha:
   - Host: `<REPLIT_POSTGRES_HOST>`
   - Database: `<REPLIT_POSTGRES_DATABASE>`
   - User: `<REPLIT_POSTGRES_USER>`
   - Password: `<REPLIT_POSTGRES_PASSWORD>`
   - Port: `5432`
   - SSL: Enabled

#### Credencial 2: OpenAI API

1. No workflow, clique no nó **"Gerar Análise com OpenAI"**
2. Em "Credential to connect with", clique em **"Select Credential"**
3. Se já configurou antes, selecione **"OpenAI API - Framework V6.0"**
4. Se não, clique em **"Create New"** e preencha:
   - API Key: `<SUA_OPENAI_API_KEY>`

### Passo 3: Ativar Workflow

1. No canto superior direito, toggle **"Inactive"** → **"Active"**
2. Workflow agora está ativo e pronto para receber requisições!

---

## 🧪 TESTANDO O AGENTE ECON

### Teste 1: Análise Simples (Palmas)

**Requisição HTTP:**

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/agent-econ \
  -H "Content-Type: application/json" \
  -d '{
    "task_id": "test-001",
    "territory_id": 1,
    "territory_name": "Palmas",
    "dimension": "economic",
    "task_description": "Analisar evolução econômica de Palmas (2019-2023)",
    "context": {
      "user_question": "Como está a economia de Palmas?",
      "comparison_territories": [],
      "time_range": "2019-2023"
    }
  }'
```

**Resposta Esperada:**

```json
{
  "task_id": "test-001",
  "agent_name": "ECON",
  "status": "success",
  "analysis": {
    "text": "**RESUMO EXECUTIVO**\nPalmas apresentou crescimento econômico consistente...",
    "summary": "Palmas apresentou crescimento econômico consistente...",
    "territory": {
      "id": 1,
      "name": "Palmas"
    },
    "statistics": {
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
  },
  "metadata": {
    "processing_time_ms": 7500,
    "data_sources": ["IBGE", "SICONFI", "RAIS"],
    "time_range": "2019-2023",
    "years_analyzed": 5,
    "last_data_update": 2023,
    "model_used": "gpt-4o-mini",
    "confidence_score": 0.92,
    "generated_at": "2025-11-16T21:30:00.000Z"
  }
}
```

**Tempo esperado:** 6-8 segundos

---

### Teste 2: Território Inexistente (Erro)

**Requisição HTTP:**

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/agent-econ \
  -H "Content-Type: application/json" \
  -d '{
    "task_id": "test-002",
    "territory_id": 9999,
    "territory_name": "Território Inexistente",
    "dimension": "economic",
    "task_description": "Analisar economia",
    "context": {}
  }'
```

**Resposta Esperada:**

```json
{
  "error": true,
  "message": "Nenhum dado econômico encontrado para o território especificado.",
  "territory_id": 9999
}
```

**Status Code:** 404 Not Found

---

## 📊 DADOS CONSULTADOS

O Agente ECON consulta as seguintes tabelas no PostgreSQL:

### Tabela: `territories`
- `id`: ID do território
- `name`: Nome do território
- `state`: Estado (TO)
- `population`: População estimada
- `area_km2`: Área em km²

### Tabela: `economic_indicators`
- `year`: Ano (2019-2023)
- `gdp_total`: PIB total (R$)
- `gdp_per_capita`: PIB per capita (R$)
- `gdp_agriculture`: PIB agropecuária (R$)
- `gdp_industry`: PIB indústria (R$)
- `gdp_services`: PIB serviços (R$)
- `formal_jobs`: Empregos formais
- `average_salary`: Salário médio (R$)
- `unemployment_rate`: Taxa de desemprego (%)

### Tabela: `financial_indicators`
- `year`: Ano (2019-2023)
- `total_revenue`: Receita total (R$)
- `own_revenue`: Receita própria (R$)
- `fpm_transfers`: Transferências FPM (R$)
- `total_expenses`: Despesas totais (R$)
- `investment_expenses`: Despesas de investimento (R$)
- `debt_total`: Dívida total (R$)

---

## 🧮 ESTATÍSTICAS CALCULADAS

O agente calcula automaticamente as seguintes estatísticas:

1. **Crescimento do PIB (%)**: `(PIB_2023 - PIB_2019) / PIB_2019 × 100`
2. **Crescimento do PIB per capita (%)**: `(PIBpc_2023 - PIBpc_2019) / PIBpc_2019 × 100`
3. **Variação do desemprego (p.p.)**: `Desemprego_2023 - Desemprego_2019`
4. **Composição setorial (%)**: `Setor / PIB_total × 100`
5. **Dependência de transferências (%)**: `FPM / Receita_total × 100`
6. **Capacidade de investimento (%)**: `Investimentos / Despesas_totais × 100`

---

## 🤖 PROMPT DO LLM

O agente usa um prompt estruturado que inclui:

### Seção 1: Papel do Agente
```
Você é um economista especializado em desenvolvimento territorial, 
trabalhando como parte do Framework de Inteligência Territorial V6.0.
```

### Seção 2: Tarefa e Contexto
- Descrição da tarefa
- Pergunta do usuário
- Informações do território (nome, população, área)

### Seção 3: Dados Econômicos
- Dados formatados por ano (2019-2023)
- Estatísticas agregadas calculadas

### Seção 4: Instruções de Formato
```
Estruture sua análise em 5 seções:
1. RESUMO EXECUTIVO (2-3 frases)
2. PRINCIPAIS TENDÊNCIAS (3-4 pontos)
3. PONTOS FORTES (3-4 pontos)
4. DESAFIOS E VULNERABILIDADES (3-4 pontos)
5. RECOMENDAÇÕES PRIORITÁRIAS (3-4 ações)
```

### Seção 5: Tom Desejado
- Profissional mas acessível
- Baseado em evidências
- Acionável (foco em "o que fazer")
- Máximo 400 palavras

---

## 💾 SALVAMENTO NA BASE DE CONHECIMENTO

Após gerar a análise, o agente salva na tabela `knowledge_base`:

```sql
INSERT INTO knowledge_base (
  territory_id,
  dimension,
  analysis_type,
  content,
  summary,
  key_insights,
  metadata,
  created_at,
  updated_at
) VALUES (...)
ON CONFLICT (territory_id, dimension, analysis_type)
DO UPDATE SET ...
```

**Comportamento:**
- Se análise já existe para o território, **atualiza**
- Se não existe, **insere nova**
- Garante que sempre temos versão mais recente

**Benefícios:**
- **Cache:** Evita gerar mesma análise múltiplas vezes
- **RAG:** Análises anteriores servem de contexto
- **Auditoria:** Histórico de análises geradas
- **Performance:** Dashboard consulta rapidamente

---

## ⚙️ CONFIGURAÇÕES TÉCNICAS

### OpenAI GPT-4o-mini

- **Modelo:** `gpt-4o-mini`
- **Temperature:** `0.7` (equilíbrio criatividade/precisão)
- **Max Tokens:** `1500` (~1.125 palavras)
- **Custo:** ~$0,001 por análise

### Performance

- **Tempo médio:** 6-8 segundos
- **Breakdown:**
  - Consulta PostgreSQL: ~500ms
  - Preparar contexto: ~100ms
  - Gerar análise (LLM): ~5.000ms
  - Estruturar resposta: ~50ms
  - Salvar no banco: ~500ms

### Escalabilidade

- **Requisições simultâneas:** Ilimitado (n8n Cloud)
- **Rate limit OpenAI:** 3.500 requisições/minuto (tier padrão)
- **Custo mensal (100 análises/dia):** ~$3,00

---

## 🔍 MONITORAMENTO

### No n8n Cloud

1. Menu lateral → **"Executions"**
2. Filtrar por workflow: **"WF-AGENT-ECON"**
3. Ver detalhes de cada execução:
   - Tempo de processamento
   - Dados de entrada/saída
   - Erros (se houver)

### Métricas Importantes

- **Taxa de sucesso:** >95%
- **Tempo médio:** <10 segundos
- **Erros comuns:**
  - Territory_id não existe (404)
  - Dados incompletos (500)
  - Timeout OpenAI (503)

---

## 🐛 TROUBLESHOOTING

### Erro: "Nenhum dado econômico encontrado"

**Causa:** Territory_id não existe ou não tem dados no período 2019-2023

**Solução:**
1. Verificar se território existe: `SELECT * FROM territories WHERE id = X;`
2. Verificar se há indicadores: `SELECT * FROM economic_indicators WHERE territory_id = X;`
3. Executar Data Collector para popular dados

---

### Erro: "OpenAI API Error"

**Causa:** Problema com credencial OpenAI ou rate limit

**Solução:**
1. Verificar API Key em Credentials
2. Verificar saldo da conta OpenAI
3. Verificar rate limits: https://platform.openai.com/account/limits

---

### Erro: "PostgreSQL Connection Failed"

**Causa:** Credencial PostgreSQL incorreta ou banco offline

**Solução:**
1. Verificar credencial em Credentials
2. Testar conexão no Replit
3. Verificar se Replit está ativo (não hibernando)

---

## 🚀 PRÓXIMOS PASSOS

Após testar o Agente ECON com sucesso:

1. **Criar Agente SOCIAL** (análise social)
2. **Criar Agente TERRA** (análise territorial)
3. **Criar Agente AMBIENT** (análise ambiental)
4. **Criar Orquestrador** (Meta-LLM que coordena todos)
5. **Integrar com Dashboard** (requisições do frontend)

---

## 📚 REFERÊNCIAS

- **Documentação n8n:** https://docs.n8n.io/
- **OpenAI API:** https://platform.openai.com/docs/
- **PostgreSQL:** https://www.postgresql.org/docs/
- **Arquitetura do Núcleo:** `/docs/n8n/ARQUITETURA_NUCLEO_ESPECIALISTAS.md`

---

**Autor:** Manus AI  
**Data:** 16 de novembro de 2025  
**Versão:** 1.0.0
