# DESCOBERTA IMPORTANTE: n8n Respond to Webhook

**Framework de Inteligência Territorial V6.0**  
**Data:** 26 de novembro de 2025  
**Sessão:** #6  
**Fonte:** Comunidade n8n

---

## 🎯 PROBLEMA IDENTIFICADO NA COMUNIDADE

### Tópico Original
**Título:** "Why does n8n always return arrays, even when I return a single object?"  
**URL:** https://community.n8n.io/t/why-does-n8n-always-return-arrays-even-when-i-return-a-single-object/101521  
**Data:** 15 de abril de 2025

### Descrição do Problema

O usuário Xenia_Zhukova relatou **exatamente o mesmo problema** que estamos enfrentando:

> "I'm working on a workflow where I want to return a single JSON object when responding to webhook. Instead the JSON is always wrapped in an array."

**Output recebido (incorreto):**
```json
[
   {
      "output": 
         {
           "status":  "error",
          "action":  "createPoster",
          "link":  "",
          "text": "Tool execution failed due to an undefined error."
         }
      }
]
```

**Output desejado (correto):**
```json
{
          "status": "error",
          "action": "createPoster",
          "link": "",
          "text": "Tool execution failed due to an undefined error."
}
```

---

## ✅ SOLUÇÃO OFICIAL (por Franz - Moderador n8n)

### Resposta Marcada como "Solution"

Franz (moderador oficial do n8n) forneceu a seguinte solução:

> "Your code is correct. The output of the Respond to Webhook node is not the same as the actual output of the Webhook. The output you see in the workflow is the data that is passed to nodes in your workflow after this node."

### Solução Proposta

**Para retornar um objeto (não array), use uma das seguintes opções:**

#### Opção 1: Usar o nó Set
1. Adicionar um nó **Set** antes do **Respond to Webhook**
2. Mudar o mode para **JSON**

#### Opção 2: Configurar o Respond to Webhook
1. No nó **Respond to Webhook**
2. Configurar: **Respond with = "First incoming item"**

---

## 🔍 ANÁLISE DA SOLUÇÃO

### O Que Isso Significa Para Nós?

1. **O output visual no n8n NÃO é o mesmo que a resposta do webhook**
   - O que vemos no workflow é o dado passado para nós subsequentes
   - A resposta real do webhook pode ser diferente

2. **O nó Respond to Webhook tem configurações específicas**
   - Existe um parâmetro "Respond with" que controla o formato da resposta
   - Podemos configurar para retornar apenas o primeiro item (objeto)

3. **Nosso código JavaScript pode estar correto**
   - O problema pode não estar no `return response;` vs `return [response];`
   - O problema pode estar na configuração do nó Respond to Webhook

---

## 🎯 AÇÃO NECESSÁRIA

### Verificar Configuração do Nó "Respond to Webhook"

**Passo 1:** Abrir o nó "Respond to Webhook"

**Passo 2:** Procurar o parâmetro **"Respond With"** ou **"Respond Mode"**

**Passo 3:** Verificar as opções disponíveis:
- [ ] All Incoming Items (retorna array)
- [ ] First Incoming Item (retorna objeto) ← **USAR ESTA**
- [ ] Last Incoming Item (retorna objeto)
- [ ] Using an Expression

**Passo 4:** Selecionar **"First Incoming Item"**

**Passo 5:** Salvar e testar

---

## 📊 COMPARAÇÃO: ANTES vs. DEPOIS

### Configuração Atual (Suspeita)
```
Respond With: All Incoming Items (padrão)
  ↓
Retorna: [{ success: true, ... }]  ← ARRAY
```

### Configuração Correta
```
Respond With: First Incoming Item
  ↓
Retorna: { success: true, ... }  ← OBJETO
```

---

## 💡 POR QUE ISSO EXPLICA TUDO

### 1. O Código JavaScript Está Correto
- `return response;` retorna um objeto
- O n8n automaticamente envolve em `{ json: response }`
- Isso gera um item no workflow

### 2. O Problema Está no Nó Respond to Webhook
- Se configurado para "All Incoming Items", retorna array de todos os itens
- Se configurado para "First Incoming Item", retorna apenas o primeiro item (objeto)

### 3. O Response Body Estava Correto
- `={{ $('Preparar Resposta do Webhook').item.json }}` acessa o primeiro item
- Mas se o nó está configurado para retornar "All Items", ele ignora isso

---

## ✅ SOLUÇÃO DEFINITIVA

### Não Mexer no Código JavaScript

O código atual está correto:
```javascript
return response;
```

### Ajustar o Nó "Respond to Webhook"

**Configuração:**
- **Respond With:** First Incoming Item

**Response Body:**
- `={{ $json }}`  (simples, sem necessidade de acessar nó anterior)

ou

- `={{ $('Preparar Resposta do Webhook').item.json }}`  (mais explícito)

---

## 🎉 EXPECTATIVA

Após ajustar o parâmetro "Respond With" para "First Incoming Item", o webhook deve retornar:

```json
{
  "success": true,
  "task_id": "test-006-SUCCESS",
  "agent_name": "ECON",
  "analysis": {
    ...
  },
  "metadata": {
    ...
  },
  "storage": {
    ...
  }
}
```

**SEM** o `[` no início!

---

## 📝 PRÓXIMOS PASSOS

1. Verificar se o nó "Respond to Webhook" tem o parâmetro "Respond With"
2. Configurar para "First Incoming Item"
3. Testar novamente
4. Se funcionar, documentar a solução final

---

## 🔗 REFERÊNCIAS

- **Tópico da Comunidade:** https://community.n8n.io/t/why-does-n8n-always-return-arrays-even-when-i-return-a-single-object/101521
- **Solução por:** Franz (Moderador n8n)
- **Data:** 15 de abril de 2025
- **Status:** Marcada como "Solution" pela comunidade

---

**Documento criado por:** Manus AI  
**Sessão:** #6 (26 de novembro de 2025)  
**Framework:** V6.0 - Inteligência Territorial
