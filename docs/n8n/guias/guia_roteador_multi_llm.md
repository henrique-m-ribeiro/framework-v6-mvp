# Guia de Implementação: Roteador Inteligente Multi-LLM no n8n

Henrique, conforme solicitado, preparei um guia completo para você criar manualmente o nó do **Roteador Inteligente** no n8n. Este guia oferece a flexibilidade de usar diferentes modelos de LLM (OpenAI, Google Gemini, Anthropic Claude e Deepseek), preparando nosso sistema para o futuro.

---

## 🎯 Objetivo

Criar um nó no n8n que receba uma pergunta do usuário e a classifique em uma das quatro dimensões (**econ**, **social**, **terra**, **ambient**), retornando apenas o código da dimensão.

## 🧠 O Prompt (A Lógica Central)

O coração do nosso roteador é o prompt do sistema. Ele será praticamente o mesmo para todos os modelos. Apenas o local onde você o insere muda.

```text
Você é um roteador inteligente para um sistema de análise territorial.

Sua tarefa é classificar a pergunta do usuário em UMA das 4 dimensões:

1.  **econ** (Econômica): PIB, emprego, renda, setores econômicos, empresas, comércio, indústria, serviços
2.  **social** (Social): População, educação, saúde, segurança, assistência social, cultura, esporte
3.  **terra** (Territorial): Uso do solo, infraestrutura urbana, transporte, habitação, saneamento, planejamento urbano
4.  **ambient** (Ambiental): Meio ambiente, recursos naturais, poluição, áreas protegidas, clima, biodiversidade

RESPONDA APENAS COM O CÓDIGO DA DIMENSÃO (econ, social, terra ou ambient).
```

--- 

## 🛠️ Guia Passo a Passo: Configurando o Nó

Primeiro, delete o nó "OpenAI - Roteador Inteligente" que não está funcionando no seu workflow. Em seguida, adicione um novo nó e escolha uma das opções abaixo.

### ✅ Opção 1: OpenAI (Recomendado para Iniciar)

1.  **Adicionar Nó:** Busque e adicione o nó **OpenAI**.
2.  **Credenciais:** Conecte sua credencial da OpenAI.
3.  **Configuração:**
    *   **Resource:** `Text`
    *   **Operation:** `Generate a Chat Completion`
    *   **Model:** `gpt-4o-mini` (ótimo custo-benefício)
    *   **Messages:**
        *   Clique em **"Add Message"**.
        *   **Item 1 (System):**
            *   **Role:** `System`
            *   **Content:** Cole o prompt do sistema (acima).
        *   **Item 2 (User):**
            *   **Role:** `User`
            *   **Content (Expression):** `{{ $("Webhook - Recebe Requisição").first().json.body.question }}`
    *   **Options (Opcional, mas recomendado):**
        *   **Temperature:** `0.1` (para respostas consistentes)
        *   **Max Tokens:** `10` (só precisamos de uma palavra)
    *   **Simplify Output:** `Ativado` (retorna apenas o texto da resposta)

###  alternativa Opção 2: Google Gemini

1.  **Adicionar Nó:** Busque e adicione o nó **Google Gemini**.
2.  **Credenciais:** Conecte sua credencial do Google.
3.  **Configuração:**
    *   **Resource:** `Chat`
    *   **Operation:** `Send Message`
    *   **Model:** `gemini-1.5-flash-latest` (rápido e eficiente)
    *   **Message:**
        *   **Role:** `User`
        *   **Text (Expression):**
            ```
            SYSTEM: [COLE O PROMPT DO SISTEMA AQUI]
            
            USER: {{ $("Webhook - Recebe Requisição").first().json.body.question }}
            ```
    *   **Options (Opcional):**
        *   **Temperature:** `0.1`
        *   **Max Output Tokens:** `10`

###  alternativa Opção 3: Anthropic Claude

1.  **Adicionar Nó:** Busque e adicione o nó **Anthropic**.
2.  **Credenciais:** Conecte sua credencial da Anthropic.
3.  **Configuração:**
    *   **Resource:** `Chat`
    *   **Operation:** `Send Message`
    *   **Model:** `claude-3-haiku-20240307` (mais rápido da família Claude)
    *   **System Prompt:** Cole o prompt do sistema (acima).
    *   **Messages:**
        *   **Role:** `User`
        *   **Content (Expression):** `{{ $("Webhook - Recebe Requisição").first().json.body.question }}`
    *   **Options (Opcional):**
        *   **Temperature:** `0.1`
        *   **Max Tokens:** `10`

### 🚀 Opção 4: Deepseek (via HTTP Request)

Esta é a opção mais flexível, pois funciona para qualquer modelo que tenha uma API compatível com OpenAI.

1.  **Adicionar Nó:** Busque e adicione o nó **HTTP Request**.
2.  **Credenciais:** Nenhuma (a chave vai no Header).
3.  **Configuração:**
    *   **Method:** `POST`
    *   **URL:** `https://api.deepseek.com/v1/chat/completions`
    *   **Authentication:** `None`
    *   **Headers:**
        *   Clique em **"Add Header"**.
        *   **Name 1:** `Authorization`
        *   **Value 1:** `Bearer [SUA_CHAVE_API_DEEPSEEK]`
        *   **Name 2:** `Content-Type`
        *   **Value 2:** `application/json`
    *   **Body Content Type:** `JSON`
    *   **Body (Expression):**
        ```json
        {
          "model": "deepseek-chat",
          "messages": [
            {
              "role": "system",
              "content": "[COLE O PROMPT DO SISTEMA AQUI]"
            },
            {
              "role": "user",
              "content": "{{ $(\"Webhook - Recebe Requisição\").first().json.body.question }}"
            }
          ],
          "temperature": 0.1,
          "max_tokens": 10
        }
        ```

--- 

## 🔌 Passo Final: Atualizar o Nó Switch

O nó **Switch** precisa saber onde ler a resposta do LLM. O caminho muda dependendo do nó que você usou.

1.  Clique no nó **Switch**.
2.  Para cada uma das 4 regras (econ, social, terra, ambient), atualize o campo **Value 1** com a expressão correta:

    *   **Se usou OpenAI (com Simplify Output):**
        `{{ $json.message.toLowerCase().trim() }}`

    *   **Se usou Google Gemini:**
        `{{ $json.candidates[0].content.parts[0].text.toLowerCase().trim() }}`

    *   **Se usou Anthropic Claude:**
        `{{ $json.content[0].text.toLowerCase().trim() }}`

    *   **Se usou Deepseek (HTTP Request):**
        `{{ $json.choices[0].message.content.toLowerCase().trim() }}`

---

## 💡 Recomendação

Comece com a **Opção 1 (OpenAI)**. É a mais direta e bem documentada no n8n. Depois que o workflow estiver funcionando, você pode duplicá-lo e experimentar as outras opções para comparar performance e custo.

Estou à disposição para ajudar em cada passo da configuração. Apenas me diga qual opção você escolheu e podemos configurar juntos!
