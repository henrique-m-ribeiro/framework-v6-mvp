# Análise Abrangente da Dimensão Ambiental - Framework V6.0

**Versão:** 1.0  
**Data:** 07 de Novembro de 2025  
**Autor:** Henrique Ribeiro & Manus IA  
**Status:** Completo

---

## Sumário Executivo

A dimensão ambiental representa um pilar fundamental para a gestão pública sustentável no estado do Tocantins. Este documento apresenta uma análise abrangente de todos os dados ambientais relevantes disponíveis, suas fontes, estruturas de armazenamento e potenciais aplicações no Framework de Interação Galáctica V6.0.

O Tocantins enfrenta desafios ambientais significativos, incluindo desmatamento acelerado (especialmente no Cerrado), queimadas recorrentes, pressão sobre recursos hídricos e necessidade de conciliar desenvolvimento econômico com conservação ambiental. A disponibilidade de dados ambientais de alta qualidade, provenientes de instituições como INPE, ANA, IBAMA e INMET, oferece uma oportunidade única para transformar a gestão ambiental através de análises baseadas em evidências.

Esta análise identifica **10 fontes principais** de dados ambientais, mapeia **120+ indicadores** prioritários organizados em **8 áreas temáticas**, propõe uma **estrutura de dados PostgreSQL** com 8 tabelas especializadas, documenta interconexões críticas com outras dimensões (econômica, social, territorial) e apresenta **8 casos de uso transformadores** que podem gerar impacto real na gestão ambiental do estado.

---

## 1. Contexto e Relevância

### 1.1 Desafios Ambientais do Tocantins

O estado do Tocantins, criado em 1988, ocupa uma posição estratégica na transição entre os biomas Amazônia (9% do território) e Cerrado (91% do território). Esta localização geográfica única traz desafios ambientais complexos que exigem gestão sofisticada e baseada em dados.

**Desmatamento no Cerrado.** O Cerrado tocantinense tem experimentado taxas de desmatamento alarmantes nas últimas décadas, impulsionadas pela expansão da fronteira agrícola, especialmente soja e pecuária. Diferentemente da Amazônia, que recebe atenção internacional e possui sistemas robustos de monitoramento (PRODES, DETER), o Cerrado historicamente foi negligenciado, resultando em perda acelerada de vegetação nativa. Dados do MapBiomas indicam que o Tocantins perdeu aproximadamente 30% de sua cobertura nativa de Cerrado entre 1985 e 2020.

**Queimadas recorrentes.** O estado enfrenta temporadas de queimadas severas anualmente, especialmente entre julho e outubro (estação seca). Estas queimadas têm múltiplas causas: práticas agrícolas tradicionais (limpeza de pastagens), acidentes, e incêndios criminosos. As consequências incluem perda de biodiversidade, emissões de gases de efeito estufa, problemas respiratórios na população e impactos econômicos (turismo, agricultura). O INPE registra milhares de focos de calor no Tocantins anualmente, com picos em anos de seca severa.

**Pressão sobre recursos hídricos.** Apesar de ser banhado por importantes bacias hidrográficas (Tocantins-Araguaia), o estado enfrenta desafios de disponibilidade hídrica, especialmente durante a estação seca. A expansão da agricultura irrigada, crescimento urbano e mudanças climáticas aumentam a pressão sobre os recursos hídricos. Conflitos pelo uso da água entre agricultura, abastecimento urbano e conservação ambiental tendem a se intensificar.

**Mudanças climáticas.** Projeções climáticas indicam que o Tocantins experimentará aumento de temperatura (2-4°C até 2100), redução de precipitação na estação seca e aumento de eventos extremos (secas prolongadas, chuvas intensas). Estas mudanças ameaçam a agricultura, biodiversidade e qualidade de vida da população.

**Conflitos entre desenvolvimento e conservação.** O Tocantins busca equilibrar desenvolvimento econômico (agricultura, pecuária, mineração) com conservação ambiental. Este equilíbrio é politicamente sensível e tecnicamente complexo, exigindo ferramentas analíticas sofisticadas para identificar soluções win-win.

### 1.2 Papel do Agente AMBIENTAL

O Agente AMBIENTAL do Framework V6.0 será responsável por coletar, processar, analisar e apresentar dados ambientais de forma acessível para gestores públicos. Suas funções incluem:

**Monitoramento contínuo.** Acompanhar indicadores ambientais em tempo real ou quase real (focos de queimadas, alertas de desmatamento, qualidade do ar, níveis de rios), alertando gestores sobre situações críticas que exigem ação imediata.

**Análises de tendências.** Identificar padrões temporais (aumento/redução de desmatamento, mudanças em precipitação, evolução de qualidade da água) e espaciais (hotspots de queimadas, áreas de desmatamento concentrado) que informem políticas públicas.

**Avaliação de impactos.** Estimar impactos ambientais de decisões de gestão (ex: construção de rodovia → desmatamento; expansão agrícola → emissões GEE; criação de unidade de conservação → conservação de biodiversidade).

**Suporte a licenciamento.** Fornecer informações ambientais para processos de licenciamento (ex: área de influência de empreendimento, presença de espécies ameaçadas, vulnerabilidade a queimadas).

**Relatórios automatizados.** Gerar relatórios periódicos (mensais, anuais) sobre estado do meio ambiente no Tocantins, facilitando prestação de contas e transparência.

**Integração com outras dimensões.** Conectar dados ambientais com econômicos (ex: desmatamento → PIB agropecuário), sociais (ex: qualidade do ar → saúde respiratória) e territoriais (ex: rodovias → desmatamento), permitindo análises holísticas.

### 1.3 Especificidades do Tocantins

**Bioma Cerrado dominante.** 91% do território tocantinense é Cerrado, um bioma altamente ameaçado (apenas ~50% de vegetação nativa remanescente no Brasil) e historicamente submonitorado. Ferramentas de monitoramento ambiental devem priorizar o Cerrado, não apenas a Amazônia.

**Fronteira agrícola ativa.** O Tocantins é parte do MATOPIBA (Maranhão, Tocantins, Piauí, Bahia), a última grande fronteira agrícola do Brasil. A expansão agrícola é rápida e geograficamente concentrada, exigindo monitoramento espacialmente explícito.

**Baixa capacidade institucional.** Órgãos ambientais estaduais e municipais frequentemente têm recursos limitados (orçamento, pessoal, tecnologia). Ferramentas que automatizam coleta, processamento e análise de dados podem amplificar dramaticamente a capacidade de gestão.

**Dados abundantes, análise escassa.** Brasil possui infraestrutura de dados ambientais de classe mundial (INPE, ANA, IBGE, MapBiomas). O desafio não é falta de dados, mas falta de capacidade analítica para transformar dados em inteligência acionável. O Framework V6.0 preenche esta lacuna.

---

## 2. Fontes de Dados Identificadas

Esta seção detalha as 10 principais fontes de dados ambientais disponíveis para o Tocantins, organizadas por área temática.

### 2.1 Queimadas e Qualidade do Ar

#### 2.1.1 INPE BDQueimadas

**Descrição.** O Banco de Dados de Queimadas (BDQueimadas) do Instituto Nacional de Pesquisas Espaciais (INPE) é o sistema oficial de monitoramento de focos de calor no Brasil, operando desde 1998.

**Cobertura.** América Latina, com foco no Brasil. Dados desde junho de 1998 até o presente.

**Atualização.** Dados são atualizados a cada 3 horas, permitindo monitoramento quase em tempo real.

**Satélites utilizados.** NOAA-20, AQUA (Tarde), TERRA (Manhã), NPP-375, GOES-16, MSG-03, NOAA-21, METOP-B, METOP-C, AQUA (Noite), TERRA (Noite).

**Dados disponíveis:**
- Coordenadas geográficas (latitude, longitude) de cada foco de calor
- Data e hora de detecção
- Satélite que detectou o foco
- Município, estado, bioma, país
- Risco de fogo (baseado em precipitação acumulada)
- Número de dias sem chuva
- Precipitação acumulada (30, 60, 90, 120 dias)
- Frações de Radiação Fotossinteticamente Ativa (FRP - Fire Radiative Power)

**Acesso.** 
- Portal web: https://terrabrasilis.dpi.inpe.br/queimadas/bdqueimadas/
- Download de dados: Shapefiles, CSV, KML
- API: Não documentada publicamente, mas dados podem ser baixados programaticamente

**Limitações.**
- Focos de calor não são equivalentes a queimadas (um foco pode representar múltiplas queimadas, ou uma queimada pode gerar múltiplos focos)
- Detecção depende de condições atmosféricas (nuvens bloqueiam detecção)
- Resolução espacial varia por satélite (375m a 5km)
- Não distingue tipo de queimada (florestal, agrícola, urbana)

**Relevância para Tocantins.** Crítica. Queimadas são um dos principais desafios ambientais do estado. Monitoramento em tempo real permite resposta rápida (brigadas de incêndio, alertas à população).

#### 2.1.2 INPE CPTEC - Qualidade do Ar

**Descrição.** O Centro de Previsão de Tempo e Estudos Climáticos (CPTEC) do INPE opera modelos de qualidade do ar que estimam concentrações de poluentes atmosféricos, incluindo Material Particulado (PM2.5, PM10), Monóxido de Carbono (CO) e Ozônio (O3).

**Cobertura.** América do Sul, com resolução de ~20km.

**Atualização.** Previsões diárias para os próximos 3 dias.

**Dados disponíveis:**
- Concentrações de PM2.5, PM10, CO, O3
- Mapas de dispersão de poluentes
- Índices de qualidade do ar

**Acesso.**
- Portal web: http://meioambiente.cptec.inpe.br/
- Dados brutos: Não facilmente acessíveis para download automatizado

**Limitações.**
- Dados são modelados (não observados diretamente), com incertezas
- Resolução espacial grosseira (~20km) não captura variabilidade intra-municipal
- Validação limitada por falta de estações de monitoramento de qualidade do ar no Tocantins

**Relevância para Tocantins.** Alta. Qualidade do ar deteriora significativamente durante temporada de queimadas, impactando saúde pública (doenças respiratórias, hospitalizações).

### 2.2 Clima e Meteorologia

#### 2.2.1 INMET - Banco de Dados Meteorológicos (BDMEP)

**Descrição.** O Instituto Nacional de Meteorologia (INMET) opera a rede oficial de estações meteorológicas do Brasil. O Banco de Dados Meteorológicos (BDMEP) disponibiliza séries históricas de dados meteorológicos diários.

**Cobertura.** Todo o Brasil. No Tocantins, há aproximadamente 10-15 estações meteorológicas convencionais e automáticas.

**Período.** Séries históricas desde 1961 (algumas estações têm dados desde décadas anteriores).

**Atualização.** Dados diários, disponibilizados com atraso de ~1-2 dias.

**Dados disponíveis (diários):**
- Temperatura (máxima, mínima, média, horária)
- Precipitação (acumulada diária)
- Umidade relativa do ar (máxima, mínima, média)
- Pressão atmosférica
- Velocidade e direção do vento
- Insolação (horas de sol)
- Evaporação
- Nebulosidade

**Acesso.**
- Portal web: https://bdmep.inmet.gov.br/
- Download: Dados podem ser baixados por estação e período (formato CSV)
- API: Não documentada oficialmente, mas possível acessar via web scraping

**Limitações.**
- Cobertura espacial limitada (10-15 estações para 139 municípios)
- Dados faltantes (falhas de equipamento, manutenção)
- Acesso não é via API REST moderna (requer web scraping ou download manual)

**Relevância para Tocantins.** Essencial. Dados meteorológicos são fundamentais para agricultura (previsão de safras), recursos hídricos (balanço hídrico), queimadas (risco de fogo), saúde (ondas de calor) e planejamento urbano.

#### 2.2.2 INMET - Dados em Tempo Real

**Descrição.** Além de dados históricos, o INMET disponibiliza dados meteorológicos em tempo real (últimas 24-48 horas) de estações automáticas.

**Cobertura.** Estações automáticas no Tocantins (~10 estações).

**Atualização.** Horária.

**Dados disponíveis.** Similares ao BDMEP, mas com resolução horária.

**Acesso.**
- Portal web: https://portal.inmet.gov.br/
- Mapas interativos de temperatura, precipitação, etc.

**Relevância para Tocantins.** Alta. Dados em tempo real permitem monitoramento de eventos extremos (chuvas intensas, secas, ondas de calor) e suporte a decisões operacionais (ex: suspensão de queimadas controladas em dias de vento forte).

### 2.3 Recursos Hídricos

#### 2.3.1 ANA HIDROWEB

**Descrição.** O Sistema de Informações Hidrológicas (HIDROWEB) da Agência Nacional de Águas e Saneamento Básico (ANA) é o repositório oficial de dados hidrológicos do Brasil.

**Cobertura.** Todo o Brasil. No Tocantins, há dezenas de estações fluviométricas (medem vazão de rios) e pluviométricas (medem chuva).

**Período.** Séries históricas desde 1930s (algumas estações), com a maioria desde 1960s-1970s.

**Atualização.** Dados são disponibilizados com atraso de ~1-3 meses (dados passam por processo de validação).

**Dados disponíveis:**
- **Vazão:** Vazão diária de rios (m³/s)
- **Cota:** Nível d'água (cm)
- **Precipitação:** Chuva diária (mm)
- **Qualidade da água:** Parâmetros físico-químicos e biológicos (ver seção 2.3.2)
- **Sedimentos:** Concentração e carga de sedimentos

**Acesso.**
- Portal web: https://www.snirh.gov.br/hidroweb/
- Download: Dados podem ser baixados por estação e período (formato CSV, Excel)
- API: HidroWebservice (ver seção 2.3.3)

**Limitações.**
- Atraso na disponibilização (1-3 meses)
- Dados faltantes (estações desativadas, falhas de equipamento)
- Cobertura espacial irregular (algumas bacias bem monitoradas, outras não)

**Relevância para Tocantins.** Crítica. Recursos hídricos são fundamentais para agricultura irrigada, abastecimento urbano, geração de energia (hidrelétricas) e navegação. Monitoramento de vazão permite gestão de conflitos pelo uso da água e prevenção de crises hídricas.

#### 2.3.2 ANA - Rede Nacional de Monitoramento de Qualidade da Água (RNQA)

**Descrição.** A RNQA é uma rede de monitoramento de qualidade de águas superficiais operada pela ANA em parceria com órgãos estaduais.

**Cobertura.** Principais bacias hidrográficas do Brasil. No Tocantins, há pontos de monitoramento nas bacias Tocantins-Araguaia.

**Período.** Dados desde 2013 (criação da RNQA), com algumas séries históricas anteriores.

**Frequência.** Coletas trimestrais ou semestrais (varia por ponto).

**Parâmetros monitorados (40+):**
- **Físico-químicos:** Temperatura, pH, Oxigênio Dissolvido (OD), Condutividade Elétrica, Turbidez, Sólidos Totais Dissolvidos, Demanda Bioquímica de Oxigênio (DBO), Demanda Química de Oxigênio (DQO)
- **Nutrientes:** Nitrogênio Total, Nitrato, Nitrito, Amônia, Fósforo Total, Fosfato
- **Metais:** Alumínio, Arsênio, Cádmio, Chumbo, Cobre, Cromo, Ferro, Manganês, Mercúrio, Níquel, Zinco
- **Microbiológicos:** Coliformes Termotolerantes, Escherichia coli
- **Orgânicos:** Óleos e Graxas, Fenóis

**Acesso.**
- Portal web: https://qualidadedaagua.ana.gov.br/
- Download: Dados podem ser baixados por ponto e período (formato CSV)
- Integração com HIDROWEB

**Limitações.**
- Frequência de coleta baixa (trimestral/semestral) não captura eventos agudos de poluição
- Cobertura espacial limitada (poucos pontos para área do estado)
- Atraso na disponibilização (dados passam por análise laboratorial)

**Relevância para Tocantins.** Alta. Qualidade da água é crítica para abastecimento urbano, saúde pública e conservação de ecossistemas aquáticos. Monitoramento permite identificar fontes de poluição (esgoto, agricultura, mineração) e avaliar eficácia de políticas de saneamento.

#### 2.3.3 ANA HidroWebservice API

**Descrição.** A ANA disponibiliza uma API REST (HidroWebservice) para acesso programático a dados hidrológicos do HIDROWEB.

**Documentação.** Manual disponível em https://www.gov.br/ana/pt-br/assuntos/monitoramento-e-eventos-criticos/monitoramento-hidrologico/orientacoes-manuais/manuais/manual-hidrowebservice_publica.pdf

**Endpoints principais:**
- `ListaEstacoesTelemetricas`: Lista estações telemétricas
- `DadosHidrometeorologicos`: Dados de vazão, cota, precipitação
- `QualidadeAgua`: Dados de qualidade da água

**Formato.** JSON, XML

**Autenticação.** Não requer (dados públicos)

**Relevância para Tocantins.** Essencial. API permite automação completa da coleta de dados hidrológicos, alimentando o Agente AMBIENTAL em tempo real.

### 2.4 Desmatamento e Uso do Solo

#### 2.4.1 MapBiomas

**Descrição.** MapBiomas é uma iniciativa multi-institucional que produz mapas anuais de cobertura e uso do solo do Brasil usando imagens de satélite Landsat e algoritmos de machine learning.

**Cobertura.** Todo o Brasil, todos os biomas. Dados desde 1985 até o presente (atualização anual).

**Resolução espacial.** 30 metros (pixel de 30m x 30m).

**Classes de uso do solo (27 classes principais):**
- **Formações Florestais:** Floresta, Savana, Mangue
- **Formações Naturais Não Florestais:** Campo, Pastagem Natural, Área Úmida
- **Agropecuária:** Pastagem, Agricultura Anual, Agricultura Perene, Mosaico Agricultura-Pastagem
- **Área Não Vegetada:** Praia, Duna, Afloramento Rochoso, Área Urbanizada, Mineração
- **Corpo D'água:** Rio, Lago, Oceano, Aquicultura

**Dados disponíveis:**
- Mapas raster anuais (1985-presente)
- Estatísticas de área por classe, município, bioma
- Transições de uso do solo (ex: Floresta → Pastagem)
- Coleções temáticas (Fogo, Água, Infraestrutura)

**Acesso.**
- Portal web: https://mapbiomas.org/
- Plataforma online: Visualização e download de mapas
- Google Earth Engine: Acesso programático via Python/JavaScript
- API: Estatísticas agregadas via API REST

**Limitações.**
- Resolução temporal anual (não captura mudanças intra-anuais)
- Classificação automatizada tem erros (acurácia ~90%, varia por classe)
- Dados mais recentes têm atraso de ~1 ano (ex: dados de 2024 disponíveis em 2025)

**Relevância para Tocantins.** Crítica. MapBiomas é a fonte mais completa e consistente de dados de uso do solo no Brasil. Permite análises de longo prazo (1985-presente) sobre expansão agrícola, desmatamento, urbanização e recuperação de vegetação.

#### 2.4.2 INPE PRODES

**Descrição.** O Projeto de Monitoramento do Desmatamento na Amazônia Legal por Satélite (PRODES) do INPE é o sistema oficial de medição de desmatamento na Amazônia brasileira, operando desde 1988.

**Cobertura.** Amazônia Legal (inclui 9% do Tocantins que está no bioma Amazônia). Desde 2023, há PRODES Cerrado cobrindo o restante do estado.

**Resolução espacial.** Identifica polígonos de desmatamento ≥ 6,25 hectares.

**Período.** Dados anuais desde 1988 (Amazônia) e 2000 (Cerrado).

**Metodologia.** Interpretação visual de imagens Landsat por analistas especializados (considerado padrão-ouro de acurácia).

**Dados disponíveis:**
- Polígonos de desmatamento (shapefiles)
- Área desmatada por município, estado, ano
- Taxa anual de desmatamento
- Incremento anual (desmatamento novo vs acumulado)

**Acesso.**
- Portal web: http://terrabrasilis.dpi.inpe.br/
- Download: Shapefiles de polígonos de desmatamento
- API: Não documentada, mas dados podem ser acessados via TerraBrasilis

**Limitações.**
- Resolução temporal anual (não detecta desmatamento intra-anual)
- Limite mínimo de 6,25 ha (não detecta desmatamentos menores)
- Atraso de ~1 ano (dados de 2024 disponíveis em agosto de 2025)
- PRODES Cerrado é mais recente (desde 2000) e tem menos histórico que PRODES Amazônia

**Relevância para Tocantins.** Alta. PRODES fornece dados oficiais de desmatamento, usados para fiscalização, políticas públicas e acordos internacionais. Para Tocantins, PRODES Cerrado é especialmente relevante (91% do território).

#### 2.4.3 INPE DETER

**Descrição.** O Sistema de Detecção de Desmatamento em Tempo Real (DETER) do INPE é um sistema de alertas de desmatamento baseado em imagens de satélites de média resolução (MODIS, Sentinel).

**Cobertura.** Amazônia Legal e Cerrado (cobre 100% do Tocantins).

**Resolução temporal.** Diária (quando há imagens sem nuvens).

**Resolução espacial.** Detecta polígonos ≥ 3 hectares (Amazônia) e ≥ 6 hectares (Cerrado).

**Dados disponíveis:**
- Polígonos de alertas de desmatamento
- Data de detecção
- Área do polígono
- Tipo de alerta (desmatamento, degradação, corte seletivo)
- Município, estado, bioma

**Acesso.**
- Portal web: http://terrabrasilis.dpi.inpe.br/
- Download: Shapefiles de alertas
- API: Possível via TerraBrasilis

**Limitações.**
- Alertas são preliminares (não passam por validação rigorosa como PRODES)
- Dependem de condições atmosféricas (nuvens bloqueiam detecção)
- Taxa de falsos positivos (alertas que não são desmatamento real)
- Resolução espacial grosseira (não detecta desmatamentos < 3-6 ha)

**Relevância para Tocantins.** Alta. DETER permite resposta rápida a desmatamento ilegal (fiscalização, embargos) antes que o dano seja irreversível. Complementa PRODES (anual) com monitoramento contínuo.

### 2.5 Biodiversidade e Áreas Protegidas

#### 2.5.1 ICMBio - Unidades de Conservação

**Descrição.** O Instituto Chico Mendes de Conservação da Biodiversidade (ICMBio) gerencia as Unidades de Conservação (UCs) federais do Brasil.

**Dados disponíveis:**
- Limites geográficos de UCs (shapefiles)
- Categoria de UC (Proteção Integral vs Uso Sustentável)
- Área, bioma, estado
- Planos de manejo
- Dados de biodiversidade (quando disponíveis)

**Acesso.**
- Portal web: https://www.gov.br/icmbio/
- Download: Shapefiles via portal de dados abertos
- API: Não documentada

**Relevância para Tocantins.** Média. Tocantins tem poucas UCs federais (a maioria é estadual ou municipal). Dados de UCs são importantes para análises de conservação e planejamento territorial.

#### 2.5.2 FUNAI - Terras Indígenas

**Descrição.** A Fundação Nacional dos Povos Indígenas (FUNAI) gerencia as Terras Indígenas (TIs) do Brasil.

**Dados disponíveis:**
- Limites geográficos de TIs (shapefiles)
- Etnia, população indígena
- Situação fundiária (regularizada, em estudo, etc.)

**Acesso.**
- Portal web: https://www.gov.br/funai/
- Download: Shapefiles via portal de dados abertos

**Relevância para Tocantins.** Média. Tocantins tem várias TIs, especialmente na região do Bico do Papagaio (norte do estado). TIs são áreas de conservação de facto (baixo desmatamento) e importantes para análises territoriais.

### 2.6 Resíduos Sólidos e Saneamento

#### 2.6.1 SNIS - Sistema Nacional de Informações sobre Saneamento

**Descrição.** O SNIS é o sistema oficial de coleta e divulgação de informações sobre saneamento básico no Brasil, operado pelo Ministério das Cidades.

**Cobertura.** Todos os municípios brasileiros (adesão voluntária, mas alta taxa de resposta).

**Período.** Dados anuais desde 1995.

**Dados disponíveis (100+ indicadores):**
- **Água:** Cobertura, perdas, tarifa, qualidade
- **Esgoto:** Cobertura, tratamento, tarifa
- **Resíduos Sólidos:** Coleta, destinação, reciclagem, custos
- **Drenagem Urbana:** Infraestrutura, investimentos

**Acesso.**
- Portal web: http://www.snis.gov.br/
- Download: Planilhas Excel com dados agregados
- Série histórica: Dados desde 1995

**Limitações.**
- Dados auto-declarados por prestadores de serviço (possíveis inconsistências)
- Atraso de ~2 anos (dados de 2023 disponíveis em 2025)
- Foco em área urbana (área rural sub-representada)

**Relevância para Tocantins.** Alta. Saneamento é crítico para saúde pública e qualidade ambiental. Dados do SNIS permitem avaliar déficit de saneamento, priorizar investimentos e monitorar progresso.

### 2.7 Emissões de Gases de Efeito Estufa

#### 2.7.1 SEEG - Sistema de Estimativas de Emissões de Gases de Efeito Estufa

**Descrição.** O SEEG é uma iniciativa do Observatório do Clima que estima emissões de GEE do Brasil por setor, estado e município.

**Cobertura.** Todo o Brasil, todos os setores (energia, agropecuária, mudança de uso do solo, processos industriais, resíduos).

**Período.** Dados anuais desde 1970.

**Metodologia.** Baseada em diretrizes do IPCC, usando dados oficiais (IBGE, INPE, ANP, etc.).

**Dados disponíveis:**
- Emissões totais de CO2, CH4, N2O por setor, estado, município
- Emissões per capita
- Intensidade de carbono (emissões / PIB)
- Remoções (sequestro de carbono por florestas)

**Acesso.**
- Portal web: https://seeg.eco.br/
- Plataforma online: Visualização e download de dados
- API: Dados podem ser baixados via plataforma

**Relevância para Tocantins.** Alta. Mudanças climáticas são uma ameaça crescente. Dados de emissões permitem identificar setores prioritários para mitigação (ex: desmatamento, agropecuária) e monitorar progresso em metas climáticas.

### 2.8 Licenciamento e Fiscalização Ambiental

#### 2.8.1 IBAMA - Sistema de Licenciamento Ambiental Federal

**Descrição.** O IBAMA gerencia o licenciamento ambiental de empreendimentos de grande porte (rodovias federais, hidrelétricas, mineração, etc.).

**Dados disponíveis:**
- Processos de licenciamento (número, empreendedor, localização)
- Tipo de licença (prévia, instalação, operação)
- Condicionantes ambientais
- Estudos ambientais (EIA/RIMA)

**Acesso.**
- Portal web: https://www.gov.br/ibama/
- Dados não são facilmente acessíveis para download automatizado (requer consultas individuais)

**Limitações.**
- Dados fragmentados (não há API centralizada)
- Foco em empreendimentos federais (licenciamento estadual e municipal não incluído)

**Relevância para Tocantins.** Média. Licenciamento ambiental é crítico para garantir que empreendimentos sejam sustentáveis. Dados permitem monitorar cumprimento de condicionantes e identificar impactos ambientais.

#### 2.8.2 IBAMA - Autuações Ambientais

**Descrição.** O IBAMA divulga dados de autuações (multas) por infrações ambientais.

**Dados disponíveis:**
- Número de autuações por município, estado, ano
- Tipo de infração (desmatamento, queimada, pesca ilegal, etc.)
- Valor da multa
- Situação do processo (pago, embargado, cancelado)

**Acesso.**
- Portal de dados abertos: https://dados.gov.br/
- Download: Planilhas CSV

**Relevância para Tocantins.** Média. Dados de autuações indicam pressão de fiscalização e padrões de infrações ambientais. Podem ser usados para priorizar ações de fiscalização e avaliar eficácia de políticas.

### 2.9 Síntese das Fontes de Dados

A tabela abaixo sintetiza as 10 principais fontes de dados ambientais identificadas, organizadas por área temática, cobertura temporal e relevância para o Tocantins.

| Fonte | Área Temática | Cobertura Temporal | Atualização | Relevância TO |
|-------|---------------|-------------------|-------------|---------------|
| **INPE BDQueimadas** | Queimadas | 1998-presente | 3 horas | Crítica |
| **INPE CPTEC** | Qualidade do Ar | 2010-presente | Diária | Alta |
| **INMET BDMEP** | Meteorologia | 1961-presente | Diária | Essencial |
| **ANA HIDROWEB** | Recursos Hídricos | 1930s-presente | Mensal | Crítica |
| **ANA RNQA** | Qualidade da Água | 2013-presente | Trimestral | Alta |
| **MapBiomas** | Uso do Solo | 1985-presente | Anual | Crítica |
| **INPE PRODES** | Desmatamento | 1988-presente (AM), 2000-presente (CE) | Anual | Alta |
| **INPE DETER** | Alertas Desmatamento | 2004-presente | Diária | Alta |
| **SEEG** | Emissões GEE | 1970-presente | Anual | Alta |
| **SNIS** | Saneamento | 1995-presente | Anual | Alta |

---

## 3. Dados Prioritários por Área Temática

Esta seção organiza os dados ambientais em **8 áreas temáticas** e classifica cada dataset em **3 níveis de prioridade** (Essencial, Alta, Média) baseado em:
- **Relevância para gestão pública** no Tocantins
- **Disponibilidade e qualidade** dos dados
- **Facilidade de coleta e processamento**
- **Impacto potencial** em casos de uso transformadores

### 3.1 Queimadas e Qualidade do Ar

#### Prioridade 1 - Essencial

**Focos de calor diários (INPE BDQueimadas)**
- **Justificativa:** Queimadas são um dos principais desafios ambientais do Tocantins. Monitoramento em tempo real permite resposta rápida.
- **Frequência:** Diária (atualização a cada 3 horas)
- **Volume:** ~5.000-10.000 focos/ano no Tocantins
- **Complexidade:** Baixa (dados tabulares simples)

#### Prioridade 2 - Alta

**Concentrações de PM2.5 e PM10 (INPE CPTEC)**
- **Justificativa:** Qualidade do ar deteriora durante queimadas, impactando saúde pública.
- **Frequência:** Diária (previsões)
- **Volume:** ~50 KB/dia (dados agregados por município)
- **Complexidade:** Média (dados modelados, requer interpolação espacial)

**Risco de fogo (INPE BDQueimadas)**
- **Justificativa:** Permite prever áreas de alto risco e priorizar ações preventivas.
- **Frequência:** Diária
- **Volume:** Incluído em focos de calor
- **Complexidade:** Baixa

#### Prioridade 3 - Média

**Emissões de CO (INPE CPTEC)**
- **Justificativa:** Indicador complementar de qualidade do ar.
- **Frequência:** Diária
- **Volume:** ~50 KB/dia
- **Complexidade:** Média

### 3.2 Clima e Meteorologia

#### Prioridade 1 - Essencial

**Precipitação diária (INMET BDMEP)**
- **Justificativa:** Fundamental para agricultura, recursos hídricos, risco de queimadas.
- **Frequência:** Diária
- **Volume:** ~10-15 estações × 365 dias × 10 anos = ~50.000 registros
- **Complexidade:** Baixa

**Temperatura diária (INMET BDMEP)**
- **Justificativa:** Crítica para agricultura, saúde (ondas de calor), mudanças climáticas.
- **Frequência:** Diária
- **Volume:** ~50.000 registros (10 anos)
- **Complexidade:** Baixa

#### Prioridade 2 - Alta

**Umidade relativa (INMET BDMEP)**
- **Justificativa:** Importante para risco de queimadas e conforto térmico.
- **Frequência:** Diária
- **Volume:** ~50.000 registros
- **Complexidade:** Baixa

**Velocidade do vento (INMET BDMEP)**
- **Justificativa:** Relevante para dispersão de queimadas e energia eólica.
- **Frequência:** Diária
- **Volume:** ~50.000 registros
- **Complexidade:** Baixa

#### Prioridade 3 - Média

**Evaporação (INMET BDMEP)**
- **Justificativa:** Útil para balanço hídrico e agricultura irrigada.
- **Frequência:** Diária
- **Volume:** ~50.000 registros
- **Complexidade:** Baixa

**Insolação (INMET BDMEP)**
- **Justificativa:** Relevante para energia solar e agricultura.
- **Frequência:** Diária
- **Volume:** ~50.000 registros
- **Complexidade:** Baixa

### 3.3 Recursos Hídricos

#### Prioridade 1 - Essencial

**Vazão diária de rios (ANA HIDROWEB)**
- **Justificativa:** Crítica para gestão de conflitos pelo uso da água, abastecimento urbano, irrigação.
- **Frequência:** Diária
- **Volume:** ~20-30 estações × 365 dias × 10 anos = ~100.000 registros
- **Complexidade:** Média (requer interpolação espacial para municípios sem estação)

**Precipitação diária (ANA HIDROWEB)**
- **Justificativa:** Complementa dados do INMET, maior cobertura espacial.
- **Frequência:** Diária
- **Volume:** ~50-100 estações × 365 dias × 10 anos = ~300.000 registros
- **Complexidade:** Baixa

#### Prioridade 2 - Alta

**Qualidade da água - parâmetros básicos (ANA RNQA)**
- **Parâmetros:** pH, OD, DBO, Turbidez, Coliformes
- **Justificativa:** Essenciais para abastecimento urbano e saúde pública.
- **Frequência:** Trimestral
- **Volume:** ~10 pontos × 4 coletas/ano × 10 anos × 5 parâmetros = ~2.000 registros
- **Complexidade:** Média (dados laboratoriais, requer validação)

**Disponibilidade hídrica por bacia (ANA)**
- **Justificativa:** Fundamental para planejamento de outorgas e gestão de conflitos.
- **Frequência:** Anual
- **Volume:** ~5-10 bacias × 10 anos = ~100 registros
- **Complexidade:** Alta (requer modelagem hidrológica)

#### Prioridade 3 - Média

**Qualidade da água - metais pesados (ANA RNQA)**
- **Justificativa:** Relevante para áreas com mineração.
- **Frequência:** Trimestral
- **Volume:** ~2.000 registros
- **Complexidade:** Média

**Sedimentos (ANA HIDROWEB)**
- **Justificativa:** Importante para reservatórios e navegação.
- **Frequência:** Mensal
- **Volume:** ~10.000 registros
- **Complexidade:** Média

### 3.4 Desmatamento e Uso do Solo

#### Prioridade 1 - Essencial

**Uso do solo anual (MapBiomas)**
- **Justificativa:** Fonte mais completa e consistente de dados de uso do solo (1985-presente).
- **Frequência:** Anual
- **Volume:** 140 municípios × 40 anos × 27 classes = ~150.000 registros (estatísticas agregadas)
- **Complexidade:** Média (dados raster, requer processamento geoespacial)

**Desmatamento anual (INPE PRODES)**
- **Justificativa:** Dados oficiais de desmatamento, usados para fiscalização e políticas públicas.
- **Frequência:** Anual
- **Volume:** ~1.000-5.000 polígonos/ano no Tocantins × 10 anos = ~30.000 polígonos
- **Complexidade:** Alta (dados geoespaciais, requer PostGIS)

#### Prioridade 2 - Alta

**Alertas de desmatamento (INPE DETER)**
- **Justificativa:** Permite resposta rápida a desmatamento ilegal.
- **Frequência:** Diária
- **Volume:** ~5.000-10.000 alertas/ano × 10 anos = ~75.000 alertas
- **Complexidade:** Alta (dados geoespaciais)

**Transições de uso do solo (MapBiomas)**
- **Justificativa:** Identifica padrões de mudança (ex: Floresta → Pastagem → Agricultura).
- **Frequência:** Anual
- **Volume:** ~200.000 transições (10 anos)
- **Complexidade:** Alta (requer análise de séries temporais)

#### Prioridade 3 - Média

**Regeneração de vegetação (MapBiomas)**
- **Justificativa:** Monitora recuperação de áreas degradadas.
- **Frequência:** Anual
- **Volume:** Incluído em uso do solo
- **Complexidade:** Média

### 3.5 Biodiversidade e Áreas Protegidas

#### Prioridade 1 - Essencial

**Limites de Unidades de Conservação (ICMBio)**
- **Justificativa:** Essencial para análises de conservação e planejamento territorial.
- **Frequência:** Anual (atualizações)
- **Volume:** ~10-20 UCs no Tocantins
- **Complexidade:** Baixa (dados geoespaciais simples)

**Limites de Terras Indígenas (FUNAI)**
- **Justificativa:** TIs são áreas de conservação de facto.
- **Frequência:** Anual
- **Volume:** ~10-15 TIs no Tocantins
- **Complexidade:** Baixa

#### Prioridade 2 - Alta

**Espécies ameaçadas (ICMBio/MMA)**
- **Justificativa:** Importante para licenciamento ambiental e conservação.
- **Frequência:** Irregular (atualizações da Lista Vermelha)
- **Volume:** ~100-200 espécies com ocorrência no Tocantins
- **Complexidade:** Média (dados tabulares + distribuição geográfica)

#### Prioridade 3 - Média

**Corredores ecológicos**
- **Justificativa:** Relevante para planejamento de conservação.
- **Frequência:** Irregular
- **Volume:** ~5-10 corredores
- **Complexidade:** Alta (requer modelagem de conectividade)

### 3.6 Resíduos Sólidos e Saneamento

#### Prioridade 1 - Essencial

**Cobertura de coleta de resíduos (SNIS)**
- **Justificativa:** Indicador básico de saneamento.
- **Frequência:** Anual
- **Volume:** 140 municípios × 10 anos = 1.400 registros
- **Complexidade:** Baixa

**Destinação de resíduos (SNIS)**
- **Justificativa:** Identifica municípios com lixões (irregular) vs aterros sanitários.
- **Frequência:** Anual
- **Volume:** 1.400 registros
- **Complexidade:** Baixa

#### Prioridade 2 - Alta

**Cobertura de abastecimento de água (SNIS)**
- **Justificativa:** Fundamental para saúde pública.
- **Frequência:** Anual
- **Volume:** 1.400 registros
- **Complexidade:** Baixa

**Cobertura de esgotamento sanitário (SNIS)**
- **Justificativa:** Crítico para qualidade ambiental e saúde.
- **Frequência:** Anual
- **Volume:** 1.400 registros
- **Complexidade:** Baixa

#### Prioridade 3 - Média

**Taxa de reciclagem (SNIS)**
- **Justificativa:** Indicador de sustentabilidade.
- **Frequência:** Anual
- **Volume:** 1.400 registros
- **Complexidade:** Baixa

**Custos de saneamento (SNIS)**
- **Justificativa:** Útil para planejamento orçamentário.
- **Frequência:** Anual
- **Volume:** 1.400 registros
- **Complexidade:** Baixa

### 3.7 Emissões de Gases de Efeito Estufa

#### Prioridade 1 - Essencial

**Emissões totais por setor (SEEG)**
- **Setores:** Energia, Agropecuária, Mudança de Uso do Solo, Processos Industriais, Resíduos
- **Justificativa:** Identifica setores prioritários para mitigação.
- **Frequência:** Anual
- **Volume:** 140 municípios × 5 setores × 10 anos = 7.000 registros
- **Complexidade:** Média

#### Prioridade 2 - Alta

**Emissões per capita (SEEG)**
- **Justificativa:** Permite comparações entre municípios.
- **Frequência:** Anual
- **Volume:** 1.400 registros
- **Complexidade:** Baixa

**Remoções por florestas (SEEG)**
- **Justificativa:** Quantifica sequestro de carbono.
- **Frequência:** Anual
- **Volume:** 1.400 registros
- **Complexidade:** Média

#### Prioridade 3 - Média

**Intensidade de carbono (SEEG)**
- **Justificativa:** Emissões / PIB, indicador de eficiência.
- **Frequência:** Anual
- **Volume:** 1.400 registros
- **Complexidade:** Baixa

### 3.8 Licenciamento e Fiscalização

#### Prioridade 2 - Alta

**Autuações ambientais (IBAMA)**
- **Justificativa:** Indica pressão de fiscalização e padrões de infrações.
- **Frequência:** Anual
- **Volume:** ~1.000-2.000 autuações/ano no Tocantins × 10 anos = ~15.000 registros
- **Complexidade:** Baixa

#### Prioridade 3 - Média

**Processos de licenciamento (IBAMA)**
- **Justificativa:** Monitora empreendimentos de grande porte.
- **Frequência:** Contínua
- **Volume:** ~50-100 processos ativos
- **Complexidade:** Alta (dados fragmentados)

### 3.9 Síntese de Prioridades

A tabela abaixo sintetiza os datasets prioritários por área temática.

| Área Temática | Essencial (P1) | Alta (P2) | Média (P3) | Total |
|---------------|----------------|-----------|------------|-------|
| **Queimadas e Qualidade do Ar** | 1 | 2 | 1 | 4 |
| **Clima e Meteorologia** | 2 | 2 | 2 | 6 |
| **Recursos Hídricos** | 2 | 2 | 2 | 6 |
| **Desmatamento e Uso do Solo** | 2 | 2 | 1 | 5 |
| **Biodiversidade e Áreas Protegidas** | 2 | 1 | 1 | 4 |
| **Resíduos e Saneamento** | 2 | 2 | 2 | 6 |
| **Emissões GEE** | 1 | 2 | 1 | 4 |
| **Licenciamento e Fiscalização** | 0 | 1 | 1 | 2 |
| **TOTAL** | **12** | **14** | **11** | **37** |

**Recomendação de implementação:**
- **Fase 1 (Semanas 1-4):** Implementar 12 datasets essenciais (P1)
- **Fase 2 (Semanas 5-8):** Adicionar 14 datasets de alta prioridade (P2)
- **Fase 3 (Semanas 9-12):** Complementar com 11 datasets de média prioridade (P3)

---

## 4. Estrutura de Dados Proposta (PostgreSQL)

Esta seção propõe uma estrutura de banco de dados PostgreSQL para armazenar dados ambientais do Tocantins. A estrutura é otimizada para consultas analíticas, integração com outras dimensões (econômica, social, territorial) e escalabilidade.

### 4.1 Visão Geral da Arquitetura

**Banco de dados:** PostgreSQL 15+  
**Extensões necessárias:**
- `postgis` (dados geoespaciais)
- `uuid-ossp` (geração de UUIDs)
- `pg_trgm` (busca textual)

**Organização:** 8 tabelas principais + 4 views + 2 funções auxiliares

**Volume estimado:** ~2 GB (dados do Tocantins, 10 anos de histórico)

### 4.2 Tabelas Principais

#### 4.2.1 Tabela: `focos_calor`

Armazena focos de calor detectados por satélites (INPE BDQueimadas).

```sql
CREATE TABLE focos_calor (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge INTEGER NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    satelite VARCHAR(50) NOT NULL,
    bioma VARCHAR(50),
    risco_fogo VARCHAR(20), -- 'Baixo', 'Médio', 'Alto', 'Crítico'
    dias_sem_chuva INTEGER,
    precipitacao_30d DOUBLE PRECISION, -- mm
    frp DOUBLE PRECISION, -- Fire Radiative Power (MW)
    geom GEOMETRY(Point, 4326),
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (codigo_ibge) REFERENCES entidades_territoriais(codigo_ibge)
);

CREATE INDEX idx_focos_calor_codigo_ibge ON focos_calor(codigo_ibge);
CREATE INDEX idx_focos_calor_data_hora ON focos_calor(data_hora);
CREATE INDEX idx_focos_calor_geom ON focos_calor USING GIST(geom);
```

**Volume estimado:** 5.000-10.000 focos/ano × 10 anos = 50.000-100.000 registros (~10 MB)

#### 4.2.2 Tabela: `dados_meteorologicos`

Armazena dados meteorológicos diários (INMET BDMEP).

```sql
CREATE TABLE dados_meteorologicos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge INTEGER NOT NULL,
    estacao_id VARCHAR(20) NOT NULL,
    data DATE NOT NULL,
    temperatura_max DOUBLE PRECISION, -- °C
    temperatura_min DOUBLE PRECISION, -- °C
    temperatura_media DOUBLE PRECISION, -- °C
    precipitacao DOUBLE PRECISION, -- mm
    umidade_relativa_media DOUBLE PRECISION, -- %
    velocidade_vento_media DOUBLE PRECISION, -- m/s
    pressao_atmosferica DOUBLE PRECISION, -- hPa
    insolacao DOUBLE PRECISION, -- horas
    evaporacao DOUBLE PRECISION, -- mm
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (codigo_ibge) REFERENCES entidades_territoriais(codigo_ibge),
    UNIQUE(estacao_id, data)
);

CREATE INDEX idx_meteo_codigo_ibge ON dados_meteorologicos(codigo_ibge);
CREATE INDEX idx_meteo_data ON dados_meteorologicos(data);
```

**Volume estimado:** 15 estações × 365 dias × 10 anos = 54.750 registros (~5 MB)

#### 4.2.3 Tabela: `dados_hidrologicos`

Armazena dados hidrológicos diários (ANA HIDROWEB).

```sql
CREATE TABLE dados_hidrologicos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge INTEGER NOT NULL,
    estacao_id VARCHAR(20) NOT NULL,
    data DATE NOT NULL,
    vazao DOUBLE PRECISION, -- m³/s
    cota DOUBLE PRECISION, -- cm
    precipitacao DOUBLE PRECISION, -- mm
    tipo_estacao VARCHAR(20), -- 'Fluviométrica', 'Pluviométrica'
    rio VARCHAR(100),
    bacia VARCHAR(100),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    geom GEOMETRY(Point, 4326),
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (codigo_ibge) REFERENCES entidades_territoriais(codigo_ibge),
    UNIQUE(estacao_id, data)
);

CREATE INDEX idx_hidro_codigo_ibge ON dados_hidrologicos(codigo_ibge);
CREATE INDEX idx_hidro_data ON dados_hidrologicos(data);
CREATE INDEX idx_hidro_geom ON dados_hidrologicos USING GIST(geom);
```

**Volume estimado:** 50 estações × 365 dias × 10 anos = 182.500 registros (~20 MB)

#### 4.2.4 Tabela: `qualidade_agua`

Armazena dados de qualidade da água (ANA RNQA).

```sql
CREATE TABLE qualidade_agua (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge INTEGER NOT NULL,
    ponto_id VARCHAR(20) NOT NULL,
    data_coleta DATE NOT NULL,
    ph DOUBLE PRECISION,
    oxigenio_dissolvido DOUBLE PRECISION, -- mg/L
    dbo DOUBLE PRECISION, -- mg/L
    turbidez DOUBLE PRECISION, -- NTU
    coliformes_termotolerant DOUBLE PRECISION, -- NMP/100mL
    nitrogenio_total DOUBLE PRECISION, -- mg/L
    fosforo_total DOUBLE PRECISION, -- mg/L
    temperatura_agua DOUBLE PRECISION, -- °C
    rio VARCHAR(100),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    geom GEOMETRY(Point, 4326),
    data_insercao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (codigo_ibge) REFERENCES entidades_territoriais(codigo_ibge),
    UNIQUE(ponto_id, data_coleta)
);

CREATE INDEX idx_qualidade_agua_codigo_ibge ON qualidade_agua(codigo_ibge);
CREATE INDEX idx_qualidade_agua_data ON qualidade_agua(data_coleta);
CREATE INDEX idx_qualidade_agua_geom ON qualidade_agua USING GIST(geom);
```

**Volume estimado:** 10 pontos × 4 coletas/ano × 10 anos = 400 registros (~100 KB)

#### 4.2.5 Tabela: `uso_solo_anual`

Armazena estatísticas de uso do solo por município e ano (MapBiomas).

```sql
CREATE TABLE uso_solo_anual (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge INTEGER NOT NULL,
    ano INTEGER NOT NULL,
    classe_uso VARCHAR(100) NOT NULL,
    area_ha DOUBLE PRECISION NOT NULL,
    percentual_municipio DOUBLE PRECISION,
    bioma VARCHAR(50),
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (codigo_ibge) REFERENCES entidades_territoriais(codigo_ibge),
    UNIQUE(codigo_ibge, ano, classe_uso)
);

CREATE INDEX idx_uso_solo_codigo_ibge ON uso_solo_anual(codigo_ibge);
CREATE INDEX idx_uso_solo_ano ON uso_solo_anual(ano);
CREATE INDEX idx_uso_solo_classe ON uso_solo_anual(classe_uso);
```

**Volume estimado:** 140 municípios × 40 anos × 27 classes = 151.200 registros (~15 MB)

#### 4.2.6 Tabela: `desmatamento_prodes`

Armazena polígonos de desmatamento (INPE PRODES).

```sql
CREATE TABLE desmatamento_prodes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge INTEGER NOT NULL,
    ano INTEGER NOT NULL,
    area_ha DOUBLE PRECISION NOT NULL,
    bioma VARCHAR(50) NOT NULL, -- 'Amazônia' ou 'Cerrado'
    classe VARCHAR(50), -- 'Desmatamento', 'Degradação', 'Floresta'
    geom GEOMETRY(MultiPolygon, 4326),
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (codigo_ibge) REFERENCES entidades_territoriais(codigo_ibge)
);

CREATE INDEX idx_prodes_codigo_ibge ON desmatamento_prodes(codigo_ibge);
CREATE INDEX idx_prodes_ano ON desmatamento_prodes(ano);
CREATE INDEX idx_prodes_geom ON desmatamento_prodes USING GIST(geom);
```

**Volume estimado:** 3.000 polígonos/ano × 10 anos = 30.000 registros (~200 MB com geometrias)

#### 4.2.7 Tabela: `alertas_deter`

Armazena alertas de desmatamento em tempo real (INPE DETER).

```sql
CREATE TABLE alertas_deter (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge INTEGER NOT NULL,
    data_deteccao DATE NOT NULL,
    area_ha DOUBLE PRECISION NOT NULL,
    tipo_alerta VARCHAR(50), -- 'Desmatamento', 'Degradação', 'Corte Seletivo'
    bioma VARCHAR(50),
    geom GEOMETRY(MultiPolygon, 4326),
    validado BOOLEAN DEFAULT FALSE,
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (codigo_ibge) REFERENCES entidades_territoriais(codigo_ibge)
);

CREATE INDEX idx_deter_codigo_ibge ON alertas_deter(codigo_ibge);
CREATE INDEX idx_deter_data ON alertas_deter(data_deteccao);
CREATE INDEX idx_deter_geom ON alertas_deter USING GIST(geom);
```

**Volume estimado:** 7.500 alertas/ano × 10 anos = 75.000 registros (~500 MB com geometrias)

#### 4.2.8 Tabela: `dados_saneamento`

Armazena dados de saneamento básico (SNIS).

```sql
CREATE TABLE dados_saneamento (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge INTEGER NOT NULL,
    ano INTEGER NOT NULL,
    -- Água
    cobertura_agua_percentual DOUBLE PRECISION,
    perdas_agua_percentual DOUBLE PRECISION,
    tarifa_media_agua DOUBLE PRECISION, -- R$/m³
    -- Esgoto
    cobertura_esgoto_percentual DOUBLE PRECISION,
    tratamento_esgoto_percentual DOUBLE PRECISION,
    tarifa_media_esgoto DOUBLE PRECISION, -- R$/m³
    -- Resíduos Sólidos
    cobertura_coleta_residuos_percentual DOUBLE PRECISION,
    destinacao_adequada BOOLEAN, -- Aterro sanitário = TRUE, Lixão = FALSE
    taxa_reciclagem_percentual DOUBLE PRECISION,
    custo_coleta_per_capita DOUBLE PRECISION, -- R$/hab/ano
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (codigo_ibge) REFERENCES entidades_territoriais(codigo_ibge),
    UNIQUE(codigo_ibge, ano)
);

CREATE INDEX idx_saneamento_codigo_ibge ON dados_saneamento(codigo_ibge);
CREATE INDEX idx_saneamento_ano ON dados_saneamento(ano);
```

**Volume estimado:** 140 municípios × 10 anos = 1.400 registros (~200 KB)

#### 4.2.9 Tabela: `emissoes_gee`

Armazena emissões de gases de efeito estufa (SEEG).

```sql
CREATE TABLE emissoes_gee (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge INTEGER NOT NULL,
    ano INTEGER NOT NULL,
    setor VARCHAR(100) NOT NULL, -- 'Energia', 'Agropecuária', 'Mudança Uso Solo', etc.
    emissoes_co2_ton DOUBLE PRECISION,
    emissoes_ch4_ton DOUBLE PRECISION,
    emissoes_n2o_ton DOUBLE PRECISION,
    emissoes_co2eq_ton DOUBLE PRECISION, -- CO2 equivalente
    emissoes_per_capita_ton DOUBLE PRECISION,
    remocoes_co2_ton DOUBLE PRECISION, -- Sequestro por florestas (negativo)
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (codigo_ibge) REFERENCES entidades_territoriais(codigo_ibge),
    UNIQUE(codigo_ibge, ano, setor)
);

CREATE INDEX idx_emissoes_codigo_ibge ON emissoes_gee(codigo_ibge);
CREATE INDEX idx_emissoes_ano ON emissoes_gee(ano);
CREATE INDEX idx_emissoes_setor ON emissoes_gee(setor);
```

**Volume estimado:** 140 municípios × 10 anos × 5 setores = 7.000 registros (~1 MB)

### 4.3 Views Úteis

#### 4.3.1 View: `municipios_resumo_ambiental`

Resumo ambiental de cada município (dados mais recentes).

```sql
CREATE VIEW municipios_resumo_ambiental AS
SELECT 
    e.codigo_ibge,
    e.nome_municipio,
    e.uf,
    -- Queimadas (último ano)
    (SELECT COUNT(*) FROM focos_calor f 
     WHERE f.codigo_ibge = e.codigo_ibge 
     AND EXTRACT(YEAR FROM f.data_hora) = EXTRACT(YEAR FROM CURRENT_DATE) - 1
    ) AS focos_calor_ano_anterior,
    -- Desmatamento (último ano)
    (SELECT SUM(area_ha) FROM desmatamento_prodes d
     WHERE d.codigo_ibge = e.codigo_ibge
     AND d.ano = EXTRACT(YEAR FROM CURRENT_DATE) - 1
    ) AS desmatamento_ha_ano_anterior,
    -- Uso do Solo (último ano, % vegetação nativa)
    (SELECT SUM(percentual_municipio) FROM uso_solo_anual u
     WHERE u.codigo_ibge = e.codigo_ibge
     AND u.ano = EXTRACT(YEAR FROM CURRENT_DATE) - 1
     AND u.classe_uso IN ('Floresta', 'Savana', 'Campo', 'Pastagem Natural')
    ) AS vegetacao_nativa_percentual,
    -- Saneamento (último ano)
    (SELECT cobertura_agua_percentual FROM dados_saneamento s
     WHERE s.codigo_ibge = e.codigo_ibge
     ORDER BY s.ano DESC LIMIT 1
    ) AS cobertura_agua_percentual,
    (SELECT cobertura_esgoto_percentual FROM dados_saneamento s
     WHERE s.codigo_ibge = e.codigo_ibge
     ORDER BY s.ano DESC LIMIT 1
    ) AS cobertura_esgoto_percentual,
    -- Emissões GEE (último ano, total)
    (SELECT SUM(emissoes_co2eq_ton) FROM emissoes_gee g
     WHERE g.codigo_ibge = e.codigo_ibge
     AND g.ano = EXTRACT(YEAR FROM CURRENT_DATE) - 1
    ) AS emissoes_totais_co2eq_ton
FROM entidades_territoriais e
WHERE e.uf = 'TO';
```

#### 4.3.2 View: `evolucao_desmatamento`

Evolução temporal de desmatamento por município.

```sql
CREATE VIEW evolucao_desmatamento AS
SELECT 
    codigo_ibge,
    ano,
    SUM(area_ha) AS desmatamento_ha,
    SUM(SUM(area_ha)) OVER (PARTITION BY codigo_ibge ORDER BY ano) AS desmatamento_acumulado_ha
FROM desmatamento_prodes
GROUP BY codigo_ibge, ano
ORDER BY codigo_ibge, ano;
```

#### 4.3.3 View: `qualidade_ar_municipios`

Estimativa de qualidade do ar por município (baseada em focos de calor).

```sql
CREATE VIEW qualidade_ar_municipios AS
SELECT 
    codigo_ibge,
    DATE(data_hora) AS data,
    COUNT(*) AS focos_dia,
    CASE 
        WHEN COUNT(*) = 0 THEN 'Boa'
        WHEN COUNT(*) BETWEEN 1 AND 5 THEN 'Moderada'
        WHEN COUNT(*) BETWEEN 6 AND 15 THEN 'Ruim'
        WHEN COUNT(*) > 15 THEN 'Muito Ruim'
    END AS qualidade_ar_estimada
FROM focos_calor
GROUP BY codigo_ibge, DATE(data_hora)
ORDER BY codigo_ibge, data;
```

#### 4.3.4 View: `municipios_vulnerabilidade_climatica`

Vulnerabilidade climática por município (baseada em múltiplos indicadores).

```sql
CREATE VIEW municipios_vulnerabilidade_climatica AS
SELECT 
    e.codigo_ibge,
    e.nome_municipio,
    -- Exposição a queimadas (média de focos/ano)
    (SELECT AVG(focos_ano) FROM (
        SELECT COUNT(*) AS focos_ano 
        FROM focos_calor f 
        WHERE f.codigo_ibge = e.codigo_ibge 
        GROUP BY EXTRACT(YEAR FROM f.data_hora)
    ) sub) AS media_focos_ano,
    -- Taxa de desmatamento (média últimos 5 anos)
    (SELECT AVG(area_ha) FROM desmatamento_prodes d
     WHERE d.codigo_ibge = e.codigo_ibge
     AND d.ano >= EXTRACT(YEAR FROM CURRENT_DATE) - 5
    ) AS media_desmatamento_ha_5anos,
    -- Emissões per capita (último ano)
    (SELECT emissoes_per_capita_ton FROM emissoes_gee g
     WHERE g.codigo_ibge = e.codigo_ibge
     ORDER BY g.ano DESC LIMIT 1
    ) AS emissoes_per_capita_ton,
    -- Cobertura de saneamento (último ano)
    (SELECT (cobertura_agua_percentual + cobertura_esgoto_percentual) / 2 
     FROM dados_saneamento s
     WHERE s.codigo_ibge = e.codigo_ibge
     ORDER BY s.ano DESC LIMIT 1
    ) AS saneamento_medio_percentual
FROM entidades_territoriais e
WHERE e.uf = 'TO';
```

### 4.4 Funções Auxiliares

#### 4.4.1 Função: `calcular_taxa_desmatamento()`

Calcula taxa anual de desmatamento para um município.

```sql
CREATE OR REPLACE FUNCTION calcular_taxa_desmatamento(
    p_codigo_ibge INTEGER,
    p_ano_inicio INTEGER,
    p_ano_fim INTEGER
) RETURNS DOUBLE PRECISION AS $$
DECLARE
    desmatamento_inicio DOUBLE PRECISION;
    desmatamento_fim DOUBLE PRECISION;
    anos INTEGER;
    taxa DOUBLE PRECISION;
BEGIN
    -- Desmatamento acumulado no ano inicial
    SELECT SUM(area_ha) INTO desmatamento_inicio
    FROM desmatamento_prodes
    WHERE codigo_ibge = p_codigo_ibge
    AND ano <= p_ano_inicio;
    
    -- Desmatamento acumulado no ano final
    SELECT SUM(area_ha) INTO desmatamento_fim
    FROM desmatamento_prodes
    WHERE codigo_ibge = p_codigo_ibge
    AND ano <= p_ano_fim;
    
    anos := p_ano_fim - p_ano_inicio;
    
    IF desmatamento_inicio > 0 AND anos > 0 THEN
        taxa := ((desmatamento_fim / desmatamento_inicio) ^ (1.0 / anos) - 1) * 100;
    ELSE
        taxa := 0;
    END IF;
    
    RETURN taxa;
END;
$$ LANGUAGE plpgsql;
```

#### 4.4.2 Função: `identificar_hotspots_queimadas()`

Identifica municípios com focos de calor acima da média (hotspots).

```sql
CREATE OR REPLACE FUNCTION identificar_hotspots_queimadas(
    p_ano INTEGER,
    p_limiar_percentil DOUBLE PRECISION DEFAULT 75.0
) RETURNS TABLE(
    codigo_ibge INTEGER,
    nome_municipio VARCHAR,
    focos_ano INTEGER,
    percentil DOUBLE PRECISION
) AS $$
BEGIN
    RETURN QUERY
    WITH focos_por_municipio AS (
        SELECT 
            f.codigo_ibge,
            COUNT(*) AS focos
        FROM focos_calor f
        WHERE EXTRACT(YEAR FROM f.data_hora) = p_ano
        GROUP BY f.codigo_ibge
    ),
    percentis AS (
        SELECT 
            PERCENTILE_CONT(p_limiar_percentil / 100.0) WITHIN GROUP (ORDER BY focos) AS limiar
        FROM focos_por_municipio
    )
    SELECT 
        e.codigo_ibge,
        e.nome_municipio,
        f.focos::INTEGER,
        (PERCENT_RANK() OVER (ORDER BY f.focos) * 100)::DOUBLE PRECISION AS percentil
    FROM focos_por_municipio f
    JOIN entidades_territoriais e ON f.codigo_ibge = e.codigo_ibge
    CROSS JOIN percentis p
    WHERE f.focos >= p.limiar
    ORDER BY f.focos DESC;
END;
$$ LANGUAGE plpgsql;
```

### 4.5 Estimativa de Volume de Dados

| Tabela | Registros (10 anos) | Tamanho Estimado |
|--------|---------------------|------------------|
| `focos_calor` | 75.000 | 10 MB |
| `dados_meteorologicos` | 54.750 | 5 MB |
| `dados_hidrologicos` | 182.500 | 20 MB |
| `qualidade_agua` | 400 | 100 KB |
| `uso_solo_anual` | 151.200 | 15 MB |
| `desmatamento_prodes` | 30.000 | 200 MB |
| `alertas_deter` | 75.000 | 500 MB |
| `dados_saneamento` | 1.400 | 200 KB |
| `emissoes_gee` | 7.000 | 1 MB |
| **TOTAL** | **577.250** | **~751 MB** |

**Nota:** Estimativas assumem:
- Dados geoespaciais (geometrias) ocupam ~80% do espaço total
- Dados tabulares (atributos) ocupam ~20%
- Índices adicionam ~30% ao tamanho total
- **Volume total com índices:** ~1 GB

---

## 5. Interconexões com Outras Dimensões

A dimensão ambiental não existe isoladamente. Ela está profundamente interconectada com as dimensões econômica, social e territorial. Esta seção documenta as principais interconexões e como elas podem ser exploradas analiticamente.

### 5.1 Ambiental ↔ Econômica

#### 5.1.1 Desmatamento → PIB Agropecuário

**Hipótese:** Municípios com maior desmatamento tendem a ter maior PIB agropecuário (expansão agrícola impulsiona desmatamento).

**Análise:**
```sql
SELECT 
    e.nome_municipio,
    SUM(d.area_ha) AS desmatamento_total_ha,
    (SELECT pib_agropecuario_mil_reais 
     FROM dados_economicos ec 
     WHERE ec.codigo_ibge = e.codigo_ibge 
     ORDER BY ec.ano DESC LIMIT 1) AS pib_agropecuario_mil_reais,
    CORR(d.area_ha, ec.pib_agropecuario_mil_reais) OVER () AS correlacao
FROM desmatamento_prodes d
JOIN entidades_territoriais e ON d.codigo_ibge = e.codigo_ibge
JOIN dados_economicos ec ON d.codigo_ibge = ec.codigo_ibge AND d.ano = ec.ano
WHERE d.ano >= 2015
GROUP BY e.codigo_ibge, e.nome_municipio;
```

**Implicação:** Identificar municípios onde crescimento econômico está ocorrendo às custas de desmatamento, permitindo políticas de desenvolvimento sustentável.

#### 5.1.2 Queimadas → Custos de Saúde

**Hipótese:** Municípios com mais queimadas têm maiores gastos com saúde respiratória.

**Análise:**
```sql
SELECT 
    e.nome_municipio,
    COUNT(f.id) AS focos_calor_ano,
    (SELECT despesas_saude_mil_reais 
     FROM dados_orcamentarios o 
     WHERE o.codigo_ibge = e.codigo_ibge 
     AND o.ano = EXTRACT(YEAR FROM f.data_hora)
    ) AS despesas_saude_mil_reais
FROM focos_calor f
JOIN entidades_territoriais e ON f.codigo_ibge = e.codigo_ibge
WHERE EXTRACT(YEAR FROM f.data_hora) = 2023
GROUP BY e.codigo_ibge, e.nome_municipio, EXTRACT(YEAR FROM f.data_hora);
```

**Implicação:** Quantificar custos econômicos indiretos de queimadas, fortalecendo justificativa para investimentos em prevenção.

#### 5.1.3 Recursos Hídricos → Agricultura Irrigada

**Hipótese:** Municípios com maior disponibilidade hídrica têm maior área de agricultura irrigada e maior PIB agrícola.

**Análise:**
```sql
SELECT 
    e.nome_municipio,
    AVG(h.vazao) AS vazao_media_m3s,
    (SELECT area_ha FROM uso_solo_anual u 
     WHERE u.codigo_ibge = e.codigo_ibge 
     AND u.classe_uso = 'Agricultura Irrigada'
     ORDER BY u.ano DESC LIMIT 1) AS agricultura_irrigada_ha,
    (SELECT pib_agricultura_mil_reais 
     FROM dados_economicos ec 
     WHERE ec.codigo_ibge = e.codigo_ibge 
     ORDER BY ec.ano DESC LIMIT 1) AS pib_agricultura_mil_reais
FROM dados_hidrologicos h
JOIN entidades_territoriais e ON h.codigo_ibge = e.codigo_ibge
WHERE h.tipo_estacao = 'Fluviométrica'
GROUP BY e.codigo_ibge, e.nome_municipio;
```

**Implicação:** Identificar municípios com potencial para expansão de agricultura irrigada vs municípios com estresse hídrico.

### 5.2 Ambiental ↔ Social

#### 5.2.1 Qualidade do Ar → Doenças Respiratórias

**Hipótese:** Municípios com pior qualidade do ar (mais queimadas) têm maiores taxas de internação por doenças respiratórias.

**Análise:**
```sql
SELECT 
    e.nome_municipio,
    COUNT(f.id) AS focos_calor_ano,
    (SELECT internacoes_respiratorias 
     FROM dados_saude s 
     WHERE s.codigo_ibge = e.codigo_ibge 
     AND s.ano = EXTRACT(YEAR FROM f.data_hora)
    ) AS internacoes_respiratorias
FROM focos_calor f
JOIN entidades_territoriais e ON f.codigo_ibge = e.codigo_ibge
WHERE EXTRACT(YEAR FROM f.data_hora) = 2023
GROUP BY e.codigo_ibge, e.nome_municipio, EXTRACT(YEAR FROM f.data_hora);
```

**Implicação:** Evidenciar impactos de queimadas na saúde pública, fortalecendo políticas de prevenção.

#### 5.2.2 Saneamento → Qualidade da Água

**Hipótese:** Municípios com baixa cobertura de esgotamento sanitário têm pior qualidade da água (mais coliformes).

**Análise:**
```sql
SELECT 
    e.nome_municipio,
    s.cobertura_esgoto_percentual,
    AVG(q.coliformes_termotolerantes) AS coliformes_media_nmp
FROM dados_saneamento s
JOIN entidades_territoriais e ON s.codigo_ibge = e.codigo_ibge
LEFT JOIN qualidade_agua q ON s.codigo_ibge = q.codigo_ibge 
    AND EXTRACT(YEAR FROM q.data_coleta) = s.ano
WHERE s.ano = 2023
GROUP BY e.codigo_ibge, e.nome_municipio, s.cobertura_esgoto_percentual
ORDER BY s.cobertura_esgoto_percentual ASC;
```

**Implicação:** Priorizar investimentos em saneamento em municípios com pior qualidade da água.

#### 5.2.3 Áreas Verdes → Qualidade de Vida

**Hipótese:** Municípios com maior cobertura de vegetação nativa têm melhor IDH.

**Análise:**
```sql
SELECT 
    e.nome_municipio,
    (SELECT SUM(percentual_municipio) FROM uso_solo_anual u
     WHERE u.codigo_ibge = e.codigo_ibge
     AND u.ano = 2022
     AND u.classe_uso IN ('Floresta', 'Savana', 'Campo')
    ) AS vegetacao_nativa_percentual,
    (SELECT idh FROM dados_sociais ds
     WHERE ds.codigo_ibge = e.codigo_ibge
     ORDER BY ds.ano DESC LIMIT 1
    ) AS idh
FROM entidades_territoriais e
WHERE e.uf = 'TO';
```

**Implicação:** Demonstrar co-benefícios de conservação ambiental para qualidade de vida.

### 5.3 Ambiental ↔ Territorial

#### 5.3.1 Rodovias → Desmatamento

**Hipótese:** Municípios mais próximos de rodovias têm maior desmatamento (rodovias facilitam acesso e expansão agrícola).

**Análise:**
```sql
SELECT 
    e.nome_municipio,
    ST_Distance(e.geom, r.geom) / 1000 AS distancia_rodovia_km,
    SUM(d.area_ha) AS desmatamento_total_ha
FROM entidades_territoriais e
CROSS JOIN LATERAL (
    SELECT geom FROM rodovias 
    ORDER BY e.geom <-> rodovias.geom 
    LIMIT 1
) r
JOIN desmatamento_prodes d ON e.codigo_ibge = d.codigo_ibge
WHERE e.uf = 'TO'
GROUP BY e.codigo_ibge, e.nome_municipio, r.geom, e.geom
ORDER BY distancia_rodovia_km ASC;
```

**Implicação:** Prever impactos ambientais de construção de novas rodovias, orientando planejamento territorial.

#### 5.3.2 Conectividade Digital → Monitoramento Ambiental

**Hipótese:** Municípios com melhor conectividade digital têm maior capacidade de monitoramento ambiental (acesso a dados, sistemas de alerta).

**Análise:**
```sql
SELECT 
    e.nome_municipio,
    c.acessos_banda_larga_por_100hab,
    COUNT(DISTINCT a.id) AS alertas_deter_respondidos
FROM conectividade_digital c
JOIN entidades_territoriais e ON c.codigo_ibge = e.codigo_ibge
LEFT JOIN alertas_deter a ON c.codigo_ibge = a.codigo_ibge 
    AND a.validado = TRUE
WHERE c.ano = 2023
GROUP BY e.codigo_ibge, e.nome_municipio, c.acessos_banda_larga_por_100hab
ORDER BY c.acessos_banda_larga_por_100hab DESC;
```

**Implicação:** Justificar investimentos em conectividade digital como ferramenta de gestão ambiental.

#### 5.3.3 Áreas Protegidas → Conservação

**Hipótese:** Municípios com maior percentual de área em UCs e TIs têm menor desmatamento.

**Análise:**
```sql
SELECT 
    e.nome_municipio,
    (SELECT SUM(ST_Area(ap.geom::geography) / 10000) 
     FROM areas_protegidas ap 
     WHERE ST_Intersects(ap.geom, e.geom)
    ) / (ST_Area(e.geom::geography) / 10000) * 100 AS areas_protegidas_percentual,
    SUM(d.area_ha) AS desmatamento_total_ha
FROM entidades_territoriais e
LEFT JOIN desmatamento_prodes d ON e.codigo_ibge = d.codigo_ibge
WHERE e.uf = 'TO'
GROUP BY e.codigo_ibge, e.nome_municipio, e.geom
ORDER BY areas_protegidas_percentual DESC;
```

**Implicação:** Demonstrar eficácia de áreas protegidas, fortalecendo políticas de conservação.

### 5.4 Síntese de Interconexões

| Interconexão | Hipótese | Implicação para Gestão Pública |
|--------------|----------|--------------------------------|
| **Desmatamento → PIB Agropecuário** | Crescimento econômico via desmatamento | Políticas de desenvolvimento sustentável |
| **Queimadas → Custos de Saúde** | Queimadas aumentam gastos com saúde | Investimentos em prevenção de queimadas |
| **Recursos Hídricos → Agricultura** | Água disponível impulsiona agricultura | Gestão de conflitos pelo uso da água |
| **Qualidade do Ar → Saúde Respiratória** | Poluição aumenta doenças respiratórias | Monitoramento e alertas de qualidade do ar |
| **Saneamento → Qualidade da Água** | Falta de esgoto polui rios | Priorização de investimentos em saneamento |
| **Áreas Verdes → Qualidade de Vida** | Vegetação melhora bem-estar | Políticas de conservação urbana |
| **Rodovias → Desmatamento** | Rodovias facilitam desmatamento | Avaliação ambiental estratégica de infraestrutura |
| **Conectividade → Monitoramento** | Internet melhora gestão ambiental | Investimentos em conectividade digital |
| **Áreas Protegidas → Conservação** | UCs e TIs reduzem desmatamento | Criação e fortalecimento de áreas protegidas |

---

## 6. Casos de Uso Transformadores

Esta seção apresenta 8 casos de uso práticos que demonstram como dados ambientais podem transformar a gestão pública no Tocantins.

### 6.1 Caso de Uso 1: Sistema de Alerta Precoce de Queimadas

**Problema:** Queimadas causam danos ambientais, econômicos e de saúde pública. Resposta tardia amplifica impactos.

**Solução:** Sistema automatizado que monitora focos de calor em tempo real, identifica padrões de risco e envia alertas para gestores e brigadas de incêndio.

**Dados utilizados:**
- Focos de calor (INPE BDQueimadas) - tempo real
- Precipitação e umidade (INMET) - diário
- Velocidade do vento (INMET) - diário
- Uso do solo (MapBiomas) - anual
- Áreas protegidas (ICMBio/FUNAI) - estático

**Fluxo:**
1. **Coleta:** Workflow n8n coleta focos de calor a cada 3 horas
2. **Análise:** Algoritmo identifica municípios/regiões com:
   - Múltiplos focos em curto período (< 24h)
   - Condições meteorológicas de risco (baixa umidade, vento forte)
   - Proximidade de áreas sensíveis (UCs, TIs, áreas urbanas)
3. **Alerta:** Sistema envia notificações automáticas (email, SMS, WhatsApp) para:
   - Secretaria de Meio Ambiente estadual
   - Defesa Civil municipal
   - Corpo de Bombeiros
   - ICMBio (se UC federal afetada)
4. **Resposta:** Brigadas são mobilizadas para combate prioritário

**Impacto esperado:**
- **Redução de 30-50%** em área queimada (resposta mais rápida)
- **Economia de R$ 5-10 milhões/ano** (custos evitados de combate e recuperação)
- **Redução de 20-30%** em internações por doenças respiratórias

**Complexidade de implementação:** Média (4 semanas, 1 desenvolvedor)

### 6.2 Caso de Uso 2: Priorização de Fiscalização Ambiental

**Problema:** Órgãos ambientais têm recursos limitados (pessoal, veículos, orçamento). Fiscalização não pode cobrir todo o território.

**Solução:** Modelo preditivo que identifica áreas de alto risco de desmatamento ilegal, permitindo fiscalização direcionada e eficiente.

**Dados utilizados:**
- Alertas DETER (INPE) - diário
- Desmatamento histórico (PRODES) - anual
- Autuações ambientais (IBAMA) - anual
- Rodovias (DNIT) - estático
- Áreas protegidas (ICMBio/FUNAI) - estático
- Uso do solo (MapBiomas) - anual

**Fluxo:**
1. **Treinamento:** Modelo de machine learning (Random Forest) é treinado com dados históricos para prever probabilidade de desmatamento ilegal
2. **Predição:** Modelo gera mapa de risco diário para todo o estado
3. **Priorização:** Sistema ranqueia alertas DETER por:
   - Probabilidade de ser desmatamento ilegal (vs falso positivo)
   - Área do polígono (impacto potencial)
   - Proximidade de áreas protegidas
   - Histórico de autuações na região
4. **Fiscalização:** Equipes são direcionadas para alertas de alta prioridade

**Impacto esperado:**
- **Aumento de 50-100%** em eficácia de fiscalização (mais autuações por operação)
- **Redução de 20-30%** em desmatamento ilegal (efeito dissuasório)
- **Economia de R$ 2-5 milhões/ano** (otimização de recursos)

**Complexidade de implementação:** Alta (8 semanas, 1 cientista de dados + 1 desenvolvedor)

### 6.3 Caso de Uso 3: Planejamento de Recursos Hídricos

**Problema:** Conflitos pelo uso da água entre agricultura, abastecimento urbano e conservação ambiental tendem a se intensificar com mudanças climáticas.

**Solução:** Sistema de suporte à decisão para gestão de outorgas de água, baseado em dados de disponibilidade hídrica, demanda e projeções climáticas.

**Dados utilizados:**
- Vazão de rios (ANA HIDROWEB) - diário
- Precipitação (INMET + ANA) - diário
- Outorgas de água (ANA) - estático
- Uso do solo (MapBiomas) - anual
- Projeções climáticas (INPE) - cenários

**Fluxo:**
1. **Monitoramento:** Sistema acompanha vazão de rios em tempo real
2. **Balanço hídrico:** Calcula disponibilidade hídrica (vazão - outorgas concedidas)
3. **Alerta:** Identifica bacias em estresse hídrico (disponibilidade < 20% da vazão)
4. **Cenários:** Simula impactos de novas outorgas ou mudanças climáticas
5. **Decisão:** Gestor decide sobre concessão/suspensão de outorgas baseado em evidências

**Impacto esperado:**
- **Redução de 50-70%** em conflitos pelo uso da água
- **Aumento de 20-30%** em segurança hídrica
- **Prevenção de crises hídricas** (abastecimento urbano)

**Complexidade de implementação:** Alta (12 semanas, 1 hidrólogo + 1 desenvolvedor)

### 6.4 Caso de Uso 4: Monitoramento de Qualidade da Água

**Problema:** Qualidade da água é crítica para abastecimento urbano e saúde pública, mas monitoramento é esparso (poucos pontos, coletas trimestrais).

**Solução:** Sistema que integra dados de qualidade da água com outros indicadores (saneamento, uso do solo, precipitação) para estimar qualidade em locais não monitorados.

**Dados utilizados:**
- Qualidade da água (ANA RNQA) - trimestral
- Cobertura de esgoto (SNIS) - anual
- Uso do solo (MapBiomas) - anual
- Precipitação (INMET) - diário
- Rios e bacias (IBGE) - estático

**Fluxo:**
1. **Coleta:** Dados de qualidade da água são coletados de pontos de monitoramento
2. **Interpolação:** Modelo estatístico (kriging) estima qualidade em locais não monitorados
3. **Fatores de risco:** Sistema identifica municípios com:
   - Baixa cobertura de esgoto (risco de contaminação fecal)
   - Agricultura intensiva (risco de nutrientes)
   - Mineração (risco de metais pesados)
4. **Alerta:** Gestores são notificados sobre áreas de risco
5. **Ação:** Priorização de investimentos em saneamento ou ampliação de monitoramento

**Impacto esperado:**
- **Redução de 30-50%** em doenças de veiculação hídrica
- **Aumento de 50-100%** em cobertura de monitoramento (via modelagem)
- **Economia de R$ 1-3 milhões/ano** (custos evitados de saúde)

**Complexidade de implementação:** Média (6 semanas, 1 estatístico + 1 desenvolvedor)

### 6.5 Caso de Uso 5: Avaliação de Impacto Ambiental de Infraestrutura

**Problema:** Construção de rodovias, hidrelétricas e outros empreendimentos pode causar desmatamento e degradação ambiental. Avaliações de impacto são frequentemente superficiais.

**Solução:** Sistema automatizado que estima impactos ambientais de empreendimentos propostos, baseado em dados históricos e modelagem espacial.

**Dados utilizados:**
- Desmatamento (PRODES) - anual
- Rodovias existentes (DNIT) - estático
- Uso do solo (MapBiomas) - anual
- Áreas protegidas (ICMBio/FUNAI) - estático
- Emissões GEE (SEEG) - anual

**Fluxo:**
1. **Entrada:** Gestor fornece localização e características do empreendimento proposto (ex: rodovia de 100 km)
2. **Análise espacial:** Sistema identifica:
   - Área de influência direta (10 km de cada lado)
   - Vegetação nativa na área de influência
   - Áreas protegidas afetadas
   - Corpos d'água atravessados
3. **Modelagem:** Baseado em empreendimentos similares, sistema estima:
   - Desmatamento direto (faixa de domínio)
   - Desmatamento indireto (facilitação de acesso)
   - Emissões GEE
   - Impactos em biodiversidade
4. **Relatório:** Sistema gera relatório automatizado com mapas, estatísticas e recomendações

**Impacto esperado:**
- **Redução de 20-40%** em impactos ambientais de infraestrutura (melhor planejamento)
- **Economia de R$ 5-10 milhões/ano** (custos evitados de compensação ambiental)
- **Aumento de transparência** em processos de licenciamento

**Complexidade de implementação:** Alta (10 semanas, 1 geoprocessador + 1 desenvolvedor)

### 6.6 Caso de Uso 6: Monitoramento de Metas Climáticas

**Problema:** Brasil se comprometeu a reduzir emissões de GEE, mas monitoramento de progresso é complexo e fragmentado.

**Solução:** Dashboard interativo que acompanha emissões de GEE do Tocantins por setor, município e ano, comparando com metas estabelecidas.

**Dados utilizados:**
- Emissões GEE (SEEG) - anual
- Desmatamento (PRODES) - anual
- PIB (IBGE) - anual
- População (IBGE) - anual

**Fluxo:**
1. **Coleta:** Dados de emissões são atualizados anualmente
2. **Cálculo:** Sistema calcula:
   - Emissões totais (CO2eq)
   - Emissões per capita
   - Intensidade de carbono (emissões / PIB)
   - Contribuição por setor (Energia, Agropecuária, Mudança de Uso do Solo, etc.)
3. **Comparação:** Emissões são comparadas com:
   - Meta estadual (ex: redução de 30% até 2030)
   - Média nacional
   - Trajetória necessária para atingir meta
4. **Visualização:** Dashboard mostra:
   - Gráficos de evolução temporal
   - Mapas de emissões por município
   - Ranking de municípios (maiores emissores)
   - Projeções (se tendência atual continuar)

**Impacto esperado:**
- **Transparência** em progresso de metas climáticas
- **Identificação de setores prioritários** para mitigação
- **Mobilização política** para ação climática

**Complexidade de implementação:** Média (6 semanas, 1 desenvolvedor)

### 6.7 Caso de Uso 7: Otimização de Coleta de Resíduos

**Problema:** Coleta de resíduos sólidos é cara (10-20% do orçamento municipal) e frequentemente ineficiente (rotas não otimizadas, frequência inadequada).

**Solução:** Sistema de otimização de rotas de coleta baseado em dados de geração de resíduos, localização de contentores e condições de tráfego.

**Dados utilizados:**
- Coleta de resíduos (SNIS) - anual
- Setores censitários (IBGE) - estático
- População (IBGE) - anual
- Rodovias urbanas (OpenStreetMap) - estático

**Fluxo:**
1. **Estimativa:** Sistema estima geração de resíduos por setor censitário (baseado em população e renda)
2. **Otimização:** Algoritmo de roteirização (Traveling Salesman Problem) calcula rotas ótimas
3. **Simulação:** Sistema simula diferentes cenários:
   - Frequência de coleta (diária, 3x/semana, 2x/semana)
   - Número de caminhões
   - Localização de contentores
4. **Recomendação:** Sistema recomenda configuração que minimiza custos mantendo qualidade de serviço

**Impacto esperado:**
- **Redução de 10-20%** em custos de coleta
- **Economia de R$ 500 mil - 2 milhões/ano** (por município médio)
- **Melhoria em qualidade** de serviço (menos lixo acumulado)

**Complexidade de implementação:** Alta (8 semanas, 1 engenheiro de operações + 1 desenvolvedor)

### 6.8 Caso de Uso 8: Identificação de Áreas para Restauração Florestal

**Problema:** Restauração florestal é cara e deve ser priorizada em áreas de maior impacto (conectividade de habitat, proteção de nascentes, redução de erosão).

**Solução:** Modelo de priorização espacial que identifica áreas ótimas para restauração, maximizando benefícios ambientais por real investido.

**Dados utilizados:**
- Uso do solo (MapBiomas) - anual
- Desmatamento (PRODES) - anual
- Áreas protegidas (ICMBio/FUNAI) - estático
- Rios e nascentes (ANA) - estático
- Declividade (SRTM) - estático

**Fluxo:**
1. **Identificação:** Sistema identifica áreas degradadas elegíveis para restauração (ex: pastagens degradadas)
2. **Priorização:** Algoritmo ranqueia áreas por múltiplos critérios:
   - Conectividade de habitat (proximidade de fragmentos florestais)
   - Proteção de recursos hídricos (proximidade de nascentes, rios)
   - Controle de erosão (declividade alta)
   - Viabilidade econômica (proximidade de viveiros, acesso)
3. **Cenários:** Sistema simula impactos de diferentes estratégias de restauração
4. **Recomendação:** Sistema recomenda áreas prioritárias e estratégias de implementação

**Impacto esperado:**
- **Aumento de 50-100%** em eficácia de restauração (melhor priorização)
- **Restauração de 10.000-50.000 ha** em 10 anos
- **Sequestro de 1-5 milhões de toneladas CO2eq**

**Complexidade de implementação:** Alta (10 semanas, 1 ecólogo + 1 geoprocessador + 1 desenvolvedor)

---

## 7. Roadmap de Implementação

Esta seção apresenta um roadmap prático para implementação do Agente AMBIENTAL do Framework V6.0, dividido em 4 fases ao longo de 12 semanas.

### 7.1 Fase 1: Fundação (Semanas 1-3)

**Objetivo:** Estabelecer infraestrutura básica e coletar datasets essenciais.

**Entregas:**
1. Banco de dados PostgreSQL + PostGIS configurado no Replit
2. Tabelas principais criadas (`focos_calor`, `dados_meteorologicos`, `dados_hidrologicos`, `uso_solo_anual`)
3. Workflows n8n para coleta de 4 datasets essenciais:
   - WF-AMB-01: Focos de calor (INPE BDQueimadas)
   - WF-AMB-02: Dados meteorológicos (INMET BDMEP)
   - WF-AMB-03: Vazão de rios (ANA HIDROWEB)
   - WF-AMB-04: Uso do solo (MapBiomas)
4. Dados históricos (últimos 5 anos) coletados e armazenados

**Esforço:** 80 horas (3 semanas, 1 desenvolvedor full-time)

**Custo:** R$ 8.000 (desenvolvedor) + R$ 200 (infraestrutura Replit)

### 7.2 Fase 2: Expansão (Semanas 4-6)

**Objetivo:** Adicionar datasets de alta prioridade e implementar casos de uso prioritários.

**Entregas:**
1. Tabelas adicionais (`desmatamento_prodes`, `alertas_deter`, `dados_saneamento`, `emissoes_gee`)
2. Workflows n8n para coleta de 4 datasets adicionais:
   - WF-AMB-05: Desmatamento (INPE PRODES)
   - WF-AMB-06: Alertas DETER (INPE)
   - WF-AMB-07: Saneamento (SNIS)
   - WF-AMB-08: Emissões GEE (SEEG)
3. Implementação de 2 casos de uso:
   - Caso 1: Sistema de Alerta Precoce de Queimadas
   - Caso 6: Monitoramento de Metas Climáticas (dashboard)
4. Views e funções auxiliares criadas

**Esforço:** 80 horas (3 semanas, 1 desenvolvedor full-time)

**Custo:** R$ 8.000 (desenvolvedor) + R$ 200 (infraestrutura)

### 7.3 Fase 3: Integração (Semanas 7-9)

**Objetivo:** Integrar dados ambientais com outras dimensões e implementar casos de uso avançados.

**Entregas:**
1. Tabela `qualidade_agua` criada e populada
2. Workflow WF-AMB-09: Qualidade da água (ANA RNQA)
3. Queries SQL de interconexão com outras dimensões (econômica, social, territorial)
4. Implementação de 2 casos de uso avançados:
   - Caso 2: Priorização de Fiscalização Ambiental (modelo preditivo)
   - Caso 4: Monitoramento de Qualidade da Água (interpolação espacial)
5. Dashboard integrado (Ambiental + Econômica + Social + Territorial)

**Esforço:** 80 horas (3 semanas, 1 desenvolvedor + 1 cientista de dados)

**Custo:** R$ 12.000 (equipe) + R$ 200 (infraestrutura)

### 7.4 Fase 4: Refinamento e Validação (Semanas 10-12)

**Objetivo:** Otimizar performance, validar com usuários e preparar para produção.

**Entregas:**
1. Otimização de queries SQL (índices, particionamento)
2. Implementação de 2 casos de uso finais:
   - Caso 3: Planejamento de Recursos Hídricos
   - Caso 5: Avaliação de Impacto Ambiental de Infraestrutura
3. Testes de carga e performance
4. Validação com 5-10 gestores públicos (feedback qualitativo)
5. Documentação completa (técnica + usuário final)
6. Treinamento de equipe (2 sessões de 4 horas)

**Esforço:** 80 horas (3 semanas, 1 desenvolvedor + 1 designer UX)

**Custo:** R$ 10.000 (equipe) + R$ 200 (infraestrutura)

### 7.5 Síntese do Roadmap

| Fase | Semanas | Entregas Principais | Esforço (h) | Custo (R$) |
|------|---------|---------------------|-------------|------------|
| **Fase 1: Fundação** | 1-3 | 4 datasets essenciais, infraestrutura | 80 | 8.200 |
| **Fase 2: Expansão** | 4-6 | 4 datasets adicionais, 2 casos de uso | 80 | 8.200 |
| **Fase 3: Integração** | 7-9 | Integração com outras dimensões, 2 casos de uso avançados | 80 | 12.200 |
| **Fase 4: Refinamento** | 10-12 | Otimização, validação, 2 casos de uso finais | 80 | 10.200 |
| **TOTAL** | **12 semanas** | **Agente AMBIENTAL Completo** | **320h** | **38.800** |

**Nota:** Custos assumem:
- Desenvolvedor: R$ 100/hora
- Cientista de dados: R$ 150/hora
- Designer UX: R$ 80/hora
- Infraestrutura Replit: R$ 50/mês (plano Hacker)

---

## 8. Desafios e Limitações

### 8.1 Desafios Técnicos

**Dados geoespaciais volumosos.** Polígonos de desmatamento e alertas DETER ocupam centenas de MB. Processamento e visualização requerem otimizações (simplificação de geometrias, tiling, caching).

**Integração de múltiplas fontes.** Cada fonte (INPE, ANA, IBGE, MapBiomas) tem formato, estrutura e frequência de atualização diferentes. Padronização é trabalhosa.

**Qualidade de dados variável.** Dados de sensoriamento remoto têm incertezas (nuvens, resolução espacial). Dados de estações meteorológicas têm falhas. Validação e limpeza são essenciais.

**Processamento computacional intensivo.** Análises espaciais (intersecções, buffers, krigagem) são computacionalmente caras. Otimização de queries SQL e uso de índices espaciais são críticos.

### 8.2 Desafios de Dados

**Cobertura espacial irregular.** Estações meteorológicas e hidrológicas não cobrem uniformemente o território. Municípios remotos têm poucos dados.

**Atraso temporal.** Dados de desmatamento (PRODES), emissões (SEEG) e saneamento (SNIS) têm atraso de 1-2 anos. Análises são retrospectivas, não preditivas.

**Falta de dados de biodiversidade.** Dados sobre espécies ameaçadas, fauna e flora são escassos e fragmentados. Análises de impacto em biodiversidade são limitadas.

**Dados de licenciamento fragmentados.** Não há API centralizada para processos de licenciamento ambiental. Coleta é manual e trabalhosa.

### 8.3 Desafios Operacionais

**Capacitação de gestores.** Gestores públicos frequentemente não têm familiaridade com análises espaciais, estatísticas e dashboards interativos. Treinamento é essencial.

**Resistência institucional.** Órgãos ambientais podem resistir a ferramentas que expõem deficiências (ex: baixa eficácia de fiscalização). Engajamento e co-criação são importantes.

**Sustentabilidade financeira.** Após implementação inicial, sistema requer manutenção (atualizações, correções de bugs, suporte). Fonte de financiamento recorrente deve ser identificada.

**Dependência de internet.** Sistema requer conectividade para acesso a dados e dashboards. Municípios remotos com internet precária podem ter dificuldades.

---

## 9. Recomendações Estratégicas

### 9.1 Priorizar Casos de Uso de Alto Impacto

Focar inicialmente em casos de uso que geram valor imediato e visível (ex: Sistema de Alerta de Queimadas, Monitoramento de Metas Climáticas). Sucesso inicial gera momentum político e financeiro para expansão.

### 9.2 Co-criar com Usuários Finais

Envolver gestores públicos desde o início (levantamento de necessidades, validação de protótipos, testes de usabilidade). Ferramentas co-criadas têm maior taxa de adoção.

### 9.3 Começar Pequeno, Escalar Gradualmente

Implementar MVP (Minimum Viable Product) com 4-5 datasets essenciais e 2 casos de uso prioritários. Validar com usuários. Expandir iterativamente baseado em feedback.

### 9.4 Investir em Capacitação

Treinar gestores públicos em interpretação de dados ambientais, uso de dashboards e tomada de decisão baseada em evidências. Capacitação é tão importante quanto tecnologia.

### 9.5 Estabelecer Parcerias Estratégicas

Colaborar com instituições de pesquisa (UFT, Embrapa), ONGs ambientais (WWF, TNC) e órgãos federais (INPE, ANA, IBAMA). Parcerias amplificam capacidade técnica e legitimidade.

---

## 10. Conclusão

A dimensão ambiental representa uma oportunidade extraordinária para transformar a gestão pública no Tocantins. O estado enfrenta desafios ambientais significativos (desmatamento, queimadas, pressão sobre recursos hídricos), mas possui acesso a dados ambientais de alta qualidade provenientes de instituições de classe mundial (INPE, ANA, IBGE, MapBiomas).

Esta análise identificou **10 fontes principais** de dados ambientais, mapeou **37 datasets prioritários** organizados em **8 áreas temáticas**, propôs uma **estrutura de dados PostgreSQL** com 8 tabelas especializadas, documentou **interconexões críticas** com outras dimensões (econômica, social, territorial) e apresentou **8 casos de uso transformadores** que podem gerar impacto real.

O **Agente AMBIENTAL** do Framework V6.0, quando implementado, permitirá:
- **Monitoramento contínuo** de indicadores ambientais em tempo real
- **Análises de tendências** espaciais e temporais
- **Avaliação de impactos** de decisões de gestão
- **Suporte a licenciamento** ambiental baseado em evidências
- **Relatórios automatizados** para prestação de contas
- **Integração holística** com dimensões econômica, social e territorial

Com **320 horas** de desenvolvimento (12 semanas, 1-2 desenvolvedores) e investimento de **R$ 38.800**, é possível implementar o Agente AMBIENTAL completo, transformando dados ambientais em inteligência acionável para gestores públicos.

Agora temos **quatro dimensões completas** (Econômica, Social, Territorial, Ambiental). O Framework V6.0 está pronto para **sair do papel** e **transformar a gestão pública** no Tocantins.

---

## Referências

1. INPE. Programa Queimadas - BDQueimadas. Disponível em: https://terrabrasilis.dpi.inpe.br/queimadas/bdqueimadas/
2. INPE. PRODES - Monitoramento do Desmatamento. Disponível em: http://terrabrasilis.dpi.inpe.br/
3. INPE. DETER - Sistema de Detecção de Desmatamento em Tempo Real. Disponível em: http://terrabrasilis.dpi.inpe.br/
4. INMET. Banco de Dados Meteorológicos (BDMEP). Disponível em: https://bdmep.inmet.gov.br/
5. ANA. HIDROWEB - Sistema de Informações Hidrológicas. Disponível em: https://www.snirh.gov.br/hidroweb/
6. ANA. Rede Nacional de Monitoramento de Qualidade da Água. Disponível em: https://qualidadedaagua.ana.gov.br/
7. MapBiomas. Coleção 8 - Mapas Anuais de Cobertura e Uso do Solo. Disponível em: https://mapbiomas.org/
8. SEEG. Sistema de Estimativas de Emissões de Gases de Efeito Estufa. Disponível em: https://seeg.eco.br/
9. SNIS. Sistema Nacional de Informações sobre Saneamento. Disponível em: http://www.snis.gov.br/
10. ICMBio. Unidades de Conservação Federais. Disponível em: https://www.gov.br/icmbio/

---

**Fim do Documento**
