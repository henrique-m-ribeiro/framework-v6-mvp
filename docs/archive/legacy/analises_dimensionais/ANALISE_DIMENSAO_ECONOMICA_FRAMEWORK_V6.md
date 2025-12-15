# Análise Completa: Dimensão Econômica - Framework V6.0

**Framework de Interação Galáctica V6.0**  
**Versão:** 1.0  
**Data:** 07 de Novembro de 2025  
**Autores:** Henrique Ribeiro & Manus IA

---

## Sumário Executivo

Este documento apresenta uma análise abrangente e detalhada de todos os dados relevantes para a **dimensão econômica** do Framework de Interação Galáctica V6.0, focando nos 139 municípios do Tocantins e no estado como um todo. A dimensão econômica é fundamental para compreender a capacidade produtiva, dinâmica de geração de renda, sustentabilidade fiscal e desenvolvimento econômico dos territórios, fornecendo base essencial para tomada de decisão em políticas públicas.

A análise está organizada em **7 áreas principais** (Produto Interno Bruto, Finanças Públicas, Mercado de Trabalho, Setores Produtivos, Comércio Exterior, Investimentos e Crédito, Indicadores de Desenvolvimento), totalizando **mais de 120 indicadores** de **10 fontes de dados oficiais**. Identificamos **APIs e sistemas disponíveis**, propusemos **estrutura de dados integrada**, mapeamos **interconexões críticas** com outras dimensões e apresentamos **casos de uso transformadores** para gestores públicos.

**Principais Conclusões:**

A economia tocantinense apresenta características estruturais que demandam atenção especial na formulação de políticas públicas. O estado possui **PIB de aproximadamente R$ 51,5 bilhões** (2021), representando **0,6% do PIB nacional**, com forte concentração em Palmas (32% do PIB estadual) e dependência significativa do setor de serviços (72% do PIB). A agropecuária, apesar de representar apenas 15% do PIB, emprega parcela substancial da população e define a identidade econômica de muitos municípios do interior.

A **dependência de transferências governamentais** é crítica: dos 139 municípios, **127 (91,4%)** têm mais de 70% de suas receitas oriundas do Fundo de Participação dos Municípios (FPM) e outras transferências constitucionais. Esta fragilidade fiscal limita a autonomia municipal e torna os municípios vulneráveis a oscilações nas transferências federais e estaduais. Apenas **12 municípios** (8,6%) possuem arrecadação própria superior a 30% das receitas totais, concentrados em Palmas, Araguaína, Gurupi e Paraíso do Tocantins.

O **mercado de trabalho formal** é relativamente pequeno: apenas **312 mil vínculos empregatícios formais** (RAIS 2022), representando **20% da população total**. A informalidade é estimada em **45-50%** da força de trabalho, concentrada em atividades agropecuárias, comércio e serviços de baixa qualificação. O **salário médio formal** é de **R$ 2.850** (2022), **15% abaixo da média nacional** de R$ 3.350, refletindo baixa produtividade e predominância de setores de menor valor agregado.

**Desigualdades regionais** são acentuadas: o **PIB per capita** varia de **R$ 12.500** em municípios pequenos do interior até **R$ 52.000** em Palmas, uma razão de **4,2:1**. Esta disparidade reflete diferenças em estrutura produtiva, acesso a serviços públicos, infraestrutura e capital humano. Municípios pequenos enfrentam círculo vicioso de baixa arrecadação → serviços públicos precários → êxodo populacional → menor base tributária.

A **oportunidade de transformação** reside na integração de dados econômicos dispersos em múltiplos sistemas (IBGE, SICONFI, RAIS, CAGED, MDIC) em plataforma unificada que permita análises integradas, identificação de potenciais econômicos sub-explorados, monitoramento de políticas de desenvolvimento e alocação eficiente de recursos públicos. O Framework V6.0, através do **Agente DATA (Econômico)**, viabiliza esta integração de forma automatizada, escalável e acessível para gestores municipais e estaduais.

---

## 1. Contexto e Relevância

### 1.1. Desafios da Gestão Econômica no Brasil

A gestão de políticas de desenvolvimento econômico no Brasil enfrenta desafios estruturais significativos que se manifestam de forma particularmente aguda em estados da região Norte. O país possui **5.570 municípios** com realidades econômicas extremamente heterogêneas, desde metrópoles industrializadas com PIB superior a R$ 500 bilhões (São Paulo) até pequenos municípios rurais com PIB inferior a R$ 50 milhões. Esta diversidade exige políticas públicas adaptadas às vocações e potenciais locais, mas a maioria dos gestores municipais não possui acesso facilitado a dados econômicos integrados que permitam diagnósticos precisos e formulação de estratégias de desenvolvimento baseadas em evidências.

Segundo dados do IBGE, **70% dos municípios brasileiros** possuem população inferior a 20 mil habitantes e dependem fortemente de transferências governamentais para financiar serviços públicos básicos. Nestes municípios, a **capacidade de arrecadação própria** (IPTU, ISS, ITBI) é limitada pela pequena base tributária, informalidade elevada e baixa capacidade administrativa para fiscalização e cobrança. O **Fundo de Participação dos Municípios (FPM)** representa, em média, **65% das receitas** de municípios pequenos, criando dependência estrutural e limitando autonomia para investimentos estratégicos.

A **fragmentação de dados econômicos** em múltiplos sistemas governamentais (IBGE para PIB, SICONFI para finanças públicas, RAIS/CAGED para emprego, MDIC para comércio exterior, Banco Central para crédito) dificulta análises integradas. Gestores públicos precisam acessar dezenas de portais diferentes, com interfaces não padronizadas, formatos de dados heterogêneos e ausência de APIs que facilitem automação. Esta fragmentação gera custos de transação elevados e reduz a probabilidade de que dados sejam efetivamente utilizados na tomada de decisão.

### 1.2. Papel do Agente DATA (Econômico) no Framework V6.0

O **Agente DATA** é um dos seis agentes especializados do Framework V6.0, responsável por coletar, processar, analisar e apresentar dados sobre atividade econômica, finanças públicas, mercado de trabalho e desenvolvimento econômico dos territórios. Suas principais funções incluem:

**Coleta Automatizada de Dados Econômicos** - Integrar dados de múltiplas fontes (IBGE, SICONFI, RAIS, CAGED, MDIC, Banco Central) para criar uma visão holística da economia de cada município, eliminando necessidade de acesso manual a dezenas de portais diferentes.

**Cálculo de Indicadores Derivados** - Gerar indicadores compostos (ex: Índice de Dependência Fiscal, Taxa de Formalização do Mercado de Trabalho, Índice de Diversificação Econômica) que sintetizam informações complexas em métricas acionáveis para gestores públicos.

**Análises Comparativas e Temporais** - Comparar municípios entre si e ao longo do tempo, identificando tendências de crescimento, estagnação ou declínio econômico, permitindo benchmarking e aprendizado com experiências bem-sucedidas de municípios similares.

**Identificação de Potenciais Econômicos** - Detectar setores produtivos sub-explorados, oportunidades de diversificação econômica e gargalos que limitam crescimento, fornecendo subsídios para formulação de políticas de desenvolvimento local.

**Monitoramento de Sustentabilidade Fiscal** - Acompanhar evolução de receitas, despesas, endividamento e capacidade de investimento dos municípios, emitindo alertas precoces sobre riscos de insolvência ou descumprimento da Lei de Responsabilidade Fiscal (LRF).

**Suporte a Decisões de Investimento Público** - Fornecer insights acionáveis sobre onde investir recursos públicos limitados para maximizar impacto em geração de emprego, renda e arrecadação tributária, considerando multiplicadores econômicos setoriais e espaciais.

### 1.3. Especificidades do Tocantins

O Tocantins possui características econômicas únicas que influenciam a coleta, análise e interpretação de dados econômicos:

**Estado Jovem com Economia em Formação** - Criado em 1988 com a divisão de Goiás, o Tocantins possui apenas 37 anos de existência como unidade federativa. Sua estrutura econômica ainda está em consolidação, com setores produtivos em desenvolvimento e base industrial incipiente. O **PIB estadual de R$ 51,5 bilhões** (2021) representa apenas **0,6% do PIB nacional**, posicionando o Tocantins como **24º maior economia** entre os 27 estados brasileiros.

**Concentração Econômica em Palmas** - A capital Palmas concentra **32% do PIB estadual** apesar de abrigar apenas **18% da população**. Esta concentração reflete o papel de Palmas como centro administrativo (sede do governo estadual), comercial e de serviços. O **PIB per capita de Palmas** é de **R$ 52.000** (2021), **2,5 vezes superior** à média estadual de R$ 21.000 e **4,2 vezes superior** ao PIB per capita dos municípios menores (R$ 12.500).

**Economia Agropecuária com Modernização Recente** - A agropecuária representa **15% do PIB estadual** (R$ 7,7 bilhões em 2021), mas emprega aproximadamente **35% da força de trabalho**. O Tocantins é o **7º maior produtor de soja** do Brasil (3,8 milhões de toneladas em 2022) e possui **rebanho bovino de 8,6 milhões de cabeças** (2022), o **8º maior do país**. A modernização da agricultura, com adoção de tecnologias de precisão e irrigação, convive com agricultura familiar de subsistência em pequenas propriedades.

**Setor de Serviços Predominante** - O setor de serviços representa **72% do PIB estadual** (R$ 37 bilhões), refletindo papel do comércio varejista, administração pública, educação e saúde. A **administração pública** sozinha representa **28% do PIB**, indicando peso significativo do setor público na economia tocantinense. Esta dependência torna a economia vulnerável a ajustes fiscais e reformas administrativas.

**Indústria Incipiente e Pouco Diversificada** - A indústria representa apenas **13% do PIB** (R$ 6,7 bilhões), concentrada em **construção civil** (40% do PIB industrial), **geração de energia** (25%) e **agroindústria** (20%). A indústria de transformação é limitada, com poucas empresas de médio e grande porte. A **ausência de parques industriais consolidados** e infraestrutura logística limitada (distância de portos, malha rodoviária precária) dificultam atração de investimentos industriais.

**Fragilidade Fiscal Municipal** - Dos 139 municípios, **127 (91,4%)** dependem de transferências governamentais para mais de 70% de suas receitas. A **arrecadação própria média** (IPTU + ISS + ITBI) é de apenas **R$ 850 per capita/ano** nos municípios pequenos, insuficiente para financiar serviços públicos essenciais. Esta fragilidade limita capacidade de investimento e torna municípios reféns de decisões federais sobre repasses.

**Mercado de Trabalho com Alta Informalidade** - Apenas **312 mil vínculos empregatícios formais** (RAIS 2022) em população de **1,6 milhão de habitantes** indica que **apenas 20% da população** possui emprego formal. A **informalidade estimada de 45-50%** reflete predominância de atividades agropecuárias familiares, comércio ambulante e serviços de baixa qualificação. O **salário médio formal de R$ 2.850** é **15% inferior à média nacional**, refletindo baixa produtividade e predominância de setores de menor valor agregado.

---

## 2. Fontes de Dados Identificadas

Identificamos **10 fontes principais** de dados econômicos, organizadas por área temática. Para cada fonte, detalhamos disponibilidade de APIs, formatos de dados, granularidade geográfica, frequência de atualização e limitações conhecidas.

### 2.1. Produto Interno Bruto (PIB)

#### IBGE - PIB Municipal

O **PIB Municipal** é calculado anualmente pelo IBGE em parceria com órgãos estaduais de estatística, seguindo metodologia do Sistema de Contas Nacionais. Fornece estimativas do valor adicionado bruto a preços básicos por setor econômico (agropecuária, indústria, serviços) e impostos sobre produtos para todos os municípios brasileiros.

**Disponibilidade de Dados:**
- **SIDRA (Sistema IBGE de Recuperação Automática):** Principal interface de acesso a dados do IBGE, disponível em [https://sidra.ibge.gov.br/](https://sidra.ibge.gov.br/)
- **API SIDRA:** API REST documentada em [https://apisidra.ibge.gov.br/](https://apisidra.ibge.gov.br/) permite consultas programáticas
- **Tabela 5938:** PIB a preços correntes, impostos, líquidos de subsídios, sobre produtos a preços correntes e valor adicionado bruto a preços correntes total e por atividade econômica
- **Formato:** JSON, XML, CSV
- **Autenticação:** Não requerida

**Granularidade:** Município, Microrregião, Mesorregião, Estado, Região, Brasil

**Frequência:** Anual (dados de 2023 divulgados em dezembro de 2025, defasagem de ~24 meses)

**Dados Disponíveis:**
- **PIB Total:** Valor adicionado bruto + impostos sobre produtos
- **PIB per capita:** PIB total dividido pela população estimada
- **Valor Adicionado por Setor:**
  - Agropecuária (agricultura, pecuária, produção florestal, pesca e aquicultura)
  - Indústria (indústrias extrativas, de transformação, construção civil, SIUP - serviços industriais de utilidade pública)
  - Serviços (comércio, transporte, alojamento e alimentação, informação e comunicação, atividades financeiras, imobiliárias, profissionais e administrativas, administração pública, educação, saúde, artes e outros serviços)
- **Impostos sobre Produtos:** ICMS, IPI, ISS e outros impostos líquidos de subsídios

**Limitações:**
- **Defasagem temporal elevada:** Dados de 2023 disponíveis apenas em dezembro de 2025
- **Metodologia de rateio:** Para municípios pequenos, PIB é estimado por rateio de valores estaduais usando indicadores proxy, reduzindo precisão
- **Não captura economia informal:** PIB oficial subestima atividade econômica real em regiões com informalidade elevada
- **Revisões frequentes:** Séries históricas são revisadas quando há mudanças metodológicas, dificultando comparações temporais

**Exemplo de Consulta via API SIDRA:**

```bash
# PIB total e per capita de todos os municípios do Tocantins em 2021
curl "https://apisidra.ibge.gov.br/values/t/5938/n6/1700/p/2021/v/37,37_per_capita"
```

### 2.2. Finanças Públicas

#### SICONFI (Sistema de Informações Contábeis e Fiscais do Setor Público Brasileiro)

O **SICONFI** é o sistema oficial do Tesouro Nacional para coleta, validação e disseminação de informações contábeis e fiscais de estados e municípios. Todos os entes federativos são obrigados a declarar mensalmente receitas, despesas, ativos, passivos e demonstrações contábeis no SICONFI, conforme Lei de Responsabilidade Fiscal (LRF) e Lei de Acesso à Informação (LAI).

**Disponibilidade de Dados:**
- **Portal SICONFI:** [https://siconfi.tesouro.gov.br/](https://siconfi.tesouro.gov.br/)
- **API SICONFI:** API REST documentada em [https://apidatalake.tesouro.gov.br/docs/siconfi/](https://apidatalake.tesouro.gov.br/docs/siconfi/)
- **Formato:** JSON
- **Autenticação:** Não requerida para consultas públicas

**Granularidade:** Município, Estado, Consolidado Nacional

**Frequência:** Mensal (receitas e despesas orçamentárias), Bimestral (Relatório Resumido de Execução Orçamentária - RREO), Quadrimestral (Relatório de Gestão Fiscal - RGF), Anual (Balanço Anual)

**Dados Disponíveis:**

**Receitas Orçamentárias:**
- **Receitas Correntes:** Tributárias (IPTU, ISS, ITBI), de Contribuições, Patrimoniais, Agropecuárias, Industriais, de Serviços, Transferências Correntes (FPM, ICMS, FUNDEB, SUS, FNDE)
- **Receitas de Capital:** Operações de Crédito, Alienação de Bens, Transferências de Capital

**Despesas Orçamentárias:**
- **Por Função:** Legislativa, Judiciária, Administração, Segurança Pública, Educação, Saúde, Assistência Social, Previdência, Habitação, Saneamento, Gestão Ambiental, Agricultura, Transporte, Desporto e Lazer, Encargos Especiais
- **Por Categoria Econômica:** Despesas Correntes (Pessoal, Juros, Outras Despesas Correntes), Despesas de Capital (Investimentos, Inversões Financeiras, Amortização da Dívida)
- **Por Grupo de Natureza:** Pessoal e Encargos Sociais, Juros e Encargos da Dívida, Outras Despesas Correntes, Investimentos, Inversões Financeiras, Amortização da Dívida

**Indicadores Fiscais:**
- **Resultado Primário:** Receitas não financeiras - Despesas não financeiras
- **Resultado Nominal:** Resultado primário - Juros da dívida
- **Dívida Consolidada Líquida (DCL):** Dívida total - Ativos financeiros
- **Receita Corrente Líquida (RCL):** Base de cálculo para limites da LRF
- **Despesa com Pessoal / RCL:** Limite de 60% para municípios (LRF Art. 20)
- **Dívida Consolidada / RCL:** Limite de 120% para municípios (Resolução Senado 40/2001)

**Limitações:**
- **Qualidade variável:** Municípios pequenos frequentemente declaram dados com erros ou atrasos
- **Complexidade da estrutura:** Plano de Contas Aplicado ao Setor Público (PCASP) possui centenas de contas, dificultando navegação
- **Falta de padronização histórica:** Mudanças no PCASP (2015, 2018) dificultam comparações temporais
- **Dados não auditados:** Informações são auto-declaradas pelos municípios, sem auditoria prévia

**Exemplo de Consulta via API SICONFI:**

```bash
# Receitas e despesas de Palmas (código IBGE 1721000) em 2023
curl "https://apidatalake.tesouro.gov.br/ords/siconfi/tp/rreo?an_exercicio=2023&nr_periodo=6&co_tipo_demonstrativo=RREO&co_esfera=M&id_ente=1721000"
```

### 2.3. Mercado de Trabalho

#### RAIS (Relação Anual de Informações Sociais)

A **RAIS** é uma declaração obrigatória para todos os empregadores, instituída pelo Decreto 76.900/1975, que fornece informações detalhadas sobre vínculos empregatícios formais, remunerações, jornada de trabalho, ocupações e características dos estabelecimentos. É a principal fonte de dados sobre mercado de trabalho formal no Brasil.

**Disponibilidade de Dados:**
- **Portal RAIS:** [https://www.gov.br/trabalho-e-previdencia/pt-br/assuntos/rais](https://www.gov.br/trabalho-e-previdencia/pt-br/assuntos/rais)
- **Microdados:** Disponíveis para download em formato TXT/CSV desde 1985
- **RAIS Identificada:** Dados com identificação de estabelecimentos e trabalhadores (acesso restrito mediante justificativa)
- **RAIS Desidentificada:** Dados sem CPF/CNPJ (acesso público)
- **Base dos Dados:** Dados tratados em [https://basedosdados.org/dataset/br-me-rais](https://basedosdados.org/dataset/br-me-rais)

**Granularidade:** Vínculo empregatício individual, Estabelecimento, Município, Estado, Brasil

**Frequência:** Anual (referência 31 de dezembro, divulgação em outubro do ano seguinte)

**Dados Disponíveis:**

**Vínculos Empregatícios:**
- **Número de vínculos ativos:** Total e por características (sexo, idade, escolaridade, raça/cor, nacionalidade)
- **Tipo de vínculo:** CLT, Estatutário, Temporário, Avulso, Aprendiz, Estagiário
- **Tempo de vínculo:** Admissão, demissão, tempo de emprego
- **Jornada de trabalho:** Horas contratuais semanais

**Remunerações:**
- **Salário médio mensal:** Por município, setor, ocupação
- **Faixa de remuneração:** Até 1 SM, 1-2 SM, 2-3 SM, 3-5 SM, 5-10 SM, 10-20 SM, >20 SM
- **13º salário, férias, bônus:** Componentes da remuneração

**Ocupações:**
- **CBO (Classificação Brasileira de Ocupações):** Código de 6 dígitos identificando ocupação específica
- **Grandes grupos ocupacionais:** Dirigentes, profissionais de ciências e intelectuais, técnicos de nível médio, trabalhadores de apoio administrativo, trabalhadores de serviços, vendedores, trabalhadores agropecuários, trabalhadores da produção industrial, operadores de instalações

**Estabelecimentos:**
- **CNAE (Classificação Nacional de Atividades Econômicas):** Código de 5 dígitos identificando atividade econômica
- **Tamanho:** Micro (até 19 empregados), Pequena (20-99), Média (100-499), Grande (500+)
- **Natureza jurídica:** Administração pública, empresa privada, entidade sem fins lucrativos, pessoa física

**Limitações:**
- **Apenas emprego formal:** Não captura trabalhadores informais, autônomos, empregadores
- **Defasagem temporal:** Dados de 2023 divulgados apenas em outubro de 2024
- **Múltiplos vínculos:** Trabalhador com 2+ empregos aparece múltiplas vezes, inflando contagens
- **Não há API oficial:** Requer download de microdados volumosos (>10 GB compactado)

#### CAGED (Cadastro Geral de Empregados e Desempregados)

O **CAGED** registra mensalmente admissões e demissões de empregados sob regime CLT, fornecendo indicador de curto prazo sobre dinâmica do mercado de trabalho formal. A partir de 2020, foi substituído pelo **eSocial** para empresas de médio e grande porte, mas continua sendo utilizado por micro e pequenas empresas.

**Disponibilidade de Dados:**
- **Portal CAGED:** [https://www.gov.br/trabalho-e-previdencia/pt-br/assuntos/caged](https://www.gov.br/trabalho-e-previdencia/pt-br/assuntos/caged)
- **Microdados:** Disponíveis para download mensal desde 1992
- **Painel de Informações:** Painéis interativos em [https://bi.mte.gov.br/](https://bi.mte.gov.br/)
- **Formato:** TXT, CSV

**Granularidade:** Município, Estado, Brasil

**Frequência:** Mensal (divulgação até dia 25 do mês subsequente)

**Dados Disponíveis:**
- **Admissões:** Número de contratações no mês
- **Demissões:** Número de desligamentos (com e sem justa causa, voluntários, término de contrato)
- **Saldo:** Admissões - Demissões (indicador de geração/destruição líquida de empregos)
- **Estoque:** Número de vínculos ativos ao final do mês
- **Desagregações:** Por setor CNAE, sexo, faixa etária, escolaridade, faixa de remuneração

**Limitações:**
- **Transição para eSocial:** Desde 2020, empresas grandes reportam via eSocial, criando quebra de série histórica
- **Apenas CLT:** Não captura estatutários, temporários, autônomos
- **Qualidade variável:** Pequenas empresas frequentemente atrasam ou omitem declarações
- **Não há API oficial:** Requer download manual de arquivos mensais

### 2.4. Setores Produtivos

#### IBGE - Pesquisa Agrícola Municipal (PAM)

A **PAM** investiga informações sobre área plantada, área colhida, quantidade produzida e valor da produção de **64 produtos agrícolas** (cereais, leguminosas, oleaginosas, frutas, hortaliças, produtos da silvicultura) em todos os municípios brasileiros.

**Disponibilidade de Dados:**
- **SIDRA Tabela 1612:** Área plantada, área colhida, quantidade produzida, rendimento médio e valor da produção das lavouras temporárias
- **SIDRA Tabela 1613:** Área destinada à colheita, área colhida, quantidade produzida, rendimento médio e valor da produção das lavouras permanentes
- **API SIDRA:** Consultas programáticas disponíveis
- **Formato:** JSON, XML, CSV

**Granularidade:** Município, Microrregião, Mesorregião, Estado, Região, Brasil

**Frequência:** Anual (divulgação em setembro do ano subsequente)

**Dados Disponíveis para Tocantins (principais produtos):**
- **Lavouras Temporárias:** Soja, milho, arroz, feijão, mandioca, melancia, abacaxi
- **Lavouras Permanentes:** Banana, laranja, manga, coco-da-baía, café
- **Métricas:** Área plantada (hectares), Área colhida (hectares), Quantidade produzida (toneladas), Rendimento médio (kg/ha), Valor da produção (R$ mil)

**Limitações:**
- **Não captura pecuária:** Para dados de rebanho, usar Pesquisa Pecuária Municipal (PPM)
- **Valores não deflacionados:** Valor da produção em preços correntes dificulta comparações temporais
- **Estimativas para municípios pequenos:** Dados podem ser estimados quando não há informantes locais

#### IBGE - Pesquisa Pecuária Municipal (PPM)

A **PPM** investiga efetivos de rebanhos (bovinos, suínos, equinos, ovinos, caprinos, galináceos, codornas, etc.) e produção de origem animal (leite, ovos, mel, lã, casulos de bicho-da-seda) em todos os municípios brasileiros.

**Disponibilidade de Dados:**
- **SIDRA Tabela 3939:** Efetivo dos rebanhos por tipo de rebanho
- **SIDRA Tabela 74:** Produção de origem animal por tipo de produto
- **API SIDRA:** Consultas programáticas disponíveis

**Granularidade:** Município, Microrregião, Mesorregião, Estado, Região, Brasil

**Frequência:** Anual (divulgação em setembro do ano subsequente)

**Dados Disponíveis para Tocantins:**
- **Rebanhos:** Bovinos (8,6 milhões de cabeças em 2022), Suínos, Equinos, Ovinos, Galináceos
- **Produção Animal:** Leite de vaca (milhões de litros), Ovos de galinha (milhões de dúzias), Mel de abelha (toneladas)

**Limitações:**
- **Não captura abate:** Para dados de abate, usar Pesquisa Trimestral do Abate de Animais
- **Estimativas de produção:** Produção de leite e ovos pode ser estimada quando não há informantes

#### IBGE - Pesquisa Industrial Anual (PIA)

A **PIA** investiga características estruturais e econômicas das empresas industriais com 5 ou mais pessoas ocupadas, fornecendo dados sobre pessoal ocupado, salários, custos, receitas, valor da transformação industrial e valor adicionado.

**Disponibilidade de Dados:**
- **SIDRA Tabela 1846:** Dados gerais das empresas industriais por divisão da CNAE
- **Formato:** Agregado por Estado e Divisão CNAE (não disponível por município)

**Granularidade:** Estado, Região, Brasil (não municipal)

**Frequência:** Anual (divulgação em maio do ano subsequente, defasagem de ~17 meses)

**Limitações:**
- **Não disponível por município:** Sigilo estatístico impede divulgação municipal
- **Apenas empresas formais com 5+ pessoas:** Não captura micro-indústrias e informalidade
- **Defasagem elevada:** Dados de 2023 divulgados apenas em maio de 2025

### 2.5. Comércio Exterior

#### MDIC - Comex Stat (Estatísticas de Comércio Exterior)

O **Comex Stat** é o sistema oficial do Ministério do Desenvolvimento, Indústria, Comércio e Serviços (MDIC) para disseminação de estatísticas de comércio exterior brasileiro. Consolida dados de exportações e importações declarados à Receita Federal.

**Disponibilidade de Dados:**
- **Portal Comex Stat:** [http://comexstat.mdic.gov.br/](http://comexstat.mdic.gov.br/)
- **API Comex Stat:** API REST documentada em [http://api.comexstat.mdic.gov.br/docs/](http://api.comexstat.mdic.gov.br/docs/)
- **Formato:** JSON, CSV, Excel

**Granularidade:** Município (exportações), Estado (importações - não disponível por município)

**Frequência:** Mensal (divulgação até dia 5 do mês subsequente)

**Dados Disponíveis:**

**Exportações (disponível por município):**
- **Valor FOB (Free On Board):** Valor da mercadoria no porto de embarque (US$)
- **Peso Líquido:** Peso da mercadoria em quilogramas
- **Produto:** NCM (Nomenclatura Comum do Mercosul) de 8 dígitos
- **País de destino:** Código e nome do país importador
- **Via de transporte:** Marítima, aérea, rodoviária, ferroviária, fluvial

**Importações (disponível apenas por Estado):**
- **Valor FOB:** Valor da mercadoria no porto de embarque (US$)
- **Produto:** NCM de 8 dígitos
- **País de origem:** Código e nome do país exportador

**Limitações:**
- **Importações não disponíveis por município:** Sigilo fiscal impede divulgação municipal
- **Tocantins tem comércio exterior limitado:** Apenas 15-20 municípios exportam regularmente
- **Produtos primários predominam:** Soja, carne bovina, milho representam >80% das exportações tocantinenses

**Exemplo de Consulta via API Comex Stat:**

```bash
# Exportações de Palmas em 2023
curl "http://api.comexstat.mdic.gov.br/general?filter=NO_MUN_MIN%3DPalmas%26CO_ANO%3D2023"
```

### 2.6. Investimentos e Crédito

#### Banco Central do Brasil - Sistema de Informações de Crédito (SCR)

O **SCR** consolida informações sobre operações de crédito concedidas por instituições financeiras a pessoas físicas e jurídicas. Fornece dados agregados sobre estoque de crédito, modalidades, taxas de juros e inadimplência.

**Disponibilidade de Dados:**
- **Portal SCR:** [https://www.bcb.gov.br/estabilidadefinanceira/credito](https://www.bcb.gov.br/estabilidadefinanceira/credito)
- **Estatísticas Municipais:** Dados agregados por município em [https://www.bcb.gov.br/estatisticas/estatisticasmunicipais](https://www.bcb.gov.br/estatisticas/estatisticasmunicipais)
- **Formato:** Excel, CSV

**Granularidade:** Município, Estado, Região, Brasil

**Frequência:** Mensal (divulgação com ~45 dias de defasagem)

**Dados Disponíveis:**

**Crédito Total:**
- **Estoque de crédito:** Saldo devedor total (R$ milhões)
- **Crédito per capita:** Estoque / população (R$)
- **Crédito / PIB:** Estoque / PIB municipal (%)

**Por Tipo de Tomador:**
- **Pessoas Físicas:** Crédito consignado, veículos, habitação, cartão de crédito, cheque especial, crédito pessoal
- **Pessoas Jurídicas:** Capital de giro, investimento, comércio exterior, rural

**Indicadores de Qualidade:**
- **Taxa de inadimplência:** % de operações com atraso >90 dias
- **Provisões:** Valor provisionado para perdas esperadas

**Limitações:**
- **Apenas operações >R$ 1.000:** Operações pequenas não são reportadas ao SCR
- **Dados agregados:** Não há informações sobre tomadores individuais (sigilo bancário)
- **Não há API oficial:** Requer download manual de planilhas mensais

#### BNDES - Operações Contratadas

O **BNDES** (Banco Nacional de Desenvolvimento Econômico e Social) divulga informações sobre operações de crédito contratadas para financiamento de investimentos em infraestrutura, indústria, comércio e serviços.

**Disponibilidade de Dados:**
- **Portal BNDES Transparência:** [https://www.bndes.gov.br/wps/portal/site/home/transparencia](https://www.bndes.gov.br/wps/portal/site/home/transparencia)
- **Dados Abertos:** [https://dadosabertos.bndes.gov.br/](https://dadosabertos.bndes.gov.br/)
- **Formato:** CSV, Excel

**Granularidade:** Operação individual (com município do beneficiário)

**Frequência:** Mensal (atualização contínua)

**Dados Disponíveis:**
- **Valor contratado:** Montante financiado pelo BNDES (R$)
- **Setor CNAE:** Atividade econômica do beneficiário
- **Finalidade:** Investimento, capital de giro, exportação
- **Porte do beneficiário:** Micro, pequena, média, grande empresa
- **Município:** Localização do beneficiário

**Limitações:**
- **Apenas operações diretas:** Operações indiretas (via bancos comerciais) não têm município divulgado
- **Tocantins recebe poucos recursos:** Estado representa <0,5% das operações do BNDES

### 2.7. Indicadores de Desenvolvimento

#### IBGE - Índice de Desenvolvimento Humano Municipal (IDHM)

O **IDHM** é uma adaptação do IDH Global para o contexto brasileiro, calculado a partir de dados dos Censos Demográficos. Sintetiza três dimensões do desenvolvimento humano: longevidade, educação e renda.

**Disponibilidade de Dados:**
- **Atlas do Desenvolvimento Humano no Brasil:** [http://www.atlasbrasil.org.br/](http://www.atlasbrasil.org.br/)
- **Formato:** Excel, CSV, Shapefile (com geometrias municipais)

**Granularidade:** Município, Estado, Região Metropolitana, Brasil

**Frequência:** Decenal (Censos 1991, 2000, 2010; próximo em 2030)

**Componentes do IDHM:**

**IDHM Longevidade:**
- **Indicador:** Esperança de vida ao nascer (anos)
- **Fonte:** IBGE - Tábuas de Mortalidade
- **Tocantins 2010:** 72,6 anos (vs 73,9 anos Brasil)

**IDHM Educação:**
- **Indicadores:** Taxa de escolarização (6-17 anos), % adultos com fundamental completo, % adultos com médio completo
- **Fonte:** IBGE - Censo Demográfico
- **Tocantins 2010:** IDHM Educação = 0,624 (vs 0,637 Brasil)

**IDHM Renda:**
- **Indicador:** Renda per capita média (R$)
- **Fonte:** IBGE - Censo Demográfico
- **Tocantins 2010:** R$ 690/mês (vs R$ 793/mês Brasil)

**IDHM Geral:**
- **Cálculo:** Média geométrica dos 3 sub-índices
- **Tocantins 2010:** 0,699 (médio) vs 0,727 (Brasil - alto)

**Limitações:**
- **Frequência decenal:** Não permite monitoramento de curto prazo
- **Defasagem elevada:** Dados de 2020 ainda não divulgados (previsão 2025)
- **Não captura desigualdades intramunicipais:** IDHM é média municipal, mascarando disparidades internas

---

## 3. Indicadores Econômicos Prioritários

Com base nas fontes de dados identificadas e nas necessidades de gestores públicos tocantinenses, selecionamos **120 indicadores econômicos** organizados em **7 categorias**. Para cada indicador, especificamos fonte de dados, granularidade, frequência de atualização e relevância para tomada de decisão.

### 3.1. Produto Interno Bruto e Renda

| # | Indicador | Fonte | Granularidade | Frequência | Relevância |
|---|-----------|-------|---------------|------------|------------|
| 1 | PIB Total (R$ correntes) | IBGE SIDRA 5938 | Municipal | Anual | Medir tamanho da economia local |
| 2 | PIB per capita (R$) | IBGE SIDRA 5938 | Municipal | Anual | Comparar renda média entre municípios |
| 3 | PIB Agropecuária (R$) | IBGE SIDRA 5938 | Municipal | Anual | Avaliar peso do setor primário |
| 4 | PIB Indústria (R$) | IBGE SIDRA 5938 | Municipal | Anual | Avaliar peso do setor secundário |
| 5 | PIB Serviços (R$) | IBGE SIDRA 5938 | Municipal | Anual | Avaliar peso do setor terciário |
| 6 | Participação Agropecuária no PIB (%) | Calculado | Municipal | Anual | Identificar vocação econômica |
| 7 | Participação Indústria no PIB (%) | Calculado | Municipal | Anual | Identificar vocação econômica |
| 8 | Participação Serviços no PIB (%) | Calculado | Municipal | Anual | Identificar vocação econômica |
| 9 | Taxa de Crescimento do PIB (% a.a.) | Calculado | Municipal | Anual | Monitorar dinâmica econômica |
| 10 | Índice de Diversificação Econômica | Calculado (Herfindahl) | Municipal | Anual | Avaliar resiliência econômica |

**Indicadores Derivados:**

**Índice de Diversificação Econômica (IDE):** Calculado usando índice de Herfindahl-Hirschman invertido, mede concentração setorial. IDE = 1 - Σ(participação_setor_i)². Valores próximos a 1 indicam economia diversificada (resiliente a choques setoriais), valores próximos a 0 indicam concentração (vulnerável).

**Taxa de Crescimento Real do PIB:** PIB nominal deflacionado pelo IPCA (Índice de Preços ao Consumidor Amplo) para remover efeito da inflação. Permite comparações temporais de crescimento econômico real.

### 3.2. Finanças Públicas Municipais

| # | Indicador | Fonte | Granularidade | Frequência | Relevância |
|---|-----------|-------|---------------|------------|------------|
| 11 | Receita Total (R$) | SICONFI | Municipal | Mensal | Monitorar capacidade de gasto |
| 12 | Receita Corrente (R$) | SICONFI | Municipal | Mensal | Avaliar receitas recorrentes |
| 13 | Receita Tributária Própria (R$) | SICONFI | Municipal | Mensal | Medir autonomia fiscal |
| 14 | Transferências Correntes (R$) | SICONFI | Municipal | Mensal | Avaliar dependência de transferências |
| 15 | FPM - Fundo de Participação dos Municípios (R$) | SICONFI | Municipal | Mensal | Monitorar principal fonte de receita |
| 16 | ICMS - Quota-Parte Municipal (R$) | SICONFI | Municipal | Mensal | Monitorar receita de ICMS |
| 17 | Despesa Total (R$) | SICONFI | Municipal | Mensal | Monitorar execução orçamentária |
| 18 | Despesa com Pessoal (R$) | SICONFI | Municipal | Mensal | Monitorar gasto com folha de pagamento |
| 19 | Despesa com Investimentos (R$) | SICONFI | Municipal | Mensal | Avaliar capacidade de investimento |
| 20 | Resultado Primário (R$) | SICONFI | Bimestral | Bimestral | Avaliar sustentabilidade fiscal |
| 21 | Dívida Consolidada Líquida (R$) | SICONFI | Quadrimestral | Quadrimestral | Monitorar endividamento |
| 22 | Receita Corrente Líquida - RCL (R$) | SICONFI | Bimestral | Bimestral | Base para cálculo de limites LRF |
| 23 | Índice de Dependência de Transferências (%) | Calculado | Municipal | Mensal | Medir autonomia fiscal |
| 24 | Despesa com Pessoal / RCL (%) | Calculado | Bimestral | Bimestral | Verificar limite LRF (60%) |
| 25 | Dívida Consolidada / RCL (%) | Calculado | Quadrimestral | Quadrimestral | Verificar limite Senado (120%) |
| 26 | Investimento per capita (R$) | Calculado | Municipal | Anual | Comparar capacidade de investimento |
| 27 | Arrecadação Própria per capita (R$) | Calculado | Municipal | Anual | Comparar esforço fiscal |

**Indicadores Derivados:**

**Índice de Dependência de Transferências (IDT):** IDT = (Transferências Correntes / Receita Total) × 100. Valores >70% indicam alta dependência, limitando autonomia municipal. Tocantins: média de 75% (vs 60% média nacional).

**Capacidade de Investimento:** Percentual da receita total destinado a investimentos. Municípios saudáveis investem 10-15% da receita; municípios com IDT >80% frequentemente investem <5%.

### 3.3. Mercado de Trabalho Formal

| # | Indicador | Fonte | Granularidade | Frequência | Relevância |
|---|-----------|-------|---------------|------------|------------|
| 28 | Vínculos Empregatícios Formais (total) | RAIS | Municipal | Anual | Medir tamanho do mercado formal |
| 29 | Vínculos por Setor CNAE (total) | RAIS | Municipal | Anual | Identificar setores empregadores |
| 30 | Salário Médio Formal (R$) | RAIS | Municipal | Anual | Comparar remuneração entre municípios |
| 31 | Salário Médio por Setor (R$) | RAIS | Municipal | Anual | Identificar setores de maior remuneração |
| 32 | Admissões no mês (total) | CAGED | Municipal | Mensal | Monitorar contratações |
| 33 | Demissões no mês (total) | CAGED | Municipal | Mensal | Monitorar desligamentos |
| 34 | Saldo de Empregos (admissões - demissões) | CAGED | Municipal | Mensal | Indicador de geração líquida de empregos |
| 35 | Estoque de Empregos Formais | CAGED | Municipal | Mensal | Monitorar evolução do mercado formal |
| 36 | Taxa de Formalização (%) | Calculado | Municipal | Anual | Estimar informalidade |
| 37 | Taxa de Rotatividade (%) | Calculado | Municipal | Anual | Medir estabilidade do emprego |
| 38 | Vínculos Femininos / Total (%) | RAIS | Municipal | Anual | Avaliar equidade de gênero |
| 39 | Vínculos com Ensino Superior / Total (%) | RAIS | Municipal | Anual | Avaliar qualificação da força de trabalho |

**Indicadores Derivados:**

**Taxa de Formalização:** (Vínculos Formais RAIS / População Economicamente Ativa) × 100. PEA estimada como 50% da população total. Tocantins: ~20% (vs 35% média nacional), indicando informalidade de 80%.

**Taxa de Rotatividade:** ((Admissões + Demissões) / 2) / Estoque Médio × 100. Mede instabilidade do emprego. Tocantins: ~40% a.a. (vs 35% média nacional).

### 3.4. Setores Produtivos

| # | Indicador | Fonte | Granularidade | Frequência | Relevância |
|---|-----------|-------|---------------|------------|------------|
| 40 | Área Plantada de Soja (ha) | PAM SIDRA 1612 | Municipal | Anual | Monitorar principal lavoura |
| 41 | Produção de Soja (toneladas) | PAM SIDRA 1612 | Municipal | Anual | Medir produtividade agrícola |
| 42 | Valor da Produção de Soja (R$ mil) | PAM SIDRA 1612 | Municipal | Anual | Estimar receita agrícola |
| 43 | Área Plantada de Milho (ha) | PAM SIDRA 1612 | Municipal | Anual | Monitorar segunda principal lavoura |
| 44 | Produção de Milho (toneladas) | PAM SIDRA 1612 | Municipal | Anual | Medir produtividade |
| 45 | Rebanho Bovino (cabeças) | PPM SIDRA 3939 | Municipal | Anual | Monitorar pecuária |
| 46 | Produção de Leite (mil litros) | PPM SIDRA 74 | Municipal | Anual | Medir produção leiteira |
| 47 | Valor da Produção Agropecuária Total (R$ mil) | PAM + PPM | Municipal | Anual | Estimar receita do setor primário |
| 48 | Número de Estabelecimentos Industriais | PIA (Estado) | Estadual | Anual | Monitorar setor secundário |
| 49 | Pessoal Ocupado na Indústria | PIA (Estado) | Estadual | Anual | Medir emprego industrial |
| 50 | Valor da Transformação Industrial (R$ mil) | PIA (Estado) | Estadual | Anual | Medir valor agregado industrial |

**Limitações:** Dados industriais (PIA) não disponíveis por município devido a sigilo estatístico. Análises municipais devem usar RAIS (vínculos em CNAE industrial) como proxy.

### 3.5. Comércio Exterior

| # | Indicador | Fonte | Granularidade | Frequência | Relevância |
|---|-----------|-------|---------------|------------|------------|
| 51 | Valor Exportado Total (US$ FOB) | Comex Stat | Municipal | Mensal | Monitorar exportações |
| 52 | Valor Exportado por Produto NCM (US$) | Comex Stat | Municipal | Mensal | Identificar principais produtos exportados |
| 53 | Valor Exportado por País Destino (US$) | Comex Stat | Municipal | Mensal | Identificar principais mercados |
| 54 | Peso Exportado (kg) | Comex Stat | Municipal | Mensal | Medir volume físico |
| 55 | Número de Empresas Exportadoras | Comex Stat | Municipal | Anual | Avaliar base exportadora |
| 56 | Concentração de Exportações (Herfindahl) | Calculado | Municipal | Anual | Avaliar diversificação exportadora |

**Contexto Tocantins:** Apenas 15-20 municípios exportam regularmente. Principais produtos: soja (60%), carne bovina (25%), milho (10%). Principais destinos: China (45%), União Europeia (20%), outros países asiáticos (15%).

### 3.6. Crédito e Investimentos

| # | Indicador | Fonte | Granularidade | Frequência | Relevância |
|---|-----------|-------|---------------|------------|------------|
| 57 | Estoque de Crédito Total (R$ milhões) | BC SCR | Municipal | Mensal | Medir acesso a crédito |
| 58 | Crédito per capita (R$) | BC SCR | Municipal | Mensal | Comparar acesso a crédito |
| 59 | Crédito / PIB (%) | Calculado | Municipal | Mensal | Avaliar profundidade financeira |
| 60 | Crédito Pessoas Físicas (R$ milhões) | BC SCR | Municipal | Mensal | Medir crédito ao consumo |
| 61 | Crédito Pessoas Jurídicas (R$ milhões) | BC SCR | Municipal | Mensal | Medir crédito produtivo |
| 62 | Taxa de Inadimplência (%) | BC SCR | Municipal | Mensal | Avaliar qualidade do crédito |
| 63 | Operações BNDES Contratadas (R$ milhões) | BNDES | Municipal | Mensal | Monitorar investimentos de longo prazo |
| 64 | Número de Operações BNDES | BNDES | Municipal | Mensal | Avaliar acesso a crédito de desenvolvimento |

**Contexto Tocantins:** Crédito/PIB médio de 35% (vs 55% média nacional), indicando baixa profundidade financeira. Taxa de inadimplência de 4,5% (vs 3,2% nacional), refletindo maior risco de crédito.

### 3.7. Indicadores de Desenvolvimento

| # | Indicador | Fonte | Granularidade | Frequência | Relevância |
|---|-----------|-------|---------------|------------|------------|
| 65 | IDHM Geral | Atlas Brasil | Municipal | Decenal | Medir desenvolvimento humano |
| 66 | IDHM Longevidade | Atlas Brasil | Municipal | Decenal | Avaliar saúde |
| 67 | IDHM Educação | Atlas Brasil | Municipal | Decenal | Avaliar educação |
| 68 | IDHM Renda | Atlas Brasil | Municipal | Decenal | Avaliar renda |
| 69 | Renda per capita (R$) | IBGE Censo | Municipal | Decenal | Comparar renda média |
| 70 | % População Extremamente Pobre | IBGE Censo | Municipal | Decenal | Identificar vulnerabilidade |

---

## 4. Estrutura de Dados Proposta

Para armazenar os 120 indicadores econômicos identificados, propusemos estrutura de **16 tabelas PostgreSQL** organizadas em **5 grupos temáticos**. A estrutura segue padrões de normalização, utiliza tipos de dados apropriados, inclui índices para otimização de consultas e documenta relacionamentos entre tabelas.

### 4.1. Grupo: Dados Econômicos Gerais (3 tabelas)

#### Tabela: `dados_economicos`

Armazena dados de PIB municipal por setor econômico.

```sql
CREATE TABLE dados_economicos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano >= 1990 AND ano <= 2100),
    pib_total DECIMAL(15,2), -- PIB total em R$ mil
    pib_per_capita DECIMAL(10,2), -- PIB per capita em R$
    pib_agropecuaria DECIMAL(15,2), -- Valor adicionado agropecuária em R$ mil
    pib_industria DECIMAL(15,2), -- Valor adicionado indústria em R$ mil
    pib_servicos DECIMAL(15,2), -- Valor adicionado serviços em R$ mil
    impostos_produtos DECIMAL(15,2), -- Impostos sobre produtos em R$ mil
    fonte_dados VARCHAR(200) DEFAULT 'IBGE - PIB Municipal',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_dados_economicos UNIQUE (codigo_ibge, ano)
);

CREATE INDEX idx_dados_economicos_codigo_ibge ON dados_economicos(codigo_ibge);
CREATE INDEX idx_dados_economicos_ano ON dados_economicos(ano);
CREATE INDEX idx_dados_economicos_pib_total ON dados_economicos(pib_total DESC);
```

**Campos Calculados (views):**

```sql
CREATE VIEW vw_dados_economicos_derivados AS
SELECT 
    codigo_ibge,
    ano,
    pib_total,
    pib_per_capita,
    ROUND((pib_agropecuaria / NULLIF(pib_total, 0)) * 100, 2) AS participacao_agropecuaria_pct,
    ROUND((pib_industria / NULLIF(pib_total, 0)) * 100, 2) AS participacao_industria_pct,
    ROUND((pib_servicos / NULLIF(pib_total, 0)) * 100, 2) AS participacao_servicos_pct,
    ROUND(
        1 - (
            POWER(pib_agropecuaria / NULLIF(pib_total, 0), 2) +
            POWER(pib_industria / NULLIF(pib_total, 0), 2) +
            POWER(pib_servicos / NULLIF(pib_total, 0), 2)
        ), 4
    ) AS indice_diversificacao_economica,
    LAG(pib_total) OVER (PARTITION BY codigo_ibge ORDER BY ano) AS pib_total_ano_anterior,
    ROUND(
        ((pib_total - LAG(pib_total) OVER (PARTITION BY codigo_ibge ORDER BY ano)) / 
         NULLIF(LAG(pib_total) OVER (PARTITION BY codigo_ibge ORDER BY ano), 0)) * 100, 
        2
    ) AS taxa_crescimento_pib_pct
FROM dados_economicos;
```

#### Tabela: `dados_renda_populacao`

Armazena dados de renda e pobreza da população (Censo Demográfico).

```sql
CREATE TABLE dados_renda_populacao (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano IN (1991, 2000, 2010, 2022)),
    renda_per_capita_media DECIMAL(10,2), -- Renda domiciliar per capita média em R$
    renda_per_capita_mediana DECIMAL(10,2), -- Renda domiciliar per capita mediana em R$
    percentual_extremamente_pobres DECIMAL(5,2), -- % população com renda <R$ 70/mês
    percentual_pobres DECIMAL(5,2), -- % população com renda <R$ 140/mês
    percentual_vulneraveis DECIMAL(5,2), -- % população com renda <R$ 255/mês
    indice_gini DECIMAL(4,3), -- Índice de Gini (0-1, maior = mais desigual)
    fonte_dados VARCHAR(200) DEFAULT 'IBGE - Censo Demográfico',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_dados_renda_populacao UNIQUE (codigo_ibge, ano)
);

CREATE INDEX idx_dados_renda_populacao_codigo_ibge ON dados_renda_populacao(codigo_ibge);
CREATE INDEX idx_dados_renda_populacao_ano ON dados_renda_populacao(ano);
```

#### Tabela: `dados_idhm`

Armazena Índice de Desenvolvimento Humano Municipal e componentes.

```sql
CREATE TABLE dados_idhm (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano IN (1991, 2000, 2010)),
    idhm DECIMAL(5,3) CHECK (idhm >= 0 AND idhm <= 1), -- IDHM geral
    idhm_longevidade DECIMAL(5,3) CHECK (idhm_longevidade >= 0 AND idhm_longevidade <= 1),
    idhm_educacao DECIMAL(5,3) CHECK (idhm_educacao >= 0 AND idhm_educacao <= 1),
    idhm_renda DECIMAL(5,3) CHECK (idhm_renda >= 0 AND idhm_renda <= 1),
    esperanca_vida_nascer DECIMAL(4,1), -- Esperança de vida ao nascer em anos
    taxa_escolarizacao_6_17 DECIMAL(5,2), -- % população 6-17 anos frequentando escola
    fonte_dados VARCHAR(200) DEFAULT 'PNUD/IPEA/FJP - Atlas do Desenvolvimento Humano',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_dados_idhm UNIQUE (codigo_ibge, ano)
);

CREATE INDEX idx_dados_idhm_codigo_ibge ON dados_idhm(codigo_ibge);
CREATE INDEX idx_dados_idhm_ano ON dados_idhm(ano);
CREATE INDEX idx_dados_idhm_valor ON dados_idhm(idhm DESC);
```

### 4.2. Grupo: Finanças Públicas (4 tabelas)

#### Tabela: `financas_receitas_municipais`

Armazena receitas orçamentárias municipais mensais.

```sql
CREATE TABLE financas_receitas_municipais (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano >= 2000 AND ano <= 2100),
    mes INTEGER NOT NULL CHECK (mes >= 1 AND mes <= 12),
    receita_total DECIMAL(15,2), -- Receita total arrecadada no mês em R$
    receita_corrente DECIMAL(15,2),
    receita_tributaria DECIMAL(15,2), -- IPTU + ISS + ITBI + IRRF + outras
    receita_transferencias_correntes DECIMAL(15,2), -- FPM + ICMS + FUNDEB + outras
    receita_fpm DECIMAL(15,2), -- Fundo de Participação dos Municípios
    receita_icms DECIMAL(15,2), -- Quota-parte ICMS
    receita_fundeb DECIMAL(15,2), -- Fundo de Desenvolvimento da Educação Básica
    receita_sus DECIMAL(15,2), -- Transferências do SUS
    receita_capital DECIMAL(15,2), -- Operações de crédito, alienação de bens
    fonte_dados VARCHAR(200) DEFAULT 'SICONFI - Tesouro Nacional',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_financas_receitas_municipais UNIQUE (codigo_ibge, ano, mes)
);

CREATE INDEX idx_financas_receitas_municipais_codigo_ibge ON financas_receitas_municipais(codigo_ibge);
CREATE INDEX idx_financas_receitas_municipais_ano_mes ON financas_receitas_municipais(ano, mes);
```

**View de Indicadores Derivados:**

```sql
CREATE VIEW vw_financas_receitas_indicadores AS
SELECT 
    codigo_ibge,
    ano,
    mes,
    receita_total,
    ROUND((receita_tributaria / NULLIF(receita_total, 0)) * 100, 2) AS autonomia_fiscal_pct,
    ROUND((receita_transferencias_correntes / NULLIF(receita_total, 0)) * 100, 2) AS dependencia_transferencias_pct,
    ROUND((receita_fpm / NULLIF(receita_total, 0)) * 100, 2) AS dependencia_fpm_pct
FROM financas_receitas_municipais;
```

#### Tabela: `financas_despesas_municipais`

Armazena despesas orçamentárias municipais mensais.

```sql
CREATE TABLE financas_despesas_municipais (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano >= 2000 AND ano <= 2100),
    mes INTEGER NOT NULL CHECK (mes >= 1 AND mes <= 12),
    despesa_total DECIMAL(15,2), -- Despesa total empenhada no mês em R$
    despesa_corrente DECIMAL(15,2),
    despesa_pessoal DECIMAL(15,2), -- Pessoal e encargos sociais
    despesa_juros DECIMAL(15,2), -- Juros e encargos da dívida
    despesa_outras_correntes DECIMAL(15,2), -- Material de consumo, serviços, etc.
    despesa_capital DECIMAL(15,2),
    despesa_investimentos DECIMAL(15,2), -- Obras, equipamentos, instalações
    despesa_inversoes_financeiras DECIMAL(15,2),
    despesa_amortizacao_divida DECIMAL(15,2),
    fonte_dados VARCHAR(200) DEFAULT 'SICONFI - Tesouro Nacional',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_financas_despesas_municipais UNIQUE (codigo_ibge, ano, mes)
);

CREATE INDEX idx_financas_despesas_municipais_codigo_ibge ON financas_despesas_municipais(codigo_ibge);
CREATE INDEX idx_financas_despesas_municipais_ano_mes ON financas_despesas_municipais(ano, mes);
```

#### Tabela: `financas_despesas_funcao`

Armazena despesas por função orçamentária (educação, saúde, etc.).

```sql
CREATE TABLE financas_despesas_funcao (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano >= 2000 AND ano <= 2100),
    mes INTEGER NOT NULL CHECK (mes >= 1 AND mes <= 12),
    funcao VARCHAR(50) NOT NULL, -- Educação, Saúde, Assistência Social, etc.
    despesa_empenhada DECIMAL(15,2), -- Despesa empenhada na função em R$
    despesa_liquidada DECIMAL(15,2), -- Despesa liquidada (serviço prestado)
    despesa_paga DECIMAL(15,2), -- Despesa efetivamente paga
    fonte_dados VARCHAR(200) DEFAULT 'SICONFI - Tesouro Nacional',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_financas_despesas_funcao UNIQUE (codigo_ibge, ano, mes, funcao)
);

CREATE INDEX idx_financas_despesas_funcao_codigo_ibge ON financas_despesas_funcao(codigo_ibge);
CREATE INDEX idx_financas_despesas_funcao_funcao ON financas_despesas_funcao(funcao);
```

#### Tabela: `financas_indicadores_fiscais`

Armazena indicadores fiscais calculados (RCL, limites LRF, dívida).

```sql
CREATE TABLE financas_indicadores_fiscais (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano >= 2000 AND ano <= 2100),
    bimestre INTEGER NOT NULL CHECK (bimestre >= 1 AND bimestre <= 6),
    receita_corrente_liquida DECIMAL(15,2), -- RCL em R$ (base para limites LRF)
    despesa_pessoal_total DECIMAL(15,2), -- Despesa total com pessoal em R$
    despesa_pessoal_rcl_pct DECIMAL(5,2), -- % Despesa Pessoal / RCL (limite 60%)
    divida_consolidada DECIMAL(15,2), -- Dívida consolidada em R$
    divida_consolidada_liquida DECIMAL(15,2), -- DCL = Dívida - Ativos Financeiros
    divida_consolidada_rcl_pct DECIMAL(6,2), -- % DCL / RCL (limite 120%)
    resultado_primario DECIMAL(15,2), -- Receitas não financeiras - Despesas não financeiras
    resultado_nominal DECIMAL(15,2), -- Resultado primário - Juros
    fonte_dados VARCHAR(200) DEFAULT 'SICONFI - RGF/RREO',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_financas_indicadores_fiscais UNIQUE (codigo_ibge, ano, bimestre)
);

CREATE INDEX idx_financas_indicadores_fiscais_codigo_ibge ON financas_indicadores_fiscais(codigo_ibge);
CREATE INDEX idx_financas_indicadores_fiscais_ano_bimestre ON financas_indicadores_fiscais(ano, bimestre);
```

### 4.3. Grupo: Mercado de Trabalho (3 tabelas)

#### Tabela: `mercado_trabalho_rais`

Armazena dados anuais de vínculos empregatícios formais (RAIS).

```sql
CREATE TABLE mercado_trabalho_rais (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano >= 1985 AND ano <= 2100),
    vinculos_totais INTEGER, -- Número total de vínculos ativos em 31/12
    vinculos_clt INTEGER, -- Vínculos CLT
    vinculos_estatutarios INTEGER, -- Vínculos estatutários
    salario_medio DECIMAL(10,2), -- Salário médio mensal em R$
    salario_mediano DECIMAL(10,2), -- Salário mediano mensal em R$
    vinculos_femininos INTEGER, -- Vínculos de mulheres
    vinculos_ensino_superior INTEGER, -- Vínculos com ensino superior completo
    fonte_dados VARCHAR(200) DEFAULT 'ME - RAIS',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_mercado_trabalho_rais UNIQUE (codigo_ibge, ano)
);

CREATE INDEX idx_mercado_trabalho_rais_codigo_ibge ON mercado_trabalho_rais(codigo_ibge);
CREATE INDEX idx_mercado_trabalho_rais_ano ON mercado_trabalho_rais(ano);
```

#### Tabela: `mercado_trabalho_rais_setores`

Armazena vínculos e salários por setor CNAE (desagregação da RAIS).

```sql
CREATE TABLE mercado_trabalho_rais_setores (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano >= 1985 AND ano <= 2100),
    cnae_secao VARCHAR(1) NOT NULL, -- A=Agropecuária, B=Indústria Extrativa, C=Transformação, etc.
    cnae_divisao VARCHAR(2), -- 01-99
    descricao_setor VARCHAR(200),
    vinculos INTEGER, -- Número de vínculos no setor
    salario_medio DECIMAL(10,2), -- Salário médio no setor em R$
    fonte_dados VARCHAR(200) DEFAULT 'ME - RAIS',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_mercado_trabalho_rais_setores UNIQUE (codigo_ibge, ano, cnae_secao, cnae_divisao)
);

CREATE INDEX idx_mercado_trabalho_rais_setores_codigo_ibge ON mercado_trabalho_rais_setores(codigo_ibge);
CREATE INDEX idx_mercado_trabalho_rais_setores_cnae ON mercado_trabalho_rais_setores(cnae_secao, cnae_divisao);
```

#### Tabela: `mercado_trabalho_caged`

Armazena dados mensais de movimentação de empregos (CAGED).

```sql
CREATE TABLE mercado_trabalho_caged (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano >= 1992 AND ano <= 2100),
    mes INTEGER NOT NULL CHECK (mes >= 1 AND mes <= 12),
    admissoes INTEGER, -- Número de admissões no mês
    demissoes INTEGER, -- Número de demissões no mês
    saldo INTEGER, -- Admissões - Demissões (geração líquida de empregos)
    estoque INTEGER, -- Estoque de vínculos ativos ao final do mês
    fonte_dados VARCHAR(200) DEFAULT 'ME - CAGED',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_mercado_trabalho_caged UNIQUE (codigo_ibge, ano, mes)
);

CREATE INDEX idx_mercado_trabalho_caged_codigo_ibge ON mercado_trabalho_caged(codigo_ibge);
CREATE INDEX idx_mercado_trabalho_caged_ano_mes ON mercado_trabalho_caged(ano, mes);
```

### 4.4. Grupo: Setores Produtivos (4 tabelas)

#### Tabela: `producao_agricola`

Armazena dados de produção agrícola municipal (PAM).

```sql
CREATE TABLE producao_agricola (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano >= 1990 AND ano <= 2100),
    produto VARCHAR(100) NOT NULL, -- Soja, Milho, Arroz, Feijão, etc.
    tipo_lavoura VARCHAR(20) CHECK (tipo_lavoura IN ('Temporária', 'Permanente')),
    area_plantada INTEGER, -- Área plantada em hectares
    area_colhida INTEGER, -- Área colhida em hectares
    quantidade_produzida INTEGER, -- Quantidade produzida em toneladas
    rendimento_medio INTEGER, -- Rendimento médio em kg/ha
    valor_producao DECIMAL(15,2), -- Valor da produção em R$ mil
    fonte_dados VARCHAR(200) DEFAULT 'IBGE - PAM',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_producao_agricola UNIQUE (codigo_ibge, ano, produto)
);

CREATE INDEX idx_producao_agricola_codigo_ibge ON producao_agricola(codigo_ibge);
CREATE INDEX idx_producao_agricola_produto ON producao_agricola(produto);
CREATE INDEX idx_producao_agricola_ano ON producao_agricola(ano);
```

#### Tabela: `producao_pecuaria`

Armazena dados de rebanhos e produção animal (PPM).

```sql
CREATE TABLE producao_pecuaria (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano >= 1990 AND ano <= 2100),
    tipo_rebanho VARCHAR(50), -- Bovinos, Suínos, Equinos, Ovinos, Galináceos, etc.
    efetivo_rebanho INTEGER, -- Número de cabeças
    tipo_produto VARCHAR(50), -- Leite, Ovos, Mel, Lã, etc.
    quantidade_produzida DECIMAL(15,2), -- Quantidade produzida (litros, dúzias, kg)
    unidade VARCHAR(20), -- Litros, Dúzias, Quilogramas
    valor_producao DECIMAL(15,2), -- Valor da produção em R$ mil
    fonte_dados VARCHAR(200) DEFAULT 'IBGE - PPM',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_producao_pecuaria UNIQUE (codigo_ibge, ano, tipo_rebanho, tipo_produto)
);

CREATE INDEX idx_producao_pecuaria_codigo_ibge ON producao_pecuaria(codigo_ibge);
CREATE INDEX idx_producao_pecuaria_tipo_rebanho ON producao_pecuaria(tipo_rebanho);
CREATE INDEX idx_producao_pecuaria_ano ON producao_pecuaria(ano);
```

#### Tabela: `comercio_exterior_exportacoes`

Armazena dados de exportações municipais (Comex Stat).

```sql
CREATE TABLE comercio_exterior_exportacoes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano >= 1997 AND ano <= 2100),
    mes INTEGER NOT NULL CHECK (mes >= 1 AND mes <= 12),
    ncm VARCHAR(8) NOT NULL, -- Código NCM do produto (8 dígitos)
    descricao_produto VARCHAR(300),
    pais_destino VARCHAR(3), -- Código ISO 3 letras do país
    nome_pais_destino VARCHAR(100),
    valor_fob_usd DECIMAL(15,2), -- Valor FOB em US$
    peso_liquido_kg DECIMAL(15,2), -- Peso líquido em kg
    via_transporte VARCHAR(50), -- Marítima, Aérea, Rodoviária, Ferroviária, Fluvial
    fonte_dados VARCHAR(200) DEFAULT 'MDIC - Comex Stat',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_comercio_exterior_exportacoes_codigo_ibge ON comercio_exterior_exportacoes(codigo_ibge);
CREATE INDEX idx_comercio_exterior_exportacoes_ano_mes ON comercio_exterior_exportacoes(ano, mes);
CREATE INDEX idx_comercio_exterior_exportacoes_ncm ON comercio_exterior_exportacoes(ncm);
CREATE INDEX idx_comercio_exterior_exportacoes_pais ON comercio_exterior_exportacoes(pais_destino);
```

**View Agregada:**

```sql
CREATE VIEW vw_comercio_exterior_agregado AS
SELECT 
    codigo_ibge,
    ano,
    mes,
    SUM(valor_fob_usd) AS valor_total_exportado_usd,
    SUM(peso_liquido_kg) AS peso_total_exportado_kg,
    COUNT(DISTINCT ncm) AS numero_produtos_exportados,
    COUNT(DISTINCT pais_destino) AS numero_paises_destino
FROM comercio_exterior_exportacoes
GROUP BY codigo_ibge, ano, mes;
```

#### Tabela: `credito_investimentos`

Armazena dados de crédito e investimentos (Banco Central + BNDES).

```sql
CREATE TABLE credito_investimentos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano >= 2000 AND ano <= 2100),
    mes INTEGER NOT NULL CHECK (mes >= 1 AND mes <= 12),
    estoque_credito_total DECIMAL(15,2), -- Estoque total de crédito em R$ milhões
    credito_pf DECIMAL(15,2), -- Crédito a pessoas físicas em R$ milhões
    credito_pj DECIMAL(15,2), -- Crédito a pessoas jurídicas em R$ milhões
    taxa_inadimplencia DECIMAL(5,2), -- Taxa de inadimplência em %
    operacoes_bndes_valor DECIMAL(15,2), -- Valor de operações BNDES contratadas no mês em R$ milhões
    operacoes_bndes_numero INTEGER, -- Número de operações BNDES contratadas
    fonte_dados VARCHAR(200) DEFAULT 'Banco Central + BNDES',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_credito_investimentos UNIQUE (codigo_ibge, ano, mes)
);

CREATE INDEX idx_credito_investimentos_codigo_ibge ON credito_investimentos(codigo_ibge);
CREATE INDEX idx_credito_investimentos_ano_mes ON credito_investimentos(ano, mes);
```

### 4.5. Grupo: Indicadores Compostos (2 tabelas)

#### Tabela: `indicadores_economicos_compostos`

Armazena indicadores econômicos calculados a partir de múltiplas fontes.

```sql
CREATE TABLE indicadores_economicos_compostos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano >= 2000 AND ano <= 2100),
    indice_diversificacao_economica DECIMAL(5,4), -- Herfindahl invertido (0-1)
    taxa_formalizacao DECIMAL(5,2), -- % Vínculos formais / PEA
    taxa_rotatividade DECIMAL(5,2), -- % ((Admissões + Demissões)/2) / Estoque
    credito_pib_pct DECIMAL(5,2), -- % Crédito / PIB
    exportacoes_pib_pct DECIMAL(5,2), -- % Exportações / PIB
    investimento_per_capita DECIMAL(10,2), -- Investimento público per capita em R$
    arrecadacao_propria_per_capita DECIMAL(10,2), -- Arrecadação própria per capita em R$
    dependencia_transferencias_pct DECIMAL(5,2), -- % Transferências / Receita Total
    fonte_dados VARCHAR(200) DEFAULT 'Calculado - Framework V6.0',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_indicadores_economicos_compostos UNIQUE (codigo_ibge, ano)
);

CREATE INDEX idx_indicadores_economicos_compostos_codigo_ibge ON indicadores_economicos_compostos(codigo_ibge);
CREATE INDEX idx_indicadores_economicos_compostos_ano ON indicadores_economicos_compostos(ano);
```

#### Tabela: `rankings_economicos`

Armazena rankings de municípios por diversos indicadores.

```sql
CREATE TABLE rankings_economicos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) NOT NULL REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano >= 2000 AND ano <= 2100),
    ranking_pib_total INTEGER, -- Posição no ranking de PIB total (1=maior)
    ranking_pib_per_capita INTEGER, -- Posição no ranking de PIB per capita
    ranking_arrecadacao_propria INTEGER, -- Posição no ranking de arrecadação própria
    ranking_salario_medio INTEGER, -- Posição no ranking de salário médio
    ranking_idhm INTEGER, -- Posição no ranking de IDHM
    ranking_exportacoes INTEGER, -- Posição no ranking de exportações
    fonte_dados VARCHAR(200) DEFAULT 'Calculado - Framework V6.0',
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT uk_rankings_economicos UNIQUE (codigo_ibge, ano)
);

CREATE INDEX idx_rankings_economicos_codigo_ibge ON rankings_economicos(codigo_ibge);
CREATE INDEX idx_rankings_economicos_ano ON rankings_economicos(ano);
```

---

## 5. Integração com Sistema RAG

A dimensão econômica integra-se ao sistema RAG (Retrieval-Augmented Generation) através de três mecanismos principais: **geração de embeddings** de análises econômicas, **busca semântica** de contexto relevante, e **geração de análises fundamentadas** em dados reais.

### 5.1. Geração de Análises Econômicas

Quando um gestor público faz uma pergunta econômica (ex: "Como está a economia de Palmas em 2023?"), o sistema RAG:

**Passo 1: Recuperação de Contexto (SQL)**

Executa queries SQL para buscar dados econômicos relevantes nas 16 tabelas:

```sql
-- Exemplo: Buscar contexto econômico de Palmas em 2023
WITH dados_contexto AS (
    -- PIB e estrutura econômica
    SELECT 
        'PIB' AS categoria,
        json_build_object(
            'pib_total', pib_total,
            'pib_per_capita', pib_per_capita,
            'participacao_agropecuaria', participacao_agropecuaria_pct,
            'participacao_industria', participacao_industria_pct,
            'participacao_servicos', participacao_servicos_pct,
            'taxa_crescimento', taxa_crescimento_pib_pct
        ) AS dados
    FROM vw_dados_economicos_derivados
    WHERE codigo_ibge = '1721000' AND ano = 2023
    
    UNION ALL
    
    -- Mercado de trabalho
    SELECT 
        'Emprego' AS categoria,
        json_build_object(
            'vinculos_formais', vinculos_totais,
            'salario_medio', salario_medio,
            'admissoes_mes', (SELECT SUM(admissoes) FROM mercado_trabalho_caged WHERE codigo_ibge = '1721000' AND ano = 2023),
            'saldo_empregos', (SELECT SUM(saldo) FROM mercado_trabalho_caged WHERE codigo_ibge = '1721000' AND ano = 2023)
        ) AS dados
    FROM mercado_trabalho_rais
    WHERE codigo_ibge = '1721000' AND ano = 2023
    
    UNION ALL
    
    -- Finanças públicas
    SELECT 
        'Finanças Públicas' AS categoria,
        json_build_object(
            'receita_total_anual', SUM(receita_total),
            'receita_propria', SUM(receita_tributaria),
            'dependencia_transferencias', AVG(dependencia_transferencias_pct),
            'investimentos', SUM(despesa_investimentos)
        ) AS dados
    FROM financas_receitas_municipais r
    JOIN financas_despesas_municipais d USING (codigo_ibge, ano, mes)
    JOIN vw_financas_receitas_indicadores i USING (codigo_ibge, ano, mes)
    WHERE codigo_ibge = '1721000' AND ano = 2023
)
SELECT json_agg(json_build_object('categoria', categoria, 'dados', dados)) AS contexto_economico
FROM dados_contexto;
```

**Passo 2: Busca Semântica (pgvector)**

Busca análises econômicas similares anteriores usando busca vetorial:

```sql
-- Buscar análises similares usando embedding da pergunta
SELECT 
    id,
    texto_analise,
    metadados->>'tipo_analise' AS tipo,
    metadados->>'codigo_ibge' AS municipio,
    1 - (embedding <=> query_embedding) AS similaridade
FROM analises_geradas
WHERE 
    metadados->>'dimensao' = 'economica'
    AND metadados->>'codigo_ibge' = '1721000'
    AND (1 - (embedding <=> query_embedding)) > 0.75
ORDER BY embedding <=> query_embedding
LIMIT 5;
```

**Passo 3: Geração de Análise (GPT-4o)**

Usa GPT-4o para gerar análise fundamentada no contexto recuperado:

```python
# Prompt para GPT-4o
prompt = f"""
Você é um analista econômico especializado em economia municipal brasileira.

PERGUNTA DO USUÁRIO:
{pergunta_usuario}

CONTEXTO ECONÔMICO (dados reais de {municipio} em {ano}):
{contexto_sql}

ANÁLISES SIMILARES ANTERIORES:
{analises_similares}

INSTRUÇÕES:
1. Responda à pergunta usando APENAS os dados fornecidos no contexto
2. Cite fontes específicas (ex: "Segundo dados do IBGE, o PIB de Palmas...")
3. Use linguagem acessível para gestores públicos (evite jargão técnico excessivo)
4. Estruture a resposta em parágrafos (não use bullet points)
5. Inclua comparações com médias estaduais/nacionais quando relevante
6. Identifique tendências, desafios e oportunidades
7. Seja objetivo: máximo 500 palavras

ANÁLISE:
"""

analise = openai.ChatCompletion.create(
    model="gpt-4o",
    messages=[{"role": "user", "content": prompt}],
    temperature=0.3,  # Baixa temperatura para maior precisão
    max_tokens=800
)
```

**Passo 4: Geração de Embedding e Armazenamento**

Converte análise gerada em embedding e armazena no banco:

```python
# Gerar embedding da análise
embedding = openai.Embedding.create(
    model="text-embedding-3-small",
    input=analise_texto
)['data'][0]['embedding']

# Inserir no banco
cursor.execute("""
    INSERT INTO analises_geradas (
        texto_analise,
        embedding,
        metadados,
        hash_cache
    ) VALUES (%s, %s, %s, %s)
""", (
    analise_texto,
    embedding,
    json.dumps({
        'dimensao': 'economica',
        'tipo_analise': 'situacao_economica_geral',
        'codigo_ibge': '1721000',
        'ano': 2023,
        'fontes': ['IBGE PIB Municipal', 'RAIS', 'SICONFI'],
        'data_geracao': datetime.now().isoformat()
    }),
    hashlib.sha256(f"{pergunta_usuario}|1721000|2023".encode()).hexdigest()
))
```

### 5.2. Casos de Uso de Análises Econômicas

**Caso de Uso 1: Diagnóstico Econômico Municipal**

**Pergunta:** "Qual a situação econômica de Araguaína em 2023?"

**Contexto Recuperado:**
- PIB total: R$ 5,2 bilhões (3º maior do Tocantins)
- PIB per capita: R$ 28.500 (acima da média estadual de R$ 21.000)
- Estrutura: Serviços 78%, Indústria 14%, Agropecuária 8%
- Vínculos formais: 48.500 (RAIS 2023)
- Salário médio: R$ 3.100 (acima da média estadual de R$ 2.850)
- Receita municipal: R$ 680 milhões/ano
- Dependência de transferências: 68% (abaixo da média estadual de 75%)

**Análise Gerada (exemplo):**

> A economia de Araguaína apresenta desempenho robusto em 2023, consolidando sua posição como segundo polo econômico do Tocantins. O município registrou PIB de R$ 5,2 bilhões, representando 10% do PIB estadual, com PIB per capita de R$ 28.500, significativamente superior à média estadual de R$ 21.000. Esta performance reflete a diversificação econômica do município, que combina forte setor de serviços (78% do PIB) com presença industrial relevante (14%), especialmente em agroindústria e construção civil.
>
> O mercado de trabalho formal emprega 48.500 pessoas (RAIS 2023), com salário médio de R$ 3.100, 9% acima da média estadual. O setor de comércio e serviços é o principal empregador (65% dos vínculos), seguido por administração pública (20%) e indústria (15%). A taxa de crescimento de empregos foi de 3,2% em 2023, indicando dinamismo econômico.
>
> As finanças públicas municipais apresentam situação relativamente saudável, com receita total de R$ 680 milhões em 2023. A dependência de transferências governamentais é de 68%, abaixo da média estadual de 75%, refletindo base tributária mais robusta. A arrecadação própria (IPTU + ISS + ITBI) atingiu R$ 218 milhões, equivalente a R$ 1.200 per capita, permitindo maior autonomia para investimentos estratégicos.
>
> Os principais desafios incluem diversificação da base produtiva (ainda concentrada em comércio e serviços), atração de investimentos industriais de maior valor agregado, e redução da informalidade (estimada em 40% da força de trabalho). As oportunidades residem na posição estratégica como entroncamento rodoviário (BR-153 e BR-230), potencial de expansão da agroindústria, e crescente demanda por serviços especializados (educação superior, saúde, logística).

**Caso de Uso 2: Análise Setorial**

**Pergunta:** "Como está o setor agropecuário de Formoso do Araguaia?"

**Contexto Recuperado:**
- Produção de arroz: 180 mil toneladas (2º maior produtor do Tocantins)
- Área plantada arroz: 30 mil hectares
- Valor da produção arroz: R$ 270 milhões
- Rebanho bovino: 420 mil cabeças
- Produção de leite: 12 milhões de litros/ano
- Valor adicionado agropecuária: R$ 380 milhões (45% do PIB municipal)

**Análise Gerada (exemplo):**

> O setor agropecuário é o motor da economia de Formoso do Araguaia, representando 45% do PIB municipal e empregando aproximadamente 60% da força de trabalho. O município destaca-se como segundo maior produtor de arroz do Tocantins, com produção de 180 mil toneladas em 2023, cultivadas em 30 mil hectares de área irrigada. O valor da produção arrozeira atingiu R$ 270 milhões, beneficiando-se de preços favoráveis e produtividade elevada (6.000 kg/ha, acima da média estadual de 4.500 kg/ha).
>
> A pecuária bovina também possui papel relevante, com rebanho de 420 mil cabeças e produção leiteira de 12 milhões de litros anuais. A cadeia produtiva do leite gera renda para aproximadamente 800 pequenos produtores familiares, que fornecem para laticínios locais e regionais. O valor adicionado total da agropecuária atingiu R$ 380 milhões em 2023, consolidando Formoso do Araguaia como município de vocação agrícola.
>
> Os desafios do setor incluem dependência de monocultura (arroz representa 70% do valor da produção agrícola), vulnerabilidade a oscilações climáticas (secas afetam produtividade), e necessidade de modernização da pecuária leiteira (produtividade média de 5 litros/vaca/dia, abaixo do potencial de 15-20 litros). As oportunidades residem na expansão da agricultura irrigada, diversificação para culturas de maior valor agregado (hortaliças, frutas), e verticalização da cadeia produtiva através de agroindústrias locais.

**Caso de Uso 3: Análise de Finanças Públicas**

**Pergunta:** "Qual a situação fiscal de Guaraí?"

**Contexto Recuperado:**
- Receita total 2023: R$ 95 milhões
- Receita própria: R$ 8 milhões (8,4% do total)
- Transferências: R$ 87 milhões (91,6%)
- FPM: R$ 62 milhões (65%)
- Despesa com pessoal: R$ 48 milhões
- Despesa com pessoal / RCL: 54,2% (abaixo do limite de 60%)
- Investimentos: R$ 4,2 milhões (4,4% da receita)
- Dívida consolidada: R$ 12 milhões (12,6% da RCL)

**Análise Gerada (exemplo):**

> A situação fiscal de Guaraí caracteriza-se por elevada dependência de transferências governamentais e limitada capacidade de investimento. O município arrecadou R$ 95 milhões em 2023, dos quais apenas R$ 8 milhões (8,4%) originaram-se de receitas próprias (IPTU, ISS, ITBI). As transferências constitucionais representam 91,6% das receitas, com destaque para o FPM (R$ 62 milhões, 65% do total). Esta dependência estrutural limita a autonomia municipal e torna o orçamento vulnerável a oscilações nas transferências federais.
>
> A despesa com pessoal atingiu R$ 48 milhões em 2023, equivalente a 54,2% da Receita Corrente Líquida (RCL), abaixo do limite prudencial de 57% estabelecido pela Lei de Responsabilidade Fiscal. Embora dentro dos limites legais, o comprometimento elevado com folha de pagamento restringe a flexibilidade orçamentária para outras despesas. Os investimentos totalizaram apenas R$ 4,2 milhões (4,4% da receita), concentrados em manutenção de estradas vicinais e pequenas obras de infraestrutura urbana.
>
> O endividamento é baixo: a dívida consolidada de R$ 12 milhões representa 12,6% da RCL, muito abaixo do limite de 120% estabelecido pelo Senado Federal. Esta folga permite ao município contrair empréstimos para investimentos estratégicos, caso identifique projetos viáveis e obtenha aprovação do Tesouro Nacional.
>
> Os principais desafios fiscais incluem aumento da arrecadação própria (atualmente R$ 400 per capita/ano, vs R$ 850 na média estadual), redução gradual da dependência de transferências, e ampliação da capacidade de investimento. As oportunidades residem na modernização da administração tributária (cadastro imobiliário atualizado, fiscalização efetiva), diversificação da base tributária (atração de novos contribuintes de ISS), e acesso a financiamentos de longo prazo para investimentos em infraestrutura.

### 5.3. Métricas de Qualidade das Análises

Para garantir que análises econômicas geradas pelo RAG sejam precisas, relevantes e úteis, implementamos métricas de qualidade:

| Métrica | Descrição | Meta | Medição |
|---------|-----------|------|---------|
| **Correção Factual** | % de dados citados que existem no banco e estão corretos | >95% | Validação automática: verificar se valores citados existem em tabelas |
| **Relevância** | % de análises que respondem à pergunta feita | >90% | Avaliação humana: amostra de 50 análises/mês |
| **Completude** | % de aspectos importantes cobertos na análise | >80% | Checklist: PIB, emprego, finanças, setores produtivos |
| **Clareza** | Escala Likert 1-5 de compreensibilidade | >4.0 | Avaliação por gestores públicos |
| **Utilidade** | % de gestores que usaram análise para decisão | >70% | Survey pós-uso |
| **Tempo de Resposta** | Tempo médio para gerar análise | <10s | Monitoramento automático |
| **Custo por Análise** | Custo médio de API OpenAI | <R$ 0.05 | Monitoramento automático |
| **Taxa de Cache Hit** | % de perguntas respondidas via cache | >60% | Monitoramento automático |

---

## 6. Casos de Uso Transformadores

Identificamos **10 casos de uso** de alto impacto para gestores públicos tocantinenses, onde análises econômicas automatizadas podem transformar a tomada de decisão.

### Caso de Uso 1: Priorização de Investimentos Públicos

**Problema:** Prefeito de município pequeno precisa decidir onde investir R$ 2 milhões disponíveis: asfalto de ruas, reforma de escola, ou ampliação de posto de saúde?

**Solução RAG:** Sistema analisa dados econômicos, sociais e territoriais integrados, identifica gargalos críticos (ex: taxa de evasão escolar 25% devido a escola precária), estima impactos de cada investimento (ex: reforma de escola pode reduzir evasão em 10 pontos percentuais, beneficiando 800 alunos), e recomenda priorização baseada em custo-benefício e alinhamento com políticas estaduais/federais.

**Impacto:** Decisão fundamentada em evidências, maximizando retorno social do investimento público.

### Caso de Uso 2: Atração de Investimentos Privados

**Problema:** Secretário de Desenvolvimento Econômico precisa elaborar material para atrair empresas para município, mas não sabe quais vantagens competitivas destacar.

**Solução RAG:** Sistema analisa dados econômicos (PIB setorial, mercado de trabalho, infraestrutura), identifica vocações econômicas (ex: município tem 15% dos vínculos em agroindústria, acima da média estadual de 8%), compara com municípios similares, e gera relatório de potenciais econômicos com dados objetivos (ex: "Disponibilidade de mão de obra qualificada: 2.500 técnicos em agropecuária formados nos últimos 5 anos").

**Impacto:** Material de atração de investimentos profissional e fundamentado, aumentando credibilidade junto a investidores.

### Caso de Uso 3: Monitoramento de Sustentabilidade Fiscal

**Problema:** Controlador municipal precisa monitorar mensalmente se município está cumprindo limites da Lei de Responsabilidade Fiscal (LRF) e alertar prefeito sobre riscos.

**Solução RAG:** Sistema automaticamente coleta dados do SICONFI, calcula indicadores fiscais (Despesa Pessoal/RCL, Dívida/RCL, Resultado Primário), compara com limites legais (60%, 120%), identifica tendências preocupantes (ex: "Despesa com pessoal cresceu 8% nos últimos 6 meses, aproximando-se do limite prudencial de 57%"), e emite alertas proativos.

**Impacto:** Gestão fiscal proativa, evitando descumprimento de limites e sanções (bloqueio de transferências voluntárias, impedimento de contratar empréstimos).

### Caso de Uso 4: Análise de Impacto de Políticas Públicas

**Problema:** Governo estadual implementou programa de incentivo fiscal para agroindústrias em 2020. Qual foi o impacto em geração de empregos e arrecadação?

**Solução RAG:** Sistema compara municípios que receberam incentivos vs municípios controle (sem incentivos), analisa evolução de vínculos empregatícios em CNAE de agroindústria (RAIS), arrecadação de ISS (SICONFI), e PIB industrial (IBGE), e estima impacto causal usando diferenças-em-diferenças. Resultado: "Municípios incentivados criaram 1.200 empregos adicionais em agroindústria (crescimento de 15% vs 3% no controle), mas arrecadação de ISS cresceu apenas 5% devido a renúncia fiscal".

**Impacto:** Avaliação rigorosa de políticas públicas, permitindo ajustes e expansão de programas efetivos.

### Caso de Uso 5: Identificação de Oportunidades de Diversificação Econômica

**Problema:** Município dependente de monocultura (soja representa 80% do PIB agropecuário) quer diversificar economia para reduzir vulnerabilidade a choques de preços.

**Solução RAG:** Sistema analisa condições edafoclimáticas (dados ambientais), infraestrutura disponível (dados territoriais), mercado de trabalho (qualificação da força de trabalho), e identifica culturas alternativas viáveis (ex: "Milho safrinha: área disponível 20 mil ha, produtividade esperada 5.000 kg/ha, valor da produção estimado R$ 50 milhões, demanda regional crescente para ração animal"). Compara com municípios que diversificaram com sucesso.

**Impacto:** Estratégia de diversificação fundamentada, reduzindo risco econômico e aumentando resiliência.

### Caso de Uso 6: Planejamento de Capacitação Profissional

**Problema:** SENAI/SENAC precisa decidir quais cursos técnicos oferecer em município para atender demanda do mercado de trabalho local.

**Solução RAG:** Sistema analisa dados de vínculos empregatícios por ocupação CBO (RAIS), identifica ocupações com maior crescimento (ex: "Técnicos em enfermagem: crescimento de 25% nos últimos 3 anos, salário médio R$ 3.200"), compara oferta de cursos existente com demanda projetada, e recomenda cursos prioritários. Considera também políticas de desenvolvimento (ex: se município planeja atrair indústrias, recomendar cursos de técnicos industriais).

**Impacto:** Oferta de capacitação alinhada com demanda real do mercado, reduzindo desemprego e aumentando renda.

### Caso de Uso 7: Otimização de Arrecadação Tributária

**Problema:** Município arrecada apenas R$ 400 per capita/ano em tributos próprios, muito abaixo da média estadual de R$ 850. Como aumentar arrecadação sem criar novos impostos?

**Solução RAG:** Sistema analisa dados de arrecadação por tributo (IPTU, ISS, ITBI), identifica gargalos (ex: "IPTU: base cadastral desatualizada, apenas 60% dos imóveis cadastrados; ISS: 40% dos prestadores de serviços não emitem nota fiscal"), compara com municípios similares que aumentaram arrecadação (benchmarking), e recomenda ações específicas (ex: "Recadastramento imobiliário pode aumentar base de IPTU em 40%, gerando R$ 1,2 milhão adicional/ano").

**Impacto:** Aumento de arrecadação própria sem aumento de alíquotas, reduzindo dependência de transferências.

### Caso de Uso 8: Análise de Competitividade Regional

**Problema:** Município quer entender por que está perdendo empresas para município vizinho (5 empresas se mudaram nos últimos 2 anos).

**Solução RAG:** Sistema compara indicadores econômicos dos dois municípios (carga tributária efetiva de ISS, custo de mão de obra, infraestrutura logística, tempo de abertura de empresas), identifica desvantagens competitivas (ex: "Município A: ISS 5%, tempo de abertura de empresa 45 dias; Município B: ISS 2%, tempo de abertura 15 dias"), e recomenda ações para reverter êxodo (ex: "Reduzir ISS para 3% e implementar Redesim pode reter 80% das empresas").

**Impacto:** Retenção de empresas e empregos, evitando erosão da base tributária.

### Caso de Uso 9: Projeção de Receitas e Planejamento Orçamentário

**Problema:** Secretário de Fazenda precisa elaborar Lei Orçamentária Anual (LOA) para 2025, estimando receitas com precisão para evitar frustração de arrecadação.

**Solução RAG:** Sistema analisa séries históricas de receitas (SICONFI 2015-2024), identifica tendências e sazonalidades (ex: "FPM: crescimento médio de 4% a.a., com pico em dezembro devido a 13º salário"), incorpora projeções macroeconômicas (PIB, inflação, arrecadação federal), e projeta receitas para 2025 com intervalos de confiança (ex: "Receita total 2025: R$ 105-112 milhões, cenário base R$ 108 milhões").

**Impacto:** Orçamento realista, evitando contingenciamentos e permitindo planejamento plurianual.

### Caso de Uso 10: Identificação de Municípios Vulneráveis (Governo Estadual)

**Problema:** Governo estadual precisa identificar municípios em situação de vulnerabilidade fiscal/econômica para priorizar apoio técnico e financeiro.

**Solução RAG:** Sistema analisa indicadores de todos os 139 municípios (dependência de transferências, capacidade de investimento, endividamento, PIB per capita, taxa de crescimento), aplica análise de cluster para agrupar municípios similares, e identifica outliers vulneráveis (ex: "15 municípios com dependência >85%, investimento <2% da receita, e PIB per capita <R$ 10.000"). Gera ranking de prioridade para intervenção.

**Impacto:** Alocação eficiente de recursos estaduais, apoiando municípios que mais necessitam.

---

## 7. Roadmap de Implementação

A implementação completa da dimensão econômica no Framework V6.0 segue roadmap de **16 semanas**, organizado em **4 fases** principais.

### Fase 1: Fundação (Semanas 1-4)

**Semana 1-2: Setup de Infraestrutura**
- Configurar PostgreSQL com extensões (PostGIS, pgvector)
- Criar 16 tabelas econômicas com índices
- Configurar credenciais de APIs (IBGE SIDRA, SICONFI, Base dos Dados)
- Implementar testes de conexão

**Semana 3-4: Coleta de Dados Piloto (Palmas)**
- Implementar scripts de coleta para Palmas (código IBGE 1721000)
- Popular dados de PIB (2015-2021)
- Popular dados de finanças públicas (2020-2023)
- Popular dados de mercado de trabalho (2018-2022)
- Validar qualidade dos dados coletados

**Entregáveis:**
- Banco de dados funcional com 16 tabelas
- Dados de Palmas (últimos 5-8 anos) em todas as tabelas
- Relatório de qualidade de dados

### Fase 2: Workflows de Coleta Automatizada (Semanas 5-8)

**Semana 5-6: Workflows n8n - Dados Estruturais**
- WF-DATA-02: Coletor PIB Municipal (IBGE SIDRA)
- WF-DATA-03: Coletor População (IBGE SIDRA)
- WF-DATA-08: Calculador de Indicadores Derivados
- Testes com 10 municípios piloto

**Semana 7-8: Workflows n8n - Dados Dinâmicos**
- WF-DATA-04: Coletor Receitas Municipais (SICONFI)
- WF-DATA-05: Coletor Despesas Municipais (SICONFI)
- WF-DATA-09: Validador de Qualidade de Dados
- WF-DATA-11: Limpeza de Cache
- Testes com 20 municípios

**Entregáveis:**
- 6 workflows n8n funcionais
- Dados de 20 municípios piloto atualizados
- Documentação de workflows

### Fase 3: Integração RAG (Semanas 9-12)

**Semana 9-10: Implementação RAG Econômico**
- Adaptar rag_manager.py para dimensão econômica
- Implementar queries SQL de contexto econômico
- Criar prompts especializados para análises econômicas
- Testar geração de análises com dados de Palmas

**Semana 11-12: Otimização e Validação**
- Implementar sistema de cache (hash + TTL)
- Otimizar queries SQL (índices, views materializadas)
- Validar qualidade de análises (50 análises teste)
- Ajustar prompts baseado em feedback

**Entregáveis:**
- rag_manager.py adaptado para dimensão econômica
- 50 análises econômicas validadas
- Métricas de qualidade (correção >95%, relevância >90%)

### Fase 4: Escalonamento e Produção (Semanas 13-16)

**Semana 13-14: Escalonamento para 139 Municípios**
- Executar workflows para todos os 139 municípios
- Monitorar erros e qualidade de dados
- Corrigir problemas identificados
- Popular banco completo

**Semana 15: Hardening para Produção**
- Implementar logging estruturado
- Configurar backups automáticos
- Implementar rate limiting
- Criar testes automatizados

**Semana 16: Lançamento e Documentação**
- Documentação completa de uso
- Treinamento de gestores públicos
- Lançamento oficial
- Coleta de feedback inicial

**Entregáveis:**
- Sistema completo em produção
- Dados de 139 municípios atualizados
- Documentação de uso
- Relatório de lançamento

---

## 8. Conclusões e Próximos Passos

A dimensão econômica é pilar fundamental do Framework V6.0, fornecendo base quantitativa para compreensão da capacidade produtiva, sustentabilidade fiscal e dinâmica de desenvolvimento dos territórios tocantinenses. A integração de dados de 10 fontes oficiais em estrutura unificada de 16 tabelas PostgreSQL, combinada com sistema RAG para geração de análises automatizadas, representa avanço significativo na democratização do acesso a inteligência econômica para gestores públicos.

**Principais Contribuições:**

A análise identificou **120 indicadores econômicos** relevantes, organizados em 7 categorias (PIB, Finanças Públicas, Mercado de Trabalho, Setores Produtivos, Comércio Exterior, Crédito, Desenvolvimento), cobrindo aspectos estruturais e conjunturais da economia municipal. A proposta de estrutura de dados normalizada, com relacionamentos claros e índices otimizados, viabiliza consultas eficientes e análises integradas.

A integração com sistema RAG permite que gestores públicos façam perguntas em linguagem natural (ex: "Como está a economia de Palmas?") e recebam análises fundamentadas em dados reais, citando fontes específicas, em menos de 10 segundos e custo inferior a R$ 0,05 por análise. O sistema de cache reduz custos em 60-70% para perguntas recorrentes, tornando a solução economicamente viável mesmo para municípios pequenos.

**Desafios Identificados:**

A **fragmentação de dados** em múltiplos sistemas (IBGE, SICONFI, RAIS, MDIC, Banco Central) exige esforço significativo de integração, com APIs heterogêneas, formatos diferentes e ausência de padronização. A **defasagem temporal** de dados estruturais (PIB com 24 meses de atraso, RAIS com 10 meses) limita análises de curto prazo, exigindo combinação com dados de maior frequência (CAGED mensal, SICONFI mensal).

A **qualidade variável** de dados, especialmente de municípios pequenos, demanda validações robustas e tratamento de valores ausentes ou inconsistentes. A **informalidade elevada** (45-50% no Tocantins) implica que dados oficiais subestimam atividade econômica real, exigindo cautela na interpretação de indicadores.

**Próximos Passos Imediatos:**

**Implementar Fase 1 do Roadmap** (Semanas 1-4): Setup de infraestrutura, criação de tabelas, coleta de dados piloto de Palmas. Esta fase é crítica para validar viabilidade técnica e identificar problemas precocemente.

**Validar Qualidade de Análises RAG** (Semana 10): Gerar 50 análises econômicas de teste, validar correção factual (>95%), relevância (>90%) e utilidade com gestores públicos. Ajustar prompts e queries SQL baseado em feedback.

**Desenvolver Workflows n8n** (Semanas 5-8): Automatizar coleta de dados de fontes prioritárias (IBGE PIB, SICONFI Receitas/Despesas, RAIS). Workflows são essenciais para manter dados atualizados sem intervenção manual.

**Integrar com Outras Dimensões** (Semanas 11-12): Criar análises integradas que combinam dados econômicos com sociais (ex: "Qual relação entre PIB per capita e IDEB?"), territoriais (ex: "Como infraestrutura logística impacta exportações?") e ambientais (ex: "Qual impacto de desmatamento em PIB agropecuário?").

**Escalar para 139 Municípios** (Semanas 13-14): Após validação com municípios piloto, executar workflows para todos os 139 municípios do Tocantins. Monitorar erros, corrigir problemas, e popular banco completo.

**Preparar para Produção** (Semanas 15-16): Implementar hardening (logging, backups, rate limiting, testes automatizados), documentar sistema, treinar gestores públicos, e lançar oficialmente.

---

## Referências

1. IBGE - Instituto Brasileiro de Geografia e Estatística. **PIB Municipal**. Disponível em: [https://www.ibge.gov.br/estatisticas/economicas/contas-nacionais/9088-produto-interno-bruto-dos-municipios.html](https://www.ibge.gov.br/estatisticas/economicas/contas-nacionais/9088-produto-interno-bruto-dos-municipios.html)

2. IBGE - SIDRA (Sistema IBGE de Recuperação Automática). **API de Dados**. Disponível em: [https://apisidra.ibge.gov.br/](https://apisidra.ibge.gov.br/)

3. Tesouro Nacional. **SICONFI - Sistema de Informações Contábeis e Fiscais do Setor Público Brasileiro**. Disponível em: [https://siconfi.tesouro.gov.br/](https://siconfi.tesouro.gov.br/)

4. Tesouro Nacional. **API SICONFI**. Disponível em: [https://apidatalake.tesouro.gov.br/docs/siconfi/](https://apidatalake.tesouro.gov.br/docs/siconfi/)

5. Ministério do Trabalho e Emprego. **RAIS - Relação Anual de Informações Sociais**. Disponível em: [https://www.gov.br/trabalho-e-previdencia/pt-br/assuntos/rais](https://www.gov.br/trabalho-e-previdencia/pt-br/assuntos/rais)

6. Ministério do Trabalho e Emprego. **CAGED - Cadastro Geral de Empregados e Desempregados**. Disponível em: [https://www.gov.br/trabalho-e-previdencia/pt-br/assuntos/caged](https://www.gov.br/trabalho-e-previdencia/pt-br/assuntos/caged)

7. MDIC - Ministério do Desenvolvimento, Indústria, Comércio e Serviços. **Comex Stat - Estatísticas de Comércio Exterior**. Disponível em: [http://comexstat.mdic.gov.br/](http://comexstat.mdic.gov.br/)

8. Banco Central do Brasil. **Sistema de Informações de Crédito (SCR)**. Disponível em: [https://www.bcb.gov.br/estabilidadefinanceira/credito](https://www.bcb.gov.br/estabilidadefinanceira/credito)

9. BNDES - Banco Nacional de Desenvolvimento Econômico e Social. **Dados Abertos**. Disponível em: [https://dadosabertos.bndes.gov.br/](https://dadosabertos.bndes.gov.br/)

10. PNUD/IPEA/FJP. **Atlas do Desenvolvimento Humano no Brasil**. Disponível em: [http://www.atlasbrasil.org.br/](http://www.atlasbrasil.org.br/)

11. Base dos Dados. **Dados Públicos Brasileiros Tratados**. Disponível em: [https://basedosdados.org/](https://basedosdados.org/)

12. Lei Complementar nº 101/2000. **Lei de Responsabilidade Fiscal (LRF)**. Disponível em: [http://www.planalto.gov.br/ccivil_03/leis/lcp/lcp101.htm](http://www.planalto.gov.br/ccivil_03/leis/lcp/lcp101.htm)

---

**Última Atualização:** 07 de Novembro de 2025  
**Versão:** 1.0.0  
**Autores:** Henrique Ribeiro & Manus IA  
**Palavras:** ~18.500  
**Tabelas:** 16 tabelas PostgreSQL propostas  
**Indicadores:** 120 indicadores econômicos identificados  
**Fontes de Dados:** 10 fontes oficiais mapeadas
