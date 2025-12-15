# Prompt para Replit Agent - Dashboard de Inteligência Territorial

## Prompt Principal (Copiar e Colar no Replit Agent)

```
Criar aplicação web full-stack de Dashboard de Inteligência Territorial para gestores públicos do estado do Tocantins, Brasil.

=== OBJETIVO ===
Sistema de análise territorial com IA integrada para apoiar decisões de gestão pública, focado em 4 dimensões: Econômica, Social, Territorial e Ambiental.

=== PÚBLICO-ALVO ===
Gestores públicos municipais e estaduais SEM familiaridade técnica. Interface deve ser extremamente intuitiva, funcional e com destaque para interação com IA.

=== ARQUITETURA GERAL ===

FRONTEND:
- React 18+ com TypeScript
- Tailwind CSS para estilização
- Layout responsivo (desktop, tablet, mobile)
- Navegação por abas (6 abas principais)
- Chat com IA lateral fixo (sempre visível)

BACKEND:
- Python 3.11+ com FastAPI
- PostgreSQL 14+ com extensões PostGIS e pgvector
- Sistema RAG (Retrieval-Augmented Generation) com OpenAI API
- APIs REST para CRUD de dados e geração de análises

BANCO DE DADOS:
- 40 tabelas (schema será fornecido posteriormente)
- Dados de 140 entidades territoriais:
  * 1 estado (Tocantins)
  * 139 municípios
  * 3 regiões intermediárias
  * 11 regiões imediatas
  * 2 mesorregiões históricas
  * 8 microrregiões históricas
- Dados históricos (5-20 anos conforme disponibilidade)
- Suporte a dados geoespaciais (PostGIS) e embeddings vetoriais (pgvector)

=== LAYOUT DO DASHBOARD ===

ESTRUTURA PRINCIPAL:
┌─────────────────────────────────────────────────────────────┬──────────────┐
│ HEADER: Logo + Título + Painel de Controle                  │              │
├─────────────────────────────────────────────────────────────┤              │
│ NAVEGAÇÃO POR ABAS (Horizontal):                            │              │
│ [Visão Geral] [Econômica] [Social] [Territorial]            │   CHAT IA    │
│ [Ambiental] [Comparação]                                     │   (Fixo)     │
├─────────────────────────────────────────────────────────────┤   300px      │
│                                                              │              │
│ ÁREA DE CONTEÚDO PRINCIPAL (Varia por aba):                 │              │
│ - KPIs (4 cards horizontais)                                │              │
│ - Gráficos (2 colunas)                                       │              │
│ - Caixa de Análise IA                                        │              │
│ - Tabela de Dados                                            │              │
│                                                              │              │
└─────────────────────────────────────────────────────────────┴──────────────┘

PAINEL DE CONTROLE SUPERIOR:
- Seletor 1: Tipo de Território (dropdown)
  Opções: Estado | Região Intermediária | Região Imediata | Município | Mesorregião | Microrregião
- Seletor 2: Território Específico (dropdown dinâmico com busca)
  Conteúdo muda conforme Seletor 1
- Seletor 3: Período Temporal (dropdown)
  Opções: Últimos 5 anos | Últimos 10 anos | Últimos 20 anos | Customizado
- Seletor 4: Indicadores (multi-select, varia por aba)
- Botões: Resetar | Salvar Configuração | Compartilhar

=== 6 ABAS PRINCIPAIS ===

ABA 1: VISÃO GERAL
- Grid 2x2 com síntese das 4 dimensões
- Cada quadrante: 2 KPIs + mini gráfico + badge de status
- Caixa de Análise IA integrada (síntese das 4 dimensões)

ABA 2: ECONÔMICA
- KPIs: PIB Total | PIB per Capita | Taxa de Emprego | Arrecadação Municipal
- Gráfico 1: Evolução do PIB (linha, 5 anos)
- Gráfico 2: Composição Setorial do PIB (barras)
- Caixa de Análise IA: Insights econômicos
- Tabela: Dados históricos detalhados

ABA 3: SOCIAL
- KPIs: IDH-M | População Total | Taxa de Alfabetização | Renda per Capita
- Gráfico 1: Componentes do IDH-M (radar)
- Gráfico 2: Indicadores Educacionais (barras horizontais)
- Caixa de Análise IA: Desenvolvimento humano
- Tabela: Dados demográficos e sociais

ABA 4: TERRITORIAL
- KPIs: Área Total | Área Urbanizada | Densidade Demográfica | Cobertura Saneamento
- Visualização 1: Mapa Interativo (Leaflet ou Mapbox)
- Visualização 2: Uso do Solo (pizza)
- Caixa de Análise IA: Padrões de ocupação
- Tabela: Dados geoespaciais

ABA 5: AMBIENTAL
- KPIs: Cobertura Vegetal | Área Desmatada | Qualidade Água (IQA) | Emissões CO₂
- Gráfico 1: Evolução Cobertura Vegetal (área empilhada)
- Gráfico 2: Qualidade da Água (linha com referência)
- Caixa de Análise IA: Riscos ambientais
- Tabela: Dados ambientais

ABA 6: COMPARAÇÃO (NOVA - IMPORTANTE)
- Seletor multi-território (até 5 territórios)
- Seletor de dimensão e indicadores
- Gráfico 1: Barras agrupadas (comparação indicadores)
- Gráfico 2: Radar/Spider (perfil multidimensional)
- Tabela comparativa (territórios x indicadores)
- Caixa de Análise IA: Benchmarking e insights comparativos

=== CHAT IA LATERAL (COMPONENTE CRÍTICO) ===

POSIÇÃO: Lateral direita, fixo em todas as telas
LARGURA: 300px (desktop), fullscreen (mobile)

ESTRUTURA:
┌──────────────────────┐
│ Header:              │
│ - Ícone IA (animado) │
│ - Título             │
│ - Badge de contexto  │
│ - Botões (min/exp)   │
├──────────────────────┤
│ Área de Mensagens:   │
│ - Scroll vertical    │
│ - Msgs usuário (dir) │
│ - Msgs IA (esq)      │
│ - Timestamps         │
├──────────────────────┤
│ Sugestões:           │
│ [Chip 1] [Chip 2]    │
│ [Chip 3] [Chip 4]    │
├──────────────────────┤
│ Input:               │
│ [Campo de texto...]  │
│ [Botão Enviar]       │
└──────────────────────┘

FUNCIONALIDADES:
- Contexto automático (sabe qual aba, território, dimensão está ativa)
- Sugestões de perguntas contextuais (3-4 chips clicáveis)
- Typing indicator durante processamento
- Suporte a markdown nas respostas
- Exportação de conversa em PDF
- Estados: normal (300px), minimizado (60px ícone), expandido (500px)

INTEGRAÇÃO IA:
- OpenAI GPT-4o-mini (padrão) ou GPT-4o (análises complexas)
- Sistema RAG: busca em embeddings de dados territoriais
- Prompt contextual: inclui território, dimensão, indicadores visíveis
- Respostas: 150-250 palavras, objetivas, com dados quantitativos

=== CAIXA DE ANÁLISE IA (EM CADA ABA) ===

APARÊNCIA:
- Fundo: rgba(6, 182, 212, 0.1) (cyan transparente)
- Borda superior: 3px solid #06b6d4
- Ícone de IA pulsante no canto
- Título: "Análise [Dimensão] por IA"

CONTEÚDO:
- Texto gerado automaticamente ao carregar aba/mudar território
- 150-250 palavras
- Estrutura: Contexto → Insights → Alertas/Oportunidades
- Dados quantitativos integrados
- Comparação com médias regionais
- Linguagem acessível para gestores públicos

GERAÇÃO:
- Trigger: Mudança de aba, território ou indicadores
- Loading state: Skeleton screen
- Erro: Mensagem amigável + botão "Tentar novamente"

=== FUNCIONALIDADES DE EXPORTAÇÃO ===

EXPORTAÇÃO PDF:
- Escopo: Aba atual ou dashboard completo
- Conteúdo: Cabeçalho + KPIs + Gráficos (alta res) + Análise IA + Tabela + Rodapé
- Opções: Incluir chat | Formato A4/Carta | Orientação
- Botão: Header (ícone PDF) ou no final de cada aba

EXPORTAÇÃO CSV:
- Escopo: Tabela de dados da aba atual
- Formato: UTF-8, delimitador configurável
- Metadados: Território, período, fonte em linhas de comentário
- Botão: Acima de cada tabela

COMPARTILHAMENTO:
- Link direto (URL com query params preservando configuração)
- QR Code para acesso mobile
- Embed code (futuro)

=== RESPONSIVIDADE ===

DESKTOP (1280px+):
- Layout completo conforme descrito
- Chat lateral fixo (300px)

TABLET (768px-1279px):
- Chat colapsa em drawer (desliza da direita)
- Botão flutuante para abrir chat
- Gráficos redimensionam

MOBILE (<768px):
- Abas viram accordion vertical
- Chat abre em modal fullscreen
- KPIs em grid 2x2
- Gráficos empilhados
- Seletores em modals
- Botões touch-friendly (min 44x44px)

=== PALETA DE CORES ===

PRIMARY: #1e3a8a (Navy Blue) - Fundos principais
SECONDARY: #06b6d4 (Cyan) - Títulos, destaques, links
ACCENT_1: #f97316 (Orange) - Ações primárias, alertas
ACCENT_2: #10b981 (Green) - Sucesso, crescimento
ACCENT_3: #fbbf24 (Yellow) - Avisos
NEUTRAL_LIGHT: #ffffff (White) - Texto principal
NEUTRAL_DARK: #6b7280 (Gray) - Texto secundário

APLICAÇÃO:
- Background geral: Navy Blue
- Cards/Modals: White com sombra sutil
- Títulos principais: Cyan
- Botões primários: Orange
- Badges positivos: Green
- Badges negativos/alertas: Yellow/Orange
- Texto corpo: White (em fundo navy) ou Gray (em fundo white)

=== TIPOGRAFIA ===

FONTE: Inter (Google Fonts)
- Títulos H1: 36px, Bold (700)
- Títulos H2: 24px, Semibold (600)
- Títulos H3: 20px, Semibold (600)
- Corpo: 16px, Regular (400)
- Captions: 14px, Regular (400)
- KPIs (números grandes): 32px, Bold (700)

=== BIBLIOTECAS RECOMENDADAS ===

FRONTEND:
- React 18+ com TypeScript
- Tailwind CSS (estilização)
- Headless UI ou Radix UI (componentes acessíveis)
- Chart.js ou Recharts (gráficos)
- Leaflet ou Mapbox GL JS (mapas)
- React Query (cache e sincronização)
- Zustand ou Context API (estado global)
- React Router (se necessário)

BACKEND:
- FastAPI (APIs REST)
- SQLAlchemy (ORM)
- Pydantic (validação)
- python-dotenv (variáveis de ambiente)
- openai (integração OpenAI)
- langchain (sistema RAG)
- psycopg2 (PostgreSQL)
- pandas (manipulação de dados)

=== VARIÁVEIS DE AMBIENTE ===

Criar arquivo .env.example:
```
DATABASE_URL=postgresql://user:password@localhost:5432/framework_v6
OPENAI_API_KEY=sk-...
OPENAI_MODEL=gpt-4o-mini
OPENAI_TEMPERATURE=0.3
OPENAI_MAX_TOKENS=500
RAG_EMBEDDING_MODEL=text-embedding-3-small
RAG_CHUNK_SIZE=1000
RAG_TOP_K=5
PORT=3000
NODE_ENV=development
```

=== ESTRUTURA DE PASTAS SUGERIDA ===

```
framework-v6-mvp/
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   │   ├── layout/
│   │   │   │   ├── Header.tsx
│   │   │   │   ├── TabNavigation.tsx
│   │   │   │   ├── ChatSidebar.tsx
│   │   │   │   └── Footer.tsx
│   │   │   ├── controls/
│   │   │   │   ├── TerritorySelector.tsx
│   │   │   │   ├── PeriodSelector.tsx
│   │   │   │   └── IndicatorSelector.tsx
│   │   │   ├── tabs/
│   │   │   │   ├── OverviewTab.tsx
│   │   │   │   ├── EconomicTab.tsx
│   │   │   │   ├── SocialTab.tsx
│   │   │   │   ├── TerritorialTab.tsx
│   │   │   │   ├── EnvironmentalTab.tsx
│   │   │   │   └── ComparisonTab.tsx
│   │   │   ├── shared/
│   │   │   │   ├── KPICard.tsx
│   │   │   │   ├── Chart.tsx
│   │   │   │   ├── AIAnalysisBox.tsx
│   │   │   │   ├── DataTable.tsx
│   │   │   │   └── ExportButtons.tsx
│   │   │   └── chat/
│   │   │       ├── ChatContainer.tsx
│   │   │       ├── MessageList.tsx
│   │   │       ├── MessageInput.tsx
│   │   │       └── SuggestionChips.tsx
│   │   ├── hooks/
│   │   ├── services/
│   │   ├── types/
│   │   ├── utils/
│   │   └── App.tsx
│   ├── public/
│   └── package.json
├── backend/
│   ├── app/
│   │   ├── api/
│   │   │   ├── endpoints/
│   │   │   │   ├── territories.py
│   │   │   │   ├── indicators.py
│   │   │   │   ├── analysis.py
│   │   │   │   └── chat.py
│   │   │   └── deps.py
│   │   ├── core/
│   │   │   ├── config.py
│   │   │   └── security.py
│   │   ├── db/
│   │   │   ├── base.py
│   │   │   ├── session.py
│   │   │   └── models/
│   │   ├── services/
│   │   │   ├── rag_service.py
│   │   │   ├── openai_service.py
│   │   │   └── export_service.py
│   │   └── main.py
│   ├── requirements.txt
│   └── .env.example
├── database/
│   ├── schema.sql
│   ├── migrations/
│   └── seeds/
├── docs/
└── README.md
```

=== PRIORIDADES DE IMPLEMENTAÇÃO ===

FASE 1 (MVP Básico - 3-5 dias):
1. Estrutura React com 6 abas (navegação funcional)
2. Painel de controle com seletores (mock de dados)
3. Layout de cada aba com KPIs e gráficos (dados estáticos)
4. Chat UI (sem IA ainda, apenas interface)
5. Estilização completa (Tailwind, paleta de cores)
6. Responsividade básica

FASE 2 (Backend e Dados - 3-4 dias):
7. Configurar PostgreSQL no Replit
8. Criar schema de banco (40 tabelas)
9. Popular dados iniciais (Tocantins + 139 municípios)
10. APIs REST (FastAPI) para CRUD
11. Integrar frontend com backend

FASE 3 (IA e Análises - 2-3 dias):
12. Integrar OpenAI API
13. Implementar sistema RAG
14. Gerar análises automáticas em cada aba
15. Chat funcional com contexto
16. Sugestões contextuais

FASE 4 (Funcionalidades Avançadas - 2-3 dias):
17. Gráficos interativos (Chart.js)
18. Mapas (Leaflet)
19. Aba de Comparação completa
20. Exportação PDF/CSV
21. Compartilhamento de links

FASE 5 (Polimento - 1-2 dias):
22. Testes de usabilidade
23. Ajustes de performance
24. Correções de bugs
25. Documentação

=== INSTRUÇÕES PARA REPLIT AGENT ===

1. COMEÇAR COM ESTRUTURA BÁSICA:
   - Criar projeto React + TypeScript
   - Configurar Tailwind CSS
   - Criar componentes de layout (Header, TabNavigation, ChatSidebar)
   - Implementar navegação entre abas (state management simples)

2. MOCK DE DADOS INICIAIS:
   - Criar arquivo JSON com dados de exemplo (3-5 municípios)
   - Incluir todos indicadores das 4 dimensões
   - Dados históricos (5 anos)

3. IMPLEMENTAR ABAS SEQUENCIALMENTE:
   - Começar por "Visão Geral" (mais simples)
   - Depois "Econômica" (modelo para outras)
   - Replicar estrutura para Social, Territorial, Ambiental
   - Por último "Comparação" (mais complexa)

4. CHAT UI PRIMEIRO, IA DEPOIS:
   - Criar interface completa do chat
   - Mock de mensagens
   - Depois integrar OpenAI

5. RESPONSIVIDADE DESDE O INÍCIO:
   - Usar classes Tailwind responsivas (sm:, md:, lg:)
   - Testar em diferentes tamanhos

6. ACESSIBILIDADE:
   - ARIA labels em elementos interativos
   - Navegação por teclado
   - Contraste de cores WCAG AA

7. PERFORMANCE:
   - Lazy loading de abas
   - Memoização de componentes pesados
   - Debounce em inputs de busca

=== OBSERVAÇÕES IMPORTANTES ===

- FOCO EM USABILIDADE: Gestores públicos não são técnicos. Interface deve ser autoexplicativa.
- CHAT IA É PROTAGONISTA: Sempre visível, sempre contextual, sempre útil.
- DADOS REAIS: Usar APIs oficiais (IBGE, INPE, ANA) quando possível. Mock apenas temporário.
- ANÁLISES AUTOMÁTICAS: IA deve gerar insights sem necessidade de perguntas.
- COMPARAÇÃO É ESSENCIAL: Gestores precisam benchmarking entre territórios.
- EXPORTAÇÃO CONTEXTUAL: PDF para relatórios, CSV para análises adicionais.
- RESPONSIVIDADE CRÍTICA: 40% dos gestores usam mobile.
- ACESSIBILIDADE NÃO É OPCIONAL: Contraste, teclado, leitores de tela.

=== COMEÇAR AGORA ===

Iniciar com:
1. Estrutura de pastas
2. Configuração Tailwind com paleta de cores
3. Componente Header com logo e título
4. Componente TabNavigation (6 abas)
5. Componente ChatSidebar (UI apenas)
6. Layout responsivo básico

Após estrutura básica, pedir feedback antes de prosseguir com implementação das abas.
```

---

## Prompt Alternativo (Mais Conciso)

Se o Replit Agent tiver limite de caracteres, use esta versão resumida:

```
Criar dashboard web de inteligência territorial para gestores públicos do Tocantins (Brasil).

STACK: React + TypeScript + Tailwind CSS (frontend) | FastAPI + PostgreSQL (backend) | OpenAI GPT-4o-mini (IA)

LAYOUT: 6 abas horizontais (Visão Geral, Econômica, Social, Territorial, Ambiental, Comparação) + Chat IA lateral fixo (300px)

FUNCIONALIDADES:
- Seletores: Tipo território (Estado/Região/Município) | Território específico (140 opções) | Período (5-20 anos) | Indicadores
- Cada aba: 4 KPIs + 2 gráficos + Análise IA automática + Tabela dados
- Chat IA: Sempre visível, contextual, sugestões de perguntas, integração OpenAI
- Aba Comparação: Selecionar até 5 territórios, gráficos comparativos, benchmarking
- Exportação: PDF (relatórios) e CSV (dados)
- Responsivo: Desktop (layout completo) | Tablet (chat em drawer) | Mobile (abas em accordion, chat fullscreen)

PALETA: Navy Blue (#1e3a8a) | Cyan (#06b6d4) | Orange (#f97316) | Green (#10b981) | White (#ffffff)

DADOS: PostgreSQL com 40 tabelas, 140 entidades territoriais, dados históricos 5-20 anos, PostGIS (geoespacial), pgvector (embeddings)

PRIORIDADE: Usabilidade para não-técnicos. Chat IA como protagonista. Análises automáticas. Comparação entre territórios.

COMEÇAR: Estrutura React + Tailwind + 6 abas + Chat UI (mock dados). Depois backend + IA.
```

---

## Notas Adicionais

### Imagens de Referência para Replit Agent

Se o Replit Agent suportar imagens, anexar:
1. Wireframe da estrutura geral (layout com 6 abas + chat)
2. Wireframe da aba "Econômica" (exemplo detalhado)
3. Wireframe da aba "Comparação" (nova funcionalidade)
4. Mockup do Chat IA lateral

### Iteração com Replit Agent

Após Replit Agent gerar estrutura inicial:

1. **Validar estrutura de pastas e componentes**
2. **Testar navegação entre abas**
3. **Validar paleta de cores e tipografia**
4. **Pedir implementação de uma aba completa (Econômica)**
5. **Validar responsividade**
6. **Pedir implementação do Chat UI**
7. **Validar antes de prosseguir para backend**

### Ajustes Esperados

Replit Agent pode precisar de orientação em:
- Estrutura exata dos seletores hierárquicos
- Lógica de contexto do chat (qual aba/território está ativo)
- Geração de análises IA (prompts específicos)
- Integração de gráficos (Chart.js ou Recharts)
- Exportação PDF (biblioteca html2pdf ou similar)

### Fallbacks

Se Replit não suportar:
- **pgvector:** Usar busca por texto (PostgreSQL full-text search)
- **PostGIS:** Usar apenas lat/long (sem geometrias complexas)
- **Mapas interativos:** Usar imagens estáticas inicialmente
- **OpenAI:** Usar análises pré-geradas (templates)

---

## Checklist de Validação

Antes de aprovar implementação do Replit Agent, verificar:

- [ ] 6 abas navegáveis
- [ ] Chat lateral fixo em todas as telas
- [ ] Seletores de território funcionais (mock)
- [ ] Paleta de cores aplicada corretamente
- [ ] Tipografia Inter carregada
- [ ] Layout responsivo (testar em 3 tamanhos)
- [ ] KPIs com formatação adequada (números grandes, variação %)
- [ ] Gráficos renderizando (mesmo com dados mock)
- [ ] Caixa de Análise IA visível em cada aba
- [ ] Tabela de dados com scroll
- [ ] Botões de exportação visíveis (mesmo sem funcionar)
- [ ] Chat com input funcional (mesmo sem IA)
- [ ] Sugestões de perguntas visíveis no chat
- [ ] Aba "Comparação" com seletor multi-território
- [ ] Acessibilidade básica (contraste, navegação teclado)

---

## Próximos Passos Após Aprovação do Wireframe

1. **Copiar prompt para Replit Agent**
2. **Anexar imagens de wireframes (se possível)**
3. **Iniciar geração com "Start designing" ou "Build the entire app"**
4. **Acompanhar progresso e dar feedback iterativo**
5. **Validar estrutura básica antes de backend**
6. **Implementar backend e dados**
7. **Integrar IA**
8. **Testar e refinar**
