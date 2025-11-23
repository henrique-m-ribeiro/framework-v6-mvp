# Análise Abrangente da Dimensão Social - Framework V6.0

**Framework de Interação Galáctica V6.0**  
**Versão:** 1.0  
**Data:** 07 de Novembro de 2025  
**Autores:** Henrique Ribeiro & Manus IA

---

## Sumário Executivo

Este documento apresenta uma análise abrangente e detalhada de todos os dados relevantes para a **dimensão social** do Framework de Interação Galáctica V6.0, focando nos 139 municípios do Tocantins e no estado como um todo. A dimensão social é fundamental para compreender a qualidade de vida, bem-estar e desenvolvimento humano das populações, complementando as análises econômicas e territoriais.

A análise está organizada em **8 áreas principais** (Educação, Saúde, Assistência Social, Segurança Pública, Habitação e Saneamento, Trabalho e Renda, Desenvolvimento Humano, Demografia), totalizando **mais de 150 indicadores** de **12 fontes de dados oficiais**. Identificamos **APIs e sistemas disponíveis**, propusemos **estrutura de dados integrada**, mapeamos **interconexões críticas** com outras dimensões e apresentamos **casos de uso transformadores** para gestores públicos.

**Principais Conclusões:**

1. **Dados abundantes mas fragmentados** - Existem dados sociais ricos, mas dispersos em múltiplos sistemas (INEP, DataSUS, MDS, IBGE, etc.), dificultando análises integradas.

2. **Qualidade variável** - Dados de educação e saúde são bem estruturados e atualizados, mas dados de segurança pública e habitação são mais escassos e defasados.

3. **Tocantins apresenta desafios específicos** - Estado jovem (criado em 1988), com municípios pequenos, alta dependência de transferências, baixos indicadores educacionais e de saúde comparados à média nacional.

4. **Interconexões são críticas** - Educação impacta renda futura, saúde impacta produtividade, assistência social reduz pobreza. Análises isoladas perdem insights valiosos.

5. **Oportunidade de transformação** - Um sistema integrado de dados sociais pode revolucionar a gestão pública tocantinense, permitindo decisões baseadas em evidências e políticas públicas mais efetivas.

---

## 1. Contexto e Relevância

### 1.1. Desafios da Gestão Pública Social no Brasil

A gestão de políticas sociais no Brasil enfrenta desafios estruturais significativos. Segundo o IBGE, o Brasil possui **5.570 municípios** com realidades socioeconômicas extremamente heterogêneas, desde metrópoles com milhões de habitantes até pequenos municípios rurais com menos de 5 mil pessoas. Esta diversidade exige políticas públicas adaptadas às realidades locais, mas a maioria dos gestores municipais não possui acesso facilitado a dados integrados que permitam diagnósticos precisos e tomada de decisão baseada em evidências.

No Tocantins, estado criado em 1988 com a divisão de Goiás, os desafios são ainda mais acentuados. Com **139 municípios** e população de aproximadamente **1,5 milhão de habitantes**, o estado apresenta indicadores sociais abaixo da média nacional em diversas áreas. O **Índice de Desenvolvimento Humano Municipal (IDHM)** médio do Tocantins é **0,699** (2010), classificado como médio, mas abaixo da média nacional de **0,727**. Apenas **12 municípios** (8,6%) possuem IDHM alto (≥ 0,700), enquanto **127 municípios** (91,4%) têm IDHM médio ou baixo.

### 1.2. Papel do Agente SOCIAL no Framework V6.0

O **Agente SOCIAL** é um dos seis agentes especializados do Framework V6.0, responsável por coletar, processar, analisar e apresentar dados sobre condições de vida, bem-estar e desenvolvimento humano das populações. Suas principais funções incluem:

**Coleta Automatizada de Dados Sociais** - Integrar dados de múltiplas fontes (INEP, DataSUS, MDS, IBGE, SSP) para criar uma visão holística da realidade social de cada município.

**Cálculo de Indicadores Derivados** - Gerar indicadores compostos (ex: Índice de Vulnerabilidade Social, Taxa de Cobertura de Serviços Essenciais) que sintetizam informações complexas em métricas acionáveis.

**Análises Comparativas e Temporais** - Comparar municípios entre si e ao longo do tempo, identificando tendências, progressos e retrocessos em áreas críticas como educação, saúde e assistência social.

**Identificação de Vulnerabilidades** - Detectar populações e territórios em situação de vulnerabilidade social, permitindo priorização de recursos e intervenções.

**Suporte a Decisões de Políticas Públicas** - Fornecer insights acionáveis para gestores públicos sobre onde investir, quais programas expandir e como otimizar a alocação de recursos limitados.

### 1.3. Especificidades do Tocantins

O Tocantins possui características únicas que influenciam a coleta e análise de dados sociais:

**Municípios Pequenos e Dispersos** - Dos 139 municípios, **118 (84,9%)** possuem menos de 20 mil habitantes. Municípios pequenos frequentemente têm capacidade técnica limitada para gestão de dados e implementação de políticas públicas complexas.

**Economia Agropecuária Predominante** - A agropecuária representa parcela significativa do PIB estadual (15-20%), com implicações para emprego, renda e padrões de migração rural-urbana.

**Baixa Densidade Populacional** - Com **5,5 habitantes/km²**, o Tocantins é um dos estados menos densamente povoados do Brasil, dificultando a oferta de serviços públicos (escolas, postos de saúde) em áreas rurais.

**Desigualdades Regionais Acentuadas** - Palmas, a capital, concentra **18% da população estadual** e apresenta indicadores sociais significativamente melhores que a maioria dos municípios do interior.

**População Jovem** - O Tocantins possui estrutura etária relativamente jovem, com **idade mediana de 28,9 anos** (vs 33,5 anos no Brasil), demandando investimentos em educação, saúde materno-infantil e geração de emprego.

---

## 2. Fontes de Dados Identificadas

Identificamos **12 fontes principais** de dados sociais, organizadas por área temática. Para cada fonte, detalhamos disponibilidade de APIs, formatos de dados, granularidade geográfica, frequência de atualização e limitações conhecidas.

### 2.1. Educação

#### INEP (Instituto Nacional de Estudos e Pesquisas Educacionais Anísio Teixeira)

**Censo Escolar da Educação Básica**

O Censo Escolar é o principal instrumento de coleta de informações sobre educação básica no Brasil, realizado anualmente pelo INEP em parceria com secretarias estaduais e municipais de educação. Todos os estabelecimentos públicos e privados de educação básica são obrigados a declarar informações, com data de referência na última quarta-feira de maio de cada ano.

**Disponibilidade de Dados:**
- **Microdados:** Disponíveis para download em formato CSV/TXT desde 1995 no portal [INEP Dados Abertos](https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-escolar)
- **API:** Não há API oficial do INEP. Existe projeto comunitário no [GitHub](https://github.com/inepdadosabertos/api), mas não é mantido oficialmente.
- **INEP Data:** Painéis de BI interativos em [https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/inep-data](https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/inep-data)
- **Base dos Dados:** Dados tratados e prontos para análise via SQL em [https://basedosdados.org/dataset/br-inep-censo-escolar](https://basedosdados.org/dataset/br-inep-censo-escolar)

**Granularidade:** Escola, Município, Estado, Brasil

**Frequência:** Anual (coleta em maio, divulgação em janeiro do ano seguinte)

**Dados Disponíveis:**
- **Matrículas:** Total e por etapa de ensino (creche, pré-escola, fundamental, médio, EJA, profissional)
- **Estabelecimentos:** Número de escolas por dependência administrativa (federal, estadual, municipal, privada)
- **Infraestrutura:** Laboratórios de informática e ciências, bibliotecas, quadras esportivas, internet, água, esgoto, energia
- **Docentes:** Número de professores, formação (superior completo, licenciatura na área), vínculo empregatício
- **Turmas:** Número de turmas por etapa e turno
- **Rendimento:** Taxa de aprovação, reprovação e abandono por etapa de ensino

**Limitações:**
- Não há API oficial, exigindo download manual de microdados ou web scraping
- Microdados são volumosos (> 1 GB compactado) e requerem processamento local
- Defasagem temporal: dados de 2024 são divulgados apenas em janeiro de 2025

**IDEB (Índice de Desenvolvimento da Educação Básica)**

O IDEB é o principal indicador de qualidade da educação básica no Brasil, criado em 2007 pelo INEP. Combina dois conceitos: fluxo escolar (taxa de aprovação) e aprendizado (médias de desempenho no SAEB - Sistema de Avaliação da Educação Básica).

**Disponibilidade de Dados:**
- **Portal IDEB:** [https://www.gov.br/inep/pt-br/areas-de-atuacao/pesquisas-estatisticas-e-indicadores/ideb](https://www.gov.br/inep/pt-br/areas-de-atuacao/pesquisas-estatisticas-e-indicadores/ideb)
- **Dados Abertos:** [https://dados.gov.br/dados/conjuntos-dados/ideb-por-municipios](https://dados.gov.br/dados/conjuntos-dados/ideb-por-municipios)
- **QEdu:** Plataforma não-governamental com dados do IDEB em formato amigável: [https://qedu.org.br/](https://qedu.org.br/)

**Granularidade:** Escola, Município, Estado, Brasil

**Frequência:** Bienal (anos ímpares: 2019, 2021, 2023, 2025)

**Dados Disponíveis:**
- IDEB por etapa (Anos Iniciais do Fundamental, Anos Finais do Fundamental, Ensino Médio)
- IDEB por rede (pública, privada)
- Metas projetadas vs IDEB observado
- Componentes: Taxa de aprovação e Nota Padronizada (SAEB)

**Limitações:**
- Frequência bienal limita análises de curto prazo
- Escolas com menos de 20 alunos não têm IDEB calculado
- SAEB é amostral para alguns municípios pequenos, reduzindo confiabilidade

### 2.2. Saúde

#### DataSUS (Departamento de Informática do SUS)

**API de Dados Abertos do Ministério da Saúde (DEMAS)**

O Ministério da Saúde disponibiliza uma API REST com dados abertos de diversos sistemas de informação em saúde. A documentação está disponível em formato Swagger em [https://apidadosabertos.saude.gov.br/](https://apidadosabertos.saude.gov.br/).

**Endpoints Relevantes:**

1. **Assistência à Saúde - Hospitais e Leitos**
   - **Endpoint:** `GET /assistencia-a-saude/hospitais-e-leitos`
   - **Descrição:** Lista estabelecimentos hospitalares, leitos gerais e complementares, informações de contato
   - **Parâmetros:** Estado, município, tipo de estabelecimento
   - **Formato:** JSON
   - **Autenticação:** Não requerida para este endpoint

2. **Registro de Ocupação Hospitalar COVID-19**
   - **Endpoint:** `GET /assistencia-a-saude/registro-de-ocupacao-hospitalar-covid-19`
   - **Descrição:** Dados de ocupação de leitos durante a pandemia
   - **Parâmetros:** Estado, município, período
   - **Formato:** JSON

3. **Agravo Arboviroses**
   - **Endpoints:** 
     - `GET /arboviroses/dengue`
     - `GET /arboviroses/zikavirus`
     - `GET /arboviroses/chikungunya`
     - `GET /arboviroses/febre-amarela-humanos-primatas-nao-humanos`
   - **Descrição:** Bases de ocorrência de doenças transmitidas por mosquitos
   - **Parâmetros:** Estado, município, ano
   - **Formato:** JSON

**Autenticação:**
- Alguns endpoints requerem autenticação via token
- Obter token: `POST /autenticacao/login` com credenciais
- Revogar token: `POST /autenticacao/logout`

**CNES (Cadastro Nacional de Estabelecimentos de Saúde)**

Sistema oficial de cadastramento de todos os estabelecimentos de saúde do Brasil, mantido pelo DataSUS.

**Disponibilidade de Dados:**
- **Portal CNES:** [https://cnes.datasus.gov.br/](https://cnes.datasus.gov.br/)
- **Consulta Web:** Permite busca por estabelecimento, município, tipo
- **Arquivos para Download:** Disponíveis em [ftp://ftp.datasus.gov.br/cnes/](ftp://ftp.datasus.gov.br/cnes/)
- **TabNet:** Tabulação online em [http://tabnet.datasus.gov.br/cgi/deftohtm.exe?cnes/cnv/leiintbr.def](http://tabnet.datasus.gov.br/cgi/deftohtm.exe?cnes/cnv/leiintbr.def)

**Granularidade:** Estabelecimento, Município, Estado, Brasil

**Frequência:** Mensal (atualização contínua)

**Dados Disponíveis:**
- **Estabelecimentos:** Número, tipo (hospital, posto de saúde, clínica), natureza jurídica (público, privado)
- **Leitos:** Total e por especialidade (clínico, cirúrgico, obstétrico, pediátrico, UTI)
- **Leitos SUS vs Não-SUS:** Distinção importante para análise de acesso
- **Profissionais:** Médicos, enfermeiros, técnicos de enfermagem, dentistas, etc.
- **Equipamentos:** Raio-X, tomógrafos, ressonância magnética, etc.
- **Serviços:** Ambulatório, internação, urgência/emergência, SADT (Serviços Auxiliares de Diagnóstico e Terapia)

**Limitações:**
- Não há API REST oficial, apenas arquivos FTP e consultas web
- Arquivos FTP são em formato DBF (dBase), requerendo conversão
- Dados podem estar desatualizados se estabelecimentos não atualizarem cadastro

**TabNet DataSUS**

Sistema de tabulação online que permite consultas customizadas a diversas bases de dados do SUS.

**Disponibilidade:**
- **Portal:** [http://tabnet.datasus.gov.br/](http://tabnet.datasus.gov.br/)
- **Bases Disponíveis:** SIA (Produção Ambulatorial), SIH (Internações Hospitalares), SIM (Mortalidade), SINASC (Nascimentos), SINAN (Doenças de Notificação), entre outras

**Granularidade:** Município, Estado, Brasil

**Frequência:** Mensal (SIA, SIH) ou Anual (SIM, SINASC)

**Dados Disponíveis:**
- **Produção Ambulatorial (SIA):** Consultas, exames, procedimentos realizados no SUS
- **Internações Hospitalares (SIH):** Número de internações, dias de permanência, causas (CID-10), custos
- **Mortalidade (SIM):** Óbitos por causa (CID-10), faixa etária, sexo
- **Nascimentos (SINASC):** Nascidos vivos, peso ao nascer, tipo de parto, idade da mãe
- **Doenças de Notificação (SINAN):** Casos de doenças como dengue, tuberculose, HIV/AIDS, etc.

**Limitações:**
- Interface web não é API REST, requerendo web scraping ou download manual
- Consultas complexas podem ser lentas
- Dados de mortalidade e nascimentos têm defasagem de 1-2 anos

**Cobertura de Estratégia Saúde da Família (ESF)**

A ESF é o modelo de atenção primária à saúde no Brasil, com equipes multidisciplinares que atendem populações adscritas.

**Disponibilidade:**
- **e-Gestor AB:** [https://egestorab.saude.gov.br/](https://egestorab.saude.gov.br/)
- **Dados Abertos:** Não há API oficial, dados disponíveis via relatórios web

**Granularidade:** Município, Estado, Brasil

**Frequência:** Mensal

**Dados Disponíveis:**
- Número de equipes de Saúde da Família (eSF)
- Número de Agentes Comunitários de Saúde (ACS)
- População coberta por eSF
- Percentual de cobertura populacional

**Limitações:**
- Não há API, dados obtidos via web scraping ou relatórios manuais
- Cobertura reportada pode não refletir qualidade do atendimento

### 2.3. Assistência Social

#### MDS (Ministério do Desenvolvimento e Assistência Social, Família e Combate à Fome)

**Cecad 2.0 (Consulta, Seleção e Extração de Informações do CadÚnico)**

O Cecad é o sistema de consulta e extração de dados do Cadastro Único para Programas Sociais, que identifica e caracteriza famílias de baixa renda no Brasil.

**Disponibilidade:**
- **Portal Cecad:** [https://cecad.cidadania.gov.br/](https://cecad.cidadania.gov.br/)
- **Manual:** [https://manual-cecad-20.readthedocs.io/](https://manual-cecad-20.readthedocs.io/)
- **API CadÚnico Serviços:** [https://www.gov.br/conecta/catalogo/apis/cadunico-servicos](https://www.gov.br/conecta/catalogo/apis/cadunico-servicos)

**Granularidade:** Família, Município, Estado, Brasil

**Frequência:** Mensal

**Dados Disponíveis:**
- **Famílias Cadastradas:** Total de famílias no CadÚnico
- **Famílias Atualizadas:** Famílias com cadastro atualizado nos últimos 24 meses
- **Pessoas Cadastradas:** Total de pessoas nas famílias cadastradas
- **Perfil de Renda:** Distribuição por faixa de renda per capita
- **Grupos Populacionais Específicos:** Indígenas, quilombolas, ribeirinhos, etc.
- **Características Domiciliares:** Tipo de moradia, acesso a água, esgoto, energia

**Limitações:**
- Acesso ao Cecad requer credenciais de gestor municipal/estadual
- API CadÚnico Serviços tem acesso restrito e requer convênio
- Dados são sensíveis (LGPD), limitando compartilhamento público

**Bolsa Família (Auxílio Brasil)**

Programa de transferência de renda para famílias em situação de pobreza e extrema pobreza.

**Disponibilidade:**
- **Portal Transparência:** [https://portaldatransparencia.gov.br/bolsa-familia-e-cadastro-unico](https://portaldatransparencia.gov.br/bolsa-familia-e-cadastro-unico)
- **Dados Abertos:** [https://dados.gov.br/dados/conjuntos-dados/bolsa-familia](https://dados.gov.br/dados/conjuntos-dados/bolsa-familia)
- **Relatórios Municipais:** [https://aplicacoes.cidadania.gov.br/ri/pbfcad/](https://aplicacoes.cidadania.gov.br/ri/pbfcad/)

**Granularidade:** Município, Estado, Brasil

**Frequência:** Mensal

**Dados Disponíveis:**
- Número de famílias beneficiárias
- Valor total repassado (R$)
- Valor médio por família (R$)
- Distribuição por tipo de benefício (básico, variável, jovem, etc.)

**Limitações:**
- Não há API oficial, dados disponíveis via download CSV ou web scraping
- Dados individuais são protegidos por LGPD

**CRAS e CREAS**

Centros de Referência de Assistência Social (CRAS) e Centros de Referência Especializados de Assistência Social (CREAS) são equipamentos públicos da política de assistência social.

**Disponibilidade:**
- **CadSUAS:** [https://aplicacoes.mds.gov.br/cadsuas/](https://aplicacoes.mds.gov.br/cadsuas/)
- **Censo SUAS:** Pesquisa anual sobre equipamentos e serviços socioassistenciais

**Granularidade:** Equipamento, Município, Estado, Brasil

**Frequência:** Anual (Censo SUAS)

**Dados Disponíveis:**
- Número de CRAS e CREAS por município
- Serviços ofertados
- Recursos humanos (assistentes sociais, psicólogos, etc.)
- Atendimentos realizados

**Limitações:**
- Acesso ao CadSUAS requer credenciais de gestor
- Dados do Censo SUAS têm defasagem de 1 ano

### 2.4. Segurança Pública

#### Fórum Brasileiro de Segurança Pública

**Anuário Brasileiro de Segurança Pública**

Publicação anual que consolida dados de segurança pública de todas as Unidades da Federação.

**Disponibilidade:**
- **Portal:** [https://forumseguranca.org.br/anuario-brasileiro-seguranca-publica/](https://forumseguranca.org.br/anuario-brasileiro-seguranca-publica/)
- **Dados Abertos:** Planilhas Excel disponíveis para download

**Granularidade:** Estado, Brasil (dados municipais limitados)

**Frequência:** Anual

**Dados Disponíveis:**
- Homicídios dolosos
- Latrocínios
- Lesões corporais seguidas de morte
- Roubos (total, veículos, carga, instituições financeiras)
- Furtos (total, veículos)
- Estupros
- Feminicídios
- Violência doméstica
- Efetivo policial (militar e civil)

**Limitações:**
- Dados municipais são escassos, maioria é estadual
- Subnotificação é problema conhecido, especialmente em municípios pequenos
- Não há API, apenas download manual de planilhas

#### SSP Estaduais (Secretarias de Segurança Pública)

Cada estado possui sua SSP que coleta e divulga dados de criminalidade.

**Disponibilidade (Tocantins):**
- **SSP-TO:** [https://www.to.gov.br/ssp](https://www.to.gov.br/ssp)
- **Dados:** Boletins mensais e anuais, geralmente em PDF

**Granularidade:** Município, Estado

**Frequência:** Mensal ou Trimestral

**Dados Disponíveis:**
- Ocorrências policiais por tipo de crime
- Prisões realizadas
- Apreensões (drogas, armas)

**Limitações:**
- Não há padronização entre estados
- Não há API, dados em PDFs ou planilhas
- Qualidade e completude variam significativamente

### 2.5. Habitação e Saneamento

#### IBGE - Censo Demográfico

O Censo Demográfico, realizado a cada 10 anos, é a principal fonte de dados sobre condições de moradia no Brasil.

**Disponibilidade:**
- **Portal IBGE:** [https://www.ibge.gov.br/estatisticas/sociais/populacao/22827-censo-demografico-2022.html](https://www.ibge.gov.br/estatisticas/sociais/populacao/22827-censo-demografico-2022.html)
- **SIDRA:** Sistema de recuperação automática de dados: [https://sidra.ibge.gov.br/](https://sidra.ibge.gov.br/)
- **API SIDRA:** [https://apisidra.ibge.gov.br/](https://apisidra.ibge.gov.br/)

**Granularidade:** Domicílio, Setor Censitário, Município, Estado, Brasil

**Frequência:** Decenal (2010, 2020, 2030)

**Dados Disponíveis:**
- **Tipo de Domicílio:** Casa, apartamento, cômodo
- **Condição de Ocupação:** Próprio, alugado, cedido
- **Material das Paredes:** Alvenaria, madeira, taipa, outro
- **Abastecimento de Água:** Rede geral, poço, nascente, outro
- **Esgotamento Sanitário:** Rede geral, fossa séptica, fossa rudimentar, outro
- **Coleta de Lixo:** Coletado, queimado, enterrado, jogado
- **Energia Elétrica:** Sim ou não
- **Número de Cômodos e Dormitórios**
- **Bens Duráveis:** Geladeira, fogão, TV, computador, internet, etc.

**Limitações:**
- Frequência decenal limita análises de curto prazo
- Censo 2020 foi adiado para 2022 devido à pandemia, gerando defasagem
- Dados mais detalhados (setor censitário) requerem processamento complexo

#### SNIS (Sistema Nacional de Informações sobre Saneamento)

Sistema de informações sobre prestação de serviços de água, esgoto e resíduos sólidos.

**Disponibilidade:**
- **Portal SNIS:** [http://www.snis.gov.br/](http://www.snis.gov.br/)
- **Série Histórica:** Dados desde 1995

**Granularidade:** Prestador de Serviço, Município, Estado, Brasil

**Frequência:** Anual

**Dados Disponíveis:**
- **Água:** População atendida, volume produzido, perdas, tarifa média
- **Esgoto:** População atendida, volume coletado, volume tratado, tarifa média
- **Resíduos Sólidos:** Quantidade coletada, destinação (aterro, lixão, reciclagem)

**Limitações:**
- Adesão ao SNIS é voluntária, alguns municípios não reportam dados
- Dados dependem da qualidade do preenchimento pelos prestadores
- Não há API, dados disponíveis via download de planilhas

### 2.6. Trabalho e Renda

#### RAIS (Relação Anual de Informações Sociais)

Registro administrativo obrigatório para todos os empregadores, contendo informações sobre vínculos empregatícios formais.

**Disponibilidade:**
- **Portal RAIS:** [https://www.gov.br/trabalho-e-previdencia/pt-br/assuntos/rais](https://www.gov.br/trabalho-e-previdencia/pt-br/assuntos/rais)
- **Microdados:** Disponíveis para download (requer processamento)
- **Base dos Dados:** Dados tratados em [https://basedosdados.org/dataset/br-me-rais](https://basedosdados.org/dataset/br-me-rais)

**Granularidade:** Vínculo Empregatício, Estabelecimento, Município, Estado, Brasil

**Frequência:** Anual (ano-base, divulgação no ano seguinte)

**Dados Disponíveis:**
- Número de vínculos empregatícios formais
- Vínculos por setor econômico (CNAE)
- Vínculos por ocupação (CBO)
- Salários médios por setor e ocupação
- Características dos trabalhadores (sexo, idade, escolaridade)
- Tempo de emprego

**Limitações:**
- Cobre apenas emprego formal, excluindo autônomos e informais
- Defasagem temporal: dados de 2023 divulgados em 2024
- Microdados são volumosos (> 10 GB) e requerem processamento

#### CAGED (Cadastro Geral de Empregados e Desempregados)

Registro mensal de admissões e demissões no mercado de trabalho formal.

**Disponibilidade:**
- **Portal CAGED:** [https://www.gov.br/trabalho-e-previdencia/pt-br/assuntos/caged](https://www.gov.br/trabalho-e-previdencia/pt-br/assuntos/caged)
- **Dados Abertos:** [https://dados.gov.br/dados/conjuntos-dados/caged](https://dados.gov.br/dados/conjuntos-dados/caged)

**Granularidade:** Município, Estado, Brasil

**Frequência:** Mensal

**Dados Disponíveis:**
- Admissões
- Desligamentos
- Saldo (admissões - desligamentos)
- Estoque de empregos formais
- Dados por setor econômico

**Limitações:**
- Desde 2020, CAGED foi substituído pelo eSocial para empresas grandes, gerando quebra de série histórica
- Cobre apenas emprego formal

#### IBGE - PNAD Contínua

Pesquisa Nacional por Amostra de Domicílios Contínua, principal fonte de dados sobre mercado de trabalho no Brasil.

**Disponibilidade:**
- **Portal IBGE:** [https://www.ibge.gov.br/estatisticas/sociais/trabalho/9173-pesquisa-nacional-por-amostra-de-domicilios-continua-trimestral.html](https://www.ibge.gov.br/estatisticas/sociais/trabalho/9173-pesquisa-nacional-por-amostra-de-domicilios-continua-trimestral.html)
- **SIDRA:** Tabulações online
- **Microdados:** Disponíveis para download

**Granularidade:** Brasil, Grandes Regiões, Estados, Regiões Metropolitanas (municípios não são representativos)

**Frequência:** Trimestral

**Dados Disponíveis:**
- Taxa de desocupação (desemprego)
- Taxa de participação na força de trabalho
- Rendimento médio real do trabalho
- Informalidade
- Subocupação
- Desalento

**Limitações:**
- Amostra não é representativa para municípios individuais
- Dados municipais não estão disponíveis

### 2.7. Desenvolvimento Humano

#### Atlas do Desenvolvimento Humano no Brasil

Plataforma desenvolvida pelo PNUD (Programa das Nações Unidas para o Desenvolvimento), IPEA (Instituto de Pesquisa Econômica Aplicada) e FJP (Fundação João Pinheiro) que disponibiliza dados de desenvolvimento humano para todos os municípios brasileiros.

**Disponibilidade:**
- **Portal Atlas:** [http://www.atlasbrasil.org.br/](http://www.atlasbrasil.org.br/)
- **Dados Abertos:** Planilhas Excel disponíveis para download
- **Consulta Interativa:** Mapas e gráficos por município

**Granularidade:** Município, Estado, Brasil

**Frequência:** Decenal (baseado no Censo IBGE: 1991, 2000, 2010)

**Dados Disponíveis:**
- **IDHM (Índice de Desenvolvimento Humano Municipal):** Índice composto (0 a 1)
- **IDHM Longevidade:** Baseado em expectativa de vida ao nascer
- **IDHM Educação:** Baseado em escolaridade da população adulta e fluxo escolar
- **IDHM Renda:** Baseado em renda per capita
- **Índice de Gini:** Medida de desigualdade de renda (0 = igualdade perfeita, 1 = desigualdade máxima)
- **% de Pobres:** População com renda domiciliar per capita < R$ 140 (valores de 2010)
- **% de Extremamente Pobres:** População com renda domiciliar per capita < R$ 70 (valores de 2010)
- **Expectativa de Vida ao Nascer:** Anos
- **Taxa de Mortalidade Infantil:** Óbitos de menores de 1 ano por 1.000 nascidos vivos
- **Taxa de Analfabetismo:** % da população de 15 anos ou mais analfabeta
- **% de 18 a 20 anos com Ensino Médio Completo**
- **Renda per Capita:** R$ (valores de 2010)

**Limitações:**
- Frequência decenal limita análises de curto prazo
- Dados mais recentes são de 2010, próxima atualização baseada no Censo 2022 ainda não disponível
- Não há API, apenas download de planilhas

#### IBGE - Síntese de Indicadores Sociais

Publicação anual que apresenta análise das condições de vida da população brasileira.

**Disponibilidade:**
- **Portal IBGE:** [https://www.ibge.gov.br/estatisticas/sociais/populacao/9221-sintese-de-indicadores-sociais.html](https://www.ibge.gov.br/estatisticas/sociais/populacao/9221-sintese-de-indicadores-sociais.html)
- **Publicação:** PDF e tabelas Excel

**Granularidade:** Brasil, Grandes Regiões, Estados (municípios não são representativos)

**Frequência:** Anual

**Dados Disponíveis:**
- Pobreza e desigualdade
- Educação
- Trabalho
- Habitação
- Saúde

**Limitações:**
- Dados municipais não estão disponíveis
- Baseado em PNAD Contínua, que não é representativa para municípios

### 2.8. Demografia

#### IBGE - Projeções e Estimativas Populacionais

O IBGE produz estimativas anuais de população para todos os municípios brasileiros, utilizadas para cálculo do Fundo de Participação dos Municípios (FPM).

**Disponibilidade:**
- **Portal IBGE:** [https://www.ibge.gov.br/estatisticas/sociais/populacao/9103-estimativas-de-populacao.html](https://www.ibge.gov.br/estatisticas/sociais/populacao/9103-estimativas-de-populacao.html)
- **API IBGE:** [https://servicodados.ibge.gov.br/api/v3/agregados/6579](https://servicodados.ibge.gov.br/api/v3/agregados/6579)
- **SIDRA:** Tabulações online

**Granularidade:** Município, Estado, Brasil

**Frequência:** Anual

**Dados Disponíveis:**
- População total estimada
- População por faixa etária e sexo (apenas Censo, decenal)
- Taxa de natalidade (apenas Censo)
- Taxa de mortalidade (apenas Censo)
- Expectativa de vida (apenas Censo)

**Limitações:**
- Estimativas anuais são projeções baseadas no último Censo, podendo divergir da realidade
- Dados detalhados por idade e sexo são decenais (Censo)

#### IBGE - Censo Demográfico

Já descrito na seção de Habitação, o Censo também é a principal fonte de dados demográficos detalhados.

**Dados Demográficos Adicionais:**
- Pirâmide etária (população por idade simples e sexo)
- Razão de dependência (população < 15 anos + > 65 anos / população 15-64 anos)
- Taxa de urbanização (% da população em área urbana)
- Migração (naturalidade, tempo de residência no município)
- Composição familiar (tamanho médio das famílias, arranjos familiares)

---

## 3. Dados Prioritários por Área

Organizamos os dados sociais em **três níveis de prioridade** (Essencial, Alta, Média) com base em critérios de relevância para gestão pública, disponibilidade de dados, facilidade de coleta e impacto em decisões de políticas públicas.

### 3.1. Educação

#### Essencial (Prioridade 1)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Matrículas por Etapa** | INEP Censo Escolar | Município | Anual | Dimensiona demanda por vagas e infraestrutura |
| **IDEB Anos Iniciais** | INEP | Município | Bienal | Principal indicador de qualidade educacional |
| **IDEB Anos Finais** | INEP | Município | Bienal | Identifica gargalos no fundamental II |
| **Taxa de Aprovação** | INEP Censo Escolar | Município | Anual | Indica eficiência do sistema educacional |
| **Número de Escolas** | INEP Censo Escolar | Município | Anual | Dimensiona infraestrutura disponível |
| **Número de Professores** | INEP Censo Escolar | Município | Anual | Permite calcular razão aluno/professor |

#### Alta Prioridade (Prioridade 2)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Taxa de Reprovação** | INEP Censo Escolar | Município | Anual | Identifica problemas de aprendizagem |
| **Taxa de Abandono** | INEP Censo Escolar | Município | Anual | Indica evasão escolar |
| **Professores com Superior** | INEP Censo Escolar | Município | Anual | Qualidade do corpo docente |
| **Escolas com Internet** | INEP Censo Escolar | Município | Anual | Inclusão digital |
| **Escolas com Biblioteca** | INEP Censo Escolar | Município | Anual | Infraestrutura de apoio |
| **Razão Aluno/Professor** | Calculado (INEP) | Município | Anual | Indica sobrecarga docente |

#### Média Prioridade (Prioridade 3)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Escolas com Lab. Informática** | INEP Censo Escolar | Município | Anual | Infraestrutura tecnológica |
| **Escolas com Quadra Esportiva** | INEP Censo Escolar | Município | Anual | Infraestrutura esportiva |
| **Turmas por Turno** | INEP Censo Escolar | Município | Anual | Identifica sobrecarga de turnos |
| **Matrículas EJA** | INEP Censo Escolar | Município | Anual | Educação de adultos |
| **Matrículas Educação Especial** | INEP Censo Escolar | Município | Anual | Inclusão de PcD |

### 3.2. Saúde

#### Essencial (Prioridade 1)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Leitos SUS por 1.000 hab** | CNES | Município | Mensal | Dimensiona capacidade de atendimento |
| **Estabelecimentos de Saúde** | CNES | Município | Mensal | Infraestrutura disponível |
| **Médicos por 1.000 hab** | CNES | Município | Mensal | Disponibilidade de profissionais |
| **Cobertura ESF (%)** | e-Gestor AB | Município | Mensal | Acesso à atenção primária |
| **Taxa de Mortalidade Infantil** | SIM/SINASC | Município | Anual | Indicador de saúde materno-infantil |
| **Expectativa de Vida** | IBGE (Censo) | Município | Decenal | Indicador de saúde geral |

#### Alta Prioridade (Prioridade 2)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Leitos UTI por 1.000 hab** | CNES | Município | Mensal | Capacidade para casos graves |
| **Enfermeiros por 1.000 hab** | CNES | Município | Mensal | Equipe de enfermagem |
| **Equipes Saúde da Família** | e-Gestor AB | Município | Mensal | Número absoluto de equipes |
| **Internações por Causa** | SIH | Município | Mensal | Identifica principais causas |
| **Mortalidade por Causa** | SIM | Município | Anual | Identifica principais causas de óbito |
| **Casos de Dengue** | SINAN | Município | Mensal | Vigilância epidemiológica |

#### Média Prioridade (Prioridade 3)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Leitos Obstétricos** | CNES | Município | Mensal | Saúde materno-infantil |
| **Leitos Pediátricos** | CNES | Município | Mensal | Saúde infantil |
| **Consultas Ambulatoriais** | SIA | Município | Mensal | Produção ambulatorial |
| **Exames Realizados** | SIA | Município | Mensal | Acesso a diagnóstico |
| **Nascidos Vivos** | SINASC | Município | Anual | Demografia e saúde materno-infantil |
| **Casos de Tuberculose** | SINAN | Município | Anual | Vigilância epidemiológica |

### 3.3. Assistência Social

#### Essencial (Prioridade 1)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Famílias Cadastradas CadÚnico** | Cecad | Município | Mensal | Dimensiona população vulnerável |
| **Beneficiários Bolsa Família** | Portal Transparência | Município | Mensal | Principal programa de transferência de renda |
| **Valor Repassado Bolsa Família** | Portal Transparência | Município | Mensal | Recursos transferidos ao município |
| **% Famílias em Extrema Pobreza** | Cecad | Município | Mensal | Identifica vulnerabilidade extrema |
| **Número de CRAS** | CadSUAS | Município | Anual | Infraestrutura de assistência social |

#### Alta Prioridade (Prioridade 2)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Famílias Atualizadas CadÚnico** | Cecad | Município | Mensal | Qualidade do cadastro |
| **Renda Média per Capita** | Cecad | Município | Mensal | Perfil socioeconômico |
| **Número de CREAS** | CadSUAS | Município | Anual | Atendimento especializado |
| **Atendimentos CRAS** | Censo SUAS | Município | Anual | Produção dos serviços |
| **Benefício de Prestação Continuada (BPC)** | Portal Transparência | Município | Mensal | Transferência para idosos e PcD |

#### Média Prioridade (Prioridade 3)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Grupos Populacionais Específicos** | Cecad | Município | Mensal | Indígenas, quilombolas, etc. |
| **Assistentes Sociais CRAS** | Censo SUAS | Município | Anual | Recursos humanos |
| **Psicólogos CRAS** | Censo SUAS | Município | Anual | Recursos humanos |

### 3.4. Segurança Pública

#### Essencial (Prioridade 1)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Homicídios** | SSP-TO / FBSP | Município | Mensal | Principal indicador de violência |
| **Taxa de Homicídios por 100k hab** | Calculado | Município | Mensal | Permite comparações |

#### Alta Prioridade (Prioridade 2)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Roubos** | SSP-TO | Município | Mensal | Criminalidade patrimonial |
| **Furtos** | SSP-TO | Município | Mensal | Criminalidade patrimonial |
| **Estupros** | SSP-TO | Município | Mensal | Violência sexual |
| **Feminicídios** | SSP-TO | Município | Mensal | Violência contra a mulher |

#### Média Prioridade (Prioridade 3)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Efetivo Policial** | SSP-TO / FBSP | Estado | Anual | Capacidade de policiamento |
| **Prisões Realizadas** | SSP-TO | Município | Mensal | Efetividade policial |
| **Apreensões de Drogas** | SSP-TO | Município | Mensal | Combate ao tráfico |

**Nota:** Dados de segurança pública municipal são escassos no Tocantins. Maioria dos indicadores está disponível apenas em nível estadual.

### 3.5. Habitação e Saneamento

#### Essencial (Prioridade 1)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **% Domicílios com Água Encanada** | IBGE Censo | Município | Decenal | Acesso a saneamento básico |
| **% Domicílios com Esgoto** | IBGE Censo | Município | Decenal | Acesso a saneamento básico |
| **% Domicílios com Coleta de Lixo** | IBGE Censo | Município | Decenal | Acesso a saneamento básico |
| **% Domicílios com Energia Elétrica** | IBGE Censo | Município | Decenal | Acesso a infraestrutura básica |

#### Alta Prioridade (Prioridade 2)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Déficit Habitacional** | IBGE Censo | Município | Decenal | Necessidade de novas moradias |
| **% Domicílios Próprios** | IBGE Censo | Município | Decenal | Segurança habitacional |
| **População Atendida Água (SNIS)** | SNIS | Município | Anual | Cobertura de água tratada |
| **População Atendida Esgoto (SNIS)** | SNIS | Município | Anual | Cobertura de esgotamento |

#### Média Prioridade (Prioridade 3)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Material das Paredes** | IBGE Censo | Município | Decenal | Qualidade da moradia |
| **Número de Cômodos Médio** | IBGE Censo | Município | Decenal | Densidade domiciliar |
| **% Domicílios com Internet** | IBGE Censo | Município | Decenal | Inclusão digital |
| **Volume de Água Produzido** | SNIS | Município | Anual | Capacidade de abastecimento |
| **% de Esgoto Tratado** | SNIS | Município | Anual | Qualidade ambiental |

### 3.6. Trabalho e Renda

#### Essencial (Prioridade 1)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Empregos Formais** | RAIS | Município | Anual | Dimensiona mercado de trabalho formal |
| **Salário Médio** | RAIS | Município | Anual | Renda do trabalho |
| **Saldo de Empregos (CAGED)** | CAGED | Município | Mensal | Dinâmica do mercado de trabalho |

#### Alta Prioridade (Prioridade 2)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Empregos por Setor** | RAIS | Município | Anual | Estrutura produtiva |
| **Admissões** | CAGED | Município | Mensal | Geração de empregos |
| **Demissões** | CAGED | Município | Mensal | Perda de empregos |
| **Rendimento Médio (PNAD)** | PNAD Contínua | Estado | Trimestral | Renda do trabalho (formal + informal) |

#### Média Prioridade (Prioridade 3)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Empregos por Ocupação** | RAIS | Município | Anual | Perfil ocupacional |
| **Tempo Médio de Emprego** | RAIS | Município | Anual | Rotatividade |
| **Taxa de Desemprego (PNAD)** | PNAD Contínua | Estado | Trimestral | Desocupação |
| **Taxa de Informalidade (PNAD)** | PNAD Contínua | Estado | Trimestral | Trabalho sem carteira |

**Nota:** Dados de PNAD Contínua não são representativos para municípios individuais, apenas para estados.

### 3.7. Desenvolvimento Humano

#### Essencial (Prioridade 1)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **IDHM** | Atlas Brasil | Município | Decenal | Síntese de desenvolvimento humano |
| **IDHM Longevidade** | Atlas Brasil | Município | Decenal | Componente saúde |
| **IDHM Educação** | Atlas Brasil | Município | Decenal | Componente educação |
| **IDHM Renda** | Atlas Brasil | Município | Decenal | Componente renda |
| **Índice de Gini** | Atlas Brasil | Município | Decenal | Desigualdade de renda |
| **% de Pobres** | Atlas Brasil | Município | Decenal | Pobreza |

#### Alta Prioridade (Prioridade 2)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **% de Extremamente Pobres** | Atlas Brasil | Município | Decenal | Pobreza extrema |
| **Expectativa de Vida** | Atlas Brasil | Município | Decenal | Longevidade |
| **Taxa de Mortalidade Infantil** | Atlas Brasil | Município | Decenal | Saúde materno-infantil |
| **Taxa de Analfabetismo** | Atlas Brasil | Município | Decenal | Educação básica |
| **Renda per Capita** | Atlas Brasil | Município | Decenal | Renda média |

#### Média Prioridade (Prioridade 3)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **% 18-20 anos com EM Completo** | Atlas Brasil | Município | Decenal | Conclusão ensino médio |
| **Taxa de Fecundidade** | IBGE Censo | Município | Decenal | Demografia |

### 3.8. Demografia

#### Essencial (Prioridade 1)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **População Total** | IBGE Estimativas | Município | Anual | Dimensiona demandas |
| **Taxa de Urbanização** | IBGE Censo | Município | Decenal | Distribuição urbano/rural |

#### Alta Prioridade (Prioridade 2)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **População por Faixa Etária** | IBGE Censo | Município | Decenal | Pirâmide etária |
| **Razão de Dependência** | IBGE Censo | Município | Decenal | Estrutura etária |
| **Taxa de Natalidade** | SINASC | Município | Anual | Demografia |
| **Taxa de Mortalidade** | SIM | Município | Anual | Demografia |

#### Média Prioridade (Prioridade 3)

| Indicador | Fonte | Granularidade | Frequência | Justificativa |
|-----------|-------|---------------|------------|---------------|
| **Migração (Saldo Migratório)** | IBGE Censo | Município | Decenal | Dinâmica populacional |
| **Tamanho Médio das Famílias** | IBGE Censo | Município | Decenal | Estrutura familiar |

---

## 4. Estrutura de Dados Proposta

Propomos uma estrutura de banco de dados PostgreSQL integrada para armazenar dados sociais, complementando as tabelas já definidas para dados econômicos. A estrutura segue princípios de normalização, permite séries temporais e facilita análises integradas.

### 4.1. Tabelas Principais

#### Tabela: `dados_educacao`

Armazena indicadores educacionais por município e ano.

```sql
CREATE TABLE dados_educacao (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  entidade_id UUID NOT NULL REFERENCES entidades_territoriais(id),
  ano INTEGER NOT NULL,
  
  -- Matrículas
  matriculas_total INTEGER,
  matriculas_creche INTEGER,
  matriculas_pre_escola INTEGER,
  matriculas_fundamental_anos_iniciais INTEGER,
  matriculas_fundamental_anos_finais INTEGER,
  matriculas_ensino_medio INTEGER,
  matriculas_eja INTEGER,
  
  -- Estabelecimentos
  escolas_total INTEGER,
  escolas_publicas INTEGER,
  escolas_privadas INTEGER,
  
  -- Docentes
  professores_total INTEGER,
  professores_superior_completo INTEGER,
  professores_licenciatura INTEGER,
  
  -- Infraestrutura
  escolas_internet INTEGER,
  escolas_biblioteca INTEGER,
  escolas_lab_informatica INTEGER,
  escolas_quadra_esportiva INTEGER,
  
  -- Rendimento
  taxa_aprovacao_fundamental NUMERIC(5,2),
  taxa_reprovacao_fundamental NUMERIC(5,2),
  taxa_abandono_fundamental NUMERIC(5,2),
  taxa_aprovacao_medio NUMERIC(5,2),
  taxa_reprovacao_medio NUMERIC(5,2),
  taxa_abandono_medio NUMERIC(5,2),
  
  -- IDEB
  ideb_anos_iniciais NUMERIC(3,1),
  ideb_anos_finais NUMERIC(3,1),
  ideb_ensino_medio NUMERIC(3,1),
  
  -- Indicadores Calculados
  razao_aluno_professor NUMERIC(5,2),
  percentual_escolas_internet NUMERIC(5,2),
  percentual_professores_superior NUMERIC(5,2),
  
  -- Metadados
  fonte VARCHAR(100),
  data_coleta TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE(entidade_id, ano)
);

CREATE INDEX idx_dados_educacao_entidade ON dados_educacao(entidade_id);
CREATE INDEX idx_dados_educacao_ano ON dados_educacao(ano);
```

#### Tabela: `dados_saude`

Armazena indicadores de saúde por município e ano/mês.

```sql
CREATE TABLE dados_saude (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  entidade_id UUID NOT NULL REFERENCES entidades_territoriais(id),
  ano INTEGER NOT NULL,
  mes INTEGER, -- NULL para dados anuais
  
  -- Estabelecimentos
  estabelecimentos_total INTEGER,
  estabelecimentos_sus INTEGER,
  hospitais INTEGER,
  postos_saude INTEGER,
  
  -- Leitos
  leitos_total INTEGER,
  leitos_sus INTEGER,
  leitos_clinicos INTEGER,
  leitos_cirurgicos INTEGER,
  leitos_obstetricos INTEGER,
  leitos_pediatricos INTEGER,
  leitos_uti INTEGER,
  
  -- Profissionais
  medicos INTEGER,
  enfermeiros INTEGER,
  tecnicos_enfermagem INTEGER,
  dentistas INTEGER,
  
  -- Atenção Primária
  equipes_saude_familia INTEGER,
  agentes_comunitarios_saude INTEGER,
  populacao_coberta_esf INTEGER,
  percentual_cobertura_esf NUMERIC(5,2),
  
  -- Produção
  consultas_ambulatoriais INTEGER,
  internacoes INTEGER,
  
  -- Mortalidade e Nascimentos (dados anuais)
  obitos INTEGER,
  obitos_infantis INTEGER,
  nascidos_vivos INTEGER,
  taxa_mortalidade_infantil NUMERIC(6,2), -- por 1.000 nascidos vivos
  
  -- Doenças de Notificação
  casos_dengue INTEGER,
  casos_tuberculose INTEGER,
  casos_hanseniase INTEGER,
  
  -- Indicadores Calculados
  leitos_por_1000_hab NUMERIC(6,2),
  medicos_por_1000_hab NUMERIC(6,2),
  enfermeiros_por_1000_hab NUMERIC(6,2),
  
  -- Metadados
  fonte VARCHAR(100),
  data_coleta TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE(entidade_id, ano, mes)
);

CREATE INDEX idx_dados_saude_entidade ON dados_saude(entidade_id);
CREATE INDEX idx_dados_saude_ano ON dados_saude(ano);
CREATE INDEX idx_dados_saude_mes ON dados_saude(mes);
```

#### Tabela: `dados_assistencia_social`

Armazena dados de assistência social por município e ano/mês.

```sql
CREATE TABLE dados_assistencia_social (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  entidade_id UUID NOT NULL REFERENCES entidades_territoriais(id),
  ano INTEGER NOT NULL,
  mes INTEGER, -- NULL para dados anuais
  
  -- CadÚnico
  familias_cadastradas_cadunico INTEGER,
  familias_atualizadas_cadunico INTEGER,
  pessoas_cadastradas_cadunico INTEGER,
  familias_extrema_pobreza INTEGER,
  renda_media_per_capita NUMERIC(10,2),
  
  -- Bolsa Família
  familias_beneficiarias_bolsa_familia INTEGER,
  valor_repassado_bolsa_familia NUMERIC(15,2),
  valor_medio_bolsa_familia NUMERIC(10,2),
  
  -- BPC (Benefício de Prestação Continuada)
  beneficiarios_bpc_idoso INTEGER,
  beneficiarios_bpc_pcd INTEGER,
  valor_repassado_bpc NUMERIC(15,2),
  
  -- Equipamentos (dados anuais)
  numero_cras INTEGER,
  numero_creas INTEGER,
  
  -- Atendimentos (dados anuais)
  atendimentos_cras INTEGER,
  atendimentos_creas INTEGER,
  
  -- Indicadores Calculados
  percentual_familias_extrema_pobreza NUMERIC(5,2),
  percentual_familias_atualizadas NUMERIC(5,2),
  cobertura_bolsa_familia NUMERIC(5,2), -- % de famílias pobres cobertas
  
  -- Metadados
  fonte VARCHAR(100),
  data_coleta TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE(entidade_id, ano, mes)
);

CREATE INDEX idx_dados_assist_social_entidade ON dados_assistencia_social(entidade_id);
CREATE INDEX idx_dados_assist_social_ano ON dados_assistencia_social(ano);
```

#### Tabela: `dados_seguranca_publica`

Armazena dados de criminalidade por município e ano/mês.

```sql
CREATE TABLE dados_seguranca_publica (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  entidade_id UUID NOT NULL REFERENCES entidades_territoriais(id),
  ano INTEGER NOT NULL,
  mes INTEGER, -- NULL para dados anuais
  
  -- Crimes Violentos
  homicidios INTEGER,
  latrocinios INTEGER,
  lesoes_corporais_morte INTEGER,
  estupros INTEGER,
  feminicidios INTEGER,
  
  -- Crimes Patrimoniais
  roubos_total INTEGER,
  roubos_veiculos INTEGER,
  furtos_total INTEGER,
  furtos_veiculos INTEGER,
  
  -- Violência Doméstica
  violencia_domestica INTEGER,
  
  -- Efetivo (dados anuais, geralmente estaduais)
  efetivo_policial_militar INTEGER,
  efetivo_policial_civil INTEGER,
  
  -- Indicadores Calculados
  taxa_homicidios_por_100k NUMERIC(6,2),
  taxa_roubos_por_100k NUMERIC(6,2),
  taxa_estupros_por_100k NUMERIC(6,2),
  
  -- Metadados
  fonte VARCHAR(100),
  data_coleta TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE(entidade_id, ano, mes)
);

CREATE INDEX idx_dados_seguranca_entidade ON dados_seguranca_publica(entidade_id);
CREATE INDEX idx_dados_seguranca_ano ON dados_seguranca_publica(ano);
```

#### Tabela: `dados_habitacao_saneamento`

Armazena dados de habitação e saneamento por município e ano.

```sql
CREATE TABLE dados_habitacao_saneamento (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  entidade_id UUID NOT NULL REFERENCES entidades_territoriais(id),
  ano INTEGER NOT NULL,
  
  -- Domicílios (Censo, decenal)
  domicilios_total INTEGER,
  domicilios_proprios INTEGER,
  domicilios_alugados INTEGER,
  domicilios_cedidos INTEGER,
  
  -- Saneamento Básico (Censo)
  domicilios_agua_encanada INTEGER,
  domicilios_esgoto_rede INTEGER,
  domicilios_esgoto_fossa_septica INTEGER,
  domicilios_coleta_lixo INTEGER,
  domicilios_energia_eletrica INTEGER,
  
  -- Infraestrutura Digital (Censo)
  domicilios_internet INTEGER,
  domicilios_computador INTEGER,
  
  -- SNIS (anual)
  populacao_atendida_agua INTEGER,
  populacao_atendida_esgoto INTEGER,
  volume_agua_produzido NUMERIC(15,2), -- m³/ano
  volume_esgoto_coletado NUMERIC(15,2), -- m³/ano
  volume_esgoto_tratado NUMERIC(15,2), -- m³/ano
  
  -- Indicadores Calculados
  percentual_domicilios_agua NUMERIC(5,2),
  percentual_domicilios_esgoto NUMERIC(5,2),
  percentual_domicilios_coleta_lixo NUMERIC(5,2),
  percentual_domicilios_energia NUMERIC(5,2),
  percentual_domicilios_internet NUMERIC(5,2),
  percentual_domicilios_proprios NUMERIC(5,2),
  percentual_esgoto_tratado NUMERIC(5,2),
  deficit_habitacional INTEGER,
  
  -- Metadados
  fonte VARCHAR(100),
  data_coleta TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE(entidade_id, ano)
);

CREATE INDEX idx_dados_habitacao_entidade ON dados_habitacao_saneamento(entidade_id);
CREATE INDEX idx_dados_habitacao_ano ON dados_habitacao_saneamento(ano);
```

#### Tabela: `dados_trabalho_renda`

Armazena dados de trabalho e renda por município e ano/mês.

```sql
CREATE TABLE dados_trabalho_renda (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  entidade_id UUID NOT NULL REFERENCES entidades_territoriais(id),
  ano INTEGER NOT NULL,
  mes INTEGER, -- NULL para dados anuais (RAIS)
  
  -- Emprego Formal (RAIS, anual)
  empregos_formais_total INTEGER,
  empregos_agropecuaria INTEGER,
  empregos_industria INTEGER,
  empregos_construcao INTEGER,
  empregos_comercio INTEGER,
  empregos_servicos INTEGER,
  empregos_administracao_publica INTEGER,
  salario_medio NUMERIC(10,2),
  
  -- CAGED (mensal)
  admissoes INTEGER,
  demissoes INTEGER,
  saldo_empregos INTEGER,
  
  -- Indicadores Calculados
  taxa_emprego_formal NUMERIC(5,2), -- empregos formais / população em idade ativa
  participacao_agropecuaria NUMERIC(5,2),
  participacao_industria NUMERIC(5,2),
  participacao_servicos NUMERIC(5,2),
  
  -- Metadados
  fonte VARCHAR(100),
  data_coleta TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE(entidade_id, ano, mes)
);

CREATE INDEX idx_dados_trabalho_entidade ON dados_trabalho_renda(entidade_id);
CREATE INDEX idx_dados_trabalho_ano ON dados_trabalho_renda(ano);
```

#### Tabela: `dados_desenvolvimento_humano`

Armazena indicadores de desenvolvimento humano por município e ano (decenal, baseado em Censo).

```sql
CREATE TABLE dados_desenvolvimento_humano (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  entidade_id UUID NOT NULL REFERENCES entidades_territoriais(id),
  ano INTEGER NOT NULL,
  
  -- IDHM
  idhm NUMERIC(5,3),
  idhm_longevidade NUMERIC(5,3),
  idhm_educacao NUMERIC(5,3),
  idhm_renda NUMERIC(5,3),
  
  -- Desigualdade e Pobreza
  indice_gini NUMERIC(5,3),
  percentual_pobres NUMERIC(5,2),
  percentual_extremamente_pobres NUMERIC(5,2),
  
  -- Longevidade
  expectativa_vida NUMERIC(5,2),
  taxa_mortalidade_infantil NUMERIC(6,2),
  
  -- Educação
  taxa_analfabetismo NUMERIC(5,2),
  percentual_18_20_ensino_medio_completo NUMERIC(5,2),
  
  -- Renda
  renda_per_capita NUMERIC(10,2),
  
  -- Metadados
  fonte VARCHAR(100) DEFAULT 'Atlas Brasil',
  data_coleta TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE(entidade_id, ano)
);

CREATE INDEX idx_dados_desenv_humano_entidade ON dados_desenvolvimento_humano(entidade_id);
CREATE INDEX idx_dados_desenv_humano_ano ON dados_desenvolvimento_humano(ano);
```

#### Tabela: `dados_demografia`

Armazena dados demográficos por município e ano.

```sql
CREATE TABLE dados_demografia (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  entidade_id UUID NOT NULL REFERENCES entidades_territoriais(id),
  ano INTEGER NOT NULL,
  
  -- População (anual, estimativas IBGE)
  populacao_total INTEGER,
  populacao_urbana INTEGER,
  populacao_rural INTEGER,
  
  -- Estrutura Etária (decenal, Censo)
  populacao_0_4 INTEGER,
  populacao_5_9 INTEGER,
  populacao_10_14 INTEGER,
  populacao_15_19 INTEGER,
  populacao_20_24 INTEGER,
  populacao_25_29 INTEGER,
  populacao_30_34 INTEGER,
  populacao_35_39 INTEGER,
  populacao_40_44 INTEGER,
  populacao_45_49 INTEGER,
  populacao_50_54 INTEGER,
  populacao_55_59 INTEGER,
  populacao_60_64 INTEGER,
  populacao_65_mais INTEGER,
  
  populacao_masculina INTEGER,
  populacao_feminina INTEGER,
  
  -- Dinâmica Demográfica (anual)
  nascimentos INTEGER,
  obitos INTEGER,
  taxa_natalidade NUMERIC(6,2), -- por 1.000 habitantes
  taxa_mortalidade NUMERIC(6,2), -- por 1.000 habitantes
  crescimento_vegetativo INTEGER,
  
  -- Indicadores Calculados
  taxa_urbanizacao NUMERIC(5,2),
  razao_dependencia NUMERIC(5,2),
  idade_mediana NUMERIC(5,2),
  razao_sexo NUMERIC(6,2), -- homens / 100 mulheres
  
  -- Metadados
  fonte VARCHAR(100),
  data_coleta TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE(entidade_id, ano)
);

CREATE INDEX idx_dados_demografia_entidade ON dados_demografia(entidade_id);
CREATE INDEX idx_dados_demografia_ano ON dados_demografia(ano);
```

### 4.2. Views Úteis

#### View: `v_indicadores_sociais_recentes`

Consolida os indicadores sociais mais recentes de cada município.

```sql
CREATE VIEW v_indicadores_sociais_recentes AS
SELECT 
  e.id AS entidade_id,
  e.codigo_ibge,
  e.nome AS municipio,
  e.uf,
  
  -- Educação (ano mais recente)
  ed.ano AS ano_educacao,
  ed.matriculas_total,
  ed.ideb_anos_iniciais,
  ed.ideb_anos_finais,
  ed.taxa_aprovacao_fundamental,
  ed.razao_aluno_professor,
  
  -- Saúde (ano mais recente)
  sa.ano AS ano_saude,
  sa.leitos_por_1000_hab,
  sa.medicos_por_1000_hab,
  sa.percentual_cobertura_esf,
  sa.taxa_mortalidade_infantil,
  
  -- Assistência Social (ano mais recente)
  as.ano AS ano_assistencia,
  as.familias_cadastradas_cadunico,
  as.familias_beneficiarias_bolsa_familia,
  as.percentual_familias_extrema_pobreza,
  
  -- Desenvolvimento Humano (2010, último disponível)
  dh.idhm,
  dh.indice_gini,
  dh.percentual_pobres,
  dh.expectativa_vida,
  
  -- Demografia (ano mais recente)
  dem.populacao_total,
  dem.taxa_urbanizacao,
  dem.razao_dependencia

FROM entidades_territoriais e

LEFT JOIN LATERAL (
  SELECT * FROM dados_educacao 
  WHERE entidade_id = e.id 
  ORDER BY ano DESC LIMIT 1
) ed ON true

LEFT JOIN LATERAL (
  SELECT * FROM dados_saude 
  WHERE entidade_id = e.id AND mes IS NULL
  ORDER BY ano DESC LIMIT 1
) sa ON true

LEFT JOIN LATERAL (
  SELECT * FROM dados_assistencia_social 
  WHERE entidade_id = e.id AND mes IS NULL
  ORDER BY ano DESC LIMIT 1
) as ON true

LEFT JOIN LATERAL (
  SELECT * FROM dados_desenvolvimento_humano 
  WHERE entidade_id = e.id 
  ORDER BY ano DESC LIMIT 1
) dh ON true

LEFT JOIN LATERAL (
  SELECT * FROM dados_demografia 
  WHERE entidade_id = e.id 
  ORDER BY ano DESC LIMIT 1
) dem ON true

WHERE e.uf = 'TO';
```

#### View: `v_ranking_municipios_social`

Ranking de municípios por indicadores sociais.

```sql
CREATE VIEW v_ranking_municipios_social AS
SELECT 
  e.nome AS municipio,
  e.codigo_ibge,
  
  -- Educação
  ed.ideb_anos_iniciais,
  RANK() OVER (ORDER BY ed.ideb_anos_iniciais DESC NULLS LAST) AS rank_ideb,
  
  -- Saúde
  sa.leitos_por_1000_hab,
  RANK() OVER (ORDER BY sa.leitos_por_1000_hab DESC NULLS LAST) AS rank_leitos,
  sa.percentual_cobertura_esf,
  RANK() OVER (ORDER BY sa.percentual_cobertura_esf DESC NULLS LAST) AS rank_esf,
  
  -- Desenvolvimento Humano
  dh.idhm,
  RANK() OVER (ORDER BY dh.idhm DESC NULLS LAST) AS rank_idhm,
  dh.indice_gini,
  RANK() OVER (ORDER BY dh.indice_gini ASC NULLS LAST) AS rank_gini, -- menor é melhor
  
  -- Assistência Social
  as.percentual_familias_extrema_pobreza,
  RANK() OVER (ORDER BY as.percentual_familias_extrema_pobreza ASC NULLS LAST) AS rank_pobreza -- menor é melhor

FROM entidades_territoriais e

LEFT JOIN LATERAL (
  SELECT * FROM dados_educacao 
  WHERE entidade_id = e.id 
  ORDER BY ano DESC LIMIT 1
) ed ON true

LEFT JOIN LATERAL (
  SELECT * FROM dados_saude 
  WHERE entidade_id = e.id AND mes IS NULL
  ORDER BY ano DESC LIMIT 1
) sa ON true

LEFT JOIN LATERAL (
  SELECT * FROM dados_desenvolvimento_humano 
  WHERE entidade_id = e.id 
  ORDER BY ano DESC LIMIT 1
) dh ON true

LEFT JOIN LATERAL (
  SELECT * FROM dados_assistencia_social 
  WHERE entidade_id = e.id AND mes IS NULL
  ORDER BY ano DESC LIMIT 1
) as ON true

WHERE e.uf = 'TO' AND e.tipo = 'municipio';
```

### 4.3. Estimativa de Volume de Dados

| Tabela | Registros (TO) | Tamanho Estimado |
|--------|----------------|------------------|
| `dados_educacao` | 140 entidades × 10 anos = 1.400 | ~500 KB |
| `dados_saude` | 140 × 10 anos × 12 meses = 16.800 | ~8 MB |
| `dados_assistencia_social` | 140 × 10 anos × 12 meses = 16.800 | ~6 MB |
| `dados_seguranca_publica` | 140 × 10 anos × 12 meses = 16.800 | ~4 MB |
| `dados_habitacao_saneamento` | 140 × 2 censos = 280 | ~100 KB |
| `dados_trabalho_renda` | 140 × 10 anos × 12 meses = 16.800 | ~5 MB |
| `dados_desenvolvimento_humano` | 140 × 2 censos = 280 | ~50 KB |
| `dados_demografia` | 140 × 10 anos = 1.400 | ~1 MB |
| **TOTAL** | **~70.000 registros** | **~25 MB** |

**Nota:** Estimativas assumem 10 anos de dados históricos. Volume real dependerá de disponibilidade de dados e frequência de coleta.

---

## 5. Interconexões com Outras Dimensões

A dimensão social não existe isoladamente. Ela está profundamente interconectada com as dimensões econômica, territorial e ambiental. Identificar e explorar essas interconexões é fundamental para análises holísticas e políticas públicas efetivas.

### 5.1. Social ↔ Econômica

**Educação → Renda Futura**

Municípios com IDEB alto tendem a ter, 10-15 anos depois, salários médios mais elevados e maior proporção de empregos formais qualificados. Investimentos em educação hoje geram retornos econômicos no médio/longo prazo.

**Exemplo de Análise:**
```sql
-- Correlação entre IDEB (2013) e Salário Médio (2023)
SELECT 
  e.nome,
  ed2013.ideb_anos_finais AS ideb_2013,
  tr2023.salario_medio AS salario_2023
FROM entidades_territoriais e
JOIN dados_educacao ed2013 ON e.id = ed2013.entidade_id AND ed2013.ano = 2013
JOIN dados_trabalho_renda tr2023 ON e.id = tr2023.entidade_id AND tr2023.ano = 2023
WHERE e.uf = 'TO' AND e.tipo = 'municipio'
ORDER BY ed2013.ideb_anos_finais DESC;
```

**Assistência Social → Consumo Local**

Transferências de renda (Bolsa Família, BPC) injetam recursos na economia local, especialmente em municípios pequenos onde o comércio é a principal atividade econômica. Um real transferido gera efeito multiplicador de 1,5 a 2,0 no PIB municipal.

**Saúde → Produtividade**

Municípios com melhor cobertura de atenção primária (ESF) e menores taxas de mortalidade infantil tendem a ter trabalhadores mais saudáveis e produtivos, reduzindo absenteísmo e aumentando produtividade.

**Dependência Fiscal → Vulnerabilidade Social**

Municípios com alta dependência do FPM (> 80% das receitas) frequentemente têm indicadores sociais piores, pois têm menos recursos próprios para investir em educação, saúde e assistência social além do mínimo constitucional.

### 5.2. Social ↔ Territorial

**Urbanização → Acesso a Serviços**

Municípios com maior taxa de urbanização geralmente têm melhor acesso a serviços de saúde, educação e saneamento, pois é mais eficiente ofertar serviços em áreas densamente povoadas.

**Exemplo de Análise:**
```sql
-- Correlação entre Urbanização e Acesso a Saneamento
SELECT 
  e.nome,
  dem.taxa_urbanizacao,
  hs.percentual_domicilios_agua,
  hs.percentual_domicilios_esgoto
FROM entidades_territoriais e
JOIN dados_demografia dem ON e.id = dem.entidade_id AND dem.ano = 2022
JOIN dados_habitacao_saneamento hs ON e.id = hs.entidade_id AND hs.ano = 2022
WHERE e.uf = 'TO' AND e.tipo = 'municipio'
ORDER BY dem.taxa_urbanizacao DESC;
```

**Distância de Palmas → Indicadores Sociais**

Municípios mais distantes da capital (Palmas) tendem a ter indicadores sociais piores devido a menor acesso a serviços especializados (hospitais de referência, universidades) e menor dinamismo econômico.

**Área Rural → Desafios Específicos**

Populações rurais enfrentam desafios específicos: acesso limitado a escolas de ensino médio, postos de saúde distantes, falta de saneamento básico. Políticas públicas devem considerar essas especificidades.

### 5.3. Social ↔ Ambiental

**Saneamento → Saúde Pública**

Municípios com baixa cobertura de esgotamento sanitário têm maiores taxas de doenças de veiculação hídrica (diarreias, hepatite A, verminoses), aumentando internações e mortalidade infantil.

**Desmatamento → Doenças Transmitidas por Vetores**

Desmatamento e degradação ambiental aumentam incidência de doenças como dengue, malária e leishmaniose, impactando saúde pública e custos do SUS.

**Qualidade da Água → Mortalidade Infantil**

Acesso a água tratada é um dos principais determinantes da mortalidade infantil. Municípios sem tratamento adequado de água têm taxas de mortalidade infantil 2-3 vezes maiores.

### 5.4. Análises Integradas Prioritárias

Propomos **5 análises integradas** que cruzam múltiplas dimensões e geram insights acionáveis para gestores públicos:

**1. Índice de Vulnerabilidade Social Municipal**

Combina indicadores de pobreza, educação, saúde, habitação e dependência fiscal para criar um índice composto de vulnerabilidade social. Municípios com índice alto são prioritários para políticas de redução de desigualdades.

**2. Análise de Retorno sobre Investimento em Educação**

Correlaciona investimentos municipais em educação (% do orçamento, gasto por aluno) com evolução do IDEB ao longo do tempo, identificando municípios com melhor eficiência de gasto.

**3. Mapeamento de Desertos de Serviços Públicos**

Identifica áreas geográficas (municípios ou regiões) com baixa oferta de serviços essenciais (escolas de ensino médio, hospitais, CRAS), cruzando dados territoriais (distância, população) com dados de infraestrutura social.

**4. Projeção de Demanda por Serviços Sociais**

Utiliza projeções demográficas (envelhecimento populacional, migração) para estimar demanda futura por serviços de saúde (leitos geriátricos), educação (vagas em creches) e assistência social (BPC para idosos).

**5. Análise de Impacto de Programas Sociais**

Avalia impacto de programas como Bolsa Família na redução da pobreza, evasão escolar e mortalidade infantil, comparando municípios com diferentes níveis de cobertura do programa.

---

## 6. Casos de Uso Transformadores

Apresentamos **8 casos de uso** concretos que demonstram como o Agente SOCIAL do Framework V6.0 pode transformar a gestão pública no Tocantins.

### 6.1. Priorização de Investimentos em Educação

**Contexto:** Secretaria Estadual de Educação do Tocantins precisa decidir quais municípios receberão investimentos prioritários em infraestrutura escolar (construção de escolas, laboratórios, bibliotecas).

**Análise do Agente SOCIAL:**

1. Identifica municípios com IDEB abaixo da meta projetada
2. Cruza com dados de infraestrutura (% de escolas sem internet, sem biblioteca)
3. Considera taxa de crescimento populacional (demanda futura)
4. Calcula "déficit de infraestrutura educacional" por município
5. Gera ranking de priorização

**Resultado:** Lista de 20 municípios prioritários, com justificativa técnica baseada em dados, otimizando alocação de recursos limitados.

**Impacto Esperado:** Aumento de 0,3 pontos no IDEB médio dos municípios prioritários em 4 anos, reduzindo desigualdades educacionais no estado.

### 6.2. Expansão Estratégica da Estratégia Saúde da Família

**Contexto:** Secretaria Estadual de Saúde quer expandir cobertura de ESF, mas recursos são limitados. Precisa identificar municípios onde expansão terá maior impacto.

**Análise do Agente SOCIAL:**

1. Identifica municípios com cobertura ESF < 50%
2. Cruza com taxa de mortalidade infantil (indicador de necessidade)
3. Considera população sem acesso a hospital (dados territoriais)
4. Calcula "potencial de redução de mortalidade infantil" por equipe adicional de ESF
5. Gera ranking de priorização

**Resultado:** Lista de municípios onde cada equipe adicional de ESF pode salvar mais vidas, maximizando impacto do investimento.

**Impacto Esperado:** Redução de 15% na mortalidade infantil nos municípios prioritários em 3 anos.

### 6.3. Combate à Evasão Escolar

**Contexto:** Município identifica alta taxa de abandono escolar no ensino médio (12%), mas não sabe quais fatores estão causando o problema.

**Análise do Agente SOCIAL:**

1. Cruza dados de abandono escolar com dados socioeconômicos (renda, Bolsa Família)
2. Identifica correlação: 80% dos evadidos são de famílias com renda per capita < R$ 200
3. Cruza com dados de trabalho: 60% dos evadidos estão no mercado de trabalho informal
4. Identifica escolas com maiores taxas de abandono (geralmente em áreas rurais)

**Resultado:** Diagnóstico preciso das causas da evasão (pobreza + necessidade de trabalhar) e escolas prioritárias para intervenção.

**Ação Recomendada:** Expandir Bolsa Família para famílias com adolescentes no ensino médio, condicionado à frequência escolar. Oferecer ensino médio noturno em áreas rurais.

**Impacto Esperado:** Redução de 50% na taxa de abandono em 2 anos.

### 6.4. Otimização da Rede Hospitalar

**Contexto:** Estado do Tocantins tem déficit de leitos de UTI, mas não sabe onde construir novos hospitais ou ampliar existentes.

**Análise do Agente SOCIAL:**

1. Mapeia distribuição atual de leitos de UTI por município
2. Calcula população sem acesso a UTI em até 100 km (dados territoriais)
3. Identifica "desertos de UTI" (regiões com > 50 mil habitantes sem UTI próxima)
4. Considera demanda (taxa de internações, mortalidade por causas evitáveis)
5. Simula impacto de construir UTI em diferentes localizações

**Resultado:** Recomendação de construir 3 novos hospitais com UTI em municípios estratégicos, cobrindo 80% da população atualmente desassistida.

**Impacto Esperado:** Redução de 25% na mortalidade por causas evitáveis em 5 anos.

### 6.5. Identificação de Famílias Vulneráveis Não Cadastradas

**Contexto:** Município suspeita que há famílias em situação de pobreza que não estão cadastradas no CadÚnico e, portanto, não recebem Bolsa Família.

**Análise do Agente SOCIAL:**

1. Estima número de famílias pobres com base em Censo (% de pobres × população)
2. Compara com número de famílias cadastradas no CadÚnico
3. Identifica "gap de cobertura": 1.200 famílias estimadas pobres, mas apenas 800 cadastradas
4. Cruza com dados territoriais: famílias não cadastradas concentram-se em áreas rurais distantes

**Resultado:** Diagnóstico de 400 famílias vulneráveis não cadastradas, com localização geográfica provável.

**Ação Recomendada:** Realizar busca ativa nas áreas rurais identificadas, com equipes móveis de cadastramento.

**Impacto Esperado:** Aumento de 50% no número de famílias cadastradas em 1 ano, garantindo acesso a direitos sociais.

### 6.6. Planejamento de Infraestrutura de Saneamento

**Contexto:** Município quer universalizar acesso a água e esgoto, mas tem orçamento limitado. Precisa priorizar bairros/áreas.

**Análise do Agente SOCIAL:**

1. Mapeia áreas sem acesso a água e esgoto (dados Censo por setor censitário)
2. Cruza com taxa de mortalidade infantil por área (dados SIM georreferenciados)
3. Identifica áreas onde falta de saneamento está causando mais mortes
4. Calcula custo estimado de levar saneamento a cada área (dados territoriais: distância, topografia)
5. Calcula "custo por vida salva" para cada área

**Resultado:** Ranking de áreas prioritárias onde investimento em saneamento terá maior impacto em saúde pública por real investido.

**Impacto Esperado:** Redução de 40% na mortalidade infantil nas áreas prioritárias em 3 anos.

### 6.7. Monitoramento de Indicadores de Desenvolvimento Sustentável (ODS)

**Contexto:** Estado do Tocantins se comprometeu com Objetivos de Desenvolvimento Sustentável (ODS) da ONU, mas não tem sistema de monitoramento.

**Análise do Agente SOCIAL:**

1. Mapeia indicadores sociais do Framework V6.0 para metas dos ODS
   - ODS 1 (Erradicação da Pobreza): % de extremamente pobres
   - ODS 2 (Fome Zero): desnutrição infantil (dados SISVAN)
   - ODS 3 (Saúde e Bem-Estar): mortalidade infantil, cobertura ESF
   - ODS 4 (Educação de Qualidade): IDEB, taxa de alfabetização
   - ODS 6 (Água e Saneamento): % de domicílios com água e esgoto
   - ODS 10 (Redução das Desigualdades): Índice de Gini
2. Calcula progresso anual em cada meta
3. Identifica metas em risco de não serem cumpridas até 2030
4. Gera relatório de monitoramento para governador e sociedade civil

**Resultado:** Dashboard interativo de progresso do Tocantins nos ODS, com transparência e accountability.

**Impacto Esperado:** Aumento da pressão social por políticas efetivas, acelerando progresso em metas prioritárias.

### 6.8. Análise de Impacto de Crises (ex: Pandemia)

**Contexto:** Durante pandemia de COVID-19, gestores precisavam entender impacto em indicadores sociais para ajustar políticas.

**Análise do Agente SOCIAL:**

1. Compara indicadores sociais pré-pandemia (2019) vs durante pandemia (2020-2021)
2. Identifica impactos:
   - Educação: queda de 0,5 pontos no IDEB (ensino remoto precário)
   - Saúde: aumento de 20% na mortalidade infantil (redução de consultas pré-natal)
   - Assistência Social: aumento de 30% em famílias cadastradas no CadÚnico (empobrecimento)
   - Trabalho: perda de 15% dos empregos formais (fechamento de comércios)
3. Identifica municípios mais impactados (geralmente os mais pobres)
4. Simula impacto de políticas compensatórias (Auxílio Emergencial, merenda escolar para casa)

**Resultado:** Diagnóstico preciso de impactos da crise, orientando políticas de recuperação.

**Ação Recomendada:** Priorizar investimentos em educação (recuperação de aprendizagem), saúde (vacinação, pré-natal) e assistência social (manutenção de transferências de renda).

**Impacto Esperado:** Recuperação de indicadores sociais aos níveis pré-pandemia em 2-3 anos.

---

## 7. Roadmap de Implementação

Propomos um roadmap de **16 semanas** para implementação completa do Agente SOCIAL, dividido em **4 fases** incrementais.

### Fase 1: Fundação (Semanas 1-4)

**Objetivo:** Estabelecer infraestrutura básica e coletar dados prioritários de educação e saúde.

**Atividades:**

1. **Criar Tabelas PostgreSQL** (Semana 1)
   - Implementar schema completo (8 tabelas)
   - Criar índices e views
   - Testar integridade referencial

2. **Implementar Workflows n8n - Educação** (Semanas 2-3)
   - WF-SOCIAL-01: Coletor INEP Censo Escolar (microdados)
   - WF-SOCIAL-02: Coletor IDEB
   - Coletar dados de 2015-2024 para 139 municípios do TO

3. **Implementar Workflows n8n - Saúde** (Semanas 3-4)
   - WF-SOCIAL-03: Coletor CNES (leitos, estabelecimentos, profissionais)
   - WF-SOCIAL-04: Coletor e-Gestor AB (cobertura ESF)
   - Coletar dados atuais (último mês disponível)

4. **Validação e Testes** (Semana 4)
   - Verificar qualidade dos dados coletados
   - Calcular indicadores derivados
   - Gerar relatório de cobertura

**Entregas:**
- Banco de dados com 2.000+ registros (educação + saúde)
- 4 workflows n8n funcionais
- Relatório de validação

**Métricas de Sucesso:**
- 100% dos 139 municípios com dados de educação
- 100% dos municípios com dados de saúde
- Taxa de sucesso de coleta > 95%

### Fase 2: Expansão (Semanas 5-8)

**Objetivo:** Adicionar dados de assistência social, demografia e desenvolvimento humano.

**Atividades:**

1. **Implementar Workflows n8n - Assistência Social** (Semanas 5-6)
   - WF-SOCIAL-05: Coletor Cecad (CadÚnico)
   - WF-SOCIAL-06: Coletor Bolsa Família (Portal Transparência)
   - WF-SOCIAL-07: Coletor CadSUAS (CRAS/CREAS)
   - Coletar dados mensais de 2020-2024

2. **Implementar Workflows n8n - Demografia** (Semana 7)
   - WF-SOCIAL-08: Coletor IBGE Estimativas Populacionais
   - WF-SOCIAL-09: Coletor IBGE Censo Demográfico (2010, 2022)
   - Coletar dados de 2015-2024

3. **Implementar Workflows n8n - Desenvolvimento Humano** (Semana 7)
   - WF-SOCIAL-10: Coletor Atlas Brasil (IDHM, Gini, pobreza)
   - Coletar dados de 1991, 2000, 2010

4. **Calculador de Indicadores Sociais** (Semana 8)
   - WF-SOCIAL-11: Calcular indicadores derivados (taxas, percentuais, razões)
   - Executar para todos os municípios e anos

**Entregas:**
- Banco de dados com 10.000+ registros
- 7 workflows n8n adicionais (total: 11)
- Dashboard de indicadores sociais (view PostgreSQL)

**Métricas de Sucesso:**
- 100% dos municípios com dados de assistência social
- 100% dos municípios com IDHM (2010)
- Indicadores derivados calculados para 100% dos registros

### Fase 3: Complementação (Semanas 9-12)

**Objetivo:** Adicionar dados de habitação, trabalho e segurança pública.

**Atividades:**

1. **Implementar Workflows n8n - Habitação e Saneamento** (Semanas 9-10)
   - WF-SOCIAL-12: Coletor IBGE Censo (habitação)
   - WF-SOCIAL-13: Coletor SNIS (água, esgoto)
   - Coletar dados de 2010, 2022 (Censo) e 2015-2023 (SNIS)

2. **Implementar Workflows n8n - Trabalho e Renda** (Semanas 10-11)
   - WF-SOCIAL-14: Coletor RAIS (emprego formal)
   - WF-SOCIAL-15: Coletor CAGED (admissões/demissões)
   - Coletar dados de 2015-2023 (RAIS) e 2020-2024 (CAGED)

3. **Implementar Workflows n8n - Segurança Pública** (Semana 11)
   - WF-SOCIAL-16: Coletor SSP-TO (criminalidade)
   - Coletar dados de 2015-2024 (quando disponível)

4. **Validador de Qualidade de Dados Sociais** (Semana 12)
   - WF-SOCIAL-17: Validar consistência, detectar anomalias
   - Executar para todos os dados coletados

**Entregas:**
- Banco de dados com 50.000+ registros (todas as dimensões sociais)
- 6 workflows n8n adicionais (total: 17)
- Relatório de qualidade de dados

**Métricas de Sucesso:**
- 100% dos municípios com dados de habitação (Censo 2022)
- 100% dos municípios com dados de trabalho (RAIS 2023)
- Taxa de qualidade de dados > 90%

### Fase 4: Integração e Análises Avançadas (Semanas 13-16)

**Objetivo:** Integrar dados sociais com outras dimensões, implementar análises avançadas e criar dashboards.

**Atividades:**

1. **Análises Integradas** (Semanas 13-14)
   - Implementar 5 análises integradas (Social ↔ Econômica, Social ↔ Territorial, etc.)
   - Gerar relatórios de interconexões
   - Identificar insights acionáveis

2. **Casos de Uso Transformadores** (Semana 14)
   - Implementar 3 casos de uso prioritários (Priorização Educação, Expansão ESF, Combate Evasão)
   - Gerar recomendações para gestores públicos

3. **Dashboards e Visualizações** (Semana 15)
   - Criar dashboard interativo no Replit (Flask + Chart.js)
   - Mapas de calor de indicadores sociais
   - Rankings de municípios
   - Séries temporais

4. **Documentação e Treinamento** (Semana 16)
   - Documentar todos os workflows
   - Criar guia de uso para gestores públicos
   - Realizar treinamento com equipe piloto

**Entregas:**
- 5 análises integradas funcionais
- 3 casos de uso implementados
- Dashboard interativo completo
- Documentação completa

**Métricas de Sucesso:**
- 5 insights acionáveis identificados
- Dashboard acessado por 10+ gestores públicos
- Feedback positivo > 80%

### Cronograma Resumido

| Fase | Semanas | Entregas Principais | Esforço Estimado |
|------|---------|---------------------|------------------|
| **Fase 1: Fundação** | 1-4 | Educação + Saúde | 80 horas |
| **Fase 2: Expansão** | 5-8 | Assistência Social + Demografia + Desenv. Humano | 80 horas |
| **Fase 3: Complementação** | 9-12 | Habitação + Trabalho + Segurança | 80 horas |
| **Fase 4: Integração** | 13-16 | Análises Avançadas + Dashboards | 80 horas |
| **TOTAL** | **16 semanas** | **Agente SOCIAL Completo** | **320 horas** |

**Nota:** Esforço de 320 horas assume 1 desenvolvedor full-time (40h/semana × 8 semanas) ou 2 desenvolvedores part-time (20h/semana × 16 semanas).

---

## 8. Desafios e Limitações

### 8.1. Desafios Técnicos

**Ausência de APIs Oficiais**

A maioria das fontes de dados sociais (INEP, SNIS, Atlas Brasil) não possui APIs REST oficiais, exigindo download manual de microdados ou web scraping. Isso aumenta complexidade de implementação e fragilidade (mudanças em sites quebram scrapers).

**Mitigação:** Utilizar Base dos Dados (basedosdados.org) quando disponível, que oferece acesso via SQL a dados tratados. Para fontes sem API, implementar scrapers robustos com retry e notificação de falhas.

**Volume de Dados**

Microdados do Censo Escolar e RAIS são volumosos (> 1 GB compactado), exigindo processamento local e armazenamento significativo.

**Mitigação:** Filtrar dados apenas para Tocantins antes de armazenar no PostgreSQL. Implementar compactação e arquivamento de dados antigos.

**Defasagem Temporal**

Dados de Censo (habitação, IDHM) são decenais, com defasagem de 1-2 anos após coleta. Dados de mortalidade e nascimentos têm defasagem de 1-2 anos. Isso limita análises de curto prazo.

**Mitigação:** Complementar com dados de frequência maior (mensal/anual) quando disponível. Usar projeções e estimativas para períodos recentes.

**Qualidade Variável**

Dados dependem de preenchimento por gestores municipais (Censo Escolar, CNES, CadSUAS). Municípios pequenos frequentemente têm dados incompletos ou desatualizados.

**Mitigação:** Implementar validador de qualidade (WF-SOCIAL-17) que detecta inconsistências e alerta gestores. Trabalhar com secretarias estaduais para melhorar qualidade de preenchimento.

### 8.2. Desafios de Dados

**Dados Municipais de Segurança Pública Escassos**

SSP-TO divulga dados principalmente em nível estadual. Dados municipais são limitados e não padronizados.

**Mitigação:** Focar em dados estaduais e, quando disponível, municipal. Pressionar SSP-TO para maior transparência e granularidade.

**Dados de Trabalho Não Representativos**

PNAD Contínua (taxa de desemprego, informalidade) não é representativa para municípios individuais, apenas para estados.

**Mitigação:** Usar RAIS e CAGED (emprego formal) como proxy. Reconhecer limitação em análises de informalidade municipal.

**Dados de Habitação Defasados**

Censo 2022 ainda não divulgou todos os dados de habitação. Dados mais recentes são de 2010, com 14 anos de defasagem.

**Mitigação:** Usar estimativas baseadas em SNIS (saneamento) e PNAD Contínua (estadual) para períodos recentes. Aguardar divulgação completa do Censo 2022.

### 8.3. Desafios Operacionais

**Capacitação de Gestores Públicos**

Gestores municipais frequentemente não têm formação em análise de dados, dificultando uso efetivo do sistema.

**Mitigação:** Criar interface simplificada (dashboards visuais, relatórios em linguagem não-técnica). Oferecer treinamentos e suporte técnico.

**Resistência a Mudanças**

Gestores podem resistir a adotar sistema baseado em dados, preferindo decisões baseadas em intuição ou pressões políticas.

**Mitigação:** Demonstrar valor através de casos de uso concretos. Envolver gestores desde o início (co-criação). Obter apoio de lideranças (governador, secretários estaduais).

**Sustentabilidade Financeira**

Sistema requer manutenção contínua (atualização de dados, correção de bugs, suporte a usuários). Sem financiamento garantido, pode ser descontinuado.

**Mitigação:** Buscar financiamento de organismos internacionais (Banco Mundial, BID) ou fundações (Gates, Lemann). Demonstrar ROI através de melhorias em indicadores sociais.

---

## 9. Recomendações Estratégicas

### 9.1. Priorizar Dados de Alto Impacto

Nem todos os dados têm o mesmo valor. Recomendamos priorizar coleta e análise de dados que:
- Estão disponíveis e atualizados (educação, saúde, assistência social)
- Têm impacto direto em decisões de políticas públicas (IDEB, cobertura ESF, Bolsa Família)
- Permitem comparações entre municípios (indicadores padronizados)

Dados de segurança pública e habitação, embora importantes, são mais escassos e defasados, devendo ser tratados como prioridade secundária.

### 9.2. Investir em Parcerias

Estabelecer parcerias com:
- **Secretarias Estaduais** (Educação, Saúde, Assistência Social): Acesso a dados, validação de análises, adoção do sistema
- **IBGE Regional**: Acesso antecipado a dados, suporte técnico
- **Universidades** (UFT, UNITINS): Pesquisas, validação acadêmica, formação de recursos humanos
- **TCE-TO** (Tribunal de Contas do Estado): Uso do sistema para fiscalização, pressão por qualidade de dados

### 9.3. Garantir Transparência e Participação Social

Disponibilizar dados e análises publicamente (portal de transparência, dados abertos), permitindo:
- Controle social sobre políticas públicas
- Pesquisas acadêmicas
- Jornalismo investigativo
- Advocacy de ONGs

Transparência aumenta pressão por melhoria de indicadores e reduz margem para decisões arbitrárias.

### 9.4. Iterar e Melhorar Continuamente

Sistema deve evoluir com base em feedback de usuários (gestores públicos, sociedade civil). Implementar ciclos de melhoria contínua:
1. Coletar feedback (surveys, entrevistas, analytics de uso)
2. Identificar problemas e oportunidades
3. Priorizar melhorias
4. Implementar e testar
5. Repetir

### 9.5. Documentar Lições Aprendidas

Documentar sucessos e fracassos, criando conhecimento replicável para outros estados. Publicar artigos acadêmicos, apresentar em conferências, compartilhar código aberto (GitHub).

---

## 10. Conclusão

A dimensão social é fundamental para compreender qualidade de vida, bem-estar e desenvolvimento humano das populações. No Tocantins, estado com desafios sociais significativos (baixo IDHM, alta pobreza, indicadores educacionais e de saúde abaixo da média nacional), um sistema integrado de dados sociais pode transformar a gestão pública.

Este documento identificou **12 fontes principais** de dados sociais, mapeou **mais de 150 indicadores** organizados em **8 áreas** (Educação, Saúde, Assistência Social, Segurança Pública, Habitação e Saneamento, Trabalho e Renda, Desenvolvimento Humano, Demografia), propôs **estrutura de banco de dados** integrada, mapeou **interconexões críticas** com outras dimensões e apresentou **8 casos de uso transformadores**.

O **Agente SOCIAL** do Framework V6.0, quando implementado, permitirá aos gestores públicos do Tocantins:
- Tomar decisões baseadas em evidências, não em intuição
- Priorizar investimentos onde terão maior impacto
- Monitorar progresso em indicadores-chave de forma contínua
- Identificar vulnerabilidades e agir proativamente
- Prestar contas à sociedade com transparência

A implementação completa do Agente SOCIAL é viável em **16 semanas** (4 meses) com **320 horas** de esforço de desenvolvimento, seguindo o roadmap proposto. Os desafios são significativos (ausência de APIs, dados defasados, capacitação de gestores), mas superáveis com estratégia adequada.

O potencial de impacto é extraordinário: melhorias em educação, saúde e assistência social podem transformar vidas de milhares de tocantinenses, especialmente os mais vulneráveis. Este é o verdadeiro valor do Framework V6.0 - não apenas dados e tecnologia, mas **transformação social baseada em evidências**.

---

## Referências

1. [INEP - Censo Escolar](https://www.gov.br/inep/pt-br/areas-de-atuacao/pesquisas-estatisticas-e-indicadores/censo-escolar)
2. [INEP - IDEB](https://www.gov.br/inep/pt-br/areas-de-atuacao/pesquisas-estatisticas-e-indicadores/ideb)
3. [DataSUS - API de Dados Abertos](https://apidadosabertos.saude.gov.br/)
4. [DataSUS - CNES](https://cnes.datasus.gov.br/)
5. [DataSUS - TabNet](http://tabnet.datasus.gov.br/)
6. [MDS - Cecad 2.0](https://cecad.cidadania.gov.br/)
7. [Portal da Transparência - Bolsa Família](https://portaldatransparencia.gov.br/bolsa-familia-e-cadastro-unico)
8. [Fórum Brasileiro de Segurança Pública](https://forumseguranca.org.br/)
9. [IBGE - Censo Demográfico](https://www.ibge.gov.br/estatisticas/sociais/populacao/22827-censo-demografico-2022.html)
10. [SNIS - Sistema Nacional de Informações sobre Saneamento](http://www.snis.gov.br/)
11. [Atlas do Desenvolvimento Humano no Brasil](http://www.atlasbrasil.org.br/)
12. [Base dos Dados](https://basedosdados.org/)

---

**Framework de Interação Galáctica V6.0**  
**Desenvolvido com ❤️ por Henrique Ribeiro & Manus IA**  
**Metodologia Inovadora de Colaboração Humano-IA**

**Versão:** 1.0  
**Data:** 07 de Novembro de 2025  
**Status:** ✅ Pronto para Implementação
