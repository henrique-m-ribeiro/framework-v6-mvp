# Relatrio de Teste do Sistema Multiagentes - Sesso #16

**Data:** 2025-12-15
**Objetivo:** Testar funcionamento do sistema multiagentes via POST para o webhook do orquestrador
**Pergunta de Teste:** "Quais so os principais indicadores econmicos do Tocantins?"

---

## Resumo Executivo

**Status Geral:**  FALHA - Workflows no ativos no n8n

O sistema multiagentes no est respondendo porque **os workflows no esto ativos** no n8n Cloud. As requisies so aceitas (HTTP 200) pela URL do webhook, mas no retornam dados (0 bytes na resposta).

---

## Testes Realizados

### 1. Teste Inicial com URL Fornecida

**URL:** `https://galactic-ai.app.n8n.cloud/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2`

#### Teste 1.1: Campo "pergunta"
```bash
curl -X POST [URL] -H "Content-Type: application/json" \
  -d '{"pergunta": "Quais so os principais indicadores econmicos do Tocantins?"}'
```
**Resultado:** HTTP 200, 0 bytes de resposta, tempo: 11.1s

#### Teste 1.2: Campo "query"
**Resultado:** HTTP 200, 0 bytes de resposta

#### Teste 1.3: Campo "message"
**Resultado:** HTTP 200, 0 bytes de resposta

#### Teste 1.4: Campo "input"
**Resultado:** HTTP 503 - Erro SSL/TLS (conexo remota falhou)

### 2. Teste com Payload Correto (Baseado na Documentao)

**Payload esperado pelo orquestrador:**
```json
{
  "territory_id": "1721000",
  "question": "Quais so os principais indicadores econmicos do Tocantins?"
}
```

**Resultado:** HTTP 200, 0 bytes de resposta, tempo: 24.2s

### 3. Teste com Endpoint Documentado

**URL:** `https://galactic-ai.app.n8n.cloud/webhook/orchestrator`

**Resultado:** HTTP 404
```json
{
  "code": 404,
  "message": "The requested webhook \"POST orchestrator\" is not registered.",
  "hint": "The workflow must be active for a production URL to run successfully. You can activate the workflow using the toggle in the top-right of the editor."
}
```

### 4. Teste com URL de Teste do n8n

**URL:** `https://galactic-ai.app.n8n.cloud/webhook-test/orchestrator`

**Resultado:** HTTP 404
```json
{
  "code": 404,
  "message": "The requested webhook \"orchestrator\" is not registered.",
  "hint": "Click the 'Execute workflow' button on the canvas, then try again. (In test mode, the webhook only works for one call after you click this button)"
}
```

### 5. Teste Direto com Agente ECON

**URL:** `https://galactic-ai.app.n8n.cloud/webhook/agent-econ`

**Resultado:** HTTP 200, 0 bytes de resposta

---

## Diagnstico

### Problema Principal

**Os workflows do n8n NO ESTO ATIVOS em produo.**

A mensagem de erro do n8n explica claramente:
> "The workflow must be active for a production URL to run successfully. You can activate the workflow using the toggle in the top-right of the editor."

### Comportamento Observado

1. **URL fornecida (`0268b424-b3a3-41ea-9448-c99a1340a0c2`):**
   - Aceita requisies (HTTP 200)
   - No retorna dados (0 bytes)
   - Possvel webhook "rfo" ou workflow inativo

2. **URLs de produo (`/webhook/orchestrator`):**
   - Retornam 404 "not registered"
   - Confirmam que workflows esto inativos

3. **URLs de teste (`/webhook-test/`):**
   - Retornam 404
   - Indicam que nenhum workflow est aguardando teste no canvas

---

## Payload Esperado pelo Sistema

De acordo com o arquivo `WF-AGENT-ORCHESTRATOR-V4.0-CLEAN.json`:

```json
{
  "territory_id": "1721000",      // Cdigo IBGE do municpio (7 dgitos) - OBRIGATRIO
  "question": "..."              // Pergunta do usurio - OBRIGATRIO
}
```

### Territrios Disponveis

| Municpio | Cdigo IBGE |
|----------|------------|
| Palmas | 1721000 |
| Araguaina | 1702109 |
| Gurupi | 1709500 |
| Porto Nacional | 1718204 |
| Paraso do Tocantins | 1716109 |

---

## Arquitetura do Sistema (Baseado no Workflow)

```
                    +------------------+
                    |     Webhook      |
                    | (Recebe Request) |
                    +--------+---------+
                             |
                             v
                    +------------------+
                    |  IF - Validar    |
                    |     Payload      |
                    +--------+---------+
                             |
                    +--------v---------+
                    |   PostgreSQL     |
                    | Buscar Territrio|
                    +--------+---------+
                             |
                    +--------v---------+
                    |   OpenAI GPT-4   |
                    |   Interpretar    |
                    |    Requisio    |
                    +--------+---------+
                             |
                    +--------v---------+
                    |   Loop sobre     |
                    |    Agentes       |
                    +--------+---------+
                             |
        +--------+---------+---------+--------+
        |        |         |         |        |
        v        v         v         v        v
     +------+ +-------+ +-------+ +--------+ +-----+
     | ECON | | SOCIAL| | TERRA | | AMBIENT| | 500 |
     +------+ +-------+ +-------+ +--------+ +-----+
        |        |         |         |
        +--------+---------+---------+
                             |
                    +--------v---------+
                    |   PostgreSQL     |
                    | Salvar Knowledge |
                    |      Base        |
                    +--------+---------+
                             |
                    +--------v---------+
                    |   OpenAI GPT-4   |
                    |   Sintetizar     |
                    |    Anlises     |
                    +--------+---------+
                             |
                    +--------v---------+
                    |    Respond to    |
                    |     Webhook      |
                    +------------------+
```

---

## Aes Necessrias

### 1. Ativar Workflows no n8n Cloud

Para que o sistema funcione, necessrio:

1. Acessar o n8n Cloud em `https://galactic-ai.app.n8n.cloud`
2. Abrir o workflow `WF-AGENT-ORCHESTRATOR - Orquestrador Central V4.0`
3. Clicar no toggle de ativao (top-right do editor)
4. Fazer o mesmo para os workflows dos agentes:
   - WF-AGENT-ECON
   - WF-AGENT-SOCIAL
   - WF-AGENT-TERRA
   - WF-AGENT-AMBIENT

### 2. Verificar Credenciais

Garantir que as credenciais esto configuradas:
- **PostgreSQL:** "Postgres Replit"
- **OpenAI API:** "OpenAI API"

### 3. Verificar Conexes do Banco

O workflow usa `territories` table - verificar se existe e tem dados.

---

## Comando para Teste Aps Ativao

```bash
curl -X POST "https://galactic-ai.app.n8n.cloud/webhook/orchestrator" \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "question": "Quais so os principais indicadores econmicos do Tocantins?"
  }' | jq .
```

---

## Concluso

O teste revelou que o sistema multiagentes **est configurado corretamente** em termos de arquitetura e payload, mas os **workflows no esto ativos** no n8n Cloud, impedindo qualquer processamento das requisies.

**Prximos passos:**
1. Ativar workflows no n8n Cloud
2. Executar novamente os testes
3. Validar respostas do sistema

---

**Gerado por:** Claude Code
**Sesso:** #16
**Branch:** claude/test-n8n-multiagent-R8g68
