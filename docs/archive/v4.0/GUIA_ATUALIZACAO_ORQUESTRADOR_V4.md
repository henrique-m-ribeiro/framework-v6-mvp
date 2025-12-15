# Guia de Atualização do Orquestrador para Arquitetura V4

**Data:** 08/12/2025  
**Sessão:** #13  
**Objetivo:** Implementar a Arquitetura V4 (IDs Semânticos + Metadados Estruturados) no Orquestrador.

---

## 🎯 Visão Geral da Mudança

O Orquestrador se tornará um **interpretador de intenções**. Ele irá analisar a pergunta do usuário, estruturar os metadados da análise e gerar um payload completo para os agentes.

## 📋 Passos de Implementação

### Passo 1: Adicionar Nó "OpenAI - Interpretar Requisição"

1.  Logo após o nó **"Webhook - Recebe Requisição"**, adicione um novo nó **"OpenAI Chat Model"**.
2.  **Renomeie** para: `OpenAI - Interpretar Requisição`.
3.  Configure o nó:
    *   **Model:** `gpt-4.1-mini`
    *   **JSON Mode:** `true` (Habilitado)
    *   **Prompt:**

        ```
        Você é um especialista em análise de dados territoriais. Analise a pergunta do usuário e extraia as seguintes informações em formato JSON:

        - "analysis_scope": "unidimensional" ou "multidimensional"
        - "territory_scope": "uniterritorial" ou "multiterritorial"
        - "dimensions": um array com as dimensões (economic, social, terra, ambient)
        - "territories": um array de objetos, cada um com "id" e "name" do território.

        Pergunta do usuário: "{{ $("Webhook - Recebe Requisição").first().json.body.question }}"

        Base de territórios para consulta:
        - Palmas: 1721000
        - Araguaína: 1702109
        - Gurupi: 1709500

        Responda APENAS com o objeto JSON.
        ```

### Passo 2: Adicionar Nó "Set Payload V4"

1.  Após o nó `OpenAI - Interpretar Requisição`, adicione um nó **"Set"**.
2.  **Renomeie** para: `Set Payload V4`.
3.  Configure-o para criar o payload completo, combinando a entrada original com a interpretação da IA.

    | Name | Value |
    | :--- | :--- |
    | `request_id` | `{{ $now.format("YYYYMMDDHHmmss") }}-req-{{ $("Webhook - Recebe Requisição").first().json.body.territory_id }}` |
    | `question` | `{{ $("Webhook - Recebe Requisição").first().json.body.question }}` |
    | `analysis_scope` | `{{ $("OpenAI - Interpretar Requisição").first().json.message.analysis_scope }}` |
    | `territory_scope` | `{{ $("OpenAI - Interpretar Requisição").first().json.message.territory_scope }}` |
    | `dimensions` | `{{ $("OpenAI - Interpretar Requisição").first().json.message.dimensions }}` |
    | `territories` | `{{ $("OpenAI - Interpretar Requisição").first().json.message.territories }}` |

### Passo 3: Atualizar Chamada aos Agentes (HTTP Request)

1.  No nó **"HTTP Request - Chamar Agente"**, no `Body`, envie o payload completo:

    ```json
    {{ JSON.stringify($json) }}
    ```

### Passo 4: Atualizar Query de Salvamento (Knowledge Base)

1.  No nó **"PostgreSQL - Salvar na Knowledge Base"**, atualize a query para incluir os novos campos de metadados.

    ```sql
    INSERT INTO knowledge_base (
      id, -- analysis_id retornado pelo agente
      request_id,
      analysis_scope,
      territory_scope,
      dimensions,
      territories,
      -- outros campos...
    )
    VALUES (
      -- O ID da análise agora vem do agente
      -- e já contém o request_id e a dimensão
      -- Ex: 20251208-req-1721000-economic
      '{{ $input.first().json.analysis_id }}',
      
      -- Os metadados vêm do agente, que os recebeu do Orquestrador
      '{{ $input.first().json.request_id }}',
      '{{ $input.first().json.analysis_scope }}',
      '{{ $input.first().json.territory_scope }}',
      ARRAY(SELECT jsonb_array_elements_text(
        '{{ JSON.stringify($input.first().json.dimensions) }}'::jsonb
      )),
      '{{ JSON.stringify($input.first().json.territories) }}'::jsonb,
      -- outros valores...
    )
    ```

---

## 📈 Diagrama de Fluxo de Dados (V4)

```mermaid
graph TD
    A[Webhook] --> B{Interpretar Requisição};
    B --> C{Set Payload V4};
    C --> D[Roteador Inteligente];
    D --> E{HTTP Request para Agente(s)};
    E --> F[Agente Especialista];
    F --> G[Resposta do Agente com Metadados];
    G --> H(Salvar na Knowledge Base);
    H --> I[Respond to Webhook];
```
