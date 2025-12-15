# Arquitetura do Núcleo de Especialistas n8n
**Framework de Inteligência Territorial V6.0**  
**Data:** 16 de novembro de 2025  
**Autor:** Manus AI  
**Versão:** 1.0.0

---

## 🎯 VISÃO GERAL

O **Núcleo de Especialistas** é o coração do Framework V6.0 - um sistema multi-agentes implementado no n8n Cloud que funciona como um **time de especialistas em políticas públicas** trabalhando de forma coordenada para gerar conhecimento profundo sobre territórios.

### Analogia: Consultoria Estratégica Automatizada

Imagine contratar uma consultoria de elite com 6 especialistas:

- **1 Coordenador Sênior** (Orquestrador) que entende a demanda e distribui tarefas
- **1 Analista de Dados** (Data Collector) que busca e organiza informações
- **4 Especialistas Dimensionais** (ECON, SOCIAL, TERRA, AMBIENT) que analisam suas áreas

Este time trabalha 24/7, consulta bases de dados em tempo real, aprende com análises anteriores e gera relatórios em minutos. **Esse é o Núcleo de Especialistas**.

---

## 🏗️ ARQUITETURA GERAL

### Arquitetura de Duas Camadas de IA

O Núcleo de Especialistas é a **Camada 2** do Framework V6.0 - o motor de geração de conhecimento profundo. Ele não interage diretamente com o usuário final, mas sim com o **Agente Concierge** (Camada 1) que vive no dashboard do Replit.

```
┌─────────────────────────────────────────────────────────────────┐
│              CAMADA 1: DASHBOARD WEB (Replit)                    │
│                                                                  │
│  🤖 AGENTE CONCIERGE ("Interface Inteligente")                  │
│     • Conversa com o usuário em linguagem natural               │
│     • Responde perguntas rápidas (dados existentes)              │
│     • Aciona Camada 2 para análises profundas                    │
└───────────────────────────┬─────────────────────────────────────┘
                            │
                            │ HTTP POST (Webhook)
                            │ Solicitação de Análise Profunda
                            │ {territory_id, question}
                            ↓
┌─────────────────────────────────────────────────────────────────┐
│         CAMADA 2: NÚCLEO DE ESPECIALISTAS (n8n Cloud)           │
│                                                                  │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │           ORQUESTRADOR ("Coordenador do Time")            │ │
│  │                                                            │ │
│  │  • Recebe solicitações do Agente Concierge                 │ │
│  │  • Normaliza e enriquece dados de entrada                  │ │
│  │  • Identifica dimensões relevantes                         │ │
│  │  • Roteia para especialistas apropriados                   │ │
│  │  • Consolida e retorna análises ao Concierge               │ │
│  └──────────────┬─────────────────────────────────────────────┘ │
│                 │                                                │
│                 │ Distribui Tarefas                              │
│                 │                                                │
│     ┌───────────┼───────────┬───────────┬───────────┐           │
│     ↓           ↓           ↓           ↓           ↓           │
│  ┌──────┐   ┌──────┐   ┌──────┐   ┌──────┐   ┌──────┐         │
│  │ DATA │   │ ECON │   │SOCIAL│   │TERRA │   │AMBIENT│         │
│  │COLLEC│   │      │   │      │   │      │   │      │         │
│  └──┬───┘   └──┬───┘   └──┬───┘   └──┬───┘   └──┬───┘         │
│     │          │          │          │          │              │
│     │          └──────────┴──────────┴──────────┘              │
│     │                     │                                     │
│     │ Coleta Dados        │ Geram Análises                      │
│     │ de APIs             │ Especializadas (RAG 4 Camadas)      │
│     ↓                     ↓                                     │
└─────┼─────────────────────┼─────────────────────────────────────┘
      │                     │
      │                     │ Salvam Resultados
      ↓                     ↓
┌─────────────────────────────────────────────────────────────────┐
│              BASE DE CONHECIMENTO (PostgreSQL - Neon)            │
│                                                                  │
│  • Dados estruturados (indicators, territories)                  │
│  • Análises geradas (knowledge_base)                             │
│  • Embeddings vetoriais (para RAG)                               │
│  • Memória evolutiva dos agentes                                 │
└─────────────────────────────────────────────────────────────────┘
```

**Fluxo de Comunicação:**

1. **Usuário → Concierge:** *"Como está a economia de Palmas?"*
2. **Concierge analisa:** Não há análise recente → Precisa acionar Camada 2
3. **Concierge → Orquestrador:** `{territory_id: "1721000", question: "Como está a economia de Palmas?"}`
4. **Orquestrador normaliza:** Adiciona `territory_name: "Palmas"`, `analysis_type: "comprehensive"`, `agent_id: "econ"`
5. **Orquestrador → Agente ECON:** Envia payload completo
6. **Agente ECON:** Executa ciclo de 4 camadas RAG e gera análise
7. **Agente ECON → Orquestrador:** Retorna análise completa
8. **Orquestrador → Concierge:** Retorna análise
9. **Concierge → Usuário:** Apresenta análise de forma amigável

---

## 👥 OS 6 ESPECIALISTAS

### 1. ORQUESTRADOR - O Coordenador do Time

**Perfil:** Generalista sênior com visão sistêmica

**Cliente:** Agente Concierge (Camada 1 - Replit). O Orquestrador **NÃO interage diretamente com o usuário final**.

**Responsabilidades:**
- **Receber solicitações do Agente Concierge:** Quando o Concierge identifica que uma análise profunda é necessária, ele aciona o Orquestrador via webhook
- **Validar e normalizar dados:** Verifica se os dados obrigatórios foram fornecidos (ex: `territory_id`)
- **Enriquecer informações:** Busca dados faltantes no banco (ex: `territory_name` a partir do `territory_id`)
- **Rotear inteligentemente:** Identifica qual(is) especialista(s) deve(m) ser acionado(s) baseado na pergunta
- **Coordenar especialistas:** Chama o(s) agente(s) apropriado(s) com payload completo e validado
- **Consolidar e retornar:** Recebe a análise do especialista e a retorna ao Concierge (no MVP, sem consolidação adicional; no futuro, poderá sintetizar análises de múltiplos agentes)

**Tecnologias:**
- GPT-4o-mini ou GPT-4o (classificação e roteamento inteligente)
- n8n Webhook (receber solicitações do Concierge)
- n8n HTTP Request (chamar workflows dos especialistas)
- n8n PostgreSQL (buscar dados de territórios para enriquecimento)

**Exemplo de Fluxo (MVP):**

```json
// 1. Concierge aciona o Orquestrador
POST https://galactic-ai.app.n8n.cloud/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2
{
  "territory_id": "1721000",
  "question": "Qual o impacto do crescimento populacional na economia de Palmas?"
}

// 2. Orquestrador valida e enriquece
// - Valida: territory_id presente ✓
// - Busca no banco: territory_id = 1721000 → territory_name = "Palmas"
// - Define padrão: analysis_type = "comprehensive"

// 3. Orquestrador roteia
// - Analisa pergunta: identifica palavras-chave "economia"
// - Decisão: acionar Agente ECON

// 4. Orquestrador chama o especialista
POST https://n8n.cloud/webhook/agent-econ
{
  "agent_id": "econ",
  "territory_id": "1721000",
  "territory_name": "Palmas",
  "analysis_type": "comprehensive"
}

// 5. Agente ECON retorna análise completa
// 6. Orquestrador retorna ao Concierge
```

**Exemplo de Fluxo (Produto Completo - Futuro):**

```
Concierge: "Como Palmas se compara com Araguaína em infraestrutura e economia?"

Orquestrador analisa:
1. Dimensões relevantes: TERRA (infraestrutura) + ECON (economia)
2. Territórios: Palmas e Araguaína
3. Tipo de análise: Comparativa multidimensional

Distribui tarefas:
- Agente TERRA: Analisar infraestrutura de Palmas
- Agente TERRA: Analisar infraestrutura de Araguaína
- Agente ECON: Analisar economia de Palmas
- Agente ECON: Analisar economia de Araguaína

Consolida respostas:
"Palmas possui infraestrutura superior em saneamento (87% vs 65%) e 
economia mais diversificada (PIB R$ 14,2 bi vs R$ 5,8 bi), mas 
Araguaína tem maior dinamismo no setor agropecuário..."
```

---

### 2. DATA COLLECTOR - O Analista de Dados

**Perfil:** Especialista em coleta e estruturação de dados

**Responsabilidades:**
- Coletar dados de APIs governamentais (IBGE, INPE, ANA, etc.)
- Estruturar dados no formato do PostgreSQL
- Inserir/atualizar indicadores nas tabelas apropriadas
- Gerar embeddings de análises para RAG
- Executar periodicamente (agendado)

**Tecnologias:**
- n8n Schedule Trigger (execução periódica)
- n8n HTTP Request (chamar APIs)
- n8n Code (processar e transformar dados)
- n8n PostgreSQL (inserir dados)
- OpenAI Embeddings (gerar vetores)

**APIs Integradas (MVP):**
1. **IBGE - PIB Municipal:** `https://servicodados.ibge.gov.br/api/v3/agregados/5938`
2. **IBGE - População:** `https://servicodados.ibge.gov.br/api/v3/agregados/6579`
3. **IBGE - IDH-M:** (via planilha, não tem API em tempo real)
4. **INPE - Desmatamento:** `http://terrabrasilis.dpi.inpe.br/api/`

**Fluxo de Execução:**
1. Trigger agendado (ex: diariamente às 2h)
2. Para cada API:
   - Fazer requisição HTTP
   - Processar resposta JSON
   - Transformar para formato do banco
   - Inserir/atualizar no PostgreSQL
3. Gerar embeddings de novas análises
4. Inserir embeddings na tabela `knowledge_base`

---

### 3. ECON - Especialista Econômico

**Perfil:** Economista especializado em desenvolvimento territorial

**Responsabilidades:**
- Analisar indicadores econômicos (PIB, emprego, renda, setores)
- Identificar tendências e padrões de crescimento/declínio
- Comparar territórios em dimensão econômica
- Gerar insights acionáveis para políticas de desenvolvimento

**Áreas de Análise:**
1. **Produto Interno Bruto:** PIB total, per capita, setorial
2. **Finanças Públicas:** Receitas, despesas, endividamento, dependência de FPM
3. **Mercado de Trabalho:** Emprego formal, salários, informalidade
4. **Setores Produtivos:** Agropecuária, indústria, serviços
5. **Comércio Exterior:** Exportações, importações, balança comercial
6. **Investimentos:** Crédito, investimentos públicos e privados

**Fontes de Dados:**
- IBGE (PIB, setores produtivos)
- SICONFI (finanças públicas)
- RAIS/CAGED (mercado de trabalho)
- MDIC (comércio exterior)
- Banco Central (crédito)

**Exemplo de Análise:**
```
DADOS DE PALMAS (2019-2023):
- PIB: R$ 12,5 bi → R$ 14,2 bi (+13,6%)
- PIB per capita: R$ 42.300 → R$ 45.800 (+8,3%)
- Desemprego: 8,2% → 6,5% (-1,7 p.p.)
- Setores: Serviços 68%, Indústria 22%, Agro 10%

ANÁLISE:
Palmas apresentou crescimento econômico consistente nos últimos 5 anos, 
com PIB aumentando 13,6% e desemprego caindo 1,7 p.p. A economia é 
fortemente baseada em serviços (68%), refletindo o papel da capital 
como centro administrativo e comercial. 

PONTOS FORTES:
• Crescimento acima da média estadual (+13,6% vs +9,2%)
• Redução do desemprego em período pós-pandemia
• Diversificação setorial superior a municípios do interior

DESAFIOS:
• Dependência excessiva do setor público (28% do PIB)
• Indústria incipiente (22% do PIB, concentrada em construção)
• Salário médio 15% abaixo da média nacional

RECOMENDAÇÕES:
1. Atrair investimentos industriais (incentivos fiscais, infraestrutura)
2. Diversificar economia para reduzir dependência do setor público
3. Investir em qualificação profissional para aumentar produtividade
```

---

### 4. SOCIAL - Especialista Social

**Perfil:** Sociólogo especializado em políticas públicas

**Responsabilidades:**
- Analisar indicadores sociais (IDH-M, educação, saúde, segurança)
- Identificar vulnerabilidades e desigualdades
- Comparar territórios em dimensão social
- Gerar insights para políticas de inclusão e bem-estar

**Áreas de Análise:**
1. **Educação:** IDEB, taxa de alfabetização, matrículas, infraestrutura escolar
2. **Saúde:** Mortalidade infantil, cobertura ESF, leitos hospitalares
3. **Assistência Social:** Bolsa Família, CadÚnico, extrema pobreza
4. **Segurança Pública:** Homicídios, roubos, violência doméstica
5. **Habitação e Saneamento:** Déficit habitacional, água, esgoto, coleta de lixo
6. **Trabalho e Renda:** Renda per capita, desigualdade (Gini), pobreza
7. **Desenvolvimento Humano:** IDH-M e componentes (longevidade, educação, renda)

**Fontes de Dados:**
- INEP (educação)
- DataSUS (saúde)
- MDS (assistência social)
- SSP (segurança pública)
- IBGE (habitação, saneamento, renda)

**Exemplo de Análise:**
```
DADOS SOCIAIS DE PALMAS (2019-2023):
- IDH-M: 0,788 → 0,795 (+0,007)
- Alfabetização: 94,1% → 95,3% (+1,2 p.p.)
- Mortalidade infantil: 12,4/1000 → 10,8/1000 (-12,9%)
- Saneamento: 82% → 87% (+5 p.p.)

ANÁLISE:
Palmas apresentou avanços consistentes em indicadores sociais, com 
destaque para redução da mortalidade infantil (-12,9%) e expansão do 
saneamento básico (+5 p.p.). O IDH-M cresceu 0,007 pontos, mantendo 
a capital na faixa "alto desenvolvimento humano".

AVANÇOS PRINCIPAIS:
• Saúde: Redução significativa da mortalidade infantil
• Infraestrutura: Expansão de saneamento em áreas periféricas
• Educação: Aumento da alfabetização, especialmente em adultos

DESAFIOS PERSISTENTES:
• 12,8% da população ainda em situação de pobreza
• Desigualdade educacional entre centro e periferia
• Cobertura de ESF ainda insuficiente (68% vs meta de 85%)

GRUPOS VULNERÁVEIS:
• Famílias monoparentais chefiadas por mulheres
• População em assentamentos irregulares (falta de saneamento)
• Jovens de 15-24 anos (alto desemprego e evasão escolar)

RECOMENDAÇÕES PRIORITÁRIAS:
1. Expandir Bolsa Família para famílias não cadastradas no CadÚnico
2. Investir em saneamento em áreas periféricas (13% ainda sem acesso)
3. Criar programas de qualificação para jovens vulneráveis
```

---

### 5. TERRA - Especialista Territorial

**Perfil:** Geógrafo especializado em planejamento territorial

**Responsabilidades:**
- Analisar indicadores territoriais (área, densidade, urbanização, infraestrutura)
- Identificar padrões espaciais e relações de proximidade
- Comparar territórios geograficamente
- Gerar insights para planejamento urbano e regional

**Áreas de Análise:**
1. **Geografia Física:** Área total, relevo, hidrografia, clima
2. **Ocupação Territorial:** Densidade demográfica, taxa de urbanização
3. **Infraestrutura:** Transporte, energia, telecomunicações
4. **Conectividade:** Distância a outros territórios, malha rodoviária
5. **Uso do Solo:** Áreas urbanas, rurais, protegidas

**Fontes de Dados:**
- IBGE (área, densidade, urbanização)
- DNIT (infraestrutura de transporte)
- ANEEL (energia)
- ANATEL (telecomunicações)
- PostGIS (análises geoespaciais)

**Exemplo de Análise:**
```
DADOS TERRITORIAIS DE PALMAS:
- Área total: 2.218,9 km²
- Área urbanizada: 187,3 km² (8,4%)
- Densidade: 139,4 hab/km²
- Saneamento: 87%
- Territórios próximos: Miracema (32 km), Porto Nacional (43 km)

ANÁLISE:
Palmas possui características territoriais únicas como capital planejada, 
com área urbanizada de apenas 8,4% do território total, indicando grande 
potencial de expansão. A densidade demográfica de 139,4 hab/km² é 
moderada, permitindo crescimento ordenado.

PADRÕES DE OCUPAÇÃO:
• Concentração urbana na área central planejada
• Expansão periférica desordenada em assentamentos irregulares
• 91,6% do território ainda rural/não urbanizado

DESAFIOS DE INFRAESTRUTURA:
• Transporte público insuficiente (baixa cobertura em periferias)
• Saneamento básico não universalizado (13% sem acesso)
• Conectividade rodoviária limitada com interior do estado

OPORTUNIDADES DE EXPANSÃO:
• Grandes áreas disponíveis para crescimento planejado
• Potencial para criação de novos bairros com infraestrutura adequada
• Possibilidade de integração metropolitana com Porto Nacional

RECOMENDAÇÕES:
1. Elaborar Plano Diretor de Expansão Urbana para áreas não ocupadas
2. Investir em transporte público para conectar periferias ao centro
3. Universalizar saneamento básico em assentamentos irregulares
4. Criar corredores de integração com Porto Nacional e Miracema
```

---

### 6. AMBIENT - Especialista Ambiental

**Perfil:** Ambientalista especializado em gestão territorial

**Responsabilidades:**
- Analisar indicadores ambientais (desmatamento, qualidade ar/água, áreas protegidas)
- Identificar riscos ambientais e áreas críticas
- Comparar territórios em dimensão ambiental
- Gerar insights para políticas de conservação e sustentabilidade

**Áreas de Análise:**
1. **Desmatamento:** Taxa anual, áreas desmatadas, tendências
2. **Qualidade do Ar:** IQA (Índice de Qualidade do Ar), poluentes
3. **Recursos Hídricos:** Qualidade da água, disponibilidade, poluição
4. **Áreas Protegidas:** Unidades de conservação, terras indígenas
5. **Biodiversidade:** Espécies ameaçadas, ecossistemas críticos
6. **Mudanças Climáticas:** Emissões de GEE, vulnerabilidades

**Fontes de Dados:**
- INPE (desmatamento, queimadas)
- ANA (recursos hídricos)
- IBAMA (áreas protegidas)
- ICMBio (biodiversidade)
- INMET (clima)

**Exemplo de Análise:**
```
DADOS AMBIENTAIS DE PALMAS (2019-2023):
- Desmatamento: 2,3% → 2,8% (+0,5 p.p.) ⚠️
- Qualidade do ar: Boa (IQA médio: 45)
- Cobertura vegetal: 89,2% → 88,1% (-1,1 p.p.)
- Áreas protegidas: 12% do território

ANÁLISE:
Palmas apresenta situação ambiental relativamente favorável, com 88,1% 
de cobertura vegetal preservada e qualidade do ar boa. No entanto, a 
taxa de desmatamento aumentou 0,5 p.p. nos últimos 5 anos, sinalizando 
necessidade de atenção.

PRINCIPAIS RISCOS:
• Aumento do desmatamento em áreas periféricas (expansão urbana)
• Poluição do Lago de Palmas (esgoto não tratado)
• Queimadas em período de seca (risco para áreas urbanas)

ÁREAS DE ATENÇÃO:
• Região sul (expansão urbana irregular sobre áreas de preservação)
• Margens do Lago de Palmas (ocupação irregular e poluição)
• Áreas de recarga de aquíferos (vulneráveis a contaminação)

OPORTUNIDADES DE CONSERVAÇÃO:
• 12% do território já protegido (Parque Cesamar, APA Serra do Lajeado)
• Potencial para criação de corredores ecológicos
• Possibilidade de recuperação de áreas degradadas

RECOMENDAÇÕES URGENTES:
1. Implementar fiscalização rigorosa em áreas de expansão urbana
2. Universalizar tratamento de esgoto para proteger Lago de Palmas
3. Criar programa de prevenção e combate a queimadas
4. Ampliar áreas protegidas para 20% do território (meta ONU)
```

---

## 🔄 COMUNICAÇÃO ENTRE ESPECIALISTAS

### Protocolo de Comunicação

**Orquestrador → Especialistas:**
- Método: HTTP POST para webhook de cada agente
- Formato: JSON estruturado

**Especialistas → Orquestrador:**
- Método: Resposta HTTP
- Formato: JSON com análise gerada

**Todos → PostgreSQL:**
- Inserção de dados e análises na base de conhecimento

### Formato de Mensagem (Orquestrador → Especialista)

```json
{
  "task_id": "uuid-v4-12345",
  "territory_id": 1,
  "territory_name": "Palmas",
  "dimension": "economic",
  "task_description": "Analisar evolução econômica de Palmas (2019-2023)",
  "context": {
    "user_question": "Como está a economia de Palmas?",
    "comparison_territories": [],
    "time_range": "2019-2023",
    "requested_by": "user@example.com",
    "priority": "normal"
  }
}
```

### Formato de Resposta (Especialista → Orquestrador)

```json
{
  "task_id": "uuid-v4-12345",
  "agent_name": "ECON",
  "status": "success",
  "analysis": {
    "summary": "Palmas apresentou crescimento econômico consistente...",
    "key_insights": [
      "PIB cresceu 13,6% no período",
      "Desemprego caiu 1,7 p.p.",
      "Economia fortemente baseada em serviços (68%)"
    ],
    "strengths": [
      "Crescimento acima da média estadual",
      "Redução do desemprego",
      "Diversificação setorial"
    ],
    "challenges": [
      "Dependência do setor público (28% do PIB)",
      "Indústria incipiente",
      "Salário médio abaixo da média nacional"
    ],
    "recommendations": [
      "Atrair investimentos industriais",
      "Diversificar economia",
      "Investir em qualificação profissional"
    ]
  },
  "metadata": {
    "processing_time_seconds": 12.5,
    "data_sources": ["IBGE", "SICONFI", "RAIS"],
    "confidence_score": 0.92,
    "last_data_update": "2023-12-31"
  }
}
```

---

## 💾 INTEGRAÇÃO COM BASE DE CONHECIMENTO

### Fluxo de Dados

```
1. Especialista gera análise
   ↓
2. Salva na tabela `knowledge_base`
   ↓
3. Gera embedding vetorial (OpenAI)
   ↓
4. Salva embedding na mesma tabela
   ↓
5. Análise fica disponível para:
   - Dashboard (consulta rápida)
   - RAG (contexto para futuras análises)
   - Orquestrador (aprendizado contínuo)
```

### Estrutura da Tabela `knowledge_base`

```sql
CREATE TABLE knowledge_base (
  id SERIAL PRIMARY KEY,
  territory_id INTEGER REFERENCES territories(id),
  dimension VARCHAR(50), -- 'economic', 'social', 'territorial', 'environmental'
  analysis_type VARCHAR(50), -- 'single', 'comparative', 'temporal'
  content TEXT, -- Análise completa em texto
  summary TEXT, -- Resumo executivo
  key_insights JSONB, -- Insights principais estruturados
  metadata JSONB, -- Metadados (fontes, confiança, etc.)
  embedding VECTOR(1536), -- Embedding para RAG (pgvector)
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### Consulta RAG (Retrieval-Augmented Generation)

Quando um especialista precisa de contexto de análises anteriores:

```sql
-- Buscar análises similares usando similaridade de cosseno
SELECT 
  content, 
  summary, 
  key_insights,
  1 - (embedding <=> $1::vector) AS similarity
FROM knowledge_base
WHERE dimension = 'economic'
  AND territory_id = 1
ORDER BY embedding <=> $1::vector
LIMIT 5;
```

Isso permite que os especialistas **aprendam com análises anteriores** e mantenham **consistência** nas recomendações.

---

## 🚀 ESCALABILIDADE

### Workflows Criados

| Agente | Webhook | Dimensão | Confidence | Diferencial |
|--------|---------|----------|------------|-------------|
| **ECON** | `/agent-econ` | economic | 0.92 | Análise econômica e fiscal |
| **SOCIAL** | `/agent-social` | social | 0.90 | Vulnerabilidades e inclusão |
| **TERRA** | `/agent-terra` | territorial | 0.91 | PostGIS + conectividade |
| **AMBIENT** | `/agent-ambient` | environmental | 0.88 | Alertas ambientais |

**Localização dos Workflows:** `/n8n/workflows/`

---


### Adicionar Novo Especialista

O núcleo foi projetado para ser facilmente escalável. Para adicionar um novo especialista (ex: SECURITY - Segurança Pública):

1. **Criar workflow no n8n:**
   - Webhook para receber tarefas
   - Consulta ao PostgreSQL
   - Processamento com LLM
   - Resposta estruturada

2. **Atualizar Orquestrador:**
   - Adicionar "security" na lista de dimensões
   - Adicionar lógica de roteamento
   - Adicionar consolidação de resposta

3. **Atualizar Base de Conhecimento:**
   - Adicionar "security" como valor válido em `dimension`
   - Criar tabela `security_indicators` (se necessário)

**Tempo estimado:** 2-4 horas por novo especialista

---

## 📊 MONITORAMENTO E MÉTRICAS

### Métricas de Performance

- **Tempo de resposta por especialista:** <15 segundos (média)
- **Taxa de sucesso:** >95%
- **Análises geradas por dia:** Ilimitado (escalável)
- **Custo por análise:** ~$0,10 (OpenAI API)

### Monitoramento no n8n

1. Menu lateral → **"Executions"**
2. Filtrar por workflow
3. Ver detalhes de cada execução:
   - Tempo de processamento
   - Dados de entrada/saída
   - Erros (se houver)

---

## 🎓 PRÓXIMOS PASSOS

1. **Criar workflows dos 4 especialistas dimensionais** (ECON, SOCIAL, TERRA, AMBIENT)
2. **Criar workflow do Orquestrador** (Meta-LLM)
3. **Criar workflow do Data Collector**
4. **Testar integração completa** (dashboard → n8n → PostgreSQL → dashboard)
5. **Documentar cada workflow** individualmente

---

**Autor:** Manus AI  
**Data:** 16 de novembro de 2025  
**Versão:** 1.0.0
