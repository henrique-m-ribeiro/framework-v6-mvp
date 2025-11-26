# Guia Rápido: Implementando Novos Agentes

**Data:** 26 de novembro de 2025

---

## 1. Visão Geral

Este guia simplifica a criação de novos agentes, utilizando o `TEMPLATE-AGENT-WORKFLOW.json` como base. O template já contém as correções e melhores práticas validadas.

## 2. Passos de Implementação

### Passo 1: Duplicar o Template

1.  No n8n, importe o arquivo `TEMPLATE-AGENT-WORKFLOW.json`.
2.  Renomeie o workflow para o novo agente (ex: `WF-AGENT-URBAN - Especialista Urbano`).

### Passo 2: Configurar o Webhook

1.  **Nó:** `Webhook - Recebe Tarefa`
2.  **Ação:** Altere o `path` para o endpoint do novo agente (ex: `agent-urban`).

### Passo 3: Ajustar a Query de Consulta

1.  **Nó:** `Consultar Dados PostgreSQL`
2.  **Ação:** Substitua `{DATA_SOURCE}` pela tabela de indicadores correta (ex: `urban_indicators`).

### Passo 4: Ajustar o Nó "Preparar Dados"

1.  **Nó:** `Preparar Dados para Salvar`
2.  **Ação:** No código JavaScript, substitua `{DATA_SOURCE}` pela mesma tabela do passo anterior.

### Passo 5: Ajustar a Query de Salvamento

1.  **Nó:** `Salvar Análise no PostgreSQL`
2.  **Ação:** Na query SQL, substitua:
    -   `{DIMENSION}` pela dimensão do agente (ex: `urban`).
    -   `{GENERATED_BY}` pelo nome do workflow (ex: `WF-AGENT-URBAN`).

### Passo 6: Configurar a OpenAI

1.  **Nó:** `Gerar Análise com OpenAI` (ou similar)
2.  **Ação:** Ajuste o **System Prompt** para refletir a especialidade do novo agente.

    **Exemplo (Agente Urbano):**
    > "Você é um especialista em análise urbana de municípios brasileiros, com foco em indicadores de infraestrutura, mobilidade e desenvolvimento urbano."

### Passo 7: Conectar as Credenciais

1.  **Nós:** `Consultar Dados PostgreSQL` e `Salvar Análise no PostgreSQL`
2.  **Ação:** Selecione as credenciais corretas do seu banco de dados PostgreSQL.

## 3. Checklist Final

- [ ] `path` do webhook está correto?
- [ ] Query de consulta usa a tabela de indicadores correta?
- [ ] Código "Preparar Dados" usa a fonte de dados correta?
- [ ] Query de salvamento tem `dimension` e `generated_by` corretos?
- [ ] System prompt da OpenAI está adaptado?
- [ ] Credenciais do PostgreSQL estão conectadas?

## 4. Conclusão

Seguindo estes passos, a implementação de um novo agente se torna um processo rápido e à prova de erros, garantindo consistência e robustez em todo o framework.

---

**Documento criado por:** Manus AI
