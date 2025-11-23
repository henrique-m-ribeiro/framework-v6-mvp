# Guia Completo: Configuração do n8n Cloud - Fase 7
**Framework de Inteligência Territorial V6.0**  
**Data:** 10 de novembro de 2025  
**Autor:** Manus AI  
**Versão:** 1.0.0

---

## 🎯 OBJETIVO DA FASE 7

Configurar o n8n Cloud e estabelecer a arquitetura do sistema multi-agentes que será o **diferencial inovador** do Framework V6.0.

**Visão Estratégica:**
- **Dashboard Web (Replit):** Interface para gestores públicos + IA embarcada para navegação
- **Sistema Multi-Agentes (n8n):** Time de especialistas IA para geração de conhecimento + monitoramento contínuo

---

## 📋 ÍNDICE

1. [Visão Geral da Arquitetura](#visão-geral-da-arquitetura)
2. [Configuração Inicial do n8n Cloud](#configuração-inicial-do-n8n-cloud)
3. [Arquitetura do Sistema Multi-Agentes](#arquitetura-do-sistema-multi-agentes)
4. [Roadmap de Implementação (Fases 7-11)](#roadmap-de-implementação)
5. [Próximos Passos](#próximos-passos)

---

## 1. VISÃO GERAL DA ARQUITETURA

### Arquitetura em Duas Camadas

```
┌─────────────────────────────────────────────────────────────┐
│                    CAMADA 1: DASHBOARD WEB                   │
│                         (Replit)                             │
├─────────────────────────────────────────────────────────────┤
│  • Interface intuitiva para gestores públicos                │
│  • IA embarcada (Chat) para navegação e exploração          │
│  • Consulta rápida de análises já realizadas                 │
│  • Visualizações interativas (gráficos, mapas)               │
│  • Exportação de relatórios (PDF, CSV)                       │
└──────────────────────┬──────────────────────────────────────┘
                       │ APIs REST
                       │ (Consulta + Inserção)
                       ↓
┌─────────────────────────────────────────────────────────────┐
│              CAMADA 2: SISTEMA MULTI-AGENTES                 │
│                      (n8n Cloud)                             │
├─────────────────────────────────────────────────────────────┤
│  • Time de especialistas IA (6 agentes)                      │
│  • Gera bases de dados e conhecimento                        │
│  • Monitora redes sociais, academia, documentos oficiais     │
│  • Análises avançadas e preditivas                           │
│  • **DIFERENCIAL INOVADOR** do sistema                       │
└──────────────────────┬──────────────────────────────────────┘
                       │ SQL + HTTP
                       │ (Inserção de dados)
                       ↓
┌─────────────────────────────────────────────────────────────┐
│                 BANCO DE DADOS CENTRAL                       │
│                    (PostgreSQL - Replit)                     │
├─────────────────────────────────────────────────────────────┤
│  • 40 tabelas (territories, indicators, knowledge_base)      │
│  • Dados de 140 territórios (Tocantins)                      │
│  • 5 anos de histórico (2019-2023)                           │
│  • Embeddings vetoriais (pgvector)                           │
│  • Coordenadas geoespaciais (PostGIS)                        │
└─────────────────────────────────────────────────────────────┘
```

### Fluxo de Dados

**Cenário 1: Usuário consulta análise existente**
1. Gestor acessa dashboard → Seleciona "Palmas" + "Dimensão Econômica"
2. Dashboard consulta PostgreSQL → Retorna análise já realizada
3. Chat IA embarcado permite exploração interativa
4. **Tempo de resposta:** <2 segundos ⚡

**Cenário 2: Usuário solicita análise inédita**
1. Gestor pergunta: "Como Palmas se compara com Araguaína em infraestrutura?"
2. Dashboard verifica PostgreSQL → Análise não existe
3. Dashboard aciona n8n (webhook) → Sistema multi-agentes é ativado
4. Orquestrador distribui tarefa → Agentes TERRA + ECON coletam dados
5. Agentes geram análise → Inserem no PostgreSQL
6. Dashboard retorna análise ao usuário
7. **Tempo de resposta:** 30-60 segundos (primeira vez), <2s (próximas vezes) 🚀

**Cenário 3: Monitoramento contínuo (futuro - v2.0)**
1. Agente RESEARCH monitora notícias, redes sociais, academia
2. Detecta evento relevante (ex: "Nova lei de incentivo fiscal aprovada")
3. Aciona Orquestrador → Agente ECON analisa impacto
4. Gera análise preditiva → Insere no PostgreSQL
5. Dashboard notifica gestores sobre nova análise disponível
6. **Proatividade:** Sistema antecipa necessidades 🧠

---

## 2. CONFIGURAÇÃO INICIAL DO N8N CLOUD

### 2.1 Criar Conta no n8n Cloud

#### Passo 1: Acessar n8n Cloud
- URL: https://n8n.cloud
- Clique em "Start for free" ou "Sign up"

#### Passo 2: Escolher Plano
**Planos disponíveis:**
- **Starter (Gratuito):** 5.000 execuções/mês, workflows ilimitados
- **Pro ($20/mês):** 10.000 execuções/mês, prioridade de suporte
- **Enterprise (Custom):** Execuções ilimitadas, SLA, suporte dedicado

**Recomendação para MVP:**
- Começar com **Starter (Gratuito)** para testes iniciais
- Migrar para **Pro ($20/mês)** após validação

**Estimativa de execuções (MVP):**
- Data Collector: 4 execuções/dia × 30 dias = 120 execuções/mês
- Análises inéditas: ~50 execuções/mês (estimativa conservadora)
- **Total:** ~170 execuções/mês (bem dentro do plano gratuito) ✅

#### Passo 3: Criar Conta
- Preencher email, senha
- Verificar email
- Fazer login

#### Passo 4: Criar Workspace
- Nome: "Framework V6.0 - Tocantins"
- Região: "US East" (melhor latência para Brasil)

---

### 2.2 Configurar Credenciais

O n8n precisa de credenciais para acessar serviços externos (OpenAI, PostgreSQL, APIs governamentais).

#### Credencial 1: OpenAI API

**Passo 1:** No n8n, clicar em "Credentials" (menu lateral)  
**Passo 2:** Clicar em "Add Credential"  
**Passo 3:** Buscar "OpenAI"  
**Passo 4:** Preencher:
- **API Key:** `<SUA_CHAVE_OPENAI>`
- **Organization ID:** (opcional, deixar vazio)

**Passo 5:** Clicar em "Save"  
**Passo 6:** Nomear: "OpenAI - Framework V6.0"

---

#### Credencial 2: PostgreSQL (Replit)

**Passo 1:** No n8n, clicar em "Credentials"  
**Passo 2:** Clicar em "Add Credential"  
**Passo 3:** Buscar "Postgres"  
**Passo 4:** Preencher com dados do Replit:

```
Host: <REPLIT_POSTGRES_HOST>
Database: <REPLIT_POSTGRES_DATABASE>
User: <REPLIT_POSTGRES_USER>
Password: <REPLIT_POSTGRES_PASSWORD>
Port: 5432
SSL: Enabled
```

**Onde encontrar esses dados no Replit:**
1. Abrir projeto Replit
2. Painel lateral → Tools → PostgreSQL
3. Copiar "Connection String"
4. Formato: `postgresql://user:password@host:port/database`
5. Extrair cada parte

**Passo 5:** Clicar em "Test Connection" → Deve retornar "Success" ✅  
**Passo 6:** Clicar em "Save"  
**Passo 7:** Nomear: "PostgreSQL - Replit - Framework V6.0"

---

#### Credencial 3: HTTP Request (APIs Governamentais)

Para acessar APIs públicas (IBGE, INPE, etc.), não precisamos de credenciais específicas, mas vamos configurar headers padrão.

**Passo 1:** No n8n, clicar em "Credentials"  
**Passo 2:** Clicar em "Add Credential"  
**Passo 3:** Buscar "HTTP Request"  
**Passo 4:** Preencher:
- **Authentication:** None
- **Custom Headers:**
  ```json
  {
    "User-Agent": "Framework-V6-Tocantins/1.0",
    "Accept": "application/json"
  }
  ```

**Passo 5:** Clicar em "Save"  
**Passo 6:** Nomear: "HTTP - APIs Governamentais"

---

### 2.3 Testar Configuração

#### Teste 1: OpenAI

**Criar workflow de teste:**
1. Novo workflow → Nomear "Teste OpenAI"
2. Adicionar nó "Manual Trigger"
3. Adicionar nó "OpenAI"
4. Configurar:
   - **Operation:** "Message a Model"
   - **Model:** "gpt-4o-mini"
   - **Prompt:** "Diga olá em português"
5. Conectar nós
6. Clicar em "Execute Workflow"
7. Verificar resposta: "Olá!" ✅

#### Teste 2: PostgreSQL

**Criar workflow de teste:**
1. Novo workflow → Nomear "Teste PostgreSQL"
2. Adicionar nó "Manual Trigger"
3. Adicionar nó "Postgres"
4. Configurar:
   - **Operation:** "Execute Query"
   - **Query:** `SELECT COUNT(*) FROM territories;`
5. Conectar nós
6. Clicar em "Execute Workflow"
7. Verificar resposta: `{"count": 21}` ✅

---

## 3. ARQUITETURA DO SISTEMA MULTI-AGENTES

### 3.1 Visão Geral dos Agentes

O sistema multi-agentes do Framework V6.0 é composto por **6 agentes especializados**:

```
┌─────────────────────────────────────────────────────────────┐
│                    ORQUESTRADOR (Meta-LLM)                   │
│                        (Maestro)                             │
├─────────────────────────────────────────────────────────────┤
│  • Recebe requisições do dashboard                           │
│  • Identifica dimensões relevantes                           │
│  • Distribui tarefas para agentes especializados             │
│  • Consolida respostas                                       │
│  • Retorna análise integrada                                 │
└──────────────────┬──────────────────────────────────────────┘
                   │
         ┌─────────┼─────────┬─────────┬─────────┐
         ↓         ↓         ↓         ↓         ↓
    ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐
    │  DATA  │ │  ECON  │ │ SOCIAL │ │ TERRA  │ │AMBIENT │
    │COLLECT │ │        │ │        │ │        │ │        │
    └────────┘ └────────┘ └────────┘ └────────┘ └────────┘
    │          │          │          │          │
    │ Coleta   │ Análise  │ Análise  │ Análise  │ Análise
    │ dados    │ econômica│ social   │ territor.│ ambient.
    │ oficiais │          │          │          │
    └──────────┴──────────┴──────────┴──────────┴──────────┘
```

### 3.2 Detalhamento dos Agentes

#### Agente 1: ORQUESTRADOR (Meta-LLM)
**Função:** Maestro do sistema multi-agentes

**Responsabilidades:**
- Receber requisições do dashboard via webhook
- Analisar pergunta do usuário e identificar dimensões relevantes
- Distribuir tarefas para agentes especializados (paralelamente quando possível)
- Consolidar respostas dos agentes
- Gerar análise integrada e coerente
- Inserir resultado no PostgreSQL
- Retornar resposta ao dashboard

**Tecnologias:**
- GPT-4o (para raciocínio complexo e orquestração)
- n8n Webhook (para receber requisições)
- n8n HTTP Request (para chamar outros workflows)
- n8n PostgreSQL (para inserir resultados)

**Exemplo de Prompt:**
```
Você é o Orquestrador do Framework de Inteligência Territorial V6.0.

REQUISIÇÃO DO USUÁRIO:
"Como Palmas se compara com Araguaína em infraestrutura e economia?"

ANÁLISE:
1. Identificar dimensões relevantes: TERRA (infraestrutura) + ECON (economia)
2. Distribuir tarefas:
   - Agente TERRA: Analisar infraestrutura de Palmas e Araguaína
   - Agente ECON: Analisar economia de Palmas e Araguaína
3. Consolidar respostas dos agentes
4. Gerar análise integrada comparativa

FORMATO DE SAÍDA:
{
  "agents_to_call": ["TERRA", "ECON"],
  "tasks": {
    "TERRA": "Analisar e comparar infraestrutura de Palmas e Araguaína",
    "ECON": "Analisar e comparar economia de Palmas e Araguaína"
  }
}
```

**Workflow (simplificado):**
1. Webhook recebe requisição
2. OpenAI analisa pergunta → Identifica agentes necessários
3. Loop: Para cada agente identificado
   - HTTP Request chama workflow do agente
   - Aguarda resposta
4. OpenAI consolida respostas → Gera análise integrada
5. PostgreSQL insere análise na tabela `knowledge_base`
6. Webhook responde ao dashboard

---

#### Agente 2: DATA COLLECTOR (Coletor de Dados)
**Função:** Coletor e estruturador de dados para memória do sistema

**Responsabilidades:**
- Coletar dados de APIs oficiais (IBGE, INPE, ANA, etc.)
- Estruturar dados no formato do PostgreSQL
- Inserir dados nas tabelas `economic_indicators`, `social_indicators`, etc.
- Gerar embeddings de análises realizadas
- Inserir embeddings na tabela `knowledge_base` (para RAG)
- Executar periodicamente (ex: diariamente)

**Tecnologias:**
- n8n HTTP Request (para chamar APIs)
- n8n Code (para processar dados)
- n8n PostgreSQL (para inserir dados)
- OpenAI Embeddings (para gerar vetores)

**APIs Utilizadas (MVP):**
1. **IBGE - Cidades:** https://servicodados.ibge.gov.br/api/v1/localidades/estados/TO/municipios
2. **IBGE - PIB Municipal:** https://servicodados.ibge.gov.br/api/v3/agregados/5938/periodos/2019|2020|2021|2022|2023/variaveis/37?localidades=N6[TO]
3. **IBGE - População:** https://servicodados.ibge.gov.br/api/v3/agregados/6579/periodos/2019|2020|2021|2022|2023/variaveis/93?localidades=N6[TO]
4. **IBGE - IDH-M:** (via download de planilha, não tem API em tempo real)

**Workflow (simplificado):**
1. Schedule Trigger (diariamente às 2h da manhã)
2. HTTP Request → IBGE API (PIB)
3. Code → Processar JSON → Extrair dados
4. PostgreSQL → Inserir em `economic_indicators`
5. HTTP Request → IBGE API (População)
6. Code → Processar JSON
7. PostgreSQL → Inserir em `social_indicators`
8. (Repetir para outras APIs)
9. OpenAI → Gerar embeddings de análises
10. PostgreSQL → Inserir em `knowledge_base`

---

#### Agente 3: ECON (Análise Econômica)
**Função:** Especialista em análise econômica territorial

**Responsabilidades:**
- Analisar indicadores econômicos (PIB, emprego, renda, setores)
- Identificar tendências e padrões
- Comparar territórios
- Gerar insights acionáveis para gestores públicos

**Tecnologias:**
- GPT-4o-mini (análise econômica)
- n8n PostgreSQL (consultar dados)
- n8n Code (cálculos estatísticos)

**Exemplo de Prompt:**
```
Você é um economista especializado em desenvolvimento territorial.

DADOS ECONÔMICOS DE PALMAS (2019-2023):
- PIB: R$ 12,5 bi (2019) → R$ 14,2 bi (2023) [+13,6%]
- PIB per capita: R$ 42.300 (2019) → R$ 45.800 (2023) [+8,3%]
- Taxa de desemprego: 8,2% (2019) → 6,5% (2023) [-1,7 p.p.]
- Principais setores: Serviços (68%), Indústria (22%), Agropecuária (10%)

TAREFA:
Analise a evolução econômica de Palmas nos últimos 5 anos e identifique:
1. Principais tendências
2. Pontos fortes
3. Desafios
4. Recomendações para gestores públicos

FORMATO DE SAÍDA:
Texto corrido, máximo 300 palavras, linguagem acessível para gestores públicos.
```

**Workflow (simplificado):**
1. Webhook recebe tarefa do Orquestrador
2. PostgreSQL → Consultar dados econômicos do território
3. Code → Calcular estatísticas (variação %, médias, etc.)
4. OpenAI → Gerar análise econômica
5. Webhook → Retornar análise ao Orquestrador

---

#### Agente 4: SOCIAL (Análise Social)
**Função:** Especialista em análise social territorial

**Responsabilidades:**
- Analisar indicadores sociais (IDH-M, educação, saúde, segurança)
- Identificar vulnerabilidades e oportunidades
- Comparar territórios
- Gerar insights para políticas públicas

**Tecnologias:**
- GPT-4o-mini (análise social)
- n8n PostgreSQL (consultar dados)
- n8n Code (cálculos estatísticos)

**Exemplo de Prompt:**
```
Você é um sociólogo especializado em políticas públicas.

DADOS SOCIAIS DE PALMAS (2019-2023):
- IDH-M: 0,788 (2019) → 0,795 (2023) [+0,007]
- Taxa de alfabetização: 94,1% (2019) → 95,3% (2023) [+1,2 p.p.]
- Mortalidade infantil: 12,4/1000 (2019) → 10,8/1000 (2023) [-12,9%]
- Cobertura de saneamento: 82% (2019) → 87% (2023) [+5 p.p.]

TAREFA:
Analise a evolução social de Palmas e identifique:
1. Avanços principais
2. Desafios persistentes
3. Grupos vulneráveis
4. Recomendações prioritárias

FORMATO DE SAÍDA:
Texto corrido, máximo 300 palavras, linguagem acessível.
```

**Workflow:** Similar ao Agente ECON, mas focado em dados sociais.

---

#### Agente 5: TERRA (Análise Territorial)
**Função:** Especialista em análise territorial e infraestrutura

**Responsabilidades:**
- Analisar indicadores territoriais (área, densidade, urbanização, infraestrutura)
- Identificar padrões espaciais
- Comparar territórios geograficamente próximos
- Gerar insights para planejamento urbano

**Tecnologias:**
- GPT-4o-mini (análise territorial)
- n8n PostgreSQL (consultar dados + PostGIS)
- n8n Code (cálculos geoespaciais)

**Exemplo de Prompt:**
```
Você é um geógrafo especializado em planejamento territorial.

DADOS TERRITORIAIS DE PALMAS:
- Área total: 2.218,9 km²
- Área urbanizada: 187,3 km² (8,4% do total)
- Densidade demográfica: 139,4 hab/km²
- Cobertura de saneamento: 87%
- Territórios próximos (raio 100 km): Miracema (32 km), Porto Nacional (43 km)

TAREFA:
Analise as características territoriais de Palmas e identifique:
1. Padrões de ocupação
2. Desafios de infraestrutura
3. Oportunidades de expansão
4. Recomendações para planejamento urbano

FORMATO DE SAÍDA:
Texto corrido, máximo 300 palavras.
```

**Workflow:** Similar aos anteriores, mas com consultas PostGIS para análises geoespaciais.

---

#### Agente 6: AMBIENT (Análise Ambiental)
**Função:** Especialista em análise ambiental territorial

**Responsabilidades:**
- Analisar indicadores ambientais (desmatamento, qualidade do ar/água, áreas protegidas)
- Identificar riscos ambientais
- Comparar territórios
- Gerar insights para políticas ambientais

**Tecnologias:**
- GPT-4o-mini (análise ambiental)
- n8n PostgreSQL (consultar dados)
- n8n Code (cálculos estatísticos)

**Exemplo de Prompt:**
```
Você é um ambientalista especializado em gestão territorial.

DADOS AMBIENTAIS DE PALMAS (2019-2023):
- Desmatamento: 2,3% da área total (2019) → 2,8% (2023) [+0,5 p.p.] ⚠️
- Qualidade do ar: Boa (IQA médio: 45)
- Cobertura vegetal: 89,2% (2019) → 88,1% (2023) [-1,1 p.p.]
- Áreas protegidas: 12% do território

TAREFA:
Analise a situação ambiental de Palmas e identifique:
1. Principais riscos
2. Áreas de atenção
3. Oportunidades de conservação
4. Recomendações urgentes

FORMATO DE SAÍDA:
Texto corrido, máximo 300 palavras.
```

**Workflow:** Similar aos anteriores, mas focado em dados ambientais.

---

### 3.3 Comunicação entre Agentes

**Protocolo de Comunicação:**
- **Orquestrador → Agentes:** HTTP Request (POST) para webhook de cada agente
- **Agentes → Orquestrador:** Resposta HTTP (JSON) com análise gerada
- **Todos → PostgreSQL:** Inserção de dados e análises

**Formato de Mensagem (Orquestrador → Agente):**
```json
{
  "task_id": "uuid-v4",
  "territory_id": "palmas-to-123",
  "territory_name": "Palmas",
  "dimension": "economic",
  "task_description": "Analisar evolução econômica de Palmas (2019-2023)",
  "context": {
    "user_question": "Como está a economia de Palmas?",
    "comparison_territories": [],
    "time_range": "2019-2023"
  }
}
```

**Formato de Resposta (Agente → Orquestrador):**
```json
{
  "task_id": "uuid-v4",
  "agent_name": "ECON",
  "status": "success",
  "analysis": "Palmas apresentou crescimento econômico consistente nos últimos 5 anos, com PIB aumentando 13,6%...",
  "key_insights": [
    "Crescimento do PIB acima da média nacional",
    "Setor de serviços lidera a economia (68%)",
    "Taxa de desemprego em queda"
  ],
  "data_sources": ["IBGE PIB Municipal 2023", "IBGE PNAD 2023"],
  "confidence": 0.92
}
```

---

## 4. ROADMAP DE IMPLEMENTAÇÃO (FASES 7-11)

### Fase 7: Configuração do n8n Cloud ✅ (VOCÊ ESTÁ AQUI)
**Tempo:** 30-45 minutos  
**Objetivo:** Preparar ambiente n8n

**Tarefas:**
- [x] Criar conta n8n Cloud
- [x] Configurar credenciais (OpenAI, PostgreSQL, HTTP)
- [x] Testar configuração
- [ ] Entender arquitetura multi-agentes

**Entregável:** n8n Cloud configurado e pronto para desenvolvimento

---

### Fase 8: Implementação do Orquestrador
**Tempo:** 2-3 horas (1-2 sessões)  
**Objetivo:** Criar o "maestro" do sistema

**Tarefas:**
1. Criar workflow "Orquestrador"
2. Implementar webhook de entrada
3. Implementar análise de requisição (GPT-4o)
4. Implementar distribuição de tarefas
5. Implementar consolidação de respostas
6. Implementar inserção no PostgreSQL
7. Testar com requisição simulada

**Entregável:** Orquestrador funcional capaz de distribuir tarefas

---

### Fase 9: Implementação do Data Collector
**Tempo:** 2-3 horas (1-2 sessões)  
**Objetivo:** Automatizar coleta de dados oficiais

**Tarefas:**
1. Criar workflow "Data Collector"
2. Implementar chamadas para APIs do IBGE (PIB, População, etc.)
3. Implementar processamento de dados
4. Implementar inserção no PostgreSQL
5. Implementar geração de embeddings
6. Configurar execução periódica (schedule)
7. Testar coleta completa

**Entregável:** Data Collector coletando dados diariamente

---

### Fase 10: Implementação dos Agentes Dimensionais
**Tempo:** 4-6 horas (3-4 sessões)  
**Objetivo:** Criar os 4 especialistas (ECON, SOCIAL, TERRA, AMBIENT)

**Tarefas (para cada agente):**
1. Criar workflow "Agente [NOME]"
2. Implementar webhook de entrada
3. Implementar consulta ao PostgreSQL
4. Implementar cálculos estatísticos
5. Implementar geração de análise (GPT-4o-mini)
6. Implementar resposta ao Orquestrador
7. Testar com tarefa simulada

**Entregável:** 4 agentes dimensionais funcionais

---

### Fase 11: Integração n8n ↔ Replit
**Tempo:** 2-3 horas (1-2 sessões)  
**Objetivo:** Conectar dashboard ao sistema multi-agentes

**Tarefas:**
1. Criar endpoint no Replit para acionar n8n
2. Implementar lógica de verificação (análise existe?)
3. Implementar chamada ao webhook do Orquestrador
4. Implementar polling ou callback para aguardar resposta
5. Atualizar chat IA para usar novo fluxo
6. Testar integração completa (ponta a ponta)

**Entregável:** Sistema integrado funcionando ponta a ponta

---

## 5. PRÓXIMOS PASSOS

### Ação Imediata (Agora)

**Você precisa:**
1. ✅ Criar conta no n8n Cloud (https://n8n.cloud)
2. ✅ Configurar credenciais (OpenAI + PostgreSQL)
3. ✅ Testar configuração (workflows de teste)

**Tempo estimado:** 30-45 minutos

---

### Próxima Sessão (Fase 8)

**Implementar o Orquestrador**
- Criar primeiro workflow real
- Aprender interface drag-and-drop do n8n
- Ver sistema multi-agentes começar a tomar forma

**Tempo estimado:** 2-3 horas (1-2 sessões)

---

## 📊 PROGRESSO GERAL

**Fases Concluídas:**
- ✅ Fase 1-6: Dashboard completo (Replit)
- 🔄 **Fase 7: Configuração n8n (em andamento - VOCÊ ESTÁ AQUI)**

**Fases Restantes:**
- ⏳ Fase 8: Orquestrador
- ⏳ Fase 9: Data Collector
- ⏳ Fase 10: Agentes Dimensionais
- ⏳ Fase 11: Integração

**Progresso:** 60% → 65% (após Fase 7)

---

## 💰 CUSTOS

### n8n Cloud
- **Starter (Gratuito):** 5.000 execuções/mês → Suficiente para MVP ✅
- **Pro ($20/mês):** 10.000 execuções/mês → Para produção

### OpenAI API (via n8n)
- **GPT-4o-mini:** $0.15/1M tokens input, $0.60/1M tokens output
- **Estimativa:** ~500 análises/mês × $0.02/análise = **$10/mês**

### Total Mensal (MVP)
- n8n: $0 (gratuito)
- OpenAI: $10
- **Total: $10/mês** 💰

---

## 🎯 CRITÉRIOS DE SUCESSO (FASE 7)

- [ ] Conta n8n Cloud criada e ativa
- [ ] Credencial OpenAI configurada e testada
- [ ] Credencial PostgreSQL configurada e testada
- [ ] Workflow de teste OpenAI executado com sucesso
- [ ] Workflow de teste PostgreSQL executado com sucesso
- [ ] Arquitetura multi-agentes compreendida
- [ ] Pronto para Fase 8 (Orquestrador)

---

## 📚 RECURSOS

### Documentação Oficial
- **n8n Docs:** https://docs.n8n.io
- **n8n Community:** https://community.n8n.io
- **OpenAI API:** https://platform.openai.com/docs

### Tutoriais Recomendados
- **n8n Quickstart:** https://docs.n8n.io/getting-started/quickstart/
- **n8n Workflows:** https://docs.n8n.io/workflows/
- **n8n Credentials:** https://docs.n8n.io/credentials/

---

## ✅ CHECKLIST DE CONFIGURAÇÃO

### Antes de Começar
- [ ] Conta n8n Cloud criada
- [ ] Chave OpenAI disponível
- [ ] Connection string PostgreSQL (Replit) disponível

### Durante Configuração
- [ ] Workspace "Framework V6.0" criado
- [ ] Credencial OpenAI adicionada
- [ ] Credencial PostgreSQL adicionada
- [ ] Credencial HTTP adicionada

### Testes
- [ ] Teste OpenAI: Resposta "Olá!" recebida
- [ ] Teste PostgreSQL: Contagem de territórios retornada
- [ ] Ambos os testes executados sem erros

### Finalização
- [ ] Todos os workflows de teste salvos
- [ ] Credenciais nomeadas corretamente
- [ ] Pronto para Fase 8

---

**Está pronto para começar a Fase 7?** 🚀

Quando terminar a configuração, me avise e avançamos para a Fase 8 (Orquestrador)!
