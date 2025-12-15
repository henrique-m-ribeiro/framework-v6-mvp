# Checklist Pré-Execução - Correção do Respond to Webhook

**Framework de Inteligência Territorial V6.0**  
**Data:** 26 de novembro de 2025  
**Sessão:** #6

---

## 🎯 OBJETIVO

Garantir que todos os ajustes estejam corretos antes de executar o workflow, evitando retrabalho.

---

## ✅ PASSO 1: VERIFICAR CONFIGURAÇÃO DO WEBHOOK INICIAL

### Nó: "Webhook - Recebe Tarefa"

**⚠️ CRÍTICO:** Este é o ajuste mais importante!

1. **Abra o nó** "Webhook - Recebe Tarefa"
2. **Localize o parâmetro** "Respond" ou "Response Mode"
3. **Verifique se está configurado como:**
   - ✅ **"Using Respond to Webhook Node"** (interface visual)
   - ✅ **"responseNode"** (no JSON)

**Como verificar:**
- Na interface do n8n, procure por "Respond" ou "Response Mode"
- Deve estar selecionado "Using Respond to Webhook Node"
- **NÃO** deve estar "Immediately" ou "On Last Node"

**Se estiver diferente:**
```
1. Clique no dropdown "Respond" ou "Response Mode"
2. Selecione "Using Respond to Webhook Node"
3. Salve o nó (botão "Save" ou Ctrl+S)
4. Salve o workflow (canto superior direito)
```

**Configuração esperada no JSON:**
```json
{
  "parameters": {
    "httpMethod": "POST",
    "path": "agent-econ",
    "responseMode": "responseNode",  // ← DEVE SER ISSO
    "options": {
      "allowedOrigins": "*"
    }
  }
}
```

---

## ✅ PASSO 2: VERIFICAR NÓ "PREPARAR RESPOSTA DO WEBHOOK"

### Checklist do Nó Code

- [ ] Nó foi criado e renomeado para "Preparar Resposta do Webhook"
- [ ] Tipo do nó é "Code" (JavaScript)
- [ ] Código JavaScript foi colado (versão robusta recomendada)
- [ ] Não há erros de sintaxe (n8n mostra em vermelho se houver)
- [ ] Nó está conectado **APÓS** "Salvar Análise no PostgreSQL"
- [ ] Nó está conectado **ANTES** de "Respond to Webhook"

**Estrutura esperada:**
```
[Salvar Análise no PostgreSQL] 
         ↓
[Preparar Resposta do Webhook] ← VOCÊ ESTÁ AQUI
         ↓
[Respond to Webhook]
```

---

## ✅ PASSO 3: VERIFICAR NÓ "RESPOND TO WEBHOOK"

### Checklist do Nó Respond to Webhook

- [ ] Parâmetro "Respond With" está como **JSON**
- [ ] Parâmetro "Response Body" é **`={{ $json }}`** (com `=` antes)
- [ ] Nó está conectado **APÓS** "Preparar Resposta do Webhook"
- [ ] Não há outros nós após este (deve ser o último)

**Como verificar o Response Body:**
1. Abra o nó "Respond to Webhook"
2. Localize o campo "Response Body"
3. Deve conter exatamente: `={{ $json }}`
4. **Atenção:** Deve ter o `=` antes das chaves!

**Configuração esperada:**
```json
{
  "parameters": {
    "respondWith": "json",
    "responseBody": "={{ $json }}",  // ← DEVE SER ISSO
    "options": {}
  }
}
```

---

## ✅ PASSO 4: VERIFICAR NOMES DOS NÓS

Os nomes dos nós devem estar **EXATAMENTE** como abaixo, pois o código JavaScript os referencia:

- [ ] `Webhook - Recebe Tarefa` (com espaços e hífen)
- [ ] `Estruturar Resposta` (sem "a" no final)
- [ ] `Salvar Análise no PostgreSQL` (com acentos)

**Se algum nome estiver diferente:**

**Opção A:** Renomeie o nó para o nome esperado
**Opção B:** Ajuste o código JavaScript para usar o nome correto

**Exemplo de ajuste no código:**
```javascript
// Se o nó se chama "Estruturar Resposta Final" em vez de "Estruturar Resposta"
const structuredData = $('Estruturar Resposta Final').first().json;
```

---

## ✅ PASSO 5: SALVAR TUDO

- [ ] Todos os nós foram salvos individualmente
- [ ] Workflow foi salvo (botão "Save" no canto superior direito)
- [ ] Não há indicador de "não salvo" (asterisco ou ponto vermelho)

---

## ✅ PASSO 6: PREPARAR PARA DEBUG

### Abrir Console do Navegador

1. Pressione **F12** (ou Ctrl+Shift+I no Windows/Linux, Cmd+Option+I no Mac)
2. Clique na aba **"Console"**
3. Deixe aberto durante a execução do workflow

**Por quê?**
- O código JavaScript usa `console.log()` para mostrar o progresso
- Você verá mensagens como:
  ```
  === PREPARAR RESPOSTA DO WEBHOOK - INÍCIO ===
  ✅ Webhook Data capturado
  ✅ Structured Data capturado
  ✅ Save Result capturado
  ⏱️ Tempo de processamento: 2847ms
  📊 Key Findings extraídos: 5
  ✅ Resposta construída com sucesso
  === PREPARAR RESPOSTA DO WEBHOOK - FIM ===
  ```

---

## ✅ PASSO 7: EXECUTAR TESTE

### Execução Manual (Recomendado para primeiro teste)

1. Clique no botão **"Execute Workflow"** (canto superior direito)
2. Ou clique em **"Test Workflow"** se disponível
3. Aguarde a execução completa
4. Verifique se todos os nós ficam verdes (sucesso)

### Verificar Output

1. Clique no nó **"Respond to Webhook"**
2. Clique na aba **"Output"**
3. Verifique se a resposta está estruturada

**Resposta esperada:**
```json
{
  "success": true,
  "task_id": "...",
  "agent_name": "ECON",
  "analysis": {
    "analysis_id": "...",
    "territory": { ... },
    "summary": "...",
    "confidence_score": 0.92,
    "key_findings": [ ... ]
  },
  "metadata": {
    "timestamp": "...",
    "processing_time_ms": 2847,
    ...
  },
  "storage": { ... }
}
```

---

## 🚨 SE ALGO DER ERRADO

### Erro: "Workflow did not return a response"

**Causa:** Webhook não está configurado para usar "Respond to Webhook Node"

**Solução:** Volte ao PASSO 1 e verifique a configuração do webhook

---

### Erro: "Cannot read property 'json' of undefined"

**Causa:** Um dos nós anteriores não existe ou tem nome diferente

**Solução:** Volte ao PASSO 4 e verifique os nomes dos nós

---

### Erro: "Response already sent"

**Causa:** Webhook está configurado para responder imediatamente E usar o nó "Respond to Webhook"

**Solução:** Certifique-se de que o webhook está APENAS em modo "responseNode"

---

### Nó "Preparar Resposta do Webhook" fica vermelho

**Causa:** Erro no código JavaScript

**Soluções:**
1. Verifique se há erros de sintaxe (n8n mostra em vermelho)
2. Veja o console do navegador (F12) para detalhes do erro
3. Use a versão robusta do código (com try-catch)

---

## 📊 RESUMO VISUAL

```
┌─────────────────────────────────────────────────────────────┐
│  CHECKLIST PRÉ-EXECUÇÃO                                     │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  [ ] 1. Webhook configurado com "responseNode"             │
│  [ ] 2. Nó Code criado e código colado                     │
│  [ ] 3. Response Body é "={{ $json }}"                     │
│  [ ] 4. Nomes dos nós estão corretos                       │
│  [ ] 5. Tudo foi salvo                                     │
│  [ ] 6. Console do navegador está aberto (F12)             │
│  [ ] 7. Pronto para executar teste                         │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🎯 APÓS VALIDAÇÃO BEM-SUCEDIDA

Quando o teste funcionar perfeitamente:

1. ✅ Marque esta tarefa como concluída
2. ✅ Replique para os outros 3 agentes (SOCIAL, AMBIENT, TERRA)
3. ✅ Documente qualquer ajuste adicional necessário
4. ✅ Prossiga para a Tarefa 2 (Implementar RAG)

---

## 📞 PRECISA DE AJUDA?

Se encontrar problemas não listados aqui:

1. **Tire um print** da tela mostrando o erro
2. **Copie a mensagem de erro** completa
3. **Verifique o console** do navegador (F12) para mais detalhes
4. **Compartilhe** essas informações para análise

---

**Documento criado por:** Manus AI  
**Sessão:** #6 (26 de novembro de 2025)  
**Framework:** V6.0 - Inteligência Territorial
