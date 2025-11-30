# Prompt de Continuidade - Sessão #11

**Framework de Inteligência Territorial V6.0**  
**Data de Criação:** 30/11/2025  
**Sessão Anterior:** #10 - Depuração e Validação do Agente ECON

---

## 🎯 CONTEXTO PARA A PRÓXIMA SESSÃO

Olá, **você do futuro**! 👋

Se você está lendo isso, é porque está prestes a dar continuidade a um dos projetos mais ambiciosos e transformadores que você já iniciou: o **Framework de Inteligência Territorial V6.0**.

Na **Sessão #10**, alcançamos um marco histórico: **o Agente ECON está 100% funcional!** Após uma sessão intensa de depuração colaborativa, conseguimos validar completamente o ciclo de aprendizagem evolutiva de 4 camadas. O workflow do Agente ECON no n8n agora executa perfeitamente: gera análises multidimensionais, registra aprendizados, atualiza a expertise e mantém auditoria completa. Todas as queries SQL foram validadas contra o schema real do banco de dados Neon, e a arquitetura foi corrigida para execução sequencial. O MVP saltou para **90% de conclusão**.

Agora temos um **template validado e funcional** que pode ser replicado para os outros 3 agentes especializados: SOCIAL, TERRA e AMBIENT.

---

## 🌟 O QUE VOCÊ CONQUISTOU NA SESSÃO #10

- ✅ **Workflow do Agente ECON** totalmente depurado e validado
- ✅ **Ciclo de Aprendizagem Evolutiva** funcionando 100% (4 camadas)
- ✅ **Arquitetura Sequencial** implementada (corrigido problema de execução paralela)
- ✅ **Queries SQL Validadas** contra o schema real do banco Neon
- ✅ **UPSERT Implementado** para `knowledge_base` (resolve chave duplicada)
- ✅ **Análise de Schema** documentada (GitHub vs Banco Real)
- ✅ **Template Replicável** criado e validado
- ✅ **MVP em 90%** de conclusão

---

## 📚 DOCUMENTAÇÃO ESSENCIAL

Antes de prosseguir, **leia estes documentos** no repositório GitHub para absorver o contexto completo:

### Documentos Chave

1. **README.md** (Visão Geral do Projeto)  
   📍 `/README.md`

2. **INDEX.md** (Índice Master da Documentação)  
   📍 `/docs/INDEX.md`

3. **VISION.md** (Visão Estratégica)  
   📍 `/VISION.md`

4. **Estado Atual do Projeto** (**Atualizado na Sessão #10**)  
   📍 `/docs/estado_atual.md`

5. **Arquitetura do Núcleo de Especialistas**  
   📍 `/docs/n8n/ARQUITETURA_NUCLEO_ESPECIALISTAS.md`

### Diários das Últimas Sessões

6. **Diário de Pesquisa-Ação (Sessão #10)** (**Novo!**)  
   📍 `/docs/diarios/SESSAO_2025-11-30_ECON_RAG_COMPLETO.md`

7. **Relatório Final da Sessão #10** (**Novo!**)  
   📍 `/relatorio_final_workflow_econ.md`

8. **Análise de Schema (Sessão #10)** (**Novo!**)  
   📍 `/docs/analise_schema_sessao10.md`

### Documentos de Implementação da Sessão #10

9. **Workflow Funcional do Agente ECON V6.1** (**Template para Replicação!**)  
   📍 `/n8n/workflows/WF-AGENT-ECON-EspecialistaEconômicoV6.1(Multidimensional).json`

10. **Queries SQL Corrigidas** (**Templates para Adaptação!**)  
    📍 `/n8n/code-snippets/consultar_memoria_aprendizados_v3_final.sql`  
    📍 `/n8n/code-snippets/consultar_dados_multidimensional_v4_final.sql`  
    📍 `/n8n/code-snippets/salvar_analise_knowledge_base_v2_upsert.sql`  
    📍 `/n8n/code-snippets/registrar_auditoria_ciclo_v2_fixed.sql`  
    📍 `/n8n/code-snippets/estruturar_resposta_v2_fixed.js`

---

## 🛠️ ATIVOS EXISTENTES (CHECKLIST DE CONTEXTO)

Verifique o status e a localização dos seguintes ativos:

### 1. Aplicativo Web (Replit)
- **URL:** [https://inteligencia-territorial--hrhenrique7.replit.app](https://inteligencia-territorial--hrhenrique7.replit.app)
- **Estrutura:** `client/` (frontend), `server/` (backend), `shared/` (schemas)
- **Integração:** Sincronizado com a branch `main` do GitHub

### 2. Banco de Dados (Neon)
- **Status:** Em produção com dados reais e schema validado
- **Estrutura:** 4 camadas RAG, 22 tabelas, 700+ indicadores
- **Credenciais:** Fornecidas separadamente pelo usuário
- **Tabelas por Agente:**
  - ✅ **ECON:** `agent_econ_memory`, `agent_econ_learning_evolution` (validadas)
  - ⏳ **SOCIAL:** `agent_social_memory`, `agent_social_learning_evolution` (existem, precisam validação)
  - ⏳ **TERRA:** `agent_terra_memory`, `agent_terra_learning_evolution` (existem, precisam validação)
  - ⏳ **AMBIENT:** `agent_ambient_memory`, `agent_ambient_learning_evolution` (existem, precisam validação)

### 3. Workflows (n8n)
- **Agente ECON V6.1:** ✅ **100% Funcional e Validado** (Template pronto para replicação)
- **Agente SOCIAL:** ⏳ Aguardando atualização
- **Agente TERRA:** ⏳ Aguardando atualização
- **Agente AMBIENT:** ⏳ Aguardando atualização
- **Orquestrador:** ⏳ Aguardando implementação (Sessão #12)

### 4. Scripts de Teste e Validação (Novos na Sessão #10)
- **Validação do Ciclo de Aprendizagem:** Scripts Python criados para validar cada componente
- **Análise de Schema:** Script Python para comparar schema GitHub vs Neon

### 5. Scripts de Coleta
- **Disponíveis:** `scripts/data_collection/`
- **Status:** Prontos para uso, dados reais populados no banco

---

## 🚀 PRÓXIMA FRONTEIRA: SESSÃO #11

### Objetivo da Sessão #11

**Replicar a arquitetura validada do Agente ECON para os outros 3 agentes especializados: SOCIAL, TERRA e AMBIENT.**

### Tarefas da Sessão

| Tarefa | Descrição | Critérios de Conclusão |
|---|---|---|
| **Replicar Workflow para SOCIAL** (Prioridade #1) | Duplicar o workflow do ECON V6.1 e adaptar para a dimensão social. Ajustar queries SQL para acessar `social_indicators` e tabelas relacionadas. | Workflow SOCIAL funcional, testado e validado |
| **Replicar Workflow para TERRA** (Prioridade #2) | Duplicar o workflow do ECON V6.1 e adaptar para a dimensão territorial. Ajustar queries SQL para acessar `territorial_indicators` e tabelas relacionadas. | Workflow TERRA funcional, testado e validado |
| **Replicar Workflow para AMBIENT** (Prioridade #3) | Duplicar o workflow do ECON V6.1 e adaptar para a dimensão ambiental. Ajustar queries SQL para acessar `environmental_indicators` e tabelas relacionadas. | Workflow AMBIENT funcional, testado e validado |
| **Validar Ciclo Completo** | Testar o ciclo de aprendizagem de cada agente individualmente, garantindo que análises, aprendizados, expertise e auditoria funcionem corretamente. | 4 agentes funcionais, cada um com ciclo de aprendizagem validado |
| **Documentar Adaptações** | Documentar as adaptações específicas de cada dimensão e criar um guia de replicação para futuros agentes. | Documentação completa das adaptações |

---

## 💡 INSTRUÇÕES PARA O MANUS AI

Ao iniciar a Sessão #11, siga este protocolo:

1. **Conecte ao GitHub:**
   ```bash
   gh repo clone henrique-m-ribeiro/framework-v6-mvp
   ```

2. **Leia os documentos essenciais** listados acima, com atenção especial para:
   - O diário da Sessão #10 (para entender o processo de depuração)
   - O workflow do Agente ECON V6.1 (template para replicação)
   - As queries SQL corrigidas (templates para adaptação)

3. **Verifique o schema das tabelas** de cada agente no banco Neon para identificar diferenças.

4. **Confirme o entendimento** com o usuário antes de prosseguir.

5. **Solicite as credenciais do n8n** ao usuário para iniciar a replicação.

6. **Replique e adapte** o workflow para cada agente, um por vez.

7. **Teste cada agente** individualmente antes de passar para o próximo.

8. **Registre a sessão** no diário de pesquisa-ação ao final.

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

### Aprendizados da Sessão #10

- **Validação Contra Schema Real:** Sempre valide queries SQL contra o schema real do banco de dados, não contra documentação desatualizada.
- **Arquitetura Sequencial:** Em workflows n8n, garanta que os nós de consulta sejam executados sequencialmente quando há dependências de dados.
- **UPSERT para Análises:** Use `INSERT ... ON CONFLICT UPDATE` para evitar erros de chave duplicada ao salvar análises.
- **Nomenclatura de Nós:** Ao referenciar nós no n8n, use `$('Nome do Nó').first().json` em vez de `$node['Nome do Nó']`.
- **Colaboração Humano-IA:** A depuração é mais eficaz quando o humano fornece contexto preciso (logs, screenshots) e a IA analisa e propõe soluções.

### Estrutura do Ciclo de Aprendizagem (Validado na Sessão #10)

1. **Nova Análise Gerada:** O agente gera uma análise multidimensional e a salva na Camada 3 (`knowledge_base`).
2. **Busca de Memória RAG:** O sistema busca análises prévias e aprendizados na Camada 1 e Camada 2.
3. **Contexto Multidimensional:** O sistema consulta dados brutos das 4 dimensões (econômica, social, territorial, ambiental).
4. **Geração de Análise:** Um LLM gera a análise usando o contexto RAG + dados brutos.
5. **Registro de Aprendizado:** Um novo aprendizado é registrado na Camada 2 (`agent_*_learning_evolution`).
6. **Atualização de Expertise:** O contador de aprendizados é incrementado e o nível de expertise é recalculado.
7. **Auditoria:** Todos os eventos são registrados em `audit_trail`.

### Adaptações Necessárias por Agente

#### Agente SOCIAL
- **Dimensão:** `social`
- **Tabelas de Indicadores:** `social_indicators` (idhm, population, literacy_rate, income_per_capita, education_metrics, health_metrics)
- **Foco da Análise:** Desenvolvimento humano, educação, saúde, renda, desigualdade
- **Prompt do LLM:** Adaptar para análise social

#### Agente TERRA
- **Dimensão:** `territorial`
- **Tabelas de Indicadores:** `territorial_indicators` (urbanized_area, density, sanitation_coverage, land_use)
- **Foco da Análise:** Urbanização, densidade demográfica, saneamento, uso do solo
- **Prompt do LLM:** Adaptar para análise territorial

#### Agente AMBIENT
- **Dimensão:** `environmental`
- **Tabelas de Indicadores:** `environmental_indicators` (vegetation_coverage, deforested_area, water_quality, co2_emissions)
- **Foco da Análise:** Cobertura vegetal, desmatamento, qualidade da água, emissões
- **Prompt do LLM:** Adaptar para análise ambiental

---

## 🎯 ESTRATÉGIA DE REPLICAÇÃO

### Passo 1: Duplicar o Workflow do ECON
1. Exportar o workflow `WF-AGENT-ECON-V6.1` do n8n
2. Criar 3 cópias e renomear para cada agente

### Passo 2: Adaptar Cada Workflow
Para cada agente (SOCIAL, TERRA, AMBIENT):

1. **Webhook:** Atualizar a URL do webhook (ex: `/webhook/agent-social`)
2. **Normalizar Entrada:** Ajustar validação de `agent_id` (ex: `social`, `terra`, `ambient`)
3. **Consultar Memória:** Adaptar query para usar as tabelas corretas (ex: `agent_social_memory`)
4. **Consultar Dados:** Adaptar query para usar os indicadores corretos (ex: `social_indicators`)
5. **Preparar Contexto:** Ajustar o script JavaScript para formatar os dados da dimensão
6. **Gerar Análise:** Adaptar o prompt do LLM para a dimensão específica
7. **Salvar Análise:** Atualizar `dimension` na query (ex: `'social'`)
8. **Registrar Aprendizado:** Adaptar query para usar as tabelas corretas (ex: `agent_social_learning_evolution`)
9. **Atualizar Expertise:** Adaptar para usar `get_agent_expertise('social')`
10. **Registrar Auditoria:** Atualizar `agent_id` na query

### Passo 3: Testar Cada Agente
1. Enviar POST para o webhook de cada agente
2. Validar que todas as 4 camadas do ciclo funcionam
3. Verificar os dados salvos no banco

### Passo 4: Documentar
1. Criar documento com as adaptações específicas de cada dimensão
2. Atualizar o estado atual do projeto

---

**Preparado por:** Manus AI  
**Data:** 30/11/2025  
**Repositório:** [framework-v6-mvp](https://github.com/henrique-m-ribeiro/framework-v6-mvp)
