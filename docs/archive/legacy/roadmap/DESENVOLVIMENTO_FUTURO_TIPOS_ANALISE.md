# Desenvolvimento Futuro: Tipos de Análise Diferenciados

**Framework de Inteligência Territorial V6.0**  
**Data:** 01/12/2025  
**Status:** 📋 Planejamento  
**Prioridade:** Média  
**Complexidade:** Alta

---

## 📋 RESUMO EXECUTIVO

Atualmente, o sistema aceita o parâmetro `analysis_type` nos workflows, mas este campo funciona apenas como **metadado** e não influencia ativamente o comportamento dos agentes. Este documento propõe a implementação de **4 tipos de análise diferenciados**, cada um com objetivos específicos, requisitos técnicos e adaptações necessárias nos workflows.

A implementação desses tipos de análise transformará o sistema em uma ferramenta mais versátil, capaz de atender diferentes necessidades de gestores públicos, desde consultas rápidas até estudos comparativos complexos.

---

## 🎯 TIPOS DE ANÁLISE PROPOSTOS

### 1. Comprehensive (Análise Abrangente)

**Objetivo:** Gerar uma análise completa, profunda e contextualizada de um território, cobrindo todas as dimensões disponíveis.

**Características:**
- Análise detalhada de todos os indicadores
- Contextualização histórica e temporal
- Identificação de tendências e padrões
- Recomendações estratégicas de curto, médio e longo prazo
- Integração entre dimensões (social, econômica, territorial, ambiental)
- Extensão: 1500-2500 palavras

**Casos de Uso:**
- Elaboração de planos diretores municipais
- Relatórios anuais de gestão
- Diagnósticos territoriais completos
- Planejamento estratégico de longo prazo
- Prestação de contas para órgãos de controle

**Tempo de Execução Estimado:** 30-60 segundos

**Exemplo de Payload:**
```json
{
  "agent_id": "social",
  "territory_id": "1721000",
  "territory_name": "Palmas",
  "analysis_type": "comprehensive",
  "parameters": {
    "time_period": "2019-2023",
    "focus_areas": ["educação", "saúde", "desenvolvimento humano"],
    "detail_level": "high"
  }
}
```

---

### 2. Quick (Análise Rápida)

**Objetivo:** Gerar uma análise resumida e objetiva, focada nos principais indicadores e insights críticos.

**Características:**
- Foco nos indicadores mais relevantes
- Síntese executiva concisa
- Identificação de alertas e oportunidades prioritárias
- Recomendações imediatas (ações de curto prazo)
- Extensão: 300-500 palavras

**Casos de Uso:**
- Consultas rápidas para tomada de decisão
- Dashboards executivos
- Briefings para gestores
- Monitoramento contínuo de indicadores
- Alertas de situações críticas

**Tempo de Execução Estimado:** 10-20 segundos

**Exemplo de Payload:**
```json
{
  "agent_id": "social",
  "territory_id": "1721000",
  "territory_name": "Palmas",
  "analysis_type": "quick",
  "parameters": {
    "time_period": "2023",
    "focus_areas": ["IDHM", "educação"],
    "detail_level": "low"
  }
}
```

---

### 3. Focused (Análise Focada)

**Objetivo:** Gerar uma análise aprofundada de áreas temáticas específicas, ignorando indicadores não relacionados.

**Características:**
- Análise profunda de temas específicos
- Contextualização temática detalhada
- Identificação de causas e consequências
- Recomendações especializadas para o tema
- Extensão: 800-1200 palavras

**Casos de Uso:**
- Investigação de problemas específicos (ex: evasão escolar)
- Elaboração de políticas setoriais
- Estudos temáticos (ex: saneamento básico)
- Avaliação de programas governamentais
- Pesquisas acadêmicas aplicadas

**Tempo de Execução Estimado:** 20-40 segundos

**Exemplo de Payload:**
```json
{
  "agent_id": "social",
  "territory_id": "1721000",
  "territory_name": "Palmas",
  "analysis_type": "focused",
  "parameters": {
    "time_period": "2019-2023",
    "focus_areas": ["educação"],
    "focus_theme": "qualidade do ensino fundamental",
    "detail_level": "high"
  }
}
```

---

### 4. Comparative (Análise Comparativa)

**Objetivo:** Comparar múltiplos territórios em relação a indicadores específicos, identificando padrões, disparidades e benchmarks.

**Características:**
- Comparação lado a lado de indicadores
- Identificação de líderes e retardatários
- Análise de disparidades regionais
- Identificação de boas práticas
- Recomendações baseadas em benchmarking
- Extensão: 1000-1500 palavras

**Casos de Uso:**
- Ranking de municípios
- Identificação de desigualdades regionais
- Benchmarking de políticas públicas
- Estudos de desenvolvimento regional
- Alocação de recursos baseada em necessidades

**Tempo de Execução Estimado:** 40-90 segundos (depende do número de territórios)

**Exemplo de Payload:**
```json
{
  "agent_id": "social",
  "territory_ids": ["1721000", "1705508", "1702109"],
  "territory_names": ["Palmas", "Araguaína", "Gurupi"],
  "analysis_type": "comparative",
  "parameters": {
    "time_period": "2023",
    "focus_areas": ["IDHM", "educação", "saúde"],
    "comparison_metrics": ["absolute", "relative", "ranking"],
    "detail_level": "medium"
  }
}
```

---

## 🏗️ ARQUITETURA DE IMPLEMENTAÇÃO

### Visão Geral

A implementação dos tipos de análise diferenciados requer modificações em **3 camadas** do workflow:

1. **Camada de Entrada** - Validação e normalização do payload
2. **Camada de Processamento** - Coleta e preparação de dados
3. **Camada de Geração** - Prompts LLM adaptativos

---

## 🔧 ADAPTAÇÕES NECESSÁRIAS POR TIPO

### 1. Comprehensive (Estado Atual - Já Implementado)

**Adaptações Necessárias:** ✅ Nenhuma (já é o comportamento padrão)

**Observação:** O tipo `comprehensive` representa o comportamento atual dos workflows. Todas as análises geradas hoje são abrangentes e profundas.

---

### 2. Quick (Análise Rápida)

#### 2.1. Nó "Normalizar Entrada"

**Mudanças:**
- Validar `detail_level = "low"`
- Limitar `focus_areas` a no máximo 3 áreas
- Limitar `time_period` a 1 ano (ex: "2023" em vez de "2019-2023")

**Código Adicional:**
```javascript
if (analysis_type === "quick") {
  // Limitar período temporal
  if (parameters.time_period && parameters.time_period.includes("-")) {
    const years = parameters.time_period.split("-");
    parameters.time_period = years[1]; // Usar apenas o ano mais recente
  }
  
  // Limitar focus_areas
  if (parameters.focus_areas && parameters.focus_areas.length > 3) {
    parameters.focus_areas = parameters.focus_areas.slice(0, 3);
  }
  
  // Forçar detail_level baixo
  parameters.detail_level = "low";
}
```

#### 2.2. Nó "Consultar Dados PostgreSQL"

**Mudanças:**
- Modificar query SQL para retornar apenas o ano mais recente
- Selecionar apenas indicadores principais (top 5-7)

**Query SQL Adaptada:**
```sql
-- Para analysis_type = "quick"
WHERE si.year = (
  SELECT MAX(year) 
  FROM social_indicators 
  WHERE territory_id = '{{ $('Normalizar Entrada').first().json.territory_id }}'
)
```

#### 2.3. Nó "Preparar Contexto para LLM"

**Mudanças:**
- Adicionar flag `is_quick_analysis: true`
- Incluir instrução de brevidade no contexto

**Código Adicional:**
```javascript
const analysis_type = $('Normalizar Entrada').first().json.analysis_type;

if (analysis_type === "quick") {
  context.analysis_instructions = {
    type: "quick",
    max_words: 500,
    focus: "principais insights e alertas críticos",
    structure: "resumo executivo apenas"
  };
}
```

#### 2.4. Nó "Gerar Análise com OpenAI"

**Mudanças:**
- Modificar prompt LLM para incluir instruções de brevidade

**Prompt Adaptado:**
```
Você é o Agente SOCIAL. Gere uma análise RÁPIDA e OBJETIVA.

⚠️ RESTRIÇÕES:
- Máximo de 500 palavras
- Foco nos 3 indicadores mais críticos
- Apenas 1 parágrafo de resumo executivo
- Listar apenas as 3 ações mais urgentes

[Resto do prompt...]
```

---

### 3. Focused (Análise Focada)

#### 3.1. Nó "Normalizar Entrada"

**Mudanças:**
- Adicionar campo obrigatório: `focus_theme` (string)
- Validar que `focus_areas` tem no máximo 2 áreas

**Código Adicional:**
```javascript
if (analysis_type === "focused") {
  // Validar focus_theme
  if (!webhookData.parameters || !webhookData.parameters.focus_theme) {
    throw new Error("analysis_type 'focused' requer o campo 'focus_theme'");
  }
  
  // Limitar focus_areas
  if (parameters.focus_areas && parameters.focus_areas.length > 2) {
    throw new Error("analysis_type 'focused' permite no máximo 2 focus_areas");
  }
  
  normalizedData.parameters.focus_theme = parameters.focus_theme;
}
```

#### 3.2. Nó "Consultar Dados PostgreSQL"

**Mudanças:**
- Filtrar colunas da query para incluir apenas as relacionadas ao `focus_theme`
- Adicionar lógica de mapeamento tema → colunas

**Mapeamento Tema → Colunas:**
```javascript
const themeColumns = {
  "qualidade do ensino fundamental": [
    "ideb_anos_iniciais",
    "ideb_anos_finais",
    "taxa_conclusao_fundamental",
    "literacy_rate"
  ],
  "saúde materno-infantil": [
    "mortalidade_infantil",
    "expectativa_vida",
    "cobertura_vacinal"
  ],
  "saneamento básico": [
    "sanitation_coverage",
    "water_quality"
  ]
};
```

#### 3.3. Nó "Gerar Análise com OpenAI"

**Mudanças:**
- Modificar prompt para focar exclusivamente no tema

**Prompt Adaptado:**
```
Você é o Agente SOCIAL. Gere uma análise FOCADA no tema: "{{ focus_theme }}".

🎯 FOCO EXCLUSIVO:
- Analise APENAS indicadores relacionados a: {{ focus_theme }}
- Ignore indicadores não relacionados
- Aprofunde-se nas causas e consequências
- Recomendações específicas para o tema

[Resto do prompt...]
```

---

### 4. Comparative (Análise Comparativa)

#### 4.1. Nó "Normalizar Entrada"

**Mudanças:**
- Aceitar **array** de `territory_ids` (em vez de string única)
- Aceitar **array** de `territory_names`
- Validar que há pelo menos 2 territórios
- Limitar a no máximo 10 territórios

**Código Adicional:**
```javascript
if (analysis_type === "comparative") {
  // Validar territory_ids (array)
  if (!Array.isArray(webhookData.territory_ids) || webhookData.territory_ids.length < 2) {
    throw new Error("analysis_type 'comparative' requer pelo menos 2 territory_ids");
  }
  
  if (webhookData.territory_ids.length > 10) {
    throw new Error("analysis_type 'comparative' permite no máximo 10 territórios");
  }
  
  // Validar territory_names (array)
  if (!Array.isArray(webhookData.territory_names) || 
      webhookData.territory_names.length !== webhookData.territory_ids.length) {
    throw new Error("territory_names deve ter o mesmo tamanho que territory_ids");
  }
  
  normalizedData.territory_ids = webhookData.territory_ids;
  normalizedData.territory_names = webhookData.territory_names;
  
  // Remover territory_id único (não usado em comparativa)
  delete normalizedData.territory_id;
  delete normalizedData.territory_name;
}
```

#### 4.2. Nó "Consultar Dados PostgreSQL"

**Mudanças:**
- Modificar query SQL para usar `IN` em vez de `=`
- Retornar dados de todos os territórios
- Adicionar colunas de identificação de território

**Query SQL Adaptada:**
```sql
-- Para analysis_type = "comparative"
WHERE si.territory_id IN (
  '{{ $('Normalizar Entrada').first().json.territory_ids.join("','") }}'
)
ORDER BY si.territory_id, si.year DESC
```

#### 4.3. Nó "Preparar Contexto para LLM"

**Mudanças:**
- Agrupar dados por território
- Calcular métricas comparativas (médias, rankings, disparidades)
- Formatar dados em tabelas comparativas

**Código Adicional:**
```javascript
if (analysis_type === "comparative") {
  const territories = {};
  
  // Agrupar dados por território
  for (const row of data) {
    if (!territories[row.territory_id]) {
      territories[row.territory_id] = {
        id: row.territory_id,
        name: row.territory_name,
        indicators: []
      };
    }
    territories[row.territory_id].indicators.push(row);
  }
  
  // Calcular rankings
  const rankings = calculateRankings(territories, focus_areas);
  
  // Calcular disparidades
  const disparities = calculateDisparities(territories, focus_areas);
  
  context.comparative_data = {
    territories: territories,
    rankings: rankings,
    disparities: disparities
  };
}
```

#### 4.4. Nó "Gerar Análise com OpenAI"

**Mudanças:**
- Modificar prompt para análise comparativa

**Prompt Adaptado:**
```
Você é o Agente SOCIAL. Gere uma análise COMPARATIVA entre os seguintes territórios:
{{ territory_names.join(", ") }}

📊 ESTRUTURA DA ANÁLISE:

1. RESUMO COMPARATIVO
   - Principais diferenças e semelhanças
   - Líderes e retardatários por indicador

2. ANÁLISE POR INDICADOR
   Para cada indicador em {{ focus_areas }}:
   - Ranking dos territórios
   - Disparidades (máximo vs mínimo)
   - Padrões identificados

3. BOAS PRÁTICAS
   - Identificar territórios com desempenho superior
   - Analisar possíveis fatores de sucesso

4. RECOMENDAÇÕES
   - Para territórios com desempenho inferior
   - Oportunidades de aprendizado entre territórios

[Resto do prompt...]
```

#### 4.5. Nó "Salvar Análise no PostgreSQL"

**Mudanças:**
- Salvar análise com referência a múltiplos territórios
- Adicionar campo `compared_territories` (array JSON)

**Query SQL Adaptada:**
```sql
INSERT INTO knowledge_base (
  id,
  territory_id,
  compared_territories, -- NOVO CAMPO
  dimension,
  content,
  summary,
  -- [outros campos...]
)
VALUES (
  $1,
  'COMPARATIVE', -- Valor especial para análises comparativas
  $2, -- Array JSON com IDs dos territórios comparados
  $3,
  -- [outros valores...]
)
```

---

## 📊 TABELA COMPARATIVA DE REQUISITOS

| Aspecto | Comprehensive | Quick | Focused | Comparative |
|---------|---------------|-------|---------|-------------|
| **Payload** | Simples | Simples | +focus_theme | +territory_ids[] |
| **Validação** | Básica | Básica | +tema obrigatório | +múltiplos territórios |
| **Query SQL** | Padrão | Ano único | Colunas filtradas | IN clause |
| **Dados Retornados** | Todos | Top 5-7 | Filtrados por tema | Múltiplos territórios |
| **Contexto LLM** | Completo | Resumido | Focado | Agrupado + Rankings |
| **Prompt LLM** | Padrão | +brevidade | +foco temático | +comparação |
| **Salvamento** | Padrão | Padrão | Padrão | +compared_territories |
| **Complexidade** | Baixa | Baixa | Média | Alta |

---

## 🚧 DESAFIOS TÉCNICOS

### 1. Análise Comparativa

**Desafio 1: Performance**
- Consultar dados de 10 territórios pode ser lento
- Solução: Otimizar query SQL com índices, usar cache

**Desafio 2: Tamanho do Contexto LLM**
- Dados de múltiplos territórios podem exceder limite de tokens
- Solução: Resumir dados antes de enviar ao LLM, usar apenas indicadores chave

**Desafio 3: Qualidade da Comparação**
- LLM pode ter dificuldade em comparar muitos territórios simultaneamente
- Solução: Limitar a 5 territórios por análise, ou fazer comparações em pares

### 2. Análise Focada

**Desafio 1: Mapeamento Tema → Colunas**
- Difícil mapear temas livres para colunas específicas
- Solução: Criar dicionário de temas pré-definidos, usar NLP para temas livres

**Desafio 2: Validação de Tema**
- Usuário pode informar tema irrelevante para o agente
- Solução: Validar tema contra lista de temas suportados por dimensão

### 3. Análise Rápida

**Desafio 1: Qualidade vs Velocidade**
- Análise muito resumida pode perder insights importantes
- Solução: Definir critérios claros de priorização de insights

---

## 📈 ROADMAP DE IMPLEMENTAÇÃO

### Fase 1: Quick (Prioridade Alta)
**Estimativa:** 2-3 dias  
**Complexidade:** Baixa  
**Benefício:** Alto (facilita testes e consultas rápidas)

**Tarefas:**
1. Adaptar nó "Normalizar Entrada" (2h)
2. Adaptar query SQL (2h)
3. Adaptar prompt LLM (3h)
4. Testar com múltiplos territórios (2h)
5. Documentar (1h)

---

### Fase 2: Focused (Prioridade Média)
**Estimativa:** 4-5 dias  
**Complexidade:** Média  
**Benefício:** Médio (útil para estudos temáticos)

**Tarefas:**
1. Criar dicionário de temas por dimensão (4h)
2. Adaptar nó "Normalizar Entrada" (3h)
3. Implementar filtro de colunas na query SQL (4h)
4. Adaptar prompt LLM (4h)
5. Testar com múltiplos temas (3h)
6. Documentar (2h)

---

### Fase 3: Comparative (Prioridade Baixa)
**Estimativa:** 7-10 dias  
**Complexidade:** Alta  
**Benefício:** Alto (funcionalidade diferenciada)

**Tarefas:**
1. Adaptar nó "Normalizar Entrada" para arrays (4h)
2. Reescrever query SQL para múltiplos territórios (6h)
3. Implementar cálculo de rankings e disparidades (8h)
4. Adaptar prompt LLM para comparação (6h)
5. Adaptar salvamento no banco (4h)
6. Criar visualizações comparativas (opcional) (8h)
7. Testar com 2, 5 e 10 territórios (6h)
8. Otimizar performance (4h)
9. Documentar (3h)

---

## 🎯 CRITÉRIOS DE SUCESSO

### Quick
- ✅ Tempo de execução < 20 segundos
- ✅ Análise com 300-500 palavras
- ✅ Mantém qualidade mínima de insights

### Focused
- ✅ Análise focada exclusivamente no tema
- ✅ Profundidade superior ao comprehensive para o tema
- ✅ Recomendações específicas e acionáveis

### Comparative
- ✅ Comparação clara entre territórios
- ✅ Rankings precisos e justificados
- ✅ Identificação de boas práticas
- ✅ Tempo de execução < 90 segundos para 5 territórios

---

## 📚 EXEMPLOS DE USO

### Caso 1: Gestor Precisa de Decisão Rápida

**Situação:** Prefeito precisa saber se deve priorizar educação ou saúde no próximo trimestre.

**Solução:** Análise Quick de ambas as dimensões
```bash
# Análise rápida - Educação
POST /webhook/agent-social
{
  "agent_id": "social",
  "territory_id": "1721000",
  "analysis_type": "quick",
  "parameters": {"focus_areas": ["educação"]}
}

# Análise rápida - Saúde
POST /webhook/agent-social
{
  "agent_id": "social",
  "territory_id": "1721000",
  "analysis_type": "quick",
  "parameters": {"focus_areas": ["saúde"]}
}
```

**Resultado:** 2 análises resumidas em 40 segundos, permitindo decisão informada.

---

### Caso 2: Secretaria Investiga Evasão Escolar

**Situação:** Secretaria de Educação quer entender causas da evasão no ensino fundamental.

**Solução:** Análise Focused em educação
```bash
POST /webhook/agent-social
{
  "agent_id": "social",
  "territory_id": "1721000",
  "analysis_type": "focused",
  "parameters": {
    "focus_areas": ["educação"],
    "focus_theme": "evasão escolar no ensino fundamental"
  }
}
```

**Resultado:** Análise aprofundada sobre evasão, com causas, consequências e recomendações específicas.

---

### Caso 3: Estado Quer Identificar Municípios Prioritários

**Situação:** Governo estadual precisa alocar recursos de saúde para municípios mais vulneráveis.

**Solução:** Análise Comparative de todos os municípios
```bash
POST /webhook/agent-social
{
  "agent_id": "social",
  "territory_ids": ["1721000", "1705508", "1702109", "1720101", "1718204"],
  "territory_names": ["Palmas", "Araguaína", "Gurupi", "Porto Nacional", "Paraíso do Tocantins"],
  "analysis_type": "comparative",
  "parameters": {
    "focus_areas": ["saúde"],
    "comparison_metrics": ["absolute", "ranking"]
  }
}
```

**Resultado:** Ranking de municípios por indicadores de saúde, identificando os 3 mais vulneráveis para priorização.

---

## 🔮 VISÃO DE LONGO PRAZO

### Tipos Adicionais Futuros

#### 5. Predictive (Análise Preditiva)
- Projeções de indicadores para 5-10 anos
- Simulação de cenários (otimista, pessimista, realista)
- Requer: Modelos de machine learning, dados históricos extensos

#### 6. Impact (Análise de Impacto)
- Avaliação de impacto de políticas públicas
- Comparação antes/depois de intervenções
- Requer: Dados de intervenções, metodologia de avaliação de impacto

#### 7. Causal (Análise Causal)
- Identificação de relações causais entre indicadores
- Análise de fatores determinantes
- Requer: Modelos estatísticos avançados, dados longitudinais

---

## 📝 CONSIDERAÇÕES FINAIS

A implementação de tipos de análise diferenciados é um **desenvolvimento estratégico** que ampliará significativamente a utilidade e versatilidade do Framework de Inteligência Territorial. 

**Recomendações:**

1. **Começar pela análise Quick** - Menor complexidade, alto benefício
2. **Validar com usuários reais** - Testar protótipos com gestores públicos
3. **Iterar baseado em feedback** - Ajustar tipos e funcionalidades conforme necessidade
4. **Documentar casos de uso** - Criar biblioteca de exemplos práticos
5. **Considerar interface gráfica** - Facilitar seleção de tipos de análise no Web App

**Quando implementar:**
- Quick: Assim que houver demanda por consultas rápidas
- Focused: Quando houver casos de uso temáticos recorrentes
- Comparative: Quando houver necessidade de benchmarking regional

---

**Preparado por:** Manus AI  
**Data:** 01/12/2025  
**Sessão:** #11  
**Status:** 📋 Documento de Planejamento  
**Próxima Revisão:** Quando houver demanda de implementação
