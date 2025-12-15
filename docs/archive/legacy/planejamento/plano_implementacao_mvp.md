# Plano de Implementação do MVP - Framework V6.0

**Data:** 10 de Novembro de 2025  
**Versão:** 1.0  
**Objetivo:** Roteiro detalhado para implementação passo-a-passo do MVP

---

## 1. ESCOPO DEFINIDO DO MVP

### 1.1. Decisões Estratégicas

Com base nas respostas fornecidas, o escopo do MVP foi definido como:

**Dimensões:**
- ✅ Todas as 4 dimensões desde o início (Econômica, Social, Territorial, Ambiental)
- Evolução futura: incremento de workflows e lógica de interação entre agentes

**Cobertura Territorial:**
- ✅ Estado do Tocantins completo
- ✅ Todos os 139 municípios tocantinenses
- Visão de longo prazo: expansão para outros municípios/estados brasileiros e internacional

**Agentes:**
- ✅ Início com Data Collector (agente essencial de coleta)
- Incremento gradual de agentes especializados (TERRA, ECON, SOCIAL, INTERACT)
- Aprendizado progressivo sobre impacto de cada agente nas análises

**Fontes de Dados:**
- ✅ APIs públicas oficiais (IBGE, INPE, ANA, INMET, MapBiomas, etc.)
- Verificação conjunta de acessos e funcionalidade

**Infraestrutura:**
- ✅ Replit (conta nova, projeto a ser criado)
- ✅ n8n Cloud (conta nova)
- ✅ OpenAI (chave API a ser obtida)

**Metodologia:**
- ✅ Múltiplas sessões com checkpoints
- ✅ Instruções passo-a-passo para execução autônoma
- ✅ Foco em aprendizado e transferência de conhecimento
- ✅ Ritmo sem pressa, priorizando assimilação

---

## 2. FASES DE IMPLEMENTAÇÃO

### FASE 1: Análise e Planejamento ✅
**Status:** Concluída  
**Duração:** Sessão atual  
**Entregas:**
- ✅ Análise completa da documentação
- ✅ Esclarecimento de escopo
- ✅ Definição de metodologia de trabalho

---

### FASE 2: Planejamento Detalhado 🔄
**Status:** Em andamento  
**Duração:** Sessão atual  
**Objetivos:**
- Criar roteiro detalhado de todas as fases
- Identificar dependências entre componentes
- Preparar checklist de pré-requisitos
- Definir critérios de sucesso para cada fase

**Entregas:**
- Documento de planejamento completo (este documento)
- Checklist de pré-requisitos
- Roteiro de sessões futuras

---

### FASE 3: Configuração do Ambiente Replit
**Duração Estimada:** 1 sessão (1-2 horas)  
**Pré-requisitos:**
- Conta Replit criada ✅
- Chave OpenAI obtida
- Documento de planejamento revisado

**Objetivos:**
1. Criar projeto Replit para o Framework V6.0
2. Ativar PostgreSQL nativo do Replit
3. Instalar extensões PostGIS e pgvector
4. Configurar variáveis de ambiente
5. Testar conectividade do banco

**Entregas:**
- Projeto Replit configurado e funcional
- PostgreSQL rodando com extensões instaladas
- Arquivo `.env` com credenciais configuradas
- Script de teste de conexão validado

**Critérios de Sucesso:**
- [ ] PostgreSQL acessível via connection string
- [ ] Extensões PostGIS e pgvector instaladas e funcionais
- [ ] Variáveis de ambiente carregando corretamente
- [ ] Teste de conexão bem-sucedido

---

### FASE 4: Implementação do Schema do Banco
**Duração Estimada:** 1 sessão (1-2 horas)  
**Pré-requisitos:**
- Fase 3 concluída com sucesso
- Arquivo `SCHEMA_COMPLETO_40_TABELAS_POSTGRESQL.sql` disponível

**Objetivos:**
1. Executar script SQL de criação das 40 tabelas
2. Verificar criação de todas as tabelas
3. Validar índices e constraints
4. Testar queries básicas de estrutura

**Entregas:**
- 40 tabelas criadas no PostgreSQL
- Índices e constraints configurados
- Documentação de estrutura validada
- Script de verificação executado

**Critérios de Sucesso:**
- [ ] Todas as 40 tabelas criadas sem erros
- [ ] Índices GiST (PostGIS) e IVFFlat (pgvector) funcionais
- [ ] Foreign keys e constraints validados
- [ ] Query de contagem de tabelas retorna 40

---

### FASE 5: População de Dados Territoriais
**Duração Estimada:** 1-2 sessões (2-4 horas)  
**Pré-requisitos:**
- Fase 4 concluída com sucesso
- Acesso às APIs do IBGE verificado

**Objetivos:**
1. Coletar dados territoriais básicos do Tocantins via API IBGE
2. Popular tabela `entidades_territoriais` (1 estado + 139 municípios)
3. Coletar geometrias (polígonos) dos municípios
4. Inserir dados geoespaciais com PostGIS
5. Validar integridade dos dados inseridos

**Entregas:**
- Script Python de coleta de dados IBGE
- 140 registros em `entidades_territoriais` (1 estado + 139 municípios)
- Geometrias geoespaciais validadas
- Documentação do processo de coleta

**Critérios de Sucesso:**
- [ ] 140 entidades territoriais inseridas
- [ ] Geometrias válidas para todos os municípios
- [ ] Queries espaciais (ST_Contains, ST_Intersects) funcionando
- [ ] Dados básicos (nome, código IBGE, população) preenchidos

**APIs a Utilizar:**
- IBGE - Localidades: `https://servicodados.ibge.gov.br/api/v1/localidades/estados/TO/municipios`
- IBGE - Malhas: `https://servicodados.ibge.gov.br/api/v3/malhas/estados/TO`

---

### FASE 6: Configuração do n8n Cloud
**Duração Estimada:** 1 sessão (1-2 horas)  
**Pré-requisitos:**
- Conta n8n Cloud criada ✅
- Credenciais OpenAI e PostgreSQL disponíveis

**Objetivos:**
1. Configurar workspace no n8n Cloud
2. Adicionar credenciais PostgreSQL
3. Adicionar credenciais OpenAI
4. Testar conectividade com banco de dados
5. Testar chamada à API OpenAI

**Entregas:**
- Workspace n8n configurado
- Credenciais armazenadas de forma segura
- Workflow de teste de conectividade
- Documentação de configuração

**Critérios de Sucesso:**
- [ ] Conexão PostgreSQL testada e funcional
- [ ] Conexão OpenAI testada e funcional
- [ ] Workflow simples de teste executado com sucesso
- [ ] Webhooks funcionando (para testes futuros)

---

### FASE 7: Implementação do Agente Data Collector
**Duração Estimada:** 2-3 sessões (4-6 horas)  
**Pré-requisitos:**
- Fases 5 e 6 concluídas com sucesso
- Entendimento das APIs oficiais a serem utilizadas

**Objetivos:**
1. Criar workflow n8n do Data Collector
2. Implementar coleta de dados econômicos (IBGE - PIB, emprego)
3. Implementar coleta de dados sociais (IBGE - educação, saúde)
4. Implementar coleta de dados ambientais (INPE - queimadas, desmatamento)
5. Implementar coleta de dados territoriais (IBGE - infraestrutura)
6. Estruturar dados coletados para inserção no PostgreSQL
7. Implementar lógica de atualização incremental (evitar duplicatas)
8. Adicionar logging e tratamento de erros

**Entregas:**
- Workflow n8n `WF01_Data_Collector.json` completo
- Documentação detalhada de cada nó do workflow
- Script de teste de coleta para cada dimensão
- Dados reais coletados e inseridos no banco

**Critérios de Sucesso:**
- [ ] Workflow executa sem erros
- [ ] Dados de pelo menos 2 dimensões coletados com sucesso
- [ ] Dados inseridos corretamente nas tabelas apropriadas
- [ ] Logs detalhados de execução disponíveis
- [ ] Tratamento de erros implementado (retry, fallback)

**APIs Prioritárias:**
- **IBGE Cidades:** `https://servicodados.ibge.gov.br/api/v1/pesquisas/indicadores`
- **INPE Queimadas:** `https://queimadas.dgi.inpe.br/queimadas/dados-abertos/api`
- **INPE PRODES:** `http://terrabrasilis.dpi.inpe.br/geoserver/wfs`

**Estrutura do Workflow (Simplificada):**
```
[Trigger Manual/Schedule]
    ↓
[Buscar Municípios do TO no PostgreSQL]
    ↓
[Loop: Para cada município]
    ↓
[HTTP Request: API IBGE - Dados Econômicos]
    ↓
[Transformar Dados (JSON → Estrutura do Banco)]
    ↓
[PostgreSQL: Inserir/Atualizar Dados Econômicos]
    ↓
[HTTP Request: API INPE - Dados Ambientais]
    ↓
[Transformar Dados]
    ↓
[PostgreSQL: Inserir/Atualizar Dados Ambientais]
    ↓
[Logging: Registrar Sucesso/Erros]
    ↓
[Fim do Loop]
    ↓
[Notificação: Resumo da Coleta]
```

---

### FASE 8: Implementação do Sistema RAG
**Duração Estimada:** 2-3 sessões (4-6 horas)  
**Pré-requisitos:**
- Fase 4 concluída (tabela `rag_analises_geradas` criada)
- Fase 6 concluída (credenciais OpenAI configuradas)
- Dados iniciais no banco (Fase 5 e/ou Fase 7)

**Objetivos:**
1. Configurar ambiente Python no Replit
2. Implementar classe `RAGManager` (já existe no código fornecido)
3. Criar workflow n8n `WF-RAG-01_Gerar_Inserir_Analise`
4. Implementar geração de embeddings (text-embedding-3-small)
5. Implementar busca semântica com pgvector
6. Implementar sistema de cache (verificação de análises similares)
7. Implementar geração de análises com GPT-4o-mini
8. Testar ciclo completo: pergunta → cache → busca → geração → armazenamento

**Entregas:**
- Classe `RAGManager` configurada e testada
- Workflow n8n RAG completo e funcional
- Primeira análise gerada com sucesso
- Sistema de cache funcionando
- Documentação do fluxo RAG

**Critérios de Sucesso:**
- [ ] Embeddings gerados corretamente (1536 dimensões)
- [ ] Busca vetorial retornando resultados relevantes
- [ ] Cache funcionando (análises similares reutilizadas)
- [ ] Análises geradas fundamentadas em dados reais do banco
- [ ] Análises armazenadas com embeddings para cache futuro
- [ ] Tempo de resposta < 15 segundos para análise nova
- [ ] Tempo de resposta < 2 segundos para análise em cache

**Fluxo RAG (Detalhado):**
```
[Webhook: Recebe Pergunta]
    ↓
[Gerar Embedding da Pergunta] (OpenAI text-embedding-3-small)
    ↓
[Busca Vetorial no Cache] (pgvector: similaridade > 0.85)
    ↓
[Cache Hit?]
    ├─ SIM → [Retornar Análise do Cache] → [Fim]
    └─ NÃO → [Continuar]
        ↓
[Extrair Entidades da Pergunta] (município, dimensão, período)
    ↓
[Busca SQL: Dados Relevantes] (PostgreSQL: filtros por entidade/dimensão)
    ↓
[Construir Contexto] (dados + metadados + instruções)
    ↓
[Gerar Análise] (GPT-4o-mini com contexto)
    ↓
[Gerar Embedding da Análise]
    ↓
[Armazenar Análise + Embedding] (PostgreSQL: rag_analises_geradas)
    ↓
[Retornar Análise]
    ↓
[Fim]
```

---

### FASE 9: Testes Integrados e Validação
**Duração Estimada:** 1 sessão (2-3 horas)  
**Pré-requisitos:**
- Todas as fases anteriores concluídas

**Objetivos:**
1. Testar fluxo completo: coleta → armazenamento → análise → cache
2. Validar qualidade das análises geradas
3. Testar casos extremos (município sem dados, pergunta ambígua)
4. Medir performance (tempo de resposta, custo por análise)
5. Identificar gargalos e oportunidades de otimização

**Entregas:**
- Relatório de testes com casos de uso
- Métricas de performance documentadas
- Lista de bugs/melhorias identificados
- Plano de otimizações futuras

**Critérios de Sucesso:**
- [ ] 10 análises de teste geradas com sucesso
- [ ] Taxa de cache > 50% em análises repetidas
- [ ] Análises fundamentadas em dados reais (não alucinações)
- [ ] Custo por análise < R$ 0,05
- [ ] Tempo médio de resposta < 10 segundos

**Casos de Teste Sugeridos:**
1. "Qual o PIB de Palmas em 2023?"
2. "Compare indicadores de educação entre Palmas e Araguaína"
3. "Quais municípios do Tocantins têm maior índice de desmatamento?"
4. "Análise integrada das 4 dimensões para o município de Porto Nacional"
5. "Evolução temporal da taxa de emprego em Tocantins (2018-2023)"

---

### FASE 10: Documentação e Checkpoint
**Duração Estimada:** 1 sessão (2-3 horas)  
**Pré-requisitos:**
- Fase 9 concluída

**Objetivos:**
1. Criar diário de pesquisa-ação da implementação do MVP
2. Documentar decisões técnicas tomadas
3. Registrar aprendizados e insights
4. Identificar próximos passos para evolução do sistema
5. Atualizar documentação do projeto

**Entregas:**
- Diário de pesquisa-ação completo
- Documentação técnica atualizada
- Guia de troubleshooting
- Roadmap de evolução pós-MVP

**Critérios de Sucesso:**
- [ ] Diário reflexivo completo (seguindo template estabelecido)
- [ ] Documentação técnica atualizada com decisões reais de implementação
- [ ] Aprendizados explicitados de forma estruturada
- [ ] Próximos passos claramente definidos

---

## 3. DEPENDÊNCIAS ENTRE FASES

```
FASE 1 (Análise) ✅
    ↓
FASE 2 (Planejamento) 🔄
    ↓
FASE 3 (Replit) ─────┐
    ↓                │
FASE 4 (Schema)      │
    ↓                │
FASE 5 (Dados) ──┐   │
    ↓            │   │
FASE 6 (n8n) ────┼───┘
    ↓            │
FASE 7 (Collector) ──┘
    ↓
FASE 8 (RAG)
    ↓
FASE 9 (Testes)
    ↓
FASE 10 (Documentação)
```

**Observações:**
- Fases 3 e 6 podem ser parcialmente paralelas (configurações independentes)
- Fase 7 depende de Fases 5 e 6 (dados territoriais + n8n configurado)
- Fase 8 pode começar assim que Fase 4 estiver concluída (não depende de Fase 7 para testes iniciais)

---

## 4. RECURSOS NECESSÁRIOS

### 4.1. Contas e Credenciais

| Recurso | Status | Custo | Notas |
|---------|--------|-------|-------|
| Replit | ✅ Criada | Gratuito (tier free) | Upgrade opcional para mais recursos |
| n8n Cloud | ✅ Criada | $20/mês (tier starter) | 5.000 execuções/mês incluídas |
| OpenAI API | ⏳ A obter | ~$10 inicial | Suficiente para ~1.800 análises |
| IBGE API | ✅ Pública | Gratuito | Sem necessidade de chave |
| INPE API | ⏳ A verificar | Gratuito | Verificar necessidade de cadastro |

### 4.2. Ferramentas de Desenvolvimento

- Editor de código: VS Code (recomendado) ou editor web do Replit
- Cliente PostgreSQL: psql (via terminal) ou DBeaver (GUI)
- Cliente HTTP: Postman ou Insomnia (para testar APIs)
- Git: Para versionamento (opcional mas recomendado)

### 4.3. Conhecimentos Técnicos

**Essenciais:**
- SQL básico (SELECT, INSERT, UPDATE)
- Conceitos de API REST
- JSON (estrutura e manipulação)

**Desejáveis:**
- Python básico (para entender scripts RAG)
- Conceitos de embeddings e busca vetorial
- Experiência com no-code/low-code (n8n)

---

## 5. ESTIMATIVAS

### 5.1. Tempo Total

- **Mínimo:** 12-15 horas (ritmo acelerado, sem problemas)
- **Realista:** 18-24 horas (ritmo moderado, com aprendizado)
- **Conservador:** 30-36 horas (ritmo lento, com experimentação)

**Distribuição por Fase:**
- Fases 1-2: 2-3 horas ✅
- Fases 3-4: 2-4 horas
- Fase 5: 2-4 horas
- Fase 6: 1-2 horas
- Fase 7: 4-6 horas (fase mais complexa)
- Fase 8: 4-6 horas (fase mais complexa)
- Fase 9: 2-3 horas
- Fase 10: 2-3 horas

### 5.2. Custo Total (MVP)

| Item | Custo Mensal | Custo Inicial | Notas |
|------|--------------|---------------|-------|
| Replit | $0 | $0 | Tier gratuito suficiente para MVP |
| n8n Cloud | $20 | $20 | Primeiro mês |
| OpenAI | ~$3-5 | $10 | Créditos iniciais, uso real ~$3-5/mês |
| **TOTAL** | **~$23-25** | **~$30** | Custo recorrente baixo |

### 5.3. Número de Sessões

Considerando sessões de 2-3 horas com checkpoints:

- **Mínimo:** 6-8 sessões
- **Realista:** 10-12 sessões
- **Conservador:** 15-18 sessões

---

## 6. RISCOS E MITIGAÇÕES

### 6.1. Riscos Técnicos

| Risco | Probabilidade | Impacto | Mitigação |
|-------|---------------|---------|-----------|
| PostgreSQL do Replit insuficiente | Média | Alto | Ter Neon como plano B (gratuito, 0.5GB) |
| APIs públicas instáveis | Média | Médio | Implementar retry logic e cache agressivo |
| Limite de execuções n8n | Baixa | Médio | Monitorar uso, otimizar workflows |
| Custo OpenAI maior que estimado | Baixa | Baixo | Usar GPT-4o-mini, implementar cache eficiente |
| Dificuldade com pgvector | Média | Alto | Documentação detalhada, fallback para busca SQL |

### 6.2. Riscos de Aprendizado

| Risco | Probabilidade | Impacto | Mitigação |
|-------|---------------|---------|-----------|
| Curva de aprendizado n8n | Média | Médio | Tutoriais passo-a-passo, exemplos comentados |
| Complexidade do RAG | Alta | Alto | Implementação incremental, testes frequentes |
| Dificuldade com SQL espacial | Média | Médio | Queries pré-prontas, documentação PostGIS |

---

## 7. PRÓXIMOS PASSOS IMEDIATOS

### 7.1. Antes da Próxima Sessão

**Ações do Usuário:**
1. Obter chave de API OpenAI
   - Acessar https://platform.openai.com/api-keys
   - Criar chave "Framework V6.0 - MVP"
   - Adicionar $10 USD de créditos
   - Guardar chave em local seguro

2. Revisar documentação do projeto
   - Ler QUICKSTART.md (30 min)
   - Revisar schema das 40 tabelas (opcional, 20 min)
   - Familiarizar-se com conceito de RAG (opcional, 20 min)

3. Preparar ambiente local
   - Instalar VS Code (se preferir editor local)
   - Instalar Python 3.9+ (se não tiver)
   - Criar pasta local para o projeto

**Ações do Assistente:**
1. Preparar roteiro detalhado da Fase 3 (Configuração Replit)
2. Criar checklist de verificação para cada fase
3. Preparar scripts de teste prontos para uso

### 7.2. Próxima Sessão (Fase 3)

**Objetivo:** Configurar ambiente Replit completo e funcional

**Duração Estimada:** 1-2 horas

**Agenda:**
1. Criar projeto Replit
2. Ativar PostgreSQL
3. Instalar extensões (PostGIS, pgvector)
4. Configurar variáveis de ambiente
5. Testar conectividade
6. Executar primeiro script de verificação

**Preparação:**
- Ter chave OpenAI em mãos
- Ter conta Replit logada
- Ter este documento de planejamento revisado

---

## 8. CRITÉRIOS DE SUCESSO DO MVP

Ao final da Fase 9, o MVP será considerado bem-sucedido se:

### 8.1. Critérios Funcionais

- [ ] Sistema capaz de coletar dados reais de pelo menos 2 dimensões via APIs públicas
- [ ] Dados de Tocantins (1 estado + 139 municípios) armazenados no PostgreSQL
- [ ] Sistema RAG gerando análises fundamentadas em dados reais
- [ ] Cache funcionando e reduzindo custos em pelo menos 50%
- [ ] Workflow n8n Data Collector executando sem erros críticos

### 8.2. Critérios de Performance

- [ ] Tempo de resposta < 15 segundos para análise nova
- [ ] Tempo de resposta < 3 segundos para análise em cache
- [ ] Custo por análise < R$ 0,05
- [ ] Taxa de sucesso de coleta de dados > 90%

### 8.3. Critérios de Qualidade

- [ ] Análises geradas são coerentes e fundamentadas
- [ ] Não há alucinações evidentes (dados inventados)
- [ ] Sistema trata erros graciosamente (não quebra)
- [ ] Logs permitem debugging eficiente

### 8.4. Critérios de Aprendizado

- [ ] Usuário capaz de explicar arquitetura do sistema
- [ ] Usuário capaz de modificar workflows n8n de forma autônoma
- [ ] Usuário capaz de adicionar novas fontes de dados
- [ ] Usuário capaz de troubleshoot problemas comuns

---

## 9. EVOLUÇÃO PÓS-MVP

### 9.1. Incrementos Planejados (Pós-Fase 10)

**Curto Prazo (1-2 meses):**
- Adicionar agentes especializados (TERRA, ECON, SOCIAL, INTERACT)
- Implementar lógica de interação entre agentes (Meta Orchestrator)
- Expandir coleta para todas as 4 dimensões completas
- Implementar frontend básico (dashboard Replit)

**Médio Prazo (3-6 meses):**
- Adicionar mais municípios brasileiros (benchmark)
- Implementar sistema de reranking (Cohere)
- Otimizar performance (Redis cache, query optimization)
- Implementar autenticação e controle de acesso

**Longo Prazo (6-12 meses):**
- Expansão internacional (dados de outros países)
- Sistema de alertas e monitoramento automático
- API pública para terceiros
- Modelo de negócio SaaS (startup)

### 9.2. Aprendizados Transferíveis

Este projeto servirá como base para:
- Outros sistemas multi-agentes de automação
- Projetos de inteligência territorial em diferentes contextos
- Sistemas RAG para outros domínios
- Metodologia de implementação de MVPs complexos

---

## 10. RECURSOS DE APOIO

### 10.1. Documentação de Referência

**Projeto:**
- README.md (guia completo)
- QUICKSTART.md (guia rápido)
- docs/guias/ (guias especializados)

**Tecnologias:**
- PostgreSQL: https://www.postgresql.org/docs/
- PostGIS: https://postgis.net/documentation/
- pgvector: https://github.com/pgvector/pgvector
- n8n: https://docs.n8n.io/
- OpenAI: https://platform.openai.com/docs/

**APIs:**
- IBGE: https://servicodados.ibge.gov.br/api/docs
- INPE Queimadas: https://queimadas.dgi.inpe.br/queimadas/dados-abertos/
- INPE PRODES: http://terrabrasilis.dpi.inpe.br/

### 10.2. Comunidades e Suporte

- n8n Community: https://community.n8n.io/
- PostgreSQL Brasil: https://www.postgresql.org.br/
- Stack Overflow (tags: postgresql, n8n, openai, postgis)

---

**Documento preparado por:** Manus AI  
**Revisão:** Aguardando feedback do usuário  
**Próxima Atualização:** Após conclusão de cada fase
