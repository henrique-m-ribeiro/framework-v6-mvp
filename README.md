# Framework V6.0 - Sistema de Inteligência Territorial

[![Status](https://img.shields.io/badge/status-em%20desenvolvimento-yellow)](https://github.com)
[![Versão](https://img.shields.io/badge/versão-0.80-blue)](https://github.com)
[![Progresso](https://img.shields.io/badge/progresso-80%25-green)](https://github.com)
[![Licença](https://img.shields.io/badge/licença-Proprietária-red)](LICENSE)
[![Python](https://img.shields.io/badge/python-3.9+-blue)](https://www.python.org/)
[![PostgreSQL](https://img.shields.io/badge/postgresql-15+-blue)](https://www.postgresql.org/)

> **🎉 ATUALIZAÇÃO (17/11/2025):** Núcleo de Especialistas criado! 4 agentes dimensionais (ECON, SOCIAL, TERRA, AMBIENT) prontos para importação. Progresso: 65% → 80% (+15%). [Ver detalhes](#atualizações-recentes)

**Sistema abrangente de inteligência territorial para gestão pública, integrando análises multi-dimensionais com arquitetura RAG (Retrieval-Augmented Generation).**

---

## 📋 Sobre o Projeto

O **Framework V6.0** (também conhecido como "Framework de Interação Galáctica") é um sistema de inteligência territorial desenvolvido para apoiar a gestão pública do estado de Tocantins, Brasil, com potencial de expansão para outros territórios.

### Características Principais

- 🌍 **Multi-dimensional:** Integra 4 dimensões (Econômica, Social, Territorial, Ambiental)
- 🤖 **RAG Avançado:** Análises fundamentadas em dados reais usando GPT-4o e embeddings vetoriais
- 🗄️ **PostgreSQL + Extensões:** PostGIS (geoespacial) e pgvector (busca vetorial)
- 🔄 **Automação n8n:** Sistema multi-agentes para coleta e processamento de dados
- 📊 **140 Entidades:** Cobertura completa do Tocantins (1 estado + 139 municípios)
- 💰 **Custo Competitivo:** ~R$ 0,01/análise (com cache) ou ~R$ 0,03/análise (sem cache)

---

## 🎯 Objetivo

Fornecer aos gestores públicos análises profundas, atualizadas e contextualizadas para tomada de decisão baseada em evidências, sem necessidade de expertise técnica em ciência de dados.

---

## 🏗️ Arquitetura

```
┌─────────────────────────────────────────────────────────────┐
│                   FONTES DE DADOS EXTERNAS                   │
│  • IBGE  • INPE  • ANA  • INMET  • MapBiomas  • Ministérios │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│              CAMADA DE ORQUESTRAÇÃO (n8n)                    │
│  • WF01: Data Collector  • WF-RAG-01: Análises              │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│         CAMADA DE DADOS (PostgreSQL + PostGIS + pgvector)    │
│  • 40 tabelas  • 140 entidades  • Dados históricos 5 anos   │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│          CAMADA DE INTELIGÊNCIA (RAG + OpenAI)               │
│  • GPT-4o-mini/GPT-4o  • text-embedding-3-small  • Cache     │
└─────────────────────────────────────────────────────────────┘
```

---

## 📁 Estrutura do Repositório

```
framework-v6-mvp/
│
├── README.md                          # Este arquivo
├── QUICKSTART.md                      # Guia rápido (em breve)
├── LICENSE                            # Licença
├── .gitignore                         # Arquivos ignorados
├── .env.example                       # Template de variáveis
│
├── docs/                              # Documentação completa
│   ├── planejamento/                  # Planos e configurações
│   ├── analises_dimensionais/         # Análises das 4 dimensões
│   ├── arquitetura/                   # Documentação arquitetural
│   ├── guias/                         # Guias de implementação
│   └── diarios/                       # Diários de pesquisa-ação
│
├── database/                          # Schema e scripts SQL
│   ├── schema/                        # Schema completo (40 tabelas)
│   ├── migrations/                    # Migrações (futuro)
│   └── seeds/                         # Dados iniciais (futuro)
│
├── rag/                               # Sistema RAG
│   ├── python/                        # Scripts Python
│   │   ├── rag_manager.py            # Classe principal RAG
│   │   └── requirements.txt          # Dependências
│   └── n8n_workflows/                # Workflows RAG
│
├── workflows/                         # Workflows n8n
│   └── WF01_Data_Collector.json      # (em desenvolvimento)
│
├── scripts/                           # Scripts auxiliares
└── tests/                             # Testes (futuro)
```

---

## 🚀 Guia de Início Rápido

### Pré-requisitos

- Python 3.9+
- PostgreSQL 15+ com PostGIS e pgvector
- Conta OpenAI com créditos
- Conta n8n Cloud ou self-hosted
- Conta Replit (opcional, para hospedagem)

### Instalação

**1. Clone o repositório:**
```bash
git clone https://github.com/SEU_USUARIO/framework-v6-mvp.git
cd framework-v6-mvp
```

**2. Configure variáveis de ambiente:**
```bash
cp .env.example .env
# Edite .env com suas credenciais
```

**3. Instale dependências Python:**
```bash
cd rag/python
pip install -r requirements.txt
```

**4. Crie o schema do banco:**
```bash
psql $DATABASE_URL -f database/schema/SCHEMA_COMPLETO_40_TABELAS_POSTGRESQL.sql
```

**5. Configure n8n:**
- Importe workflows de `rag/n8n_workflows/` e `workflows/`
- Configure credenciais PostgreSQL e OpenAI
- Ative workflows

### Documentação Detalhada

Para instruções completas, consulte:
- **Planejamento:** [`docs/planejamento/plano_implementacao_mvp.md`](docs/planejamento/plano_implementacao_mvp.md)
- **Configuração:** [`docs/planejamento/configuracao_personalizada_mvp.md`](docs/planejamento/configuracao_personalizada_mvp.md)
- **Checklist:** [`docs/planejamento/checklist_pre_requisitos.md`](docs/planejamento/checklist_pre_requisitos.md)

---

## 📊 Status do Desenvolvimento

### Fases Concluídas ✅

- [x] **Fase 1:** Análise da documentação e contexto
- [x] **Fase 2:** Planejamento detalhado da implementação

### Fases em Desenvolvimento 🔄

- [ ] **Fase 3:** Configuração do ambiente Replit (PostgreSQL + extensões)
- [ ] **Fase 4:** Implementação do schema do banco de dados (40 tabelas)
- [ ] **Fase 5:** População inicial de dados territoriais (Tocantins + 139 municípios)
- [ ] **Fase 6:** Configuração do n8n Cloud e credenciais
- [ ] **Fase 7:** Implementação do agente Data Collector no n8n
- [ ] **Fase 8:** Implementação do sistema RAG (Python + OpenAI)
- [ ] **Fase 9:** Testes integrados e validação do MVP
- [ ] **Fase 10:** Documentação do processo e checkpoint de aprendizados

**Progresso:** 8.5/12 fases concluídas (80%)

### Atualizações Recentes (17/11/2025) 🆕

**Sessão 5 - Criação do Núcleo de Especialistas:**
- ✅ Sistema de Continuidade 100% validado (Fase 7)
- ✅ 4 Agentes Dimensionais criados (ECON, SOCIAL, TERRA, AMBIENT)
- ✅ Base de Conhecimento projetada (PostgreSQL + pgvector)
- ✅ 140 territórios do Tocantins processados
- 🔄 Pesquisa de APIs governamentais iniciada (30%)
- 📚 ~60.000 palavras de documentação técnica

**Próximos Passos:**
- Data Collector (catalogação de APIs + implementação)
- Prompts para IA do n8n (meta-mediação)
- Orquestrador (Meta-LLM)

[📖 Ver Resumo Completo da Sessão 5](docs/diarios/SESSAO_2025-11-17_DATA_COLLECTOR_INICIO.md) | [📓 Ver Diário de Campo](docs/diarios/DIARIO_DE_CAMPO_2025-11-17.md) | [💡 Ver Lições Aprendidas](docs/LICOES_APRENDIDAS_E_DICAS.md)

---

## 💰 Estimativas

### Tempo
- **Total estimado:** 20-27 horas
- **Sessões:** 15-18 sessões de 1-1.5h
- **Duração:** 6-9 semanas

### Custo
- **Inicial:** ~$30 USD (OpenAI + n8n primeiro mês)
- **Mensal:** ~$25-27 USD (com cache 70%)
- **Por análise:** ~$0.01 USD (com cache) ou ~$0.03 USD (sem cache)

---

## 🛠️ Stack Tecnológico

| Componente | Tecnologia | Versão | Custo |
|------------|------------|--------|-------|
| **Banco de Dados** | PostgreSQL | 15+ | Gratuito (Replit) |
| **Extensão Geoespacial** | PostGIS | 3.3+ | Gratuito |
| **Extensão Vetorial** | pgvector | 0.5+ | Gratuito |
| **Orquestração** | n8n Cloud | Latest | $20/mês |
| **LLM** | OpenAI GPT-4o-mini | Latest | $15-20/mês |
| **Embeddings** | text-embedding-3-small | Latest | Incluído |
| **Backend** | Python | 3.9+ | Gratuito |
| **Hospedagem** | Replit | Latest | Gratuito (tier free) |

---

## 📖 Documentação

### Planejamento
- [Plano de Implementação do MVP](docs/planejamento/plano_implementacao_mvp.md)
- [Configuração Personalizada](docs/planejamento/configuracao_personalizada_mvp.md)
- [Checklist de Pré-Requisitos](docs/planejamento/checklist_pre_requisitos.md)
- [Síntese da Análise](docs/planejamento/sintese_analise_framework.md)

### Análises Dimensionais
- [Dimensão Econômica](docs/analises_dimensionais/ANALISE_DIMENSAO_ECONOMICA_FRAMEWORK_V6.md)
- [Dimensão Social](docs/analises_dimensionais/ANALISE_DIMENSAO_SOCIAL_FRAMEWORK_V6.md)
- [Dimensão Territorial](docs/analises_dimensionais/ANALISE_DIMENSAO_TERRITORIAL_FRAMEWORK_V6.md)
- [Dimensão Ambiental](docs/analises_dimensionais/ANALISE_DIMENSAO_AMBIENTAL_FRAMEWORK_V6.md)

### Arquitetura
- [Arquitetura RAG Integrado](docs/arquitetura/ARQUITETURA_RAG_INTEGRADO_FRAMEWORK_V6.md)
- [Documentação do Schema (40 Tabelas)](docs/arquitetura/DOCUMENTACAO_SCHEMA_40_TABELAS.md)
- [Síntese das 4 Dimensões](docs/arquitetura/SINTESE_4_DIMENSOES_ESTRUTURA_RAG_FINAL.md)

### Guias
- [Configuração de Variáveis de Ambiente](docs/guias/GUIA_CONFIGURACAO_VARIAVEIS_AMBIENTE.md)
- [Configuração Replit PostgreSQL](docs/guias/GUIA_CONFIGURACAO_REPLIT_POSTGRESQL_PGVECTOR.md)
- [Revisão Técnica](docs/guias/REVISAO_TECNICA_IMPLEMENTACAO_RAG.md)
- [Importância do GitHub](docs/guias/importancia_github.md)

### Diários de Pesquisa-Ação
- [Sessão 10/11/2025 - Planejamento](docs/diarios/resumo_sessao_fase1_fase2.md)

---

## 🤝 Contribuindo

Este é um projeto em desenvolvimento ativo. Contribuições serão bem-vindas após a conclusão do MVP.

### Roadmap Futuro

**Curto Prazo (1-2 meses):**
- Adicionar agentes especializados (TERRA, ECON, SOCIAL, INTERACT)
- Implementar Meta Orchestrator
- Expandir coleta para todas as 4 dimensões
- Implementar frontend básico (dashboard)

**Médio Prazo (3-6 meses):**
- Adicionar mais municípios brasileiros (benchmark)
- Implementar sistema de reranking (Cohere)
- Otimizar performance (Redis cache)
- Implementar autenticação e controle de acesso

**Longo Prazo (6-12 meses):**
- Expansão internacional
- Sistema de alertas automáticos
- API pública para terceiros
- Modelo de negócio SaaS

---

## 📝 Licença

Este projeto está sob licença proprietária. Todos os direitos reservados.

Para uso comercial ou acadêmico, entre em contato.

---

## 👤 Autor

**Henrique Ribeiro**
- Pesquisador e Desenvolvedor
- Projeto de Startup em Inteligência Territorial

**Colaboração:**
- Manus AI (Assistente de Desenvolvimento)

---

## 📧 Contato

Para dúvidas, sugestões ou parcerias:
- **Email:** [seu-email@exemplo.com]
- **LinkedIn:** [seu-linkedin]
- **GitHub:** [seu-usuario]

---

## 🙏 Agradecimentos

- IBGE, INPE, ANA, INMET e demais fontes de dados públicas
- Comunidades open source (PostgreSQL, PostGIS, pgvector, n8n)
- OpenAI pela API de LLMs e embeddings

---

**Última atualização:** 17 de Novembro de 2025  
**Versão:** 0.80  
**Status:** Em Desenvolvimento Ativo 🚀  
**Última Sessão:** Sessão 5 - Criação do Núcleo de Especialistas
