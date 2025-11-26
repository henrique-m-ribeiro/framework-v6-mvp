# Prompt de Continuidade - Sessão #6

**Framework de Inteligência Territorial V6.0**

---

## 🎯 CONTEXTO ATUAL

Na sessão anterior (#5), realizamos um debugging intensivo e uma refatoração completa dos agentes dimensionais. O **Agente ECON** foi totalmente validado, e as correções foram padronizadas e aplicadas aos agentes **SOCIAL**, **AMBIENT** e **TERRA**. Todos os workflows foram atualizados e commitados no GitHub (`commit c8cc01a`).

**Estado do Projeto:**
-   ✅ Todos os 4 agentes dimensionais estão operacionais e padronizados.
-   ✅ A documentação de melhores práticas e o template para novos agentes foram criados.
-   ✅ O repositório GitHub está atualizado e organizado.

## 🚀 OBJETIVO DA PRÓXIMA SESSÃO

O objetivo principal da próxima sessão é avançar para a **próxima camada de inteligência** do framework, focando na implementação de **RAG (Retrieval-Augmented Generation)** e no desenvolvimento do **Meta-Orquestrador**.

### Tarefas Propostas:

1.  **Corrigir o Nó "Respond to Webhook":**
    -   Ajustar o nó de resposta em todos os workflows para retornar uma mensagem de sucesso informativa, utilizando dados dos nós anteriores.

2.  **Implementar a Estratégia de RAG (Prova de Conceito):**
    -   **Foco:** Agente ECON.
    -   **Tarefa 1: Popular a Memória:** Criar um workflow ou script para fazer o upload de 1-2 documentos de referência (ex: artigos do IPEA em PDF) para a tabela `agent_econ_memory`.
    -   **Tarefa 2: Gerar Embeddings:** Para cada documento, gerar embeddings vetoriais e salvá-los na coluna `embedding_vector`.
    -   **Tarefa 3: Atualizar o Workflow ECON:** Adicionar um nó de busca por similaridade para encontrar documentos relevantes antes da chamada à OpenAI e injetá-los como contexto.

3.  **Desenvolver o Meta-Orquestrador (Conceitual):**
    -   Criar um novo workflow (`WF-META-ORQUESTRADOR`) que servirá como o cérebro do sistema.
    -   **Função:** Receber uma pergunta complexa do usuário (ex: "Qual o potencial de investimento em Palmas, considerando aspectos econômicos e sociais?"), decompor a pergunta em sub-tarefas e chamar os agentes dimensionais apropriados (ECON e SOCIAL).
    -   **MVP:** O orquestrador pode, inicialmente, apenas chamar os agentes em sequência e depois agregar as respostas.

## 📚 ARQUIVOS DE CONTEXTO ESSENCIAIS

Para iniciar a próxima sessão, revise os seguintes arquivos no repositório:

1.  **Diário da Sessão Anterior:**
    -   `docs/diarios/Diario_Pesquisa_Acao_2025-11-26_Sessao_5_Debug_e_Refatoracao_Agentes.md`

2.  **Documentação de Melhores Práticas:**
    -   `docs/WORKFLOW_BEST_PRACTICES.md`

3.  **Workflows Aprimorados:**
    -   `n8n/workflows/WF-AGENT-ECON-Especialista-Economico-V2.json`
    -   `n8n/workflows/WF-AGENT-SOCIAL-Especialista-Social-V2.json`
    -   `n8n/workflows/WF-AGENT-AMBIENT-Especialista-Ambiental-V2.json`
    -   `n8n/workflows/WF-AGENT-TERRA-Especialista-Territorial-V2.json`

4.  **Template para Novos Agentes:**
    -   `n8n/workflows/TEMPLATE-AGENT-WORKFLOW.json`

---

**Pergunta para iniciar a próxima sessão:**

> "Olá! Revisei o diário da nossa última sessão e os documentos de contexto. Estou pronto para começar a implementação da estratégia de RAG para o Agente ECON. Podemos começar criando o workflow para popular a tabela `agent_econ_memory` com documentos de referência?"
