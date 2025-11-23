-- SQL INSERTs para popular a tabela territories
-- Gerado automaticamente em: 2025-11-22 17:16:15
-- Total de territórios: 140 (1 estado + 139 municípios)
-- Fonte: IBGE Localidades API

-- Iniciar transação
BEGIN;

-- Estado do Tocantins
INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '17',  -- id (código IBGE)
    'Tocantins',  -- name
    'estado',  -- type
    NULL,  -- parent_id
    NULL,  -- area
    '{"regiao": "Norte", "codigo_ibge": "17"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

-- Municípios do Tocantins
INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1700251',  -- id (código IBGE)
    'Abreulândia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1700251"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1700301',  -- id (código IBGE)
    'Aguiarnópolis',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1700301"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1700350',  -- id (código IBGE)
    'Aliança do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1700350"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1700400',  -- id (código IBGE)
    'Almas',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1700400"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1700707',  -- id (código IBGE)
    'Alvorada',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1700707"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1701002',  -- id (código IBGE)
    'Ananás',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1701002"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1701051',  -- id (código IBGE)
    'Angico',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1701051"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1701101',  -- id (código IBGE)
    'Aparecida do Rio Negro',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1701101"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1701309',  -- id (código IBGE)
    'Aragominas',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1701309"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1701903',  -- id (código IBGE)
    'Araguacema',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1701903"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1702000',  -- id (código IBGE)
    'Araguaçu',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1702000"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1702109',  -- id (código IBGE)
    'Araguaína',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1702109"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1702158',  -- id (código IBGE)
    'Araguanã',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1702158"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1702208',  -- id (código IBGE)
    'Araguatins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1702208"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1702307',  -- id (código IBGE)
    'Arapoema',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1702307"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1702406',  -- id (código IBGE)
    'Arraias',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1702406"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1702554',  -- id (código IBGE)
    'Augustinópolis',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1702554"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1702703',  -- id (código IBGE)
    'Aurora do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1702703"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1702901',  -- id (código IBGE)
    'Axixá do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1702901"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1703008',  -- id (código IBGE)
    'Babaçulândia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703008"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1703057',  -- id (código IBGE)
    'Bandeirantes do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703057"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1703073',  -- id (código IBGE)
    'Barra do Ouro',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Jalap\u00e3o", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1703073"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1703107',  -- id (código IBGE)
    'Barrolândia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703107"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1703206',  -- id (código IBGE)
    'Bernardo Sayão',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703206"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1703305',  -- id (código IBGE)
    'Bom Jesus do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1703305"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1703602',  -- id (código IBGE)
    'Brasilândia do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703602"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1703701',  -- id (código IBGE)
    'Brejinho de Nazaré',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703701"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1703800',  -- id (código IBGE)
    'Buriti do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703800"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1703826',  -- id (código IBGE)
    'Cachoeirinha',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703826"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1703842',  -- id (código IBGE)
    'Campos Lindos',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Jalap\u00e3o", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1703842"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1703867',  -- id (código IBGE)
    'Cariri do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703867"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1703883',  -- id (código IBGE)
    'Carmolândia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703883"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1703891',  -- id (código IBGE)
    'Carrasco Bonito',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703891"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1703909',  -- id (código IBGE)
    'Caseara',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703909"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1704105',  -- id (código IBGE)
    'Centenário',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Jalap\u00e3o", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1704105"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1704600',  -- id (código IBGE)
    'Chapada de Areia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1704600"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1705102',  -- id (código IBGE)
    'Chapada da Natividade',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1705102"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1705508',  -- id (código IBGE)
    'Colinas do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1705508"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1705557',  -- id (código IBGE)
    'Combinado',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1705557"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1705607',  -- id (código IBGE)
    'Conceição do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1705607"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1706001',  -- id (código IBGE)
    'Couto Magalhães',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1706001"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1706100',  -- id (código IBGE)
    'Cristalândia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1706100"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1706258',  -- id (código IBGE)
    'Crixás do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1706258"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1706506',  -- id (código IBGE)
    'Darcinópolis',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1706506"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1707009',  -- id (código IBGE)
    'Dianópolis',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1707009"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1707108',  -- id (código IBGE)
    'Divinópolis do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1707108"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1707207',  -- id (código IBGE)
    'Dois Irmãos do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1707207"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1707306',  -- id (código IBGE)
    'Dueré',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1707306"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1707405',  -- id (código IBGE)
    'Esperantina',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1707405"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1707553',  -- id (código IBGE)
    'Fátima',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1707553"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1707652',  -- id (código IBGE)
    'Figueirópolis',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1707652"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1707702',  -- id (código IBGE)
    'Filadélfia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1707702"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1708205',  -- id (código IBGE)
    'Formoso do Araguaia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1708205"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1708254',  -- id (código IBGE)
    'Tabocão',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1708254"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1708304',  -- id (código IBGE)
    'Goianorte',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1708304"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1709005',  -- id (código IBGE)
    'Goiatins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Jalap\u00e3o", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1709005"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1709302',  -- id (código IBGE)
    'Guaraí',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1709302"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1709500',  -- id (código IBGE)
    'Gurupi',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1709500"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1709807',  -- id (código IBGE)
    'Ipueiras',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1709807"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1710508',  -- id (código IBGE)
    'Itacajá',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Jalap\u00e3o", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1710508"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1710706',  -- id (código IBGE)
    'Itaguatins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1710706"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1710904',  -- id (código IBGE)
    'Itapiratins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Jalap\u00e3o", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1710904"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1711100',  -- id (código IBGE)
    'Itaporã do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1711100"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1711506',  -- id (código IBGE)
    'Jaú do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1711506"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1711803',  -- id (código IBGE)
    'Juarina',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1711803"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1711902',  -- id (código IBGE)
    'Lagoa da Confusão',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1711902"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1711951',  -- id (código IBGE)
    'Lagoa do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Jalap\u00e3o", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1711951"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1712009',  -- id (código IBGE)
    'Lajeado',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1712009"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1712157',  -- id (código IBGE)
    'Lavandeira',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1712157"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1712405',  -- id (código IBGE)
    'Lizarda',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Jalap\u00e3o", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1712405"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1712454',  -- id (código IBGE)
    'Luzinópolis',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1712454"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1712504',  -- id (código IBGE)
    'Marianópolis do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1712504"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1712702',  -- id (código IBGE)
    'Mateiros',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Jalap\u00e3o", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1712702"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1712801',  -- id (código IBGE)
    'Maurilândia do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1712801"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1713205',  -- id (código IBGE)
    'Miracema do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1713205"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1713304',  -- id (código IBGE)
    'Miranorte',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1713304"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1713601',  -- id (código IBGE)
    'Monte do Carmo',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1713601"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1713700',  -- id (código IBGE)
    'Monte Santo do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1713700"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1713809',  -- id (código IBGE)
    'Palmeiras do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1713809"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1713957',  -- id (código IBGE)
    'Muricilândia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1713957"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1714203',  -- id (código IBGE)
    'Natividade',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1714203"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1714302',  -- id (código IBGE)
    'Nazaré',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1714302"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1714880',  -- id (código IBGE)
    'Nova Olinda',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1714880"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1715002',  -- id (código IBGE)
    'Nova Rosalândia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1715002"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1715101',  -- id (código IBGE)
    'Novo Acordo',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Jalap\u00e3o", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1715101"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1715150',  -- id (código IBGE)
    'Novo Alegre',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1715150"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1715259',  -- id (código IBGE)
    'Novo Jardim',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1715259"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1715507',  -- id (código IBGE)
    'Oliveira de Fátima',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1715507"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1715705',  -- id (código IBGE)
    'Palmeirante',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1715705"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1715754',  -- id (código IBGE)
    'Palmeirópolis',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1715754"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1716109',  -- id (código IBGE)
    'Paraíso do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1716109"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1716208',  -- id (código IBGE)
    'Paranã',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1716208"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1716307',  -- id (código IBGE)
    'Pau D''Arco',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1716307"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1716505',  -- id (código IBGE)
    'Pedro Afonso',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1716505"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1716604',  -- id (código IBGE)
    'Peixe',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1716604"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1716653',  -- id (código IBGE)
    'Pequizeiro',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1716653"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1716703',  -- id (código IBGE)
    'Colméia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1716703"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1717008',  -- id (código IBGE)
    'Pindorama do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1717008"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1717206',  -- id (código IBGE)
    'Piraquê',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1717206"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1717503',  -- id (código IBGE)
    'Pium',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1717503"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1717800',  -- id (código IBGE)
    'Ponte Alta do Bom Jesus',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1717800"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1717909',  -- id (código IBGE)
    'Ponte Alta do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Jalap\u00e3o", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1717909"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718006',  -- id (código IBGE)
    'Porto Alegre do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1718006"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718204',  -- id (código IBGE)
    'Porto Nacional',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1718204"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718303',  -- id (código IBGE)
    'Praia Norte',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718303"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718402',  -- id (código IBGE)
    'Presidente Kennedy',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718402"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718451',  -- id (código IBGE)
    'Pugmil',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718451"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718501',  -- id (código IBGE)
    'Recursolândia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Jalap\u00e3o", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1718501"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718550',  -- id (código IBGE)
    'Riachinho',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718550"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718659',  -- id (código IBGE)
    'Rio da Conceição',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1718659"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718709',  -- id (código IBGE)
    'Rio dos Bois',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718709"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718758',  -- id (código IBGE)
    'Rio Sono',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Jalap\u00e3o", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1718758"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718808',  -- id (código IBGE)
    'Sampaio',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718808"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718840',  -- id (código IBGE)
    'Sandolândia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718840"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718865',  -- id (código IBGE)
    'Santa Fé do Araguaia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718865"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718881',  -- id (código IBGE)
    'Santa Maria do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1718881"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718899',  -- id (código IBGE)
    'Santa Rita do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718899"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1718907',  -- id (código IBGE)
    'Santa Rosa do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1718907"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1719004',  -- id (código IBGE)
    'Santa Tereza do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Jalap\u00e3o", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1719004"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1720002',  -- id (código IBGE)
    'Santa Terezinha do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720002"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1720101',  -- id (código IBGE)
    'São Bento do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720101"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1720150',  -- id (código IBGE)
    'São Félix do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Jalap\u00e3o", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1720150"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1720200',  -- id (código IBGE)
    'São Miguel do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720200"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1720259',  -- id (código IBGE)
    'São Salvador do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720259"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1720309',  -- id (código IBGE)
    'São Sebastião do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720309"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1720499',  -- id (código IBGE)
    'São Valério',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1720499"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1720655',  -- id (código IBGE)
    'Silvanópolis',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1720655"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1720804',  -- id (código IBGE)
    'Sítio Novo do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720804"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1720853',  -- id (código IBGE)
    'Sucupira',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720853"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1720903',  -- id (código IBGE)
    'Taguatinga',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1720903"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1720937',  -- id (código IBGE)
    'Taipas do Tocantins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Dian\u00f3polis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1720937"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1720978',  -- id (código IBGE)
    'Talismã',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720978"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1721000',  -- id (código IBGE)
    'Palmas',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1721000"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1721109',  -- id (código IBGE)
    'Tocantínia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1721109"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1721208',  -- id (código IBGE)
    'Tocantinópolis',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1721208"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1721257',  -- id (código IBGE)
    'Tupirama',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1721257"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1721307',  -- id (código IBGE)
    'Tupiratins',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1721307"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1722081',  -- id (código IBGE)
    'Wanderlândia',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1722081"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '1722107',  -- id (código IBGE)
    'Xambioá',  -- name
    'municipio',  -- type
    '17',  -- parent_id
    NULL,  -- area
    '{"microrregiao": "Aragua\u00edna", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1722107"}'::jsonb,  -- metadata
    NULL  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;

-- Finalizar transação
COMMIT;
