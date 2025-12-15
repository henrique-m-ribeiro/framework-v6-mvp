# Wireframes do Dashboard - Framework V6.0

**Data:** 10 de Novembro de 2025  
**Versão:** 1.0 - Focada em Gestores Públicos  
**Objetivo:** Interface intuitiva para gestores sem familiaridade técnica

---

## 📋 VISÃO GERAL

Este diretório contém os wireframes do Dashboard de Inteligência Territorial, redesenhados com foco em **gestores públicos** que não têm familiaridade com tecnologias complexas.

### Princípios de Design

✅ **Simplicidade** - Interface limpa, sem jargão técnico  
✅ **Intuitividade** - Fluxo natural de interação  
✅ **Foco em IA** - Chat com assistente como elemento central  
✅ **Insights, não dados** - Apresentar análises, não números brutos  
✅ **Acessibilidade** - Alto contraste, fontes legíveis, navegação clara

---

## 🎨 ARQUIVOS INCLUÍDOS

### 1. `wireframe_dashboard_visual.png`
**Tipo:** Wireframe visual (mockup)  
**Descrição:** Layout completo do dashboard

**Elementos principais:**
- **Header:** Logo, seletor de território
- **Sidebar Esquerda:** Cards das 4 dimensões (Econômica, Social, Territorial, Ambiental)
- **Centro:** Chat com IA (destaque principal)
- **Sidebar Direita:** Histórico de análises recentes
- **Rodapé:** Ações rápidas

**Uso:** Visualizar como ficará o dashboard final

---

### 2. `wireframe_chat_interaction.png`
**Tipo:** Wireframe de interação detalhada  
**Descrição:** Foco na interação com o chat de IA

**Elementos principais:**
- **Pergunta do usuário:** "Compare economic growth of Palmas and Porto Nacional in last 5 years"
- **Resposta da IA:** Texto explicativo + gráfico comparativo + tabela de dados
- **Input de mensagem:** Campo de texto, botões de áudio e envio

**Uso:** Entender como o gestor interage com a IA

---

### 3. `wireframe_dashboard.html`
**Tipo:** Wireframe interativo em código HTML/CSS  
**Descrição:** Protótipo funcional clicável

**Funcionalidades:**
- Layout responsivo (desktop e mobile)
- Interação com cards de dimensões
- Campo de chat (não funcional, apenas visual)
- Histórico de análises
- Ações rápidas

**Uso:** 
- Abrir no navegador para testar interação
- Usar como base para implementação no Replit
- Copiar código para o Replit Agent

**Como visualizar:**
```bash
# Opção 1: Abrir diretamente no navegador
open wireframe_dashboard.html

# Opção 2: Servir com Python
python3 -m http.server 8000
# Depois acessar: http://localhost:8000/wireframe_dashboard.html
```

---

## 🎯 DIFERENÇAS EM RELAÇÃO AO WIREFRAME ANTERIOR

O wireframe anterior (`WIREFRAME_DASHBOARD_INTEGRADO_V2_REFINADO.md.doc`) era muito técnico:
- ❌ Focado em desenvolvedores (queries SQL, schemas JSON, componentes React)
- ❌ Muitos detalhes de implementação
- ❌ Difícil de visualizar para não-técnicos

**Novos wireframes:**
- ✅ Focados em **gestores públicos**
- ✅ Ênfase na **experiência do usuário**
- ✅ **Chat com IA** como elemento central
- ✅ Interface **limpa e intuitiva**
- ✅ **Visualizações claras** (gráficos, cards, badges)

---

## 🚀 COMO USAR NO REPLIT AGENT

### Opção 1: Usar Wireframe Visual como Referência

1. Abra `wireframe_dashboard_visual.png`
2. No Replit Agent, descreva o que você vê:

```
Criar dashboard baseado neste wireframe:

LAYOUT:
- Header azul com logo "Framework V6.0" e seletor de município
- 3 colunas: sidebar esquerda (dimensões), centro (chat IA), sidebar direita (histórico)

SIDEBAR ESQUERDA (300px):
- 4 cards de dimensões (Econômica, Social, Territorial, Ambiental)
- Cada card mostra: ícone, título, métrica principal, valor, variação

CENTRO (flex):
- Chat com IA em destaque
- Header do chat: "Assistente de Inteligência" + badge "IA Ativa"
- Área de mensagens com scroll
- Input de mensagem com botões de anexo, áudio e envio
- Ações rápidas abaixo (comparar, tendências, relatório)

SIDEBAR DIREITA (280px):
- Lista de análises recentes
- Cada item: título, data/hora, badge de dimensão

CORES:
- Azul primário: #3b82f6
- Azul escuro: #1e3a8a
- Cinza claro: #f8fafc
- Branco: #ffffff
```

---

### Opção 2: Usar Código HTML Diretamente

1. Copie o conteúdo de `wireframe_dashboard.html`
2. No Replit Agent, cole e diga:

```
Implementar este dashboard usando React + Tailwind CSS.
Manter a mesma estrutura e design.
Adicionar funcionalidade real ao chat (integração com OpenAI API).
Conectar aos endpoints da API backend para buscar dados reais.
```

---

### Opção 3: Abordagem Híbrida (Recomendada)

1. Mostre a imagem visual para o Agent
2. Peça para criar estrutura básica
3. Depois refine com detalhes do código HTML

```
Criar dashboard de inteligência territorial baseado neste wireframe [anexar wireframe_dashboard_visual.png].

REQUISITOS:
- Layout de 3 colunas (dimensões, chat IA, histórico)
- Chat com IA como elemento central
- Interface limpa e intuitiva para gestores públicos
- Cores: azul (#3b82f6) e branco
- Responsivo (desktop e mobile)

FUNCIONALIDADES:
- Chat com IA (integração OpenAI)
- Seletor de território (dropdown)
- Cards de dimensões clicáveis
- Histórico de análises
- Ações rápidas

Começar com estrutura básica e depois adicionar funcionalidades incrementalmente.
```

---

## 📱 RESPONSIVIDADE

O wireframe HTML inclui responsividade para mobile:

**Desktop (>1024px):**
- 3 colunas: dimensões | chat | histórico

**Tablet (768px - 1024px):**
- 2 colunas: chat | histórico
- Dimensões em dropdown ou colapsável

**Mobile (<768px):**
- 1 coluna vertical
- Tabs para alternar entre dimensões, chat e histórico

---

## 🎨 PALETA DE CORES

```css
/* Azuis (Principal) */
--primary-blue: #3b82f6;
--dark-blue: #1e3a8a;
--light-blue: #eff6ff;

/* Cinzas (Neutros) */
--gray-50: #f8fafc;
--gray-100: #f1f5f9;
--gray-200: #e2e8f0;
--gray-600: #64748b;
--gray-900: #1e293b;

/* Feedback */
--success-green: #16a34a;
--error-red: #dc2626;
--warning-yellow: #eab308;
```

---

## 📊 COMPONENTES PRINCIPAIS

### 1. Dimension Card
- **Função:** Mostrar resumo de uma dimensão
- **Elementos:** Ícone, título, métrica, valor, variação
- **Estado:** Normal, hover, active
- **Interação:** Clique filtra chat para dimensão

### 2. AI Chat
- **Função:** Interação principal com IA
- **Elementos:** Mensagens (user/ai), input, ações rápidas
- **Funcionalidade:** Enviar pergunta, receber análise + gráficos

### 3. History Item
- **Função:** Acessar análises anteriores
- **Elementos:** Título, timestamp, badge de dimensão
- **Interação:** Clique carrega análise no chat

### 4. Territory Selector
- **Função:** Selecionar território para análise
- **Opções:** Estado do Tocantins, 139 municípios, todos
- **Interação:** Mudança atualiza dados do dashboard

---

## 🔄 FLUXO DE INTERAÇÃO

### Fluxo Principal (Happy Path)

1. **Gestor acessa dashboard**
   - Dashboard carrega com Palmas selecionado (padrão)
   - Cards de dimensões mostram dados atuais
   - Chat vazio, pronto para pergunta

2. **Gestor seleciona território** (opcional)
   - Dropdown de municípios
   - Dashboard atualiza dados

3. **Gestor faz pergunta no chat**
   - Exemplo: "Como está a economia de Palmas?"
   - Mensagem aparece no chat
   - IA processa (loading indicator)

4. **IA responde com análise**
   - Texto explicativo
   - Gráficos relevantes
   - Dados de suporte
   - Comparações (se aplicável)

5. **Gestor aprofunda** (opcional)
   - Nova pergunta baseada na resposta
   - Usa ações rápidas ("Comparar com outro município")
   - Clica em card de dimensão para filtrar

6. **Gestor acessa histórico** (opcional)
   - Clica em análise anterior
   - Chat carrega conversa passada

---

## 🛠️ PRÓXIMOS PASSOS

### Para Implementação no Replit

1. **Fase 1: Estrutura HTML/CSS**
   - Usar `wireframe_dashboard.html` como base
   - Converter para React components
   - Aplicar Tailwind CSS

2. **Fase 2: Integração com Backend**
   - Conectar chat à API OpenAI
   - Buscar dados das dimensões (PostgreSQL)
   - Implementar histórico (salvar no banco)

3. **Fase 3: Funcionalidades Avançadas**
   - Gráficos interativos (Chart.js ou Recharts)
   - Exportar análises (PDF, Excel)
   - Notificações (alertas de mudanças)

4. **Fase 4: Testes com Usuários**
   - Testar com gestores públicos reais
   - Coletar feedback
   - Iterar design

---

## 📝 NOTAS TÉCNICAS

### Tecnologias Sugeridas

**Frontend:**
- React 18+ (componentes)
- Tailwind CSS (estilização)
- Recharts ou Chart.js (gráficos)
- Axios (requisições API)

**Backend:**
- Python FastAPI (APIs REST)
- PostgreSQL (banco de dados)
- OpenAI API (chat com IA)
- SQLAlchemy (ORM)

**Integração:**
- n8n Cloud (orquestração de agentes)
- Webhooks (comunicação n8n ↔ Replit)

---

## 🎓 APRENDIZADOS DO DESIGN

### O Que Funcionou Bem

✅ **Chat Central:** Colocar IA no centro torna interação intuitiva  
✅ **Cards de Dimensões:** Visão rápida sem sobrecarga de informação  
✅ **Histórico Visível:** Facilita retomar análises anteriores  
✅ **Ações Rápidas:** Sugestões reduzem curva de aprendizado

### O Que Evitamos

❌ **Dashboards tradicionais:** Muitos gráficos, pouca orientação  
❌ **Jargão técnico:** SQL, APIs, schemas expostos ao usuário  
❌ **Navegação complexa:** Menus profundos, muitos cliques  
❌ **Sobrecarga visual:** Muitas cores, animações desnecessárias

---

## 📞 FEEDBACK E ITERAÇÃO

Este é um **wireframe inicial** (v1.0). Esperamos iterar baseado em:

1. **Feedback do usuário** (você, Henrique)
2. **Testes com gestores públicos**
3. **Limitações técnicas** descobertas na implementação
4. **Novas funcionalidades** identificadas durante uso

**Como dar feedback:**
- Anote o que gostou/não gostou
- Sugira mudanças específicas
- Teste o HTML e reporte problemas
- Compartilhe com colegas gestores para opiniões

---

**Wireframes criados por:** Manus AI  
**Data:** 10 de Novembro de 2025  
**Versão:** 1.0  
**Projeto:** Framework V6.0 - Sistema de Inteligência Territorial
