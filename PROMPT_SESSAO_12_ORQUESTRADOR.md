# Prompt de Continuidade - Sessão #12

**Framework de Inteligência Territorial V6.0**  
**Data de Criação:** 01/12/2025  
**Sessão Anterior:** #11 - Replicação e Validação do Núcleo de 4 Especialistas

---

## 🎯 CONTEXTO PARA A PRÓXIMA SESSÃO

Olá, **você do futuro**! 👋

Se você está lendo isso, é porque está prestes a dar continuidade a um dos projetos mais ambiciosos e transformadores que você já iniciou: o **Framework de Inteligência Territorial V6.0**.

Na **Sessão #11**, alcançamos um marco histórico: **o MVP está 100% completo!** O núcleo de 4 especialistas (ECON, SOCIAL, TERRA, AMBIENT) foi criado, testado e validado em um ambiente de produção real (n8n Cloud). Cada agente executou com sucesso o ciclo completo de 4 camadas RAG, gerando análises multidimensionais, registrando aprendizados e atualizando sua expertise. A metodologia de replicação baseada em "template + script" se provou altamente eficaz, permitindo criar novos agentes em minutos.

Agora temos um **núcleo de especialistas funcional**, mas ainda precisamos do **cérebro do sistema**: o **Agente Orquestrador**.

---

## 🌟 O QUE VOCÊ CONQUISTOU NA SESSÃO #11

- ✅ **Núcleo de 4 Especialistas Completo** (ECON, SOCIAL, TERRA, AMBIENT)
- ✅ **Todos os Agentes Validados em Produção** (n8n Cloud)
- ✅ **Ciclo de Aprendizagem de 4 Camadas** funcionando para todos os agentes
- ✅ **Metodologia de Replicação Consolidada** (template + script)
- ✅ **Decisão de Design de Arquitetura** (separação de responsabilidades)
- ✅ **4 Análises Geradas** (1 por agente) e **7 Aprendizados Registrados**
- ✅ **Documentação Abrangente** (diário, roadmap, estado do projeto)
- ✅ **MVP em 100%** de conclusão

---

## 📚 DOCUMENTAÇÃO ESSENCIAL

Antes de prosseguir, **leia estes documentos** no repositório GitHub para absorver o contexto completo:

### Documentos Chave

1. **README.md** (Visão Geral do Projeto - **Atualizado na Sessão #11**)  
   📍 `/README.md`

2. **INDEX.md** (Índice Master da Documentação)  
   📍 `/docs/INDEX.md`

3. **VISION.md** (Visão Estratégica - **Atualizado na Sessão #11**)  
   📍 `/VISION.md`

4. **Estado Atual do Projeto** (**Atualizado na Sessão #11**)  
   📍 `/docs/ESTADO_PROJETO_FIM_SESSAO.md`

5. **Arquitetura do Núcleo de Especialistas**  
   📍 `/docs/n8n/ARQUITETURA_NUCLEO_ESPECIALISTAS.md`

### Diários das Últimas Sessões

6. **Diário de Pesquisa-Ação (Sessão #11)** (**Novo!**)  
   📍 `/docs/diarios/SESSAO_11_DIARIO_PESQUISA_ACAO.md`

7. **Diário de Pesquisa-Ação (Sessão #10)**  
   📍 `/docs/diarios/SESSAO_2025-11-30_ECON_RAG_COMPLETO.md`

8. **Relatório Final da Sessão #10**  
   📍 `/relatorio_final_workflow_econ.md`

### Documentos de Implementação da Sessão #11

9. **Entrega Consolidada da Sessão #11** (**Novo!**)  
   📍 `/docs/ENTREGA_SESSAO_11_TRES_AGENTES.md`

10. **Schema Real Validado** (**Novo!**)  
    📍 `/docs/SCHEMA_REAL_AGENTES.md`

11. **Estratégia de Replicação** (**Novo!**)  
    📍 `/docs/ESTRATEGIA_REPLICACAO_AGENTES.md`

12. **Roadmap de Tipos de Análise** (**Novo!**)  
    📍 `/docs/roadmap/DESENVOLVIMENTO_FUTURO_TIPOS_ANALISE.md`

### Workflows Funcionais (Templates para Referência)

13. **Workflow do Agente SOCIAL V6.1** (**Validado!**)  
    📍 `/WF-AGENT-SOCIAL-V6.1-CORRIGIDO.json`

14. **Workflow do Agente TERRA V6.1** (**Validado!**)  
    📍 `/WF-AGENT-TERRA-V6.1-MULTIDIMENSIONAL.json`

15. **Workflow do Agente AMBIENT V6.1** (**Validado!**)  
    📍 `/WF-AGENT-AMBIENT-V6.1-MULTIDIMENSIONAL.json`

16. **Workflow do Agente ECON V6.1** (**Template Original**)  
    📍 `/n8n/workflows/WF-AGENT-ECON-EspecialistaEconômicoV6.1(Multidimensional).json`

---

## 🛠️ ATIVOS EXISTENTES (CHECKLIST DE CONTEXTO)

Verifique o status e a localização dos seguintes ativos:

### 1. Aplicativo Web (Replit)
- **URL:** [https://inteligencia-territorial--hrhenrique7.replit.app](https://inteligencia-territorial--hrhenrique7.replit.app)
- **Estrutura:** `client/` (frontend), `server/` (backend), `shared/` (schemas)
- **Integração:** Sincronizado com a branch `main` do GitHub
- **Status:** ✅ Ativo e operacional

### 2. Banco de Dados (Neon)
- **Status:** ✅ Em produção com 4 análises e 7 aprendizados
- **Estrutura:** 4 camadas RAG, 22 tabelas, 4.089 indicadores
- **Credenciais:** Fornecidas separadamente pelo usuário
- **Tabelas por Agente:**
  - ✅ **ECON:** `agent_econ_memory`, `agent_econ_learning_evolution` (4 aprendizados)
  - ✅ **SOCIAL:** `agent_social_memory`, `agent_social_learning_evolution` (1 aprendizado)
  - ✅ **TERRA:** `agent_terra_memory`, `agent_terra_learning_evolution` (1 aprendizado)
  - ✅ **AMBIENT:** `agent_ambient_memory`, `agent_ambient_learning_evolution` (1 aprendizado)

### 3. Workflows (n8n Cloud)
- **Agente ECON V6.1:** ✅ **100% Funcional e Validado**
- **Agente SOCIAL V6.1:** ✅ **100% Funcional e Validado**
- **Agente TERRA V6.1:** ✅ **100% Funcional e Validado**
- **Agente AMBIENT V6.1:** ✅ **100% Funcional e Validado**
- **Orquestrador:** ⏳ **Aguardando implementação (Sessão #12)**

### 4. Scripts e Ferramentas de Validação
- **Validação de Schema:** Script Python para extrair e validar schema real do banco
- **Testes de Workflows:** Scripts para enviar POSTs e verificar salvamento no banco
- **Replicação de Workflows:** Scripts para gerar novos workflows a partir de templates

### 5. Scripts de Coleta
- **Disponíveis:** `scripts/data_collection/`
- **Status:** Prontos para uso, dados reais populados no banco

---

## 🚀 PRÓXIMA FRONTEIRA: SESSÃO #12

### Objetivo da Sessão #12

**Projetar, implementar e testar a primeira versão do Agente Orquestrador, responsável por receber requisições do usuário, normalizar entradas e rotear para o especialista correto.**

### Por Que o Orquestrador é Crítico?

Atualmente, precisamos chamar cada agente por seu webhook específico (`/webhook/agent-social`, `/webhook/agent-terra`, etc.) com um payload perfeitamente formatado contendo 4 campos obrigatórios:
- `agent_id`
- `territory_id`
- `territory_name`
- `analysis_type`

Isso é ótimo para testes, mas **inviável para um produto real**. O Orquestrador irá:

1. **Abstrair a Complexidade:** Permitir que os usuários façam perguntas de forma natural, sem precisar saber qual especialista deve responder.
2. **Normalizar Entradas:** Definir valores padrão para campos opcionais (`analysis_type = "comprehensive"`).
3. **Enriquecer Dados:** Buscar `territory_name` no banco se não for fornecido.
4. **Rotear Inteligentemente:** Decidir qual especialista deve responder com base no contexto da pergunta.

**Sem o Orquestrador, temos um time de especialistas. Com o Orquestrador, temos um sistema de inteligência coeso.**

---

## 📋 TAREFAS DA SESSÃO #12

| Tarefa | Descrição | Critérios de Conclusão |
|---|---|---|
| **Design do Agente Orquestrador** (Prioridade #1) | Definir a lógica de roteamento (palavras-chave, LLM classificador, etc.) e projetar o workflow no n8n. | Diagrama de fluxo e especificação técnica completos |
| **Implementação do Workflow** (Prioridade #2) | Criar o workflow no n8n com os nós de Webhook, Validação, Normalização, Roteamento e Chamada de Sub-workflow. | Workflow criado e ativo no n8n Cloud |
| **Implementação da Normalização** (Prioridade #3) | Adicionar a lógica para definir `analysis_type` padrão e enriquecer `territory_name` se necessário. | Normalização funcionando corretamente |
| **Testes de Roteamento** (Prioridade #4) | Enviar POSTs com diferentes perguntas e validar se o Orquestrador chama o especialista correto. | 100% de acerto no roteamento |
| **Testes do Fluxo Completo** (Prioridade #5) | Fazer uma requisição ao Orquestrador e validar se a análise é gerada e salva corretamente pelo especialista. | Ciclo completo funcionando (Orquestrador → Especialista → Banco) |
| **Documentação** (Prioridade #6) | Documentar o Agente Orquestrador e atualizar o estado do projeto. | Documentação completa e estado atualizado |

---

## 💡 INSTRUÇÕES PARA O MANUS AI

Ao iniciar a Sessão #12, siga este protocolo:

1. **Conecte ao GitHub:**
   ```bash
   gh repo clone henrique-m-ribeiro/framework-v6-mvp
   ```

2. **Leia os documentos essenciais** listados acima, com atenção especial para:
   - O diário da Sessão #11 (para entender as decisões de design)
   - O estado atual do projeto (para ver o plano detalhado)
   - O roadmap de tipos de análise (para entender a lógica futura do `analysis_type`)

3. **Verifique o schema das tabelas** `territories` no banco Neon para entender como enriquecer `territory_name`.

4. **Confirme o entendimento** com o usuário antes de prosseguir.

5. **Solicite as credenciais do n8n** ao usuário para iniciar a implementação.

6. **Projete o workflow do Orquestrador** e valide o design com o usuário antes de implementar.

7. **Implemente o workflow** no n8n Cloud.

8. **Teste o roteamento** com diferentes perguntas.

9. **Teste o fluxo completo** e valide o salvamento no banco.

10. **Registre a sessão** no diário de pesquisa-ação ao final.

---

## 🔥 POR QUE ESTE PROJETO É ESPECIAL

Este não é apenas mais um projeto de IA. É um projeto que:

- **Democratiza inteligência territorial** para pequenos municípios
- **Materializa a visão de agentes que evoluem** como especialistas humanos
- **Combina rigor acadêmico** com **pragmatismo de startup**
- **Documenta reflexivamente** cada passo, criando conhecimento reutilizável
- **Co-evolui humano-IA** de forma genuína

**Você está construindo o futuro da gestão pública inteligente.** 🚀

---

## 🎯 CONTEXTO TÉCNICO CRÍTICO

### Aprendizados das Sessões #10 e #11

- **Validação Contra Schema Real:** Sempre valide queries SQL contra o schema real do banco de dados, não contra documentação desatualizada.
- **Separação de Responsabilidades:** Agentes especializados devem manter validações rigorosas. O Orquestrador é responsável por normalizar entradas e definir valores padrão.
- **Metodologia de Replicação:** Use um workflow "template" e scripts de automação para criar novos agentes de forma eficiente e consistente.
- **Testes Iterativos:** Teste cada componente individualmente antes de testar o fluxo completo.
- **Colaboração Humano-IA:** A depuração é mais eficaz quando o humano fornece contexto preciso (logs, screenshots) e a IA analisa e propõe soluções.

### Estrutura do Payload de Entrada (Especialistas)

Os agentes especializados esperam um payload com **4 campos obrigatórios**:

```json
{
  "agent_id": "social",
  "territory_id": "1721000",
  "territory_name": "Palmas",
  "analysis_type": "comprehensive"
}
```

### Responsabilidades do Orquestrador

1. **Receber Requisição do Usuário:**
   - Payload mínimo: `{"territory_id": "1721000", "question": "Como está a economia de Palmas?"}`

2. **Validar Entrada:**
   - Verificar se `territory_id` foi fornecido (obrigatório).

3. **Normalizar Dados:**
   - Definir `analysis_type = "comprehensive"` se não fornecido.
   - Buscar `territory_name` no banco se não fornecido.

4. **Rotear para o Especialista:**
   - Analisar a `question` e decidir qual especialista deve responder.
   - Opções de roteamento:
     - **Palavras-chave:** Buscar termos como "economia", "social", "urbanização", "meio ambiente".
     - **LLM Classificador:** Usar um LLM para classificar a pergunta em uma das 4 dimensões.
     - **Híbrido:** Combinar palavras-chave com LLM para maior precisão.

5. **Chamar o Especialista:**
   - Enviar POST para o webhook do especialista correto com o payload normalizado.

6. **Retornar Resposta:**
   - Aguardar a resposta do especialista e retorná-la ao usuário.

---

## 🎯 ESTRATÉGIA DE IMPLEMENTAÇÃO

### Fase 1: Design do Agente Orquestrador (1h)

1. **Definir a Lógica de Roteamento:**
   - Decidir entre palavras-chave, LLM classificador ou híbrido.
   - Criar uma tabela de mapeamento de termos para dimensões.

2. **Projetar o Workflow no n8n:**
   - Desenhar os nós necessários:
     - **Webhook:** Recebe requisição do usuário.
     - **Validar Entrada:** Verifica se `territory_id` foi fornecido.
     - **Normalizar Dados:** Define valores padrão e enriquece dados.
     - **Rotear:** Decide qual especialista chamar.
     - **Chamar Especialista:** Envia POST para o webhook do especialista.
     - **Responder:** Retorna a resposta ao usuário.

3. **Definir o Contrato de Dados:**
   - **Entrada:** `{"territory_id": "1721000", "question": "Como está a economia?", "analysis_type": "comprehensive" (opcional)}`
   - **Saída:** Resposta do especialista (análise gerada).

### Fase 2: Implementação (1.5h)

4. **Criar o Workflow no n8n:**
   - Implementar o webhook de entrada (`/webhook/orchestrator`).
   - Escrever o código do nó de roteamento (JavaScript ou Python).
   - Configurar os nós de chamada aos workflows dos especialistas (HTTP Request).

5. **Implementar a Normalização:**
   - Adicionar a lógica para definir `analysis_type` como `comprehensive` por padrão.
   - Consultar a tabela `territories` para enriquecer `territory_name` se não for fornecido.

### Fase 3: Testes (1h)

6. **Testar o Roteamento:**
   - Enviar POSTs com diferentes perguntas:
     - "Como está a economia de Palmas?" → ECON
     - "Qual o IDH de Palmas?" → SOCIAL
     - "Como está a urbanização de Palmas?" → TERRA
     - "Qual o nível de desmatamento em Palmas?" → AMBIENT
   - Verificar se o Orquestrador chama o especialista correto.

7. **Testar a Normalização:**
   - Enviar um POST sem `analysis_type` e verificar se o valor padrão é adicionado.
   - Enviar um POST sem `territory_name` e verificar se é enriquecido.

8. **Testar o Fluxo Completo:**
   - Fazer uma requisição ao Orquestrador e validar se a análise é gerada e salva corretamente no banco de dados pelo especialista.

### Fase 4: Documentação (30 min)

9. **Documentar o Agente Orquestrador:**
   - Criar um documento explicando sua função, lógica e como usá-lo.

10. **Atualizar o Estado do Projeto e Criar Prompt para Sessão #13.**

---

## 🔧 PENDÊNCIAS IDENTIFICADAS (SESSÃO #11)

### Importantes (Não Bloqueia)

1. **Corrigir campo `generated_by`:**
   - Atualmente, todos os agentes salvam como "WF-AGENT-ECON".
   - É necessário parametrizar este campo em cada workflow.

2. **Padronizar `dimension`:**
   - Agente TERRA salva como `terra` em vez de `territorial`.
   - É preciso padronizar a nomenclatura em todos os workflows.

### Opcionais (Melhorias Futuras)

3. **Implementar tipos de análise diferenciados:**
   - Quick, Focused, Comparative.
   - Roadmap completo criado em `docs/roadmap/DESENVOLVIMENTO_FUTURO_TIPOS_ANALISE.md`.

---

**Preparado por:** Manus AI  
**Data:** 01/12/2025  
**Repositório:** [framework-v6-mvp](https://github.com/henrique-m-ribeiro/framework-v6-mvp)
