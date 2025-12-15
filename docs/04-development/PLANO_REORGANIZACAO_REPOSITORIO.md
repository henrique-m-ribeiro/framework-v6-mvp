# 📋 Plano de Reorganização do Repositório Framework V6 MVP

**Data:** 15 de dezembro de 2025  
**Baseado em:** Relatório de Análise do Repositório (Sessão #16)  
**Objetivo:** Reorganizar estrutura, corrigir inconsistências e atualizar endpoints

---

## 🎯 Objetivos da Reorganização

### Prioridade Crítica (Ação Imediata)
1. ✅ Atualizar endpoint do orquestrador para versão atual
2. ✅ Corrigir inconsistências de versão (V4.0 → V5.1)
3. ✅ Corrigir links quebrados no INDEX.md
4. ✅ Renomear arquivos com caracteres problemáticos

### Prioridade Alta
5. ✅ Consolidar documentação fragmentada (77 arquivos na raiz)
6. ✅ Reorganizar estrutura de pastas
7. ✅ Criar CHANGELOG.md consolidado
8. ✅ Implementar convenção de nomenclatura

### Prioridade Média
9. ✅ Consolidar workflows duplicados
10. ✅ Criar documentação de contratos de dados

---

## 📊 Diagnóstico Atual

### Estatísticas
- **Documentos .md:** 209 total (77 na raiz de /docs)
- **Subpastas em /docs:** 30
- **Workflows n8n:** 50+ versões
- **Endpoint antigo:** `https://galactic-ai.app.n8n.cloud/webhook/orchestrator`
- **Endpoint correto:** `https://galactic-ai.app.n8n.cloud/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2`

### Problemas Identificados

#### 1. Inconsistência de Versões
- INDEX.md referencia Orquestrador V4.0
- Workflows atuais são V5.0/V5.1
- Documentação desatualizada

#### 2. Endpoint Desatualizado
**Arquivos que referenciam endpoint antigo:**
- `docs/GUIA_CORRECAO_AGENTES_RESTANTES_SESSAO_13.md`
- `docs/GUIA_CORRECAO_AGENTE_ECON_SESSAO_13.md`
- `docs/GUIA_CORRECAO_ORQUESTRADOR_SESSAO_13.md`
- `docs/GUIA_TESTE_INTEGRACAO_COMPLETA_SESSAO_13.md`
- `docs/ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md`
- `docs/ORQUESTRADOR_V5_EXPLICACAO_DETALHADA.md`
- `docs/QUICK_START_CORRECOES_SESSAO_13.md`
- `docs/SOLUCAO_ERRO_PARSING_JSON_ORQUESTRADOR.md`
- `docs/diarios/DIARIO_PESQUISA_ACAO_2025-12-06_SESSAO_12.md`
- `docs/🚀CONTINUIDADE_SESSAO_14_IMPLEMENTACAO_V4.md`

**Arquivo com endpoint correto (referência):**
- `docs/guides/correcao_openai_node.md`

#### 3. Links Quebrados no INDEX.md
- `02-mvp/scripts/data_collection/QUICK_START.md` ❌
- `01-architecture-full/DISTRIBUTED_MEMORY.md` ❌
- `00-overview/BUSINESS_MODEL.md` ❌
- `00-overview/ROADMAP_STARTUP.md` ❌
- `01-architecture-full/NEURAL_LAYERS.md` ❌
- `01-architecture-full/META_ORCHESTRATOR.md` ❌
- `01-architecture-full/DATA_COLLECTOR_FULL.md` ❌

#### 4. Arquivos com Caracteres Problemáticos
- `docs/🚀CONTINUIDADE_SESSAO_13_CONSOLIDACAO_ORQUESTRADOR.md`
- `docs/🚀CONTINUIDADE_SESSAO_14_IMPLEMENTACAO_V4.md`

#### 5. Fragmentação Excessiva
**Documentos redundantes sobre Orquestrador (14 arquivos!):**
- `ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md`
- `ORQUESTRADOR_V5_EXPLICACAO_DETALHADA.md`
- `GUIA_ATUALIZACAO_ORQUESTRADOR_V4.md`
- `GUIA_ATUALIZACAO_ORQUESTRADOR_IDS_SEMANTICOS.md`
- `GUIA_IMPLEMENTACAO_ORQUESTRADOR_V5.md`
- `GUIA_CORRECAO_ORQUESTRADOR_SESSAO_13.md`
- `GUIA_ORQUESTRADOR_ATUALIZADO.md`
- `SOLUCAO_ERRO_PARSING_JSON_ORQUESTRADOR.md`
- `TESTE_ORQUESTRADOR_SUCESSO_SESSAO_12.md`
- `PROPOSTA_ORQUESTRADOR_V5_AGENT_REGISTRY.md`
- `n8n/explicacao_orquestrador.md`
- `n8n/especificacao_agente_orquestrador.md`
- `n8n/guias/guia_implementacao_orquestrador_n8n.md`

**Documentos sobre Correções (9 arquivos!):**
- `CORRECAO_DEFINITIVA_RESPONSE_BODY.md`
- `CORRECAO_FINAL_DEFINITIVA.md`
- `CORRECAO_RAPIDA_ARRAY.md`
- `GUIA_CORRECAO_AGENTES_RESTANTES_SESSAO_13.md`
- `GUIA_CORRECAO_AGENTE_ECON_SESSAO_13.md`
- `GUIA_CORRECAO_ORQUESTRADOR_SESSAO_13.md`
- `GUIA_CORRIGIR_RESPOND_WEBHOOK.md`
- `APLICAR_CORRECAO_3_AGENTES.md`
- `diarios/GUIA_CORRIGIR_RESPOND_WEBHOOK.md` (duplicado!)

---

## 🏗️ Nova Estrutura Proposta

### Estrutura de Pastas Reorganizada

```
docs/
├── 00-getting-started/          # Ponto de entrada
│   ├── README.md                # Entry point único e didático
│   ├── QUICK_START.md           # Guia rápido para desenvolvedores
│   ├── GLOSSARY.md              # Glossário de termos
│   └── FAQ.md                   # Perguntas frequentes
│
├── 01-architecture/             # Arquitetura do sistema
│   ├── OVERVIEW.md              # Visão geral consolidada
│   ├── ORCHESTRATOR.md          # Orquestrador (versão atual V5.1)
│   ├── AGENTS.md                # 4 agentes especializados consolidados
│   ├── DATA_MODEL.md            # Modelo de dados e RAG
│   ├── TWO_LAYERS.md            # Arquitetura de duas camadas
│   └── FULL_VISION.md           # Visão completa (19 agentes)
│
├── 02-implementation/           # Guias de implementação
│   ├── SETUP_REPLIT.md          # Configuração do Replit
│   ├── SETUP_N8N.md             # Configuração do n8n Cloud
│   ├── SETUP_DATABASE.md        # Configuração do PostgreSQL
│   ├── WORKFLOWS_GUIDE.md       # Guia de workflows
│   └── DATA_CONTRACTS.md        # Contratos de dados entre componentes
│
├── 03-operations/               # Operações e manutenção
│   ├── TROUBLESHOOTING.md       # Consolidação de todas as correções
│   ├── MONITORING.md            # Monitoramento do sistema
│   ├── MAINTENANCE.md           # Manutenção e atualizações
│   └── TESTING.md               # Guias de teste
│
├── 04-development/              # Desenvolvimento
│   ├── CONTRIBUTING.md          # Como contribuir
│   ├── CHANGELOG.md             # Histórico de mudanças consolidado
│   ├── ROADMAP.md               # Roadmap de desenvolvimento
│   └── CONVENTIONS.md           # Convenções de nomenclatura
│
├── 05-research/                 # Pesquisa e metodologia
│   ├── METHODOLOGY.md           # Metodologia de pesquisa-ação
│   ├── diaries/                 # Diários de sessões (manter)
│   └── papers/                  # Artigos e publicações
│
└── archive/                     # Documentos históricos
    ├── v3.2/                    # Versão 3.2
    ├── v4.0/                    # Versão 4.0
    └── v5.0/                    # Versão 5.0
```

### Estrutura de Workflows n8n

```
n8n/workflows/
├── current/                     # Versões estáveis atuais
│   ├── WF-AGENT-ORCHESTRATOR-V5.1-STABLE.json
│   ├── WF-AGENT-ECON-V6.1-STABLE.json
│   ├── WF-AGENT-SOCIAL-V6.1-STABLE.json
│   ├── WF-AGENT-TERRA-V6.1-STABLE.json
│   └── WF-AGENT-AMBIENT-V6.1-STABLE.json
│
├── archive/                     # Versões históricas
│   ├── Sessao_12/
│   ├── Sessao_13/
│   ├── Sessao_14/
│   └── Sessao_15/
│
└── templates/                   # Templates reutilizáveis
    ├── TEMPLATE-AGENT-BASE.json
    └── TEMPLATE-WEBHOOK-HANDLER.json
```

---

## 🔧 Ações de Implementação

### Fase 1: Correções Críticas (Prioridade Máxima)

#### 1.1. Atualizar Endpoint do Orquestrador

**Ação:** Substituir todas as referências ao endpoint antigo pelo novo

**Comando de busca e substituição:**
```bash
# Buscar todas as ocorrências
grep -r "webhook/orchestrator" docs/ --include="*.md"

# Substituir automaticamente (após confirmação)
find docs/ -name "*.md" -type f -exec sed -i 's|https://galactic-ai.app.n8n.cloud/webhook/orchestrator|https://galactic-ai.app.n8n.cloud/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2|g' {} +
```

**Arquivos a atualizar:**
- [x] `docs/GUIA_CORRECAO_AGENTES_RESTANTES_SESSAO_13.md`
- [x] `docs/GUIA_CORRECAO_AGENTE_ECON_SESSAO_13.md`
- [x] `docs/GUIA_CORRECAO_ORQUESTRADOR_SESSAO_13.md`
- [x] `docs/GUIA_TESTE_INTEGRACAO_COMPLETA_SESSAO_13.md`
- [x] `docs/ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md`
- [x] `docs/ORQUESTRADOR_V5_EXPLICACAO_DETALHADA.md`
- [x] `docs/QUICK_START_CORRECOES_SESSAO_13.md`
- [x] `docs/SOLUCAO_ERRO_PARSING_JSON_ORQUESTRADOR.md`
- [x] `docs/diarios/DIARIO_PESQUISA_ACAO_2025-12-06_SESSAO_12.md`
- [x] `docs/🚀CONTINUIDADE_SESSAO_14_IMPLEMENTACAO_V4.md`

#### 1.2. Renomear Arquivos com Caracteres Problemáticos

```bash
# Renomear arquivos com emoji
mv "docs/🚀CONTINUIDADE_SESSAO_13_CONSOLIDACAO_ORQUESTRADOR.md" \
   "docs/prompts/CONTINUIDADE_SESSAO_13.md"

mv "docs/🚀CONTINUIDADE_SESSAO_14_IMPLEMENTACAO_V4.md" \
   "docs/prompts/CONTINUIDADE_SESSAO_14.md"
```

#### 1.3. Atualizar Referências de Versão no INDEX.md

**Ação:** Atualizar INDEX.md para referenciar V5.1 como versão atual

**Mudanças:**
- Linha 27: `Orquestrador V4.0` → `Orquestrador V5.1`
- Adicionar seção "NOVIDADES DA SESSÃO #15 e #16"
- Atualizar data de última atualização

#### 1.4. Criar CHANGELOG.md Consolidado

**Localização:** `docs/04-development/CHANGELOG.md`

**Estrutura:**
```markdown
# Changelog

## [V5.1] - 2025-12-14 (Sessão #16)
### Fixed
- Bug #1: OpenAI - Interpretar Requisição sem "role: user"
- Bug #2: OpenAI - Sintetizar Análises sem "role: user"
- Bug #3: Incompatibilidade selected_agents vs agent_ids
- Bug #4: Campo analysis_type não enviado
- Bug #5: Referência incorreta no Code - Buscar URL
- Bug #6: HTTP Request referencia campos inexistentes
- Bug #7: Code - Agregar Respostas assume estrutura diferente

## [V5.0] - 2025-12-12 (Sessão #14-15)
### Added
- Orquestrador V5.0 com análise multidimensional
- Suporte a múltiplos territórios
- Agent Registry no PostgreSQL

## [V4.0] - 2025-12-08 (Sessão #13)
### Added
- IDs semânticos (request_id, analysis_id)
- 5 novos campos de metadados
- Migração de uuid para varchar
- Arquitetura multidimensional
```

---

### Fase 2: Reorganização da Estrutura (Prioridade Alta)

#### 2.1. Criar Nova Estrutura de Pastas

```bash
# Criar novas pastas
mkdir -p docs/00-getting-started
mkdir -p docs/01-architecture
mkdir -p docs/02-implementation
mkdir -p docs/03-operations
mkdir -p docs/04-development
mkdir -p docs/05-research/diaries
mkdir -p docs/archive/{v3.2,v4.0,v5.0}

# Mover diários existentes
mv docs/diarios/* docs/05-research/diaries/
```

#### 2.2. Consolidar Documentação do Orquestrador

**Ação:** Criar documento único consolidado

**Arquivo destino:** `docs/01-architecture/ORCHESTRATOR.md`

**Conteúdo a consolidar:**
- Versão atual: V5.1
- Explicação detalhada
- Guia de implementação
- Troubleshooting específico

**Arquivos a arquivar:**
- Mover versões antigas para `docs/archive/`

#### 2.3. Consolidar Documentação de Correções

**Ação:** Criar documento único de troubleshooting

**Arquivo destino:** `docs/03-operations/TROUBLESHOOTING.md`

**Estrutura:**
```markdown
# Troubleshooting

## Problemas Comuns e Soluções

### 1. Erro de Parsing JSON no Orquestrador
**Sintoma:** ...
**Causa:** ...
**Solução:** ...

### 2. Campo "role: user" ausente na OpenAI
**Sintoma:** ...
**Causa:** ...
**Solução:** ...

[... consolidar todos os 9 documentos de correção]
```

#### 2.4. Consolidar Workflows Duplicados

**Ação:** Organizar workflows por status

```bash
# Criar estrutura
mkdir -p n8n/workflows/current
mkdir -p n8n/workflows/archive
mkdir -p n8n/workflows/templates

# Mover workflows atuais (V5.1 e V6.1)
mv n8n/workflows/*V5.1*.json n8n/workflows/current/
mv n8n/workflows/*V6.1*.json n8n/workflows/current/

# Mover versões antigas para archive
mv n8n/workflows/Sessao_* n8n/workflows/archive/
```

---

### Fase 3: Criar Documentação Consolidada (Prioridade Média)

#### 3.1. Criar README.md Principal (00-getting-started)

**Localização:** `docs/00-getting-started/README.md`

**Conteúdo:**
- Boas-vindas ao projeto
- O que é o Framework V6.0
- Como começar (3 caminhos: usuário, desenvolvedor, pesquisador)
- Links para documentação principal

#### 3.2. Criar QUICK_START.md Consolidado

**Localização:** `docs/00-getting-started/QUICK_START.md`

**Conteúdo:**
- Pré-requisitos
- Configuração rápida (5 passos)
- Primeiro teste
- Próximos passos

#### 3.3. Criar DATA_CONTRACTS.md

**Localização:** `docs/02-implementation/DATA_CONTRACTS.md`

**Conteúdo:**
- Contratos entre Orquestrador → Agentes
- Contratos entre Agentes → Orquestrador
- Contratos entre Concierge → Orquestrador
- Exemplos de payloads

#### 3.4. Criar CONVENTIONS.md

**Localização:** `docs/04-development/CONVENTIONS.md`

**Conteúdo:**
```markdown
# Convenções de Nomenclatura

## Documentos
- Formato: `CATEGORIA_SUBCATEGORIA_VERSAO.md`
- Exemplos: 
  - `ARCHITECTURE_ORCHESTRATOR_V5.md`
  - `GUIDE_SETUP_REPLIT.md`

## Workflows
- Formato: `WF-{CAMADA}-{NOME}-V{VERSAO}[-STATUS].json`
- Camadas: AGENT, UTIL, TEST
- Status: DRAFT, STABLE, DEPRECATED
- Exemplos:
  - `WF-AGENT-ECON-V6.1-STABLE.json`
  - `WF-AGENT-ORCHESTRATOR-V5.1-STABLE.json`

## Scripts
- Formato: `{numero}_{acao}_{objeto}.{ext}`
- Exemplos:
  - `001_migrate_ids.sql`
  - `002_add_metadata.sql`
```

---

### Fase 4: Atualizar INDEX.md Principal

#### 4.1. Novo INDEX.md

**Localização:** `docs/INDEX.md`

**Estrutura atualizada:**
```markdown
# 📚 Índice de Documentação - Framework V6.0

**Última Atualização:** 15 de dezembro de 2025 (Sessão #17 - Reorganização)

---

## 🎯 INÍCIO RÁPIDO

### Novo no projeto?
1. [Leia primeiro: O que é o Framework V6.0](00-getting-started/README.md)
2. [Quick Start para Desenvolvedores](00-getting-started/QUICK_START.md)
3. [Glossário de Termos](00-getting-started/GLOSSARY.md)

### Quer usar o MVP?
1. [Dashboard Web](https://inteligencia-territorial--hrhenrique7.replit.app)
2. [Guia de Configuração Replit](02-implementation/SETUP_REPLIT.md)

### Quer entender a arquitetura?
1. [Visão Geral da Arquitetura](01-architecture/OVERVIEW.md)
2. [Orquestrador V5.1 (Atual)](01-architecture/ORCHESTRATOR.md)
3. [Agentes Especializados](01-architecture/AGENTS.md)

---

## 🆕 NOVIDADES DA SESSÃO #17 (15/12/2025)

### Reorganização Completa do Repositório
- ✅ Estrutura de documentação reorganizada
- ✅ Endpoint do orquestrador atualizado
- ✅ CHANGELOG.md consolidado
- ✅ Convenções de nomenclatura estabelecidas
- ✅ Workflows organizados por status

---

## 📚 DOCUMENTAÇÃO POR CATEGORIA

### 00. Primeiros Passos
- [README - Boas-vindas](00-getting-started/README.md)
- [Quick Start](00-getting-started/QUICK_START.md)
- [Glossário](00-getting-started/GLOSSARY.md)
- [FAQ](00-getting-started/FAQ.md)

### 01. Arquitetura
- [Visão Geral](01-architecture/OVERVIEW.md)
- [Orquestrador V5.1](01-architecture/ORCHESTRATOR.md)
- [Agentes Especializados](01-architecture/AGENTS.md)
- [Modelo de Dados](01-architecture/DATA_MODEL.md)
- [Arquitetura de Duas Camadas](01-architecture/TWO_LAYERS.md)
- [Visão Completa (19 Agentes)](01-architecture/FULL_VISION.md)

### 02. Implementação
- [Configuração Replit](02-implementation/SETUP_REPLIT.md)
- [Configuração n8n](02-implementation/SETUP_N8N.md)
- [Configuração PostgreSQL](02-implementation/SETUP_DATABASE.md)
- [Guia de Workflows](02-implementation/WORKFLOWS_GUIDE.md)
- [Contratos de Dados](02-implementation/DATA_CONTRACTS.md)

### 03. Operações
- [Troubleshooting](03-operations/TROUBLESHOOTING.md)
- [Monitoramento](03-operations/MONITORING.md)
- [Manutenção](03-operations/MAINTENANCE.md)
- [Testes](03-operations/TESTING.md)

### 04. Desenvolvimento
- [Como Contribuir](04-development/CONTRIBUTING.md)
- [Changelog](04-development/CHANGELOG.md)
- [Roadmap](04-development/ROADMAP.md)
- [Convenções](04-development/CONVENTIONS.md)

### 05. Pesquisa
- [Metodologia](05-research/METHODOLOGY.md)
- [Diários de Sessões](05-research/diaries/)

---

## 📦 VERSÕES

### Versão Atual: V5.1 (Estável)
- **Orquestrador:** V5.1
- **Agentes:** V6.1
- **Data:** 14/12/2025
- **Status:** ✅ Em produção

### Versões Anteriores
- [V5.0 (Archive)](archive/v5.0/)
- [V4.0 (Archive)](archive/v4.0/)
- [V3.2 (Archive)](archive/v3.2/)

---

## 🔗 LINKS ÚTEIS

- **Dashboard:** https://inteligencia-territorial--hrhenrique7.replit.app
- **Endpoint Orquestrador:** https://galactic-ai.app.n8n.cloud/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2
- **Repositório GitHub:** https://github.com/henrique-m-ribeiro/framework-v6-mvp
```

---

## ✅ Checklist de Implementação

### Fase 1: Correções Críticas
- [ ] 1.1. Atualizar endpoint do orquestrador (10 arquivos)
- [ ] 1.2. Renomear arquivos com caracteres problemáticos (2 arquivos)
- [ ] 1.3. Atualizar referências de versão no INDEX.md
- [ ] 1.4. Criar CHANGELOG.md consolidado

### Fase 2: Reorganização da Estrutura
- [ ] 2.1. Criar nova estrutura de pastas
- [ ] 2.2. Consolidar documentação do Orquestrador
- [ ] 2.3. Consolidar documentação de Correções
- [ ] 2.4. Consolidar workflows duplicados

### Fase 3: Criar Documentação Consolidada
- [ ] 3.1. Criar README.md principal (00-getting-started)
- [ ] 3.2. Criar QUICK_START.md consolidado
- [ ] 3.3. Criar DATA_CONTRACTS.md
- [ ] 3.4. Criar CONVENTIONS.md

### Fase 4: Atualizar INDEX.md Principal
- [ ] 4.1. Reescrever INDEX.md com nova estrutura
- [ ] 4.2. Validar todos os links
- [ ] 4.3. Adicionar seção de versões

### Fase 5: Commit e Push
- [ ] 5.1. Commit das mudanças
- [ ] 5.2. Push para GitHub
- [ ] 5.3. Criar tag de versão (v5.1-reorganized)

---

## 📝 Notas Importantes

### Arquivos a NÃO Mover/Deletar
- `docs/diarios/` → Mover para `docs/05-research/diaries/` (preservar histórico)
- `docs/roadmap/ANALISE_MULTITERRITORIAL.md` → Manter e referenciar
- `docs/guides/correcao_openai_node.md` → Manter (contém endpoint correto)

### Arquivos a Arquivar (não deletar)
- Todas as versões antigas de documentos do Orquestrador
- Todos os documentos de correção (após consolidação)
- Workflows antigos (após organização)

### Endpoint Correto (Referência)
```
https://galactic-ai.app.n8n.cloud/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2
```

---

## 🎯 Resultado Esperado

Após a implementação completa deste plano:

1. ✅ **Documentação organizada e navegável** - Estrutura clara com 6 categorias principais
2. ✅ **Endpoint atualizado** - Todas as referências apontam para o endpoint correto
3. ✅ **Versões consistentes** - V5.1 claramente identificada como atual
4. ✅ **Links funcionais** - Todos os links do INDEX.md funcionando
5. ✅ **Workflows organizados** - Separação clara entre current/archive/templates
6. ✅ **Histórico preservado** - Documentos antigos arquivados, não deletados
7. ✅ **Convenções estabelecidas** - Padrões de nomenclatura documentados
8. ✅ **CHANGELOG consolidado** - Histórico de mudanças em um único lugar

---

**Próximo Passo:** Apresentar este plano ao usuário para aprovação antes de iniciar a implementação.
