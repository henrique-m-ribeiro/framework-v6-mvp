# 🗺️ Análise: Suporte a Múltiplos Territórios e Análises Comparativas

## Resumo Executivo

**RESPOSTA DIRETA**: ❌ **O design atual NÃO suporta plenamente análises multiterritoriais**

**LIMITAÇÕES IDENTIFICADAS**:
1. ⚠️ Prompt da OpenAI retorna apenas **1 território** (`territory` objeto, não array)
2. ⚠️ Nó Set converte `territory` em array de 1 elemento: `[$json.territory]`
3. ⚠️ HTTP Request envia `territories[0]`, assumindo sempre 1 território
4. ⚠️ Agentes não estão preparados para receber múltiplos territórios

**BOA NOTÍCIA**: ✅ A arquitetura foi **projetada** para suportar isso (campos `territories`, `territory_scope` existem), mas a **implementação** está incompleta.

---

## 1. Análise do Design Atual

### 1.1. Prompt da OpenAI (Atual)

```
FORMATO DE RESPOSTA (JSON):
{
  "status": "valid" | "invalid",
  "territory": {           // ❌ SINGULAR - apenas 1 território
    "id": "TO",
    "name": "Tocantins"
  },
  "selected_agents": ["econ", "social"],
  ...
}
```

**Problema**: O prompt instrui a OpenAI a retornar apenas **1 território** (objeto singular).

**Para análises comparativas**, deveria ser:

```json
{
  "territories": [         // ✅ PLURAL - array de territórios
    {"id": "1721000", "name": "Palmas"},
    {"id": "1702109", "name": "Araguaína"},
    {"id": "1705508", "name": "Gurupi"}
  ],
  "territory_scope": "multiterritorial",  // ✅ Indica análise comparativa
  ...
}
```

---

### 1.2. Nó "Set - Criar Payload V4" (Atual)

```javascript
{
  "territory": "={{ $json.territory }}",              // Objeto singular
  "territory_id": "={{ $json.territory.id }}",        // ID do único território
  "territory_name": "={{ $json.territory.name }}",    // Nome do único território
  "territories": "={{ [$json.territory] }}"           // ❌ Array forçado com 1 elemento
}
```

**Problema**: Converte `territory` (objeto) em `territories` (array de 1 elemento).

**Para análises comparativas**, deveria ser:

```javascript
{
  "territories": "={{ $json.territories }}",          // ✅ Array direto da OpenAI
  "territory_scope": "={{ $json.territory_scope }}",  // ✅ "multiterritorial"
  "primary_territory_id": "={{ $json.territories[0].id }}",  // ✅ Território principal
}
```

---

### 1.3. HTTP Request - Chamar Agente (Atual)

```javascript
{
  "agent_id": "{{ $json.current_agent.agent_id }}",
  "territory_id": "{{ $json.territories[0].id }}",      // ❌ Sempre o primeiro
  "territory_name": "{{ $json.territories[0].name }}",  // ❌ Sempre o primeiro
  "territories": {{ JSON.stringify($json.territories) }},  // ✅ Array completo
  ...
}
```

**Problema**: Envia `territory_id` e `territory_name` do **primeiro território apenas**, mas envia o array completo em `territories`.

**Inconsistência**: Agentes podem se confundir sobre qual território analisar.

---

### 1.4. Agentes (ECON, SOCIAL, etc.)

**Estrutura esperada pelos agentes** (baseado nos workflows corrigidos):

```javascript
{
  "task_id": "...",
  "territory_id": "TO",        // ❌ Esperam 1 território apenas
  "territory_name": "Tocantins",
  "question": "...",
  "parameters": {...}
}
```

**Problema**: Agentes não têm lógica para processar múltiplos territórios.

---

## 2. Casos de Uso Desejados

### Caso 1: Análise Comparativa entre Municípios

**Pergunta**: "Compare os indicadores econômicos de Palmas, Araguaína e Gurupi"

**Comportamento esperado**:
1. OpenAI identifica 3 territórios
2. Retorna `territories: [{id: "1721000", name: "Palmas"}, ...]`
3. Retorna `territory_scope: "multiterritorial"`
4. Agente ECON recebe os 3 territórios
5. Agente analisa os 3 e faz comparação
6. Síntese final integra as comparações

**Comportamento atual**:
- ❌ OpenAI retornaria apenas 1 território (o primeiro mencionado)
- ❌ Agente receberia apenas 1 território
- ❌ Não há comparação

---

### Caso 2: Análise de Microrregiões

**Pergunta**: "Analise os desafios sociais da microrregião de Porto Nacional"

**Comportamento esperado**:
1. OpenAI identifica a microrregião
2. Busca no banco de dados os municípios da microrregião
3. Retorna `territories: [{id: "1718001", name: "Porto Nacional"}, {id: "...", name: "..."}, ...]`
4. Retorna `territory_scope: "microregional"`
5. Agente SOCIAL recebe todos os municípios
6. Agente analisa a microrregião como um todo
7. Síntese final apresenta visão integrada

**Comportamento atual**:
- ❌ OpenAI não tem informações sobre microrregiões
- ❌ Não há busca de municípios por microrregião
- ❌ Agente receberia apenas 1 município

---

### Caso 3: Soluções Integradas para Problemas Comuns

**Pergunta**: "Quais soluções integradas podem resolver os problemas de saúde pública nas cidades do Bico do Papagaio?"

**Comportamento esperado**:
1. OpenAI identifica a região "Bico do Papagaio"
2. Busca municípios da região
3. Agente SOCIAL analisa problemas comuns
4. Síntese identifica padrões e propõe soluções regionais
5. Resposta inclui recomendações para ação conjunta

**Comportamento atual**:
- ❌ OpenAI não reconhece regiões informais
- ❌ Não há mapeamento de regiões para municípios
- ❌ Análise seria limitada a 1 município

---

## 3. Mudanças Necessárias para Suporte Multiterritorial

### 3.1. Atualizar Prompt da OpenAI

**Mudanças**:

```
FORMATO DE RESPOSTA (JSON):
{
  "status": "valid" | "invalid",
  "territories": [                    // ✅ MUDANÇA: array de territórios
    {"id": "...", "name": "..."},
    {"id": "...", "name": "..."}
  ],
  "territory_scope": "uniterritorial" | "multiterritorial" | "microregional" | "regional",  // ✅ NOVO
  "selected_agents": ["econ", "social"],
  "agent_tasks": {
    "econ": "Compare os indicadores econômicos de Palmas, Araguaína e Gurupi, identificando padrões e diferenças",  // ✅ Tarefa comparativa
    "social": "..."
  },
  "synthesis_strategy": "Identifique padrões comuns e diferenças entre os territórios, propondo soluções integradas"  // ✅ Estratégia comparativa
}

INSTRUÇÕES ADICIONAIS:
4. Se a pergunta mencionar múltiplos territórios, retorne todos em "territories" como array
5. Se a pergunta mencionar uma microrregião ou região, identifique os municípios correspondentes
6. Defina "territory_scope" como:
   - "uniterritorial": 1 território
   - "multiterritorial": 2+ territórios explicitamente mencionados
   - "microregional": municípios de uma microrregião
   - "regional": municípios de uma região (ex: Bico do Papagaio)
```

---

### 3.2. Atualizar Nó "Set - Criar Payload V4"

**Mudanças**:

```javascript
// ❌ REMOVER
"territory": "={{ $json.territory }}",
"territory_id": "={{ $json.territory.id }}",
"territory_name": "={{ $json.territory.name }}",
"territories": "={{ [$json.territory] }}"

// ✅ ADICIONAR
"territories": "={{ $json.territories }}",  // Array direto da OpenAI
"territory_scope": "={{ $json.territory_scope }}",
"primary_territory_id": "={{ $json.territories[0].id }}",  // Para request_id
"territory_count": "={{ $json.territories.length }}"  // Útil para logs
```

---

### 3.3. Atualizar HTTP Request - Chamar Agente

**Mudanças**:

```javascript
{
  "agent_id": "{{ $json.current_agent.agent_id }}",
  "task_id": "{{ $json.request_id }}",
  
  // ✅ MUDANÇA: Remover territory_id e territory_name singulares
  // "territory_id": "{{ $json.territories[0].id }}",  // ❌ REMOVER
  // "territory_name": "{{ $json.territories[0].name }}",  // ❌ REMOVER
  
  // ✅ MUDANÇA: Enviar array completo e scope
  "territories": {{ JSON.stringify($json.territories) }},
  "territory_scope": "{{ $json.territory_scope }}",
  
  "question": "{{ $json.question }}",
  "agent_task": "{{ $json.agent_tasks[$json.current_agent.agent_id] }}",  // ✅ Tarefa específica (pode ser comparativa)
  
  "parameters": {
    "time_period": "{{ $json.time_period }}",
    "detail_level": "{{ $json.detail_level }}"
  }
}
```

---

### 3.4. Atualizar Agentes (ECON, SOCIAL, etc.)

**Mudanças necessárias em TODOS os agentes**:

#### Nó "Normalizar Entrada"

```javascript
const webhookData = $input.first().json;

// ✅ MUDANÇA: Suportar array de territórios
const territories = webhookData.territories || [];
const territoryScope = webhookData.territory_scope || 'uniterritorial';

// ✅ MUDANÇA: Identificar território principal
const primaryTerritory = territories[0] || { id: 'unknown', name: 'Unknown' };

return {
  json: {
    task_id: webhookData.task_id || `task_${Date.now()}`,
    agent_id: webhookData.agent_id,
    
    // ✅ MUDANÇA: Campos multiterritoriais
    territories: territories,
    territory_scope: territoryScope,
    territory_count: territories.length,
    
    // ✅ MANTER: Para compatibilidade com código legado
    territory_id: primaryTerritory.id,
    territory_name: primaryTerritory.name,
    
    question: webhookData.question,
    agent_task: webhookData.agent_task || null,  // ✅ NOVO: tarefa específica
    parameters: webhookData.parameters || {}
  }
};
```

#### Nó "Preparar Contexto para LLM"

```javascript
const normalizedData = $('Normalizar Entrada').first().json;

// ✅ MUDANÇA: Prompt adaptado ao scope territorial
let territorialContext = '';

if (normalizedData.territory_scope === 'uniterritorial') {
  territorialContext = `Território: ${normalizedData.territories[0].name} (ID: ${normalizedData.territories[0].id})`;
} else if (normalizedData.territory_scope === 'multiterritorial') {
  const territoryList = normalizedData.territories.map(t => `${t.name} (${t.id})`).join(', ');
  territorialContext = `Territórios para análise comparativa: ${territoryList}`;
} else if (normalizedData.territory_scope === 'microregional' || normalizedData.territory_scope === 'regional') {
  const territoryList = normalizedData.territories.map(t => t.name).join(', ');
  territorialContext = `Região composta por: ${territoryList}`;
}

const prompt = `
Você é um agente especializado em análise ${normalizedData.agent_id}.

${territorialContext}

Pergunta do usuário: ${normalizedData.question}

${normalizedData.agent_task ? `Tarefa específica: ${normalizedData.agent_task}` : ''}

${normalizedData.territory_scope !== 'uniterritorial' ? `
IMPORTANTE: Esta é uma análise ${normalizedData.territory_scope}. 
- Analise CADA território individualmente
- Identifique PADRÕES COMUNS entre os territórios
- Identifique DIFERENÇAS significativas
- Proponha SOLUÇÕES INTEGRADAS quando aplicável
` : ''}

Período de análise: ${normalizedData.parameters.time_period || '2019-2023'}

Forneça uma análise completa e baseada em dados.
`;

return {
  json: {
    prompt: prompt,
    metadata: normalizedData
  }
};
```

---

### 3.5. Adicionar Tabela de Microrregiões/Regiões

**Nova tabela no banco de dados**:

```sql
CREATE TABLE territorial_regions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  region_name VARCHAR(255) NOT NULL,
  region_type VARCHAR(50) NOT NULL,  -- 'microrregiao', 'regiao_planejamento', 'regiao_informal'
  territory_ids TEXT[] NOT NULL,  -- Array de IDs dos territórios
  metadata JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Exemplo de dados
INSERT INTO territorial_regions (region_name, region_type, territory_ids, metadata) VALUES
('Bico do Papagaio', 'regiao_informal', ARRAY['1700251', '1701903', '1702554', '1707108', '1709302'], 
 '{"description": "Região norte do Tocantins, fronteira com Pará e Maranhão"}'::jsonb),
 
('Porto Nacional', 'microrregiao', ARRAY['1718001', '1703206', '1713205', '1721257'],
 '{"ibge_code": "17002"}'::jsonb);
```

**Novo nó no Orquestrador**: "PostgreSQL - Buscar Região"

```sql
SELECT 
  region_name,
  region_type,
  territory_ids,
  metadata
FROM territorial_regions
WHERE 
  LOWER(region_name) = LOWER('{{ $json.request.region_query }}')
  OR '{{ $json.request.region_query }}' = ANY(metadata->'aliases')
LIMIT 1;
```

---

## 4. Fluxo Atualizado para Análises Multiterritoriais

```
Webhook - Recebe Requisição
  ↓
PostgreSQL - Listar Territórios Disponíveis
  ↓
PostgreSQL - Buscar Agentes Ativos
  ↓
[NOVO] PostgreSQL - Listar Regiões/Microrregiões  ← NOVO
  ↓
Código - Preparar Contexto Dinâmico (inclui regiões)
  ↓
OpenAI - Interpretar Requisição (retorna territories array)
  ↓
Código - Parsear Resposta OpenAI
  ↓
IF - Requisição Válida?
  ├─ TRUE → Set - Criar Payload V4 (territories array)
  │           ↓
  │         Split Out (loop sobre selected_agents)
  │           ↓
  │         Code - Buscar URL do Agente
  │           ↓
  │         HTTP Request (envia territories array + territory_scope)
  │           ↓
  │         Agente processa múltiplos territórios
  │           ↓
  │         Aggregate
  │           ↓
  │         Code - Agregar Respostas
  │           ↓
  │         OpenAI - Sintetizar (síntese comparativa)
  │           ↓
  │         Respond to Webhook
  │
  └─ FALSE → Respond to Webhook - Erro de Validação
```

---

## 5. Exemplos de Uso Após Implementação

### Exemplo 1: Comparação Simples

**Input**:
```json
{
  "question": "Compare o PIB per capita de Palmas e Araguaína"
}
```

**OpenAI retorna**:
```json
{
  "status": "valid",
  "territories": [
    {"id": "1721000", "name": "Palmas"},
    {"id": "1702109", "name": "Araguaína"}
  ],
  "territory_scope": "multiterritorial",
  "selected_agents": ["econ"],
  "agent_tasks": {
    "econ": "Compare o PIB per capita de Palmas e Araguaína entre 2019-2023, identificando tendências e fatores explicativos"
  }
}
```

**Agente ECON recebe**:
```json
{
  "territories": [
    {"id": "1721000", "name": "Palmas"},
    {"id": "1702109", "name": "Araguaína"}
  ],
  "territory_scope": "multiterritorial",
  "agent_task": "Compare o PIB per capita...",
  ...
}
```

**Agente ECON analisa**:
- PIB per capita de Palmas: R$ 32.500
- PIB per capita de Araguaína: R$ 28.100
- Diferença: 15,6%
- Fatores: Palmas é capital, concentra serviços públicos e comércio

---

### Exemplo 2: Microrregião

**Input**:
```json
{
  "question": "Quais são os principais desafios de saúde na microrregião de Porto Nacional?"
}
```

**OpenAI retorna**:
```json
{
  "status": "valid",
  "territories": [
    {"id": "1718001", "name": "Porto Nacional"},
    {"id": "1703206", "name": "Brejinho de Nazaré"},
    {"id": "1713205", "name": "Monte do Carmo"},
    {"id": "1721257", "name": "Silvanópolis"}
  ],
  "territory_scope": "microregional",
  "selected_agents": ["social"],
  "synthesis_strategy": "Identifique desafios comuns e específicos, propondo soluções regionais integradas"
}
```

---

## 6. Priorização de Implementação

### Fase 1: Fundação (CRÍTICO)
1. ✅ Atualizar prompt da OpenAI para retornar `territories` array
2. ✅ Atualizar nó Set para capturar `territories` array
3. ✅ Atualizar HTTP Request para enviar `territories` array
4. ✅ Testar com 2 territórios explícitos

**Tempo estimado**: 30-45 minutos

---

### Fase 2: Agentes Multiterritoriais (IMPORTANTE)
1. ✅ Atualizar nó "Normalizar Entrada" de todos os agentes
2. ✅ Atualizar nó "Preparar Contexto para LLM" de todos os agentes
3. ✅ Testar análise comparativa com ECON e SOCIAL

**Tempo estimado**: 1-2 horas

---

### Fase 3: Microrregiões e Regiões (DESEJÁVEL)
1. ✅ Criar tabela `territorial_regions`
2. ✅ Popular com dados de microrregiões do IBGE
3. ✅ Popular com regiões informais (Bico do Papagaio, etc.)
4. ✅ Adicionar nó "PostgreSQL - Listar Regiões"
5. ✅ Atualizar prompt da OpenAI para reconhecer regiões
6. ✅ Testar análise microregional

**Tempo estimado**: 2-3 horas

---

## 7. Conclusão

**RESPOSTA FINAL**: 

❌ **O design atual NÃO suporta análises multiterritoriais**, mas:

✅ **A arquitetura foi PROJETADA para isso** (campos existem, conceitos estão presentes)

✅ **É TOTALMENTE VIÁVEL implementar** com as mudanças propostas

✅ **Recomendação**: Implementar em **3 fases** (Fundação → Agentes → Regiões)

**PRÓXIMO PASSO SUGERIDO**: Implementar Fase 1 (30-45 min) e testar com uma pergunta comparativa simples.
