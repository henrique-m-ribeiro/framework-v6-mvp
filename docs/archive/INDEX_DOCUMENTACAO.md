# Índice Master da Documentação - Framework V6.0

## 📚 Guia Completo de Documentação

Este documento serve como **índice central** para toda a documentação do projeto Framework V6.0 MVP.

---

## 🚀 INÍCIO RÁPIDO

### **Para Executar o Carregamento de Dados:**

1. **Leia primeiro:** [`COMO_EXECUTAR_NO_REPLIT.md`](COMO_EXECUTAR_NO_REPLIT.md)
2. **Quick Start:** [`/scripts/data_collection/QUICK_START.md`](../scripts/data_collection/QUICK_START.md)
3. **Execute:** `bash RUN_ALL_DIMENSIONS.sh`

---

## 📖 DOCUMENTAÇÃO POR CATEGORIA

### **1. Guias de Execução**

| Documento | Descrição | Quando Usar |
|-----------|-----------|-------------|
| [`COMO_EXECUTAR_NO_REPLIT.md`](COMO_EXECUTAR_NO_REPLIT.md) | Guia visual passo-a-passo para Replit | **COMECE AQUI** se vai executar no Replit |
| [`GUIA_EXECUCAO_MANUAL_DIMENSOES.md`](GUIA_EXECUCAO_MANUAL_DIMENSOES.md) | Passo-a-passo manual detalhado | Se preferir executar fase por fase |
| [`/scripts/data_collection/QUICK_START.md`](../scripts/data_collection/QUICK_START.md) | Início rápido (3 comandos) | Para execução rápida |
| [`/scripts/data_collection/README_RUN_ALL.md`](../scripts/data_collection/README_RUN_ALL.md) | Documentação do script automatizado | Para entender o script completo |

---

### **2. Arquitetura e Design**

| Documento | Descrição | Conteúdo |
|-----------|-----------|----------|
| [`/n8n/ARQUITETURA_NUCLEO_ESPECIALISTAS.md`](../n8n/ARQUITETURA_NUCLEO_ESPECIALISTAS.md) | Arquitetura dos 4 agentes especialistas | Workflows, padrões, diagramas |
| [`/n8n/GUIA_N8N_CLOUD.md`](../n8n/GUIA_N8N_CLOUD.md) | Configuração do n8n Cloud | Webhooks, autenticação, testes |
| [`/database/README.md`](../database/README.md) | Estrutura do banco de dados | Schemas, migrations, relacionamentos |

---

### **3. APIs e Fontes de Dados**

| Documento | Descrição | APIs Documentadas |
|-----------|-----------|-------------------|
| [`/apis/APIS_GOVERNAMENTAIS.md`](apis/APIS_GOVERNAMENTAIS.md) | Documentação completa das 6 APIs | IBGE, SICONFI, DataSUS, INEP, INPE, Nominatim |

---

### **4. Prompts para Replit AI**

| Documento | Descrição | Fase |
|-----------|-----------|------|
| [`/prompts/README.md`](prompts/README.md) | Índice de todos os prompts | Visão geral |
| [`/prompts/PROMPT_REPLIT_AI_DIMENSAO_SOCIAL.md`](prompts/PROMPT_REPLIT_AI_DIMENSAO_SOCIAL.md) | Prompt para dimensão social | Fase 6 |
| [`/prompts/PROMPT_REPLIT_AI_DIMENSAO_TERRITORIAL.md`](prompts/PROMPT_REPLIT_AI_DIMENSAO_TERRITORIAL.md) | Prompt para dimensão territorial | Fase 7 |
| [`/prompts/PROMPT_REPLIT_AI_DIMENSAO_AMBIENTAL.md`](prompts/PROMPT_REPLIT_AI_DIMENSAO_AMBIENTAL.md) | Prompt para dimensão ambiental | Fase 8 |

---

### **5. Pesquisa e Meta-Mediação**

| Documento | Descrição | Conteúdo |
|-----------|-----------|----------|
| [`/research/GUIA_META_MEDIACAO_REPLIT.md`](research/GUIA_META_MEDIACAO_REPLIT.md) | Guia de meta-mediação IA-IA | Pesquisa acadêmica, interações |

---

### **6. Integração e Dashboard**

| Documento | Descrição | Conteúdo |
|-----------|-----------|----------|
| [`/dashboard/integration/README.md`](../dashboard/integration/README.md) | Cliente JavaScript para n8n | n8n-client.js, exemplos |

---

## 🗂️ ESTRUTURA DO PROJETO

```
framework-v6-mvp/
├── docs/                           ← Você está aqui
│   ├── INDEX_DOCUMENTACAO.md       ← Este arquivo
│   ├── COMO_EXECUTAR_NO_REPLIT.md  ← Guia principal de execução
│   ├── GUIA_EXECUCAO_MANUAL_DIMENSOES.md
│   ├── apis/
│   │   └── APIS_GOVERNAMENTAIS.md
│   ├── prompts/
│   │   ├── README.md
│   │   ├── PROMPT_REPLIT_AI_DIMENSAO_SOCIAL.md
│   │   ├── PROMPT_REPLIT_AI_DIMENSAO_TERRITORIAL.md
│   │   └── PROMPT_REPLIT_AI_DIMENSAO_AMBIENTAL.md
│   ├── research/
│   │   └── GUIA_META_MEDIACAO_REPLIT.md
│   └── n8n/
│       ├── ARQUITETURA_NUCLEO_ESPECIALISTAS.md
│       └── GUIA_N8N_CLOUD.md
├── scripts/
│   └── data_collection/
│       ├── RUN_ALL_DIMENSIONS.sh       ← Script principal
│       ├── 00_verify_environment.sh
│       ├── QUICK_START.md
│       ├── README_RUN_ALL.md
│       ├── 01_collect_territories_with_coordinates.py
│       ├── 02_collect_economic_indicators.py
│       ├── 03_collect_social_indicators.py
│       ├── 04_collect_territorial_indicators.py
│       └── 05_collect_environmental_indicators.py
├── database/
│   ├── README.md
│   └── migrations/
│       ├── 001_create_territories.sql
│       ├── 002_create_economic_indicators.sql
│       ├── 003_create_social_indicators.sql
│       ├── 003_create_territorial_indicators.sql
│       ├── 003_create_environmental_indicators.sql
│       └── 004_create_knowledge_base.sql
├── n8n/
│   └── workflows/
│       ├── WF-AGENT-ECON-Especialista-Economico.json
│       ├── WF-AGENT-SOCIAL-Especialista-Social.json
│       ├── WF-AGENT-TERRA-Especialista-Territorial.json
│       └── WF-AGENT-AMBIENT-Especialista-Ambiental.json
└── dashboard/
    └── integration/
        ├── README.md
        └── n8n-client.js
```

---

## 🎯 FLUXOS DE TRABALHO COMUNS

### **Fluxo 1: Primeira Execução (Setup Completo)**

1. Ler: [`COMO_EXECUTAR_NO_REPLIT.md`](COMO_EXECUTAR_NO_REPLIT.md)
2. Abrir Replit e sincronizar com GitHub
3. Executar: `bash RUN_ALL_DIMENSIONS.sh`
4. Aguardar ~90 minutos
5. Verificar dados no banco
6. Testar agentes especialistas

---

### **Fluxo 2: Entender a Arquitetura**

1. Ler: [`/n8n/ARQUITETURA_NUCLEO_ESPECIALISTAS.md`](../n8n/ARQUITETURA_NUCLEO_ESPECIALISTAS.md)
2. Ler: [`/database/README.md`](../database/README.md)
3. Explorar workflows em `/n8n/workflows/`
4. Revisar schemas em `/database/migrations/`

---

### **Fluxo 3: Usar Replit AI como Executor**

1. Ler: [`/prompts/README.md`](prompts/README.md)
2. Copiar: [`/prompts/PROMPT_REPLIT_AI_DIMENSAO_TERRITORIAL.md`](prompts/PROMPT_REPLIT_AI_DIMENSAO_TERRITORIAL.md)
3. Colar no chat da Replit AI
4. Aguardar execução
5. Repetir para dimensão ambiental

---

### **Fluxo 4: Executar Manualmente Fase por Fase**

1. Ler: [`GUIA_EXECUCAO_MANUAL_DIMENSOES.md`](GUIA_EXECUCAO_MANUAL_DIMENSOES.md)
2. Executar verificação: `bash 00_verify_environment.sh`
3. Executar cada script Python individualmente
4. Inserir SQLs no banco
5. Verificar resultados

---

### **Fluxo 5: Pesquisa de Meta-Mediação**

1. Ler: [`/research/GUIA_META_MEDIACAO_REPLIT.md`](research/GUIA_META_MEDIACAO_REPLIT.md)
2. Documentar interações com Replit AI
3. Analisar autonomia e supervisão
4. Registrar observações

---

## 📊 ESTATÍSTICAS DA DOCUMENTAÇÃO

| Categoria | Documentos | Palavras Estimadas |
|-----------|------------|-------------------|
| Guias de Execução | 4 | ~8.000 |
| Arquitetura | 3 | ~15.000 |
| APIs | 1 | ~26.000 |
| Prompts | 4 | ~6.000 |
| Pesquisa | 1 | ~5.000 |
| **TOTAL** | **13** | **~60.000** |

---

## 🔍 BUSCA RÁPIDA

### **Preciso de...**

- **Executar o carregamento de dados** → [`COMO_EXECUTAR_NO_REPLIT.md`](COMO_EXECUTAR_NO_REPLIT.md)
- **Entender os agentes especialistas** → [`/n8n/ARQUITETURA_NUCLEO_ESPECIALISTAS.md`](../n8n/ARQUITETURA_NUCLEO_ESPECIALISTAS.md)
- **Consultar APIs governamentais** → [`/apis/APIS_GOVERNAMENTAIS.md`](apis/APIS_GOVERNAMENTAIS.md)
- **Usar Replit AI** → [`/prompts/README.md`](prompts/README.md)
- **Executar manualmente** → [`GUIA_EXECUCAO_MANUAL_DIMENSOES.md`](GUIA_EXECUCAO_MANUAL_DIMENSOES.md)
- **Início rápido** → [`/scripts/data_collection/QUICK_START.md`](../scripts/data_collection/QUICK_START.md)
- **Estrutura do banco** → [`/database/README.md`](../database/README.md)
- **Meta-mediação** → [`/research/GUIA_META_MEDIACAO_REPLIT.md`](research/GUIA_META_MEDIACAO_REPLIT.md)

---

## 📝 CONVENÇÕES

### **Nomenclatura de Arquivos:**

- `GUIA_*.md` → Guias passo-a-passo
- `PROMPT_*.md` → Prompts para IAs
- `README.md` → Índices e visões gerais
- `ARQUITETURA_*.md` → Documentação técnica
- `COMO_*.md` → Tutoriais práticos

### **Estrutura de Documentos:**

Todos os documentos seguem este padrão:
1. **Título e Contexto**
2. **Objetivo/Visão Geral**
3. **Pré-requisitos** (quando aplicável)
4. **Passo-a-Passo** ou **Conteúdo Principal**
5. **Exemplos Práticos**
6. **Solução de Problemas** (quando aplicável)
7. **Próximos Passos**
8. **Assinatura** (autor, data)

---

## 🎓 NÍVEIS DE DOCUMENTAÇÃO

### **Nível 1: Quick Start** (2-5 minutos)
- [`/scripts/data_collection/QUICK_START.md`](../scripts/data_collection/QUICK_START.md)

### **Nível 2: Guias Práticos** (10-20 minutos)
- [`COMO_EXECUTAR_NO_REPLIT.md`](COMO_EXECUTAR_NO_REPLIT.md)
- [`/scripts/data_collection/README_RUN_ALL.md`](../scripts/data_collection/README_RUN_ALL.md)

### **Nível 3: Guias Detalhados** (30-60 minutos)
- [`GUIA_EXECUCAO_MANUAL_DIMENSOES.md`](GUIA_EXECUCAO_MANUAL_DIMENSOES.md)
- [`/n8n/ARQUITETURA_NUCLEO_ESPECIALISTAS.md`](../n8n/ARQUITETURA_NUCLEO_ESPECIALISTAS.md)

### **Nível 4: Documentação Técnica Completa** (2+ horas)
- [`/apis/APIS_GOVERNAMENTAIS.md`](apis/APIS_GOVERNAMENTAIS.md)
- Todos os schemas em `/database/migrations/`

---

## 🔄 ATUALIZAÇÕES

Este índice é atualizado sempre que:
- ✅ Novos documentos são criados
- ✅ Estrutura do projeto muda
- ✅ Novos fluxos de trabalho são identificados

**Última atualização:** 22 de novembro de 2025

---

## 📞 SUPORTE

Se você não encontrou o que procura:

1. **Verifique este índice** novamente
2. **Use a busca rápida** acima
3. **Consulte o README** do diretório relevante
4. **Revise os fluxos de trabalho** comuns

---

## 🎯 PRÓXIMOS DOCUMENTOS A CRIAR

- [ ] Guia de testes dos agentes especialistas
- [ ] Documentação do Orquestrador (Meta-LLM)
- [ ] Guia de integração com dashboard
- [ ] Tutorial de RAG e knowledge base
- [ ] Guia de deployment em produção

---

**Framework de Inteligência Territorial V6.0**  
Henrique M. Ribeiro  
22 de novembro de 2025

---

**Total de documentação produzida:** ~60.000 palavras  
**Cobertura:** Setup, Execução, Arquitetura, APIs, Pesquisa, Integração
