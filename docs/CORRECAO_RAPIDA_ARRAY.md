# Correção Rápida: Response Body Retornando Array

**Framework de Inteligência Territorial V6.0**  
**Data:** 26 de novembro de 2025  
**Sessão:** #6

---

## 🎯 PROBLEMA

A resposta do webhook está sendo retornada como **array** em vez de **objeto**:

### Atual (Incorreto)
```json
[
  {
    "success": true,
    "task_id": "test-001",
    ...
  }
]
```

### Esperado (Correto)
```json
{
  "success": true,
  "task_id": "test-001",
  ...
}
```

---

## ✅ SOLUÇÃO RÁPIDA (2 MINUTOS)

### Passo 1: Abrir o Nó "Respond to Webhook"

1. No workflow do n8n, clique no nó **"Respond to Webhook"**
2. Você verá o campo **"Response Body"**

### Passo 2: Ajustar o Response Body

**Configuração atual:**
```
={{ $json }}
```

**Nova configuração:**
```
={{ $json[0] }}
```

Ou alternativamente:
```
={{ $item(0).json }}
```

### Passo 3: Salvar

1. Clique em **"Save"** no nó (ou pressione Ctrl+S)
2. Salve o workflow (botão "Save" no canto superior direito)

---

## 🧪 TESTAR A CORREÇÃO

### Executar Novo Teste

Envie novamente o POST request:

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/agent-econ \
  -H "Content-Type: application/json" \
  -d '{
  "task_id": "test-002",
  "agent_name": "ECON",
  "territory_id": "1721000",
  "territory_name": "Palmas",
  "territory_type": "municipality",
  "analysis_type": "economic",
  "parameters": {
    "focus_areas": ["PIB", "emprego", "renda"],
    "time_period": "2019-2023",
    "detail_level": "comprehensive"
  },
  "metadata": {
    "requested_by": "test_user",
    "timestamp": "2024-11-24T21:30:00Z"
  }
}'
```

### Verificar a Resposta

A resposta agora deve começar com `{` em vez de `[`:

```json
{
  "success": true,
  "task_id": "test-002",
  "agent_name": "ECON",
  ...
}
```

---

## 📊 COMPARAÇÃO VISUAL

### Antes da Correção

```json
[                    ← Array (incorreto)
  {
    "success": true,
    ...
  }
]
```

**Acesso no código:**
```javascript
const success = response[0].success;  // Precisa do [0]
```

### Depois da Correção

```json
{                    ← Objeto (correto)
  "success": true,
  ...
}
```

**Acesso no código:**
```javascript
const success = response.success;  // Acesso direto
```

---

## 🎯 POR QUE ISSO ACONTECEU?

O n8n trabalha com **arrays de itens** internamente. Quando você usa `{{ $json }}`, ele retorna todos os itens (que é um array).

Para retornar apenas o primeiro item (que é o que queremos), usamos `{{ $json[0] }}`.

---

## ✅ CHECKLIST DE VALIDAÇÃO

Após a correção, verifique:

- [ ] Resposta começa com `{` (não `[`)
- [ ] Pode acessar `response.success` diretamente
- [ ] Pode acessar `response.task_id` diretamente
- [ ] Pode acessar `response.analysis` diretamente
- [ ] Não precisa de `response[0]` para acessar dados

---

## 🚀 APLICAR NOS OUTROS AGENTES

Quando implementar nos outros agentes (SOCIAL, AMBIENT, TERRA), lembre-se de usar:

```
Response Body: ={{ $json[0] }}
```

Em vez de:

```
Response Body: ={{ $json }}
```

---

## 📝 OBSERVAÇÃO IMPORTANTE

Esta correção é **apenas no nó "Respond to Webhook"**. Não é necessário alterar o código JavaScript do nó "Preparar Resposta do Webhook".

---

**Documento criado por:** Manus AI  
**Sessão:** #6 (26 de novembro de 2025)  
**Framework:** V6.0 - Inteligência Territorial
