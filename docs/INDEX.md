# 📚 ÍNDICE MASTER - Framework V6.0

**Guia Completo de Navegação**

**Última Atualização:** 08 de dezembro de 2025 (Sessão #13)

---

## 🎯 INÍCIO RÁPIDO

### **Novo no projeto?**

1. **Leia primeiro:** [O que é o Framework V6.0](00-overview/WHAT_IS_V6.md)
2. **Entenda a visão:** [VISION.md](../VISION.md)
3. **Veja o roadmap:** [MVP vs. Produto Completo](00-overview/MVP_VS_FULL.md)
4. **Estado atual:** [ESTADO_PROJETO_FIM_SESSAO.md](ESTADO_PROJETO_FIM_SESSAO.md) ⭐ **ATUALIZADO (Sessão #13)**

### **Quer usar o MVP?**

1. **Acesse o dashboard:** [https://inteligencia-territorial--hrhenrique7.replit.app](https://inteligencia-territorial--hrhenrique7.replit.app)
2. **Quick Start (desenvolvedor):** [QUICK_START.md](02-mvp/scripts/data_collection/QUICK_START.md)
3. **Guia Replit:** [COMO_EXECUTAR_NO_REPLIT.md](COMO_EXECUTAR_NO_REPLIT.md)

### **Quer entender a arquitetura?**

1. **Arquitetura V4.0 (Multidimensional):** [ARQUITETURA_V4_IDs_E_METADADOS.md](ARQUITETURA_V4_IDs_E_METADADOS.md) ⭐ **NOVO (Sessão #13)**
2. **Orquestrador V4.0:** [ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md](ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md) ⭐ **NOVO (Sessão #13)**
3. **Arquitetura de Duas Camadas:** [ARQUITETURA_DUAS_CAMADAS.md](01-architecture-full/ARQUITETURA_DUAS_CAMADAS.md)
4. **19 Agentes:** [19_AGENTS_COMPLETE.md](01-architecture-full/19_AGENTS_COMPLETE.md)
5. **Memória Distribuída:** [DISTRIBUTED_MEMORY.md](01-architecture-full/DISTRIBUTED_MEMORY.md)
6. **Workflows n8n:** [ARQUITETURA_NUCLEO_ESPECIALISTAS.md](n8n/ARQUITETURA_NUCLEO_ESPECIALISTAS.md)

---

## 🆕 NOVIDADES DA SESSÃO #13 (08/12/2025)

### **Arquitetura V4.0 - Multidimensional e Multiterritorial**

A Sessão #13 marcou uma evolução histórica do projeto com a criação da **Arquitetura V4.0**, que habilita análises multidimensionais (múltiplos agentes colaborando) e multiterritoriais (comparações entre municípios).

**Documentos Essenciais:**

| Documento | Descrição | Quando Ler |
|-----------|-----------|------------|
| [ARQUITETURA_V4_IDs_E_METADADOS.md](ARQUITETURA_V4_IDs_E_METADADOS.md) | Especificação completa da Arquitetura V4.0 | **COMECE AQUI** para entender a nova arquitetura |
| [ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md](ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md) | Explicação didática do Orquestrador V4.0 | Para entender como funciona o maestro do sistema |
| [GUIA_ATUALIZACAO_ORQUESTRADOR_V4.md](GUIA_ATUALIZACAO_ORQUESTRADOR_V4.md) | Guia de implementação do Orquestrador V4.0 | Para implementar no n8n Cloud |
| [GUIA_ATUALIZACAO_AGENTES_V4.md](GUIA_ATUALIZACAO_AGENTES_V4.md) | Guia de atualização dos 4 agentes para V4 | Para atualizar os agentes existentes |

### **Migrações de Banco de Dados**

| Script | Descrição | Status |
|--------|-----------|--------|
| [001_migrate_id_to_varchar_v2.sql](../database/migrations/001_migrate_id_to_varchar_v2.sql) | Migração de IDs de uuid para varchar | ✅ Executado |
| [002_add_metadata_fields.sql](../database/migrations/002_add_metadata_fields.sql) | Adição de 5 campos de metadados | ✅ Executado |

### **Análises Técnicas**

| Documento | Descrição |
|-----------|-----------|
| [ANALISE_SCHEMA_BD_SESSAO_13.md](ANALISE_SCHEMA_BD_SESSAO_13.md) | Análise do schema do banco de dados |
| [DIAGNOSTICO_PROBLEMAS_SALVAMENTO_SESSAO_13.md](DIAGNOSTICO_PROBLEMAS_SALVAMENTO_SESSAO_13.md) | Diagnóstico dos bugs de salvamento |

### **Workflows**

| Workflow | Descrição | Status |
|----------|-----------|--------|
| [WF-AGENT-ORCHESTRATOR-V4.0-Multidimensional.json](../n8n/workflows/Sessao_13/WF-AGENT-ORCHESTRATOR-V4.0-Multidimensional.json) | Orquestrador V4.0 completo | 🟡 Pronto para importação |

### **Diário de Pesquisa-Ação**

| Documento | Descrição |
|-----------|-----------|
| [DIARIO_PESQUISA_ACAO_2025-12-08_SESSAO_13.md](DIARIO_PESQUISA_ACAO_2025-12-08_SESSAO_13.md) | Diário reflexivo da Sessão #13 |

---

## 📚 DOCUMENTAÇÃO POR CATEGORIA

### **00. Visão Geral do Projeto**

| Documento | Descrição | Quando Ler |
|-----------|-----------|------------|
| [WHAT_IS_V6.md](00-overview/WHAT_IS_V6.md) | O que é o Framework V6.0 | **COMECE AQUI** |
| [MVP_VS_FULL.md](00-overview/MVP_VS_FULL.md) | Diferença MVP vs. Produto Completo | Para entender roadmap |
| [BUSINESS_MODEL.md](00-overview/BUSINESS_MODEL.md) | Modelo de negócio e precificação | Investidores e parceiros |
| [ROADMAP_STARTUP.md](00-overview/ROADMAP_STARTUP.md) | Roadmap 1-5 anos | Visão de longo prazo |
| [ESTADO_PROJETO_FIM_SESSAO.md](ESTADO_PROJETO_FIM_SESSAO.md) ⭐ | **ATUALIZADO:** Estado atual do projeto | Para saber onde estamos agora |

---

### **01. Arquitetura Completa (19 Agentes)**

| Documento | Descrição | Conteúdo |
|-----------|-----------|----------|
| [ARQUITETURA_V4_IDs_E_METADADOS.md](ARQUITETURA_V4_IDs_E_METADADOS.md) ⭐ | **NOVO:** Arquitetura V4.0 Multidimensional | IDs semânticos + Metadados estruturados |
| [ARQUITETURA_DUAS_CAMADAS.md](01-architecture-full/ARQUITETURA_DUAS_CAMADAS.md) | Arquitetura de duas camadas de IA | Concierge + Núcleo de Especialistas |
| [19_AGENTS_COMPLETE.md](01-architecture-full/19_AGENTS_COMPLETE.md) | Todos os 19 agentes detalhados | Camadas 1-3, Meta-Orq, Data Collector |
| [NEURAL_LAYERS.md](01-architecture-full/NEURAL_LAYERS.md) | 3 camadas de orquestração | Análise, Interface, Inteligência |
| [META_ORCHESTRATOR.md](01-architecture-full/META_ORCHESTRATOR.md) | Meta-Orquestrador central | Coordenação e roteamento |
| [DISTRIBUTED_MEMORY.md](01-architecture-full/DISTRIBUTED_MEMORY.md) | Arquitetura de memória | RAG Central + Individual |
| [DATA_COLLECTOR_FULL.md](01-architecture-full/DATA_COLLECTOR_FULL.md) | Data Collector completo | 6 módulos de gestão |

---

### **02. Documentação do MVP**

#### **Arquitetura do MVP**

| Documento | Descrição |
|-----------|-----------|
| [Modelo Conceitual RAG Evolutivo v3.0](sessao6/modelo_conceitual_RAG_evolutivo_v3.md) | Arquitetura RAG Evolutiva de 3 Camadas |
| [Plano de Implementação MVP](sessao6/plano_implementacao_mvp.md) | Roadmap de 6 semanas para implementação |
| [ARQUITETURA_RAG_INTEGRADO_FRAMEWORK_V6.md](02-mvp/architecture/ARQUITETURA_RAG_INTEGRADO_FRAMEWORK_V6.md) | Arquitetura RAG completa |
| [SCHEMA_COMPLETO_27_TABELAS.md](arquitetura/SCHEMA_COMPLETO_27_TABELAS.md) | Schema de 40 tabelas |
| [SINTESE_4_DIMENSOES_ESTRUTURA_RAG_FINAL.md](02-mvp/architecture/SINTESE_4_DIMENSOES_ESTRUTURA_RAG_FINAL.md) | Síntese das 4 dimensões |

#### **Guias de Implementação**

| Documento | Descrição | Quando Usar |
|-----------|-----------|-------------|
| [GUIA_ATUALIZACAO_ORQUESTRADOR_V4.md](GUIA_ATUALIZACAO_ORQUESTRADOR_V4.md) ⭐ | **NOVO:** Implementar Orquestrador V4.0 | Para importar e configurar o Orquestrador V4.0 |
| [GUIA_ATUALIZACAO_AGENTES_V4.md](GUIA_ATUALIZACAO_AGENTES_V4.md) ⭐ | **NOVO:** Atualizar agentes para V4 | Para atualizar os 4 agentes existentes |
| [COMO_EXECUTAR_NO_REPLIT.md](COMO_EXECUTAR_NO_REPLIT.md) | Guia visual passo-a-passo | **COMECE AQUI** para executar |
| [QUICK_START.md](02-mvp/scripts/data_collection/QUICK_START.md) | Início rápido (3 comandos) | Execução rápida |
| [GUIA_CONFIGURACAO_REPLIT_POSTGRESQL_PGVECTOR.md](02-mvp/guides/GUIA_CONFIGURACAO_REPLIT_POSTGRESQL_PGVECTOR.md) | Configuração do Replit | Setup inicial |
| [WORKFLOW_BEST_PRACTICES.md](WORKFLOW_BEST_PRACTICES.md) | Melhores práticas para workflows | Desenvolvimento de agentes |
| [IMPLEMENTING_NEW_AGENTS.md](IMPLEMENTING_NEW_AGENTS.md) | Guia para implementar novos agentes | Expansão do sistema |

#### **Workflows n8n**

| Documento | Descrição |
|-----------|-----------|
| [WF-AGENT-ORCHESTRATOR-V4.0-Multidimensional.json](../n8n/workflows/Sessao_13/WF-AGENT-ORCHESTRATOR-V4.0-Multidimensional.json) ⭐ | **NOVO:** Workflow JSON do Orquestrador V4.0 |
| [ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md](ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md) ⭐ | **NOVO:** Explicação didática do Orquestrador V4.0 |
| [ARQUITETURA_NUCLEO_ESPECIALISTAS.md](n8n/ARQUITETURA_NUCLEO_ESPECIALISTAS.md) | Arquitetura dos 4 agentes |
| [explicacao_orquestrador.md](n8n/explicacao_orquestrador.md) | Explicação didática do Agente Orquestrador V3.2 |
| [especificacao_agente_orquestrador.md](n8n/especificacao_agente_orquestrador.md) | Especificação técnica do Orquestrador V3.2 |
| [guias/guia_implementacao_orquestrador_n8n.md](n8n/guias/guia_implementacao_orquestrador_n8n.md) | Guia de implementação passo a passo V3.2 |
| [guias/guia_roteador_multi_llm.md](n8n/guias/guia_roteador_multi_llm.md) | Guia para configurar roteador com múltiplos LLMs |
| [workflows/WF-AGENT-ORCHESTRATOR-V3.2-FIXED.json](n8n/workflows/WF-AGENT-ORCHESTRATOR-V3.2-FIXED.json) | Workflow JSON do Orquestrador V3.2 |

#### **Banco de Dados**

| Documento | Descrição |
|-----------|-----------|
| [ANALISE_SCHEMA_BD_SESSAO_13.md](ANALISE_SCHEMA_BD_SESSAO_13.md) ⭐ | **NOVO:** Análise do schema do banco de dados |
| [001_migrate_id_to_varchar_v2.sql](../database/migrations/001_migrate_id_to_varchar_v2.sql) ⭐ | **NOVO:** Script de migração de IDs |
| [002_add_metadata_fields.sql](../database/migrations/002_add_metadata_fields.sql) ⭐ | **NOVO:** Script de adição de metadados |

#### **Diagnósticos e Análises Técnicas**

| Documento | Descrição |
|-----------|-----------|
| [DIAGNOSTICO_PROBLEMAS_SALVAMENTO_SESSAO_13.md](DIAGNOSTICO_PROBLEMAS_SALVAMENTO_SESSAO_13.md) ⭐ | **NOVO:** Diagnóstico dos bugs de salvamento |
| [ANALISE_AVISOS_N8N.md](ANALISE_AVISOS_N8N.md) | Análise de avisos do n8n |
| [ANALISE_BASES_DADOS_REPLIT.md](ANALISE_BASES_DADOS_REPLIT.md) | Análise das bases de dados no Replit |
| [ANALISE_ESTRUTURA_RAG_EXISTENTE.md](ANALISE_ESTRUTURA_RAG_EXISTENTE.md) | Análise da estrutura RAG existente |

#### **Diários de Pesquisa-Ação**

| Documento | Descrição |
|-----------|-----------|
| [DIARIO_PESQUISA_ACAO_2025-12-08_SESSAO_13.md](DIARIO_PESQUISA_ACAO_2025-12-08_SESSAO_13.md) ⭐ | **NOVO:** Sessão 13: Consolidação do Orquestrador e Evolução Arquitetural |
| [SESSAO_12_DIARIO_PESQUISA_ACAO.md](diarios/SESSAO_12_DIARIO_PESQUISA_ACAO.md) | Sessão 12: Implementação e Teste do Orquestrador V3.2 |
| [SESSAO_11_DIARIO_PESQUISA_ACAO.md](diarios/SESSAO_11_DIARIO_PESQUISA_ACAO.md) | Sessão 11: Conclusão do Núcleo de Especialistas |
| [Diario_Pesquisa_Acao_2025-11-28_Sessao_6_Arquitetura_RAG.md](diarios/Diario_Pesquisa_Acao_2025-11-28_Sessao_6_Arquitetura_RAG.md) | Sessão 6: Arquitetura RAG Evolutiva |
| [Diario_Pesquisa_Acao_2025-11-26_Sessao_5_Reflexivo.md](diarios/Diario_Pesquisa_Acao_2025-11-26_Sessao_5_Reflexivo.md) | Sessão 5: Debugging e Padronização |
| [Diario_Pesquisa_Acao_2025-11-23_Estruturacao_Dados_Inteligencia.md](02-mvp/diaries/Diario_Pesquisa_Acao_2025-11-23_Estruturacao_Dados_Inteligencia.md) | Sessão 3: Estruturação de Dados |
| [DIARIO_DE_CAMPO_2025-11-17.md](02-mvp/diaries/DIARIO_DE_CAMPO_2025-11-17.md) | Sessão 2: Núcleo de Especialistas |

---

### **03. Scripts e Ferramentas**

| Documento | Descrição |
|-----------|-----------|
| [QUICK_START.md](02-mvp/scripts/data_collection/QUICK_START.md) | Início rápido (3 comandos) |
| [Scripts de Coleta](../scripts/data_collection/) | Scripts para coleta de dados |

---

### **04. Banco de Dados**

| Documento | Descrição |
|-----------|-----------|
| [ARQUITETURA_ATUAL.md](07-database/ARQUITETURA_ATUAL.md) | Arquitetura atual do banco de dados |
| [SCHEMA_COMPLETO_27_TABELAS.md](arquitetura/SCHEMA_COMPLETO_27_TABELAS.md) | Schema de 40 tabelas |

---

## 🗺️ ROTEIRO DE LEITURA RECOMENDADO

### **Para Novos Desenvolvedores**

1. [WHAT_IS_V6.md](00-overview/WHAT_IS_V6.md) - Entenda o que é o projeto
2. [VISION.md](../VISION.md) - Entenda a visão estratégica
3. [ESTADO_PROJETO_FIM_SESSAO.md](ESTADO_PROJETO_FIM_SESSAO.md) - Veja onde estamos agora
4. [ARQUITETURA_V4_IDs_E_METADADOS.md](ARQUITETURA_V4_IDs_E_METADADOS.md) - Entenda a arquitetura atual
5. [ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md](ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md) - Entenda o componente central
6. [COMO_EXECUTAR_NO_REPLIT.md](COMO_EXECUTAR_NO_REPLIT.md) - Execute o sistema

### **Para Implementar a Arquitetura V4.0**

1. [ESTADO_PROJETO_FIM_SESSAO.md](ESTADO_PROJETO_FIM_SESSAO.md) - Entenda o estado atual
2. [ARQUITETURA_V4_IDs_E_METADADOS.md](ARQUITETURA_V4_IDs_E_METADADOS.md) - Entenda a nova arquitetura
3. [ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md](ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md) - Entenda o Orquestrador V4.0
4. [GUIA_ATUALIZACAO_ORQUESTRADOR_V4.md](GUIA_ATUALIZACAO_ORQUESTRADOR_V4.md) - Implemente o Orquestrador
5. [GUIA_ATUALIZACAO_AGENTES_V4.md](GUIA_ATUALIZACAO_AGENTES_V4.md) - Atualize os agentes
6. [ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md](ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md) (seção "Como Testar") - Execute os testes

### **Para Entender a Evolução do Projeto**

1. [DIARIO_PESQUISA_ACAO_2025-12-08_SESSAO_13.md](DIARIO_PESQUISA_ACAO_2025-12-08_SESSAO_13.md) - Sessão #13 (Arquitetura V4.0)
2. [SESSAO_12_DIARIO_PESQUISA_ACAO.md](diarios/SESSAO_12_DIARIO_PESQUISA_ACAO.md) - Sessão #12 (Orquestrador V3.2)
3. [SESSAO_11_DIARIO_PESQUISA_ACAO.md](diarios/SESSAO_11_DIARIO_PESQUISA_ACAO.md) - Sessão #11 (Núcleo de Especialistas)
4. [Diario_Pesquisa_Acao_2025-11-28_Sessao_6_Arquitetura_RAG.md](diarios/Diario_Pesquisa_Acao_2025-11-28_Sessao_6_Arquitetura_RAG.md) - Sessão #6 (Arquitetura RAG)

---

## 📞 CONTATO E SUPORTE

Para dúvidas, sugestões ou contribuições, entre em contato através do repositório GitHub:

**Repositório:** [henrique-m-ribeiro/framework-v6-mvp](https://github.com/henrique-m-ribeiro/framework-v6-mvp)

---

**Última Atualização:** 08 de dezembro de 2025 (Sessão #13)  
**Versão do Sistema:** V4.0 (Arquitetura Multidimensional e Multiterritorial)  
**Status:** 🟡 Orquestrador V4.0 pronto para implementação, Agentes V6.1 aguardando atualização para V4
