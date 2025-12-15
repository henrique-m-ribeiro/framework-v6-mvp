# Relatório de Teste do Sistema Multiagentes - Sessão #16

**Data:** 2025-12-15
**Objetivo:** Testar funcionamento do sistema multiagentes via POST para o webhook do orquestrador
**Pergunta de Teste:** "Quais são os principais indicadores econômicos do Tocantins?"
**URL do Orquestrador:** `https://galactic-ai.app.n8n.cloud/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2`

---

## Resumo Executivo

**Status Geral:** ⚠️ FALHA SILENCIOSA - Fluxo interrompido sem resposta

O sistema está **aceitando requisições** (HTTP 200) mas **retornando corpo vazio** (0 bytes). O workflow está ativo (confirmado pelo tempo de processamento de ~8-31s), mas algo está falhando internamente sem gerar resposta.

---

## Workflow Identificado

**Arquivo:** `workflows/WF-AGENT-ORCHESTRATOR-OrquestradorCentralV5.0.json`
**Versão:** V5.0 (Descoberta Dinâmica de Agentes)
**webhookId:** `0268b424-b3a3-41ea-9448-c99a1340a0c2` ✅

---

## Testes Realizados

### 1. Teste com Payload Simples
```bash
curl -X POST [URL] -H "Content-Type: application/json" \
  -d '{"territory_id": "1721000", "question": "Qual o PIB de Palmas?"}'
```
**Resultado:** HTTP 200, 0 bytes, tempo: 8.07s

### 2. Teste com Payload Completo
```bash
curl -X POST [URL] -H "Content-Type: application/json" \
  -d '{
    "question": "Quais são os principais indicadores econômicos do Tocantins?",
    "territory_id": "TO",
    "territory_name": "Tocantins",
    "parameters": {"time_period": "2019-2023", "detail_level": "comprehensive"}
  }'
```
**Resultado:** HTTP 200, 0 bytes, tempo: 8.07s

### 3. Teste de Validação (payloads inválidos)
| Payload | Esperado | Resultado |
|---------|----------|-----------|
| `{}` (vazio) | Erro 400 | HTTP 200, 0 bytes |
| Sem `territory_id` | Erro 400 | HTTP 200, 0 bytes |
| Sem `question` | Erro 400 | HTTP 200, 0 bytes |
| `territory_id` inválido | Erro 404 | HTTP 200, 0 bytes |

**Conclusão:** O workflow NÃO está atingindo os nós de resposta (nem de sucesso, nem de erro).

---

## Análise do Fluxo V5.0

```
┌─────────────────────────────────────────────────────────────────┐
│                    FLUXO DO ORQUESTRADOR V5.0                    │
└─────────────────────────────────────────────────────────────────┘

1. Webhook - Recebe Requisição
   │
   ▼
2. PostgreSQL - Listar Territórios Disponíveis  ◄──── POSSÍVEL PONTO DE FALHA
   │  Query: SELECT id, name, type, parent_id FROM territories
   │
   ▼
3. PostgreSQL - Buscar Agentes Ativos  ◄──── POSSÍVEL PONTO DE FALHA
   │  Query: SELECT agent_id, name, description, webhook_url, version
   │         FROM agent_registry WHERE is_active = TRUE
   │
   ▼
4. Code - Preparar Contexto Dinâmico  ◄──── POSSÍVEL PONTO DE FALHA
   │  (Combina dados de territórios e agentes)
   │
   ▼
5. OpenAI - Interpretar Requisição  ◄──── POSSÍVEL PONTO DE FALHA
   │  (Usa GPT-4o-mini para interpretar a pergunta)
   │
   ▼
6. Código - Parsear Resposta OpenAI  ◄──── POSSÍVEL PONTO DE FALHA
   │  (JSON.parse do resultado da OpenAI)
   │
   ▼
7. IF (status === 'valid')
   │
   ├──► [válido] → Set Payload → Split Out → Loop Agentes → Sintetizar → Responder Sucesso
   │
   └──► [inválido] → Responder Erro de Validação

Se QUALQUER nó antes do IF falhar, nenhuma resposta é enviada!
```

---

## Diagnóstico

### Hipóteses de Falha (em ordem de probabilidade)

#### 1. 🔴 Consulta PostgreSQL Falhando Silenciosamente
**Sintoma:** Tempo de resposta curto (~8s), nenhum dado retornado
**Causa provável:** Credenciais do PostgreSQL inválidas ou tabelas não existem
**Verificação necessária:**
```sql
-- Verificar se tabela territories tem dados
SELECT COUNT(*) FROM territories;

-- Verificar se tabela agent_registry tem dados
SELECT COUNT(*) FROM agent_registry WHERE is_active = TRUE;
```

#### 2. 🟡 Nó Code Falhando
**Sintoma:** Erro de JavaScript não capturado
**Causa provável:** Dados ausentes ou formato inesperado
**Verificação:** Testar workflow no modo canvas com dados de exemplo

#### 3. 🟡 OpenAI Retornando Erro
**Sintoma:** API key inválida ou rate limit
**Causa provável:** Credencial "OpenAi account 2" não configurada corretamente

#### 4. 🟢 Parse JSON Falhando
**Sintoma:** OpenAI retorna texto não-JSON
**Causa provável:** Prompt mal formatado ou resposta inesperada

---

## Dados Necessários no Banco

### Tabela `territories`
```sql
CREATE TABLE territories (
    id VARCHAR PRIMARY KEY,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    parent_id VARCHAR,
    area REAL,
    metadata JSON
);

-- Dados necessários (exemplos)
INSERT INTO territories (id, name, type) VALUES
('TO', 'Tocantins', 'state'),
('1721000', 'Palmas', 'municipality'),
('1702109', 'Araguaína', 'municipality');
```

### Tabela `agent_registry`
```sql
-- Verificar se os agentes estão registrados
SELECT agent_id, name, webhook_url, is_active FROM agent_registry;

-- Resultado esperado:
-- economic | Agente Econômico | https://galactic-ai.app.n8n.cloud/webhook/agent-econ | true
-- social   | Agente Social    | https://galactic-ai.app.n8n.cloud/webhook/agent-social | true
-- terra    | Agente Territorial | https://galactic-ai.app.n8n.cloud/webhook/agent-terra | true
-- ambient  | Agente Ambiental | https://galactic-ai.app.n8n.cloud/webhook/agent-ambient | true
```

---

## Ações de Depuração Recomendadas

### 1. No n8n Cloud - Verificar Execuções
1. Acessar `https://galactic-ai.app.n8n.cloud`
2. Abrir workflow "WF-AGENT-ORCHESTRATOR - Orquestrador Central V5.0"
3. Ir em "Executions" (menu lateral)
4. Verificar execuções recentes e identificar onde falhou

### 2. Testar Credenciais PostgreSQL
No n8n, abrir a credencial "Postgres Replit" e testar conexão.

### 3. Testar Credenciais OpenAI
No n8n, abrir a credencial "OpenAi account 2" e verificar se a API key está válida.

### 4. Executar em Modo Teste
1. Abrir o workflow no canvas
2. Clicar em "Execute Workflow" (botão de play)
3. Enviar requisição para URL de teste:
```bash
curl -X POST "https://galactic-ai.app.n8n.cloud/webhook-test/0268b424-b3a3-41ea-9448-c99a1340a0c2" \
  -H "Content-Type: application/json" \
  -d '{"question": "Qual o PIB de Palmas?", "territory_id": "1721000"}'
```
4. Observar no canvas onde o fluxo para

---

## Payload Esperado pelo Sistema V5.0

```json
{
  "question": "Quais são os principais indicadores econômicos do Tocantins?",  // OBRIGATÓRIO
  "territory_id": "TO",                    // Opcional (sugestão)
  "territory_name": "Tocantins",           // Opcional (sugestão)
  "parameters": {                          // Opcional
    "time_period": "2019-2023",
    "detail_level": "comprehensive"
  }
}
```

---

## Comando de Teste Final

```bash
curl -X POST "https://galactic-ai.app.n8n.cloud/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2" \
  -H "Content-Type: application/json" \
  -d '{
    "question": "Quais são os principais indicadores econômicos do Tocantins?",
    "territory_id": "TO",
    "territory_name": "Tocantins"
  }' \
  -w "\n\nHTTP: %{http_code} | Size: %{size_download}b | Time: %{time_total}s"
```

---

## Conclusão

O sistema multiagentes V5.0 está **parcialmente operacional**:
- ✅ Webhook está ativo e aceitando requisições
- ✅ Workflow está processando (evidenciado pelo tempo de resposta)
- ❌ Fluxo está falhando em algum nó antes de atingir as respostas
- ❌ Não há tratamento de erro adequado (falha silenciosa)

**Provável causa:** Consulta ao PostgreSQL falhando (tabelas inexistentes ou sem dados).

**Próximos passos:**
1. Verificar execuções no painel do n8n
2. Confirmar dados nas tabelas `territories` e `agent_registry`
3. Testar credenciais PostgreSQL e OpenAI
4. Executar workflow em modo teste para identificar nó com falha

---

**Gerado por:** Claude Code
**Sessão:** #16
**Branch:** claude/test-n8n-multiagent-R8g68
**Versão do Relatório:** 2.0 (Atualizado após análise do workflow V5.0)
