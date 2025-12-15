# Guia de Atualização dos Agentes para IDs Semânticos

**Data:** 08/12/2025  
**Sessão:** #13  
**Objetivo:** Modificar os Agentes Especialistas para receber e utilizar o ID semântico gerado pelo Orquestrador.

---

## 🎯 Visão Geral da Mudança

Os agentes deixarão de se preocupar com a geração de IDs. Eles irão receber o `analysis_id` do Orquestrador, usá-lo em suas operações internas e retorná-lo na resposta final. Isso garante a rastreabilidade completa da análise.

## 📋 Passos de Implementação (Para Cada Agente)

**Aplique estes passos para os workflows dos agentes ECON, SOCIAL, TERRA e AMBIENT.**

### Passo 1: Atualizar Nó "Preparar Dados para Salvar"

Este nó do tipo "Set" prepara os dados antes de serem salvos na memória e retornados ao Orquestrador. Precisamos garantir que ele inclua o `analysis_id` recebido.

1.  **Abra o workflow** de um dos agentes (ex: `WF-AGENT-ECON-EspecialistaEconômicoV6.1(Multidimensional)(4).json`).
2.  Clique no nó **"Preparar Dados para Salvar"**.
3.  **Adicione um novo campo** para o `analysis_id`:

    | Name | Value |
    | :--- | :--- |
    | `analysis_id` | `{{ $("Webhook - Recebe Tarefa").first().json.body.analysis_id }}` |

    **Observação:** Se o seu webhook se chama "Webhook - Recebe Requisição", ajuste o nome da expressão.

### Passo 2: Atualizar Nó "Salvar na Memória"

Agora, vamos usar o `analysis_id` recebido na query de inserção no banco de dados da memória do agente.

1.  Clique no nó **"Salvar na Memória"** (PostgreSQL).
2.  Atualize a query SQL para usar o `analysis_id` que vem do payload.

    **Linha a ser alterada na query:**

    ```sql
    -- ANTES (gerava automaticamente ou estava com erro)
    -- gen_random_uuid(),

    -- DEPOIS (usa o ID do payload)
    -- Note que agora usamos $json, pois o nó anterior é o "Preparar Dados para Salvar"
    -- que já contém o analysis_id
    '{{ $json.analysis_id }}',
    ```

    **Query Completa Corrigida (Exemplo para `agent_econ_memory`):**

    ```sql
    INSERT INTO agent_econ_memory (
      id,
      agent_id,
      territory_id,
      analysis_content,
      analysis_summary,
      confidence_score,
      metadata,
      time_range,
      data_sources,
      indicators_used,
      created_at,
      updated_at
    )
    VALUES (
      '{{ $json.analysis_id }}', -- ID vem do Orquestrador
      'econ',
      '{{ $json.territory_id }}',
      '{{ $json.analysis_content }}',
      '{{ $json.analysis_summary }}',
      {{ $json.confidence_score || 0.75 }},
      '{{ $json.metadata || "{}" }}'::jsonb,
      '{{ $json.time_range || "{}" }}'::jsonb,
      '{{ $json.data_sources || "[]" }}'::jsonb,
      '{{ $json.indicators_used || "[]" }}'::jsonb,
      NOW(),
      NOW()
    )
    ON CONFLICT (id) DO UPDATE SET
      analysis_content = EXCLUDED.analysis_content,
      analysis_summary = EXCLUDED.analysis_summary,
      confidence_score = EXCLUDED.confidence_score,
      metadata = EXCLUDED.metadata,
      updated_at = NOW()
    RETURNING id, agent_id, territory_id, created_at;
    ```

### Passo 3: Verificar o Nó "Respond to Webhook"

Nenhuma mudança é necessária aqui se ele já estiver configurado para retornar todos os dados do nó anterior ("Preparar Dados para Salvar"). Apenas confirme que a configuração está correta:

*   **Respond With:** `All Incoming Items`
*   **Settings -> Always Output Data:** `true` (Habilitado)

---

## 🔁 Processo de Replicação

Depois de corrigir o primeiro agente (ECON), o processo para os outros é muito similar:

1.  **Abra o workflow** do próximo agente (SOCIAL, TERRA, AMBIENT).
2.  **Adicione o campo `analysis_id`** no nó "Preparar Dados para Salvar".
3.  **Atualize a query SQL** no nó "Salvar na Memória", mudando apenas o nome da tabela (ex: `agent_social_memory`) e o `agent_id` (ex: `'social'`).

## ✅ Verificação

O `analysis_id` recebido pelo webhook do agente deve ser o mesmo salvo na sua tabela de memória e retornado na resposta para o Orquestrador.
