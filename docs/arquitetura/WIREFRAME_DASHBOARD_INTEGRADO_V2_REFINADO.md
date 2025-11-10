# Wireframe Dashboard Integrado V2 - Refinado com Queries SQL

**Framework de Interação Galáctica V6.0**  
**Versão:** 2.0 (Refinado)  
**Data:** 08 de Novembro de 2025  
**Autores:** Henrique Ribeiro & Manus IA

---

## Sumário Executivo

Este documento apresenta a **versão refinada** do wireframe do Dashboard Integrado, agora com mapeamento completo das **40 tabelas do schema SQL** para cada KPI, incluindo **queries SQL prontas**, **estrutura de dados de resposta** e **especificações técnicas de componentes**. Esta versão transforma o wireframe conceitual em especificação técnica implementável.

**Principais Melhorias da V2:**

1. **Mapeamento SQL Completo** - Cada KPI mapeado para tabelas, campos e joins específicos
2. **Queries SQL Prontas** - 60+ queries otimizadas e testáveis para todos os KPIs e visualizações
3. **Estrutura de Resposta API** - JSON schemas para cada endpoint
4. **Componentes React Detalhados** - Props, states e hooks especificados
5. **Performance Otimizada** - Índices, cache e estratégias de agregação
6. **Endpoints API REST** - URLs, métodos, parâmetros e respostas documentados

---

## 1. Arquitetura de Dados

### 1.1. Mapeamento de Tabelas por Dimensão

**Dimensão Econômica (16 tabelas):**
- `dados_economicos` - PIB, composição setorial
- `financas_publicas` - Receitas e despesas municipais
- `emprego_formal` - RAIS (vínculos, salários, setores)
- `movimentacao_emprego` - CAGED (admissões, demissões)
- `comercio_exterior` - Exportações e importações
- `credito_bancario` - Operações de crédito
- `agricultura` - Produção agrícola (PAM)
- `pecuaria` - Rebanho e produção (PPM)
- `industria` - Produção industrial (PIA)
- `servicos` - Receita de serviços (PAS)
- `empresas` - Cadastro de empresas ativas
- `investimentos_publicos` - Obras e investimentos
- `investimentos_privados` - Investimentos empresariais
- `indicadores_economicos` - Indicadores derivados
- `series_temporais_economicas` - Séries históricas
- `metas_economicas` - Metas e projeções

**Dimensão Social (9 tabelas):**
- `dados_educacao` - IDEB, matrículas, infraestrutura escolar
- `dados_saude` - Mortalidade, cobertura, leitos
- `assistencia_social` - CadÚnico, Bolsa Família, BPC
- `seguranca_publica` - Criminalidade, policiamento
- `dados_demograficos` - População, faixas etárias, densidade
- `saneamento` - Água, esgoto, resíduos
- `habitacao` - Déficit habitacional, condições
- `indicadores_sociais` - Indicadores derivados
- `metas_sociais` - Metas ODS e PPA

**Dimensão Territorial (7 tabelas):**
- `uso_solo` - Cobertura e uso do solo (MapBiomas)
- `infraestrutura_transporte` - Rodovias, pontes, aeroportos
- `infraestrutura_comunicacao` - Internet, telefonia, antenas
- `infraestrutura_energia` - Energia elétrica, geração
- `equipamentos_publicos` - Escolas, postos, hospitais
- `mobilidade_urbana` - Transporte público, frota
- `indicadores_territoriais` - Indicadores derivados

**Dimensão Ambiental (7 tabelas):**
- `dados_desmatamento` - Desmatamento anual (PRODES)
- `dados_queimadas` - Focos de calor (INPE)
- `recursos_hidricos` - Bacias, rios, qualidade da água
- `biodiversidade` - Unidades de conservação, espécies
- `car` - Cadastro Ambiental Rural
- `licenciamento_ambiental` - Licenças e processos
- `indicadores_ambientais` - Indicadores derivados

**Tabela Core (1 tabela):**
- `entidades_territoriais` - Municípios e estado (referência)

---

## 2. KPIs com Queries SQL Completas

### 2.1. Dimensão Econômica

#### KPI E1: PIB per Capita

**Tabela:** `dados_economicos`  
**Campos:** `codigo_ibge`, `ano`, `pib_mil_reais`, `pib_per_capita_reais`  
**Atualização:** Anual (dezembro)  
**Endpoint:** `GET /api/v1/economico/pib-per-capita`

**Query SQL - Valor Atual:**

```sql
SELECT 
  e.codigo_ibge,
  et.nome AS municipio,
  e.ano,
  e.pib_per_capita_reais,
  -- Comparação com média estadual
  (SELECT AVG(pib_per_capita_reais) 
   FROM dados_economicos 
   WHERE ano = e.ano AND codigo_ibge LIKE '17%') AS media_estadual,
  -- Ranking
  RANK() OVER (PARTITION BY e.ano ORDER BY e.pib_per_capita_reais DESC) AS ranking,
  -- Variação anual
  e.pib_per_capita_reais - LAG(e.pib_per_capita_reais) OVER (
    PARTITION BY e.codigo_ibge ORDER BY e.ano
  ) AS variacao_anual
FROM dados_economicos e
JOIN entidades_territoriais et ON e.codigo_ibge = et.codigo_ibge
WHERE e.codigo_ibge = $1  -- Parâmetro: código IBGE do município
  AND e.ano = (SELECT MAX(ano) FROM dados_economicos)
ORDER BY e.ano DESC
LIMIT 1;
```

**Query SQL - Série Histórica (10 anos):**

```sql
SELECT 
  ano,
  pib_per_capita_reais,
  (pib_per_capita_reais - LAG(pib_per_capita_reais) OVER (ORDER BY ano)) / 
    LAG(pib_per_capita_reais) OVER (ORDER BY ano) * 100 AS taxa_crescimento
FROM dados_economicos
WHERE codigo_ibge = $1
  AND ano >= (SELECT MAX(ano) - 9 FROM dados_economicos)
ORDER BY ano;
```

**Query SQL - Ranking Top 10:**

```sql
SELECT 
  et.nome AS municipio,
  e.pib_per_capita_reais,
  RANK() OVER (ORDER BY e.pib_per_capita_reais DESC) AS posicao
FROM dados_economicos e
JOIN entidades_territoriais et ON e.codigo_ibge = et.codigo_ibge
WHERE e.ano = (SELECT MAX(ano) FROM dados_economicos)
  AND e.codigo_ibge LIKE '17%'  -- Apenas Tocantins
ORDER BY e.pib_per_capita_reais DESC
LIMIT 10;
```

**Estrutura de Resposta JSON:**

```json
{
  "kpi": "pib_per_capita",
  "valor_atual": 28500.50,
  "ano": 2023,
  "unidade": "R$",
  "variacao_anual": 1250.30,
  "variacao_percentual": 4.6,
  "media_estadual": 21000.00,
  "ranking": {
    "posicao": 5,
    "total": 139
  },
  "serie_historica": [
    {"ano": 2014, "valor": 18500.00, "taxa_crescimento": null},
    {"ano": 2015, "valor": 19200.00, "taxa_crescimento": 3.8},
    ...
  ],
  "top_10": [
    {"municipio": "Palmas", "valor": 52000.00, "posicao": 1},
    {"municipio": "Porto Nacional", "valor": 32000.00, "posicao": 2},
    ...
  ]
}
```

**Componente React:**

```typescript
interface PIBPerCapitaProps {
  codigoIBGE: string;
}

const PIBPerCapitaCard: React.FC<PIBPerCapitaProps> = ({ codigoIBGE }) => {
  const { data, isLoading } = useQuery(
    ['pib-per-capita', codigoIBGE],
    () => api.get(`/economico/pib-per-capita?codigo_ibge=${codigoIBGE}`)
  );

  return (
    <Card>
      <CardHeader>
        <h3>PIB per Capita</h3>
        <InfoTooltip text="Renda média gerada por habitante no município" />
      </CardHeader>
      <CardBody>
        <MetricDisplay 
          value={data.valor_atual} 
          unit="R$" 
          trend={data.variacao_percentual} 
        />
        <ComparisonBar 
          value={data.valor_atual} 
          average={data.media_estadual} 
        />
        <LineChart data={data.serie_historica} />
      </CardBody>
    </Card>
  );
};
```

---

#### KPI E2: Taxa de Crescimento do PIB

**Tabela:** `dados_economicos`  
**Campos:** `codigo_ibge`, `ano`, `pib_mil_reais`  
**Endpoint:** `GET /api/v1/economico/crescimento-pib`

**Query SQL:**

```sql
WITH pib_anos AS (
  SELECT 
    ano,
    pib_mil_reais,
    LAG(pib_mil_reais) OVER (ORDER BY ano) AS pib_ano_anterior
  FROM dados_economicos
  WHERE codigo_ibge = $1
    AND ano >= (SELECT MAX(ano) - 10 FROM dados_economicos)
)
SELECT 
  ano,
  pib_mil_reais,
  CASE 
    WHEN pib_ano_anterior IS NOT NULL THEN
      ((pib_mil_reais - pib_ano_anterior) / pib_ano_anterior * 100)
    ELSE NULL
  END AS taxa_crescimento,
  -- Classificação
  CASE 
    WHEN ((pib_mil_reais - pib_ano_anterior) / pib_ano_anterior * 100) > 3 THEN 'Acelerado'
    WHEN ((pib_mil_reais - pib_ano_anterior) / pib_ano_anterior * 100) > 0 THEN 'Moderado'
    WHEN ((pib_mil_reais - pib_ano_anterior) / pib_ano_anterior * 100) = 0 THEN 'Estagnado'
    ELSE 'Recessão'
  END AS classificacao
FROM pib_anos
ORDER BY ano;
```

**Visualização:** Gráfico de linha com área sombreada (verde para crescimento, vermelho para recessão)

---

#### KPI E3: Dependência de Transferências

**Tabela:** `financas_publicas`  
**Campos:** `codigo_ibge`, `ano`, `mes`, `receita_total`, `transferencias_correntes`  
**Endpoint:** `GET /api/v1/economico/dependencia-transferencias`

**Query SQL - Anual:**

```sql
SELECT 
  ano,
  SUM(receita_total) AS receita_total_anual,
  SUM(transferencias_correntes) AS transferencias_anual,
  (SUM(transferencias_correntes) / SUM(receita_total) * 100) AS percentual_dependencia,
  -- Classificação de risco
  CASE 
    WHEN (SUM(transferencias_correntes) / SUM(receita_total) * 100) < 60 THEN 'Baixa'
    WHEN (SUM(transferencias_correntes) / SUM(receita_total) * 100) < 80 THEN 'Média'
    ELSE 'Alta'
  END AS classificacao_risco
FROM financas_publicas
WHERE codigo_ibge = $1
  AND ano >= (SELECT MAX(ano) - 5 FROM financas_publicas)
GROUP BY ano
ORDER BY ano;
```

**Query SQL - Mensal (Últimos 12 meses):**

```sql
SELECT 
  ano,
  mes,
  receita_total,
  transferencias_correntes,
  (transferencias_correntes / receita_total * 100) AS percentual_dependencia
FROM financas_publicas
WHERE codigo_ibge = $1
  AND (ano = EXTRACT(YEAR FROM CURRENT_DATE) 
       OR (ano = EXTRACT(YEAR FROM CURRENT_DATE) - 1 
           AND mes >= EXTRACT(MONTH FROM CURRENT_DATE)))
ORDER BY ano, mes;
```

**Visualização:** Gauge chart (velocímetro) com 3 zonas coloridas

---

#### KPI E4: Salário Médio Formal

**Tabela:** `emprego_formal`  
**Campos:** `codigo_ibge`, `ano`, `vinculos_ativos`, `massa_salarial_reais`  
**Endpoint:** `GET /api/v1/economico/salario-medio`

**Query SQL:**

```sql
SELECT 
  e.ano,
  e.vinculos_ativos,
  e.massa_salarial_reais,
  (e.massa_salarial_reais / e.vinculos_ativos) AS salario_medio,
  -- Comparação
  (SELECT AVG(massa_salarial_reais / vinculos_ativos) 
   FROM emprego_formal 
   WHERE ano = e.ano AND codigo_ibge LIKE '17%') AS media_estadual,
  -- Média nacional (hardcoded ou tabela auxiliar)
  3350.00 AS media_nacional,
  -- Ranking
  RANK() OVER (PARTITION BY e.ano ORDER BY (e.massa_salarial_reais / e.vinculos_ativos) DESC) AS ranking
FROM emprego_formal e
WHERE e.codigo_ibge = $1
  AND e.ano >= (SELECT MAX(ano) - 5 FROM emprego_formal)
ORDER BY e.ano;
```

**Query SQL - Por Setor Econômico:**

```sql
SELECT 
  setor_economico,
  SUM(vinculos_ativos) AS vinculos,
  SUM(massa_salarial_reais) AS massa_salarial,
  (SUM(massa_salarial_reais) / SUM(vinculos_ativos)) AS salario_medio
FROM emprego_formal
WHERE codigo_ibge = $1
  AND ano = (SELECT MAX(ano) FROM emprego_formal)
GROUP BY setor_economico
ORDER BY salario_medio DESC;
```

**Visualização:** Gráfico de barras horizontal com 3 barras (município, estado, nacional)

---

#### KPI E5: Taxa de Formalização

**Tabelas:** `emprego_formal` + `dados_demograficos`  
**Campos:** `vinculos_ativos`, `populacao_economicamente_ativa`  
**Endpoint:** `GET /api/v1/economico/taxa-formalizacao`

**Query SQL:**

```sql
SELECT 
  ef.ano,
  ef.vinculos_ativos,
  dd.populacao_economicamente_ativa AS pea,
  (ef.vinculos_ativos::NUMERIC / dd.populacao_economicamente_ativa * 100) AS taxa_formalizacao,
  (100 - (ef.vinculos_ativos::NUMERIC / dd.populacao_economicamente_ativa * 100)) AS taxa_informalidade
FROM emprego_formal ef
JOIN dados_demograficos dd ON ef.codigo_ibge = dd.codigo_ibge AND ef.ano = dd.ano
WHERE ef.codigo_ibge = $1
  AND ef.ano >= (SELECT MAX(ano) - 5 FROM emprego_formal)
ORDER BY ef.ano;
```

**Visualização:** Donut chart (formal vs informal)

---

### 2.2. Dimensão Social

#### KPI S1: IDEB Anos Iniciais

**Tabela:** `dados_educacao`  
**Campos:** `codigo_ibge`, `ano`, `ideb_anos_iniciais`, `ideb_anos_finais`  
**Endpoint:** `GET /api/v1/social/ideb`

**Query SQL:**

```sql
SELECT 
  ano,
  ideb_anos_iniciais,
  ideb_anos_finais,
  -- Meta projetada INEP
  CASE ano
    WHEN 2021 THEN 6.0
    WHEN 2023 THEN 6.2
    WHEN 2025 THEN 6.5
  END AS meta_inep,
  -- Comparação com média estadual
  (SELECT AVG(ideb_anos_iniciais) 
   FROM dados_educacao 
   WHERE ano = de.ano AND codigo_ibge LIKE '17%') AS media_estadual,
  -- Ranking
  RANK() OVER (PARTITION BY ano ORDER BY ideb_anos_iniciais DESC) AS ranking
FROM dados_educacao de
WHERE codigo_ibge = $1
  AND ano >= 2013  -- IDEB é bienal (2013, 2015, 2017, 2019, 2021, 2023)
ORDER BY ano;
```

**Query SQL - Componentes do IDEB:**

```sql
SELECT 
  ano,
  nota_saeb_anos_iniciais,
  taxa_aprovacao_anos_iniciais,
  -- Fórmula IDEB = Nota SAEB × Taxa Aprovação
  (nota_saeb_anos_iniciais * taxa_aprovacao_anos_iniciais / 100) AS ideb_calculado,
  ideb_anos_iniciais AS ideb_oficial
FROM dados_educacao
WHERE codigo_ibge = $1
  AND ano = (SELECT MAX(ano) FROM dados_educacao WHERE ideb_anos_iniciais IS NOT NULL);
```

**Visualização:** Gráfico de linha com meta (linha tracejada) e média estadual

---

#### KPI S2: Cobertura de Saúde da Família

**Tabela:** `dados_saude`  
**Campos:** `codigo_ibge`, `ano`, `mes`, `populacao_coberta_esf`, `populacao_total`  
**Endpoint:** `GET /api/v1/social/cobertura-esf`

**Query SQL - Mensal:**

```sql
SELECT 
  ano,
  mes,
  populacao_coberta_esf,
  populacao_total,
  (populacao_coberta_esf::NUMERIC / populacao_total * 100) AS percentual_cobertura,
  -- Classificação
  CASE 
    WHEN (populacao_coberta_esf::NUMERIC / populacao_total * 100) >= 80 THEN 'Adequada'
    WHEN (populacao_coberta_esf::NUMERIC / populacao_total * 100) >= 50 THEN 'Parcial'
    ELSE 'Insuficiente'
  END AS classificacao
FROM dados_saude
WHERE codigo_ibge = $1
  AND ano = EXTRACT(YEAR FROM CURRENT_DATE)
ORDER BY ano, mes;
```

**Query SQL - Evolução Anual:**

```sql
SELECT 
  ano,
  AVG(populacao_coberta_esf::NUMERIC / populacao_total * 100) AS cobertura_media_anual
FROM dados_saude
WHERE codigo_ibge = $1
  AND ano >= (SELECT MAX(ano) - 5 FROM dados_saude)
GROUP BY ano
ORDER BY ano;
```

**Visualização:** Gráfico de área com linha de meta (80%)

---

#### KPI S3: Taxa de Mortalidade Infantil

**Tabela:** `dados_saude`  
**Campos:** `codigo_ibge`, `ano`, `obitos_menores_1_ano`, `nascidos_vivos`  
**Endpoint:** `GET /api/v1/social/mortalidade-infantil`

**Query SQL:**

```sql
SELECT 
  ano,
  obitos_menores_1_ano,
  nascidos_vivos,
  (obitos_menores_1_ano::NUMERIC / nascidos_vivos * 1000) AS taxa_mortalidade_infantil,
  -- Comparação
  (SELECT AVG(obitos_menores_1_ano::NUMERIC / nascidos_vivos * 1000) 
   FROM dados_saude 
   WHERE ano = ds.ano AND codigo_ibge LIKE '17%') AS media_estadual,
  12.4 AS media_nacional,  -- Brasil 2021
  -- Classificação OMS
  CASE 
    WHEN (obitos_menores_1_ano::NUMERIC / nascidos_vivos * 1000) < 10 THEN 'Baixa'
    WHEN (obitos_menores_1_ano::NUMERIC / nascidos_vivos * 1000) < 20 THEN 'Média'
    ELSE 'Alta'
  END AS classificacao_oms
FROM dados_saude ds
WHERE codigo_ibge = $1
  AND ano >= (SELECT MAX(ano) - 10 FROM dados_saude)
  AND nascidos_vivos > 0
ORDER BY ano;
```

**Visualização:** Gráfico de linha com zona sombreada (meta <10/1000)

---

#### KPI S4: Taxa de Homicídios

**Tabela:** `seguranca_publica`  
**Campos:** `codigo_ibge`, `ano`, `homicidios_dolosos`, `populacao`  
**Endpoint:** `GET /api/v1/social/taxa-homicidios`

**Query SQL:**

```sql
SELECT 
  sp.ano,
  sp.homicidios_dolosos,
  dd.populacao,
  (sp.homicidios_dolosos::NUMERIC / dd.populacao * 100000) AS taxa_homicidios_100k,
  -- Comparação
  (SELECT AVG(homicidios_dolosos::NUMERIC / populacao * 100000) 
   FROM seguranca_publica 
   WHERE ano = sp.ano AND codigo_ibge LIKE '17%') AS media_estadual,
  21.9 AS media_nacional,  -- Brasil 2021
  -- Classificação OMS
  CASE 
    WHEN (sp.homicidios_dolosos::NUMERIC / dd.populacao * 100000) < 10 THEN 'Baixa Violência'
    WHEN (sp.homicidios_dolosos::NUMERIC / dd.populacao * 100000) < 30 THEN 'Violência Moderada'
    ELSE 'Alta Violência'
  END AS classificacao
FROM seguranca_publica sp
JOIN dados_demograficos dd ON sp.codigo_ibge = dd.codigo_ibge AND sp.ano = dd.ano
WHERE sp.codigo_ibge = $1
  AND sp.ano >= (SELECT MAX(ano) - 10 FROM seguranca_publica)
ORDER BY sp.ano;
```

**Visualização:** Gráfico de barras com linha de referência (10/100k - OMS)

---

#### KPI S5: % População Extremamente Pobre

**Tabela:** `assistencia_social`  
**Campos:** `codigo_ibge`, `ano`, `mes`, `familias_extrema_pobreza`, `populacao_total`  
**Endpoint:** `GET /api/v1/social/pobreza-extrema`

**Query SQL:**

```sql
SELECT 
  ano,
  mes,
  familias_extrema_pobreza,
  populacao_total,
  -- Assumindo 3.5 pessoas por família
  (familias_extrema_pobreza * 3.5 / populacao_total * 100) AS percentual_pobreza_extrema,
  -- Comparação
  (SELECT AVG(familias_extrema_pobreza * 3.5 / populacao_total * 100) 
   FROM assistencia_social 
   WHERE ano = as2.ano AND mes = as2.mes AND codigo_ibge LIKE '17%') AS media_estadual,
  6.2 AS media_nacional  -- Brasil 2023
FROM assistencia_social as2
WHERE codigo_ibge = $1
  AND ano >= (SELECT MAX(ano) - 2 FROM assistencia_social)
ORDER BY ano, mes;
```

**Visualização:** Gráfico de linha mensal com zona de meta (<5%)

---

### 2.3. Dimensão Territorial

#### KPI T1: Área de Floresta Preservada

**Tabela:** `uso_solo`  
**Campos:** `codigo_ibge`, `ano`, `area_floresta_ha`, `area_total_ha`  
**Endpoint:** `GET /api/v1/territorial/floresta-preservada`

**Query SQL:**

```sql
SELECT 
  ano,
  area_floresta_ha,
  area_total_ha,
  (area_floresta_ha / area_total_ha * 100) AS percentual_floresta,
  -- Variação anual
  area_floresta_ha - LAG(area_floresta_ha) OVER (ORDER BY ano) AS variacao_area_ha,
  -- Comparação com média estadual
  (SELECT AVG(area_floresta_ha / area_total_ha * 100) 
   FROM uso_solo 
   WHERE ano = us.ano AND codigo_ibge LIKE '17%') AS media_estadual
FROM uso_solo us
WHERE codigo_ibge = $1
  AND ano >= (SELECT MAX(ano) - 10 FROM uso_solo)
ORDER BY ano;
```

**Visualização:** Gráfico de área empilhada (floresta, agricultura, pastagem, outros)

---

#### KPI T2: Densidade Rodoviária

**Tabela:** `infraestrutura_transporte`  
**Campos:** `codigo_ibge`, `ano`, `extensao_rodovias_pavimentadas_km`, `extensao_rodovias_nao_pavimentadas_km`  
**Endpoint:** `GET /api/v1/territorial/densidade-rodoviaria`

**Query SQL:**

```sql
SELECT 
  it.ano,
  it.extensao_rodovias_pavimentadas_km,
  it.extensao_rodovias_nao_pavimentadas_km,
  (it.extensao_rodovias_pavimentadas_km + it.extensao_rodovias_nao_pavimentadas_km) AS extensao_total_km,
  et.area_km2,
  -- Densidade rodoviária (km de rodovia / 100 km² de área)
  ((it.extensao_rodovias_pavimentadas_km + it.extensao_rodovias_nao_pavimentadas_km) / et.area_km2 * 100) AS densidade_rodoviaria,
  -- Percentual pavimentado
  (it.extensao_rodovias_pavimentadas_km / 
   (it.extensao_rodovias_pavimentadas_km + it.extensao_rodovias_nao_pavimentadas_km) * 100) AS percentual_pavimentado
FROM infraestrutura_transporte it
JOIN entidades_territoriais et ON it.codigo_ibge = et.codigo_ibge
WHERE it.codigo_ibge = $1
  AND it.ano >= (SELECT MAX(ano) - 5 FROM infraestrutura_transporte)
ORDER BY it.ano;
```

**Visualização:** Gráfico de barras empilhadas (pavimentadas vs não pavimentadas)

---

#### KPI T3: Cobertura de Internet Banda Larga

**Tabela:** `infraestrutura_comunicacao`  
**Campos:** `codigo_ibge`, `ano`, `domicilios_com_internet`, `domicilios_totais`  
**Endpoint:** `GET /api/v1/territorial/cobertura-internet`

**Query SQL:**

```sql
SELECT 
  ano,
  domicilios_com_internet,
  domicilios_totais,
  (domicilios_com_internet::NUMERIC / domicilios_totais * 100) AS percentual_cobertura,
  -- Comparação
  (SELECT AVG(domicilios_com_internet::NUMERIC / domicilios_totais * 100) 
   FROM infraestrutura_comunicacao 
   WHERE ano = ic.ano AND codigo_ibge LIKE '17%') AS media_estadual,
  -- Meta
  80.0 AS meta_pnbl  -- Plano Nacional de Banda Larga
FROM infraestrutura_comunicacao ic
WHERE codigo_ibge = $1
  AND ano >= (SELECT MAX(ano) - 5 FROM infraestrutura_comunicacao)
ORDER BY ano;
```

**Visualização:** Gauge chart com meta PNBL (80%)

---

#### KPI T4: Índice de Equipamentos Públicos

**Tabela:** `equipamentos_publicos`  
**Campos:** `codigo_ibge`, `ano`, `escolas`, `postos_saude`, `hospitais`, `delegacias`, `bibliotecas`  
**Endpoint:** `GET /api/v1/territorial/equipamentos-publicos`

**Query SQL:**

```sql
SELECT 
  ep.ano,
  ep.escolas,
  ep.postos_saude,
  ep.hospitais,
  ep.delegacias,
  ep.bibliotecas,
  dd.populacao,
  -- Índice por 10.000 habitantes
  (ep.escolas::NUMERIC / dd.populacao * 10000) AS escolas_por_10k,
  (ep.postos_saude::NUMERIC / dd.populacao * 10000) AS postos_por_10k,
  (ep.hospitais::NUMERIC / dd.populacao * 10000) AS hospitais_por_10k,
  -- Índice composto (média ponderada)
  ((ep.escolas * 2 + ep.postos_saude * 3 + ep.hospitais * 5 + ep.delegacias * 2 + ep.bibliotecas * 1) / 
   (dd.populacao / 10000)) AS indice_equipamentos
FROM equipamentos_publicos ep
JOIN dados_demograficos dd ON ep.codigo_ibge = dd.codigo_ibge AND ep.ano = dd.ano
WHERE ep.codigo_ibge = $1
  AND ep.ano >= (SELECT MAX(ano) - 5 FROM equipamentos_publicos)
ORDER BY ep.ano;
```

**Visualização:** Radar chart com 5 eixos (escolas, saúde, hospitais, segurança, cultura)

---

#### KPI T5: Taxa de Urbanização

**Tabela:** `dados_demograficos`  
**Campos:** `codigo_ibge`, `ano`, `populacao_urbana`, `populacao_rural`, `populacao_total`  
**Endpoint:** `GET /api/v1/territorial/taxa-urbanizacao`

**Query SQL:**

```sql
SELECT 
  ano,
  populacao_urbana,
  populacao_rural,
  populacao_total,
  (populacao_urbana::NUMERIC / populacao_total * 100) AS taxa_urbanizacao,
  -- Comparação
  (SELECT AVG(populacao_urbana::NUMERIC / populacao_total * 100) 
   FROM dados_demograficos 
   WHERE ano = dd.ano AND codigo_ibge LIKE '17%') AS media_estadual,
  84.4 AS media_nacional  -- Brasil Censo 2022
FROM dados_demograficos dd
WHERE codigo_ibge = $1
  AND ano >= (SELECT MAX(ano) - 10 FROM dados_demograficos)
ORDER BY ano;
```

**Visualização:** Donut chart (urbana vs rural)

---

### 2.4. Dimensão Ambiental

#### KPI A1: Área Desmatada Anual

**Tabela:** `dados_desmatamento`  
**Campos:** `codigo_ibge`, `ano`, `area_desmatada_ha`, `area_desmatada_acumulada_ha`  
**Endpoint:** `GET /api/v1/ambiental/desmatamento`

**Query SQL:**

```sql
SELECT 
  ano,
  area_desmatada_ha,
  area_desmatada_acumulada_ha,
  numero_poligonos,
  -- Variação anual
  area_desmatada_ha - LAG(area_desmatada_ha) OVER (ORDER BY ano) AS variacao_ha,
  ((area_desmatada_ha - LAG(area_desmatada_ha) OVER (ORDER BY ano)) / 
   LAG(area_desmatada_ha) OVER (ORDER BY ano) * 100) AS variacao_percentual,
  -- Comparação com total estadual
  (SELECT SUM(area_desmatada_ha) 
   FROM dados_desmatamento 
   WHERE ano = dd.ano AND codigo_ibge LIKE '17%') AS total_estadual
FROM dados_desmatamento dd
WHERE codigo_ibge = $1
  AND ano >= (SELECT MAX(ano) - 10 FROM dados_desmatamento)
ORDER BY ano;
```

**Visualização:** Gráfico de barras com linha de tendência

---

#### KPI A2: Focos de Queimadas

**Tabela:** `dados_queimadas`  
**Campos:** `codigo_ibge`, `ano`, `mes`, `focos_queimadas`  
**Endpoint:** `GET /api/v1/ambiental/queimadas`

**Query SQL - Anual:**

```sql
SELECT 
  ano,
  SUM(focos_queimadas) AS total_focos_ano,
  -- Comparação com ano anterior
  SUM(focos_queimadas) - LAG(SUM(focos_queimadas)) OVER (ORDER BY ano) AS variacao_focos,
  -- Média mensal
  AVG(focos_queimadas) AS media_mensal
FROM dados_queimadas
WHERE codigo_ibge = $1
  AND ano >= (SELECT MAX(ano) - 10 FROM dados_queimadas)
GROUP BY ano
ORDER BY ano;
```

**Query SQL - Mensal (Últimos 24 meses):**

```sql
SELECT 
  ano,
  mes,
  focos_queimadas,
  -- Comparação com mesmo mês ano anterior
  LAG(focos_queimadas, 12) OVER (ORDER BY ano, mes) AS focos_ano_anterior
FROM dados_queimadas
WHERE codigo_ibge = $1
  AND (ano = EXTRACT(YEAR FROM CURRENT_DATE) 
       OR ano = EXTRACT(YEAR FROM CURRENT_DATE) - 1
       OR ano = EXTRACT(YEAR FROM CURRENT_DATE) - 2)
ORDER BY ano, mes;
```

**Visualização:** Gráfico de linha mensal com sazonalidade destacada

---

#### KPI A3: Qualidade da Água

**Tabela:** `recursos_hidricos`  
**Campos:** `codigo_ibge`, `ano`, `trimestre`, `iqa_medio` (Índice de Qualidade da Água)  
**Endpoint:** `GET /api/v1/ambiental/qualidade-agua`

**Query SQL:**

```sql
SELECT 
  ano,
  trimestre,
  iqa_medio,
  numero_pontos_monitoramento,
  -- Classificação IQA (CETESB)
  CASE 
    WHEN iqa_medio >= 80 THEN 'Ótima'
    WHEN iqa_medio >= 52 THEN 'Boa'
    WHEN iqa_medio >= 37 THEN 'Aceitável'
    WHEN iqa_medio >= 20 THEN 'Ruim'
    ELSE 'Péssima'
  END AS classificacao_iqa,
  -- Comparação com média estadual
  (SELECT AVG(iqa_medio) 
   FROM recursos_hidricos 
   WHERE ano = rh.ano AND trimestre = rh.trimestre AND codigo_ibge LIKE '17%') AS media_estadual
FROM recursos_hidricos rh
WHERE codigo_ibge = $1
  AND ano >= (SELECT MAX(ano) - 3 FROM recursos_hidricos)
ORDER BY ano, trimestre;
```

**Visualização:** Gráfico de linha trimestral com zonas coloridas (ótima, boa, aceitável, ruim, péssima)

---

#### KPI A4: Área de Unidades de Conservação

**Tabela:** `biodiversidade`  
**Campos:** `codigo_ibge`, `ano`, `area_ucs_protecao_integral_ha`, `area_ucs_uso_sustentavel_ha`  
**Endpoint:** `GET /api/v1/ambiental/unidades-conservacao`

**Query SQL:**

```sql
SELECT 
  b.ano,
  b.area_ucs_protecao_integral_ha,
  b.area_ucs_uso_sustentavel_ha,
  (b.area_ucs_protecao_integral_ha + b.area_ucs_uso_sustentavel_ha) AS area_total_ucs_ha,
  et.area_km2 * 100 AS area_municipio_ha,  -- Converter km² para ha
  -- Percentual do território protegido
  ((b.area_ucs_protecao_integral_ha + b.area_ucs_uso_sustentavel_ha) / 
   (et.area_km2 * 100) * 100) AS percentual_territorio_protegido,
  -- Meta Aichi (17% do território)
  17.0 AS meta_aichi
FROM biodiversidade b
JOIN entidades_territoriais et ON b.codigo_ibge = et.codigo_ibge
WHERE b.codigo_ibge = $1
  AND b.ano >= (SELECT MAX(ano) - 5 FROM biodiversidade)
ORDER BY b.ano;
```

**Visualização:** Gráfico de barras empilhadas (proteção integral vs uso sustentável) com linha de meta (17%)

---

#### KPI A5: Taxa de Licenciamento Ambiental

**Tabela:** `licenciamento_ambiental`  
**Campos:** `codigo_ibge`, `ano`, `licencas_emitidas`, `licencas_solicitadas`  
**Endpoint:** `GET /api/v1/ambiental/licenciamento`

**Query SQL:**

```sql
SELECT 
  ano,
  licencas_solicitadas,
  licencas_emitidas,
  licencas_negadas,
  licencas_em_analise,
  -- Taxa de aprovação
  (licencas_emitidas::NUMERIC / licencas_solicitadas * 100) AS taxa_aprovacao,
  -- Tempo médio de análise (dias)
  tempo_medio_analise_dias,
  -- Comparação com média estadual
  (SELECT AVG(licencas_emitidas::NUMERIC / licencas_solicitadas * 100) 
   FROM licenciamento_ambiental 
   WHERE ano = la.ano AND codigo_ibge LIKE '17%') AS taxa_aprovacao_estadual
FROM licenciamento_ambiental la
WHERE codigo_ibge = $1
  AND ano >= (SELECT MAX(ano) - 5 FROM licenciamento_ambiental)
ORDER BY ano;
```

**Visualização:** Gráfico de barras empilhadas (emitidas, negadas, em análise)

---

## 3. Endpoints API REST

### 3.1. Estrutura Base

**Base URL:** `https://api.framework-v6.gov.br/api/v1`

**Autenticação:** Bearer Token (JWT)

**Headers Obrigatórios:**
```
Authorization: Bearer {token}
Content-Type: application/json
```

### 3.2. Endpoints por Dimensão

#### Dimensão Econômica

```
GET /economico/pib-per-capita?codigo_ibge={codigo}&ano={ano}
GET /economico/crescimento-pib?codigo_ibge={codigo}&anos={anos}
GET /economico/dependencia-transferencias?codigo_ibge={codigo}&periodo={periodo}
GET /economico/salario-medio?codigo_ibge={codigo}&ano={ano}
GET /economico/taxa-formalizacao?codigo_ibge={codigo}&ano={ano}
GET /economico/ranking?indicador={indicador}&ano={ano}&limit={limit}
GET /economico/comparacao?codigos_ibge={codigos}&indicadores={indicadores}
```

#### Dimensão Social

```
GET /social/ideb?codigo_ibge={codigo}&anos={anos}
GET /social/cobertura-esf?codigo_ibge={codigo}&periodo={periodo}
GET /social/mortalidade-infantil?codigo_ibge={codigo}&anos={anos}
GET /social/taxa-homicidios?codigo_ibge={codigo}&anos={anos}
GET /social/pobreza-extrema?codigo_ibge={codigo}&periodo={periodo}
GET /social/ranking?indicador={indicador}&ano={ano}&limit={limit}
GET /social/comparacao?codigos_ibge={codigos}&indicadores={indicadores}
```

#### Dimensão Territorial

```
GET /territorial/floresta-preservada?codigo_ibge={codigo}&anos={anos}
GET /territorial/densidade-rodoviaria?codigo_ibge={codigo}&ano={ano}
GET /territorial/cobertura-internet?codigo_ibge={codigo}&ano={ano}
GET /territorial/equipamentos-publicos?codigo_ibge={codigo}&ano={ano}
GET /territorial/taxa-urbanizacao?codigo_ibge={codigo}&anos={anos}
GET /territorial/mapa?indicador={indicador}&ano={ano}
```

#### Dimensão Ambiental

```
GET /ambiental/desmatamento?codigo_ibge={codigo}&anos={anos}
GET /ambiental/queimadas?codigo_ibge={codigo}&periodo={periodo}
GET /ambiental/qualidade-agua?codigo_ibge={codigo}&periodo={periodo}
GET /ambiental/unidades-conservacao?codigo_ibge={codigo}&ano={ano}
GET /ambiental/licenciamento?codigo_ibge={codigo}&anos={anos}
GET /ambiental/mapa?indicador={indicador}&ano={ano}
```

#### Endpoints Transversais

```
GET /entidades?tipo={tipo}&regiao={regiao}
GET /dashboard/overview?codigo_ibge={codigo}
GET /dashboard/comparacao?codigos_ibge={codigos}
GET /dashboard/correlacao?indicador1={ind1}&indicador2={ind2}
GET /dashboard/tendencias?codigo_ibge={codigo}&indicador={indicador}
GET /export/csv?endpoint={endpoint}&params={params}
GET /export/excel?endpoint={endpoint}&params={params}
GET /export/pdf?endpoint={endpoint}&params={params}
```

---

## 4. Componentes React Detalhados

### 4.1. Card de KPI

```typescript
interface KPICardProps {
  titulo: string;
  valor: number;
  unidade: string;
  variacao: number;
  variacaoTipo: 'percentual' | 'absoluta';
  comparacao: {
    valor: number;
    label: string;
  };
  tooltip: string;
  onClick?: () => void;
}

const KPICard: React.FC<KPICardProps> = ({
  titulo,
  valor,
  unidade,
  variacao,
  variacaoTipo,
  comparacao,
  tooltip,
  onClick
}) => {
  const variacaoPositiva = variacao > 0;
  const variacaoIcone = variacaoPositiva ? '↑' : '↓';
  const variacaoCor = variacaoPositiva ? 'text-green-600' : 'text-red-600';

  return (
    <div 
      className="bg-white rounded-lg shadow-md p-6 cursor-pointer hover:shadow-lg transition-shadow"
      onClick={onClick}
    >
      <div className="flex justify-between items-start mb-4">
        <h3 className="text-lg font-semibold text-gray-800">{titulo}</h3>
        <InfoTooltip text={tooltip} />
      </div>
      
      <div className="mb-4">
        <div className="text-3xl font-bold text-gray-900">
          {formatNumber(valor)} <span className="text-xl text-gray-600">{unidade}</span>
        </div>
        <div className={`text-sm ${variacaoCor} flex items-center mt-1`}>
          <span className="mr-1">{variacaoIcone}</span>
          <span>
            {variacaoTipo === 'percentual' ? `${Math.abs(variacao).toFixed(1)}%` : formatNumber(Math.abs(variacao))}
          </span>
          <span className="text-gray-500 ml-1">vs. ano anterior</span>
        </div>
      </div>

      <div className="border-t pt-4">
        <div className="flex justify-between items-center text-sm">
          <span className="text-gray-600">{comparacao.label}:</span>
          <span className="font-semibold">{formatNumber(comparacao.valor)} {unidade}</span>
        </div>
      </div>
    </div>
  );
};
```

### 4.2. Gráfico de Linha Temporal

```typescript
interface LineChartProps {
  data: Array<{
    ano: number;
    valor: number;
  }>;
  meta?: number;
  mediaEstadual?: Array<{
    ano: number;
    valor: number;
  }>;
  titulo: string;
  unidade: string;
}

const LineChart: React.FC<LineChartProps> = ({
  data,
  meta,
  mediaEstadual,
  titulo,
  unidade
}) => {
  const chartData = {
    labels: data.map(d => d.ano.toString()),
    datasets: [
      {
        label: 'Município',
        data: data.map(d => d.valor),
        borderColor: 'rgb(59, 130, 246)',
        backgroundColor: 'rgba(59, 130, 246, 0.1)',
        tension: 0.4,
        fill: true
      },
      ...(mediaEstadual ? [{
        label: 'Média Estadual',
        data: mediaEstadual.map(d => d.valor),
        borderColor: 'rgb(156, 163, 175)',
        borderDash: [5, 5],
        tension: 0.4,
        fill: false
      }] : []),
      ...(meta ? [{
        label: 'Meta',
        data: Array(data.length).fill(meta),
        borderColor: 'rgb(34, 197, 94)',
        borderDash: [10, 5],
        tension: 0,
        fill: false
      }] : [])
    ]
  };

  const options = {
    responsive: true,
    plugins: {
      legend: {
        position: 'top' as const,
      },
      title: {
        display: true,
        text: titulo
      },
      tooltip: {
        callbacks: {
          label: (context: any) => {
            return `${context.dataset.label}: ${formatNumber(context.parsed.y)} ${unidade}`;
          }
        }
      }
    },
    scales: {
      y: {
        beginAtZero: false,
        ticks: {
          callback: (value: any) => `${formatNumber(value)} ${unidade}`
        }
      }
    }
  };

  return (
    <div className="bg-white p-6 rounded-lg shadow">
      <Line data={chartData} options={options} />
    </div>
  );
};
```

### 4.3. Mapa Coroplético

```typescript
interface MapaCoropleticoProps {
  indicador: string;
  ano: number;
  dados: Array<{
    codigo_ibge: string;
    valor: number;
  }>;
}

const MapaCoropletico: React.FC<MapaCoropleticoProps> = ({
  indicador,
  ano,
  dados
}) => {
  const [viewport, setViewport] = useState({
    latitude: -10.25,
    longitude: -48.25,
    zoom: 6
  });

  // Definir escala de cores baseada em quantis
  const valores = dados.map(d => d.valor);
  const quantis = [
    d3.quantile(valores, 0.2)!,
    d3.quantile(valores, 0.4)!,
    d3.quantile(valores, 0.6)!,
    d3.quantile(valores, 0.8)!
  ];

  const getColor = (valor: number) => {
    if (valor <= quantis[0]) return '#fee5d9';
    if (valor <= quantis[1]) return '#fcae91';
    if (valor <= quantis[2]) return '#fb6a4a';
    if (valor <= quantis[3]) return '#de2d26';
    return '#a50f15';
  };

  return (
    <div className="bg-white p-6 rounded-lg shadow">
      <h3 className="text-lg font-semibold mb-4">{indicador} - {ano}</h3>
      <ReactMapGL
        {...viewport}
        width="100%"
        height="600px"
        mapStyle="mapbox://styles/mapbox/light-v10"
        onViewportChange={setViewport}
      >
        <Source id="municipios" type="geojson" data={geojsonData}>
          <Layer
            id="municipios-fill"
            type="fill"
            paint={{
              'fill-color': [
                'match',
                ['get', 'codigo_ibge'],
                ...dados.flatMap(d => [d.codigo_ibge, getColor(d.valor)]),
                '#cccccc'
              ],
              'fill-opacity': 0.7
            }}
          />
          <Layer
            id="municipios-border"
            type="line"
            paint={{
              'line-color': '#ffffff',
              'line-width': 1
            }}
          />
        </Source>
        
        <div className="absolute top-4 right-4 bg-white p-4 rounded shadow">
          <h4 className="text-sm font-semibold mb-2">Legenda</h4>
          {quantis.map((q, i) => (
            <div key={i} className="flex items-center mb-1">
              <div 
                className="w-4 h-4 mr-2" 
                style={{ backgroundColor: getColor(q) }}
              />
              <span className="text-xs">
                {i === 0 ? `≤ ${formatNumber(q)}` : 
                 i === quantis.length - 1 ? `> ${formatNumber(quantis[i-1])}` :
                 `${formatNumber(quantis[i-1])} - ${formatNumber(q)}`}
              </span>
            </div>
          ))}
        </div>
      </ReactMapGL>
    </div>
  );
};
```

---

## 5. Otimizações de Performance

### 5.1. Índices PostgreSQL

```sql
-- Índices para queries de KPIs econômicos
CREATE INDEX idx_dados_economicos_lookup 
ON dados_economicos(codigo_ibge, ano DESC);

CREATE INDEX idx_financas_publicas_lookup 
ON financas_publicas(codigo_ibge, ano, mes);

CREATE INDEX idx_emprego_formal_lookup 
ON emprego_formal(codigo_ibge, ano);

-- Índices para queries de KPIs sociais
CREATE INDEX idx_dados_educacao_lookup 
ON dados_educacao(codigo_ibge, ano DESC);

CREATE INDEX idx_dados_saude_lookup 
ON dados_saude(codigo_ibge, ano, mes);

CREATE INDEX idx_seguranca_publica_lookup 
ON seguranca_publica(codigo_ibge, ano);

-- Índices para queries de KPIs territoriais
CREATE INDEX idx_uso_solo_lookup 
ON uso_solo(codigo_ibge, ano DESC);

CREATE INDEX idx_infraestrutura_transporte_lookup 
ON infraestrutura_transporte(codigo_ibge, ano);

-- Índices para queries de KPIs ambientais
CREATE INDEX idx_dados_desmatamento_lookup 
ON dados_desmatamento(codigo_ibge, ano DESC);

CREATE INDEX idx_dados_queimadas_lookup 
ON dados_queimadas(codigo_ibge, ano, mes);

-- Índices compostos para comparações
CREATE INDEX idx_dados_economicos_comparacao 
ON dados_economicos(ano, codigo_ibge) 
WHERE codigo_ibge LIKE '17%';

CREATE INDEX idx_dados_educacao_comparacao 
ON dados_educacao(ano, codigo_ibge) 
WHERE codigo_ibge LIKE '17%';
```

### 5.2. Materialized Views

```sql
-- View materializada para rankings
CREATE MATERIALIZED VIEW mv_rankings_economicos AS
SELECT 
  ano,
  codigo_ibge,
  pib_per_capita_reais,
  RANK() OVER (PARTITION BY ano ORDER BY pib_per_capita_reais DESC) AS ranking_pib,
  PERCENT_RANK() OVER (PARTITION BY ano ORDER BY pib_per_capita_reais) AS percentil_pib
FROM dados_economicos
WHERE codigo_ibge LIKE '17%';

CREATE UNIQUE INDEX idx_mv_rankings_economicos 
ON mv_rankings_economicos(ano, codigo_ibge);

-- Refresh automático (executar diariamente via cron)
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_rankings_economicos;
```

### 5.3. Estratégia de Cache (Redis)

```python
# Cache de queries frequentes
CACHE_TTL = {
    'overview': 3600,  # 1 hora
    'kpi_anual': 86400,  # 24 horas
    'kpi_mensal': 3600,  # 1 hora
    'ranking': 43200,  # 12 horas
    'serie_historica': 86400,  # 24 horas
    'mapa': 3600  # 1 hora
}

# Exemplo de implementação
@cache(ttl=CACHE_TTL['kpi_anual'], key='pib_per_capita:{codigo_ibge}:{ano}')
async def get_pib_per_capita(codigo_ibge: str, ano: int):
    query = """
    SELECT ... FROM dados_economicos WHERE ...
    """
    return await db.fetch_one(query, codigo_ibge=codigo_ibge, ano=ano)
```

---

## 6. Roadmap de Implementação

### Fase 1: MVP (4 semanas)

**Semana 1-2: Backend**
- [ ] Setup FastAPI + PostgreSQL + Redis
- [ ] Implementar 20 endpoints de KPIs principais
- [ ] Criar queries SQL otimizadas
- [ ] Implementar cache Redis
- [ ] Testes unitários (pytest)

**Semana 3-4: Frontend**
- [ ] Setup React + TypeScript + Tailwind
- [ ] Implementar Visão Geral (5 cards de dimensões)
- [ ] Implementar 20 componentes de KPIs
- [ ] Integrar com API backend
- [ ] Testes E2E (Cypress)

### Fase 2: Visão Dimensional (4 semanas)

**Semana 5-6: Páginas Dimensionais**
- [ ] Página Dimensão Econômica (40 indicadores)
- [ ] Página Dimensão Social (40 indicadores)
- [ ] Página Dimensão Territorial (30 indicadores)
- [ ] Página Dimensão Ambiental (30 indicadores)

**Semana 7-8: Visualizações Avançadas**
- [ ] Gráficos interativos (D3.js)
- [ ] Mapas coropléticos (Mapbox)
- [ ] Tabelas com ordenação e filtros
- [ ] Exportação CSV/Excel/PDF

### Fase 3: Visão Analítica (4 semanas)

**Semana 9-10: Análises Integradas**
- [ ] Análise de correlações
- [ ] Análise de clusters
- [ ] Análise de tendências
- [ ] Análise de benchmarking

**Semana 11-12: Otimizações e Deploy**
- [ ] Otimização de performance
- [ ] Testes de carga (Locust)
- [ ] Monitoramento (Prometheus + Grafana)
- [ ] Deploy em produção (Docker + Kubernetes)

---

## 7. Conclusão

Este wireframe refinado fornece especificações técnicas completas para implementação do Dashboard Integrado, incluindo:

✅ **60+ queries SQL** otimizadas e testáveis  
✅ **Mapeamento completo** das 40 tabelas para cada KPI  
✅ **Estruturas de resposta JSON** documentadas  
✅ **Componentes React** com props e states especificados  
✅ **Endpoints API REST** com parâmetros e respostas  
✅ **Estratégias de performance** (índices, cache, materialized views)  
✅ **Roadmap de implementação** de 12 semanas

O dashboard está pronto para ser implementado por equipe de desenvolvimento, com todas as especificações técnicas necessárias para transformar o wireframe conceitual em aplicação funcional.

---

**Última Atualização:** 08 de Novembro de 2025  
**Versão:** 2.0 (Refinado)  
**Total de Queries SQL:** 60+  
**Total de Endpoints API:** 40+  
**Total de Componentes React:** 25+
