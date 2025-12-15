# Proposta: Orquestrador V5.0 com Agent Registry

**Framework de Inteligência Territorial V6.0**  
**Data de Criação:** 08 de dezembro de 2025  
**Autor:** Henrique M. Ribeiro (com Manus AI)  
**Status:** Proposta para Implementação Futura  
**Versão:** 1.0.0

---

## 📋 ÍNDICE

1. [Contexto e Motivação](#1-contexto-e-motivação)
2. [Análise Crítica do Orquestrador V4.0](#2-análise-crítica-do-orquestrador-v40)
3. [Conceito: Andaimes Arquiteturais Dinâmicos](#3-conceito-andaimes-arquiteturais-dinâmicos)
4. [Proposta: Agent Registry](#4-proposta-agent-registry)
5. [Arquitetura do Orquestrador V5.0](#5-arquitetura-do-orquestrador-v50)
6. [Processo de Adição de Novos Agentes](#6-processo-de-adição-de-novos-agentes)
7. [Benefícios e Impactos](#7-benefícios-e-impactos)
8. [Roadmap de Implementação](#8-roadmap-de-implementação)
9. [Considerações Técnicas](#9-considerações-técnicas)
10. [Conclusão](#10-conclusão)

---

## 1. CONTEXTO E MOTIVAÇÃO

### 1.1 O Problema da Extensibilidade

O **Orquestrador V4.0** representa um avanço significativo na capacidade do sistema de lidar com análises multidimensionais e multiterritoriais. No entanto, ele possui uma limitação fundamental: **os agentes especialistas são conhecidos de forma estática (hard-coded)**.

Atualmente, para adicionar um novo agente especialista ao sistema (por exemplo, um **Agente Demográfico** ou um **Agente de Segurança Pública**), seria necessário:

1. Modificar o prompt do nó "OpenAI - Interpretar Pergunta" para incluir a nova dimensão.
2. Adicionar novos nós `IF` para rotear para o novo agente.
3. Adicionar novos nós `HTTP Request` para chamar o novo agente.
4. Modificar o nó de agregação para lidar com a nova resposta.

Este processo é:
- **Frágil:** Qualquer erro de configuração pode quebrar todo o fluxo.
- **Propenso a erros:** Requer modificação manual em múltiplos pontos do workflow.
- **Não escala:** A complexidade cresce linearmente com o número de agentes.
- **Requer conhecimento técnico profundo:** Apenas desenvolvedores podem adicionar novos agentes.

### 1.2 A Visão de Longo Prazo

O **Framework de Inteligência Territorial** é projetado para evoluir continuamente. A visão de longo prazo inclui:

- **12+ agentes especialistas** (conforme o Galactic Interaction Framework V5.0).
- **Agentes desenvolvidos por diferentes equipes** ou até por terceiros.
- **Agentes que podem ser ativados/desativados** dinamicamente conforme a necessidade.
- **Agentes que evoluem em versões** independentemente uns dos outros.

Para suportar essa visão, precisamos de uma arquitetura que trate os agentes como **componentes plugáveis**, não como partes fixas do código.

---

## 2. ANÁLISE CRÍTICA DO ORQUESTRADOR V4.0

### 2.1 Estrutura Atual

O Orquestrador V4.0 possui a seguinte estrutura de roteamento:

```
Webhook → Validação → Buscar Território → Gerar request_id
    ↓
OpenAI - Interpretar Pergunta
    ↓
    ├─→ IF (economic?) → HTTP Request (Agent ECON)
    ├─→ IF (social?) → HTTP Request (Agent SOCIAL)
    ├─→ IF (terra?) → HTTP Request (Agent TERRA)
    └─→ IF (ambient?) → HTTP Request (Agent AMBIENT)
    ↓
Agregar Respostas → Sintetizar → Salvar → Responder
```

### 2.2 Limitações Identificadas

| Aspecto | Limitação | Impacto |
| :--- | :--- | :--- |
| **Prompt da IA** | Lista fixa de dimensões (`economic`, `social`, `terra`, `ambient`) | Adicionar novo agente requer modificar o prompt |
| **Roteamento** | Nós `IF` específicos para cada agente | Adicionar novo agente requer adicionar novos nós |
| **Chamadas HTTP** | URLs hard-coded em cada nó `HTTP Request` | Mudança de URL requer modificar o workflow |
| **Descoberta** | Orquestrador não "sabe" quais agentes existem | Não há visibilidade do ecossistema de agentes |

### 2.3 Exemplo de Adição de Novo Agente (Processo Atual)

Para adicionar um **Agente Demográfico** ao Orquestrador V4.0:

**Passo 1:** Modificar o nó "OpenAI - Interpretar Pergunta"
```diff
- "...escolha uma ou mais das seguintes dimensões: economic, social, terra, ambient..."
+ "...escolha uma ou mais das seguintes dimensões: economic, social, terra, ambient, demographic..."
```

**Passo 2:** Adicionar novo nó `IF - Rotear para Demographic`
```javascript
IF {{ $json.dimensions }} contains "demographic"
```

**Passo 3:** Adicionar novo nó `HTTP Request - Chamar Agente DEMOGRAPHIC`
```
URL: https://galactic-ai.app.n8n.cloud/webhook/agent-demographic
```

**Passo 4:** Testar todo o fluxo para garantir que não quebrou nada.

**Tempo estimado:** 30-45 minutos por agente.  
**Risco:** Alto (modificação manual em workflow complexo).

---

## 3. CONCEITO: ANDAIMES ARQUITETURAIS DINÂMICOS

### 3.1 Definição

**"Andaimes Arquiteturais Dinâmicos"** é um conceito emergente da Sessão #13 que descreve a capacidade de um sistema de **construir sua própria estrutura de conhecimento em tempo de execução**, em vez de depender de configurações estáticas.

Um "andaime" é uma estrutura temporária que suporta a construção de algo maior. Na arquitetura de software, um andaime dinâmico é uma estrutura que:

1. **Descobre** os componentes disponíveis no sistema.
2. **Adapta** seu comportamento com base nessa descoberta.
3. **Evolui** automaticamente quando novos componentes são adicionados.

### 3.2 Aplicação ao Orquestrador

No contexto do Orquestrador, um andaime dinâmico significa:

- O Orquestrador **não conhece os agentes antecipadamente**.
- Ele **consulta um registro** para descobrir quais agentes existem.
- Ele **adapta seu prompt e roteamento** com base nessa descoberta.
- Quando um novo agente é adicionado ao registro, o Orquestrador **automaticamente o incorpora** sem modificações no código.

### 3.3 Analogia

**Orquestrador V4.0 (Estático):**  
Um gerente que conhece sua equipe de cor. Se um novo membro entra, ele precisa "reprogramar" sua memória.

**Orquestrador V5.0 (Dinâmico):**  
Um líder que consulta um diretório de talentos sempre atualizado. Se um novo membro entra, ele simplesmente aparece no diretório na próxima consulta.

---

## 4. PROPOSTA: AGENT REGISTRY

### 4.1 Visão Geral

A solução proposta é a criação de uma **tabela de registro de agentes** (`agent_registry`) no banco de dados PostgreSQL. Esta tabela serve como o **"diretório de talentos"** do sistema, contendo todas as informações necessárias para que o Orquestrador descubra e interaja com os agentes especialistas.

### 4.2 Schema da Tabela `agent_registry`

```sql
CREATE TABLE agent_registry (
    agent_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    webhook_url VARCHAR(512) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    version VARCHAR(20) DEFAULT '1.0.0',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    metadata JSONB DEFAULT '{}'::jsonb,
    
    -- Índices para otimização
    CONSTRAINT unique_agent_id UNIQUE (agent_id)
);

CREATE INDEX idx_agent_registry_active ON agent_registry(is_active);
CREATE INDEX idx_agent_registry_version ON agent_registry(version);
```

### 4.3 Descrição dos Campos

| Campo | Tipo | Obrigatório | Descrição | Exemplo |
| :--- | :--- | :--- | :--- | :--- |
| `agent_id` | `VARCHAR(50)` | Sim | Identificador único do agente (PK). Usado para referenciar o agente em todo o sistema. | `"demographic"` |
| `name` | `VARCHAR(255)` | Sim | Nome legível do agente para exibição. | `"Agente Demográfico"` |
| `description` | `TEXT` | Sim | **Descrição detalhada da especialidade do agente.** Esta descrição é usada pela IA para decidir quando acionar o agente. Deve ser clara e específica. | `"Especializado em análises de dinâmica populacional, incluindo crescimento demográfico, densidade populacional, pirâmide etária, fluxos migratórios, taxas de natalidade e mortalidade, e projeções populacionais."` |
| `webhook_url` | `VARCHAR(512)` | Sim | URL completa do webhook do agente. | `"https://galactic-ai.app.n8n.cloud/webhook/agent-demographic"` |
| `is_active` | `BOOLEAN` | Não | Flag para ativar/desativar o agente sem removê-lo do registro. Agentes inativos não são considerados pelo Orquestrador. | `true` |
| `version` | `VARCHAR(20)` | Não | Versão do agente, útil para rastreamento e debugging. | `"1.2.0"` |
| `created_at` | `TIMESTAMP` | Não | Data/hora de criação do registro. | `2025-12-08 15:30:00` |
| `updated_at` | `TIMESTAMP` | Não | Data/hora da última atualização. | `2025-12-08 15:30:00` |
| `metadata` | `JSONB` | Não | Campos adicionais em formato JSON (ex: autor, tags, dependências). | `{"author": "Henrique M. Ribeiro", "tags": ["population", "census"]}` |

### 4.4 Dados Iniciais (Seed Data)

Para popular a tabela com os agentes atuais:

```sql
INSERT INTO agent_registry (agent_id, name, description, webhook_url, is_active, version) VALUES
(
    'economic',
    'Agente Econômico',
    'Especializado em análises econômicas, incluindo PIB, PIB per capita, emprego, desemprego, renda, pobreza, estrutura setorial da economia, investimentos, finanças públicas e indicadores de desenvolvimento econômico.',
    'https://galactic-ai.app.n8n.cloud/webhook/agent-econ',
    TRUE,
    '6.1.0'
),
(
    'social',
    'Agente Social',
    'Especializado em análises sociais, incluindo educação (matrículas, IDEB, analfabetismo), saúde (mortalidade infantil, leitos hospitalares, cobertura vacinal), IDH, IDHM, desigualdade social, programas sociais e qualidade de vida.',
    'https://galactic-ai.app.n8n.cloud/webhook/agent-social',
    TRUE,
    '6.1.0'
),
(
    'terra',
    'Agente Territorial',
    'Especializado em análises territoriais e de infraestrutura, incluindo urbanização, saneamento básico, mobilidade urbana, habitação, uso e ocupação do solo, planejamento urbano e infraestrutura de transportes.',
    'https://galactic-ai.app.n8n.cloud/webhook/agent-terra',
    TRUE,
    '6.1.0'
),
(
    'ambient',
    'Agente Ambiental',
    'Especializado em análises ambientais, incluindo desmatamento, queimadas, recursos hídricos, unidades de conservação, biodiversidade, mudanças climáticas, gestão de resíduos e sustentabilidade ambiental.',
    'https://galactic-ai.app.n8n.cloud/webhook/agent-ambient',
    TRUE,
    '6.1.0'
);
```

---

## 5. ARQUITETURA DO ORQUESTRADOR V5.0

### 5.1 Fluxo de Trabalho Completo

```
Webhook → Validação → Buscar Território → Gerar request_id
    ↓
[NOVO] PostgreSQL - Buscar Agentes Ativos
    ↓
[NOVO] Code - Preparar Contexto Dinâmico
    ↓
OpenAI - Interpretar Pergunta (Prompt Dinâmico)
    ↓
[NOVO] Loop Over Items (Itera sobre agent_ids)
    ├─→ [NOVO] PostgreSQL - Buscar URL do Agente
    └─→ HTTP Request - Chamar Agente (URL Dinâmica)
    ↓
Agregar Respostas → Sintetizar → Salvar → Responder
```

### 5.2 Detalhamento dos Novos Nós

#### Nó 1: PostgreSQL - Buscar Agentes Ativos

**Tipo:** PostgreSQL  
**Operação:** Execute Query  
**Posição no Fluxo:** Logo após "Gerar request_id"

**Query:**
```sql
SELECT 
    agent_id, 
    name, 
    description, 
    webhook_url 
FROM agent_registry 
WHERE is_active = TRUE
ORDER BY agent_id;
```

**Output:**
```json
[
    {
        "agent_id": "ambient",
        "name": "Agente Ambiental",
        "description": "Especializado em análises ambientais...",
        "webhook_url": "https://.../webhook/agent-ambient"
    },
    {
        "agent_id": "economic",
        "name": "Agente Econômico",
        "description": "Especializado em análises econômicas...",
        "webhook_url": "https://.../webhook/agent-econ"
    },
    ...
]
```

#### Nó 2: Code - Preparar Contexto Dinâmico

**Tipo:** Code (JavaScript)  
**Operação:** Formatar dados para o prompt da IA

**Código:**
```javascript
// Recebe a lista de agentes do nó anterior
const agents = $input.all();

// Formata a descrição de cada agente para o prompt
const agentDescriptions = agents.map(agent => {
    const data = agent.json;
    return `- **${data.agent_id}**: ${data.description}`;
}).join('\n');

// Cria um mapa de agent_id → webhook_url para uso posterior
const agentMap = {};
agents.forEach(agent => {
    const data = agent.json;
    agentMap[data.agent_id] = {
        name: data.name,
        webhook_url: data.webhook_url
    };
});

return [{
    json: {
        agent_context: agentDescriptions,
        agent_map: agentMap,
        agent_count: agents.length
    }
}];
```

**Output:**
```json
{
    "agent_context": "- **ambient**: Especializado em análises ambientais...\n- **economic**: Especializado em análises econômicas...\n...",
    "agent_map": {
        "ambient": {"name": "Agente Ambiental", "webhook_url": "https://..."},
        "economic": {"name": "Agente Econômico", "webhook_url": "https://..."},
        ...
    },
    "agent_count": 4
}
```

#### Nó 3: OpenAI - Interpretar Pergunta (Modificado)

**Tipo:** OpenAI  
**Modelo:** gpt-4.1-mini  
**Operação:** Gerar resposta estruturada

**Prompt Dinâmico:**
```
Você é o Meta-LLM Orchestrator do Framework de Inteligência Territorial do Tocantins.

Sua tarefa é analisar a pergunta do usuário e determinar qual(is) agente(s) especialista(s) deve(m) ser acionado(s) para responder.

**PERGUNTA DO USUÁRIO:**
"{{ $('Webhook - Recebe Requisição').first().json.body.question }}"

**TERRITÓRIO:**
{{ $('PostgreSQL - Buscar Território').first().json.name }} (ID: {{ $('Webhook - Recebe Requisição').first().json.body.territory_id }})

**AGENTES DISPONÍVEIS:**
{{ $('Code - Preparar Contexto Dinâmico').first().json.agent_context }}

**INSTRUÇÕES:**
1. Analise a pergunta e identifique quais agentes são relevantes.
2. Retorne APENAS um array JSON com os `agent_id`s dos agentes selecionados.
3. Se a pergunta envolve múltiplas dimensões, retorne múltiplos agent_ids.
4. Se a pergunta envolve comparação entre territórios, identifique os territórios e retorne os agentes relevantes.

**FORMATO DE RESPOSTA (JSON):**
{
    "agent_ids": ["agent_id_1", "agent_id_2"],
    "analysis_scope": "unidimensional" | "multidimensional",
    "territory_scope": "uniterritorial" | "multiterritorial",
    "territories": [{"id": "1721000", "name": "Palmas"}],
    "reasoning": "Breve explicação da escolha"
}
```

**Response Format:** JSON

**Output Esperado:**
```json
{
    "agent_ids": ["economic", "social"],
    "analysis_scope": "multidimensional",
    "territory_scope": "uniterritorial",
    "territories": [{"id": "1721000", "name": "Palmas"}],
    "reasoning": "A pergunta sobre PIB e educação requer análise econômica e social."
}
```

#### Nó 4: Loop Over Items (Novo)

**Tipo:** Loop Over Items  
**Operação:** Iterar sobre o array `agent_ids`

**Configuração:**
- **Input:** `{{ $('OpenAI - Interpretar Pergunta').first().json.agent_ids }}`
- **Batch Size:** 1 (processar um agente por vez)

#### Nó 5: Code - Buscar URL do Agente (Dentro do Loop)

**Tipo:** Code (JavaScript)  
**Operação:** Obter a URL do webhook do agente atual

**Código:**
```javascript
const currentAgentId = $input.first().json;
const agentMap = $('Code - Preparar Contexto Dinâmico').first().json.agent_map;

const agentInfo = agentMap[currentAgentId];

if (!agentInfo) {
    throw new Error(`Agente ${currentAgentId} não encontrado no registro.`);
}

return [{
    json: {
        agent_id: currentAgentId,
        agent_name: agentInfo.name,
        webhook_url: agentInfo.webhook_url,
        request_id: $('Code - Gerar request_id').first().json.request_id,
        territory_id: $('Webhook - Recebe Requisição').first().json.body.territory_id,
        territory_name: $('PostgreSQL - Buscar Território').first().json.name,
        question: $('Webhook - Recebe Requisição').first().json.body.question,
        analysis_scope: $('OpenAI - Interpretar Pergunta').first().json.analysis_scope,
        territory_scope: $('OpenAI - Interpretar Pergunta').first().json.territory_scope
    }
}];
```

#### Nó 6: HTTP Request - Chamar Agente (Genérico, Dentro do Loop)

**Tipo:** HTTP Request  
**Método:** POST  
**URL:** `{{ $json.webhook_url }}` (Dinâmica!)

**Body:**
```json
{
    "request_id": "{{ $json.request_id }}",
    "agent_id": "{{ $json.agent_id }}",
    "territory_id": "{{ $json.territory_id }}",
    "territory_name": "{{ $json.territory_name }}",
    "question": "{{ $json.question }}",
    "analysis_scope": "{{ $json.analysis_scope }}",
    "territory_scope": "{{ $json.territory_scope }}"
}
```

---

## 6. PROCESSO DE ADIÇÃO DE NOVOS AGENTES

### 6.1 Passo a Passo Simplificado

Com o Orquestrador V5.0, adicionar um novo agente especialista se torna um processo de **configuração**, não de **codificação**:

**Passo 1: Desenvolver o Novo Agente**
- Crie o workflow do novo agente no n8n (ex: `WF-AGENT-DEMOGRAPHIC`).
- Garanta que ele segue o padrão de entrada/saída dos outros agentes.
- Teste o agente isoladamente.

**Passo 2: Registrar o Agente no Agent Registry**
```sql
INSERT INTO agent_registry (agent_id, name, description, webhook_url, is_active, version)
VALUES (
    'demographic',
    'Agente Demográfico',
    'Especializado em análises de dinâmica populacional, incluindo crescimento demográfico, densidade populacional, pirâmide etária, fluxos migratórios, taxas de natalidade e mortalidade, e projeções populacionais.',
    'https://galactic-ai.app.n8n.cloud/webhook/agent-demographic',
    TRUE,
    '1.0.0'
);
```

**Passo 3: Pronto!**
- Na próxima execução, o Orquestrador V5.0 automaticamente:
  - Descobrirá o novo agente.
  - Incluirá sua descrição como uma opção para a IA.
  - Saberá como chamá-lo se a pergunta do usuário for relevante.

**Tempo estimado:** 5 minutos (apenas o INSERT SQL).  
**Risco:** Baixo (não há modificação no workflow do Orquestrador).

### 6.2 Comparação: V4.0 vs. V5.0

| Aspecto | Orquestrador V4.0 | Orquestrador V5.0 |
| :--- | :--- | :--- |
| **Adicionar Agente** | Modificar workflow (30-45 min) | Inserir registro SQL (5 min) |
| **Conhecimento Técnico** | Alto (n8n, JavaScript) | Baixo (SQL básico) |
| **Risco de Erro** | Alto (modificação manual) | Baixo (operação isolada) |
| **Escalabilidade** | Linear (cresce com agentes) | Constante (não muda) |
| **Quem Pode Fazer** | Apenas desenvolvedores | Analistas, administradores |

---

## 7. BENEFÍCIOS E IMPACTOS

### 7.1 Benefícios Técnicos

1. **Extensibilidade:** Adicionar novos agentes é trivial.
2. **Manutenibilidade:** Mudanças em URLs ou descrições não requerem modificar o workflow.
3. **Escalabilidade:** O sistema suporta dezenas de agentes sem aumento de complexidade.
4. **Robustez:** Menos pontos de falha (não há IFs hard-coded).
5. **Testabilidade:** Agentes podem ser ativados/desativados facilmente para testes.

### 7.2 Benefícios Organizacionais

1. **Democratização:** Não-desenvolvedores podem adicionar agentes.
2. **Agilidade:** Novos agentes podem ser lançados rapidamente.
3. **Governança:** O `agent_registry` serve como um catálogo oficial de agentes.
4. **Auditoria:** Histórico de versões e metadados facilitam a rastreabilidade.

### 7.3 Benefícios Estratégicos

1. **Ecossistema de Agentes:** Facilita a criação de um marketplace de agentes.
2. **Colaboração:** Diferentes equipes podem desenvolver agentes independentemente.
3. **Inovação:** Reduz a barreira para experimentação com novos tipos de análise.

---

## 8. ROADMAP DE IMPLEMENTAÇÃO

### 8.1 Fase 1: Preparação do Banco de Dados (1 hora)

**Tarefas:**
1. Criar a tabela `agent_registry`.
2. Popular com os 4 agentes atuais (ECON, SOCIAL, TERRA, AMBIENT).
3. Validar os dados com queries de teste.

**Critérios de Conclusão:**
- Tabela criada e populada.
- Query `SELECT * FROM agent_registry WHERE is_active = TRUE` retorna 4 registros.

### 8.2 Fase 2: Desenvolvimento do Orquestrador V5.0 (3-4 horas)

**Tarefas:**
1. Adicionar nó "PostgreSQL - Buscar Agentes Ativos".
2. Adicionar nó "Code - Preparar Contexto Dinâmico".
3. Modificar nó "OpenAI - Interpretar Pergunta" com prompt dinâmico.
4. Substituir os IFs por um "Loop Over Items".
5. Adicionar nó "Code - Buscar URL do Agente" dentro do loop.
6. Modificar nó "HTTP Request - Chamar Agente" para usar URL dinâmica.
7. Testar o fluxo completo.

**Critérios de Conclusão:**
- Workflow V5.0 importado e configurado.
- Teste com pergunta unidimensional bem-sucedido.
- Teste com pergunta multidimensional bem-sucedido.

### 8.3 Fase 3: Testes e Validação (1-2 horas)

**Tarefas:**
1. Executar testes com os 4 agentes atuais.
2. Adicionar um 5º agente de teste (ex: Demographic) ao registro.
3. Validar que o Orquestrador descobre e usa o novo agente automaticamente.
4. Desativar um agente (`is_active = FALSE`) e validar que ele não é mais usado.

**Critérios de Conclusão:**
- Todos os testes passam.
- Novo agente é descoberto e usado automaticamente.
- Agente desativado não é mais considerado.

### 8.4 Fase 4: Documentação e Migração (1 hora)

**Tarefas:**
1. Atualizar documentação do sistema.
2. Criar guia de "Como Adicionar um Novo Agente".
3. Migrar workflows de produção para V5.0.

**Critérios de Conclusão:**
- Documentação atualizada.
- Guia criado e testado.
- Orquestrador V5.0 em produção.

**Tempo Total Estimado:** 6-8 horas

---

## 9. CONSIDERAÇÕES TÉCNICAS

### 9.1 Performance

**Preocupação:** A consulta ao `agent_registry` a cada execução pode adicionar latência?

**Resposta:** Não. A query `SELECT * FROM agent_registry WHERE is_active = TRUE` é extremamente rápida (< 10ms) devido ao índice em `is_active` e ao pequeno número de registros (< 20 agentes esperados).

### 9.2 Cache

**Melhoria Futura:** Implementar cache em memória do `agent_registry` no Orquestrador para reduzir ainda mais a latência. O cache pode ser invalidado a cada N minutos ou quando houver uma mudança no registro.

### 9.3 Versionamento de Agentes

**Preocupação:** Como lidar com múltiplas versões do mesmo agente?

**Resposta:** A tabela `agent_registry` possui um campo `version`. Para suportar múltiplas versões:
1. Adicionar um campo `agent_version_id` como PK composta: `(agent_id, version)`.
2. Modificar a query para selecionar a versão mais recente ou uma versão específica.
3. Permitir que o Orquestrador especifique qual versão usar (ex: para testes A/B).

### 9.4 Segurança

**Preocupação:** Qualquer pessoa com acesso ao banco pode adicionar agentes maliciosos?

**Resposta:** Sim. Mitigações:
1. **Controle de Acesso:** Restringir permissões de INSERT/UPDATE na tabela `agent_registry` apenas para administradores.
2. **Validação de URLs:** Implementar validação de que as URLs dos webhooks pertencem a domínios confiáveis.
3. **Auditoria:** Registrar todas as mudanças no `agent_registry` em uma tabela de auditoria.

---

## 10. CONCLUSÃO

A proposta do **Orquestrador V5.0 com Agent Registry** representa a materialização do conceito de **"Andaimes Arquiteturais Dinâmicos"** emergido na Sessão #13. Ela transforma o Orquestrador de um sistema estático, que conhece seus agentes de cor, em um sistema dinâmico, que **descobre e se adapta** ao ecossistema de agentes disponíveis.

Esta arquitetura não apenas resolve o problema imediato de extensibilidade, mas também **prepara o sistema para o futuro**:

- **Ecossistema de Agentes:** Facilita a criação de dezenas de agentes especializados.
- **Colaboração Distribuída:** Diferentes equipes podem desenvolver agentes independentemente.
- **Inovação Contínua:** Novos tipos de análise podem ser adicionados sem reescrever o núcleo do sistema.

O Orquestrador V5.0 é um sistema projetado não apenas para **funcionar**, mas para **crescer e evoluir** com as necessidades do projeto.

---

**Próxima Sessão Sugerida:** Implementação do Orquestrador V5.0 e teste com um novo agente (ex: Agente Demográfico).

**Status:** Proposta aprovada e pronta para implementação.

---

## APÊNDICE A: Script SQL Completo

```sql
-- =====================================================
-- SCRIPT DE CRIAÇÃO DO AGENT REGISTRY
-- Framework de Inteligência Territorial V6.0
-- Data: 08/12/2025
-- Versão: 1.0.0
-- =====================================================

-- Criar tabela agent_registry
CREATE TABLE IF NOT EXISTS agent_registry (
    agent_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    webhook_url VARCHAR(512) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    version VARCHAR(20) DEFAULT '1.0.0',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    metadata JSONB DEFAULT '{}'::jsonb,
    
    CONSTRAINT unique_agent_id UNIQUE (agent_id)
);

-- Criar índices
CREATE INDEX IF NOT EXISTS idx_agent_registry_active ON agent_registry(is_active);
CREATE INDEX IF NOT EXISTS idx_agent_registry_version ON agent_registry(version);

-- Popular com agentes atuais
INSERT INTO agent_registry (agent_id, name, description, webhook_url, is_active, version, metadata) VALUES
(
    'economic',
    'Agente Econômico',
    'Especializado em análises econômicas, incluindo PIB, PIB per capita, emprego, desemprego, renda, pobreza, estrutura setorial da economia, investimentos, finanças públicas e indicadores de desenvolvimento econômico.',
    'https://galactic-ai.app.n8n.cloud/webhook/agent-econ',
    TRUE,
    '6.1.0',
    '{"author": "Henrique M. Ribeiro", "tags": ["economy", "employment", "income"]}'::jsonb
),
(
    'social',
    'Agente Social',
    'Especializado em análises sociais, incluindo educação (matrículas, IDEB, analfabetismo), saúde (mortalidade infantil, leitos hospitalares, cobertura vacinal), IDH, IDHM, desigualdade social, programas sociais e qualidade de vida.',
    'https://galactic-ai.app.n8n.cloud/webhook/agent-social',
    TRUE,
    '6.1.0',
    '{"author": "Henrique M. Ribeiro", "tags": ["education", "health", "social"]}'::jsonb
),
(
    'terra',
    'Agente Territorial',
    'Especializado em análises territoriais e de infraestrutura, incluindo urbanização, saneamento básico, mobilidade urbana, habitação, uso e ocupação do solo, planejamento urbano e infraestrutura de transportes.',
    'https://galactic-ai.app.n8n.cloud/webhook/agent-terra',
    TRUE,
    '6.1.0',
    '{"author": "Henrique M. Ribeiro", "tags": ["urban", "infrastructure", "housing"]}'::jsonb
),
(
    'ambient',
    'Agente Ambiental',
    'Especializado em análises ambientais, incluindo desmatamento, queimadas, recursos hídricos, unidades de conservação, biodiversidade, mudanças climáticas, gestão de resíduos e sustentabilidade ambiental.',
    'https://galactic-ai.app.n8n.cloud/webhook/agent-ambient',
    TRUE,
    '6.1.0',
    '{"author": "Henrique M. Ribeiro", "tags": ["environment", "sustainability", "conservation"]}'::jsonb
);

-- Verificar dados inseridos
SELECT * FROM agent_registry ORDER BY agent_id;
```

---

## APÊNDICE B: Exemplo de Novo Agente (Demographic)

```sql
-- Adicionar Agente Demográfico
INSERT INTO agent_registry (agent_id, name, description, webhook_url, is_active, version, metadata) VALUES
(
    'demographic',
    'Agente Demográfico',
    'Especializado em análises de dinâmica populacional, incluindo crescimento demográfico, densidade populacional, pirâmide etária, fluxos migratórios, taxas de natalidade e mortalidade, projeções populacionais e transição demográfica.',
    'https://galactic-ai.app.n8n.cloud/webhook/agent-demographic',
    TRUE,
    '1.0.0',
    '{"author": "Henrique M. Ribeiro", "tags": ["population", "demographics", "census"]}'::jsonb
);
```

---

**Fim do Documento**
