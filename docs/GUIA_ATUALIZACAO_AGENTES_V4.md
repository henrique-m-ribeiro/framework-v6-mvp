# Guia de Atualização dos Agentes para Arquitetura V4

**Data:** 08/12/2025  
**Sessão:** #13  
**Objetivo:** Adaptar os Agentes para processar o payload V4 e gerar o `analysis_id`.

---

## 🎯 Visão Geral da Mudança

O Agente agora recebe um payload rico em metadados e é responsável por criar o `analysis_id` final, que identifica unicamente sua própria análise dentro de uma requisição maior.

## 📋 Passos de Implementação (Para Cada Agente)

### Passo 1: Adicionar Nó "Set Analysis ID"

1.  Logo após o nó **"Webhook - Recebe Tarefa"**, adicione um novo nó **"Set"**.
2.  **Renomeie** para: `Set Analysis ID`.
3.  Configure o nó para gerar o `analysis_id` e manter os outros dados.

    *   **Keep Only Set:** `false` (Desabilitado - queremos manter os dados do webhook)
    *   **Add Field:**

        | Name | Value |
        | :--- | :--- |
        | `analysis_id` | `{{ $("Webhook - Recebe Tarefa").first().json.body.request_id }}-economic` (Mude `economic` para `social`, `terra`, etc. em cada agente) |

### Passo 2: Atualizar Nó "Preparar Dados para Salvar"

1.  Clique no nó **"Preparar Dados para Salvar"**.
2.  Certifique-se de que ele está passando **todos os campos de metadados** recebidos do Orquestrador, além do `analysis_id` gerado no passo anterior.

    **Campos a garantir que existem:**
    - `analysis_id` (do nó `Set Analysis ID`)
    - `request_id` (do webhook)
    - `analysis_scope` (do webhook)
    - `territory_scope` (do webhook)
    - `dimensions` (do webhook)
    - `territories` (do webhook)
    - `analysis_content` (gerado pela IA)
    - `analysis_summary` (gerado pela IA)
    - etc.

### Passo 3: Atualizar Nó "Salvar na Memória"

1.  Clique no nó **"Salvar na Memória"** (PostgreSQL).
2.  Atualize a query para inserir os novos campos de metadados.

    ```sql
    INSERT INTO agent_econ_memory (
      id, -- analysis_id
      request_id,
      analysis_scope,
      territory_scope,
      dimensions,
      territories,
      -- outros campos...
    )
    VALUES (
      -- O ID da análise foi gerado no nó "Set Analysis ID"
      -- e está disponível no nó anterior ("Preparar Dados para Salvar")
      -- que é o $json deste nó.
      '{{ $json.analysis_id }}',
      
      -- Os metadados vêm do mesmo lugar
      '{{ $json.request_id }}',
      '{{ $json.analysis_scope }}',
      '{{ $json.territory_scope }}',
      ARRAY(SELECT jsonb_array_elements_text(
        '{{ JSON.stringify($json.dimensions) }}'::jsonb
      )),
      '{{ JSON.stringify($json.territories) }}'::jsonb,
      -- outros valores...
    )
    ```

    **Nota sobre `ARRAY(...)`:** Esta sintaxe converte o array JSON do n8n para o formato de array de texto do PostgreSQL. É crucial para a consistência dos dados.

### Passo 4: Verificar o Nó "Respond to Webhook"

Nenhuma mudança é necessária aqui, desde que ele retorne todos os dados do nó "Preparar Dados para Salvar". Isso garantirá que o Orquestrador receba de volta todos os metadados e o `analysis_id`.

---

## ✅ Verificação

Após a mudança, o fluxo de dados para um agente será:

1.  **Orquestrador envia:** `request_id`, `dimensions`, `territories`, etc.
2.  **Agente cria:** `analysis_id` = `request_id` + `-economic`.
3.  **Agente salva na memória:** `id` = `analysis_id`, e todos os outros metadados.
4.  **Agente retorna para o Orquestrador:** `analysis_id` e todos os metadados.
