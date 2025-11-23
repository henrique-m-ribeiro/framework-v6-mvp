-- Script de Inserção de Territórios com Coordenadas Geográficas
-- Gerado em: 2025-11-23 15:05:26
-- Total de territórios: 140
--
-- APIs utilizadas:
-- - IBGE Localidades: Dados básicos
-- - Nominatim (OpenStreetMap): Coordenadas geográficas
--

BEGIN;

-- Estado do Tocantins
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '17',
    'Tocantins',
    'Estado',
    NULL,
    '{"regiao": "Norte", "codigo_ibge": "17"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.3336423, -10.1837852), 4326)
);

-- Municípios do Tocantins
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1700251',
    'Abreulândia',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1700251"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.1558343, -9.6221526), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1700301',
    'Aguiarnópolis',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1700301"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.4721189, -6.5600452), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1700350',
    'Aliança do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1700350"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.9409096, -11.3055927), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1700400',
    'Almas',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1700400"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.1702803, -11.5681309), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1700707',
    'Alvorada',
    'Município',
    '17',
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1700707"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.124926, -12.478465), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1701002',
    'Ananás',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1701002"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.080238, -6.3663053), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1701051',
    'Angico',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1701051"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.8656722, -6.3893733), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1701101',
    'Aparecida do Rio Negro',
    'Município',
    '17',
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1701101"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.9773786, -9.9513491), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1701309',
    'Aragominas',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1701309"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.525488, -7.1654101), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1701903',
    'Araguacema',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1701903"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.5560969, -8.8067391), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1702000',
    'Araguaçu',
    'Município',
    '17',
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1702000"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.823134, -12.928934), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1702109',
    'Araguaína',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1702109"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.2018597, -7.193241), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1702158',
    'Araguanã',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1702158"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.6428482, -6.5799107), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1702208',
    'Araguatins',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1702208"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.1161923, -5.6529384), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1702307',
    'Arapoema',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1702307"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.0641484, -7.6575001), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1702406',
    'Arraias',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1702406"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-46.9437231, -12.9287788), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1702554',
    'Augustinópolis',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1702554"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.8897519, -5.4662267), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1702703',
    'Aurora do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1702703"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-46.407604, -12.71045), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1702901',
    'Axixá do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1702901"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.77007, -5.612747), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1703008',
    'Babaçulândia',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703008"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.761613, -7.2034355), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1703057',
    'Bandeirantes do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703057"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.579148, -7.7635698), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1703073',
    'Barra do Ouro',
    'Município',
    '17',
    '{"microrregiao": "Jalapão", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1703073"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.6743925, -7.7113784), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1703107',
    'Barrolândia',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703107"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.7264346, -9.837246), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1703206',
    'Bernardo Sayão',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703206"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.8968905, -7.8794244), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1703305',
    'Bom Jesus do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1703305"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.165043, -8.96306), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1703602',
    'Brasilândia do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703602"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.4842729, -8.3886619), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1703701',
    'Brejinho de Nazaré',
    'Município',
    '17',
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703701"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.564626, -11.0138265), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1703800',
    'Buriti do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703800"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.2256609, -5.3187439), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1703826',
    'Cachoeirinha',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703826"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.9208885, -6.118647), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1703842',
    'Campos Lindos',
    'Município',
    '17',
    '{"microrregiao": "Jalapão", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1703842"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-46.8023881, -7.9740597), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1703867',
    'Cariri do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703867"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.1604216, -11.8882727), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1703883',
    'Carmolândia',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703883"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.3951295, -7.033804), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1703891',
    'Carrasco Bonito',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703891"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.0376667, -5.3205734), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1703909',
    'Caseara',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1703909"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.9576837, -9.273159), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1704105',
    'Centenário',
    'Município',
    '17',
    '{"microrregiao": "Jalapão", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1704105"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.3355181, -8.9586893), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1704600',
    'Chapada de Areia',
    'Município',
    '17',
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1704600"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.1781853, -10.1417377), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1705102',
    'Chapada da Natividade',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1705102"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.7538517, -11.6119239), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1705508',
    'Colinas do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1705508"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.4716768, -8.0612688), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1705557',
    'Combinado',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1705557"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-46.5461041, -12.8136581), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1705607',
    'Conceição do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1705607"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.295103, -12.220874), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1706001',
    'Couto Magalhães',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1706001"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.1773955, -8.360583), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1706100',
    'Cristalândia',
    'Município',
    '17',
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1706100"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.194202, -10.59848), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1706258',
    'Crixás do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1706258"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.918827, -11.1039404), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1706506',
    'Darcinópolis',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1706506"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.7524283, -6.7085964), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1707009',
    'Dianópolis',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1707009"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-46.819787, -11.624008), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1707108',
    'Divinópolis do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1707108"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.2143531, -9.8015722), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1707207',
    'Dois Irmãos do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1707207"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.0665558, -9.2539897), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1707306',
    'Dueré',
    'Município',
    '17',
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1707306"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.271566, -11.341631), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1707405',
    'Esperantina',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1707405"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.5368181, -5.3658232), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1707553',
    'Fátima',
    'Município',
    '17',
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1707553"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.9031328, -10.7575656), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1707652',
    'Figueirópolis',
    'Município',
    '17',
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1707652"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.1737141, -12.1347916), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1707702',
    'Filadélfia',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1707702"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.496372, -7.3395833), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1708205',
    'Formoso do Araguaia',
    'Município',
    '17',
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1708205"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.5257153, -11.8059989), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1708254',
    'Tabocão',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1708254"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.5216745, -9.0565211), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1708304',
    'Goianorte',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1708304"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.9340879, -8.7720092), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1709005',
    'Goiatins',
    'Município',
    '17',
    '{"microrregiao": "Jalapão", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1709005"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.3154841, -7.7132054), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1709302',
    'Guaraí',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1709302"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.511432, -8.835429), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1709500',
    'Gurupi',
    'Município',
    '17',
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1709500"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.068046, -11.72794), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1709807',
    'Ipueiras',
    'Município',
    '17',
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1709807"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.4438878, -11.2408008), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1710508',
    'Itacajá',
    'Município',
    '17',
    '{"microrregiao": "Jalapão", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1710508"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.772615, -8.392935), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1710706',
    'Itaguatins',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1710706"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.4815382, -5.7696766), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1710904',
    'Itapiratins',
    'Município',
    '17',
    '{"microrregiao": "Jalapão", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1710904"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.1054968, -8.3832116), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1711100',
    'Itaporã do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1711100"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.689481, -8.571722), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1711506',
    'Jaú do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1711506"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.5922532, -12.6526649), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1711803',
    'Juarina',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1711803"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.0967459, -8.1194209), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1711902',
    'Lagoa da Confusão',
    'Município',
    '17',
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1711902"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.6224431, -10.7883045), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1711951',
    'Lagoa do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Jalapão", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1711951"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.566253, -10.2967881), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1712009',
    'Lajeado',
    'Município',
    '17',
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1712009"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.3563706, -9.7548945), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1712157',
    'Lavandeira',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1712157"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-46.5073198, -12.7887924), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1712405',
    'Lizarda',
    'Município',
    '17',
    '{"microrregiao": "Jalapão", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1712405"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-46.675218, -9.5955336), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1712454',
    'Luzinópolis',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1712454"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.8562036, -6.1918183), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1712504',
    'Marianópolis do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1712504"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.6547174, -9.7962503), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1712702',
    'Mateiros',
    'Município',
    '17',
    '{"microrregiao": "Jalapão", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1712702"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-46.417423, -10.5462254), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1712801',
    'Maurilândia do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1712801"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.512492, -5.951688), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1713205',
    'Miracema do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1713205"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.3966536, -9.5617939), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1713304',
    'Miranorte',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1713304"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.592222, -9.529068), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1713601',
    'Monte do Carmo',
    'Município',
    '17',
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1713601"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.1121813, -10.7647456), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1713700',
    'Monte Santo do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1713700"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.9927531, -10.0051944), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1713809',
    'Palmeiras do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1713809"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.546399, -6.6096035), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1713957',
    'Muricilândia',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1713957"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.609135, -7.14669), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1714203',
    'Natividade',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1714203"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.7284165, -11.7089881), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1714302',
    'Nazaré',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1714302"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.6632702, -6.3733313), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1714880',
    'Nova Olinda',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1714880"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.425232, -7.631712), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1715002',
    'Nova Rosalândia',
    'Município',
    '17',
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1715002"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.912477, -10.565102), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1715101',
    'Novo Acordo',
    'Município',
    '17',
    '{"microrregiao": "Jalapão", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1715101"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.6762804, -9.964658), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1715150',
    'Novo Alegre',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1715150"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-46.5740939, -12.915134), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1715259',
    'Novo Jardim',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1715259"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-46.6254107, -11.8199253), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1715507',
    'Oliveira de Fátima',
    'Município',
    '17',
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1715507"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.9077446, -10.7091365), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1715705',
    'Palmeirante',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1715705"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.9264382, -7.8582335), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1715754',
    'Palmeirópolis',
    'Município',
    '17',
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1715754"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.4065223, -13.0428105), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1716109',
    'Paraíso do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1716109"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.886759, -10.1752474), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1716208',
    'Paranã',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1716208"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.873378, -12.616747), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1716307',
    'Pau D''Arco',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1716307"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.3686216, -7.5416832), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1716505',
    'Pedro Afonso',
    'Município',
    '17',
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1716505"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.1733282, -8.9757351), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1716604',
    'Peixe',
    'Município',
    '17',
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1716604"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.5392455, -12.0390993), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1716653',
    'Pequizeiro',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1716653"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.9332775, -8.594846), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1716703',
    'Colméia',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1716703"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.7510897, -8.734098), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1717008',
    'Pindorama do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1717008"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.57263, -11.131074), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1717206',
    'Piraquê',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1717206"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.2945507, -6.769831), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1717503',
    'Pium',
    'Município',
    '17',
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1717503"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.1747741, -10.4421368), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1717800',
    'Ponte Alta do Bom Jesus',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1717800"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-46.4785732, -12.0873615), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1717909',
    'Ponte Alta do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Jalapão", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1717909"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.5374479, -10.7454591), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718006',
    'Porto Alegre do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1718006"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.052627, -11.6070802), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718204',
    'Porto Nacional',
    'Município',
    '17',
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1718204"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.4110952, -10.7019786), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718303',
    'Praia Norte',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718303"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.811144, -5.392812), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718402',
    'Presidente Kennedy',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718402"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.5060747, -8.5340643), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718451',
    'Pugmil',
    'Município',
    '17',
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718451"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.8969824, -10.4255161), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718501',
    'Recursolândia',
    'Município',
    '17',
    '{"microrregiao": "Jalapão", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1718501"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.2416349, -8.7368677), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718550',
    'Riachinho',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718550"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.137969, -6.4426372), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718659',
    'Rio da Conceição',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1718659"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-46.884664, -11.394863), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718709',
    'Rio dos Bois',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718709"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.5349207, -9.3412231), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718758',
    'Rio Sono',
    'Município',
    '17',
    '{"microrregiao": "Jalapão", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1718758"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.8998831, -9.3442508), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718808',
    'Sampaio',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718808"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.878184, -5.354233), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718840',
    'Sandolândia',
    'Município',
    '17',
    '{"microrregiao": "Rio Formoso", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718840"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.9285958, -12.5389465), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718865',
    'Santa Fé do Araguaia',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718865"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.6925943, -7.150072), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718881',
    'Santa Maria do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1718881"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.7482956, -8.7752144), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718899',
    'Santa Rita do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1718899"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.9082979, -10.8643623), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1718907',
    'Santa Rosa do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1718907"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.121627, -11.447392), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1719004',
    'Santa Tereza do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Jalapão", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1719004"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.8091871, -10.2816205), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1720002',
    'Santa Terezinha do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720002"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.673061, -6.4356048), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1720101',
    'São Bento do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720101"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.900057, -6.021853), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1720150',
    'São Félix do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Jalapão", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1720150"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-46.661786, -10.161465), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1720200',
    'São Miguel do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720200"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.5747649, -5.5549817), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1720259',
    'São Salvador do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720259"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.2352148, -12.7503331), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1720309',
    'São Sebastião do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720309"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.2055574, -5.2587094), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1720499',
    'São Valério',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1720499"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.235315, -11.974315), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1720655',
    'Silvanópolis',
    'Município',
    '17',
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1720655"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.1711295, -11.1513516), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1720804',
    'Sítio Novo do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720804"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.6349901, -5.6028662), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1720853',
    'Sucupira',
    'Município',
    '17',
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720853"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.9113689, -11.9850885), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1720903',
    'Taguatinga',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1720903"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-46.4365769, -12.402404), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1720937',
    'Taipas do Tocantins',
    'Município',
    '17',
    '{"microrregiao": "Dianópolis", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1720937"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-46.9918003, -12.193349), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1720978',
    'Talismã',
    'Município',
    '17',
    '{"microrregiao": "Gurupi", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1720978"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-49.0929839, -12.797836), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1721000',
    'Palmas',
    'Município',
    '17',
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1721000"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.3336423, -10.1837852), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1721109',
    'Tocantínia',
    'Município',
    '17',
    '{"microrregiao": "Porto Nacional", "mesorregiao": "Oriental do Tocantins", "uf": "TO", "codigo_ibge": "1721109"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.374104, -9.563198), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1721208',
    'Tocantinópolis',
    'Município',
    '17',
    '{"microrregiao": "Bico do Papagaio", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1721208"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.4217673, -6.3280931), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1721257',
    'Tupirama',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1721257"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.1887392, -8.9746528), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1721307',
    'Tupiratins',
    'Município',
    '17',
    '{"microrregiao": "Miracema do Tocantins", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1721307"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.1299635, -8.3996247), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1722081',
    'Wanderlândia',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1722081"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-47.9653917, -6.8522727), 4326)
);
INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '1722107',
    'Xambioá',
    'Município',
    '17',
    '{"microrregiao": "Araguaína", "mesorregiao": "Ocidental do Tocantins", "uf": "TO", "codigo_ibge": "1722107"}'::jsonb,
    ST_SetSRID(ST_MakePoint(-48.5336069, -6.4084693), 4326)
);

COMMIT;

-- Verificar inserção
SELECT type, COUNT(*) as total FROM territories GROUP BY type;
SELECT COUNT(*) as total_com_coordenadas FROM territories WHERE coordinates IS NOT NULL;
