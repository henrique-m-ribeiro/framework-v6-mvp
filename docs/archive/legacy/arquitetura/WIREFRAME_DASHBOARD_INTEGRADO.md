# Wireframe de Alto Nível: Dashboard Integrado - Framework V6.0

**Framework de Interação Galáctica V6.0**  
**Versão:** 1.0  
**Data:** 08 de Novembro de 2025  
**Autores:** Henrique Ribeiro & Manus IA

---

## Sumário Executivo

Este documento apresenta o wireframe de alto nível do **Dashboard Integrado** do Framework V6.0, uma interface web responsiva que visualiza simultaneamente as **4 dimensões fundamentais** (Econômica, Social, Territorial, Ambiental) com seus principais **KPIs (Key Performance Indicators)** para gestores públicos do estado de Tocantins e seus 139 municípios.

O dashboard foi projetado com foco em **usabilidade**, **hierarquia visual clara** e **densidade informacional equilibrada**, permitindo que gestores públicos compreendam rapidamente a situação multidimensional de seus territórios, identifiquem correlações entre dimensões e tomem decisões baseadas em evidências. A interface utiliza **design responsivo** (desktop, tablet, mobile), **visualizações interativas** (gráficos, mapas, tabelas) e **navegação intuitiva** (filtros, drill-down, comparações).

**Principais Características:**

O dashboard organiza informações em **3 níveis hierárquicos**: (1) **Visão Geral** com resumo executivo das 4 dimensões em cards compactos, (2) **Visão Dimensional** com análise detalhada de cada dimensão em página dedicada, e (3) **Visão Analítica** com comparações, correlações e análises integradas. Esta estrutura permite navegação progressiva do geral para o específico, atendendo tanto gestores que precisam de overview rápido quanto analistas que necessitam de dados detalhados.

Os **20 KPIs principais** foram selecionados criteriosamente das 4 análises dimensionais (5 KPIs por dimensão), priorizando indicadores que são: (a) **acionáveis** (gestores podem influenciar através de políticas públicas), (b) **comparáveis** (permitem benchmarking entre municípios), (c) **atualizados** (dados disponíveis com frequência mensal/trimestral/anual), e (d) **compreensíveis** (não requerem expertise técnica para interpretação).

A implementação técnica proposta utiliza stack moderno e escalável: **React** (frontend), **D3.js + Chart.js** (visualizações), **PostgreSQL** (backend de dados), **FastAPI** (API REST), **Tailwind CSS** (estilização), e **Mapbox GL JS** (mapas interativos). O dashboard consome dados das 39 tabelas PostgreSQL do Framework V6.0 através de API REST, com cache Redis para otimização de performance e suporte a 1.000+ usuários simultâneos.

---

## 1. Visão Geral da Arquitetura

### 1.1. Princípios de Design

O Dashboard Integrado foi projetado seguindo **5 princípios fundamentais** de design de interfaces para gestão pública:

**Princípio 1: Clareza sobre Complexidade**

Gestores públicos frequentemente não possuem formação técnica em estatística ou ciência de dados. O dashboard prioriza clareza na apresentação de informações complexas, utilizando linguagem acessível, visualizações intuitivas (gráficos de barras, linhas, mapas coropléticos) e evitando jargão técnico. Cada KPI é acompanhado de explicação contextual breve (tooltip) que esclarece significado, fórmula de cálculo e interpretação.

**Princípio 2: Densidade Informacional Equilibrada**

O dashboard evita tanto sobrecarga informacional (muitos dados simultaneamente, causando paralisia de decisão) quanto escassez informacional (poucos dados, insuficientes para decisão fundamentada). A **Visão Geral** apresenta 20 KPIs em formato compacto (cards), permitindo scan rápido em 30-60 segundos. A **Visão Dimensional** expande para 40-50 indicadores por dimensão, acessíveis via scroll ou tabs. A **Visão Analítica** oferece análises profundas sob demanda.

**Princípio 3: Comparabilidade como Padrão**

Números absolutos isolados têm valor limitado. O dashboard sempre apresenta KPIs com **contexto comparativo**: (a) evolução temporal (série histórica de 5-10 anos), (b) comparação com médias (estadual, regional, nacional), (c) ranking entre municípios (posição relativa), e (d) metas estabelecidas (quando aplicável, ex: limites LRF, metas ODS). Esta abordagem facilita interpretação e identificação de outliers.

**Princípio 4: Interatividade para Exploração**

Dashboards estáticos limitam análise a perguntas pré-definidas. O dashboard integrado oferece **interatividade rica**: filtros dinâmicos (município, período, dimensão), drill-down (clicar em KPI para ver detalhes), comparações customizadas (selecionar 2-5 municípios para comparar), e exportação de dados (CSV, Excel, PDF). Gestores podem formular e responder suas próprias perguntas analíticas sem depender de equipe técnica.

**Princípio 5: Responsividade Multi-Dispositivo**

Gestores públicos acessam informações em contextos diversos: desktop no escritório, tablet em reuniões, smartphone em campo. O dashboard utiliza **design responsivo** que adapta layout, tamanho de fontes e densidade de informações ao dispositivo. Funcionalidades críticas (visualização de KPIs, filtros, comparações) estão disponíveis em todos os dispositivos, enquanto funcionalidades avançadas (análises complexas, exportações) são otimizadas para desktop.

### 1.2. Arquitetura de 3 Níveis

O dashboard organiza informações em **3 níveis hierárquicos** acessíveis via navegação progressiva:

**Nível 1: Visão Geral (Overview Dashboard)**

Página inicial que apresenta resumo executivo das 4 dimensões em formato de cards compactos. Cada dimensão possui 1 card principal com 5 KPIs prioritários, totalizando 4 cards (Econômica, Social, Territorial, Ambiental). Adicionalmente, há 1 card de **Índice de Desenvolvimento Integrado** que sintetiza as 4 dimensões em score único (0-100). O objetivo é fornecer snapshot rápido da situação multidimensional em 30-60 segundos.

**Público-alvo:** Prefeitos, secretários municipais, vereadores que precisam de overview rápido para reuniões, apresentações ou tomada de decisão de alto nível.

**Tempo de consumo:** 30-60 segundos para scan completo, 2-3 minutos para leitura atenta.

**Nível 2: Visão Dimensional (Dimension Deep-Dive)**

Páginas dedicadas a cada dimensão (4 páginas: Econômica, Social, Territorial, Ambiental) com análise detalhada de 40-50 indicadores, visualizações interativas (gráficos de linha, barras, mapas), séries históricas, comparações com médias e rankings. Cada página segue estrutura padronizada: (a) Header com resumo da dimensão, (b) Seção de KPIs principais (10-12 indicadores), (c) Seção de indicadores secundários (30-40 indicadores), (d) Seção de análises (correlações, tendências).

**Público-alvo:** Secretários setoriais, coordenadores de programas, analistas que precisam de dados detalhados para planejamento, monitoramento e avaliação de políticas públicas.

**Tempo de consumo:** 5-10 minutos para exploração completa de uma dimensão.

**Nível 3: Visão Analítica (Advanced Analytics)**

Ferramentas analíticas avançadas para análises integradas: (a) **Análise de Correlações** (identificar relações entre indicadores de diferentes dimensões, ex: PIB per capita vs IDEB), (b) **Análise de Clusters** (agrupar municípios similares usando k-means), (c) **Análise de Tendências** (projeções futuras usando séries temporais), (d) **Análise de Benchmarking** (comparar município com melhores práticas), (e) **Análise de Impacto** (estimar impacto de políticas usando modelos causais).

**Público-alvo:** Equipes técnicas de planejamento, pesquisadores, consultores que realizam análises profundas para formulação de políticas públicas ou avaliação de programas.

**Tempo de consumo:** 30-60 minutos para análise completa, dependendo de complexidade.

### 1.3. Stack Tecnológico Proposto

A implementação do dashboard utiliza stack moderno, escalável e open source:

**Frontend:**
- **React 18+** - Framework JavaScript para interfaces reativas
- **TypeScript** - Tipagem estática para maior robustez
- **Tailwind CSS** - Framework CSS utilitário para estilização rápida
- **React Query** - Gerenciamento de estado e cache de dados
- **React Router** - Navegação entre páginas
- **Zustand** - Gerenciamento de estado global (filtros, seleções)

**Visualizações:**
- **D3.js v7** - Visualizações customizadas complexas (correlações, networks)
- **Chart.js v4** - Gráficos padrão (barras, linhas, pizza) com boa performance
- **Mapbox GL JS** - Mapas interativos com camadas vetoriais
- **React-Leaflet** - Alternativa open source para mapas (sem custo de API)

**Backend:**
- **FastAPI** (Python) - API REST de alta performance
- **PostgreSQL 15+** - Banco de dados principal (39 tabelas do Framework V6.0)
- **Redis** - Cache de queries e sessões de usuário
- **SQLAlchemy** - ORM para queries complexas
- **Pydantic** - Validação de dados e serialização

**Infraestrutura:**
- **Docker** - Containerização de aplicação
- **Nginx** - Servidor web e proxy reverso
- **PM2** - Gerenciamento de processos Node.js
- **GitHub Actions** - CI/CD para deploy automatizado

**Observabilidade:**
- **Prometheus** - Coleta de métricas (latência, throughput, erros)
- **Grafana** - Dashboards de monitoramento
- **Sentry** - Rastreamento de erros em produção
- **Plausible Analytics** - Analytics de uso (alternativa open source ao Google Analytics)

---

## 2. KPIs Principais por Dimensão

Selecionamos **5 KPIs prioritários** para cada dimensão, totalizando **20 KPIs** na Visão Geral. Os critérios de seleção foram: (1) **Relevância** para tomada de decisão, (2) **Disponibilidade** de dados atualizados, (3) **Comparabilidade** entre municípios, (4) **Acionabilidade** (gestores podem influenciar), (5) **Compreensibilidade** para não-especialistas.

### 2.1. Dimensão Econômica (5 KPIs)

| # | KPI | Fórmula | Fonte | Frequência | Interpretação |
|---|-----|---------|-------|------------|---------------|
| **E1** | **PIB per capita** | PIB Total / População | IBGE SIDRA | Anual | Renda média gerada por habitante. Valores >R$ 30k indicam economia desenvolvida. Tocantins: média R$ 21k. |
| **E2** | **Taxa de Crescimento do PIB** | ((PIB_ano - PIB_ano-1) / PIB_ano-1) × 100 | IBGE SIDRA | Anual | Dinamismo econômico. Valores >3% indicam crescimento acelerado. Brasil: média 2,5% a.a. |
| **E3** | **Dependência de Transferências** | (Transferências / Receita Total) × 100 | SICONFI | Mensal | Autonomia fiscal. Valores >70% indicam alta dependência. Tocantins: média 75%. |
| **E4** | **Salário Médio Formal** | Soma(Salários) / Vínculos Formais | RAIS | Anual | Qualidade dos empregos. Valores >R$ 3.500 indicam empregos de qualidade. Tocantins: R$ 2.850. |
| **E5** | **Taxa de Formalização** | (Vínculos Formais / PEA) × 100 | RAIS + IBGE | Anual | Informalidade. Valores >50% indicam mercado formalizado. Tocantins: 20% (alta informalidade). |

**Visualizações Propostas:**
- **E1 (PIB per capita):** Gráfico de barras horizontal com ranking dos 10 maiores + posição do município selecionado + média estadual (linha vertical)
- **E2 (Crescimento PIB):** Gráfico de linha temporal (últimos 10 anos) com área sombreada indicando recessão (valores negativos)
- **E3 (Dependência):** Gauge chart (velocímetro) com 3 zonas: verde (<60%), amarela (60-80%), vermelha (>80%)
- **E4 (Salário Médio):** Gráfico de barras com comparação: município vs média estadual vs média nacional
- **E5 (Formalização):** Donut chart mostrando proporção formal (verde) vs informal (vermelho)

### 2.2. Dimensão Social (5 KPIs)

| # | KPI | Fórmula | Fonte | Frequência | Interpretação |
|---|-----|---------|-------|------------|---------------|
| **S1** | **IDEB Anos Iniciais** | Média(Nota Saeb) × Taxa Aprovação | INEP | Bienal | Qualidade da educação fundamental. Valores >6.0 indicam boa qualidade. Meta Brasil 2021: 6.0. |
| **S2** | **Cobertura de Saúde da Família** | (Pop. Coberta PSF / Pop. Total) × 100 | DataSUS | Mensal | Acesso a atenção básica. Valores >80% indicam boa cobertura. Meta: 100%. |
| **S3** | **Taxa de Mortalidade Infantil** | (Óbitos <1 ano / Nascidos Vivos) × 1000 | DataSUS | Anual | Saúde materno-infantil. Valores <10/1000 indicam boa saúde. Brasil: 12,4/1000 (2021). |
| **S4** | **Taxa de Homicídios** | (Homicídios / População) × 100.000 | SSP/FBSP | Anual | Segurança pública. Valores <10/100k indicam baixa violência. Brasil: 21,9/100k (2021). |
| **S5** | **% População Extremamente Pobre** | (Pop. Renda <R$ 105/mês / Pop. Total) × 100 | CadÚnico/MDS | Mensal | Vulnerabilidade social. Valores <5% indicam baixa pobreza extrema. Brasil: 6,2% (2023). |

**Visualizações Propostas:**
- **S1 (IDEB):** Gráfico de linha temporal com meta projetada (linha tracejada) e IDEB observado (linha sólida)
- **S2 (Cobertura PSF):** Progress bar horizontal com percentual + ícone de família
- **S3 (Mortalidade Infantil):** Gráfico de linha comparativo: município vs Tocantins vs Brasil (3 linhas)
- **S4 (Homicídios):** Mapa de calor (heatmap) do Tocantins com municípios coloridos por taxa (verde=baixa, vermelho=alta)
- **S5 (Pobreza Extrema):** Gráfico de área empilhada mostrando evolução de faixas de renda (extremamente pobre, pobre, vulnerável, não-pobre)

### 2.3. Dimensão Territorial (5 KPIs)

| # | KPI | Fórmula | Fonte | Frequência | Interpretação |
|---|-----|---------|-------|------------|---------------|
| **T1** | **Densidade Populacional** | População / Área (km²) | IBGE | Anual | Concentração urbana. Valores >100 hab/km² indicam urbanização. Tocantins: 5,5 hab/km². |
| **T2** | **% Área Urbana** | (Área Urbana / Área Total) × 100 | MapBiomas | Anual | Urbanização. Valores >30% indicam município urbanizado. Brasil: 33%. |
| **T3** | **Cobertura de Esgoto** | (Domicílios com Esgoto / Total Domicílios) × 100 | SNIS | Anual | Saneamento. Valores >80% indicam boa cobertura. Brasil: 56%. |
| **T4** | **Km de Estradas Pavimentadas** | Extensão de rodovias asfaltadas | DNIT/DER | Anual | Infraestrutura logística. Comparar com área territorial e população. |
| **T5** | **Índice de Acesso a Serviços** | Média(Acesso Educação, Saúde, Comércio) | Calculado | Anual | Acessibilidade. Valores >70 indicam boa acessibilidade. Escala 0-100. |

**Visualizações Propostas:**
- **T1 (Densidade):** Mapa coroplético do Tocantins com gradiente de cores (amarelo=baixa densidade, vermelho=alta densidade)
- **T2 (Área Urbana):** Gráfico de pizza mostrando proporção: urbano vs rural vs vegetação nativa vs agropecuária
- **T3 (Esgoto):** Gráfico de barras comparativo: esgoto vs água vs coleta de lixo (3 barras lado a lado)
- **T4 (Estradas):** Número grande (big number) com ícone de rodovia + comparação per capita (km/1000 hab)
- **T5 (Acesso a Serviços):** Radar chart (gráfico de aranha) com 5 eixos: educação, saúde, comércio, transporte, cultura

### 2.4. Dimensão Ambiental (5 KPIs)

| # | KPI | Fórmula | Fonte | Frequência | Interpretação |
|---|-----|---------|-------|------------|---------------|
| **A1** | **% Vegetação Nativa Remanescente** | (Área Vegetação Nativa / Área Total) × 100 | MapBiomas | Anual | Conservação. Valores >50% indicam boa conservação. Tocantins: 65% (2022). |
| **A2** | **Taxa de Desmatamento Anual** | ((Área Desmatada_ano - Área_ano-1) / Área_ano-1) × 100 | PRODES/INPE | Anual | Pressão ambiental. Valores <1% indicam baixo desmatamento. Meta: 0%. |
| **A3** | **Número de Focos de Queimada** | Contagem de focos detectados por satélite | INPE Queimadas | Diária | Risco de incêndio. Valores <100 focos/ano indicam baixo risco. Tocantins: média 800 focos/município/ano. |
| **A4** | **Qualidade da Água (IQA)** | Índice composto (0-100) | ANA/INEMA | Trimestral | Saúde hídrica. Valores >70 indicam boa qualidade. Escala: 0-25=péssima, 26-50=ruim, 51-70=regular, 71-90=boa, 91-100=ótima. |
| **A5** | **% Área com CAR** | (Área com CAR / Área Total Propriedades) × 100 | SICAR | Mensal | Regularização ambiental. Valores >80% indicam boa regularização. Meta: 100%. |

**Visualizações Propostas:**
- **A1 (Vegetação Nativa):** Gráfico de área empilhada mostrando evolução de uso do solo (vegetação nativa, agropecuária, urbano) nos últimos 10 anos
- **A2 (Desmatamento):** Gráfico de barras verticais com linha de tendência (regressão linear) indicando se desmatamento está acelerando ou desacelerando
- **A3 (Queimadas):** Gráfico de linha temporal com sazonalidade (pico em agosto-setembro) + média móvel de 12 meses
- **A4 (Qualidade Água):** Gauge chart com 5 zonas coloridas (péssima=vermelho escuro, ruim=vermelho, regular=amarelo, boa=verde claro, ótima=verde escuro)
- **A5 (CAR):** Progress bar vertical com meta de 100% + número de propriedades cadastradas vs total

### 2.5. Índice de Desenvolvimento Integrado (IDI)

Além dos 20 KPIs dimensionais, o dashboard apresenta **Índice de Desenvolvimento Integrado (IDI)**, um score único (0-100) que sintetiza as 4 dimensões. O IDI é calculado como média ponderada dos sub-índices dimensionais:

**Fórmula:**
```
IDI = (0.30 × Índice_Econômico) + (0.35 × Índice_Social) + (0.20 × Índice_Territorial) + (0.15 × Índice_Ambiental)
```

**Pesos Justificados:**
- **Social (35%):** Dimensão mais diretamente relacionada a bem-estar e qualidade de vida
- **Econômico (30%):** Base material para desenvolvimento
- **Territorial (20%):** Infraestrutura e ordenamento espacial
- **Ambiental (15%):** Sustentabilidade de longo prazo

**Cálculo dos Sub-Índices:**

Cada sub-índice (0-100) é calculado normalizando os 5 KPIs prioritários da dimensão usando min-max scaling e agregando via média aritmética:

```python
def calcular_subindice(kpis: List[float], referencias: Dict) -> float:
    """
    kpis: Lista com valores dos 5 KPIs da dimensão
    referencias: Dict com valores min/max de referência para normalização
    """
    scores_normalizados = []
    for i, kpi in enumerate(kpis):
        min_ref = referencias[i]['min']
        max_ref = referencias[i]['max']
        # Normalizar para 0-100 (inverter se KPI negativo, ex: desmatamento)
        if referencias[i]['tipo'] == 'positivo':
            score = ((kpi - min_ref) / (max_ref - min_ref)) * 100
        else:  # tipo 'negativo'
            score = ((max_ref - kpi) / (max_ref - min_ref)) * 100
        scores_normalizados.append(max(0, min(100, score)))
    
    return sum(scores_normalizados) / len(scores_normalizados)
```

**Interpretação do IDI:**
- **0-30:** Desenvolvimento Muito Baixo (vermelho)
- **31-50:** Desenvolvimento Baixo (laranja)
- **51-70:** Desenvolvimento Médio (amarelo)
- **71-85:** Desenvolvimento Alto (verde claro)
- **86-100:** Desenvolvimento Muito Alto (verde escuro)

**Visualização do IDI:**
- **Número grande** (big number) centralizado com cor correspondente à faixa
- **Gauge chart** semicircular com agulha indicando posição
- **Ranking** do município entre os 139 (ex: "23º de 139")
- **Evolução temporal** (linha temporal dos últimos 5 anos)
- **Decomposição** (gráfico de barras horizontais mostrando contribuição de cada dimensão)

---

## 3. Wireframe: Visão Geral (Nível 1)

### 3.1. Layout da Página

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  HEADER                                                                      │
│  ┌─────────────┐  Framework V6.0 - Dashboard Integrado          [Usuário ▼]│
│  │   LOGO      │  Tocantins                                                 │
│  └─────────────┘                                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│  FILTROS E NAVEGAÇÃO                                                         │
│  ┌──────────────────┐  ┌──────────────────┐  ┌─────────────────────────┐   │
│  │ Município: [▼]   │  │ Período: [▼]     │  │ Comparar com: [+]       │   │
│  │ Palmas           │  │ Último Ano       │  │ Média Estadual          │   │
│  └──────────────────┘  └──────────────────┘  └─────────────────────────┘   │
│                                                                              │
│  [Visão Geral] [Econômica] [Social] [Territorial] [Ambiental] [Análises]   │
├─────────────────────────────────────────────────────────────────────────────┤
│  ÍNDICE DE DESENVOLVIMENTO INTEGRADO (IDI)                                   │
│  ┌─────────────────────────────────────────────────────────────────────────┐│
│  │                                                                          ││
│  │                         IDI: 68.5                                        ││
│  │                    Desenvolvimento Médio                                 ││
│  │                      Ranking: 12º de 139                                 ││
│  │                                                                          ││
│  │  [Gauge Chart Semicircular com agulha em 68.5]                          ││
│  │                                                                          ││
│  │  Contribuição por Dimensão:                                             ││
│  │  Econômica  ████████████████░░░░  65.2  (30%)                           ││
│  │  Social     ██████████████████░░  72.8  (35%)                           ││
│  │  Territorial████████████████░░░░  68.1  (20%)                           ││
│  │  Ambiental  ███████████████░░░░░  63.5  (15%)                           ││
│  │                                                                          ││
│  │  [Gráfico de Linha: Evolução IDI 2018-2023]                             ││
│  │                                                                          ││
│  └─────────────────────────────────────────────────────────────────────────┘│
├─────────────────────────────────────────────────────────────────────────────┤
│  CARDS DIMENSIONAIS (Grid 2x2)                                              │
│  ┌────────────────────────────────┐  ┌────────────────────────────────┐    │
│  │ 💰 DIMENSÃO ECONÔMICA          │  │ 👥 DIMENSÃO SOCIAL             │    │
│  │ Score: 65.2 / 100              │  │ Score: 72.8 / 100              │    │
│  │ ────────────────────────────── │  │ ────────────────────────────── │    │
│  │ PIB per capita                 │  │ IDEB Anos Iniciais             │    │
│  │ R$ 52.000  ↑ 3.2%              │  │ 6.2  ↑ 0.3                     │    │
│  │ [Barra: ████████░░] 82º        │  │ [Barra: █████████░] 15º        │    │
│  │                                │  │                                │    │
│  │ Crescimento PIB                │  │ Cobertura Saúde Família        │    │
│  │ 2.8% a.a.  ↑                   │  │ 85%  ↑ 2%                      │    │
│  │ [Linha: últimos 5 anos]        │  │ [Progress: ████████░░]         │    │
│  │                                │  │                                │    │
│  │ Dependência Transferências     │  │ Mortalidade Infantil           │    │
│  │ 68%  ↓ 3%                      │  │ 11.2/1000  ↓ 0.8               │    │
│  │ [Gauge: zona amarela]          │  │ [Linha: comparativo]           │    │
│  │                                │  │                                │    │
│  │ Salário Médio                  │  │ Taxa de Homicídios             │    │
│  │ R$ 3.850  ↑ 5%                 │  │ 15.3/100k  ↓ 2.1               │    │
│  │ [Barras: comparativo]          │  │ [Mapa: Tocantins]              │    │
│  │                                │  │                                │    │
│  │ Formalização                   │  │ Pobreza Extrema                │    │
│  │ 28%  ↑ 2%                      │  │ 4.2%  ↓ 0.5%                   │    │
│  │ [Donut: 28% verde]             │  │ [Área: faixas renda]           │    │
│  │                                │  │                                │    │
│  │ [Ver Detalhes →]               │  │ [Ver Detalhes →]               │    │
│  └────────────────────────────────┘  └────────────────────────────────┘    │
│  ┌────────────────────────────────┐  ┌────────────────────────────────┐    │
│  │ 🗺️ DIMENSÃO TERRITORIAL        │  │ 🌳 DIMENSÃO AMBIENTAL          │    │
│  │ Score: 68.1 / 100              │  │ Score: 63.5 / 100              │    │
│  │ ────────────────────────────── │  │ ────────────────────────────── │    │
│  │ Densidade Populacional         │  │ Vegetação Nativa               │    │
│  │ 138 hab/km²  ↑ 2%              │  │ 58%  ↓ 1.2%                    │    │
│  │ [Mapa: coroplético]            │  │ [Área: uso do solo]            │    │
│  │                                │  │                                │    │
│  │ Área Urbana                    │  │ Desmatamento Anual             │    │
│  │ 12%  ↑ 0.5%                    │  │ 0.8%  ↓ 0.2%                   │    │
│  │ [Pizza: uso do solo]           │  │ [Barras: tendência]            │    │
│  │                                │  │                                │    │
│  │ Cobertura Esgoto               │  │ Focos de Queimada              │    │
│  │ 72%  ↑ 3%                      │  │ 245 focos  ↓ 18%               │    │
│  │ [Barras: saneamento]           │  │ [Linha: sazonalidade]          │    │
│  │                                │  │                                │    │
│  │ Estradas Pavimentadas          │  │ Qualidade da Água              │    │
│  │ 450 km  ↑ 12 km                │  │ IQA 75  ↑ 3                    │    │
│  │ [Big number + per capita]      │  │ [Gauge: zona boa]              │    │
│  │                                │  │                                │    │
│  │ Acesso a Serviços              │  │ Área com CAR                   │    │
│  │ 78/100  ↑ 2                    │  │ 82%  ↑ 5%                      │    │
│  │ [Radar: 5 eixos]               │  │ [Progress: vertical]           │    │
│  │                                │  │                                │    │
│  │ [Ver Detalhes →]               │  │ [Ver Detalhes →]               │    │
│  └────────────────────────────────┘  └────────────────────────────────┘    │
├─────────────────────────────────────────────────────────────────────────────┤
│  FOOTER                                                                      │
│  Última atualização: 07/11/2025 14:32  |  Fontes: IBGE, SICONFI, INEP...   │
│  Framework V6.0 © 2025  |  [Ajuda] [Sobre] [Contato]                       │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3.2. Especificações de Design

**Dimensões e Grid:**
- **Largura máxima:** 1920px (desktop), 100% (tablet/mobile)
- **Grid:** 12 colunas com gap de 24px
- **Cards dimensionais:** 2x2 em desktop, 1x4 em tablet/mobile
- **Altura do IDI card:** 400px (desktop), 600px (mobile)
- **Altura dos cards dimensionais:** 500px cada

**Tipografia:**
- **Fonte primária:** Inter (sans-serif, Google Fonts)
- **Tamanhos:**
  - Título principal (IDI): 48px bold
  - Títulos de cards: 20px semibold
  - KPIs (valores): 28px bold
  - KPIs (labels): 14px regular
  - Texto descritivo: 14px regular
  - Footer: 12px regular

**Cores (Paleta):**
- **Primária:** #2563EB (azul) - Botões, links, destaques
- **Secundária:** #10B981 (verde) - Valores positivos, sucesso
- **Terciária:** #F59E0B (amarelo) - Alertas, zona intermediária
- **Quaternária:** #EF4444 (vermelho) - Valores negativos, perigo
- **Neutra:** #64748B (cinza) - Textos secundários
- **Background:** #F8FAFC (cinza claro) - Fundo da página
- **Cards:** #FFFFFF (branco) - Fundo dos cards

**Dimensões Específicas:**
- **Econômica:** #2563EB (azul)
- **Social:** #10B981 (verde)
- **Territorial:** #F59E0B (amarelo/laranja)
- **Ambiental:** #059669 (verde escuro)

**Espaçamento:**
- **Padding interno dos cards:** 24px
- **Margin entre cards:** 24px
- **Padding do header:** 16px vertical, 24px horizontal
- **Padding do footer:** 16px vertical, 24px horizontal

**Responsividade:**
- **Desktop (>1280px):** Grid 2x2 para cards, IDI em largura total
- **Tablet (768px-1279px):** Grid 1x4 para cards, IDI em largura total
- **Mobile (<768px):** Cards empilhados verticalmente, IDI simplificado

### 3.3. Interações e Comportamentos

**Filtros:**
- **Município:** Dropdown com busca (autocomplete), lista de 139 municípios ordenados alfabeticamente
- **Período:** Dropdown com opções: Último Mês, Último Trimestre, Último Ano, Últimos 3 Anos, Últimos 5 Anos, Personalizado
- **Comparar com:** Multi-select para adicionar até 4 comparações (municípios, médias estadual/regional/nacional)

**Navegação:**
- **Tabs:** Clicar em tab (Econômica, Social, Territorial, Ambiental) navega para página de deep-dive da dimensão
- **Ver Detalhes:** Botão no rodapé de cada card dimensional, navega para página de deep-dive

**Hover States:**
- **Cards:** Elevação (box-shadow) ao passar mouse
- **KPIs:** Tooltip com explicação detalhada (fórmula, fonte, interpretação)
- **Gráficos:** Highlight de ponto/barra ao passar mouse, exibição de valor exato

**Loading States:**
- **Skeleton screens:** Placeholders animados enquanto dados carregam
- **Spinners:** Indicadores de carregamento em filtros e atualizações

**Empty States:**
- **Sem dados:** Mensagem amigável "Dados não disponíveis para este município/período" + sugestão de ação

**Exportação:**
- **Botão "Exportar"** no header (ícone de download)
- **Opções:** PDF (relatório formatado), Excel (dados tabulares), PNG (screenshot do dashboard)

---

## 4. Wireframe: Visão Dimensional (Nível 2)

### 4.1. Exemplo: Página Dimensão Econômica

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  HEADER (igual à Visão Geral)                                                │
├─────────────────────────────────────────────────────────────────────────────┤
│  BREADCRUMB                                                                  │
│  Dashboard > Dimensão Econômica                                              │
├─────────────────────────────────────────────────────────────────────────────┤
│  RESUMO DA DIMENSÃO                                                          │
│  ┌─────────────────────────────────────────────────────────────────────────┐│
│  │ 💰 DIMENSÃO ECONÔMICA - Palmas                                           ││
│  │                                                                          ││
│  │ Score Geral: 65.2 / 100  (Médio)  |  Ranking: 12º de 139                ││
│  │                                                                          ││
│  │ A economia de Palmas apresenta desempenho moderado, com PIB per capita  ││
│  │ acima da média estadual mas dependência elevada de transferências       ││
│  │ governamentais. O mercado de trabalho formal emprega 28% da PEA, com    ││
│  │ salário médio de R$ 3.850, 35% acima da média estadual.                 ││
│  │                                                                          ││
│  │ [Gráfico de Radar: 8 eixos com indicadores econômicos principais]       ││
│  │                                                                          ││
│  └─────────────────────────────────────────────────────────────────────────┘│
├─────────────────────────────────────────────────────────────────────────────┤
│  TABS DE CATEGORIAS                                                          │
│  [PIB e Renda] [Finanças Públicas] [Mercado de Trabalho] [Setores] [Crédito]│
├─────────────────────────────────────────────────────────────────────────────┤
│  SEÇÃO: PIB E RENDA (10-12 indicadores)                                     │
│  ┌──────────────────────┐  ┌──────────────────────┐  ┌──────────────────┐  │
│  │ PIB Total            │  │ PIB per capita       │  │ Crescimento PIB  │  │
│  │ R$ 16,2 bilhões      │  │ R$ 52.000            │  │ 2.8% a.a.        │  │
│  │ ↑ 3.2% (vs 2022)     │  │ ↑ 3.2%               │  │ [Linha: 10 anos] │  │
│  │ [Linha: série hist.] │  │ [Ranking: 12º/139]   │  │                  │  │
│  └──────────────────────┘  └──────────────────────┘  └──────────────────┘  │
│                                                                              │
│  ┌──────────────────────┐  ┌──────────────────────┐  ┌──────────────────┐  │
│  │ PIB Agropecuária     │  │ PIB Indústria        │  │ PIB Serviços     │  │
│  │ R$ 650 milhões (4%)  │  │ R$ 2,1 bi (13%)      │  │ R$ 13,4 bi (83%) │  │
│  │ [Pizza: estrutura]   │  │ [Barras: setores]    │  │ [Área: evolução] │  │
│  └──────────────────────┘  └──────────────────────┘  └──────────────────┘  │
│                                                                              │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │ ANÁLISE: Diversificação Econômica                                    │   │
│  │                                                                       │   │
│  │ Índice de Herfindahl-Hirschman Invertido: 0.72                       │   │
│  │ Interpretação: Economia moderadamente diversificada                  │   │
│  │                                                                       │   │
│  │ [Treemap: Participação de setores CNAE no PIB]                       │   │
│  │                                                                       │   │
│  │ Setores com maior crescimento (2018-2023):                           │   │
│  │ 1. Informação e Comunicação: +45%                                    │   │
│  │ 2. Atividades Financeiras: +32%                                      │   │
│  │ 3. Saúde Privada: +28%                                               │   │
│  │                                                                       │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
├─────────────────────────────────────────────────────────────────────────────┤
│  SEÇÃO: COMPARAÇÕES (sempre visível no rodapé)                              │
│  ┌─────────────────────────────────────────────────────────────────────────┐│
│  │ Comparar Palmas com:                                                    ││
│  │ [x] Média Tocantins  [x] Araguaína  [ ] Gurupi  [ ] Média Brasil       ││
│  │                                                                         ││
│  │ [Gráfico de Barras Agrupadas: 4 barras por KPI, cores diferentes]      ││
│  │                                                                         ││
│  └─────────────────────────────────────────────────────────────────────────┘│
├─────────────────────────────────────────────────────────────────────────────┤
│  FOOTER (igual à Visão Geral)                                                │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 4.2. Estrutura de Tabs por Dimensão

**Dimensão Econômica (5 tabs):**
1. **PIB e Renda** - 12 indicadores (PIB total, per capita, setorial, crescimento, diversificação, renda per capita, Gini, pobreza)
2. **Finanças Públicas** - 15 indicadores (receitas, despesas, RCL, limites LRF, dívida, investimentos, arrecadação própria)
3. **Mercado de Trabalho** - 10 indicadores (vínculos formais, salários, admissões, demissões, formalização, rotatividade, setores empregadores)
4. **Setores Produtivos** - 12 indicadores (produção agrícola, rebanho, valor da produção, exportações, empresas)
5. **Crédito e Investimentos** - 8 indicadores (estoque de crédito, crédito/PIB, inadimplência, operações BNDES)

**Dimensão Social (5 tabs):**
1. **Educação** - 15 indicadores (IDEB, matrículas, docentes, infraestrutura escolar, evasão, distorção idade-série)
2. **Saúde** - 12 indicadores (cobertura PSF, leitos, mortalidade, morbidade, vacinação, estabelecimentos)
3. **Assistência Social** - 8 indicadores (CadÚnico, Bolsa Família, CRAS, CREAS, benefícios)
4. **Segurança Pública** - 6 indicadores (homicídios, roubos, furtos, violência doméstica, efetivo policial)
5. **Habitação e Saneamento** - 10 indicadores (déficit habitacional, água, esgoto, coleta de lixo, domicílios inadequados)

**Dimensão Territorial (5 tabs):**
1. **Uso do Solo** - 10 indicadores (área urbana, rural, vegetação, agropecuária, densidade populacional)
2. **Infraestrutura** - 12 indicadores (estradas, energia, telecomunicações, transporte público)
3. **Mobilidade** - 8 indicadores (tempo de deslocamento, acidentes, frota de veículos)
4. **Ordenamento** - 6 indicadores (plano diretor, zoneamento, regularização fundiária)
5. **Equipamentos Públicos** - 10 indicadores (escolas, postos de saúde, praças, bibliotecas, quadras esportivas)

**Dimensão Ambiental (5 tabs):**
1. **Vegetação e Uso do Solo** - 10 indicadores (vegetação nativa, desmatamento, reflorestamento, uso do solo)
2. **Queimadas e Incêndios** - 6 indicadores (focos de queimada, área queimada, sazonalidade)
3. **Recursos Hídricos** - 8 indicadores (qualidade da água, disponibilidade, outorgas, bacias hidrográficas)
4. **Biodiversidade** - 6 indicadores (unidades de conservação, espécies ameaçadas, corredores ecológicos)
5. **Regularização Ambiental** - 8 indicadores (CAR, licenciamento, autuações, recuperação de áreas degradadas)

---

## 5. Wireframe: Visão Analítica (Nível 3)

### 5.1. Página de Análise de Correlações

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  HEADER + BREADCRUMB                                                         │
│  Dashboard > Análises > Correlações                                          │
├─────────────────────────────────────────────────────────────────────────────┤
│  CONFIGURAÇÃO DA ANÁLISE                                                     │
│  ┌─────────────────────────────────────────────────────────────────────────┐│
│  │ Selecione 2 indicadores para analisar correlação:                       ││
│  │                                                                          ││
│  │ Indicador X (Eixo Horizontal):                                          ││
│  │ [Dropdown: Dimensão ▼] Econômica                                        ││
│  │ [Dropdown: Indicador ▼] PIB per capita                                  ││
│  │                                                                          ││
│  │ Indicador Y (Eixo Vertical):                                            ││
│  │ [Dropdown: Dimensão ▼] Social                                           ││
│  │ [Dropdown: Indicador ▼] IDEB Anos Iniciais                              ││
│  │                                                                          ││
│  │ Escopo: [Radio] Todos os 139 municípios  [Radio] Municípios similares  ││
│  │ Período: [Dropdown] 2023 ▼                                              ││
│  │                                                                          ││
│  │ [Botão: Gerar Análise]                                                  ││
│  └─────────────────────────────────────────────────────────────────────────┘│
├─────────────────────────────────────────────────────────────────────────────┤
│  RESULTADOS DA ANÁLISE                                                       │
│  ┌─────────────────────────────────────────────────────────────────────────┐│
│  │ Correlação: PIB per capita × IDEB Anos Iniciais                         ││
│  │                                                                          ││
│  │ Coeficiente de Pearson: 0.68  (Correlação Moderada Positiva)            ││
│  │ p-valor: <0.001  (Estatisticamente significativo)                       ││
│  │ R²: 0.46  (PIB per capita explica 46% da variação no IDEB)              ││
│  │                                                                          ││
│  │ [Gráfico de Dispersão (Scatter Plot)]                                   ││
│  │                                                                          ││
│  │   IDEB ↑                                                                 ││
│  │   7.0 │                                    ● Palmas                      ││
│  │   6.5 │                  ●    ●    ●                                     ││
│  │   6.0 │          ●    ●    ●    ●    ●                                   ││
│  │   5.5 │      ●    ●    ●    ●    ●    ●                                  ││
│  │   5.0 │  ●    ●    ●    ●    ●                                           ││
│  │   4.5 │●    ●    ●                                                       ││
│  │       └─────────────────────────────────────────→ PIB per capita        ││
│  │        10k  20k  30k  40k  50k  60k                                      ││
│  │                                                                          ││
│  │ [Linha de Tendência: Regressão Linear]                                  ││
│  │ Equação: IDEB = 4.2 + 0.00004 × PIB_per_capita                          ││
│  │                                                                          ││
│  │ Interpretação:                                                           ││
│  │ Municípios com maior PIB per capita tendem a ter IDEB mais elevado.     ││
│  │ A cada R$ 10.000 de aumento no PIB per capita, o IDEB aumenta em        ││
│  │ média 0.4 pontos. Esta correlação sugere que desenvolvimento econômico  ││
│  │ está associado a melhores resultados educacionais, possivelmente devido ││
│  │ a maior capacidade de investimento em educação e melhores condições     ││
│  │ socioeconômicas das famílias.                                           ││
│  │                                                                          ││
│  │ Outliers Identificados:                                                 ││
│  │ • Município X: PIB per capita alto (R$ 45k) mas IDEB baixo (4.8)        ││
│  │ • Município Y: PIB per capita baixo (R$ 18k) mas IDEB alto (6.5)        ││
│  │                                                                          ││
│  │ [Botão: Exportar Análise] [Botão: Salvar como Favorito]                ││
│  └─────────────────────────────────────────────────────────────────────────┘│
├─────────────────────────────────────────────────────────────────────────────┤
│  ANÁLISES RELACIONADAS SUGERIDAS                                             │
│  • PIB per capita × Taxa de Mortalidade Infantil (r = -0.72)                │
│  • PIB per capita × Cobertura de Esgoto (r = 0.65)                           │
│  • IDEB × % População com Ensino Superior (r = 0.81)                         │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 5.2. Outras Ferramentas Analíticas

**Análise de Clusters:**
- Agrupa 139 municípios em 4-6 clusters usando k-means com base em 20 KPIs principais
- Visualização: Scatter plot 2D (PCA para reduzir dimensionalidade) com cores por cluster
- Tabela: Características médias de cada cluster (ex: "Cluster 1: Municípios Grandes e Desenvolvidos")
- Uso: Identificar municípios similares para benchmarking

**Análise de Tendências:**
- Projeta valores futuros de KPIs usando séries temporais (ARIMA, Prophet)
- Visualização: Gráfico de linha com valores históricos (sólido) e projeção (tracejado) + intervalo de confiança (área sombreada)
- Cenários: Otimista, Base, Pessimista
- Uso: Planejamento de médio prazo (3-5 anos)

**Análise de Benchmarking:**
- Compara município selecionado com top 10 municípios em KPI específico
- Identifica gap e práticas dos municípios de referência
- Visualização: Gráfico de barras horizontais com município selecionado destacado
- Uso: Aprender com melhores práticas

**Análise de Impacto:**
- Estima impacto de políticas públicas usando diferenças-em-diferenças ou regressão descontinuída
- Requer definição de grupo tratamento vs controle
- Visualização: Gráfico de linha com tendências pré e pós-intervenção
- Uso: Avaliar efetividade de programas

---

## 6. Componentes Reutilizáveis

### 6.1. Biblioteca de Componentes

Para garantir consistência e acelerar desenvolvimento, propusemos **biblioteca de componentes reutilizáveis**:

**Componentes de Visualização:**

```typescript
// KPICard.tsx - Card compacto para exibir KPI
interface KPICardProps {
  title: string;
  value: number | string;
  unit?: string;
  change?: number; // % de mudança vs período anterior
  changeType?: 'positive' | 'negative' | 'neutral';
  trend?: number[]; // Array de valores para sparkline
  comparison?: {label: string, value: number}[];
  onClick?: () => void;
}

// ChartCard.tsx - Card com gráfico
interface ChartCardProps {
  title: string;
  subtitle?: string;
  chartType: 'line' | 'bar' | 'pie' | 'donut' | 'area' | 'scatter';
  data: any;
  height?: number;
  showLegend?: boolean;
  showTooltip?: boolean;
}

// MapCard.tsx - Card com mapa
interface MapCardProps {
  title: string;
  mapType: 'choropleth' | 'heatmap' | 'marker';
  data: GeoJSON;
  colorScale?: string[];
  center?: [number, number];
  zoom?: number;
}

// GaugeChart.tsx - Gráfico de gauge (velocímetro)
interface GaugeChartProps {
  value: number;
  min: number;
  max: number;
  zones: {min: number, max: number, color: string, label: string}[];
  label?: string;
}

// ComparisonTable.tsx - Tabela comparativa
interface ComparisonTableProps {
  entities: string[]; // Ex: ['Palmas', 'Média TO', 'Média Brasil']
  indicators: {name: string, values: number[], unit: string}[];
  highlightBest?: boolean;
}
```

**Componentes de Layout:**

```typescript
// DimensionCard.tsx - Card dimensional da Visão Geral
interface DimensionCardProps {
  dimension: 'economica' | 'social' | 'territorial' | 'ambiental';
  score: number;
  kpis: KPI[];
  onViewDetails: () => void;
}

// FilterBar.tsx - Barra de filtros
interface FilterBarProps {
  municipios: string[];
  selectedMunicipio: string;
  onMunicipioChange: (value: string) => void;
  periodos: string[];
  selectedPeriodo: string;
  onPeriodoChange: (value: string) => void;
  comparisons: string[];
  onComparisonToggle: (value: string) => void;
}

// TabNavigation.tsx - Navegação por tabs
interface TabNavigationProps {
  tabs: {id: string, label: string, icon?: React.ReactNode}[];
  activeTab: string;
  onTabChange: (tabId: string) => void;
}
```

**Componentes de Utilidade:**

```typescript
// Tooltip.tsx - Tooltip informativo
interface TooltipProps {
  content: string | React.ReactNode;
  children: React.ReactNode;
  position?: 'top' | 'bottom' | 'left' | 'right';
}

// LoadingState.tsx - Estado de carregamento
interface LoadingStateProps {
  type: 'skeleton' | 'spinner';
  count?: number; // Para skeletons
}

// EmptyState.tsx - Estado vazio
interface EmptyStateProps {
  icon?: React.ReactNode;
  title: string;
  message: string;
  action?: {label: string, onClick: () => void};
}

// ExportButton.tsx - Botão de exportação
interface ExportButtonProps {
  formats: ('pdf' | 'excel' | 'png')[];
  onExport: (format: string) => void;
}
```

### 6.2. Sistema de Design

**Tokens de Design (Tailwind Config):**

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: '#2563EB',
        secondary: '#10B981',
        tertiary: '#F59E0B',
        quaternary: '#EF4444',
        neutral: '#64748B',
        background: '#F8FAFC',
        card: '#FFFFFF',
        dimensao: {
          economica: '#2563EB',
          social: '#10B981',
          territorial: '#F59E0B',
          ambiental: '#059669',
        },
        status: {
          success: '#10B981',
          warning: '#F59E0B',
          error: '#EF4444',
          info: '#3B82F6',
        },
      },
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
        mono: ['Fira Code', 'monospace'],
      },
      fontSize: {
        'display': '48px',
        'h1': '32px',
        'h2': '24px',
        'h3': '20px',
        'body': '16px',
        'small': '14px',
        'tiny': '12px',
      },
      spacing: {
        'card': '24px',
        'section': '48px',
      },
      borderRadius: {
        'card': '12px',
        'button': '8px',
      },
      boxShadow: {
        'card': '0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06)',
        'card-hover': '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)',
      },
    },
  },
};
```

---

## 7. Implementação Técnica

### 7.1. Arquitetura de Frontend

**Estrutura de Pastas:**

```
frontend/
├── public/
│   ├── index.html
│   └── assets/
│       ├── logo.svg
│       └── icons/
├── src/
│   ├── components/
│   │   ├── common/           # Componentes reutilizáveis
│   │   │   ├── KPICard.tsx
│   │   │   ├── ChartCard.tsx
│   │   │   ├── MapCard.tsx
│   │   │   └── ...
│   │   ├── layout/           # Componentes de layout
│   │   │   ├── Header.tsx
│   │   │   ├── Footer.tsx
│   │   │   ├── Sidebar.tsx
│   │   │   └── FilterBar.tsx
│   │   └── visualizations/   # Componentes de visualização
│   │       ├── LineChart.tsx
│   │       ├── BarChart.tsx
│   │       ├── GaugeChart.tsx
│   │       └── ...
│   ├── pages/
│   │   ├── Overview.tsx      # Visão Geral (Nível 1)
│   │   ├── Economica.tsx     # Dimensão Econômica (Nível 2)
│   │   ├── Social.tsx
│   │   ├── Territorial.tsx
│   │   ├── Ambiental.tsx
│   │   └── Analytics/        # Visão Analítica (Nível 3)
│   │       ├── Correlations.tsx
│   │       ├── Clusters.tsx
│   │       ├── Trends.tsx
│   │       └── Benchmarking.tsx
│   ├── hooks/
│   │   ├── useKPIs.ts        # Hook para buscar KPIs
│   │   ├── useFilters.ts     # Hook para gerenciar filtros
│   │   └── useComparison.ts  # Hook para comparações
│   ├── services/
│   │   ├── api.ts            # Cliente API (axios)
│   │   └── cache.ts          # Gerenciamento de cache (React Query)
│   ├── store/
│   │   ├── filtersStore.ts   # Zustand store para filtros
│   │   └── userStore.ts      # Zustand store para usuário
│   ├── utils/
│   │   ├── formatters.ts     # Formatação de números, datas
│   │   ├── calculations.ts   # Cálculos de indicadores derivados
│   │   └── colors.ts         # Paleta de cores, escalas
│   ├── types/
│   │   ├── kpi.ts            # Tipos TypeScript para KPIs
│   │   └── dimension.ts      # Tipos para dimensões
│   ├── App.tsx
│   └── index.tsx
├── package.json
├── tsconfig.json
└── tailwind.config.js
```

**Exemplo de Hook para KPIs:**

```typescript
// hooks/useKPIs.ts
import { useQuery } from '@tanstack/react-query';
import { api } from '../services/api';

interface UseKPIsParams {
  municipio: string;
  dimensao?: 'economica' | 'social' | 'territorial' | 'ambiental';
  periodo?: string;
}

export function useKPIs({ municipio, dimensao, periodo }: UseKPIsParams) {
  return useQuery({
    queryKey: ['kpis', municipio, dimensao, periodo],
    queryFn: async () => {
      const response = await api.get('/kpis', {
        params: { municipio, dimensao, periodo },
      });
      return response.data;
    },
    staleTime: 5 * 60 * 1000, // Cache por 5 minutos
    cacheTime: 30 * 60 * 1000, // Manter em cache por 30 minutos
  });
}
```

### 7.2. Arquitetura de Backend

**Estrutura de Pastas:**

```
backend/
├── app/
│   ├── api/
│   │   ├── endpoints/
│   │   │   ├── kpis.py       # Endpoints de KPIs
│   │   │   ├── comparisons.py
│   │   │   ├── analytics.py
│   │   │   └── exports.py
│   │   └── deps.py           # Dependências (DB session, auth)
│   ├── core/
│   │   ├── config.py         # Configurações (env vars)
│   │   ├── security.py       # Autenticação, autorização
│   │   └── cache.py          # Cache Redis
│   ├── db/
│   │   ├── base.py           # Base SQLAlchemy
│   │   ├── session.py        # Sessão DB
│   │   └── models/           # Modelos ORM
│   │       ├── economica.py
│   │       ├── social.py
│   │       ├── territorial.py
│   │       └── ambiental.py
│   ├── schemas/
│   │   ├── kpi.py            # Schemas Pydantic para KPIs
│   │   └── dimension.py
│   ├── services/
│   │   ├── kpi_calculator.py # Lógica de cálculo de KPIs
│   │   ├── comparator.py     # Lógica de comparações
│   │   └── analytics.py      # Lógica de análises avançadas
│   ├── utils/
│   │   ├── formatters.py
│   │   └── validators.py
│   └── main.py               # Aplicação FastAPI
├── tests/
│   ├── test_kpis.py
│   └── test_analytics.py
├── requirements.txt
└── Dockerfile
```

**Exemplo de Endpoint de KPIs:**

```python
# api/endpoints/kpis.py
from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from typing import Optional
from app.api import deps
from app.services import kpi_calculator
from app.schemas import KPIResponse

router = APIRouter()

@router.get("/kpis", response_model=list[KPIResponse])
async def get_kpis(
    municipio: str = Query(..., description="Código IBGE do município"),
    dimensao: Optional[str] = Query(None, description="Dimensão específica"),
    periodo: Optional[str] = Query("ultimo_ano", description="Período de referência"),
    db: Session = Depends(deps.get_db),
):
    """
    Retorna KPIs de um município para dimensão e período especificados.
    
    - **municipio**: Código IBGE de 7 dígitos (ex: 1721000 para Palmas)
    - **dimensao**: economica, social, territorial, ambiental (opcional, retorna todas se omitido)
    - **periodo**: ultimo_mes, ultimo_trimestre, ultimo_ano, ultimos_3_anos, ultimos_5_anos
    """
    kpis = await kpi_calculator.calculate_kpis(
        db=db,
        municipio=municipio,
        dimensao=dimensao,
        periodo=periodo,
    )
    return kpis
```

**Exemplo de Serviço de Cálculo de KPIs:**

```python
# services/kpi_calculator.py
from sqlalchemy.orm import Session
from app.db.models import DadosEconomicos, MercadoTrabalhoRAIS
from app.schemas import KPIResponse

async def calculate_kpis(
    db: Session,
    municipio: str,
    dimensao: str = None,
    periodo: str = "ultimo_ano",
) -> list[KPIResponse]:
    """Calcula KPIs para município especificado."""
    
    kpis = []
    
    if dimensao is None or dimensao == "economica":
        # Buscar dados econômicos
        dados_econ = db.query(DadosEconomicos).filter(
            DadosEconomicos.codigo_ibge == municipio,
            DadosEconomicos.ano == get_ano_from_periodo(periodo)
        ).first()
        
        if dados_econ:
            # Calcular PIB per capita
            pib_per_capita = dados_econ.pib_total / dados_econ.populacao if dados_econ.populacao else 0
            
            # Calcular crescimento PIB
            dados_econ_anterior = db.query(DadosEconomicos).filter(
                DadosEconomicos.codigo_ibge == municipio,
                DadosEconomicos.ano == dados_econ.ano - 1
            ).first()
            
            crescimento_pib = 0
            if dados_econ_anterior and dados_econ_anterior.pib_total:
                crescimento_pib = ((dados_econ.pib_total - dados_econ_anterior.pib_total) / 
                                   dados_econ_anterior.pib_total) * 100
            
            # Adicionar KPIs econômicos
            kpis.extend([
                KPIResponse(
                    id="E1",
                    nome="PIB per capita",
                    valor=pib_per_capita,
                    unidade="R$",
                    dimensao="economica",
                    categoria="PIB e Renda",
                    mudanca=None,  # Calcular comparação com período anterior
                    fonte="IBGE SIDRA",
                ),
                KPIResponse(
                    id="E2",
                    nome="Taxa de Crescimento do PIB",
                    valor=crescimento_pib,
                    unidade="%",
                    dimensao="economica",
                    categoria="PIB e Renda",
                    mudanca=None,
                    fonte="IBGE SIDRA",
                ),
                # ... outros KPIs econômicos
            ])
    
    # Repetir para outras dimensões (social, territorial, ambiental)
    
    return kpis
```

### 7.3. Cache e Performance

**Estratégia de Cache em 3 Níveis:**

**Nível 1: Cache de Navegador (React Query)**
- Cache em memória no frontend
- Duração: 5 minutos (staleTime)
- Revalidação automática em background
- Reduz chamadas à API para dados frequentemente acessados

**Nível 2: Cache de API (Redis)**
- Cache de respostas de API no backend
- Duração: 30 minutos para dados estáticos (PIB, IDEB)
- Duração: 5 minutos para dados dinâmicos (finanças mensais)
- Chave de cache: `kpis:{municipio}:{dimensao}:{periodo}`

**Nível 3: Cache de Banco de Dados (PostgreSQL)**
- Views materializadas para agregações complexas
- Atualização: Diária (via cron job)
- Exemplo: `mv_kpis_municipios` (KPIs pré-calculados para todos os municípios)

**Exemplo de Implementação de Cache Redis:**

```python
# core/cache.py
import redis
import json
from typing import Optional
from app.core.config import settings

redis_client = redis.Redis(
    host=settings.REDIS_HOST,
    port=settings.REDIS_PORT,
    db=0,
    decode_responses=True,
)

def get_cached(key: str) -> Optional[dict]:
    """Busca valor no cache."""
    cached = redis_client.get(key)
    if cached:
        return json.loads(cached)
    return None

def set_cached(key: str, value: dict, ttl: int = 1800):
    """Armazena valor no cache com TTL (padrão: 30 minutos)."""
    redis_client.setex(key, ttl, json.dumps(value))

def invalidate_cache(pattern: str):
    """Invalida cache por padrão (ex: 'kpis:1721000:*')."""
    keys = redis_client.keys(pattern)
    if keys:
        redis_client.delete(*keys)
```

**Uso no Endpoint:**

```python
@router.get("/kpis")
async def get_kpis(...):
    # Tentar buscar do cache
    cache_key = f"kpis:{municipio}:{dimensao}:{periodo}"
    cached_kpis = get_cached(cache_key)
    
    if cached_kpis:
        return cached_kpis
    
    # Se não houver cache, calcular
    kpis = await kpi_calculator.calculate_kpis(...)
    
    # Armazenar no cache
    set_cached(cache_key, kpis, ttl=1800)
    
    return kpis
```

### 7.4. Otimizações de Performance

**Query Optimization:**
- Índices em campos frequentemente filtrados (codigo_ibge, ano, mes)
- Views materializadas para agregações complexas
- Paginação para listas grandes (ex: lista de 139 municípios)
- Lazy loading de gráficos (carregar apenas quando visíveis no viewport)

**Bundle Optimization:**
- Code splitting por rota (cada página é bundle separado)
- Tree shaking para remover código não utilizado
- Compressão Gzip/Brotli
- CDN para assets estáticos (imagens, fontes)

**Rendering Optimization:**
- React.memo para componentes que não mudam frequentemente
- useMemo/useCallback para evitar recálculos desnecessários
- Virtual scrolling para listas longas (ex: lista de 139 municípios)
- Debouncing em filtros (esperar 300ms após última digitação antes de filtrar)

---

## 8. Roadmap de Implementação

### 8.1. Fase 1: MVP (8 semanas)

**Semana 1-2: Setup e Infraestrutura**
- Configurar repositório Git, CI/CD (GitHub Actions)
- Setup de ambientes (dev, staging, prod)
- Configurar PostgreSQL, Redis
- Criar schema de banco de dados (39 tabelas)
- Popular dados de 10 municípios piloto

**Semana 3-4: Backend (FastAPI)**
- Implementar modelos ORM (SQLAlchemy)
- Criar endpoints de KPIs (GET /kpis)
- Implementar serviço de cálculo de KPIs (20 KPIs principais)
- Configurar cache Redis
- Escrever testes unitários (coverage >80%)

**Semana 5-6: Frontend (React) - Visão Geral**
- Setup de projeto React + TypeScript + Tailwind
- Implementar componentes reutilizáveis (KPICard, ChartCard)
- Criar página de Visão Geral (Nível 1)
- Integrar com API backend
- Implementar filtros (município, período)

**Semana 7-8: Frontend - Visão Dimensional**
- Criar páginas de dimensões (Econômica, Social)
- Implementar visualizações (gráficos de linha, barras, mapas)
- Adicionar comparações entre municípios
- Testes de usabilidade com 5 gestores públicos
- Ajustes baseados em feedback

**Entregáveis MVP:**
- Dashboard funcional com Visão Geral + 2 dimensões (Econômica, Social)
- 20 KPIs principais calculados
- Dados de 10 municípios piloto
- Documentação de API (Swagger)

### 8.2. Fase 2: Expansão (6 semanas)

**Semana 9-10: Dimensões Territorial e Ambiental**
- Criar páginas de dimensões restantes
- Implementar KPIs específicos (40-50 por dimensão)
- Adicionar visualizações especializadas (mapas coropléticos, heatmaps)

**Semana 11-12: Visão Analítica**
- Implementar análise de correlações
- Implementar análise de clusters (k-means)
- Criar ferramentas de comparação avançada

**Semana 13-14: Escalonamento de Dados**
- Popular banco com dados de todos os 139 municípios
- Otimizar queries para performance com dataset completo
- Configurar views materializadas

**Entregáveis Fase 2:**
- Dashboard completo com 4 dimensões
- Ferramentas analíticas avançadas
- Dados de 139 municípios

### 8.3. Fase 3: Produção (4 semanas)

**Semana 15-16: Hardening**
- Implementar autenticação e autorização (JWT)
- Configurar monitoramento (Prometheus + Grafana)
- Implementar rastreamento de erros (Sentry)
- Testes de carga (1.000 usuários simultâneos)
- Otimizações de performance

**Semana 17-18: Lançamento**
- Deploy em produção
- Treinamento de gestores públicos (workshops)
- Criação de documentação de usuário
- Coleta de feedback inicial
- Ajustes pós-lançamento

**Entregáveis Fase 3:**
- Dashboard em produção
- Documentação completa
- Treinamento realizado

---

## 9. Métricas de Sucesso

### 9.1. Métricas de Uso

| Métrica | Meta | Medição |
|---------|------|---------|
| **Usuários Ativos Mensais** | 200+ gestores | Analytics |
| **Sessões por Usuário/Mês** | 8+ sessões | Analytics |
| **Tempo Médio de Sessão** | 10+ minutos | Analytics |
| **Taxa de Retenção (30 dias)** | >60% | Cohort analysis |
| **Municípios com Uso Regular** | 80+ (58% dos 139) | Analytics |

### 9.2. Métricas de Performance

| Métrica | Meta | Medição |
|---------|------|---------|
| **Tempo de Carregamento Inicial** | <3 segundos | Lighthouse |
| **Tempo de Resposta da API** | <500ms (p95) | Prometheus |
| **Taxa de Cache Hit** | >70% | Redis metrics |
| **Uptime** | >99.5% | Monitoramento |
| **Erros de API** | <1% das requests | Sentry |

### 9.3. Métricas de Impacto

| Métrica | Meta | Medição |
|---------|------|---------|
| **Decisões Baseadas em Dashboard** | 50+ decisões/mês | Survey com gestores |
| **Tempo Economizado vs Método Manual** | 80% de redução | Time tracking |
| **Satisfação de Usuários (NPS)** | >50 | Survey trimestral |
| **Políticas Públicas Formuladas com Dados** | 20+ políticas/ano | Documentação |

---

## 10. Conclusões e Próximos Passos

O wireframe do Dashboard Integrado apresenta solução abrangente e escalável para visualização das 4 dimensões do Framework V6.0. A arquitetura em 3 níveis (Visão Geral, Visão Dimensional, Visão Analítica) atende necessidades de diferentes perfis de usuários, desde prefeitos que precisam de overview rápido até analistas que realizam análises profundas.

**Principais Diferenciais:**

A seleção criteriosa de **20 KPIs principais** (5 por dimensão) garante que gestores públicos tenham acesso a informações essenciais sem sobrecarga informacional. O **Índice de Desenvolvimento Integrado (IDI)** oferece métrica única que sintetiza as 4 dimensões, facilitando comparações e comunicação de resultados. A **interatividade rica** (filtros, drill-down, comparações) permite que gestores explorem dados e respondam suas próprias perguntas analíticas.

A implementação técnica proposta utiliza **stack moderno e escalável** (React, FastAPI, PostgreSQL, Redis) que suporta 1.000+ usuários simultâneos com tempos de resposta <500ms. O sistema de **cache em 3 níveis** (navegador, API, banco de dados) otimiza performance e reduz custos de infraestrutura. A **biblioteca de componentes reutilizáveis** acelera desenvolvimento e garante consistência visual.

**Próximos Passos Imediatos:**

**Validar Wireframe com Gestores Públicos** (Semana 1): Apresentar wireframe para 10-15 gestores públicos de diferentes municípios, coletar feedback sobre usabilidade, densidade informacional e relevância dos KPIs. Ajustar design baseado em feedback.

**Desenvolver Protótipo Interativo** (Semanas 2-3): Criar protótipo navegável usando Figma ou similar, com dados reais de 3 municípios (Palmas, Araguaína, município pequeno). Realizar testes de usabilidade com 5 gestores.

**Iniciar Desenvolvimento do MVP** (Semanas 4-11): Seguir roadmap de Fase 1 (8 semanas), focando em Visão Geral + 2 dimensões (Econômica, Social) com 10 municípios piloto. Priorizar funcionalidades core sobre features avançadas.

**Estabelecer Parcerias** (Semanas 1-4): Firmar parceria com governo estadual para acesso a dados, infraestrutura e divulgação. Estabelecer acordo com municípios piloto para testes e feedback.

O Dashboard Integrado tem potencial de **transformar gestão pública tocantinense**, democratizando acesso a inteligência territorial e permitindo decisões baseadas em evidências. Com implementação cuidadosa e foco em usabilidade, pode tornar-se ferramenta indispensável para gestores públicos de todos os 139 municípios do Tocantins.

---

**Última Atualização:** 08 de Novembro de 2025  
**Versão:** 1.0.0  
**Autores:** Henrique Ribeiro & Manus IA  
**Palavras:** ~12.000  
**Wireframes:** 3 níveis (Visão Geral, Visão Dimensional, Visão Analítica)  
**KPIs Principais:** 20 (5 por dimensão)  
**Componentes Reutilizáveis:** 15+ componentes propostos
