# Conteúdo Detalhado - Slides Wireframes Alternativa 1

## Estrutura da Apresentação

### Slide 1: Capa
**Título:** Dashboard de Inteligência Territorial - Wireframes Detalhados Alternativa 1
**Subtítulo:** Framework V6.0 - Layout em Abas com Chat IA Persistente

---

### Slide 2: Visão Geral da Arquitetura
**Título:** Arquitetura do Dashboard - 6 Abas + Chat Lateral Fixo

**Conteúdo:**
- **5 Abas Dimensionais:** Econômica, Social, Territorial, Ambiental, Comparação
- **1 Aba de Visão Geral:** Síntese integrada das 4 dimensões
- **Chat IA Lateral Direito:** Fixo em todas as telas (300px largura)
- **Painel de Controle Superior:** Seletores de território e indicadores
- **Barra de Ações:** Exportação PDF/CSV, ajuda, configurações

**Componentes Comuns a Todas as Abas:**
1. Header com logo e título do sistema
2. Painel de controle (seletores)
3. Navegação por abas horizontal
4. Área de conteúdo principal (variável por aba)
5. Chat IA lateral direito (fixo)
6. Footer com créditos e versão

---

### Slide 3: Painel de Controle Superior (Detalhamento)
**Título:** Seletores Hierárquicos de Território e Indicadores

**Seletor de Tipo de Território (Dropdown 1):**
- Estado do Tocantins
- Região Intermediária (3 opções: Palmas, Araguaína, Gurupi)
- Região Imediata (11 opções)
- Município (139 opções)
- Mesorregião Histórica (2 opções: Ocidental, Oriental)
- Microrregião Histórica (8 opções)

**Seletor de Território Específico (Dropdown 2 - Dinâmico):**
- Muda conforme tipo selecionado
- Busca por nome (autocomplete)
- Ícone de localização geográfica

**Seletor de Período Temporal:**
- Últimos 5 anos (padrão)
- Últimos 10 anos
- Últimos 20 anos
- Período customizado (date picker)

**Seletor de Indicadores (Multi-select):**
- Varia por dimensão
- Permite selecionar múltiplos indicadores para visualização
- Indicadores padrão pré-selecionados

**Botões de Ação Rápida:**
- Resetar filtros
- Salvar configuração
- Compartilhar link

---

### Slide 4: Aba "Visão Geral" - Wireframe
**Título:** Aba Visão Geral - Síntese Integrada das 4 Dimensões

**Layout (Grid 2x2):**

**Quadrante Superior Esquerdo - Dimensão Econômica:**
- 2 KPIs principais (PIB per capita, Taxa de emprego)
- Mini gráfico de tendência (5 anos)
- Ícone de dimensão
- Badge de status (crescimento/declínio)

**Quadrante Superior Direito - Dimensão Social:**
- 2 KPIs principais (IDH-M, Taxa de alfabetização)
- Mini gráfico de tendência
- Ícone de dimensão
- Badge de status

**Quadrante Inferior Esquerdo - Dimensão Territorial:**
- 2 KPIs principais (Área urbanizada, Densidade demográfica)
- Mini gráfico de tendência
- Ícone de dimensão
- Badge de status

**Quadrante Inferior Direito - Dimensão Ambiental:**
- 2 KPIs principais (Cobertura vegetal, Qualidade da água)
- Mini gráfico de tendência
- Ícone de dimensão
- Badge de status

**Caixa de Análise IA (Abaixo do Grid):**
- Título: "Análise Integrada por IA"
- Texto gerado pela IA (150-200 palavras)
- Síntese das 4 dimensões
- Destaques e alertas
- Ícone de IA pulsante

**Chat IA Lateral (Fixo):**
- Sempre visível
- Badge: "Contexto: Visão Geral"
- Sugestões de perguntas contextuais

---

### Slide 5: Aba "Econômica" - Wireframe
**Título:** Aba Econômica - Indicadores e Análise Detalhada

**Seção 1: KPIs Principais (Topo - Grid 4 colunas):**
- PIB Total (R$ milhões)
- PIB per Capita (R$)
- Taxa de Emprego (%)
- Arrecadação Municipal (R$ milhões)
- Cada KPI com: valor atual, variação percentual, mini sparkline

**Seção 2: Gráficos (Grid 2 colunas):**

**Gráfico 1 (Esquerda):**
- Tipo: Linha
- Título: "Evolução do PIB (5 anos)"
- Eixo X: Anos
- Eixo Y: R$ milhões
- Legenda: PIB Total, PIB per Capita (escala secundária)

**Gráfico 2 (Direita):**
- Tipo: Barras
- Título: "Composição Setorial do PIB (Ano Atual)"
- Setores: Agropecuária, Indústria, Serviços, Administração Pública
- Cores diferenciadas por setor

**Seção 3: Caixa de Análise IA:**
- Título: "Análise Econômica por IA"
- Texto gerado (200-250 palavras)
- Insights sobre tendências
- Comparação com média regional
- Alertas e oportunidades

**Seção 4: Tabela de Dados (Abaixo):**
- Colunas: Ano, PIB Total, PIB per Capita, Taxa Emprego, Arrecadação
- 5-10 linhas (dados históricos)
- Ordenável por coluna
- Botão "Exportar CSV"

**Chat IA Lateral:**
- Badge: "Contexto: Dimensão Econômica"
- Sugestões: "Como está o PIB comparado à média estadual?", "Quais setores mais cresceram?"

---

### Slide 6: Aba "Social" - Wireframe
**Título:** Aba Social - Indicadores de Desenvolvimento Humano

**Seção 1: KPIs Principais (Grid 4 colunas):**
- IDH-M (Índice)
- População Total (habitantes)
- Taxa de Alfabetização (%)
- Renda per Capita (R$)

**Seção 2: Gráficos (Grid 2 colunas):**

**Gráfico 1:**
- Tipo: Radar
- Título: "Componentes do IDH-M"
- Dimensões: Longevidade, Educação, Renda
- Comparação: Município vs. Média Estadual

**Gráfico 2:**
- Tipo: Barras Horizontais
- Título: "Indicadores Educacionais"
- Métricas: Taxa alfabetização, IDEB, Matrículas

**Seção 3: Caixa de Análise IA:**
- Título: "Análise Social por IA"
- Foco em desenvolvimento humano
- Identificação de desigualdades
- Recomendações de políticas públicas

**Seção 4: Tabela de Dados:**
- Dados demográficos e sociais históricos
- Exportável

**Chat IA Lateral:**
- Badge: "Contexto: Dimensão Social"
- Sugestões contextuais sobre educação, saúde, desigualdade

---

### Slide 7: Aba "Territorial" - Wireframe
**Título:** Aba Territorial - Uso do Solo e Infraestrutura

**Seção 1: KPIs Principais (Grid 4 colunas):**
- Área Total (km²)
- Área Urbanizada (%)
- Densidade Demográfica (hab/km²)
- Cobertura de Saneamento (%)

**Seção 2: Visualizações (Grid 2 colunas):**

**Visualização 1:**
- Tipo: Mapa Interativo
- Título: "Mapa do Território"
- Camadas: Limites, Área urbana, Infraestrutura
- Zoom e pan habilitados

**Visualização 2:**
- Tipo: Gráfico de Pizza
- Título: "Uso do Solo"
- Categorias: Urbano, Rural, Preservação, Outros

**Seção 3: Caixa de Análise IA:**
- Título: "Análise Territorial por IA"
- Padrões de ocupação
- Infraestrutura crítica
- Planejamento urbano

**Seção 4: Tabela de Dados:**
- Dados geoespaciais e de infraestrutura

**Chat IA Lateral:**
- Badge: "Contexto: Dimensão Territorial"
- Sugestões sobre infraestrutura, mobilidade, planejamento

---

### Slide 8: Aba "Ambiental" - Wireframe
**Título:** Aba Ambiental - Recursos Naturais e Sustentabilidade

**Seção 1: KPIs Principais (Grid 4 colunas):**
- Cobertura Vegetal (%)
- Área Desmatada (km²/ano)
- Qualidade da Água (IQA)
- Emissões CO₂ (ton/ano)

**Seção 2: Gráficos (Grid 2 colunas):**

**Gráfico 1:**
- Tipo: Área Empilhada
- Título: "Evolução da Cobertura Vegetal"
- Categorias: Floresta nativa, Reflorestamento, Área degradada

**Gráfico 2:**
- Tipo: Linha
- Título: "Qualidade da Água (IQA)"
- Tendência temporal
- Linha de referência (padrão aceitável)

**Seção 3: Caixa de Análise IA:**
- Título: "Análise Ambiental por IA"
- Riscos ambientais
- Conformidade com legislação
- Oportunidades de conservação

**Seção 4: Tabela de Dados:**
- Dados ambientais históricos
- Fontes: INPE, ANA, IBAMA

**Chat IA Lateral:**
- Badge: "Contexto: Dimensão Ambiental"
- Sugestões sobre desmatamento, recursos hídricos, sustentabilidade

---

### Slide 9: Aba "Comparação" - Wireframe (NOVA)
**Título:** Aba Comparação - Análise Comparativa entre Territórios

**Seção 1: Seletor de Territórios para Comparação:**
- Multi-select (até 5 territórios)
- Busca com autocomplete
- Chips visuais dos territórios selecionados
- Botão "Adicionar território"
- Botão "Limpar seleção"

**Seção 2: Seletor de Dimensão e Indicadores:**
- Dropdown: Escolher dimensão (Econômica, Social, Territorial, Ambiental, Todas)
- Multi-select: Escolher indicadores específicos (até 6)
- Checkbox: "Normalizar valores" (para comparação justa)

**Seção 3: Visualização Comparativa (Grid 2 colunas):**

**Visualização 1 (Esquerda):**
- Tipo: Barras Agrupadas
- Título: "Comparação de Indicadores Selecionados"
- Eixo X: Indicadores
- Eixo Y: Valores
- Legenda: Cores por território

**Visualização 2 (Direita):**
- Tipo: Radar/Spider Chart
- Título: "Perfil Multidimensional"
- Eixos: Indicadores selecionados
- Linhas: Um por território
- Facilita identificação de padrões

**Seção 4: Tabela Comparativa:**
- Linhas: Territórios selecionados
- Colunas: Indicadores selecionados
- Células: Valores + setas de tendência
- Destaque: Melhor/pior desempenho por indicador
- Botão "Exportar CSV"

**Seção 5: Caixa de Análise IA:**
- Título: "Análise Comparativa por IA"
- Síntese das diferenças e semelhanças
- Identificação de outliers
- Benchmarking
- Recomendações baseadas em melhores práticas

**Chat IA Lateral:**
- Badge: "Contexto: Comparação entre Territórios"
- Sugestões: "Por que Palmas tem PIB maior?", "Quais fatores explicam diferenças no IDH?"

---

### Slide 10: Chat IA Lateral - Detalhamento Funcional
**Título:** Chat IA Persistente - Funcionalidades e Interação

**Estrutura do Chat (300px largura fixa):**

**Header do Chat:**
- Ícone de IA (animado)
- Título: "Assistente de Inteligência Territorial"
- Badge de contexto atual (ex: "Dimensão Econômica")
- Botão minimizar/expandir
- Botão limpar histórico

**Área de Mensagens:**
- Scroll vertical
- Mensagens do usuário (direita, fundo cyan claro)
- Mensagens da IA (esquerda, fundo branco)
- Timestamp em cada mensagem
- Ícones de ações: Copiar, Exportar, Compartilhar

**Sugestões Contextuais (Chips):**
- 3-4 perguntas sugeridas baseadas no contexto atual
- Clicáveis (enviam pergunta automaticamente)
- Atualizam conforme aba/território muda

**Input de Mensagem:**
- Campo de texto multilinhas
- Placeholder contextual (ex: "Pergunte sobre indicadores econômicos...")
- Botão enviar (ícone de avião de papel)
- Botão anexar (para futuras funcionalidades)
- Contador de caracteres

**Funcionalidades Especiais:**
- Typing indicator quando IA está processando
- Suporte a markdown nas respostas (negrito, listas, links)
- Gráficos inline (quando relevante)
- Links para abas/seções específicas
- Exportação de conversa em PDF

**Estados Visuais:**
- Estado normal (300px)
- Estado minimizado (60px - apenas ícone flutuante)
- Estado expandido (500px - para conversas longas)
- Estado de erro (mensagem de erro amigável)

---

### Slide 11: Fluxos de Interação Principais
**Título:** Jornadas do Usuário no Dashboard

**Fluxo 1: Análise Rápida de Município**
1. Selecionar "Município" no dropdown de tipo
2. Buscar e selecionar município (ex: "Palmas")
3. Visualizar aba "Visão Geral" (síntese 4 dimensões)
4. Ler análise IA gerada automaticamente
5. Clicar em aba específica para aprofundar (ex: "Econômica")
6. Fazer pergunta no chat: "Como está o PIB comparado ao ano passado?"
7. IA responde com análise contextual
8. Exportar relatório PDF da dimensão

**Fluxo 2: Comparação entre Municípios**
1. Clicar na aba "Comparação"
2. Adicionar territórios (ex: Palmas, Araguaína, Gurupi)
3. Selecionar dimensão "Econômica"
4. Escolher indicadores (PIB, Emprego, Arrecadação)
5. Visualizar gráficos comparativos
6. Analisar tabela de dados
7. Ler análise IA sobre diferenças
8. Perguntar no chat: "Por que Palmas tem PIB maior?"
9. IA explica fatores (capital, concentração serviços, etc.)
10. Exportar CSV com dados comparativos

**Fluxo 3: Análise Temporal de Região**
1. Selecionar "Região Intermediária" → "Palmas"
2. Ajustar período para "Últimos 10 anos"
3. Navegar por abas dimensionais
4. Observar tendências em gráficos de linha
5. Identificar padrões com ajuda da análise IA
6. Fazer perguntas iterativas no chat para aprofundar
7. Salvar configuração para monitoramento futuro

**Fluxo 4: Exploração Guiada por IA**
1. Abrir dashboard (aba "Visão Geral" por padrão)
2. Chat sugere: "Quer ver quais municípios mais cresceram economicamente?"
3. Usuário clica na sugestão
4. IA navega automaticamente para aba "Comparação"
5. IA pré-seleciona top 5 municípios e indicadores relevantes
6. Usuário visualiza e faz perguntas de follow-up
7. IA sugere próximas análises

---

### Slide 12: Funcionalidades de Exportação
**Título:** Exportação Contextual de Relatórios e Dados

**Exportação PDF:**
- **Escopo:** Aba atual ou dashboard completo
- **Conteúdo incluído:**
  - Cabeçalho com logo e data
  - Território e período selecionados
  - KPIs com valores e variações
  - Gráficos em alta resolução
  - Análise IA formatada
  - Tabela de dados
  - Rodapé com fontes e créditos
- **Opções:**
  - Incluir/excluir histórico de chat
  - Formato: A4 ou Carta
  - Orientação: Retrato ou Paisagem

**Exportação CSV:**
- **Escopo:** Tabela de dados da aba atual
- **Conteúdo:**
  - Cabeçalhos descritivos
  - Dados históricos completos
  - Metadados (território, período, fonte)
- **Opções:**
  - Delimitador: vírgula ou ponto-e-vírgula
  - Encoding: UTF-8
  - Incluir metadados em linhas de comentário

**Compartilhamento:**
- Link direto para configuração atual
- QR Code para acesso mobile
- Embed code para incorporar em sites

---

### Slide 13: Responsividade e Adaptações Mobile
**Título:** Adaptação para Diferentes Dispositivos

**Desktop (1280px+):**
- Layout completo conforme wireframes
- Chat lateral fixo (300px)
- Todas funcionalidades visíveis

**Tablet (768px-1279px):**
- Chat colapsa em drawer lateral (desliza da direita)
- Botão flutuante para abrir chat
- Gráficos redimensionam proporcionalmente
- Tabelas com scroll horizontal

**Mobile (<768px):**
- Navegação por abas vira accordion vertical
- Chat abre em modal fullscreen
- KPIs em grid 2x2 (ao invés de 1x4)
- Gráficos empilhados verticalmente
- Seletores de território em modals
- Tabelas com scroll horizontal + modo cards

**Touch Optimization:**
- Botões mínimo 44x44px
- Espaçamento adequado entre elementos clicáveis
- Gestos: Swipe para trocar abas, Pull-to-refresh

---

### Slide 14: Paleta de Cores e Identidade Visual
**Título:** Sistema de Design - Cores e Tipografia

**Paleta de Cores (Framework V6.0):**
- **Primary (Navy Blue):** #1e3a8a - Fundos principais
- **Secondary (Cyan):** #06b6d4 - Títulos, destaques, links
- **Accent 1 (Orange):** #f97316 - Ações primárias, alertas
- **Accent 2 (Green):** #10b981 - Sucesso, crescimento positivo
- **Accent 3 (Yellow):** #fbbf24 - Avisos, atenção
- **Neutral (White):** #ffffff - Texto principal, cards
- **Neutral (Gray):** #6b7280 - Texto secundário, bordas

**Aplicação de Cores:**
- Fundos: Navy blue
- Títulos principais: Cyan
- Botões primários: Orange
- Badges positivos: Green
- Badges neutros: Gray
- Badges negativos: Yellow/Orange

**Tipografia:**
- **Fonte:** Inter (Google Fonts)
- **Títulos:** 32-36px, Bold (700)
- **Subtítulos:** 20-24px, Semibold (600)
- **Corpo:** 16-18px, Regular (400)
- **Captions:** 14px, Regular (400)

**Ícones:**
- Font Awesome 6
- Tamanho base: 20px
- Cores: Seguem paleta (contextuais)

---

### Slide 15: Próximos Passos - Implementação
**Título:** Roadmap de Implementação no Replit

**Fase 1: Protótipo HTML/CSS (1-2 dias):**
- Criar estrutura HTML das 6 abas
- Aplicar estilos CSS (Tailwind)
- Implementar navegação entre abas
- Mock de dados estáticos
- Chat UI (sem IA ainda)

**Fase 2: Integração React (2-3 dias):**
- Componentizar estrutura
- Estado global (Context API ou Zustand)
- Roteamento (se necessário)
- Responsividade completa

**Fase 3: Backend e Banco de Dados (3-4 dias):**
- Configurar PostgreSQL no Replit
- Criar schema (40 tabelas)
- APIs REST (FastAPI ou Flask)
- Popular dados iniciais (Tocantins + 139 municípios)

**Fase 4: Integração IA (2-3 dias):**
- Conectar OpenAI API
- Implementar sistema RAG
- Gerar análises automáticas
- Chat funcional com contexto

**Fase 5: Funcionalidades Avançadas (2-3 dias):**
- Exportação PDF/CSV
- Gráficos interativos (Chart.js)
- Mapas (Leaflet ou Mapbox)
- Comparação entre territórios

**Fase 6: Testes e Refinamento (1-2 dias):**
- Testes de usabilidade
- Ajustes de performance
- Correções de bugs
- Documentação

**Total Estimado: 11-17 dias de desenvolvimento**

---

## Notas para Geração dos Slides

**Estética:**
- Manter "Data-Driven Cartography" com linhas topográficas sutis
- Paleta de cores do Framework V6.0 (navy, cyan, orange, green)
- Hexágonos decorativos sutis
- Tipografia Inter
- Bordas retas (sem rounded corners)

**Wireframes:**
- Usar retângulos e placeholders para representar componentes
- Anotar dimensões importantes (ex: "300px" para chat)
- Usar cores da paleta para diferenciar seções
- Incluir ícones Font Awesome para clareza
- Adicionar labels descritivos

**Conteúdo:**
- Cada slide deve ser autoexplicativo
- Balancear texto e elementos visuais
- Usar listas e grids para organização
- Destacar funcionalidades-chave em bold
- Incluir exemplos concretos (nomes de municípios, valores)
