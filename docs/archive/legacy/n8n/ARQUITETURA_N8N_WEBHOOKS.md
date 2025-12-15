# Arquitetura de Webhooks e Workflows n8n
**Framework de Inteligência Territorial V6.0**  
**Data:** 16 de novembro de 2025  
**Autor:** Manus AI  
**Versão:** 1.0.0

---

## 🎯 OBJETIVO

Este documento detalha a arquitetura de webhooks e os workflows criados no n8n Cloud para servir como o backend de geração de conhecimento para o dashboard do Framework V6.0. Ele descreve a função de cada workflow, seus endpoints, payloads esperados e a lógica de processamento.

---

## 🏗️ ARQUITETURA GERAL

A comunicação entre o Dashboard (Replit) e o Sistema Multi-Agentes (n8n) é baseada em uma arquitetura de webhooks. O dashboard atua como o cliente, enviando requisições HTTP POST para endpoints específicos no n8n, que processam a requisição e retornam uma resposta em JSON.

**Fluxo de Comunicação:**

1.  **Dashboard (Frontend):** O usuário interage com a interface (clica em um botão, envia uma mensagem no chat).
2.  **N8N Client (JavaScript):** O `n8n-client.js` no dashboard formata um payload JSON e envia uma requisição `POST` para o webhook apropriado no n8n.
3.  **n8n Cloud (Backend):**
    *   O nó **Webhook** recebe a requisição.
    *   O workflow processa os dados, consultando o banco de dados (PostgreSQL) e/ou usando modelos de linguagem (OpenAI) conforme necessário.
    *   O workflow pode salvar novos dados ou análises no banco de dados.
    *   O nó **Respond to Webhook** envia uma resposta JSON de volta para o dashboard.
4.  **Dashboard (Frontend):** O `n8n-client.js` recebe a resposta e a exibe na interface do usuário.

**Vantagens desta Arquitetura:**

-   **Desacoplamento:** O frontend (dashboard) e o backend (n8n) são sistemas independentes, facilitando a manutenção e evolução de cada um.
-   **Escalabilidade:** O n8n Cloud pode escalar para lidar com um grande volume de requisições, sem impactar a performance do dashboard.
-   **Segurança:** As credenciais de serviços externos (OpenAI, PostgreSQL) são armazenadas de forma segura no n8n e nunca são expostas no frontend.
-   **Flexibilidade:** É fácil adicionar novos agentes ou funcionalidades criando novos workflows e endpoints, sem precisar modificar a arquitetura central.

---

## 📦 DETALHAMENTO DOS WORKFLOWS

Foram criados 3 workflows iniciais para estabelecer e testar a arquitetura.

### Workflow 1: `WF-TEST-INTEGRATION`

-   **Arquivo:** `WF-TEST-INTEGRATION.json`
-   **Objetivo:** Um workflow de "ping" para validar a conectividade básica entre o dashboard e o n8n.
-   **Complexidade:** ⭐ (Simples)

#### Endpoint

-   **Método:** `POST`
-   **URL:** `https://galactic-ai.app.n8n.cloud/webhook/test-integration`

#### Payload Esperado

```json
{
  "territory_id": 1,
  "territory_name": "Tocantins",
  "test_message": "Teste de integração"
}
```

#### Lógica do Workflow

1.  **Webhook - Recebe Teste:** Recebe a requisição POST.
2.  **Processar Teste (Nó de Código):**
    *   Extrai os dados do payload.
    *   Gera um timestamp.
    *   Constrói um objeto JSON de sucesso, ecoando os dados recebidos e adicionando informações sobre o processamento.
3.  **Responder ao Dashboard:** Envia a resposta JSON de volta com status `200 OK`.

#### Resposta de Sucesso

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
    "processed_at": "2025-11-16T18:00:00.000Z"
  }
}
```

---

### Workflow 2: `WF-WEBHOOK-01-Receptor-Principal`

-   **Arquivo:** `WF-WEBHOOK-01-Receptor-Principal.json`
-   **Objetivo:** Atuar como um roteador central (API Gateway) para a maioria das requisições do dashboard, validando e encaminhando-as para os fluxos apropriados.
-   **Complexidade:** ⭐⭐⭐ (Intermediário)

#### Endpoint

-   **Método:** `POST`
-   **URL:** `https://galactic-ai.app.n8n.cloud/webhook/dashboard-request`

#### Payload Esperado

```json
{
  "request_type": "analysis" | "data_collection" | "comparison",
  "territory_id": 1,
  "dimension": "economic" | "social" | "territorial" | "environmental",
  "parameters": { "year": 2023, "comparison_territories": [2, 3] },
  "user_id": "user@example.com"
}
```

#### Lógica do Workflow

1.  **Webhook - Recebe Requisição:** Ponto de entrada para as requisições.
2.  **Validar Requisição (Nó de Código):**
    *   Verifica a presença de campos obrigatórios (`request_type`, `territory_id`, `dimension`).
    *   Valida se os valores de `request_type` e `dimension` são permitidos.
    *   Se a validação falhar, retorna um erro `400` com uma mensagem clara.
    *   Se for válido, enriquece o payload com um `request_id` e `timestamp`.
3.  **Rotear Requisição (Nó Switch):**
    *   Usa o campo `request_type` para decidir para qual fluxo a requisição deve ir.
    *   **Output 0 (`analysis`):** Encaminha para o nó que processa análises.
    *   **Output 1 (`data_collection`):** Encaminha para o nó de coleta de dados.
    *   **Output 2 (`comparison`):** Encaminha para o nó de comparação.
    *   **Output 3 (Default):** Trata qualquer `request_type` não reconhecido.
4.  **Nós de Processamento (MVP):**
    *   Atualmente, os nós `Processar Análise`, `Processar Coleta de Dados` e `Processar Comparação` são **simulações (placeholders)**. Eles retornam uma mensagem de confirmação de que a tarefa foi iniciada e o tempo estimado, mas ainda não executam a lógica completa.
5.  **Responder ao Dashboard:** Envia a resposta JSON de volta, com status `200 OK` para sucesso ou `400` para erros de validação.

---

### Workflow 3: `WF-WEBHOOK-02-Analise-Territorial-Simples`

-   **Arquivo:** `WF-WEBHOOK-02-Analise-Territorial-Simples.json`
-   **Objetivo:** Um workflow completo que demonstra uma capacidade de ponta a ponta: receber uma requisição, consultar o banco de dados, usar um LLM para gerar uma análise e salvar o resultado.
-   **Complexidade:** ⭐⭐⭐⭐ (Avançado)

#### Endpoint

-   **Método:** `POST`
-   **URL:** `https://galactic-ai.app.n8n.cloud/webhook/analise-territorial`

#### Payload Esperado

```json
{
  "territory_id": 1,
  "territory_name": "Palmas",
  "year": 2023
}
```

#### Lógica do Workflow

1.  **Webhook - Recebe Requisição de Análise:** Recebe a requisição do dashboard.
2.  **Consultar Dados PostgreSQL:**
    *   Executa uma query SQL que faz `JOIN` em 5 tabelas (`territories`, `economic_indicators`, etc.) para coletar todos os indicadores disponíveis para o `territory_id` e `year` especificados.
    *   Requer a credencial do PostgreSQL do Replit.
3.  **Preparar Contexto para LLM (Nó de Código):**
    *   Verifica se a consulta ao banco retornou dados. Se não, retorna um erro `404`.
    *   Estrutura os dados do banco em um objeto JSON limpo.
    *   Constrói um **prompt detalhado** para o LLM, formatando todos os indicadores de forma legível e instruindo o modelo a gerar uma análise estruturada (Resumo, Análise por Dimensão, Alertas, Recomendações).
4.  **Gerar Análise com OpenAI:**
    *   Envia o prompt para o modelo `gpt-4o-mini`.
    *   Usa uma temperatura de `0.7` para um bom equilíbrio entre precisão e fluidez.
    *   Requer a credencial da API da OpenAI.
5.  **Estruturar Resposta (Nó de Código):**
    *   Pega a resposta de texto do LLM e a combina com metadados (ID do território, ano, tempo de processamento, etc.) em um objeto JSON final.
6.  **Salvar Análise no PostgreSQL:**
    *   Executa uma query `INSERT ... ON CONFLICT` (upsert) para salvar a análise gerada na tabela `knowledge_base`. Isso cria um cache no banco de dados, de modo que análises futuras para o mesmo território/ano possam ser recuperadas instantaneamente.
7.  **Responder ao Dashboard:** Envia a resposta final estruturada para o dashboard com status `200 OK`.

---

## 🛠️ ARTEFATOS DE INTEGRAÇÃO E TESTE

Para suportar esta arquitetura, os seguintes artefatos foram criados:

| Artefato                         | Localização                                       | Descrição                                                                                             |
|----------------------------------|---------------------------------------------------|-------------------------------------------------------------------------------------------------------|
| **Cliente JavaScript**           | `dashboard/integration/n8n-client.js`             | Módulo que abstrai a comunicação com os webhooks do n8n, facilitando seu uso no código do dashboard.  |
| **Exemplo de Integração**        | `dashboard/integration/exemplo-integracao.html`   | Uma página HTML interativa para demonstrar e testar visualmente a integração com o `n8n-client.js`.    |
| **Guia de Integração**           | `dashboard/integration/README_INTEGRACAO.md`      | Instruções passo a passo sobre como adicionar o `n8n-client.js` ao projeto Replit.                  |
| **Script de Teste (Node.js)**    | `tests/test-n8n-integration.js`                   | Script de teste automatizado completo para CI/CD.                                                     |
| **Script de Teste (Bash)**       | `tests/test-n8n-integration.sh`                   | Script de teste simplificado para verificações rápidas.                                              |
| **Guia de Testes**               | `tests/README.md`                                 | Instruções sobre como executar os scripts de teste.                                                   |

---

## 🚀 PRÓXIMOS PASSOS

A arquitetura atual é a fundação para o sistema multi-agentes completo. Os próximos passos na evolução do backend n8n são:

1.  **Implementar a Lógica Real nos Placeholders:** Substituir os nós de simulação no `WF-WEBHOOK-01` por chamadas a outros workflows (usando o nó `Execute Workflow`).
2.  **Criar Workflows para Agentes Dimensionais:** Desenvolver workflows separados para cada agente (ECON, SOCIAL, TERRA, AMBIENT), cada um com sua lógica especializada.
3.  **Implementar o Orquestrador (Meta-LLM):** Criar um workflow que receba perguntas em linguagem natural, interprete a intenção do usuário e orquestre chamadas para os agentes dimensionais, consolidando as respostas em uma análise coesa.
4.  **Desenvolver o Agente Data Collector:** Criar um workflow agendado (`Cron`) que periodicamente consulta APIs de fontes de dados abertos (IBGE, INPE, etc.) e atualiza o banco de dados PostgreSQL, mantendo o sistema sempre atualizado.
