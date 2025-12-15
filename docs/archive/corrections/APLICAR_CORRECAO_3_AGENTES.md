# 🚀 GUIA RÁPIDO: Aplicar Correção nos 3 Agentes Restantes

**Framework de Inteligência Territorial V6.0**  
**Sessão:** #6  
**Data:** 26 de novembro de 2025  
**Tempo Estimado:** 15-20 minutos

---

## 🎯 OBJETIVO

Aplicar a correção do parâmetro "Respond With" para "First Incoming Item" nos nós "Respond to Webhook" dos agentes:
- WF-AGENT-SOCIAL (Especialista Social)
- WF-AGENT-AMBIENT (Especialista Ambiental)
- WF-AGENT-TERRA (Especialista Territorial)

---

## ✅ A CORREÇÃO (MUITO SIMPLES)

### O Que Fazer

**Em cada um dos 3 workflows:**

1. Abrir o nó **"Respond to Webhook"**
2. Localizar o parâmetro **"Respond With"**
3. Mudar de **"All Incoming Items"** para **"First Incoming Item"**
4. Salvar o nó (Ctrl+S)
5. Salvar o workflow (botão "Save")

**Só isso!** 🎉

---

## 📋 CHECKLIST DE APLICAÇÃO

### Agente SOCIAL (1/3)

- [ ] Abrir workflow **WF-AGENT-SOCIAL**
- [ ] Clicar no nó **"Respond to Webhook"**
- [ ] Parâmetro "Respond With": **All Incoming Items** → **First Incoming Item**
- [ ] Salvar nó (Ctrl+S)
- [ ] Salvar workflow
- [ ] ✅ **SOCIAL CONCLUÍDO**

### Agente AMBIENT (2/3)

- [ ] Abrir workflow **WF-AGENT-AMBIENT**
- [ ] Clicar no nó **"Respond to Webhook"**
- [ ] Parâmetro "Respond With": **All Incoming Items** → **First Incoming Item**
- [ ] Salvar nó (Ctrl+S)
- [ ] Salvar workflow
- [ ] ✅ **AMBIENT CONCLUÍDO**

### Agente TERRA (3/3)

- [ ] Abrir workflow **WF-AGENT-TERRA**
- [ ] Clicar no nó **"Respond to Webhook"**
- [ ] Parâmetro "Respond With": **All Incoming Items** → **First Incoming Item****
- [ ] Salvar nó (Ctrl+S)
- [ ] Salvar workflow
- [ ] ✅ **TERRA CONCLUÍDO**

---

## 🔍 ONDE ENCONTRAR O PARÂMETRO

### Localização Visual

```
┌─────────────────────────────────────┐
│  Respond to Webhook                 │
├─────────────────────────────────────┤
│  Parameters    Settings             │
├─────────────────────────────────────┤
│                                     │
│  Respond With                       │
│  ┌───────────────────────────────┐ │
│  │ First Incoming Item        ▼  │ │ ← Mudar para esta opção
│  └───────────────────────────────┘ │
│                                     │
│  Response Body                      │
│  ┌───────────────────────────────┐ │
│  │ ={{ $json }}                  │ │ ← Manter como está
│  └───────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

### Opções Disponíveis

- ❌ **All Incoming Items** (padrão - retorna array)
- ✅ **First Incoming Item** (correto - retorna objeto)
- ⚠️ **Last Incoming Item** (retorna objeto, mas não é o que queremos)

---

## 🧪 COMO TESTAR (OPCIONAL)

Se você quiser testar cada agente após aplicar a correção:

### URLs dos Webhooks

**SOCIAL:**
```
https://galactic-ai.app.n8n.cloud/webhook/agent-social
```

**AMBIENT:**
```
https://galactic-ai.app.n8n.cloud/webhook/agent-ambient
```

**TERRA:**
```
https://galactic-ai.app.n8n.cloud/webhook/agent-terra
```

### Body de Teste (Adaptar para cada agente)

**Para SOCIAL:**
```json
{
  "task_id": "test-social-001",
  "agent_name": "SOCIAL",
  "territory_id": "1721000",
  "territory_name": "Palmas",
  "territory_type": "municipality",
  "analysis_type": "social",
  "parameters": {
    "focus_areas": ["educação", "saúde", "assistência social"],
    "time_period": "2019-2023",
    "detail_level": "comprehensive"
  },
  "metadata": {
    "requested_by": "test_user",
    "timestamp": "2025-11-26T17:30:00Z"
  }
}
```

**Para AMBIENT:**
```json
{
  "task_id": "test-ambient-001",
  "agent_name": "AMBIENT",
  "territory_id": "1721000",
  "territory_name": "Palmas",
  "territory_type": "municipality",
  "analysis_type": "environmental",
  "parameters": {
    "focus_areas": ["desmatamento", "recursos hídricos", "biodiversidade"],
    "time_period": "2019-2023",
    "detail_level": "comprehensive"
  },
  "metadata": {
    "requested_by": "test_user",
    "timestamp": "2025-11-26T17:30:00Z"
  }
}
```

**Para TERRA:**
```json
{
  "task_id": "test-terra-001",
  "agent_name": "TERRA",
  "territory_id": "1721000",
  "territory_name": "Palmas",
  "territory_type": "municipality",
  "analysis_type": "territorial",
  "parameters": {
    "focus_areas": ["uso do solo", "infraestrutura", "mobilidade"],
    "time_period": "2019-2023",
    "detail_level": "comprehensive"
  },
  "metadata": {
    "requested_by": "test_user",
    "timestamp": "2025-11-26T17:30:00Z"
  }
}
```

### Resposta Esperada (Objeto, não Array)

```json
{
  "success": true,
  "task_id": "test-social-001",
  "agent_name": "SOCIAL",
  "analysis": {
    "analysis_id": "kb-2025-11-26-xxxxx",
    "territory": {
      "id": "1721000",
      "name": "Palmas",
      "type": "municipality"
    },
    "summary": "Análise social completa gerada.",
    "confidence_score": 0.92,
    "key_findings": [...]
  },
  "metadata": {
    "timestamp": "2025-11-26T17:35:00.000Z",
    "processing_time_ms": 3000,
    "indicators_analyzed": 0,
    "years_covered": "2023, 2022, 2021, 2020, 2019",
    "data_sources": ["IBGE", "DataSUS"],
    "model_used": "gpt-4o-mini"
  },
  "storage": {
    "saved_to_knowledge_base": true,
    "knowledge_base_id": null
  }
}
```

**SEM o `[` no início!** ✅

---

## ⚠️ TROUBLESHOOTING

### Problema: Ainda retorna array `[{...}]`

**Causa:** O parâmetro "Respond With" não foi salvo ou o workflow não foi salvo.

**Solução:**
1. Verifique se o parâmetro está como "First Incoming Item"
2. Salve o nó (Ctrl+S)
3. Salve o workflow (botão "Save" no canto superior direito)
4. Teste novamente

### Problema: Erro "Invalid JSON in 'Response Body' field"

**Causa:** O Response Body está com sintaxe incorreta.

**Solução:**
1. Verifique se o Response Body está como: `={{ $json }}`
2. Se estiver diferente, corrija para `={{ $json }}`
3. Salve o nó e o workflow
4. Teste novamente

### Problema: Webhook não responde

**Causa:** O workflow pode estar travado ou com erro em algum nó anterior.

**Solução:**
1. Vá para "Executions" no n8n
2. Procure pela última execução
3. Verifique se há algum nó em vermelho (erro)
4. Corrija o erro e teste novamente

---

## 📊 PROGRESSO

```
┌─────────────────────────────────────┐
│  AGENTES CORRIGIDOS                 │
├─────────────────────────────────────┤
│  ✅ ECON    (Especialista Econômico)│
│  ⬜ SOCIAL  (Especialista Social)   │
│  ⬜ AMBIENT (Especialista Ambiental)│
│  ⬜ TERRA   (Especialista Territorial)│
├─────────────────────────────────────┤
│  Progresso: 1/4 (25%)               │
└─────────────────────────────────────┘
```

Após aplicar a correção em cada agente, marque como concluído:

```
┌─────────────────────────────────────┐
│  AGENTES CORRIGIDOS                 │
├─────────────────────────────────────┤
│  ✅ ECON    (Especialista Econômico)│
│  ✅ SOCIAL  (Especialista Social)   │
│  ✅ AMBIENT (Especialista Ambiental)│
│  ✅ TERRA   (Especialista Territorial)│
├─────────────────────────────────────┤
│  Progresso: 4/4 (100%) 🎉          │
└─────────────────────────────────────┘
```

---

## 🎯 RESULTADO ESPERADO

Após aplicar a correção nos 3 agentes, **todos os 4 agentes dimensionais** retornarão respostas estruturadas e profissionais:

✅ **API Profissional** - Resposta rica em informações  
✅ **Rastreabilidade** - task_id, analysis_id, timestamps  
✅ **Insights Acionáveis** - summary, key_findings, confidence_score  
✅ **Contexto Completo** - território, fontes, período  
✅ **Integração Facilitada** - frontend pode consumir diretamente

---

## 📚 DOCUMENTAÇÃO DE REFERÊNCIA

- **TAREFA_1_CONCLUIDA_COM_SUCESSO.md** - Resumo completo da correção
- **DESCOBERTA_N8N_RESPOND_WEBHOOK.md** - Descoberta na comunidade n8n
- **GUIA_CORRIGIR_RESPOND_WEBHOOK.md** - Guia detalhado passo-a-passo

---

## 💡 DICA

Se você quiser aplicar a correção de forma ainda mais rápida:

1. **Abra os 3 workflows em abas separadas** do navegador
2. **Aplique a correção em sequência** sem fechar as abas
3. **Salve todos** de uma vez
4. **Teste todos** em sequência (opcional)

**Tempo estimado:** 10-15 minutos para os 3 agentes! ⚡

---

## 🚀 PRÓXIMO PASSO

Após aplicar a correção nos 3 agentes, você pode:

**A)** Testar cada agente para validar que a correção funcionou

**B)** Prosseguir diretamente para a Tarefa 2 (implementar RAG)

**C)** Fazer um balanço da sessão e documentar o progresso

---

**Boa sorte!** 🎯🚀

Se tiver alguma dúvida ou problema, consulte a documentação de referência ou peça ajuda!
