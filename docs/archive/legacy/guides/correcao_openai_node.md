# 🔧 Correção do Erro no Nó OpenAI - Interpretar Requisição

## Erro Identificado

```
Missing required parameter: 'input[2].content[0].text'
```

**Causa**: A configuração do nó OpenAI está **incompleta**. A segunda mensagem (user message) não tem o campo `role` definido.

---

## Análise da Configuração Atual

### Configuração Atual (INCORRETA)

```json
{
  "values": [
    {
      "role": "system",
      "content": "=Você é o Orquestrador Central..."
    },
    {
      "content": "={{ $json.question }}"  // ❌ FALTA o campo "role"
    }
  ]
}
```

**Problema**: A segunda mensagem não tem `"role": "user"`, o que causa o erro.

---

## Solução

### Configuração Corrigida

No nó **"OpenAI - Interpretar Requisição"**, na seção **"Responses"**:

**Mensagem 1 (System)**:
- **Role**: `system`
- **Content**: (manter o prompt atual)

**Mensagem 2 (User)** - **CORRIGIR**:
- **Role**: `user` ← **ADICIONAR ESTE CAMPO**
- **Content**: `={{ $json.question }}`

---

## Passo a Passo para Corrigir

### 1. Abrir o Nó OpenAI

1. Clique no nó **"OpenAI - Interpretar Requisição"**
2. Vá para a aba **"Parameters"**
3. Localize a seção **"Responses"**

---

### 2. Verificar Mensagem 1 (System)

Deve estar assim:

- **Role**: `system`
- **Content**: 
```
=Você é o Orquestrador Central de um sistema de inteligência territorial para o Estado do Tocantins.

Sua função é:
1. VALIDAR a requisição do usuário
2. IDENTIFICAR o território referenciado (usando a lista de territórios disponíveis)
3. SELECIONAR os agentes especializados necessários para responder à pergunta
4. PREPARAR as tarefas específicas para cada agente

TERRITÓRIOS DISPONÍVEIS:
{{ JSON.stringify($json.available_territories, null, 2) }}

AGENTES DISPONÍVEIS:
{{ JSON.stringify($json.available_agents, null, 2) }}

REQUISIÇÃO DO USUÁRIO:
Pergunta: {{ $json.request.question }}
Território sugerido (ID): {{ $json.request.suggested_territory_id }}
Território sugerido (Nome): {{ $json.request.suggested_territory_name }}
Parâmetros: {{ JSON.stringify($json.request.parameters, null, 2) }}

INSTRUÇÕES:
1. Se a requisição for inválida ou incompleta, retorne um JSON com "status": "invalid" e explique o problema em "error_message"
2. Se o território não for identificado, retorne "status": "invalid" e peça mais informações
3. Se tudo estiver válido, retorne um JSON com:
   - "status": "valid"
   - "territory": { "id": "...", "name": "..." }
   - "selected_agents": [ lista de IDs dos agentes necessários ]
   - "agent_tasks": { "agent_id": "tarefa específica para este agente", ... }
   - "synthesis_strategy": "como sintetizar as respostas dos agentes"

FORMATO DE RESPOSTA (JSON):
{
  "status": "valid" | "invalid",
  "error_message": "...", // apenas se status = invalid
  "territory": {
    "id": "TO",
    "name": "Tocantins"
  },
  "selected_agents": ["econ", "social"],
  "agent_tasks": {
    "econ": "Analise os principais indicadores econômicos do Tocantins entre 2019-2023",
    "social": "Analise os principais desafios sociais do Tocantins entre 2019-2023"
  },
  "synthesis_strategy": "Relacione os desafios econômicos com os desafios sociais, identificando causas e consequências mútuas"
}
```

✅ **Está correto** - não precisa alterar.

---

### 3. Corrigir Mensagem 2 (User)

**PROBLEMA ATUAL**: Falta o campo **"Role"**

**CORREÇÃO**:

1. Clique na **segunda mensagem** na lista de Responses
2. Verifique se há um campo **"Role"** no topo
3. Se **NÃO houver**, adicione:
   - **Role**: Selecione `user` no dropdown
4. Mantenha o **Content**:
   ```
   ={{ $json.question }}
   ```

**Resultado esperado**:

- **Role**: `user`
- **Content**: `={{ $json.question }}`

---

## Verificação Visual

Após a correção, a seção **"Responses"** deve mostrar:

```
Responses (2)
  ├─ Message 1
  │   ├─ Role: system
  │   └─ Content: =Você é o Orquestrador Central...
  │
  └─ Message 2
      ├─ Role: user          ← ✅ ESTE CAMPO DEVE EXISTIR
      └─ Content: ={{ $json.question }}
```

---

## Alternativa: Recriar a Mensagem

Se não conseguir adicionar o campo "Role", **delete a segunda mensagem e recrie**:

1. Clique no **X** para remover a segunda mensagem
2. Clique em **"Add Message"**
3. Configure:
   - **Role**: `user`
   - **Content**: `={{ $json.question }}`
4. Salve o workflow

---

## Teste Após Correção

Após corrigir, execute o workflow novamente com:

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2 \
  -H "Content-Type: application/json" \
  -d '{
    "task_id": "test_correcao_001",
    "territory_id": "TO",
    "territory_name": "Tocantins",
    "question": "Quais são os principais desafios socioeconômicos do Tocantins?"
  }'
```

**Resultado esperado**: O nó OpenAI deve executar com sucesso e retornar um JSON.

---

## Notas Adicionais

### Por que o erro ocorreu?

O nó OpenAI do n8n v2 (LangChain) espera que **todas as mensagens** tenham:
1. `role` (system, user, ou assistant)
2. `content` (o texto da mensagem)

Quando o `role` está ausente, a API da OpenAI rejeita a requisição.

### Outros campos opcionais

Você também pode adicionar (mas não é obrigatório):
- **Name**: Nome do participante (útil para multi-turn conversations)
- **Tool Calls**: Para function calling (não aplicável neste caso)

---

## Checklist de Validação

Após a correção, verifique:

- ✅ Mensagem 1 tem `role: system`
- ✅ Mensagem 2 tem `role: user`
- ✅ Mensagem 2 tem `content: ={{ $json.question }}`
- ✅ Workflow salvo
- ✅ Teste executado com sucesso
- ✅ Nó OpenAI retorna JSON válido
