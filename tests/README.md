# Guia de Testes Automatizados - Integração n8n
**Framework de Inteligência Territorial V6.0**  
**Data:** 16 de novembro de 2025  
**Autor:** Manus AI  
**Versão:** 1.0.0

---

## 🎯 OBJETIVO

Este guia explica como executar os scripts de teste automatizados para validar a integração entre o dashboard Replit e o sistema multi-agentes n8n Cloud. A automação de testes é crucial para garantir a estabilidade, confiabilidade e performance da comunicação entre os dois sistemas.

---

## 📂 SCRIPTS DE TESTE

Foram criados dois scripts de teste com propósitos diferentes:

### 1. `test-n8n-integration.js` (Node.js)

**Descrição:** Um script de teste completo e robusto, ideal para ser executado em ambientes de desenvolvimento e integração contínua (CI/CD).

**Vantagens:**
- **Completo:** Testa múltiplos cenários, incluindo casos de sucesso e de erro.
- **Detalhado:** Fornece um resumo detalhado com taxa de sucesso, tempo de execução e lista de falhas.
- **Flexível:** Fácil de expandir com novos casos de teste.
- **Cores:** Usa cores para facilitar a leitura dos resultados no terminal.

**Requisitos:**
- Node.js instalado (versão 16 ou superior).

### 2. `test-n8n-integration.sh` (Bash)

**Descrição:** Um script de teste simplificado que usa `curl` para fazer requisições. Ideal para testes rápidos e ambientes onde Node.js não está disponível.

**Vantagens:**
- **Simples:** Depende apenas de `curl` e `bash`, disponíveis na maioria dos sistemas.
- **Rápido:** Execução imediata sem necessidade de instalar dependências.
- **Portátil:** Funciona em qualquer terminal Linux ou macOS.

**Requisitos:**
- `curl` instalado.
- Um shell compatível com Bash.

---

## 🚀 COMO EXECUTAR OS TESTES

**Pré-requisito:** Antes de executar os testes, você **DEVE** ter importado e ativado os 3 workflows no seu n8n Cloud, conforme o `GUIA_IMPORTACAO_WORKFLOWS.md`.

### Opção A: Script Completo (Node.js) - Recomendado

1.  **Navegue até a pasta de testes:**

    ```bash
    cd /caminho/para/o/projeto/framework-v6-mvp/tests
    ```

2.  **Execute o script:**

    ```bash
    node test-n8n-integration.js
    ```

3.  **Analise o resultado:**

    O script executará 7 testes em sequência e exibirá um resumo no final. Se todos os testes passarem, você verá uma mensagem de sucesso em verde. Se algum teste falhar, ele será listado em vermelho com o motivo da falha.

    **Exemplo de Saída (Sucesso):**

    ```
    ╔════════════════════════════════════════════════════════════╗
    ║  Teste de Integração Dashboard ↔ n8n Cloud                ║
    ╚════════════════════════════════════════════════════════════╝

    [1/7] Teste 1: Integração Básica
      ✓ PASSOU (350ms)

    [2/7] Teste 2: Receptor Principal - Análise Econômica
      ✓ PASSOU (210ms)

    ...

    ╔════════════════════════════════════════════════════════════╗
    ║  RESUMO DOS TESTES                                         ║
    ╚════════════════════════════════════════════════════════════╝

    Total de testes:    7
    Testes aprovados:   7
    Testes falhados:    0
    Taxa de sucesso:    100.0%

    ╔════════════════════════════════════════════════════════════╗
    ║  ✓ TODOS OS TESTES PASSARAM!                               ║
    ╚════════════════════════════════════════════════════════════╝
    ```

### Opção B: Script Simplificado (Bash)

1.  **Navegue até a pasta de testes:**

    ```bash
    cd /caminho/para/o/projeto/framework-v6-mvp/tests
    ```

2.  **Torne o script executável (apenas na primeira vez):**

    ```bash
    chmod +x test-n8n-integration.sh
    ```

3.  **Execute o script:**

    ```bash
    ./test-n8n-integration.sh
    ```

4.  **Analise o resultado:**

    O script executará os mesmos 7 testes e exibirá um resumo similar, porém mais simples.

---

## 🧪 DETALHES DOS TESTES

Ambos os scripts executam os seguintes 7 testes:

| # | Nome do Teste                               | Endpoint                    | Objetivo                                                                    | Espera Erro? |
|:-:|---------------------------------------------|-----------------------------|-----------------------------------------------------------------------------|:------------:|
| 1 | Integração Básica                           | `/test-integration`         | Validar a comunicação mais simples possível.                                | Não          |
| 2 | Receptor Principal - Análise Econômica      | `/dashboard-request`        | Testar o roteamento para o fluxo de "analysis".                           | Não          |
| 3 | Receptor Principal - Coleta de Dados        | `/dashboard-request`        | Testar o roteamento para o fluxo de "data_collection".                    | Não          |
| 4 | Receptor Principal - Comparação             | `/dashboard-request`        | Testar o roteamento para o fluxo de "comparison".                         | Não          |
| 5 | Análise Territorial Completa                | `/analise-territorial`      | Testar o workflow mais complexo, que consulta o banco e usa LLM.            | Não          |
| 6 | Validação - Request Type Inválido           | `/dashboard-request`        | Garantir que o sistema rejeita tipos de requisição inválidos.               | Sim          |
| 7 | Validação - Campos Obrigatórios Ausentes    | `/dashboard-request`        | Garantir que o sistema valida a presença de campos essenciais no payload.  | Sim          |

---

## 🐛 SOLUÇÃO DE PROBLEMAS

### Problema: Teste 5 (Análise Territorial) falha com timeout.

**Causa:** A análise com LLM pode demorar mais que o timeout padrão de 30 segundos, especialmente na primeira execução.

**Solução (`test-n8n-integration.js`):**
- O timeout para este teste já foi aumentado para 90 segundos no script. Se ainda assim falhar, você pode aumentar o valor na definição do teste:

  ```javascript
  {
    name: 'Teste 5: Análise Territorial Completa',
    // ...
    timeout: 120000 // Aumentado para 120 segundos (2 minutos)
  }
  ```

**Solução (`test-n8n-integration.sh`):**
- O `curl` por padrão não tem um timeout tão curto. Se encontrar problemas, pode ser a configuração do próprio n8n. Verifique as configurações de timeout do workflow em `Settings -> Execution Timeout`.

### Problema: Todos os testes falham com erro de conexão.

**Causa:** O n8n Cloud pode estar fora do ar, ou sua conexão com a internet está com problemas.

**Solução:**
1.  Verifique se você consegue acessar `https://galactic-ai.app.n8n.cloud` no seu navegador.
2.  Verifique o status do n8n Cloud em https://status.n8n.io/.

### Problema: Testes 6 e 7 falham (reportam sucesso quando deveriam falhar).

**Causa:** A lógica de validação no workflow `WF-WEBHOOK-01` pode estar incorreta ou desativada.

**Solução:**
1.  Abra o workflow `WF-WEBHOOK-01` no n8n.
2.  Verifique o código no nó "Validar Requisição".
3.  Garanta que ele está corretamente identificando payloads inválidos e retornando um erro.

---

## 🔄 INTEGRAÇÃO CONTÍNUA (CI/CD)

Para garantir a estabilidade do projeto a longo prazo, é altamente recomendado integrar estes testes em um pipeline de CI/CD (como GitHub Actions).

**Exemplo de workflow para GitHub Actions (`.github/workflows/test-integration.yml`):**

```yaml
name: Teste de Integração n8n

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  test-n8n-webhooks:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout do código
        uses: actions/checkout@v3

      - name: Configurar Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Instalar dependências (se houver)
        run: npm install # Se você adicionar dependências ao projeto

      - name: Executar testes de integração n8n
        run: node tests/test-n8n-integration.js
```

Este workflow executará os testes automaticamente a cada `push` ou `pull request` para a branch `main`, garantindo que nenhuma alteração quebre a integração com o n8n.
