# Configuração Personalizada do MVP - Framework V6.0

**Data:** 10 de Novembro de 2025  
**Versão:** 1.0  
**Status:** Configuração Definida  
**Baseado em:** Respostas do usuário às perguntas adicionais

---

## 1. PERFIL DO USUÁRIO E PREFERÊNCIAS

### 1.1. Experiência Técnica

**Nível de Experiência:**
- ✅ Primeira experiência com APIs OpenAI
- ✅ Primeira experiência com Replit
- ✅ Primeira experiência com ecossistema no-code
- ✅ Não usou ferramentas de automação (Zapier, Make, etc.)
- ✅ Tem bagagem teórica em gerenciamento de processos
- ✅ Alguma experiência com código (várias linguagens)

**Implicações para Implementação:**
- Instruções mais detalhadas para APIs OpenAI
- Tour guiado da interface Replit
- Foco em no-code/low-code, código apenas para ajustes finos
- Explicações conceituais sobre automação de workflows
- Aproveitar conhecimento de processos para design de workflows

---

### 1.2. Preferências de Trabalho

**Ferramentas:**
- ✅ Editor web do Replit (não VS Code local)
- ✅ Interface gráfica (não terminal)
- ✅ n8n visual drag-and-drop (JSON apenas para importação)

**Metodologia:**
- ✅ Sessões curtas (1-1.5h) e frequentes
- ✅ Fará anotações durante as sessões
- ✅ Foco em aprendizado e autonomia

**Implicações:**
- Sessões bem estruturadas com checkpoints claros
- Pausas para anotações em momentos-chave
- Explicações conceituais antes de ações práticas
- Recapitulações frequentes
- Documentação visual (screenshots, diagramas)

---

## 2. CONFIGURAÇÃO TÉCNICA PERSONALIZADA

### 2.1. Modelos de IA

**Estratégia de Uso:**

**Modelo Padrão (Análises):** GPT-4o-mini
- Custo: ~$0.015/análise
- Uso: 90% das análises (casos gerais)
- Justificativa: Melhor custo-benefício, qualidade suficiente

**Modelo Premium (Análises Complexas):** GPT-4o
- Custo: ~$0.03/análise
- Uso: 10% das análises (casos complexos, multi-dimensionais)
- Justificativa: Qualidade superior quando necessário, custo repassável

**Modelo de Embeddings:** text-embedding-3-small
- Custo: $0.02/1M tokens
- Uso: 100% dos embeddings
- Justificativa: Padrão da indústria, 1536 dimensões, excelente custo-benefício

**Modelos Alternativos a Avaliar (Futuro):**
- **Claude (Anthropic):** Para análises que requerem raciocínio profundo
- **Groq (Gratuito/Barato):** Para testes e desenvolvimento
- **DeepSeek (Gratuito/Barato):** Para tarefas específicas se mostrar melhor desempenho

**Configuração no .env:**
```bash
# Modelo padrão para análises gerais
LLM_MODEL=gpt-4o-mini

# Modelo premium para análises complexas (configurável por workflow)
LLM_MODEL_PREMIUM=gpt-4o

# Modelo de embeddings
EMBEDDING_MODEL=text-embedding-3-small

# Threshold para usar modelo premium (similaridade do cache)
PREMIUM_MODEL_THRESHOLD=0.70
```

**Lógica de Seleção de Modelo (a implementar no n8n):**
```
SE análise_multi_dimensional OU análise_comparativa_complexa:
    usar GPT-4o
SENÃO:
    usar GPT-4o-mini
```

---

### 2.2. Orçamento e Custos

**Orçamento Mensal (Fase de Testes):** $50 USD

**Distribuição Estimada:**
| Item | Custo Mensal | % do Orçamento | Notas |
|------|--------------|----------------|-------|
| n8n Cloud (Starter) | $20 | 40% | 5.000 execuções/mês |
| OpenAI (análises + embeddings) | $15-20 | 30-40% | ~1.000-1.500 análises |
| Replit (Free tier) | $0 | 0% | Upgrade se necessário |
| Margem de segurança | $10-15 | 20-30% | Buffer para testes |
| **TOTAL** | **~$35-40** | **70-80%** | Dentro do orçamento |

**Otimizações de Custo:**
1. **Cache Agressivo:** 70% de taxa de acerto = 70% de economia
2. **GPT-4o-mini como padrão:** 50% mais barato que GPT-4o
3. **Replit Free Tier:** $0 vs $7-20/mês de alternativas
4. **Coleta de dados incremental:** Evitar re-coletas desnecessárias

**Projeção de Uso Sustentável:**
- Com cache de 70%: ~3.000-5.000 análises/mês dentro do orçamento
- Custo por análise efetivo: ~$0.005-0.01 (com cache)
- Viável para startup em fase inicial

**Plano de Escalabilidade:**
- **Fase 1 (MVP):** $35-40/mês (testes internos)
- **Fase 2 (Piloto):** $50-100/mês (primeiros clientes, custo repassado)
- **Fase 3 (Expansão):** $200-500/mês (múltiplos clientes, receita > custo)

---

### 2.3. Infraestrutura

**Replit:**
- Plano: Free tier (upgrade se necessário)
- Uso: PostgreSQL + Backend Python (scripts RAG)
- Interface: Editor web (não local)
- Acesso: Via navegador

**n8n Cloud:**
- Plano: Starter ($20/mês)
- Limite: 5.000 execuções/mês
- Uso estimado: 1.000-2.000 execuções/mês (confortável)
- Interface: Visual drag-and-drop

**PostgreSQL:**
- Fonte: Replit nativo (teste inicial)
- Extensões: PostGIS + pgvector
- Plano B: Neon (gratuito, 0.5GB) se Replit insuficiente
- Volume estimado MVP: ~100-200 MB (140 entidades + 5 anos dados)

---

## 3. ESCOPO DE DADOS PERSONALIZADO

### 3.1. Cobertura Territorial

**Entidades:**
- 1 estado (Tocantins)
- 139 municípios tocantinenses
- **Total: 140 entidades territoriais**

**Justificativa:**
- Cobertura completa desde MVP
- Permite análises comparativas entre municípios
- Base sólida para expansão futura
- Dados do estado não são soma dos municípios (ex: orçamento estadual)

**Dados Territoriais Básicos (Tabela `entidades_territoriais`):**
```sql
INSERT INTO entidades_territoriais (
    codigo_ibge,
    nome,
    tipo,
    uf,
    regiao,
    populacao_estimada,
    area_km2,
    geometria
) VALUES
    ('17', 'Tocantins', 'estado', 'TO', 'Norte', 1607363, 277620.914, ST_GeomFromGeoJSON(...)),
    ('1721000', 'Palmas', 'municipio', 'TO', 'Norte', 306296, 2218.942, ST_GeomFromGeoJSON(...)),
    -- ... (mais 138 municípios)
```

---

### 3.2. Dimensão Econômica (Prioridade 1)

**Indicadores Prioritários (5 anos históricos: 2019-2023):**

**Tabela: `indicadores_economicos_pib`**
- PIB total (R$ correntes e constantes)
- PIB per capita
- Participação setorial (Agropecuária, Indústria, Serviços)
- Taxa de crescimento anual

**Tabela: `indicadores_economicos_emprego`**
- População ocupada
- Taxa de desemprego
- Empregos formais (CAGED/RAIS)
- Massa salarial

**Tabela: `indicadores_economicos_renda`**
- Renda média domiciliar per capita
- Índice de Gini
- % população em extrema pobreza
- Bolsa Família (beneficiários e valores)

**Fonte de Dados:**
- IBGE - Produto Interno Bruto dos Municípios
- IBGE - Pesquisa Nacional por Amostra de Domicílios (PNAD)
- Ministério do Trabalho - CAGED/RAIS
- Ministério da Cidadania - Cadastro Único

**APIs:**
```
# PIB Municipal
https://servicodados.ibge.gov.br/api/v1/pesquisas/38/periodos/2019|2020|2021|2022|2023/resultados

# PNAD (Renda e Emprego)
https://servicodados.ibge.gov.br/api/v3/agregados/6408/periodos/2019|2020|2021|2022|2023/variaveis/606

# CAGED (Emprego Formal)
https://pdet.mte.gov.br/api/caged/municipio/{codigo_ibge}
```

**Estimativa de Registros:**
- 140 entidades × 5 anos × 3 tabelas = **2.100 registros** (dimensão econômica)

---

### 3.3. Outras Dimensões (Prioridade 2-4)

**Dimensão Social:**
- Educação (IDEB, matrículas, infraestrutura escolar)
- Saúde (leitos, médicos, mortalidade infantil)
- Segurança (criminalidade, efetivo policial)

**Dimensão Territorial:**
- Uso do solo (área urbana, rural, preservação)
- Infraestrutura (saneamento, energia, internet)
- Mobilidade (frota, acidentes)

**Dimensão Ambiental:**
- Desmatamento (PRODES)
- Queimadas (INPE)
- Recursos hídricos (ANA)
- Clima (INMET)

**Implementação:**
- Começar com Econômica (Fase 7)
- Adicionar outras dimensões incrementalmente (pós-MVP)
- Usar mesma estrutura de coleta (Data Collector modular)

---

### 3.4. Dados Históricos

**Período Inicial:** 5 anos (2019-2023)
- Justificativa: Captura tendências recentes e impacto da pandemia
- Volume gerenciável para MVP
- Permite análises temporais significativas

**Expansão Futura:** 10-20 anos
- Após validação do MVP
- Análises de longo prazo
- Identificação de ciclos econômicos

**Atualização:**
- Dados econômicos: Anual (IBGE divulga com ~1 ano de defasagem)
- Dados ambientais: Mensal (INPE - queimadas) ou Anual (PRODES - desmatamento)
- Dados sociais: Anual (maioria) ou Bianual (Censo)

---

## 4. ESTRUTURA DE SESSÕES PERSONALIZADA

### 4.1. Formato das Sessões

**Duração:** 1-1.5 horas (curtas e frequentes)

**Estrutura Padrão:**
```
[00:00-00:10] Recapitulação da sessão anterior
    ↓
[00:10-00:15] Objetivos da sessão atual
    ↓
[00:15-00:45] Execução passo-a-passo (com pausas para anotações)
    ↓
[00:45-00:55] Validação e testes
    ↓
[00:55-01:00] Resumo e próximos passos
    ↓
[01:00-01:10] Checkpoint e documentação (opcional, se tempo permitir)
```

**Pausas para Anotações:**
- Após cada conceito novo explicado
- Após cada configuração importante
- Após cada teste bem-sucedido
- Ao final de cada sub-fase

---

### 4.2. Cronograma Revisado

Considerando sessões de 1-1.5h:

| Fase | Sessões | Duração Total | Descrição |
|------|---------|---------------|-----------|
| 1-2 | 1 | 1.5h | ✅ Análise e Planejamento |
| 3 | 1 | 1-1.5h | Configuração Replit |
| 4 | 1 | 1-1.5h | Schema do Banco |
| 5 | 2 | 2-3h | População de Dados Territoriais |
| 6 | 1 | 1-1.5h | Configuração n8n |
| 7 | 3-4 | 4-6h | Data Collector (Dimensão Econômica) |
| 8 | 3-4 | 4-6h | Sistema RAG |
| 9 | 2 | 2-3h | Testes Integrados |
| 10 | 1-2 | 2-3h | Documentação Final |
| **TOTAL** | **15-18** | **20-27h** | Estimativa realista |

**Frequência Recomendada:**
- 2-3 sessões por semana
- Intervalo de 1-2 dias entre sessões (tempo para assimilação)
- **Duração total do projeto: 6-9 semanas**

---

### 4.3. Checkpoints de Aprendizado

Ao final de cada fase, documentar:

**Conceitos Aprendidos:**
- O que aprendi nesta fase?
- Quais conceitos eram novos para mim?
- O que ainda não ficou claro?

**Habilidades Desenvolvidas:**
- O que consigo fazer agora que não conseguia antes?
- Onde ainda preciso de suporte?
- O que posso replicar em outros projetos?

**Problemas e Soluções:**
- Quais erros encontrei?
- Como foram resolvidos?
- O que faria diferente da próxima vez?

**Próximos Passos:**
- O que preciso revisar antes da próxima sessão?
- Há algo que posso explorar por conta própria?
- Quais dúvidas levar para a próxima sessão?

---

## 5. ADAPTAÇÕES PARA NO-CODE/LOW-CODE

### 5.1. Princípios de Design

**Prioridade 1: Interface Visual**
- n8n: 100% drag-and-drop
- Replit: Editor web com interface gráfica
- PostgreSQL: Queries via interface visual quando possível

**Prioridade 2: Código Comentado**
- Quando código for necessário, será amplamente comentado
- Explicações linha-a-linha para conceitos novos
- Exemplos práticos e reutilizáveis

**Prioridade 3: Templates Prontos**
- Workflows n8n pré-configurados (importação JSON)
- Scripts Python prontos para uso
- Queries SQL testadas e documentadas

---

### 5.2. Abordagem de Ensino

**Para Conceitos Novos:**
1. **Explicação conceitual** (o que é, por que é importante)
2. **Demonstração visual** (como funciona na interface)
3. **Execução guiada** (você faz, eu oriento)
4. **Validação** (testamos juntos)
5. **Reflexão** (pausa para anotações e perguntas)

**Para Tarefas Repetitivas:**
1. Primeira vez: Passo-a-passo detalhado
2. Segunda vez: Passo-a-passo resumido
3. Terceira vez: Você executa de forma autônoma

**Para Troubleshooting:**
1. Identificar erro (ler mensagem de erro juntos)
2. Entender causa (explicação conceitual)
3. Aplicar solução (passo-a-passo)
4. Documentar (adicionar às anotações)
5. Prevenir (como evitar no futuro)

---

### 5.3. Uso de Código

**Quando Código é Necessário:**
- Instalação de extensões PostgreSQL (comandos SQL)
- Configuração de scripts Python RAG (já prontos, apenas ajustes)
- Queries SQL complexas (fornecidas prontas, com explicações)
- Importação de workflows n8n (JSON, apenas importar)

**Quando Código é Opcional:**
- Ajustes finos de performance
- Customizações avançadas
- Integrações futuras

**Estratégia:**
- Código será fornecido pronto e testado
- Explicações conceituais do que o código faz
- Você não precisa escrever código do zero
- Foco em entender lógica, não sintaxe

---

## 6. CONFIGURAÇÃO DO DATA COLLECTOR (FASE 7)

### 6.1. Escopo Detalhado

**Dimensão:** Econômica (prioridade 1)

**Indicadores:**
1. PIB Municipal (total, per capita, setorial)
2. Emprego Formal (CAGED)
3. Renda Domiciliar (PNAD)

**Período:** 2019-2023 (5 anos)

**Cobertura:** 140 entidades (1 estado + 139 municípios)

**Volume de Dados:**
- 140 entidades × 5 anos × 3 indicadores = **2.100 registros**

---

### 6.2. Estrutura do Workflow (Visual)

```
┌─────────────────────────────────────────────────────────────┐
│                    WF01: Data Collector                      │
│                   (Dimensão Econômica)                       │
└─────────────────────────────────────────────────────────────┘

[1. Trigger Manual]
    │
    ├─ Descrição: Botão "Executar" na interface n8n
    │
    ↓
[2. PostgreSQL: Buscar Entidades]
    │
    ├─ Query: SELECT codigo_ibge, nome, tipo FROM entidades_territoriais
    ├─ Resultado: 140 entidades
    │
    ↓
[3. Loop: Para Cada Entidade]
    │
    ├─ Iteração: 140 vezes (1 por entidade)
    │
    ↓
    ┌─────────────────────────────────────────────────────────┐
    │ [4. HTTP Request: IBGE - PIB Municipal]                 │
    │     │                                                    │
    │     ├─ URL: https://servicodados.ibge.gov.br/...        │
    │     ├─ Parâmetros: codigo_ibge, anos=2019-2023          │
    │     ├─ Resultado: JSON com dados de PIB                 │
    │     │                                                    │
    │     ↓                                                    │
    │ [5. Transformar Dados PIB]                              │
    │     │                                                    │
    │     ├─ Extrair: pib_total, pib_per_capita, etc.         │
    │     ├─ Formatar: Estrutura do banco de dados            │
    │     │                                                    │
    │     ↓                                                    │
    │ [6. PostgreSQL: Inserir/Atualizar PIB]                  │
    │     │                                                    │
    │     ├─ Tabela: indicadores_economicos_pib               │
    │     ├─ Ação: UPSERT (INSERT ... ON CONFLICT UPDATE)     │
    │     │                                                    │
    └─────┼────────────────────────────────────────────────────┘
          │
          ↓
    ┌─────────────────────────────────────────────────────────┐
    │ [7. HTTP Request: IBGE - PNAD (Renda)]                  │
    │     │                                                    │
    │     ├─ URL: https://servicodados.ibge.gov.br/...        │
    │     ├─ Resultado: JSON com dados de renda               │
    │     │                                                    │
    │     ↓                                                    │
    │ [8. Transformar Dados Renda]                            │
    │     │                                                    │
    │     ↓                                                    │
    │ [9. PostgreSQL: Inserir/Atualizar Renda]                │
    │     │                                                    │
    │     ├─ Tabela: indicadores_economicos_renda             │
    │     │                                                    │
    └─────┼────────────────────────────────────────────────────┘
          │
          ↓
    ┌─────────────────────────────────────────────────────────┐
    │ [10. HTTP Request: CAGED (Emprego)]                     │
    │     │                                                    │
    │     ↓                                                    │
    │ [11. Transformar Dados Emprego]                         │
    │     │                                                    │
    │     ↓                                                    │
    │ [12. PostgreSQL: Inserir/Atualizar Emprego]             │
    │     │                                                    │
    │     ├─ Tabela: indicadores_economicos_emprego           │
    │     │                                                    │
    └─────┼────────────────────────────────────────────────────┘
          │
          ↓
[13. Fim do Loop]
    │
    ↓
[14. Resumo da Execução]
    │
    ├─ Total de entidades processadas: 140
    ├─ Total de registros inseridos: ~2.100
    ├─ Erros encontrados: (se houver)
    │
    ↓
[15. Notificação (Opcional)]
    │
    ├─ Email ou Webhook com resumo
    │
    ↓
[FIM]
```

---

### 6.3. Tratamento de Erros

**Estratégias:**
1. **Retry Logic:** Tentar novamente em caso de falha de rede (3 tentativas)
2. **Fallback:** Se API falhar, registrar erro e continuar com próxima entidade
3. **Logging:** Registrar todas as ações (sucesso e erro) em tabela de logs
4. **Validação:** Verificar se dados retornados são válidos antes de inserir

**Implementação no n8n:**
- Nó "Error Trigger" para capturar erros
- Nó "If" para validar dados
- Nó "Set" para registrar logs
- Nó "Wait" para implementar retry com delay

---

## 7. PRÓXIMA SESSÃO (FASE 3)

### 7.1. Objetivos

1. Criar projeto no Replit
2. Ativar PostgreSQL
3. Instalar extensões PostGIS e pgvector
4. Configurar variáveis de ambiente
5. Testar conectividade

### 7.2. Preparação do Usuário

**Antes da Sessão:**
- [ ] Obter chave OpenAI e adicionar $10 de créditos
- [ ] Fazer login no Replit
- [ ] Ter este documento revisado
- [ ] Ter papel e caneta para anotações

**Durante a Sessão:**
- Navegador aberto em Replit
- Documento de planejamento aberto para consulta
- Bloco de notas para anotações
- Tempo reservado sem interrupções (1-1.5h)

### 7.3. Resultado Esperado

Ao final da Fase 3, você terá:
- ✅ Projeto Replit configurado
- ✅ PostgreSQL rodando
- ✅ Extensões instaladas
- ✅ Variáveis de ambiente configuradas
- ✅ Primeiro teste de conexão bem-sucedido

---

## 8. RESUMO DA CONFIGURAÇÃO

### 8.1. Decisões Principais

| Aspecto | Decisão | Justificativa |
|---------|---------|---------------|
| **Modelo IA** | GPT-4o-mini (padrão) + GPT-4o (premium) | Custo-benefício, flexibilidade |
| **Orçamento** | $50/mês (fase teste) | Sustentável, com margem de segurança |
| **Interface** | No-code/visual (Replit web + n8n drag-and-drop) | Preferência do usuário, foco em aprendizado |
| **Sessões** | Curtas (1-1.5h) e frequentes | Facilita encaixe na rotina |
| **Dimensão Inicial** | Econômica | Prioridade definida pelo usuário |
| **Dados Históricos** | 5 anos (2019-2023) | Balanceio entre volume e relevância |
| **Cobertura** | 140 entidades (TO + 139 municípios) | Cobertura completa desde MVP |

### 8.2. Arquivos de Configuração

**`.env` (Replit):**
```bash
# OpenAI
OPENAI_API_KEY=sk-proj-[SUA_CHAVE]

# PostgreSQL (será gerado pelo Replit)
DATABASE_URL=postgresql://[gerado_automaticamente]

# Modelos
LLM_MODEL=gpt-4o-mini
LLM_MODEL_PREMIUM=gpt-4o
EMBEDDING_MODEL=text-embedding-3-small

# Cache
CACHE_TTL=2592000  # 30 dias em segundos
PREMIUM_MODEL_THRESHOLD=0.70

# Logs
LOG_LEVEL=INFO
```

**Credenciais n8n:**
- Nome: "PostgreSQL - Framework V6"
- Tipo: PostgreSQL
- Host: [do Replit]
- Database: [do Replit]
- User: [do Replit]
- Password: [do Replit]
- SSL: Enabled

---

**Documento preparado por:** Manus AI  
**Baseado em:** Respostas do usuário às perguntas adicionais  
**Status:** Pronto para implementação  
**Próximo Passo:** Fase 3 - Configuração do Replit
