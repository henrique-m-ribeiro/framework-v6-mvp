-- ============================================================================
-- SCHEMA COMPLETO DAS 40 TABELAS DO FRAMEWORK V6.0
-- PostgreSQL 14+ | PostGIS 3.3+ | pgvector 0.5+
-- ============================================================================
-- Versão: 1.0
-- Data: 07 de Novembro de 2025
-- Autores: Henrique Ribeiro & Manus IA
-- Descrição: Schema completo para base de conhecimento RAG integrada
--            (Econômica, Social, Territorial, Ambiental)
-- ============================================================================

-- ============================================================================
-- EXTENSÕES NECESSÁRIAS
-- ============================================================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";      -- Geração de UUIDs
CREATE EXTENSION IF NOT EXISTS "postgis";        -- Dados geoespaciais
CREATE EXTENSION IF NOT EXISTS "vector";         -- Embeddings vetoriais (pgvector)

-- ============================================================================
-- TABELA CORE: ENTIDADES TERRITORIAIS
-- ============================================================================
-- Descrição: Municípios do Tocantins + Estado (140 registros)
-- Uso: Tabela de referência para todas as outras tabelas
-- ============================================================================

CREATE TABLE entidades_territoriais (
    codigo_ibge VARCHAR(7) PRIMARY KEY,           -- Código IBGE (2 dígitos estado + 5 dígitos município)
    nome VARCHAR(100) NOT NULL,                   -- Nome do município ou "Tocantins (Estado)"
    uf CHAR(2) NOT NULL DEFAULT 'TO',             -- Sigla da UF
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('municipio', 'estado')), -- Tipo de entidade
    
    -- Regiões (Nova Divisão 2017)
    regiao_imediata_id VARCHAR(7),                -- Código da região imediata
    regiao_imediata_nome VARCHAR(100),            -- Nome da região imediata
    regiao_intermediaria_id VARCHAR(4),           -- Código da região intermediária
    regiao_intermediaria_nome VARCHAR(100),       -- Nome da região intermediária
    
    -- Regiões (Divisão Antiga 1989)
    microrregiao_id VARCHAR(7),                   -- Código da microrregião
    microrregiao_nome VARCHAR(100),               -- Nome da microrregião
    mesorregiao_id VARCHAR(4),                    -- Código da mesorregião
    mesorregiao_nome VARCHAR(100),                -- Nome da mesorregião
    
    -- Dados básicos
    populacao INTEGER,                            -- População (Censo 2022)
    area_km2 NUMERIC(10,2),                       -- Área territorial em km²
    densidade_demografica NUMERIC(10,2),          -- Habitantes por km²
    
    -- Geometria (PostGIS)
    geom GEOMETRY(MULTIPOLYGON, 4326),            -- Geometria do município/estado (SIRGAS 2000)
    centroide GEOMETRY(POINT, 4326),              -- Centroide geográfico
    
    -- Metadados
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_entidades_nome ON entidades_territoriais(nome);
CREATE INDEX idx_entidades_tipo ON entidades_territoriais(tipo);
CREATE INDEX idx_entidades_regiao_imediata ON entidades_territoriais(regiao_imediata_id);
CREATE INDEX idx_entidades_geom ON entidades_territoriais USING GIST(geom);
CREATE INDEX idx_entidades_centroide ON entidades_territoriais USING GIST(centroide);

COMMENT ON TABLE entidades_territoriais IS 'Tabela de referência com municípios do Tocantins e estado';
COMMENT ON COLUMN entidades_territoriais.codigo_ibge IS 'Código IBGE único (17 = estado, 17XXXXX = municípios)';
COMMENT ON COLUMN entidades_territoriais.geom IS 'Geometria MULTIPOLYGON no sistema SIRGAS 2000 (EPSG:4326)';

-- ============================================================================
-- DIMENSÃO ECONÔMICA (16 TABELAS)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. DADOS_ECONOMICOS
-- ----------------------------------------------------------------------------
-- Descrição: PIB municipal e estadual (série histórica 10 anos)
-- Fonte: IBGE - PIB dos Municípios
-- Atualização: Anual (liberado em dezembro do ano seguinte)
-- Volume: 140 entidades × 10 anos = 1.400 registros
-- ----------------------------------------------------------------------------

CREATE TABLE dados_economicos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL CHECK (ano >= 2000 AND ano <= 2100),
    
    -- PIB Total
    pib_mil_reais NUMERIC(15,3),                  -- PIB em milhares de reais correntes
    pib_per_capita_reais NUMERIC(10,2),           -- PIB per capita em reais correntes
    
    -- Composição Setorial (Valor Adicionado)
    va_agropecuaria_mil_reais NUMERIC(15,3),      -- Valor adicionado da agropecuária
    va_industria_mil_reais NUMERIC(15,3),         -- Valor adicionado da indústria
    va_servicos_mil_reais NUMERIC(15,3),          -- Valor adicionado de serviços
    va_adm_publica_mil_reais NUMERIC(15,3),       -- Valor adicionado da administração pública
    
    -- Impostos
    impostos_liquidos_mil_reais NUMERIC(15,3),    -- Impostos sobre produtos líquidos de subsídios
    
    -- Participação Setorial (%)
    participacao_agropecuaria NUMERIC(5,2),       -- % do VA agropecuária no PIB
    participacao_industria NUMERIC(5,2),          -- % do VA indústria no PIB
    participacao_servicos NUMERIC(5,2),           -- % do VA serviços no PIB
    
    -- Metadados
    fonte VARCHAR(50) DEFAULT 'IBGE',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE(codigo_ibge, ano)
);

CREATE INDEX idx_economicos_codigo_ano ON dados_economicos(codigo_ibge, ano DESC);
CREATE INDEX idx_economicos_ano ON dados_economicos(ano DESC);
CREATE INDEX idx_economicos_pib ON dados_economicos(pib_mil_reais DESC);

COMMENT ON TABLE dados_economicos IS 'PIB municipal e estadual com composição setorial (série histórica)';

-- ----------------------------------------------------------------------------
-- 2. DADOS_ORCAMENTARIOS
-- ----------------------------------------------------------------------------
-- Descrição: Receitas e despesas orçamentárias detalhadas
-- Fonte: SICONFI (Tesouro Nacional)
-- Atualização: Mensal (com consolidação anual)
-- Volume: 140 entidades × 10 anos × 12 meses = 16.800 registros
-- ----------------------------------------------------------------------------

CREATE TABLE dados_orcamentarios (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    mes INTEGER CHECK (mes >= 1 AND mes <= 12),  -- NULL para dados anuais consolidados
    tipo_ente VARCHAR(20) CHECK (tipo_ente IN ('municipio', 'estado')),
    
    -- Receitas Correntes
    receitas_correntes_reais NUMERIC(15,2),
    receita_tributaria_reais NUMERIC(15,2),       -- IPTU, ISS, ITBI
    receita_contribuicoes_reais NUMERIC(15,2),
    receita_patrimonial_reais NUMERIC(15,2),
    receita_servicos_reais NUMERIC(15,2),
    transferencias_correntes_reais NUMERIC(15,2), -- FPM, ICMS, etc.
    
    -- Receitas de Capital
    receitas_capital_reais NUMERIC(15,2),
    operacoes_credito_reais NUMERIC(15,2),
    alienacao_bens_reais NUMERIC(15,2),
    transferencias_capital_reais NUMERIC(15,2),
    
    -- Despesas por Função
    despesa_total_reais NUMERIC(15,2),
    despesa_educacao_reais NUMERIC(15,2),
    despesa_saude_reais NUMERIC(15,2),
    despesa_assistencia_social_reais NUMERIC(15,2),
    despesa_urbanismo_reais NUMERIC(15,2),
    despesa_agricultura_reais NUMERIC(15,2),
    despesa_transporte_reais NUMERIC(15,2),
    despesa_seguranca_publica_reais NUMERIC(15,2),
    despesa_meio_ambiente_reais NUMERIC(15,2),
    
    -- Despesas por Categoria Econômica
    despesas_correntes_reais NUMERIC(15,2),
    despesas_pessoal_reais NUMERIC(15,2),
    despesas_custeio_reais NUMERIC(15,2),
    despesas_capital_reais NUMERIC(15,2),
    despesas_investimentos_reais NUMERIC(15,2),
    
    -- Resultado
    resultado_primario_reais NUMERIC(15,2),       -- Receitas - Despesas (exceto juros)
    resultado_nominal_reais NUMERIC(15,2),        -- Resultado primário - Juros
    
    -- Metadados
    fonte VARCHAR(50) DEFAULT 'SICONFI',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE(codigo_ibge, ano, mes)
);

CREATE INDEX idx_orcamentarios_codigo_ano ON dados_orcamentarios(codigo_ibge, ano DESC, mes DESC);
CREATE INDEX idx_orcamentarios_receitas ON dados_orcamentarios(receitas_correntes_reais DESC);
CREATE INDEX idx_orcamentarios_despesas ON dados_orcamentarios(despesa_total_reais DESC);

COMMENT ON TABLE dados_orcamentarios IS 'Receitas e despesas orçamentárias detalhadas (mensal e anual)';

-- ----------------------------------------------------------------------------
-- 3. EMPRESAS_ATIVAS
-- ----------------------------------------------------------------------------
-- Descrição: Empresas ativas por município, setor e porte
-- Fonte: IBGE - Cadastro Central de Empresas (CEMPRE)
-- Atualização: Anual
-- Volume: 140 entidades × 100 setores × 10 anos = 140.000 registros
-- ----------------------------------------------------------------------------

CREATE TABLE empresas_ativas (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    
    -- Classificação
    secao_cnae VARCHAR(1),                        -- Seção CNAE 2.0 (A-U)
    divisao_cnae VARCHAR(2),                      -- Divisão CNAE 2.0 (01-99)
    descricao_cnae TEXT,                          -- Descrição da atividade econômica
    
    -- Porte
    porte VARCHAR(20) CHECK (porte IN ('MEI', 'ME', 'EPP', 'Media', 'Grande')),
    
    -- Métricas
    numero_empresas INTEGER,                      -- Número de empresas ativas
    pessoal_ocupado INTEGER,                      -- Total de pessoal ocupado
    salarios_remuneracoes_mil_reais NUMERIC(15,2), -- Salários e remunerações
    
    -- Metadados
    fonte VARCHAR(50) DEFAULT 'IBGE-CEMPRE',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE(codigo_ibge, ano, divisao_cnae, porte)
);

CREATE INDEX idx_empresas_codigo_ano ON empresas_ativas(codigo_ibge, ano DESC);
CREATE INDEX idx_empresas_secao ON empresas_ativas(secao_cnae);
CREATE INDEX idx_empresas_porte ON empresas_ativas(porte);

COMMENT ON TABLE empresas_ativas IS 'Empresas ativas por município, setor CNAE e porte';

-- ----------------------------------------------------------------------------
-- 4. EMPREGO_FORMAL
-- ----------------------------------------------------------------------------
-- Descrição: Vínculos de emprego formal (RAIS/CAGED)
-- Fonte: Ministério do Trabalho e Emprego (MTE)
-- Atualização: Anual (RAIS) / Mensal (CAGED)
-- Volume: 140 entidades × 20 setores × 10 anos = 28.000 registros
-- ----------------------------------------------------------------------------

CREATE TABLE emprego_formal (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    mes INTEGER CHECK (mes >= 1 AND mes <= 12),  -- NULL para dados anuais (RAIS)
    
    -- Classificação
    secao_cnae VARCHAR(1),
    descricao_secao TEXT,
    
    -- Vínculos
    vinculos_ativos INTEGER,                      -- Número de vínculos ativos
    admissoes INTEGER,                            -- Admissões no período
    desligamentos INTEGER,                        -- Desligamentos no período
    saldo_emprego INTEGER,                        -- Admissões - Desligamentos
    
    -- Remuneração
    remuneracao_media_reais NUMERIC(10,2),       -- Remuneração média mensal
    massa_salarial_mil_reais NUMERIC(15,2),      -- Massa salarial total
    
    -- Perfil
    vinculos_masculino INTEGER,
    vinculos_feminino INTEGER,
    vinculos_ate_24_anos INTEGER,
    vinculos_25_49_anos INTEGER,
    vinculos_50_mais_anos INTEGER,
    
    -- Metadados
    fonte VARCHAR(50),                            -- 'RAIS' ou 'CAGED'
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE(codigo_ibge, ano, mes, secao_cnae)
);

CREATE INDEX idx_emprego_codigo_ano ON emprego_formal(codigo_ibge, ano DESC, mes DESC);
CREATE INDEX idx_emprego_secao ON emprego_formal(secao_cnae);
CREATE INDEX idx_emprego_vinculos ON emprego_formal(vinculos_ativos DESC);

COMMENT ON TABLE emprego_formal IS 'Vínculos de emprego formal por município e setor (RAIS/CAGED)';

-- ----------------------------------------------------------------------------
-- 5. PRODUCAO_AGRICOLA
-- ----------------------------------------------------------------------------
-- Descrição: Produção Agrícola Municipal (PAM)
-- Fonte: IBGE - Pesquisa Agrícola Municipal
-- Atualização: Anual
-- Volume: 140 entidades × 20 produtos × 10 anos = 28.000 registros
-- ----------------------------------------------------------------------------

CREATE TABLE producao_agricola (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    
    -- Produto
    codigo_produto INTEGER,                       -- Código do produto (tabela IBGE)
    nome_produto VARCHAR(100),                    -- Ex: Soja, Milho, Arroz
    tipo_produto VARCHAR(50),                     -- 'Lavoura Temporária' ou 'Lavoura Permanente'
    
    -- Produção
    area_plantada_ha NUMERIC(15,2),              -- Área plantada em hectares
    area_colhida_ha NUMERIC(15,2),               -- Área colhida em hectares
    quantidade_produzida_t NUMERIC(15,2),        -- Quantidade produzida em toneladas
    rendimento_medio_kg_ha NUMERIC(10,2),        -- Rendimento médio (kg/ha)
    valor_producao_mil_reais NUMERIC(15,2),      -- Valor da produção
    
    -- Metadados
    fonte VARCHAR(50) DEFAULT 'IBGE-PAM',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE(codigo_ibge, ano, codigo_produto)
);

CREATE INDEX idx_producao_agricola_codigo_ano ON producao_agricola(codigo_ibge, ano DESC);
CREATE INDEX idx_producao_agricola_produto ON producao_agricola(nome_produto);
CREATE INDEX idx_producao_agricola_valor ON producao_agricola(valor_producao_mil_reais DESC);

COMMENT ON TABLE producao_agricola IS 'Produção agrícola municipal por produto (PAM)';

-- ----------------------------------------------------------------------------
-- 6. PRODUCAO_PECUARIA
-- ----------------------------------------------------------------------------
-- Descrição: Produção Pecuária Municipal (PPM)
-- Fonte: IBGE - Pesquisa Pecuária Municipal
-- Atualização: Anual
-- Volume: 140 entidades × 10 produtos × 10 anos = 14.000 registros
-- ----------------------------------------------------------------------------

CREATE TABLE producao_pecuaria (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    
    -- Produto
    codigo_produto INTEGER,
    nome_produto VARCHAR(100),                    -- Ex: Bovinos, Suínos, Aves, Leite, Ovos
    tipo_produto VARCHAR(50),                     -- 'Rebanho' ou 'Produto Animal'
    
    -- Produção
    efetivo_rebanho INTEGER,                      -- Número de cabeças (para rebanhos)
    quantidade_produzida NUMERIC(15,2),           -- Quantidade produzida (leite em mil litros, ovos em mil dúzias)
    unidade VARCHAR(20),                          -- Unidade de medida
    valor_producao_mil_reais NUMERIC(15,2),      -- Valor da produção
    
    -- Metadados
    fonte VARCHAR(50) DEFAULT 'IBGE-PPM',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE(codigo_ibge, ano, codigo_produto)
);

CREATE INDEX idx_producao_pecuaria_codigo_ano ON producao_pecuaria(codigo_ibge, ano DESC);
CREATE INDEX idx_producao_pecuaria_produto ON producao_pecuaria(nome_produto);
CREATE INDEX idx_producao_pecuaria_efetivo ON producao_pecuaria(efetivo_rebanho DESC);

COMMENT ON TABLE producao_pecuaria IS 'Produção pecuária municipal por produto (PPM)';

-- ----------------------------------------------------------------------------
-- 7. EXTRACAO_MINERAL
-- ----------------------------------------------------------------------------
-- Descrição: Produção mineral por município
-- Fonte: ANM - Agência Nacional de Mineração
-- Atualização: Anual
-- Volume: 140 entidades × 1 registro/ano × 10 anos = 1.400 registros
-- ----------------------------------------------------------------------------

CREATE TABLE extracao_mineral (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    
    -- Substâncias
    substancia VARCHAR(100),                      -- Ex: Ouro, Calcário, Areia
    quantidade_t NUMERIC(15,2),                   -- Quantidade extraída em toneladas
    valor_producao_mil_reais NUMERIC(15,2),      -- Valor da produção
    
    -- Processos Minerários
    numero_processos_ativos INTEGER,              -- Número de processos ativos na ANM
    area_processos_ha NUMERIC(15,2),             -- Área total dos processos em hectares
    
    -- Metadados
    fonte VARCHAR(50) DEFAULT 'ANM',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE(codigo_ibge, ano, substancia)
);

CREATE INDEX idx_extracao_mineral_codigo_ano ON extracao_mineral(codigo_ibge, ano DESC);
CREATE INDEX idx_extracao_mineral_substancia ON extracao_mineral(substancia);

COMMENT ON TABLE extracao_mineral IS 'Produção mineral por município e substância';

-- ----------------------------------------------------------------------------
-- 8-16. TABELAS ECONÔMICAS ADICIONAIS (SIMPLIFICADAS)
-- ----------------------------------------------------------------------------

-- 8. Transferências Intergovernamentais
CREATE TABLE transferencias_intergovernamentais (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    mes INTEGER CHECK (mes >= 1 AND mes <= 12),
    fpm_reais NUMERIC(15,2),                      -- Fundo de Participação Municipal
    icms_reais NUMERIC(15,2),                     -- Cota-parte do ICMS
    ipva_reais NUMERIC(15,2),                     -- Cota-parte do IPVA
    itr_reais NUMERIC(15,2),                      -- Cota-parte do ITR
    fundeb_reais NUMERIC(15,2),                   -- Transferências do FUNDEB
    sus_reais NUMERIC(15,2),                      -- Transferências do SUS
    outras_transferencias_reais NUMERIC(15,2),
    fonte VARCHAR(50) DEFAULT 'SICONFI',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano, mes)
);

-- 9. Indicadores Fiscais
CREATE TABLE indicadores_fiscais (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    dependencia_fpm NUMERIC(5,2),                 -- % receitas de FPM
    autonomia_fiscal NUMERIC(5,2),                -- % receitas próprias
    capacidade_investimento NUMERIC(5,2),         -- % despesas de capital
    comprometimento_pessoal NUMERIC(5,2),         -- % despesas com pessoal (LRF: max 60%)
    endividamento NUMERIC(5,2),                   -- Dívida / Receita Corrente Líquida
    fonte VARCHAR(50) DEFAULT 'SICONFI',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano)
);

-- 10. Balança Comercial
CREATE TABLE balanca_comercial (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    mes INTEGER CHECK (mes >= 1 AND mes <= 12),
    exportacoes_usd NUMERIC(15,2),
    importacoes_usd NUMERIC(15,2),
    saldo_usd NUMERIC(15,2),
    principal_produto_exportado VARCHAR(100),
    valor_principal_produto_usd NUMERIC(15,2),
    fonte VARCHAR(50) DEFAULT 'MDIC-Comex Stat',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano, mes)
);

-- 11. Crédito Rural
CREATE TABLE credito_rural (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    numero_contratos INTEGER,
    valor_contratado_reais NUMERIC(15,2),
    finalidade VARCHAR(50),                       -- 'Custeio', 'Investimento', 'Comercialização'
    fonte VARCHAR(50) DEFAULT 'BCB-SICOR',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano, finalidade)
);

-- 12. Investimentos Públicos
CREATE TABLE investimentos_publicos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    tipo_investimento VARCHAR(50),                -- 'Infraestrutura', 'Educação', 'Saúde', etc.
    valor_investido_reais NUMERIC(15,2),
    fonte_recurso VARCHAR(50),                    -- 'Próprio', 'Federal', 'Estadual', 'Financiamento'
    fonte VARCHAR(50) DEFAULT 'SICONFI',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 13. Precificação de Produtos
CREATE TABLE precificacao_produtos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    mes INTEGER CHECK (mes >= 1 AND mes <= 12),
    produto VARCHAR(100),
    preco_medio_reais NUMERIC(10,2),
    unidade VARCHAR(20),
    fonte VARCHAR(50) DEFAULT 'CONAB',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano, mes, produto)
);

-- 14. Índices Econômicos
CREATE TABLE indices_economicos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    ano INTEGER NOT NULL,
    mes INTEGER CHECK (mes >= 1 AND mes <= 12),
    ipca NUMERIC(5,2),                            -- Inflação (IPCA)
    igpm NUMERIC(5,2),                            -- IGP-M
    selic NUMERIC(5,2),                           -- Taxa Selic
    cambio_usd NUMERIC(6,4),                      -- Câmbio USD/BRL
    fonte VARCHAR(50) DEFAULT 'BCB',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(ano, mes)
);

-- 15. Metadados de Coleta Econômica
CREATE TABLE metadados_coleta_economica (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tabela VARCHAR(50) NOT NULL,
    codigo_ibge VARCHAR(7),
    ano INTEGER,
    status VARCHAR(20) CHECK (status IN ('sucesso', 'erro', 'parcial')),
    registros_coletados INTEGER,
    tempo_execucao_segundos NUMERIC(10,2),
    mensagem_erro TEXT,
    data_execucao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_metadados_economica_tabela ON metadados_coleta_economica(tabela, data_execucao DESC);

-- ============================================================================
-- DIMENSÃO SOCIAL (8 TABELAS)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 16. DADOS_EDUCACAO
-- ----------------------------------------------------------------------------

CREATE TABLE dados_educacao (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    
    -- Matrículas
    matriculas_creche INTEGER,
    matriculas_pre_escola INTEGER,
    matriculas_fundamental_anos_iniciais INTEGER,
    matriculas_fundamental_anos_finais INTEGER,
    matriculas_ensino_medio INTEGER,
    matriculas_eja INTEGER,
    matriculas_total INTEGER,
    
    -- IDEB
    ideb_anos_iniciais NUMERIC(3,1),
    ideb_anos_finais NUMERIC(3,1),
    ideb_ensino_medio NUMERIC(3,1),
    
    -- Infraestrutura
    escolas_total INTEGER,
    escolas_com_internet INTEGER,
    escolas_com_biblioteca INTEGER,
    escolas_com_laboratorio INTEGER,
    
    -- Professores
    docentes_total INTEGER,
    docentes_com_superior INTEGER,
    
    -- Metadados
    fonte VARCHAR(50) DEFAULT 'INEP',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE(codigo_ibge, ano)
);

CREATE INDEX idx_educacao_codigo_ano ON dados_educacao(codigo_ibge, ano DESC);
CREATE INDEX idx_educacao_ideb ON dados_educacao(ideb_anos_iniciais DESC);

COMMENT ON TABLE dados_educacao IS 'Indicadores educacionais por município (matrículas, IDEB, infraestrutura)';

-- ----------------------------------------------------------------------------
-- 17. DADOS_SAUDE
-- ----------------------------------------------------------------------------

CREATE TABLE dados_saude (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    
    -- Infraestrutura
    estabelecimentos_saude INTEGER,
    leitos_sus INTEGER,
    leitos_privados INTEGER,
    leitos_total INTEGER,
    leitos_por_1000_hab NUMERIC(5,2),
    
    -- Profissionais
    medicos INTEGER,
    enfermeiros INTEGER,
    medicos_por_1000_hab NUMERIC(5,2),
    
    -- Cobertura
    cobertura_esf NUMERIC(5,2),                   -- % população coberta por ESF
    cobertura_saude_bucal NUMERIC(5,2),
    
    -- Mortalidade
    taxa_mortalidade_infantil NUMERIC(5,2),       -- Por 1.000 nascidos vivos
    taxa_mortalidade_materna NUMERIC(5,2),        -- Por 100.000 nascidos vivos
    
    -- Morbidade
    internacoes_sus INTEGER,
    internacoes_por_1000_hab NUMERIC(5,2),
    
    -- Metadados
    fonte VARCHAR(50) DEFAULT 'DataSUS',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE(codigo_ibge, ano)
);

CREATE INDEX idx_saude_codigo_ano ON dados_saude(codigo_ibge, ano DESC);
CREATE INDEX idx_saude_leitos ON dados_saude(leitos_por_1000_hab DESC);

COMMENT ON TABLE dados_saude IS 'Indicadores de saúde por município (infraestrutura, profissionais, cobertura)';

-- ----------------------------------------------------------------------------
-- 18-23. TABELAS SOCIAIS ADICIONAIS (SIMPLIFICADAS)
-- ----------------------------------------------------------------------------

-- 18. Assistência Social
CREATE TABLE dados_assistencia_social (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    mes INTEGER CHECK (mes >= 1 AND mes <= 12),
    familias_bolsa_familia INTEGER,
    valor_bolsa_familia_reais NUMERIC(15,2),
    familias_cadastro_unico INTEGER,
    cras INTEGER,                                 -- Centros de Referência de Assistência Social
    creas INTEGER,                                -- Centros de Referência Especializados
    fonte VARCHAR(50) DEFAULT 'MDS',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano, mes)
);

-- 19. Segurança Pública
CREATE TABLE dados_seguranca (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    mes INTEGER CHECK (mes >= 1 AND mes <= 12),
    homicidios INTEGER,
    roubos INTEGER,
    furtos INTEGER,
    taxa_homicidios_100mil_hab NUMERIC(5,2),
    efetivo_policial INTEGER,
    fonte VARCHAR(50) DEFAULT 'SSP-TO',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano, mes)
);

-- 20. Habitação
CREATE TABLE dados_habitacao (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    domicilios_total INTEGER,
    domicilios_proprios INTEGER,
    domicilios_alugados INTEGER,
    deficit_habitacional INTEGER,
    deficit_habitacional_percentual NUMERIC(5,2),
    domicilios_inadequados INTEGER,
    fonte VARCHAR(50) DEFAULT 'IBGE-PNAD',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano)
);

-- 21. Trabalho e Renda
CREATE TABLE dados_trabalho_renda (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    populacao_economicamente_ativa INTEGER,
    populacao_ocupada INTEGER,
    populacao_desocupada INTEGER,
    taxa_desemprego NUMERIC(5,2),
    taxa_informalidade NUMERIC(5,2),
    renda_media_mensal_reais NUMERIC(10,2),
    fonte VARCHAR(50) DEFAULT 'IBGE-PNAD',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano)
);

-- 22. Desenvolvimento Humano
CREATE TABLE indicadores_desenvolvimento_humano (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    idhm NUMERIC(4,3),                            -- Índice de Desenvolvimento Humano Municipal
    idhm_renda NUMERIC(4,3),
    idhm_longevidade NUMERIC(4,3),
    idhm_educacao NUMERIC(4,3),
    gini NUMERIC(4,3),                            -- Índice de Gini (desigualdade)
    taxa_pobreza NUMERIC(5,2),                    -- % população abaixo da linha de pobreza
    taxa_extrema_pobreza NUMERIC(5,2),
    fonte VARCHAR(50) DEFAULT 'PNUD-Atlas Brasil',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano)
);

-- 23. Demografia
CREATE TABLE dados_demograficos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    populacao_total INTEGER,
    populacao_urbana INTEGER,
    populacao_rural INTEGER,
    taxa_urbanizacao NUMERIC(5,2),
    populacao_0_14_anos INTEGER,
    populacao_15_64_anos INTEGER,
    populacao_65_mais_anos INTEGER,
    razao_dependencia NUMERIC(5,2),
    esperanca_vida_anos NUMERIC(4,1),
    taxa_natalidade NUMERIC(5,2),
    taxa_mortalidade NUMERIC(5,2),
    saldo_migratorio INTEGER,
    fonte VARCHAR(50) DEFAULT 'IBGE',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano)
);

-- ============================================================================
-- DIMENSÃO TERRITORIAL (7 TABELAS)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 24. INFRAESTRUTURA_TRANSPORTE
-- ----------------------------------------------------------------------------

CREATE TABLE infraestrutura_transporte (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    tipo VARCHAR(50),                             -- 'Rodovia', 'Ferrovia', 'Hidrovia', 'Aeroporto', 'Porto'
    nome TEXT,
    extensao_km NUMERIC(10,2),                    -- Para rodovias, ferrovias, hidrovias
    condicao VARCHAR(50),                         -- 'Pavimentada', 'Não Pavimentada', 'Em Obras'
    geom GEOMETRY(LINESTRING, 4326),              -- Geometria da via
    fonte VARCHAR(50) DEFAULT 'DNIT',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_infra_transporte_codigo ON infraestrutura_transporte(codigo_ibge);
CREATE INDEX idx_infra_transporte_tipo ON infraestrutura_transporte(tipo);
CREATE INDEX idx_infra_transporte_geom ON infraestrutura_transporte USING GIST(geom);

COMMENT ON TABLE infraestrutura_transporte IS 'Infraestrutura de transporte (rodovias, ferrovias, etc.)';

-- ----------------------------------------------------------------------------
-- 25-30. TABELAS TERRITORIAIS ADICIONAIS (SIMPLIFICADAS)
-- ----------------------------------------------------------------------------

-- 25. Conectividade Digital
CREATE TABLE conectividade_digital (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    cobertura_4g NUMERIC(5,2),                    -- % área com cobertura 4G
    cobertura_fibra NUMERIC(5,2),                 -- % área com fibra óptica
    velocidade_media_mbps NUMERIC(10,2),
    domicilios_com_internet INTEGER,
    domicilios_com_internet_percentual NUMERIC(5,2),
    fonte VARCHAR(50) DEFAULT 'ANATEL',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano)
);

-- 26. Energia
CREATE TABLE energia (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    consumo_total_mwh NUMERIC(15,2),
    consumo_residencial_mwh NUMERIC(15,2),
    consumo_industrial_mwh NUMERIC(15,2),
    consumo_comercial_mwh NUMERIC(15,2),
    consumo_rural_mwh NUMERIC(15,2),
    domicilios_com_energia INTEGER,
    domicilios_com_energia_percentual NUMERIC(5,2),
    fonte VARCHAR(50) DEFAULT 'EPE',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano)
);

-- 27. Recursos Hídricos
CREATE TABLE recursos_hidricos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    bacia_hidrografica VARCHAR(100),
    area_bacia_km2 NUMERIC(15,2),
    disponibilidade_hidrica_m3_s NUMERIC(10,2),
    demanda_hidrica_m3_s NUMERIC(10,2),
    estresse_hidrico NUMERIC(5,2),                -- Demanda / Disponibilidade
    geom GEOMETRY(MULTIPOLYGON, 4326),            -- Geometria da bacia
    fonte VARCHAR(50) DEFAULT 'ANA',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_recursos_hidricos_codigo ON recursos_hidricos(codigo_ibge);
CREATE INDEX idx_recursos_hidricos_geom ON recursos_hidricos USING GIST(geom);

-- 28. Uso e Cobertura do Solo
CREATE TABLE uso_cobertura_solo (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    classe_uso VARCHAR(50),                       -- 'Floresta', 'Agricultura', 'Pastagem', 'Área Urbana', etc.
    area_ha NUMERIC(15,2),
    percentual_territorio NUMERIC(5,2),
    fonte VARCHAR(50) DEFAULT 'MapBiomas',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano, classe_uso)
);

-- 29. Áreas Protegidas
CREATE TABLE areas_protegidas (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    tipo VARCHAR(50),                             -- 'UC Federal', 'UC Estadual', 'TI', 'APP'
    nome TEXT,
    categoria VARCHAR(100),                       -- 'Proteção Integral', 'Uso Sustentável'
    area_ha NUMERIC(15,2),
    geom GEOMETRY(MULTIPOLYGON, 4326),
    fonte VARCHAR(50) DEFAULT 'MMA',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_areas_protegidas_codigo ON areas_protegidas(codigo_ibge);
CREATE INDEX idx_areas_protegidas_tipo ON areas_protegidas(tipo);
CREATE INDEX idx_areas_protegidas_geom ON areas_protegidas USING GIST(geom);

-- 30. Riscos e Vulnerabilidades
CREATE TABLE riscos_vulnerabilidades (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    tipo_risco VARCHAR(50),                       -- 'Queimada', 'Inundação', 'Seca', 'Deslizamento'
    nivel_risco VARCHAR(20) CHECK (nivel_risco IN ('Baixo', 'Médio', 'Alto', 'Muito Alto')),
    populacao_exposta INTEGER,
    area_risco_ha NUMERIC(15,2),
    geom GEOMETRY(MULTIPOLYGON, 4326),
    fonte VARCHAR(50),
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_riscos_codigo ON riscos_vulnerabilidades(codigo_ibge);
CREATE INDEX idx_riscos_tipo ON riscos_vulnerabilidades(tipo_risco);
CREATE INDEX idx_riscos_geom ON riscos_vulnerabilidades USING GIST(geom);

-- ============================================================================
-- DIMENSÃO AMBIENTAL (9 TABELAS)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 31. FOCOS_CALOR
-- ----------------------------------------------------------------------------

CREATE TABLE focos_calor (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    data_hora TIMESTAMP NOT NULL,
    latitude NUMERIC(10,6),
    longitude NUMERIC(10,6),
    satelite VARCHAR(50),
    frp NUMERIC(10,2),                            -- Fire Radiative Power (MW)
    risco_fogo VARCHAR(20),                       -- 'Mínimo', 'Baixo', 'Médio', 'Alto', 'Crítico'
    bioma VARCHAR(50),
    geom GEOMETRY(POINT, 4326),
    fonte VARCHAR(50) DEFAULT 'INPE-BDQueimadas',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_focos_calor_codigo ON focos_calor(codigo_ibge);
CREATE INDEX idx_focos_calor_data ON focos_calor(data_hora DESC);
CREATE INDEX idx_focos_calor_geom ON focos_calor USING GIST(geom);

COMMENT ON TABLE focos_calor IS 'Focos de calor detectados por satélite (INPE)';

-- ----------------------------------------------------------------------------
-- 32-39. TABELAS AMBIENTAIS ADICIONAIS (SIMPLIFICADAS)
-- ----------------------------------------------------------------------------

-- 32. Dados Meteorológicos
CREATE TABLE dados_meteorologicos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    data DATE NOT NULL,
    temperatura_max_c NUMERIC(5,2),
    temperatura_min_c NUMERIC(5,2),
    temperatura_media_c NUMERIC(5,2),
    precipitacao_mm NUMERIC(10,2),
    umidade_relativa NUMERIC(5,2),
    velocidade_vento_ms NUMERIC(5,2),
    insolacao_horas NUMERIC(5,2),
    fonte VARCHAR(50) DEFAULT 'INMET',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, data)
);

CREATE INDEX idx_meteorologicos_codigo_data ON dados_meteorologicos(codigo_ibge, data DESC);

-- 33. Dados Hidrológicos
CREATE TABLE dados_hidrologicos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    codigo_estacao VARCHAR(20),
    data DATE NOT NULL,
    vazao_m3_s NUMERIC(10,2),
    cota_cm NUMERIC(10,2),
    precipitacao_mm NUMERIC(10,2),
    fonte VARCHAR(50) DEFAULT 'ANA-HIDROWEB',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_estacao, data)
);

CREATE INDEX idx_hidrologicos_codigo_data ON dados_hidrologicos(codigo_ibge, data DESC);

-- 34. Qualidade da Água
CREATE TABLE qualidade_agua (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    codigo_estacao VARCHAR(20),
    data_coleta_amostra DATE NOT NULL,
    ph NUMERIC(4,2),
    oxigenio_dissolvido_mg_l NUMERIC(5,2),
    dbo_mg_l NUMERIC(5,2),
    coliformes_termotolerantes_nmp_100ml NUMERIC(10,2),
    turbidez_ntu NUMERIC(10,2),
    iqa NUMERIC(5,2),                             -- Índice de Qualidade da Água
    classificacao VARCHAR(20),                    -- 'Ótima', 'Boa', 'Regular', 'Ruim', 'Péssima'
    fonte VARCHAR(50) DEFAULT 'ANA-RNQA',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_estacao, data_coleta_amostra)
);

-- 35. Uso do Solo Anual
CREATE TABLE uso_solo_anual (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    classe_nivel_1 VARCHAR(50),                   -- 'Floresta', 'Formação Natural não Florestal', 'Agropecuária', 'Área não Vegetada', 'Corpo d'Água'
    classe_nivel_2 VARCHAR(100),                  -- Subclasses
    area_ha NUMERIC(15,2),
    percentual NUMERIC(5,2),
    fonte VARCHAR(50) DEFAULT 'MapBiomas',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano, classe_nivel_2)
);

-- 36. Desmatamento PRODES
CREATE TABLE desmatamento_prodes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    area_desmatada_ha NUMERIC(15,2),
    taxa_desmatamento NUMERIC(5,2),               -- % território desmatado no ano
    geom GEOMETRY(MULTIPOLYGON, 4326),            -- Polígonos de desmatamento
    fonte VARCHAR(50) DEFAULT 'INPE-PRODES',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_desmatamento_codigo_ano ON desmatamento_prodes(codigo_ibge, ano DESC);
CREATE INDEX idx_desmatamento_geom ON desmatamento_prodes USING GIST(geom);

-- 37. Alertas DETER
CREATE TABLE alertas_deter (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    data_deteccao DATE NOT NULL,
    area_ha NUMERIC(10,2),
    classe_alerta VARCHAR(50),                    -- 'Desmatamento', 'Degradação', 'Mineração'
    geom GEOMETRY(MULTIPOLYGON, 4326),
    fonte VARCHAR(50) DEFAULT 'INPE-DETER',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_alertas_deter_codigo_data ON alertas_deter(codigo_ibge, data_deteccao DESC);
CREATE INDEX idx_alertas_deter_geom ON alertas_deter USING GIST(geom);

-- 38. Dados Saneamento
CREATE TABLE dados_saneamento (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    populacao_atendida_agua INTEGER,
    cobertura_agua NUMERIC(5,2),
    populacao_atendida_esgoto INTEGER,
    cobertura_esgoto NUMERIC(5,2),
    tratamento_esgoto NUMERIC(5,2),               -- % esgoto tratado
    coleta_residuos NUMERIC(5,2),                 -- % domicílios com coleta
    destinacao_adequada_residuos NUMERIC(5,2),
    taxa_reciclagem NUMERIC(5,2),
    fonte VARCHAR(50) DEFAULT 'SNIS',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano)
);

-- 39. Emissões GEE
CREATE TABLE emissoes_gee (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    ano INTEGER NOT NULL,
    setor VARCHAR(50),                            -- 'Agropecuária', 'Mudança de Uso da Terra', 'Energia', 'Processos Industriais', 'Resíduos'
    emissoes_co2e_t NUMERIC(15,2),               -- Emissões em toneladas de CO2 equivalente
    emissoes_per_capita_t NUMERIC(10,2),
    fonte VARCHAR(50) DEFAULT 'SEEG',
    data_coleta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(codigo_ibge, ano, setor)
);

-- ============================================================================
-- TABELA DE ANÁLISES GERADAS (BASE DE CONHECIMENTO RAG)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 40. ANALISES_GERADAS
-- ----------------------------------------------------------------------------
-- Descrição: Análises geradas pelos agentes (conhecimento não estruturado)
-- Uso: Base de conhecimento RAG com busca semântica via pgvector
-- Volume: ~10.000 análises (estimativa para 140 entidades × 5 anos × 15 análises/entidade/ano)
-- ----------------------------------------------------------------------------

CREATE TABLE analises_geradas (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_ibge VARCHAR(7) REFERENCES entidades_territoriais(codigo_ibge),
    
    -- Classificação
    tipo_analise VARCHAR(50) NOT NULL CHECK (tipo_analise IN (
        'territorial', 'economica', 'social', 'ambiental', 'integrada'
    )),
    subtipo VARCHAR(100),                         -- Ex: 'pib_setorial', 'ideb_evolucao', 'queimadas_risco'
    titulo TEXT NOT NULL,
    
    -- Conteúdo
    conteudo TEXT NOT NULL,                       -- Análise completa em texto
    resumo TEXT,                                  -- Resumo executivo (opcional)
    
    -- Embedding Vetorial (pgvector)
    embedding VECTOR(1536),                       -- Embedding OpenAI text-embedding-3-small
    
    -- Metadados
    metadados JSONB,                              -- {
                                                  --   agente: 'ECON',
                                                  --   prompt: 'Analise...',
                                                  --   modelo: 'gpt-4o',
                                                  --   tokens: 1500,
                                                  --   custo_usd: 0.015,
                                                  --   fontes_dados: ['dados_economicos', 'dados_orcamentarios'],
                                                  --   periodo_analise: '2020-2023',
                                                  --   tags: ['pib', 'crescimento', 'agropecuaria']
                                                  -- }
    
    -- Versionamento
    versao INTEGER DEFAULT 1,
    analise_pai_id UUID REFERENCES analises_geradas(id), -- Para análises derivadas/atualizadas
    
    -- Qualidade
    validada BOOLEAN DEFAULT FALSE,
    validada_por VARCHAR(100),
    data_validacao TIMESTAMP,
    
    -- Timestamps
    data_geracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para busca vetorial (pgvector)
CREATE INDEX idx_analises_embedding ON analises_geradas 
    USING ivfflat (embedding vector_cosine_ops) 
    WITH (lists = 100);                           -- Ajustar 'lists' baseado no volume

-- Índices para busca estruturada
CREATE INDEX idx_analises_codigo_ibge ON analises_geradas(codigo_ibge);
CREATE INDEX idx_analises_tipo ON analises_geradas(tipo_analise);
CREATE INDEX idx_analises_data ON analises_geradas(data_geracao DESC);
CREATE INDEX idx_analises_validada ON analises_geradas(validada);

-- Índice GIN para busca em metadados JSONB
CREATE INDEX idx_analises_metadados ON analises_geradas USING GIN(metadados);

-- Índice para busca full-text em título e conteúdo
CREATE INDEX idx_analises_fulltext ON analises_geradas 
    USING GIN(to_tsvector('portuguese', titulo || ' ' || conteudo));

COMMENT ON TABLE analises_geradas IS 'Análises geradas pelos agentes (base de conhecimento RAG)';
COMMENT ON COLUMN analises_geradas.embedding IS 'Vetor de 1536 dimensões (OpenAI text-embedding-3-small) para busca semântica';
COMMENT ON COLUMN analises_geradas.metadados IS 'Metadados JSONB com informações sobre geração (agente, modelo, custo, fontes, tags)';

-- ============================================================================
-- VIEWS ÚTEIS
-- ============================================================================

-- View: Resumo econômico por município (último ano disponível)
CREATE OR REPLACE VIEW vw_resumo_economico AS
SELECT 
    e.codigo_ibge,
    e.nome,
    e.populacao,
    d.ano,
    d.pib_mil_reais,
    d.pib_per_capita_reais,
    d.participacao_agropecuaria,
    d.participacao_industria,
    d.participacao_servicos,
    i.dependencia_fpm,
    i.autonomia_fiscal
FROM entidades_territoriais e
LEFT JOIN LATERAL (
    SELECT * FROM dados_economicos 
    WHERE codigo_ibge = e.codigo_ibge 
    ORDER BY ano DESC LIMIT 1
) d ON TRUE
LEFT JOIN LATERAL (
    SELECT * FROM indicadores_fiscais 
    WHERE codigo_ibge = e.codigo_ibge 
    ORDER BY ano DESC LIMIT 1
) i ON TRUE;

-- View: Resumo social por município (último ano disponível)
CREATE OR REPLACE VIEW vw_resumo_social AS
SELECT 
    e.codigo_ibge,
    e.nome,
    e.populacao,
    edu.ano,
    edu.ideb_anos_iniciais,
    edu.ideb_anos_finais,
    sau.leitos_por_1000_hab,
    sau.cobertura_esf,
    idh.idhm,
    idh.gini,
    idh.taxa_pobreza
FROM entidades_territoriais e
LEFT JOIN LATERAL (
    SELECT * FROM dados_educacao 
    WHERE codigo_ibge = e.codigo_ibge 
    ORDER BY ano DESC LIMIT 1
) edu ON TRUE
LEFT JOIN LATERAL (
    SELECT * FROM dados_saude 
    WHERE codigo_ibge = e.codigo_ibge 
    ORDER BY ano DESC LIMIT 1
) sau ON TRUE
LEFT JOIN LATERAL (
    SELECT * FROM indicadores_desenvolvimento_humano 
    WHERE codigo_ibge = e.codigo_ibge 
    ORDER BY ano DESC LIMIT 1
) idh ON TRUE;

-- View: Resumo ambiental por município (último ano disponível)
CREATE OR REPLACE VIEW vw_resumo_ambiental AS
SELECT 
    e.codigo_ibge,
    e.nome,
    e.area_km2,
    COUNT(DISTINCT fc.id) AS focos_calor_ultimo_ano,
    d.area_desmatada_ha AS desmatamento_ultimo_ano,
    s.cobertura_esgoto,
    s.tratamento_esgoto,
    SUM(eg.emissoes_co2e_t) AS emissoes_totais_ultimo_ano
FROM entidades_territoriais e
LEFT JOIN focos_calor fc ON fc.codigo_ibge = e.codigo_ibge 
    AND fc.data_hora >= CURRENT_DATE - INTERVAL '1 year'
LEFT JOIN LATERAL (
    SELECT * FROM desmatamento_prodes 
    WHERE codigo_ibge = e.codigo_ibge 
    ORDER BY ano DESC LIMIT 1
) d ON TRUE
LEFT JOIN LATERAL (
    SELECT * FROM dados_saneamento 
    WHERE codigo_ibge = e.codigo_ibge 
    ORDER BY ano DESC LIMIT 1
) s ON TRUE
LEFT JOIN LATERAL (
    SELECT codigo_ibge, SUM(emissoes_co2e_t) AS emissoes_co2e_t
    FROM emissoes_gee 
    WHERE codigo_ibge = e.codigo_ibge 
    GROUP BY codigo_ibge
    ORDER BY codigo_ibge DESC LIMIT 1
) eg ON TRUE
GROUP BY e.codigo_ibge, e.nome, e.area_km2, d.area_desmatada_ha, s.cobertura_esgoto, s.tratamento_esgoto, eg.emissoes_co2e_t;

-- View: Dashboard integrado (todas as dimensões)
CREATE OR REPLACE VIEW vw_dashboard_integrado AS
SELECT 
    e.codigo_ibge,
    e.nome,
    e.tipo,
    e.populacao,
    e.area_km2,
    e.densidade_demografica,
    
    -- Econômico
    econ.pib_mil_reais,
    econ.pib_per_capita_reais,
    econ.participacao_agropecuaria,
    
    -- Social
    soc.ideb_anos_iniciais,
    soc.idhm,
    soc.taxa_pobreza,
    
    -- Ambiental
    amb.focos_calor_ultimo_ano,
    amb.desmatamento_ultimo_ano,
    amb.cobertura_esgoto
    
FROM entidades_territoriais e
LEFT JOIN vw_resumo_economico econ ON econ.codigo_ibge = e.codigo_ibge
LEFT JOIN vw_resumo_social soc ON soc.codigo_ibge = e.codigo_ibge
LEFT JOIN vw_resumo_ambiental amb ON amb.codigo_ibge = e.codigo_ibge;

-- ============================================================================
-- FUNÇÕES AUXILIARES
-- ============================================================================

-- Função: Busca semântica de análises similares
CREATE OR REPLACE FUNCTION buscar_analises_similares(
    query_embedding VECTOR(1536),
    limite INTEGER DEFAULT 5,
    tipo_filtro VARCHAR DEFAULT NULL
)
RETURNS TABLE (
    id UUID,
    titulo TEXT,
    tipo_analise VARCHAR,
    codigo_ibge VARCHAR,
    similarity NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        a.id,
        a.titulo,
        a.tipo_analise,
        a.codigo_ibge,
        1 - (a.embedding <=> query_embedding) AS similarity
    FROM analises_geradas a
    WHERE (tipo_filtro IS NULL OR a.tipo_analise = tipo_filtro)
    ORDER BY a.embedding <=> query_embedding
    LIMIT limite;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION buscar_analises_similares IS 'Busca análises similares usando distância coseno de embeddings';

-- Função: Calcular taxa de crescimento do PIB
CREATE OR REPLACE FUNCTION calcular_crescimento_pib(
    p_codigo_ibge VARCHAR,
    p_ano_inicial INTEGER,
    p_ano_final INTEGER
)
RETURNS NUMERIC AS $$
DECLARE
    pib_inicial NUMERIC;
    pib_final NUMERIC;
    crescimento NUMERIC;
BEGIN
    SELECT pib_mil_reais INTO pib_inicial
    FROM dados_economicos
    WHERE codigo_ibge = p_codigo_ibge AND ano = p_ano_inicial;
    
    SELECT pib_mil_reais INTO pib_final
    FROM dados_economicos
    WHERE codigo_ibge = p_codigo_ibge AND ano = p_ano_final;
    
    IF pib_inicial IS NULL OR pib_final IS NULL OR pib_inicial = 0 THEN
        RETURN NULL;
    END IF;
    
    crescimento := ((pib_final - pib_inicial) / pib_inicial) * 100;
    RETURN ROUND(crescimento, 2);
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION calcular_crescimento_pib IS 'Calcula taxa de crescimento percentual do PIB entre dois anos';

-- ============================================================================
-- TRIGGERS PARA ATUALIZAÇÃO AUTOMÁTICA
-- ============================================================================

-- Trigger: Atualizar data_atualizacao automaticamente
CREATE OR REPLACE FUNCTION atualizar_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.data_atualizacao = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_atualizar_entidades
    BEFORE UPDATE ON entidades_territoriais
    FOR EACH ROW
    EXECUTE FUNCTION atualizar_timestamp();

CREATE TRIGGER trigger_atualizar_analises
    BEFORE UPDATE ON analises_geradas
    FOR EACH ROW
    EXECUTE FUNCTION atualizar_timestamp();

-- ============================================================================
-- GRANTS E PERMISSÕES
-- ============================================================================

-- Criar role para aplicação (ajustar conforme necessário)
-- CREATE ROLE framework_v6_app WITH LOGIN PASSWORD 'senha_segura_aqui';

-- Conceder permissões de leitura e escrita
-- GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO framework_v6_app;
-- GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO framework_v6_app;
-- GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO framework_v6_app;

-- ============================================================================
-- SCRIPT DE VERIFICAÇÃO
-- ============================================================================

-- Verificar extensões instaladas
SELECT * FROM pg_extension WHERE extname IN ('uuid-ossp', 'postgis', 'vector');

-- Contar tabelas criadas
SELECT COUNT(*) AS total_tabelas FROM information_schema.tables 
WHERE table_schema = 'public' AND table_type = 'BASE TABLE';

-- Listar todas as tabelas
SELECT table_name FROM information_schema.tables 
WHERE table_schema = 'public' AND table_type = 'BASE TABLE'
ORDER BY table_name;

-- Verificar índices criados
SELECT tablename, indexname FROM pg_indexes 
WHERE schemaname = 'public'
ORDER BY tablename, indexname;

-- ============================================================================
-- FIM DO SCHEMA
-- ============================================================================

-- Este schema SQL completo está pronto para execução no PostgreSQL 14+
-- com extensões PostGIS 3.3+ e pgvector 0.5+
--
-- Para executar:
-- psql -U postgres -d framework_v6 -f SCHEMA_COMPLETO_40_TABELAS_POSTGRESQL.sql
--
-- Versão: 1.0
-- Data: 07 de Novembro de 2025
-- Autores: Henrique Ribeiro & Manus IA
