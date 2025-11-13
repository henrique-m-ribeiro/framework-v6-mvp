# Guia Rápido: Implementar Dashboard no Replit Agent

## 🚀 Início Rápido (5 minutos)

### Passo 1: Abrir Replit
1. Acesse https://replit.com
2. Faça login na sua conta
3. Clique em **"Create App"** (ou "+ Create App")

### Passo 2: Escolher Tipo de App
- Selecione **"Web app"** (NÃO "Agents & Automations" ou "Data app")
- Motivo: Precisa de full-stack (React + Python + PostgreSQL)

### Passo 3: Colar o Prompt
1. Na caixa de texto que aparece ("Describe your app idea...")
2. Copie e cole o **PROMPT PRINCIPAL** do arquivo `PROMPT_REPLIT_AGENT.md`
3. Clique em **"Start chat"** (botão azul)

### Passo 4: Escolher Abordagem
O Replit Agent perguntará: "How do you want to continue?"

**Escolha: "Start with a design" (5-10 min)**
- ✅ Você verá o protótipo visual primeiro
- ✅ Poderá ajustar antes de implementar
- ✅ Mais alinhado com abordagem no-code/visual

---

## 📋 Prompt Principal (Copiar Daqui)

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
- Dados de 140 entidades territoriais (1 estado + 139 municípios + regiões)
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
- Seletor 1: Tipo de Território (Estado | Região Intermediária | Região Imediata | Município | Mesorregião | Microrregião)
- Seletor 2: Território Específico (dropdown dinâmico com busca, 140 opções)
- Seletor 3: Período Temporal (Últimos 5/10/20 anos | Customizado)
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
- Header: Ícone IA (animado) + Título + Badge de contexto + Botões (min/exp)
- Área de Mensagens: Scroll vertical, msgs usuário (direita), msgs IA (esquerda), timestamps
- Sugestões: 3-4 chips clicáveis com perguntas contextuais
- Input: Campo de texto multilinhas + Botão Enviar

FUNCIONALIDADES:
- Contexto automático (sabe qual aba, território, dimensão está ativa)
- Sugestões de perguntas contextuais
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

=== RESPONSIVIDADE ===

DESKTOP (1280px+): Layout completo, chat lateral fixo (300px)
TABLET (768px-1279px): Chat colapsa em drawer, botão flutuante
MOBILE (<768px): Abas em accordion, chat fullscreen, KPIs 2x2, botões touch-friendly (min 44x44px)

=== PALETA DE CORES ===

PRIMARY: #1e3a8a (Navy Blue) - Fundos principais
SECONDARY: #06b6d4 (Cyan) - Títulos, destaques, links
ACCENT_1: #f97316 (Orange) - Ações primárias, alertas
ACCENT_2: #10b981 (Green) - Sucesso, crescimento
ACCENT_3: #fbbf24 (Yellow) - Avisos
NEUTRAL_LIGHT: #ffffff (White) - Texto principal
NEUTRAL_DARK: #6b7280 (Gray) - Texto secundário

=== TIPOGRAFIA ===

FONTE: Inter (Google Fonts)
- Títulos H1: 36px, Bold (700)
- Títulos H2: 24px, Semibold (600)
- Títulos H3: 20px, Semibold (600)
- Corpo: 16px, Regular (400)
- KPIs (números grandes): 32px, Bold (700)

=== PRIORIDADES DE IMPLEMENTAÇÃO ===

FASE 1 (MVP Básico - 3-5 dias):
1. Estrutura React com 6 abas (navegação funcional)
2. Painel de controle com seletores (mock de dados)
3. Layout de cada aba com KPIs e gráficos (dados estáticos)
4. Chat UI (sem IA ainda, apenas interface)
5. Estilização completa (Tailwind, paleta de cores)
6. Responsividade básica

=== INSTRUÇÕES PARA REPLIT AGENT ===

1. COMEÇAR COM ESTRUTURA BÁSICA:
   - Criar projeto React + TypeScript
   - Configurar Tailwind CSS
   - Criar componentes de layout (Header, TabNavigation, ChatSidebar)
   - Implementar navegação entre abas

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

=== OBSERVAÇÕES IMPORTANTES ===

- FOCO EM USABILIDADE: Gestores públicos não são técnicos. Interface deve ser autoexplicativa.
- CHAT IA É PROTAGONISTA: Sempre visível, sempre contextual, sempre útil.
- DADOS REAIS: Usar APIs oficiais (IBGE, INPE, ANA) quando possível. Mock apenas temporário.
- ANÁLISES AUTOMÁTICAS: IA deve gerar insights sem necessidade de perguntas.
- COMPARAÇÃO É ESSENCIAL: Gestores precisam benchmarking entre territórios.
- EXPORTAÇÃO CONTEXTUAL: PDF para relatórios, CSV para análises adicionais.
- RESPONSIVIDADE CRÍTICA: 40% dos gestores usam mobile.

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

## 🎯 O Que Esperar

### Após Colar o Prompt:

**Replit Agent vai:**
1. Analisar o prompt (30-60 segundos)
2. Criar feature list (lista de funcionalidades)
3. Perguntar: "How do you want to continue?"
   - **Escolha:** "Start with a design" ⭐

**Fase de Design (5-10 minutos):**
- Agent cria protótipo visual
- Você vê interface clicável
- Pode ajustar cores, layout, componentes
- Quando aprovar, clica "Build functionality"

**Fase de Implementação (20-40 minutos):**
- Agent gera código React + TypeScript
- Configura Tailwind CSS
- Cria componentes
- Implementa navegação
- Adiciona mock de dados

---

## ✅ Checklist de Validação do Design

Antes de aprovar "Build functionality", verificar:

### Layout Geral:
- [ ] 6 abas horizontais visíveis
- [ ] Chat lateral direito fixo (300px)
- [ ] Header com logo e título
- [ ] Painel de controle no topo

### Painel de Controle:
- [ ] 4 seletores (Tipo, Território, Período, Indicadores)
- [ ] Botões de ação (Resetar, Salvar, Compartilhar)

### Abas:
- [ ] Cada aba tem 4 KPIs no topo
- [ ] Área para 2 gráficos
- [ ] Caixa de Análise IA visível
- [ ] Tabela de dados no final

### Chat IA:
- [ ] Fixo na lateral direita
- [ ] Header com ícone e título
- [ ] Área de mensagens
- [ ] 3-4 chips de sugestões
- [ ] Input de mensagem

### Cores:
- [ ] Fundo navy blue (#1e3a8a)
- [ ] Títulos cyan (#06b6d4)
- [ ] Botões laranja (#f97316)
- [ ] Elementos verdes (#10b981)

### Responsividade:
- [ ] Testar em 3 tamanhos (desktop, tablet, mobile)
- [ ] Chat se adapta (drawer em tablet, fullscreen em mobile)

---

## 🔧 Ajustes Comuns

Se o design não estiver perfeito, você pode pedir ajustes:

### Exemplo de Ajustes:

**Chat não está fixo:**
```
"O chat precisa ser fixo na lateral direita em todas as telas, sempre visível. Largura 300px no desktop."
```

**Cores erradas:**
```
"Usar paleta de cores específica: Fundo #1e3a8a (navy), Títulos #06b6d4 (cyan), Botões #f97316 (orange)."
```

**Falta aba de Comparação:**
```
"Adicionar 6ª aba chamada 'Comparação' com seletor multi-território e gráficos comparativos."
```

**KPIs muito pequenos:**
```
"KPIs devem ser maiores e mais destacados. Números em 32px bold, com variação percentual abaixo."
```

---

## 📝 Próximos Passos Após Aprovação

### 1. Validar Estrutura Básica
- Testar navegação entre abas
- Verificar responsividade
- Confirmar paleta de cores

### 2. Adicionar Mock de Dados
- Pedir ao Agent para adicionar dados de exemplo
- 3-5 municípios do Tocantins
- Indicadores das 4 dimensões
- Dados históricos (5 anos)

### 3. Refinar Componentes
- Ajustar tamanhos e espaçamentos
- Melhorar UX dos seletores
- Adicionar ícones (Font Awesome)

### 4. Preparar para Backend
- Revisar estrutura de pastas
- Planejar APIs REST
- Preparar schema do banco de dados

---

## 🆘 Troubleshooting

### Problema: Agent não entende o prompt
**Solução:** Use o **Prompt Alternativo (Mais Conciso)** do arquivo `PROMPT_REPLIT_AGENT.md`

### Problema: Design muito diferente do esperado
**Solução:** Anexe imagens dos wireframes (se Replit suportar) ou descreva ajustes específicos

### Problema: Agent para no meio
**Solução:** Clique em "Continue" ou pergunte "Can you continue?"

### Problema: Muitos erros no código gerado
**Solução:** Peça para "Fix all errors" ou "Restart from scratch with simpler structure"

---

## 💡 Dicas Importantes

1. **Seja Paciente:** Agent pode levar 5-10 minutos no design e 20-40 minutos na implementação

2. **Itere Gradualmente:** Aprove estrutura básica antes de pedir funcionalidades avançadas

3. **Documente Ajustes:** Anote o que funciona e o que precisa melhorar para próxima iteração

4. **Teste Frequentemente:** Clique em "Run" para ver preview sempre que Agent fizer mudanças

5. **Salve Progresso:** Replit salva automaticamente, mas faça commits no GitHub periodicamente

---

## 📚 Recursos Adicionais

- **Documentação Completa:** `PROMPT_REPLIT_AGENT.md`
- **Wireframes Visuais:** Pasta `/docs/design/`
- **Análise de Melhores Práticas:** `pesquisa_melhores_praticas_dashboard_ia.md`
- **Diário de Sessões:** `/docs/diarios/`

---

## ✨ Resultado Esperado

Ao final da Fase 1 (MVP Básico), você terá:

✅ Dashboard React funcional com 6 abas navegáveis  
✅ Chat IA lateral (UI completa, sem IA ainda)  
✅ Painel de controle com seletores (mock)  
✅ Layout de cada aba com KPIs, gráficos e tabelas (dados estáticos)  
✅ Estilização completa (Tailwind, paleta Framework V6.0)  
✅ Responsividade básica (desktop, tablet, mobile)  

**Tempo estimado:** 3-5 dias de trabalho do Replit Agent (ou 30-60 minutos de geração automática)

---

Boa sorte! 🚀
