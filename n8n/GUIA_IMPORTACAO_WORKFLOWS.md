# Guia de Importação e Configuração dos Workflows n8n
**Framework de Inteligência Territorial V6.0**  
**Data:** 16 de novembro de 2025  
**Autor:** Manus AI  
**Versão:** 1.0.0

---

## 🎯 OBJETIVO

Este guia ensina como importar e configurar os 3 workflows criados para integração entre o dashboard Replit e o sistema multi-agentes n8n Cloud.

---

## 📦 WORKFLOWS CRIADOS

### 1. WF-TEST-INTEGRATION
**Arquivo:** `WF-TEST-INTEGRATION.json`  
**Função:** Testar comunicação básica entre dashboard e n8n  
**Endpoint:** `https://galactic-ai.app.n8n.cloud/webhook/test-integration`  
**Complexidade:** ⭐ Simples

### 2. WF-WEBHOOK-01: Receptor Principal
**Arquivo:** `WF-WEBHOOK-01-Receptor-Principal.json`  
**Função:** Receber e rotear todas as requisições do dashboard  
**Endpoint:** `https://galactic-ai.app.n8n.cloud/webhook/dashboard-request`  
**Complexidade:** ⭐⭐⭐ Intermediário

### 3. WF-WEBHOOK-02: Análise Territorial Simples
**Arquivo:** `WF-WEBHOOK-02-Analise-Territorial-Simples.json`  
**Função:** Gerar análises territoriais completas com LLM  
**Endpoint:** `https://galactic-ai.app.n8n.cloud/webhook/analise-territorial`  
**Complexidade:** ⭐⭐⭐⭐ Avançado

---

## 🚀 PASSO 1: IMPORTAR WORKFLOWS

### 1.1 Acessar n8n Cloud

1. Abra seu navegador
2. Acesse: https://galactic-ai.app.n8n.cloud
3. Faça login com suas credenciais

### 1.2 Importar Primeiro Workflow (Teste)

1. No menu lateral esquerdo, clique em **"Workflows"**
2. Clique no botão **"+ Add workflow"** (canto superior direito)
3. No novo workflow vazio, clique nos **3 pontinhos** (⋮) no canto superior direito
4. Selecione **"Import from File"**
5. Navegue até a pasta do projeto: `framework-v6-mvp/n8n/workflows/`
6. Selecione o arquivo: **`WF-TEST-INTEGRATION.json`**
7. Clique em **"Open"** ou **"Abrir"**
8. O workflow será carregado com todos os nós configurados
9. Clique em **"Save"** (canto superior direito) para salvar

### 1.3 Repetir para os Outros 2 Workflows

Repita o processo 1.2 para:
- `WF-WEBHOOK-01-Receptor-Principal.json`
- `WF-WEBHOOK-02-Analise-Territorial-Simples.json`

Após importar os 3 workflows, você verá todos eles na lista de workflows.

---

## 🔧 PASSO 2: CONFIGURAR CREDENCIAIS

Os workflows precisam de credenciais para acessar serviços externos (OpenAI e PostgreSQL).

### 2.1 Configurar Credencial OpenAI

**Necessário para:** WF-WEBHOOK-02 (Análise Territorial)

1. No menu lateral esquerdo, clique em **"Credentials"**
2. Clique em **"+ Add Credential"**
3. Na busca, digite: **"OpenAI"**
4. Selecione **"OpenAI"**
5. Preencha os campos:
   - **Credential Name:** `OpenAI - Framework V6.0`
   - **API Key:** `<SUA_CHAVE_OPENAI>`
   - **Organization ID:** (deixe vazio)
6. Clique em **"Save"**

**Como obter a API Key da OpenAI:**
- Acesse: https://platform.openai.com/api-keys
- Faça login
- Clique em "Create new secret key"
- Copie a chave (você não poderá vê-la novamente!)
- Cole no campo "API Key" do n8n

### 2.2 Configurar Credencial PostgreSQL (Replit)

**Necessário para:** WF-WEBHOOK-02 (Análise Territorial)

1. No menu lateral esquerdo, clique em **"Credentials"**
2. Clique em **"+ Add Credential"**
3. Na busca, digite: **"Postgres"**
4. Selecione **"Postgres"**
5. Preencha os campos:

**Onde encontrar os dados do PostgreSQL no Replit:**

1. Abra seu projeto Replit: https://replit.com/@seu-usuario/framework-v6-dashboard
2. No painel lateral esquerdo, clique em **"Tools"** (ícone de chave inglesa)
3. Clique em **"PostgreSQL"**
4. Você verá a **"Connection String"** no formato:
   ```
   postgresql://usuario:senha@host:5432/database
   ```
5. Extraia cada parte:
   - **Host:** A parte após `@` e antes de `:5432`
   - **Database:** A parte após o último `/`
   - **User:** A parte entre `://` e `:`
   - **Password:** A parte entre o segundo `:` e `@`
   - **Port:** `5432` (padrão)

**Exemplo de Connection String:**
```
postgresql://replit:abc123xyz@db.replit.com:5432/framework_v6
```

**Extração:**
- Host: `db.replit.com`
- Database: `framework_v6`
- User: `replit`
- Password: `abc123xyz`
- Port: `5432`

**Preencha no n8n:**
- **Credential Name:** `PostgreSQL - Replit - Framework V6.0`
- **Host:** (cole o host extraído)
- **Database:** (cole o database extraído)
- **User:** (cole o user extraído)
- **Password:** (cole o password extraído)
- **Port:** `5432`
- **SSL:** Marque a opção **"Use SSL"** (Replit exige SSL)

6. Clique em **"Test Connection"**
   - Se aparecer **"Connection successful"** ✅ → Prossiga
   - Se aparecer erro ❌ → Verifique os dados e tente novamente

7. Clique em **"Save"**

---

## 🔗 PASSO 3: VINCULAR CREDENCIAIS AOS WORKFLOWS

Após criar as credenciais, você precisa vinculá-las aos nós dos workflows.

### 3.1 Vincular Credencial OpenAI

1. Abra o workflow: **WF-WEBHOOK-02: Análise Territorial Simples**
2. Clique no nó: **"Gerar Análise com OpenAI"**
3. No painel lateral direito, procure o campo **"Credential to connect with"**
4. Clique no dropdown e selecione: **"OpenAI - Framework V6.0"**
5. Clique em **"Save"** (canto superior direito do workflow)

### 3.2 Vincular Credencial PostgreSQL

1. Ainda no workflow: **WF-WEBHOOK-02: Análise Territorial Simples**
2. Clique no nó: **"Consultar Dados PostgreSQL"**
3. No painel lateral direito, procure o campo **"Credential to connect with"**
4. Clique no dropdown e selecione: **"PostgreSQL - Replit - Framework V6.0"**
5. Repita para o nó: **"Salvar Análise no PostgreSQL"**
6. Clique em **"Save"** (canto superior direito do workflow)

---

## ✅ PASSO 4: ATIVAR WORKFLOWS

Os workflows precisam ser ativados para que os webhooks funcionem.

### 4.1 Ativar WF-TEST-INTEGRATION

1. Abra o workflow: **WF-TEST-INTEGRATION**
2. No canto superior direito, você verá um toggle **"Inactive"**
3. Clique no toggle para mudar para **"Active"** (ficará verde)
4. O workflow agora está ativo e pronto para receber requisições

### 4.2 Ativar WF-WEBHOOK-01

1. Abra o workflow: **WF-WEBHOOK-01: Receptor Principal Dashboard**
2. Ative o toggle: **"Inactive"** → **"Active"**

### 4.3 Ativar WF-WEBHOOK-02

1. Abra o workflow: **WF-WEBHOOK-02: Análise Territorial Simples**
2. Ative o toggle: **"Inactive"** → **"Active"**

---

## 🧪 PASSO 5: TESTAR WORKFLOWS

Agora vamos testar se os workflows estão funcionando corretamente.

### 5.1 Obter URLs dos Webhooks

Quando você ativa um workflow com webhook, o n8n gera automaticamente a URL.

**Para obter a URL:**

1. Abra o workflow (ex: **WF-TEST-INTEGRATION**)
2. Clique no nó **"Webhook - Recebe Teste"**
3. No painel lateral direito, você verá o campo **"Webhook URLs"**
4. Copie a URL de **"Production URL"**
   - Formato: `https://galactic-ai.app.n8n.cloud/webhook/test-integration`

**URLs dos 3 workflows:**

- **WF-TEST-INTEGRATION:**  
  `https://galactic-ai.app.n8n.cloud/webhook/test-integration`

- **WF-WEBHOOK-01:**  
  `https://galactic-ai.app.n8n.cloud/webhook/dashboard-request`

- **WF-WEBHOOK-02:**  
  `https://galactic-ai.app.n8n.cloud/webhook/analise-territorial`

### 5.2 Testar com cURL (Linha de Comando)

Abra um terminal e execute os comandos abaixo para testar cada webhook.

#### Teste 1: WF-TEST-INTEGRATION

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/test-integration \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": 1,
    "territory_name": "Tocantins",
    "test_message": "Teste de integração"
  }'
```

**Resposta esperada:**

```json
{
  "success": true,
  "message": "✅ Integração funcionando perfeitamente!",
  "received_data": {
    "territory_id": 1,
    "territory_name": "Tocantins",
    "test_message": "Teste de integração"
  },
  "n8n_info": {
    "workflow": "WF-TEST-INTEGRATION",
    "instance": "galactic-ai.app.n8n.cloud",
    "processed_at": "2025-11-16T12:00:00.000Z"
  },
  "next_steps": [
    "✅ Webhook configurado corretamente",
    "✅ Comunicação dashboard → n8n estabelecida",
    "🚀 Pronto para implementar workflows de análise"
  ]
}
```

#### Teste 2: WF-WEBHOOK-01 (Receptor Principal)

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/dashboard-request \
  -H "Content-Type: application/json" \
  -d '{
    "request_type": "analysis",
    "territory_id": 1,
    "territory_name": "Palmas",
    "dimension": "economic",
    "parameters": {
      "year": 2023
    }
  }'
```

**Resposta esperada:**

```json
{
  "request_id": "req_1700000000000_abc123",
  "status": "processing",
  "message": "🚀 Análise em processamento",
  "territory": {
    "id": 1,
    "name": "Palmas"
  },
  "dimension": "economic",
  "estimated_time": "30-60 segundos",
  "next_step": "Aguarde enquanto os agentes especializados geram a análise",
  "workflow": "WF-ANALYSIS-DIMENSIONAL (a ser implementado)",
  "timestamp": "2025-11-16T12:00:00.000Z"
}
```

#### Teste 3: WF-WEBHOOK-02 (Análise Territorial)

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/analise-territorial \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": 1,
    "territory_name": "Palmas",
    "year": 2023
  }'
```

**Resposta esperada:**

```json
{
  "success": true,
  "request_id": "analysis_1700000000000",
  "territory": {
    "id": 1,
    "name": "Palmas",
    "type": "municipality"
  },
  "year": 2023,
  "analysis": {
    "text": "# Análise Territorial: Palmas\n\n## Resumo Executivo\n...",
    "format": "markdown",
    "generated_at": "2025-11-16T12:00:00.000Z",
    "model": "gpt-4o-mini",
    "workflow": "WF-WEBHOOK-02"
  },
  "indicators_analyzed": {
    "economic": 3,
    "social": 3,
    "territorial": 2,
    "environmental": 2
  },
  "metadata": {
    "processing_time_ms": 2500,
    "n8n_instance": "galactic-ai.app.n8n.cloud",
    "version": "1.0.0"
  }
}
```

### 5.3 Testar com Postman ou Insomnia

Se preferir uma interface gráfica:

1. Abra **Postman** ou **Insomnia**
2. Crie uma nova requisição **POST**
3. Cole a URL do webhook
4. Em **Headers**, adicione:
   - `Content-Type: application/json`
5. Em **Body**, selecione **"raw"** e **"JSON"**
6. Cole o payload de teste (veja exemplos acima)
7. Clique em **"Send"**
8. Verifique a resposta

---

## 🔍 PASSO 6: MONITORAR EXECUÇÕES

O n8n permite visualizar todas as execuções dos workflows.

### 6.1 Acessar Histórico de Execuções

1. No menu lateral esquerdo, clique em **"Executions"**
2. Você verá uma lista de todas as execuções recentes
3. Cada execução mostra:
   - **Workflow:** Nome do workflow executado
   - **Status:** Success ✅ ou Error ❌
   - **Started:** Data e hora de início
   - **Execution Time:** Tempo de processamento

### 6.2 Visualizar Detalhes de uma Execução

1. Clique em qualquer execução da lista
2. Você verá o workflow com os dados que passaram por cada nó
3. Clique em cada nó para ver:
   - **Input:** Dados de entrada
   - **Output:** Dados de saída
   - **Execution Data:** Metadados da execução

### 6.3 Depurar Erros

Se uma execução falhar (❌):

1. Abra a execução com erro
2. O nó que falhou estará marcado em vermelho
3. Clique no nó vermelho
4. Veja a mensagem de erro no painel lateral
5. Corrija o problema (credenciais, query SQL, etc.)
6. Teste novamente

---

## 📊 PASSO 7: PRÓXIMOS PASSOS

Após importar e testar os workflows, você está pronto para:

### 7.1 Integrar com o Dashboard Replit

Adicione código no dashboard para chamar os webhooks do n8n:

```javascript
// Exemplo: Chamar análise territorial do n8n
async function requestTerritorialAnalysis(territoryId, year) {
  const response = await fetch('https://galactic-ai.app.n8n.cloud/webhook/analise-territorial', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      territory_id: territoryId,
      territory_name: 'Palmas',
      year: year
    })
  });
  
  const data = await response.json();
  return data;
}
```

### 7.2 Expandir para Mais Agentes

Com a base estabelecida, você pode criar novos workflows para:

- **Agente ECON:** Análise econômica detalhada
- **Agente SOCIAL:** Análise social e demográfica
- **Agente AMBIENT:** Análise ambiental e sustentabilidade
- **Agente Data Collector:** Coleta automática de dados de APIs governamentais

### 7.3 Implementar Orquestrador (Meta-LLM)

Criar workflow que:
1. Recebe pergunta complexa do usuário
2. Identifica quais agentes acionar
3. Distribui tarefas em paralelo
4. Consolida respostas
5. Retorna análise integrada

---

## 🆘 SOLUÇÃO DE PROBLEMAS

### Problema 1: Webhook retorna 404

**Causa:** Workflow não está ativo  
**Solução:** Ative o workflow (toggle "Active")

### Problema 2: Erro de credencial no PostgreSQL

**Causa:** Credenciais incorretas ou SSL não configurado  
**Solução:**
1. Verifique a Connection String do Replit
2. Certifique-se de marcar "Use SSL"
3. Teste a conexão no n8n

### Problema 3: Erro de credencial no OpenAI

**Causa:** API Key inválida ou expirada  
**Solução:**
1. Gere nova API Key em https://platform.openai.com/api-keys
2. Atualize a credencial no n8n
3. Teste novamente

### Problema 4: Timeout na execução

**Causa:** Query SQL muito lenta ou LLM demorando  
**Solução:**
1. Otimize a query SQL (adicione índices)
2. Reduza max_tokens no nó OpenAI
3. Aumente o timeout do workflow (Settings → Execution Timeout)

### Problema 5: CORS error no dashboard

**Causa:** Headers CORS não configurados  
**Solução:**
1. Verifique se o nó "Responder ao Dashboard" tem os headers:
   - `Access-Control-Allow-Origin: *`
   - `Access-Control-Allow-Methods: POST, OPTIONS`
   - `Access-Control-Allow-Headers: Content-Type, Authorization`

---

## 📚 RECURSOS ADICIONAIS

### Documentação Oficial n8n
- **Webhooks:** https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.webhook/
- **PostgreSQL:** https://docs.n8n.io/integrations/builtin/app-nodes/n8n-nodes-base.postgres/
- **OpenAI:** https://docs.n8n.io/integrations/builtin/cluster-nodes/root-nodes/n8n-nodes-langchain.lmchatopenai/

### Comunidade n8n
- **Forum:** https://community.n8n.io/
- **Discord:** https://discord.gg/n8n
- **GitHub:** https://github.com/n8n-io/n8n

---

## ✅ CHECKLIST DE CONFIGURAÇÃO

Use este checklist para garantir que tudo está configurado:

- [ ] Conta n8n Cloud criada e acessível
- [ ] 3 workflows importados (TEST, WEBHOOK-01, WEBHOOK-02)
- [ ] Credencial OpenAI criada e testada
- [ ] Credencial PostgreSQL criada e testada
- [ ] Credenciais vinculadas aos workflows
- [ ] 3 workflows ativados (toggle "Active")
- [ ] URLs dos webhooks copiadas
- [ ] Teste 1 (WF-TEST-INTEGRATION) executado com sucesso
- [ ] Teste 2 (WF-WEBHOOK-01) executado com sucesso
- [ ] Teste 3 (WF-WEBHOOK-02) executado com sucesso
- [ ] Histórico de execuções verificado (sem erros)
- [ ] Dashboard Replit atualizado com URLs dos webhooks

---

## 🎉 CONCLUSÃO

Parabéns! Você configurou com sucesso a integração entre o dashboard Replit e o sistema multi-agentes n8n Cloud.

**O que você consegue fazer agora:**

✅ Receber requisições do dashboard via webhooks  
✅ Validar e rotear requisições para workflows específicos  
✅ Gerar análises territoriais completas com LLM  
✅ Consultar dados do PostgreSQL  
✅ Salvar análises geradas no banco  
✅ Retornar respostas estruturadas ao dashboard  
✅ Monitorar execuções e depurar erros

**Próximos passos:**

🚀 Integrar webhooks no código do dashboard  
🚀 Criar workflows para os 4 agentes dimensionais (ECON, SOCIAL, TERRA, AMBIENT)  
🚀 Implementar Orquestrador (Meta-LLM)  
🚀 Adicionar coleta automática de dados (Data Collector)

---

**Dúvidas ou problemas?**  
Consulte a seção "Solução de Problemas" ou abra uma issue no repositório GitHub.

**Autor:** Manus AI  
**Data:** 16 de novembro de 2025  
**Versão:** 1.0.0
