# Configuração do Nó OpenAI Atualizado (n8n V2)

**Framework de Inteligência Territorial V6.0**  
**Data:** 08 de dezembro de 2025  
**Sessão:** #14  
**Versão do Nó:** OpenAI V2 (n8n 1.117.0+)

---

## 🔄 MUDANÇAS IMPORTANTES

O n8n versão 1.117.0 introduziu o **OpenAI node V2** que:

- ✅ Suporta a **OpenAI Responses API**
- ✅ Renomeia "Message a Model" para **"Generate a Chat Completion"**
- ✅ Introduz nova operação **"Generate a Model Response"**
- ❌ Remove suporte à API de Assistants (deprecated)

---

## 📋 CONFIGURAÇÃO PARA O ORQUESTRADOR

### Operação: Generate a Chat Completion

**Parâmetros Principais:**

1. **Credential to connect with**
   - Tipo: OpenAI API
   - Ação: Selecione suas credenciais da OpenAI

2. **Resource**
   - Valor: `Text`

3. **Operation**
   - Valor: `Generate a Chat Completion`

4. **Model**
   - Recomendado: `gpt-4o-mini` (velocidade + custo)
   - Alternativa: `gpt-4o` (inteligência máxima)
   - Atual no projeto: `gpt-4.1-mini` (se disponível)

5. **Messages** (NOVO - Estrutura de Roles)
   - Tipo: Array de mensagens
   - Cada mensagem tem:
     - **Text**: Conteúdo da mensagem
     - **Role**: System, User ou Assistant

---

## 🎯 ESTRUTURA DE MENSAGENS COM ROLES

### Role: System

**Função:** Define o comportamento e contexto do modelo

**Quando usar:** 
- Instruções gerais sobre como o modelo deve se comportar
- Contexto que deve ser considerado em todas as respostas
- Regras e restrições

**Exemplo para o Orquestrador V5.0:**
```
Role: System
Text: Você é um especialista em análise de dados territoriais e políticas públicas. 
Sua função é interpretar perguntas de usuários e identificar quais agentes 
especialistas devem ser acionados.

AGENTES DISPONÍVEIS NO SISTEMA:
{{ $json.dynamic_context.dimensions_list }}

Base de territórios disponíveis:
- Palmas: 1721000
- Araguaína: 1702109
- Gurupi: 1709500
- Porto Nacional: 1718204
- Paraíso do Tocantins: 1716109

IMPORTANTE: Use APENAS agent_ids que existem na lista de AGENTES DISPONÍVEIS acima.
```

---

### Role: User

**Função:** Envia a pergunta/prompt do usuário

**Quando usar:**
- A pergunta real do usuário
- Input que precisa de resposta

**Exemplo para o Orquestrador V5.0:**
```
Role: User
Text: {{ $json.question }}
```

---

### Role: Assistant

**Função:** Define tom ou personalidade que o modelo deve adotar

**Quando usar:**
- Exemplos de respostas esperadas
- Definir estilo de comunicação
- Few-shot learning

**Exemplo (opcional para o Orquestrador):**
```
Role: Assistant
Text: {
  "agent_ids": ["economic"],
  "analysis_scope": "unidimensional",
  "territory_scope": "uniterritorial",
  "territories": [{"id": "1721000", "name": "Palmas"}]
}
```

---

## 🔧 CONFIGURAÇÃO COMPLETA PARA O ORQUESTRADOR V5.0

### Nó: "OpenAI - Interpretar Requisição"

**Configuração:**

```yaml
Resource: Text
Operation: Generate a Chat Completion
Model: gpt-4o-mini (ou gpt-4.1-mini se disponível)

Messages:
  - Message 1:
      Role: System
      Text: |
        Você é um especialista em análise de dados territoriais e políticas públicas. 
        Sua função é interpretar perguntas de usuários e identificar quais agentes 
        especialistas devem ser acionados.

        AGENTES DISPONÍVEIS NO SISTEMA:
        {{ $json.dynamic_context.dimensions_list }}

        Base de territórios disponíveis:
        - Palmas: 1721000
        - Araguaína: 1702109
        - Gurupi: 1709500
        - Porto Nacional: 1718204
        - Paraíso do Tocantins: 1716109

        TAREFA:
        Analise a pergunta do usuário e identifique:
        1. Quais agentes devem ser acionados (escolha um ou mais dos agent_ids disponíveis acima)
        2. Se a análise é unidimensional (1 agente) ou multidimensional (2+ agentes)
        3. Se envolve um território (uniterritorial) ou múltiplos territórios (multiterritorial)
        4. Extraia os territórios mencionados

        RESPONDA APENAS COM UM OBJETO JSON NO SEGUINTE FORMATO:
        {
          "agent_ids": ["agent_id1", "agent_id2"],
          "analysis_scope": "unidimensional" ou "multidimensional",
          "territory_scope": "uniterritorial" ou "multiterritorial",
          "territories": [{"id": "1721000", "name": "Palmas"}]
        }

        IMPORTANTE: Use APENAS agent_ids que existem na lista de AGENTES DISPONÍVEIS acima.

  - Message 2:
      Role: User
      Text: {{ $json.question }}

Options:
  - Simplify Output: ON
  - Output Content as JSON: ON
  - Output Randomness (Temperature): 0.3
```

---

## 📊 OPÇÕES RECOMENDADAS

### Para Interpretação de Requisições (Orquestrador)

| Opção | Valor | Justificativa |
|-------|-------|---------------|
| **Simplify Output** | ON | Retorna JSON simplificado |
| **Output Content as JSON** | ON | Força resposta em JSON |
| **Temperature** | 0.3 | Baixa aleatoriedade (consistência) |
| **Maximum Tokens** | 500 | Suficiente para metadados |
| **Frequency Penalty** | 0.0 | Não necessário |
| **Presence Penalty** | 0.0 | Não necessário |

### Para Síntese de Análises (Final do Orquestrador)

| Opção | Valor | Justificativa |
|-------|-------|---------------|
| **Simplify Output** | ON | Retorna texto simplificado |
| **Output Content as JSON** | OFF | Resposta em texto natural |
| **Temperature** | 0.7 | Criatividade moderada |
| **Maximum Tokens** | 2000 | Síntese pode ser longa |
| **Frequency Penalty** | 0.3 | Evita repetições |
| **Presence Penalty** | 0.3 | Incentiva novos tópicos |

---

## 🔄 MIGRAÇÃO DO NÓ ANTIGO PARA O NOVO

### Passo 1: Identificar Nós Antigos

Nós que usam o **OpenAI node V1** (antigo):
- `@n8n/n8n-nodes-langchain.lmChatOpenAi` (tipo antigo)

Devem ser substituídos por:
- `@n8n/n8n-nodes-langchain.openAi` (tipo novo)

---

### Passo 2: Recriar o Nó

**Não é possível apenas "atualizar" o nó antigo. Você deve:**

1. **Deletar o nó antigo**
2. **Adicionar novo nó OpenAI**
3. **Configurar com a nova estrutura de Messages**

---

### Passo 3: Adaptar Mensagens

**ANTES (V1 - Antigo):**
```yaml
messages:
  values:
    - role: system
      content: "Você é um especialista..."
    - role: user
      content: "={{ $json.question }}"
```

**DEPOIS (V2 - Novo):**
```yaml
Messages:
  - Message 1:
      Role: System
      Text: "Você é um especialista..."
  - Message 2:
      Role: User
      Text: "={{ $json.question }}"
```

---

### Passo 4: Ajustar Opções

**ANTES (V1):**
```yaml
options:
  responseFormat: json_object
  temperature: 0.3
```

**DEPOIS (V2):**
```yaml
Options:
  - Output Content as JSON: ON
  - Output Randomness (Temperature): 0.3
```

---

## 🎯 CONFIGURAÇÃO ESPECÍFICA PARA CADA NÓ OPENAI

### 1. Nó: "OpenAI - Interpretar Requisição"

**Localização:** Após "Code - Preparar Contexto Dinâmico"

**Configuração:**
- Resource: `Text`
- Operation: `Generate a Chat Completion`
- Model: `gpt-4o-mini`
- Messages:
  - **System:** Instruções + lista dinâmica de agentes
  - **User:** Pergunta do usuário
- Options:
  - Simplify Output: `ON`
  - Output Content as JSON: `ON`
  - Temperature: `0.3`

**Saída Esperada:**
```json
{
  "agent_ids": ["economic", "social"],
  "analysis_scope": "multidimensional",
  "territory_scope": "uniterritorial",
  "territories": [{"id": "1721000", "name": "Palmas"}]
}
```

---

### 2. Nó: "OpenAI - Sintetizar Análises"

**Localização:** Após "IF - Análise Multidimensional?" (ramo TRUE)

**Configuração:**
- Resource: `Text`
- Operation: `Generate a Chat Completion`
- Model: `gpt-4o-mini`
- Messages:
  - **System:** Instruções para síntese
  - **User:** Análises dos agentes para sintetizar
- Options:
  - Simplify Output: `ON`
  - Output Content as JSON: `OFF`
  - Temperature: `0.7`
  - Maximum Tokens: `2000`

**Exemplo de Mensagens:**

```yaml
Message 1 (System):
  Role: System
  Text: |
    Você é um especialista em síntese de análises territoriais multidimensionais.
    
    Sua tarefa é integrar análises de diferentes dimensões (econômica, social, 
    territorial, ambiental) em uma síntese coerente e integrada.
    
    A síntese deve:
    1. Identificar conexões entre as dimensões
    2. Destacar padrões e tendências transversais
    3. Apontar sinergias e trade-offs
    4. Ser clara e objetiva

Message 2 (User):
  Role: User
  Text: |
    Sintetize as seguintes análises sobre {{ $json.territories[0].name }}:
    
    {{ $json.agent_responses.map(r => `**${r.agent_name}:**\n${r.analysis}`).join('\n\n') }}
```

---

## 📝 EXEMPLO COMPLETO: NÓ OPENAI NO JSON

```json
{
  "parameters": {
    "resource": "text",
    "operation": "generateChatCompletion",
    "model": {
      "__rl": true,
      "value": "gpt-4o-mini",
      "mode": "list"
    },
    "messages": {
      "values": [
        {
          "role": "system",
          "text": "={{ \"Você é um especialista em análise de dados territoriais...\\n\\nAGENTES DISPONÍVEIS:\\n\" + $json.dynamic_context.dimensions_list }}"
        },
        {
          "role": "user",
          "text": "={{ $json.question }}"
        }
      ]
    },
    "options": {
      "simplifyOutput": true,
      "outputContentAsJson": true,
      "temperature": 0.3,
      "maxTokens": 500
    }
  },
  "id": "openai-interpretar-requisicao",
  "name": "OpenAI - Interpretar Requisição",
  "type": "@n8n/n8n-nodes-langchain.openAi",
  "typeVersion": 1.0,
  "position": [-600, 80],
  "credentials": {
    "openAiApi": {
      "name": "OpenAI API"
    }
  }
}
```

---

## 🐛 TROUBLESHOOTING

### Erro: "Node type not found"

**Causa:** n8n desatualizado ou nó V1 sendo usado

**Solução:**
1. Verifique versão do n8n (deve ser 1.117.0+)
2. Delete o nó antigo
3. Adicione novo nó OpenAI
4. Configure com estrutura de Messages

---

### Erro: "Invalid response format"

**Causa:** Opção "Output Content as JSON" não ativada

**Solução:**
1. Abra o nó OpenAI
2. Vá em **Options**
3. Ative **Output Content as JSON**
4. Salve e teste

---

### Erro: "Temperature must be between 0 and 1"

**Causa:** Valor de temperatura inválido

**Solução:**
1. Abra o nó OpenAI
2. Vá em **Options**
3. Ajuste **Output Randomness (Temperature)** para valor entre 0.0 e 1.0
4. Recomendado: 0.3 para interpretação, 0.7 para síntese

---

## 📊 COMPARAÇÃO V1 vs V2

| Aspecto | V1 (Antigo) | V2 (Novo) |
|---------|-------------|-----------|
| **Tipo de Nó** | `lmChatOpenAi` | `openAi` |
| **Operação** | "Message a Model" | "Generate a Chat Completion" |
| **Estrutura de Mensagens** | `messages.values[]` | `Messages[]` |
| **JSON Output** | `responseFormat: json_object` | `outputContentAsJson: true` |
| **Simplify** | N/A | `simplifyOutput: true` |
| **API Usada** | Chat Completions | Chat Completions + Responses |

---

## ✅ CHECKLIST DE MIGRAÇÃO

- [ ] n8n atualizado para versão 1.117.0+
- [ ] Nós OpenAI antigos identificados
- [ ] Nós antigos deletados
- [ ] Novos nós OpenAI adicionados
- [ ] Mensagens configuradas com Roles (System, User)
- [ ] Opções configuradas (Simplify, JSON, Temperature)
- [ ] Credenciais OpenAI configuradas
- [ ] Testes realizados
- [ ] Workflow salvo

---

**Tempo Estimado de Migração por Nó:** 10-15 minutos  
**Total (2 nós OpenAI no Orquestrador):** ~30 minutos

---

**Fim do Documento**
