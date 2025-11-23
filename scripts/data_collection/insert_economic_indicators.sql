-- SQL INSERTs para popular a tabela economic_indicators
-- Gerado automaticamente em: 2025-11-23 16:36:04
-- Total de registros: 140 territórios × 5 anos = 700 registros
-- Dados: Sintéticos mas realistas (baseados em padrões reais)

BEGIN;

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '19be0f53-9360-4b0e-9842-b1b8d76c4081',
    '17',
    2019,
    50371.91,
    32794.98,
    63.6,
    9514694792.49,
    '{"agricultura": 22.2, "industria": 15.3, "servicos": 62.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a46e6a7e-b783-49ef-843c-8fa51988cf1c',
    '17',
    2020,
    44660.8,
    27633.78,
    67.9,
    8435929814.65,
    '{"agricultura": 11.2, "industria": 33.8, "servicos": 55.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd483e7e1-7de5-4009-8917-ed365b183861',
    '17',
    2021,
    43999.1,
    27440.34,
    56.6,
    8310941787.85,
    '{"agricultura": 24.0, "industria": 26.1, "servicos": 49.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'dcba5e23-b9e6-445e-b5a0-7d1a6e3639db',
    '17',
    2022,
    55839.74,
    34114.25,
    63.0,
    10547506787.55,
    '{"agricultura": 23.8, "industria": 28.9, "servicos": 47.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0f6c3b2b-9303-4e0a-91a4-02de27325a55',
    '17',
    2023,
    50171.68,
    31032.7,
    63.6,
    9476873830.49,
    '{"agricultura": 14.9, "industria": 34.5, "servicos": 50.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '26e4de06-ef55-4f01-9880-242e797cd52b',
    '1700251',
    2019,
    277.86,
    27484.03,
    59.7,
    38900892.13,
    '{"agricultura": 8.0, "industria": 16.8, "servicos": 75.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7fed3a79-c3b9-45cb-a5f9-f32316cf0ac4',
    '1700251',
    2020,
    275.92,
    26628.13,
    65.8,
    38628893.16,
    '{"agricultura": 16.6, "industria": 33.5, "servicos": 49.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '80c3a7e9-94bd-46ec-bbb2-7b51b2bd6018',
    '1700251',
    2021,
    295.66,
    30454.93,
    64.2,
    41391904.32,
    '{"agricultura": 15.1, "industria": 20.9, "servicos": 64.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9791a201-970a-4e1f-bec4-446205ff9cbd',
    '1700251',
    2022,
    300.15,
    29644.69,
    67.8,
    42021352.6,
    '{"agricultura": 7.8, "industria": 32.0, "servicos": 60.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '42dd2b13-e42e-4eee-b809-fc6df7050977',
    '1700251',
    2023,
    296.08,
    28400.71,
    67.5,
    41450840.12,
    '{"agricultura": 15.5, "industria": 31.6, "servicos": 52.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9ee628e9-d70e-4351-9c7a-7c480bbf4c8d',
    '1700301',
    2019,
    275.58,
    27230.89,
    69.8,
    38580728.62,
    '{"agricultura": 16.7, "industria": 29.0, "servicos": 54.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '05b0107c-e219-4a09-b679-af3f1b753cf2',
    '1700301',
    2020,
    273.96,
    28281.28,
    62.9,
    38354508.84,
    '{"agricultura": 22.5, "industria": 24.4, "servicos": 53.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8fa4df5c-f6ef-4df5-9540-1d96db87b030',
    '1700301',
    2021,
    276.06,
    28143.73,
    59.1,
    38648657.43,
    '{"agricultura": 14.2, "industria": 18.4, "servicos": 67.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1907252e-1e06-494c-adf5-06a9bfe5aa2d',
    '1700301',
    2022,
    279.91,
    26728.9,
    66.9,
    39186702.53,
    '{"agricultura": 21.3, "industria": 25.4, "servicos": 53.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4f35e385-5be3-4404-80c1-12bc39a79df4',
    '1700301',
    2023,
    309.79,
    31213.52,
    68.7,
    43371182.21,
    '{"agricultura": 11.8, "industria": 33.8, "servicos": 54.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4fcaa131-19d7-4c06-b316-e322c0aa3b66',
    '1700350',
    2019,
    225.24,
    22892.33,
    63.8,
    31533269.49,
    '{"agricultura": 11.6, "industria": 17.4, "servicos": 70.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '357f1d28-1d67-43e3-b1fc-a4a9ab472491',
    '1700350',
    2020,
    269.84,
    26543.57,
    62.2,
    37777874.72,
    '{"agricultura": 17.6, "industria": 28.2, "servicos": 54.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'fadac19a-ebb7-48f1-bdb4-1e0a85f72c6a',
    '1700350',
    2021,
    260.08,
    24966.93,
    68.3,
    36411271.05,
    '{"agricultura": 13.4, "industria": 31.0, "servicos": 55.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ad6cfd2f-4e24-423b-acca-933e21c4d70f',
    '1700350',
    2022,
    298.28,
    30983.33,
    66.1,
    41758709.52,
    '{"agricultura": 7.9, "industria": 15.5, "servicos": 76.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '69ac4a2e-2665-4155-a117-09b4ef81cdba',
    '1700350',
    2023,
    254.66,
    26455.85,
    63.4,
    35652966.42,
    '{"agricultura": 17.7, "industria": 29.7, "servicos": 52.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8d244a27-3fe9-4803-a67b-6ef7331a4015',
    '1700400',
    2019,
    1874.05,
    27007.91,
    62.7,
    187405184.49,
    '{"agricultura": 7.7, "industria": 33.4, "servicos": 58.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '36d5a4ee-b47a-4ed5-8d33-0c0128f2e96e',
    '1700400',
    2020,
    2233.81,
    31116.81,
    59.9,
    223381353.41,
    '{"agricultura": 21.6, "industria": 17.4, "servicos": 61.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '93418b91-2468-4283-8492-baeff24772b4',
    '1700400',
    2021,
    2131.76,
    30571.62,
    67.5,
    213175931.34,
    '{"agricultura": 17.4, "industria": 33.5, "servicos": 49.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4f6e256c-267c-427a-9ca7-1d180e81b1b6',
    '1700400',
    2022,
    2218.12,
    30680.72,
    64.3,
    221812436.76,
    '{"agricultura": 9.7, "industria": 28.1, "servicos": 62.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '80c1c241-501c-42da-9596-757d575b7748',
    '1700400',
    2023,
    2157.57,
    32323.18,
    66.5,
    215757204.36,
    '{"agricultura": 24.4, "industria": 31.3, "servicos": 44.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'bf3915a8-c321-4bfd-8746-5cbd016ed65e',
    '1700707',
    2019,
    268.62,
    28258.3,
    65.4,
    37607277.95,
    '{"agricultura": 21.6, "industria": 27.0, "servicos": 51.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b62b1c37-d920-462b-82e6-571c652906a9',
    '1700707',
    2020,
    265.62,
    27915.67,
    59.9,
    37186464.41,
    '{"agricultura": 22.0, "industria": 19.7, "servicos": 58.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'de79f575-7e86-4552-89f4-1f6ff3102d82',
    '1700707',
    2021,
    253.6,
    24384.23,
    58.3,
    35503441.38,
    '{"agricultura": 16.1, "industria": 28.0, "servicos": 55.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b3dc1b03-cc9e-47b3-978a-19b44a969540',
    '1700707',
    2022,
    247.72,
    23778.27,
    68.8,
    34681088.95,
    '{"agricultura": 13.9, "industria": 19.8, "servicos": 66.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ac91edec-e8b1-42ce-a84e-b60472dd44f3',
    '1700707',
    2023,
    310.67,
    32667.88,
    68.9,
    43494014.34,
    '{"agricultura": 12.5, "industria": 28.7, "servicos": 58.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '989af4c3-531c-4e31-a450-fc5962adb5ec',
    '1701002',
    2019,
    642.56,
    22219.43,
    62.8,
    85675170.88,
    '{"agricultura": 13.1, "industria": 30.3, "servicos": 56.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f95d1d2c-ed3c-47e9-9283-4b45e3f6b93b',
    '1701002',
    2020,
    566.1,
    19401.58,
    55.2,
    75479892.17,
    '{"agricultura": 13.3, "industria": 28.2, "servicos": 58.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '058a4e5f-599c-43b4-85e9-da6b6f1b5e79',
    '1701002',
    2021,
    670.54,
    21548.28,
    57.5,
    89405242.52,
    '{"agricultura": 7.1, "industria": 15.3, "servicos": 77.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7a30e60f-004a-4bf7-8e1f-ab093ac49256',
    '1701002',
    2022,
    649.04,
    21154.31,
    58.5,
    86538048.27,
    '{"agricultura": 23.6, "industria": 21.4, "servicos": 55.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '033b84c5-8e7a-4e61-90d5-8ed48a18ee53',
    '1701002',
    2023,
    662.59,
    22248.81,
    67.7,
    88345577.39,
    '{"agricultura": 7.2, "industria": 18.7, "servicos": 74.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '49392db3-4471-4637-80af-9f9d823c65e4',
    '1701051',
    2019,
    674.28,
    22998.05,
    57.8,
    89903977.55,
    '{"agricultura": 22.5, "industria": 17.2, "servicos": 60.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '921511b9-8126-423a-9c23-7f35cb9de381',
    '1701051',
    2020,
    642.26,
    21465.26,
    57.9,
    85634952.54,
    '{"agricultura": 24.8, "industria": 15.8, "servicos": 59.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '936922b4-9c0c-4a87-9e75-551a131056c3',
    '1701051',
    2021,
    610.42,
    20282.33,
    66.3,
    81388923.49,
    '{"agricultura": 17.3, "industria": 26.9, "servicos": 55.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c6a31cf9-6b80-4c4a-81c6-5a8d69069802',
    '1701051',
    2022,
    626.4,
    20401.25,
    64.0,
    83519996.35,
    '{"agricultura": 22.7, "industria": 34.6, "servicos": 42.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '74bef0db-a617-43d8-8f54-f8021b013af2',
    '1701051',
    2023,
    764.05,
    25037.53,
    63.7,
    101872700.57,
    '{"agricultura": 5.5, "industria": 32.2, "servicos": 62.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '36ddc7ad-3a46-4a24-a298-98132b1da71b',
    '1701101',
    2019,
    596.51,
    19705.73,
    58.1,
    79534964.33,
    '{"agricultura": 21.9, "industria": 33.6, "servicos": 44.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '729c347e-21d9-4011-808a-efa736a2cb87',
    '1701101',
    2020,
    709.94,
    22813.72,
    55.9,
    94658705.02,
    '{"agricultura": 17.7, "industria": 18.8, "servicos": 63.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9e223814-153e-4a90-9ffb-304bdf43440c',
    '1701101',
    2021,
    579.16,
    18982.0,
    55.5,
    77221290.3,
    '{"agricultura": 15.6, "industria": 19.9, "servicos": 64.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f960191e-74cf-4747-a487-ba75ef259c87',
    '1701101',
    2022,
    695.49,
    23638.32,
    57.3,
    92731552.62,
    '{"agricultura": 7.7, "industria": 27.9, "servicos": 64.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '30dcb1e7-b126-4f43-a1b6-e105c4a2d114',
    '1701101',
    2023,
    746.28,
    24619.08,
    55.0,
    99503737.27,
    '{"agricultura": 21.5, "industria": 32.7, "servicos": 45.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2c13c62e-7a73-420f-bdb5-eed2db0a3ed5',
    '1701309',
    2019,
    239.29,
    23881.54,
    60.6,
    33501022.47,
    '{"agricultura": 6.0, "industria": 29.5, "servicos": 64.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7d3a96ef-a2cc-4fed-8182-e27bf51ca780',
    '1701309',
    2020,
    285.48,
    27764.61,
    64.2,
    39966603.24,
    '{"agricultura": 10.5, "industria": 17.2, "servicos": 72.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a159c301-4bfa-4847-8e0a-3206499e93f6',
    '1701309',
    2021,
    263.44,
    27450.17,
    67.9,
    36881498.02,
    '{"agricultura": 5.7, "industria": 24.1, "servicos": 70.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c4a617cd-b734-450b-a017-249024795f39',
    '1701309',
    2022,
    301.45,
    29522.52,
    57.8,
    42203616.41,
    '{"agricultura": 14.5, "industria": 28.0, "servicos": 57.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2c7fc6f9-2eb3-4455-953c-8b30a3c5e821',
    '1701309',
    2023,
    256.34,
    26549.95,
    57.7,
    35887567.46,
    '{"agricultura": 20.8, "industria": 27.2, "servicos": 52.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2f87be09-9552-4492-9e54-fdfbaa77a426',
    '1701903',
    2019,
    2035.61,
    28837.09,
    67.0,
    203561048.14,
    '{"agricultura": 18.3, "industria": 27.5, "servicos": 54.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '691e0007-d159-4aab-bae4-8f0d6e0d29d1',
    '1701903',
    2020,
    1918.47,
    27295.98,
    66.5,
    191847034.15,
    '{"agricultura": 9.7, "industria": 33.4, "servicos": 56.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c9ec37cf-be18-482f-ae03-a84a8a5c9d70',
    '1701903',
    2021,
    2257.39,
    31093.91,
    58.0,
    225738675.51,
    '{"agricultura": 8.5, "industria": 34.0, "servicos": 57.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f23294f1-55f5-4cb0-8636-e3fb88bd2525',
    '1701903',
    2022,
    2212.39,
    30316.26,
    64.6,
    221238960.21,
    '{"agricultura": 6.5, "industria": 29.0, "servicos": 64.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '50cc4e1c-71e4-4b67-8c68-7f22b6a14e47',
    '1701903',
    2023,
    2137.03,
    29204.38,
    63.6,
    213703057.2,
    '{"agricultura": 8.5, "industria": 24.1, "servicos": 67.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '42015425-d8c2-4cc7-98b1-263f59800717',
    '1702158',
    2019,
    265.11,
    26426.52,
    65.4,
    37115520.06,
    '{"agricultura": 10.6, "industria": 15.6, "servicos": 73.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7d1f883e-14bb-4824-b4d3-163600e96c57',
    '1702158',
    2020,
    237.11,
    23529.59,
    59.7,
    33195080.25,
    '{"agricultura": 18.0, "industria": 20.8, "servicos": 61.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '057018be-9624-4db1-85ce-11c43195b871',
    '1702158',
    2021,
    287.17,
    27626.15,
    62.1,
    40204333.22,
    '{"agricultura": 17.4, "industria": 24.0, "servicos": 58.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f5842984-dfe0-4c77-8b09-704a3e676d6d',
    '1702158',
    2022,
    245.8,
    24733.22,
    61.6,
    34411819.09,
    '{"agricultura": 16.9, "industria": 33.1, "servicos": 49.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '91d6c221-8d40-4ec2-bb85-e4dac49e2d97',
    '1702158',
    2023,
    318.26,
    33180.1,
    55.7,
    44556887.04,
    '{"agricultura": 13.6, "industria": 28.3, "servicos": 58.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd83e80aa-a785-4fd0-aa94-c53318c508d0',
    '1702208',
    2019,
    634.82,
    20445.68,
    60.5,
    84642400.78,
    '{"agricultura": 20.2, "industria": 15.1, "servicos": 64.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '812c9559-4a08-4757-a57f-aa297c8f1275',
    '1702208',
    2020,
    565.95,
    19298.6,
    57.7,
    75460116.72,
    '{"agricultura": 7.6, "industria": 15.1, "servicos": 77.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '34da229a-55ca-43fe-a40a-101392da311b',
    '1702208',
    2021,
    608.52,
    21142.53,
    67.6,
    81136583.52,
    '{"agricultura": 21.7, "industria": 29.7, "servicos": 48.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd0bba25c-5e5b-44b0-8d9a-00b11d3250ef',
    '1702208',
    2022,
    634.72,
    20307.13,
    58.3,
    84629282.41,
    '{"agricultura": 5.2, "industria": 20.6, "servicos": 74.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0db0be9f-c857-4e9c-aa71-a6dfa64c954f',
    '1702208',
    2023,
    756.6,
    25738.28,
    59.9,
    100880343.43,
    '{"agricultura": 14.1, "industria": 24.4, "servicos": 61.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7b8c4eaf-c907-48fe-afbc-080e2ed75dba',
    '1702000',
    2019,
    244.35,
    23333.36,
    58.3,
    34208568.77,
    '{"agricultura": 7.4, "industria": 16.0, "servicos": 76.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2aa6d55d-988c-42d6-bd16-5fed2d748c3c',
    '1702000',
    2020,
    245.5,
    25533.12,
    68.9,
    34370133.65,
    '{"agricultura": 6.2, "industria": 28.9, "servicos": 64.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ab447aa2-b148-4561-8821-f09fe3560445',
    '1702000',
    2021,
    261.78,
    25348.77,
    67.7,
    36648749.49,
    '{"agricultura": 11.2, "industria": 23.0, "servicos": 65.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '685269e2-a0fd-48d5-b826-7e50fb578cfc',
    '1702000',
    2022,
    252.14,
    24100.55,
    68.5,
    35299590.25,
    '{"agricultura": 13.7, "industria": 21.9, "servicos": 64.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ad3c315e-60b3-4873-9293-1443c5d640cd',
    '1702000',
    2023,
    318.88,
    31522.0,
    64.2,
    44642721.61,
    '{"agricultura": 22.6, "industria": 34.1, "servicos": 43.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd23a2517-c844-4783-ab2f-b2132fb22322',
    '1702109',
    2019,
    4217.31,
    22659.33,
    61.1,
    474447334.1,
    '{"agricultura": 19.6, "industria": 20.3, "servicos": 60.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a5918c5d-b299-4ee0-bb1b-3f4b085840ac',
    '1702109',
    2020,
    4526.09,
    24736.53,
    64.3,
    509185421.47,
    '{"agricultura": 13.0, "industria": 15.2, "servicos": 71.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'af4a214a-5ad0-4c9c-a3e3-bc6576fd5592',
    '1702109',
    2021,
    4439.55,
    24044.08,
    69.1,
    499449022.19,
    '{"agricultura": 6.6, "industria": 18.6, "servicos": 74.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '36d91fb0-41c8-4fa7-a4ed-829674db5f01',
    '1702109',
    2022,
    4952.08,
    27323.3,
    64.0,
    557108512.9,
    '{"agricultura": 9.6, "industria": 17.5, "servicos": 72.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '28c21141-919b-4b9b-b32b-b10fbd3fd05b',
    '1702109',
    2023,
    4535.24,
    25360.35,
    66.0,
    510214834.5,
    '{"agricultura": 10.0, "industria": 17.3, "servicos": 72.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '492cdcf6-f29a-47d6-b480-95559d287a0b',
    '1702307',
    2019,
    274.05,
    27048.06,
    57.2,
    38367136.48,
    '{"agricultura": 9.6, "industria": 23.9, "servicos": 66.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'fa71ad44-6962-4c68-8381-a2a9d0f9ecf5',
    '1702307',
    2020,
    274.3,
    26324.04,
    64.3,
    38401506.36,
    '{"agricultura": 5.2, "industria": 24.1, "servicos": 70.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f7700e80-964a-42c6-9a20-a67fc84c4fd9',
    '1702307',
    2021,
    298.05,
    31350.33,
    58.8,
    41726666.94,
    '{"agricultura": 5.5, "industria": 15.0, "servicos": 79.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ed8e7620-ccfd-4b03-8ffd-b986b60a9320',
    '1702307',
    2022,
    276.0,
    29046.57,
    66.2,
    38640066.29,
    '{"agricultura": 21.4, "industria": 33.2, "servicos": 45.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8ba607b3-4089-42d3-bffe-14ef122eaa89',
    '1702307',
    2023,
    295.57,
    28203.39,
    66.4,
    41380016.56,
    '{"agricultura": 5.6, "industria": 26.0, "servicos": 68.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b7d48bfd-da1d-4ac8-a4ec-e4cad697d237',
    '1702406',
    2019,
    605.91,
    20718.38,
    58.1,
    80787888.85,
    '{"agricultura": 21.2, "industria": 17.6, "servicos": 61.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '870abd81-75d7-4e84-9be2-53be11cd76a4',
    '1702406',
    2020,
    594.15,
    19023.0,
    68.8,
    79219367.73,
    '{"agricultura": 9.6, "industria": 28.2, "servicos": 62.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4bd3cfba-2d4b-44e5-9004-2a37091df285',
    '1702406',
    2021,
    710.22,
    24202.43,
    57.4,
    94696036.43,
    '{"agricultura": 24.6, "industria": 16.6, "servicos": 58.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5387eada-fa6a-4b15-aab5-fd20fb12a88e',
    '1702406',
    2022,
    621.39,
    20211.14,
    68.3,
    82852209.86,
    '{"agricultura": 23.9, "industria": 15.5, "servicos": 60.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b925aab2-53ca-4b7e-8a8e-29bdb5b64eff',
    '1702406',
    2023,
    611.47,
    19581.33,
    63.2,
    81528837.42,
    '{"agricultura": 14.0, "industria": 20.4, "servicos": 65.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f4392f9d-14e7-4bbd-81e8-c87dfa9b5eb4',
    '1702554',
    2019,
    629.44,
    20953.27,
    57.9,
    83924813.73,
    '{"agricultura": 5.9, "industria": 21.4, "servicos": 72.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e20b8f06-3333-4317-94d5-d137fee2de8f',
    '1702554',
    2020,
    664.87,
    21705.19,
    58.6,
    88649780.31,
    '{"agricultura": 10.3, "industria": 35.0, "servicos": 54.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '13e02f0d-57b3-4fbf-a30b-134634060ed4',
    '1702554',
    2021,
    676.74,
    23144.96,
    61.4,
    90231399.75,
    '{"agricultura": 23.4, "industria": 24.2, "servicos": 52.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b3de8f8f-fde0-41ec-9169-93e7393c3079',
    '1702554',
    2022,
    692.47,
    23494.99,
    67.5,
    92329042.03,
    '{"agricultura": 16.4, "industria": 28.4, "servicos": 55.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ab9a7f75-d41a-475b-a94f-2572a577e1c7',
    '1702554',
    2023,
    652.59,
    22486.8,
    69.9,
    87011905.36,
    '{"agricultura": 16.2, "industria": 34.2, "servicos": 49.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd3eecb3d-cdf0-498c-a62d-453f2b50c987',
    '1702703',
    2019,
    260.59,
    25195.06,
    59.8,
    36482957.98,
    '{"agricultura": 10.4, "industria": 27.6, "servicos": 62.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f8617cc6-3cd1-4c77-a7c8-1266b1879632',
    '1702703',
    2020,
    277.37,
    28907.95,
    59.6,
    38832053.97,
    '{"agricultura": 17.7, "industria": 31.4, "servicos": 50.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '75bb061d-51db-44ff-82e0-92d94ef5e483',
    '1702703',
    2021,
    281.39,
    28150.25,
    63.3,
    39394583.84,
    '{"agricultura": 7.5, "industria": 34.1, "servicos": 58.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ab3ff1f9-8941-4944-bf2d-cb86d97fd4ee',
    '1702703',
    2022,
    284.7,
    27296.69,
    63.2,
    39858624.41,
    '{"agricultura": 5.3, "industria": 31.9, "servicos": 62.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd2d4385e-320d-446f-b347-5cedb7e64831',
    '1702703',
    2023,
    315.04,
    30124.67,
    56.4,
    44106137.0,
    '{"agricultura": 10.6, "industria": 29.3, "servicos": 60.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a0bf2bb2-8a38-4ac3-ab58-504eb84f6c16',
    '1702901',
    2019,
    667.57,
    22239.15,
    59.4,
    89009984.86,
    '{"agricultura": 10.1, "industria": 27.6, "servicos": 62.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '763cae05-2a85-41db-94af-925f066929cc',
    '1702901',
    2020,
    615.81,
    21431.54,
    67.8,
    82108510.51,
    '{"agricultura": 10.3, "industria": 33.7, "servicos": 56.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '71e0d0d3-654d-4b9d-b8e4-4fb80dcc82ee',
    '1702901',
    2021,
    681.27,
    23521.29,
    69.2,
    90836083.16,
    '{"agricultura": 12.0, "industria": 29.3, "servicos": 58.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '644794be-9a0d-43db-a893-9e4be5c5c084',
    '1702901',
    2022,
    716.24,
    24896.13,
    64.7,
    95498235.95,
    '{"agricultura": 21.5, "industria": 24.8, "servicos": 53.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '405d715e-1396-4147-bb9d-408afd5a195a',
    '1702901',
    2023,
    668.17,
    23433.93,
    70.0,
    89089540.24,
    '{"agricultura": 20.6, "industria": 24.5, "servicos": 55.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8b535c88-7822-42dd-a784-5003bdc12f97',
    '1703008',
    2019,
    660.18,
    22985.17,
    59.4,
    88023996.97,
    '{"agricultura": 21.6, "industria": 15.5, "servicos": 62.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '26c1cb72-68a6-48f6-b5bf-9e694361a127',
    '1703008',
    2020,
    570.61,
    18588.57,
    58.1,
    76081773.37,
    '{"agricultura": 10.3, "industria": 21.8, "servicos": 67.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '358cac5d-0279-455d-a00b-7b1c9ec164d0',
    '1703008',
    2021,
    644.44,
    22094.99,
    63.4,
    85925956.31,
    '{"agricultura": 20.7, "industria": 23.2, "servicos": 56.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '43d9223c-699b-44a1-a1a8-20f36bfae79e',
    '1703008',
    2022,
    596.36,
    19340.88,
    56.2,
    79514225.32,
    '{"agricultura": 20.9, "industria": 29.2, "servicos": 50.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '90d542f9-f41b-4a91-a2d9-2bff13701750',
    '1703008',
    2023,
    631.97,
    21185.65,
    69.4,
    84262394.43,
    '{"agricultura": 12.1, "industria": 22.4, "servicos": 65.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '97ef0b4c-8a5f-4ff9-9afc-a7c3f3e83bd1',
    '1703057',
    2019,
    1826.39,
    26933.56,
    58.3,
    182639187.7,
    '{"agricultura": 17.1, "industria": 19.6, "servicos": 63.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1b68d6d8-c6d4-4214-bf53-9e8b6b11bc0e',
    '1703057',
    2020,
    2106.18,
    29226.87,
    59.8,
    210617584.16,
    '{"agricultura": 11.0, "industria": 30.7, "servicos": 58.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c83cef49-771e-40cd-b76f-58b3e0b99fb5',
    '1703057',
    2021,
    2390.2,
    35612.42,
    55.2,
    239019857.07,
    '{"agricultura": 18.0, "industria": 15.7, "servicos": 66.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'be457d9a-4e1f-42d7-a95f-4432d1662564',
    '1703057',
    2022,
    1999.34,
    27988.66,
    62.7,
    199934187.22,
    '{"agricultura": 20.8, "industria": 28.0, "servicos": 51.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3856a52a-9937-48ba-89ea-5bf93962e74d',
    '1703057',
    2023,
    2332.1,
    32790.61,
    61.0,
    233210073.55,
    '{"agricultura": 24.9, "industria": 25.9, "servicos": 49.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6410574d-736b-4ca1-b855-fdba4778bfd1',
    '1703073',
    2019,
    1990.61,
    29799.04,
    61.5,
    199060596.5,
    '{"agricultura": 20.6, "industria": 25.7, "servicos": 53.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '55507483-b73f-43d6-aec9-945262324e39',
    '1703073',
    2020,
    2168.58,
    30688.63,
    57.9,
    216858119.68,
    '{"agricultura": 24.2, "industria": 21.8, "servicos": 54.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '63d670c0-b101-42fc-9579-3925dc166242',
    '1703073',
    2021,
    2255.02,
    31907.3,
    64.9,
    225501641.2,
    '{"agricultura": 19.2, "industria": 33.8, "servicos": 47.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b27c85f4-2ab2-4245-bac1-ad64f95a7816',
    '1703073',
    2022,
    2189.63,
    29796.21,
    57.9,
    218963413.8,
    '{"agricultura": 9.5, "industria": 31.0, "servicos": 59.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9e46c63a-5b6d-4cd5-9ef7-03536ec7801b',
    '1703073',
    2023,
    2296.94,
    32618.21,
    66.3,
    229694172.33,
    '{"agricultura": 15.6, "industria": 25.2, "servicos": 59.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '13975085-1006-4916-b8aa-34afe3ecedf9',
    '1703107',
    2019,
    642.64,
    21606.26,
    58.7,
    85684676.36,
    '{"agricultura": 5.9, "industria": 26.5, "servicos": 67.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a017e839-a8fe-45f4-bced-c52b920248dd',
    '1703107',
    2020,
    671.63,
    22223.07,
    57.6,
    89550100.52,
    '{"agricultura": 5.7, "industria": 17.2, "servicos": 77.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '95ab5993-e303-495f-986b-7ff6041e629a',
    '1703107',
    2021,
    705.15,
    24683.96,
    67.6,
    94019547.47,
    '{"agricultura": 11.5, "industria": 28.4, "servicos": 60.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5430a241-7d87-4aa1-bf60-63b0c375f7cb',
    '1703107',
    2022,
    696.36,
    23524.94,
    55.4,
    92848241.45,
    '{"agricultura": 16.9, "industria": 35.0, "servicos": 48.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c6a0edd0-f010-4708-8210-e500bf954390',
    '1703107',
    2023,
    751.48,
    25535.26,
    58.7,
    100196970.47,
    '{"agricultura": 24.2, "industria": 17.1, "servicos": 58.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9b611e15-7b89-4699-a183-8657284e3317',
    '1703206',
    2019,
    2133.5,
    29826.18,
    57.5,
    213349616.42,
    '{"agricultura": 19.5, "industria": 32.3, "servicos": 48.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'dd1baf37-07df-43e3-a340-01643334658d',
    '1703206',
    2020,
    1955.04,
    29310.13,
    66.7,
    195504457.45,
    '{"agricultura": 10.2, "industria": 20.8, "servicos": 69.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c4a1820e-8cdd-4caf-a689-87681e8838f2',
    '1703206',
    2021,
    1938.78,
    26406.35,
    61.2,
    193878038.26,
    '{"agricultura": 10.5, "industria": 15.0, "servicos": 74.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8ef88c5c-faa9-420a-907f-656b2adbe6b1',
    '1703206',
    2022,
    2360.99,
    32665.37,
    64.3,
    236098743.95,
    '{"agricultura": 14.4, "industria": 17.2, "servicos": 68.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2cec2fee-e0c2-4962-92a9-4468d2189a30',
    '1703206',
    2023,
    2170.38,
    30610.08,
    58.0,
    217037745.77,
    '{"agricultura": 6.6, "industria": 34.6, "servicos": 58.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '924e8d23-6b37-4608-b7de-f822d5a8372c',
    '1703305',
    2019,
    540.55,
    17871.05,
    60.8,
    72072761.76,
    '{"agricultura": 17.4, "industria": 19.1, "servicos": 63.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9620dc2b-4bf9-4281-be6e-bfffac4c1051',
    '1703305',
    2020,
    680.63,
    21856.95,
    58.4,
    90750037.46,
    '{"agricultura": 16.9, "industria": 34.3, "servicos": 48.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9c99fff1-7985-4072-83a6-a2936192f2f6',
    '1703305',
    2021,
    613.48,
    20761.46,
    69.3,
    81797376.18,
    '{"agricultura": 12.4, "industria": 33.8, "servicos": 53.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ac93cd76-f2c7-42d1-a9d4-7010e5cf33af',
    '1703305',
    2022,
    614.91,
    20521.69,
    68.9,
    81988256.94,
    '{"agricultura": 6.0, "industria": 28.0, "servicos": 66.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '36963833-af2a-4a7e-821c-b5b460bb7707',
    '1703305',
    2023,
    751.92,
    24949.93,
    55.4,
    100255469.35,
    '{"agricultura": 20.6, "industria": 28.2, "servicos": 51.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c5d465a8-3603-43d6-9ee0-98d59053c7ab',
    '1703602',
    2019,
    283.52,
    27107.3,
    63.8,
    39692129.54,
    '{"agricultura": 22.7, "industria": 23.0, "servicos": 54.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8c22927c-4383-46ec-b1c9-078346f990c1',
    '1703602',
    2020,
    271.94,
    27372.3,
    56.4,
    38072129.47,
    '{"agricultura": 15.0, "industria": 34.9, "servicos": 50.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '028b7478-9d0a-4a4e-9b4a-c52c21a4680e',
    '1703602',
    2021,
    284.78,
    28655.65,
    60.4,
    39869180.7,
    '{"agricultura": 6.5, "industria": 32.1, "servicos": 61.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4635d876-f344-4a41-9a14-c5a764f437c6',
    '1703602',
    2022,
    252.26,
    25652.28,
    56.6,
    35317033.22,
    '{"agricultura": 11.8, "industria": 30.5, "servicos": 57.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '18f71837-e999-4b83-9595-65fe009a34ca',
    '1703602',
    2023,
    300.66,
    30199.38,
    58.9,
    42093097.33,
    '{"agricultura": 14.9, "industria": 19.0, "servicos": 66.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7bd3d649-6fc2-4ce7-a486-5771f9261940',
    '1703701',
    2019,
    579.82,
    19335.06,
    68.3,
    77309316.5,
    '{"agricultura": 14.1, "industria": 27.5, "servicos": 58.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2e7033be-3bf0-4629-88db-71d307cd8ca0',
    '1703701',
    2020,
    561.76,
    17871.61,
    55.7,
    74901109.27,
    '{"agricultura": 19.2, "industria": 29.0, "servicos": 51.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '56319be5-660e-4264-83ab-2a7e0046cf31',
    '1703701',
    2021,
    685.64,
    21827.32,
    61.2,
    91418619.72,
    '{"agricultura": 6.6, "industria": 32.5, "servicos": 61.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '02d42ec9-e8a0-420a-88c5-0fbcf8e4137d',
    '1703701',
    2022,
    618.95,
    19914.77,
    63.6,
    82526821.01,
    '{"agricultura": 19.2, "industria": 19.3, "servicos": 61.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2af7b8de-6426-44a2-9e0b-48d112176245',
    '1703701',
    2023,
    627.69,
    21845.7,
    59.0,
    83692324.97,
    '{"agricultura": 10.5, "industria": 26.0, "servicos": 63.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '88a92e17-79cb-4f30-83af-1045df9e7f80',
    '1703800',
    2019,
    233.96,
    23961.2,
    66.9,
    32754000.57,
    '{"agricultura": 13.1, "industria": 34.6, "servicos": 52.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0970fa5a-b1be-40fa-9643-5d359ccfc78e',
    '1703800',
    2020,
    235.89,
    24687.13,
    62.8,
    33023976.01,
    '{"agricultura": 18.0, "industria": 29.4, "servicos": 52.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '37e88e09-00cb-4065-9f0a-cbb5a440f25e',
    '1703800',
    2021,
    281.5,
    29332.41,
    68.5,
    39410438.17,
    '{"agricultura": 24.0, "industria": 27.3, "servicos": 48.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6d0cc169-3427-4a12-8118-d265e7a8ed4a',
    '1703800',
    2022,
    266.03,
    26376.02,
    60.2,
    37243992.54,
    '{"agricultura": 21.5, "industria": 25.8, "servicos": 52.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '205cd70f-780e-4ec2-9628-ccb013c840aa',
    '1703800',
    2023,
    276.79,
    27832.44,
    55.0,
    38751106.46,
    '{"agricultura": 14.3, "industria": 22.6, "servicos": 63.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '550c0461-693f-4706-8fe8-62de7e30acc5',
    '1703826',
    2019,
    1804.89,
    26101.52,
    66.0,
    180489395.38,
    '{"agricultura": 13.2, "industria": 29.8, "servicos": 56.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b64cf892-0509-4f5a-a19e-f9a557eaf649',
    '1703826',
    2020,
    1871.53,
    27561.44,
    64.0,
    187153206.05,
    '{"agricultura": 5.0, "industria": 19.6, "servicos": 75.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f1f3afd3-c61e-4a76-8b2c-00263ad7979a',
    '1703826',
    2021,
    2155.16,
    30183.1,
    59.1,
    215516362.89,
    '{"agricultura": 24.3, "industria": 31.9, "servicos": 43.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6e97506f-b0e4-4f1e-812a-ef634023f25c',
    '1703826',
    2022,
    2119.96,
    28918.11,
    55.2,
    211995753.07,
    '{"agricultura": 18.9, "industria": 32.6, "servicos": 48.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e4f82696-9903-4d3b-b85a-689277276f52',
    '1703826',
    2023,
    2081.56,
    30795.11,
    56.8,
    208156497.67,
    '{"agricultura": 21.5, "industria": 29.4, "servicos": 49.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a5bc3499-9284-4dea-9d06-39950515edf2',
    '1703842',
    2019,
    261.4,
    27062.69,
    60.3,
    36595792.08,
    '{"agricultura": 8.3, "industria": 16.1, "servicos": 75.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c5720b93-6ec2-424e-8456-7cf7bf868726',
    '1703842',
    2020,
    237.05,
    22784.52,
    63.9,
    33187019.71,
    '{"agricultura": 21.3, "industria": 15.5, "servicos": 63.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b249aa23-732f-40a9-a5cc-be113b15ff32',
    '1703842',
    2021,
    255.6,
    25486.35,
    62.2,
    35784363.55,
    '{"agricultura": 7.2, "industria": 27.8, "servicos": 65.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f81cd98f-d64c-421e-86c8-592a3162f8dd',
    '1703842',
    2022,
    264.58,
    26490.15,
    65.9,
    37041712.21,
    '{"agricultura": 18.4, "industria": 28.1, "servicos": 53.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '80bbd759-3040-4c5e-8017-5cfa7b604eba',
    '1703842',
    2023,
    301.03,
    29988.72,
    66.8,
    42143751.74,
    '{"agricultura": 11.1, "industria": 32.2, "servicos": 56.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '415fa380-7697-4d91-acc2-2b8899ace55f',
    '1703867',
    2019,
    2096.25,
    30538.03,
    59.4,
    209625265.27,
    '{"agricultura": 15.2, "industria": 31.8, "servicos": 52.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9329bd27-8d6d-493f-a059-d97e7c5c6f04',
    '1703867',
    2020,
    2084.79,
    30326.49,
    60.0,
    208479466.77,
    '{"agricultura": 20.7, "industria": 18.6, "servicos": 60.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c0e3e5be-5a3a-4b61-b748-98436931ca96',
    '1703867',
    2021,
    2126.93,
    30970.53,
    55.3,
    212693189.69,
    '{"agricultura": 5.0, "industria": 15.1, "servicos": 79.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'bd6323fc-fa89-4bf3-84a2-cafe0e9d0080',
    '1703867',
    2022,
    2247.7,
    31357.0,
    67.9,
    224770136.46,
    '{"agricultura": 18.9, "industria": 16.8, "servicos": 64.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9dba06f1-3352-4776-8656-55d46b094489',
    '1703867',
    2023,
    2510.96,
    36526.23,
    57.8,
    251095903.84,
    '{"agricultura": 16.5, "industria": 22.8, "servicos": 60.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0a569151-b1da-4a96-8cfb-ec5b609aabb5',
    '1703883',
    2019,
    2031.96,
    29819.44,
    58.9,
    203195642.56,
    '{"agricultura": 20.6, "industria": 33.2, "servicos": 46.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2c12cb84-eea1-40b9-a6bc-b564c693ee87',
    '1703883',
    2020,
    2210.03,
    31916.05,
    66.9,
    221002717.65,
    '{"agricultura": 12.0, "industria": 20.2, "servicos": 67.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f28880e4-d7f9-42ce-9bc1-296ba7cec7ea',
    '1703883',
    2021,
    2396.82,
    34211.38,
    55.9,
    239681513.33,
    '{"agricultura": 12.3, "industria": 32.9, "servicos": 54.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ff8205d2-626e-405c-a7d0-71e975159183',
    '1703883',
    2022,
    2006.34,
    29226.55,
    67.8,
    200634447.74,
    '{"agricultura": 21.6, "industria": 34.7, "servicos": 43.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4cd7e770-5c48-4a0a-9502-98c234d32e85',
    '1703883',
    2023,
    2125.23,
    29787.26,
    61.5,
    212523152.82,
    '{"agricultura": 14.9, "industria": 33.5, "servicos": 51.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '767ada93-f1b1-4e0a-9dfa-e53ed3a943f6',
    '1703891',
    2019,
    227.22,
    22215.87,
    63.8,
    31811345.26,
    '{"agricultura": 14.0, "industria": 15.2, "servicos": 70.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '36c6f0d5-7a73-40b5-b131-d1fb15f58a08',
    '1703891',
    2020,
    242.41,
    25039.44,
    61.8,
    33936951.07,
    '{"agricultura": 14.6, "industria": 34.0, "servicos": 51.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a661ef86-0741-4bcb-9155-914ddfa5a301',
    '1703891',
    2021,
    243.44,
    24973.51,
    65.6,
    34081848.52,
    '{"agricultura": 15.5, "industria": 28.6, "servicos": 55.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '81132b29-647b-4374-953b-6c910fcbd605',
    '1703891',
    2022,
    287.45,
    27970.02,
    56.2,
    40242709.55,
    '{"agricultura": 21.4, "industria": 15.5, "servicos": 63.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2b4ad32d-00fd-40c6-b245-dc1bcd7c00cd',
    '1703891',
    2023,
    267.98,
    26564.18,
    57.9,
    37517127.03,
    '{"agricultura": 12.3, "industria": 17.2, "servicos": 70.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd73b15ad-16bf-49e3-a909-c6b82464b3ca',
    '1703909',
    2019,
    606.92,
    21070.55,
    65.5,
    80922136.86,
    '{"agricultura": 21.2, "industria": 15.1, "servicos": 63.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3b8dc63e-f661-4939-8264-b64b5f21a1e8',
    '1703909',
    2020,
    683.7,
    21841.22,
    55.4,
    91159412.23,
    '{"agricultura": 17.5, "industria": 22.9, "servicos": 59.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '15560fe7-f798-454b-a6e7-72970e41ae3d',
    '1703909',
    2021,
    614.62,
    19722.74,
    55.5,
    81949294.29,
    '{"agricultura": 17.5, "industria": 24.4, "servicos": 58.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9fe1e8d4-c0b7-462d-9a4e-24ebc216cdf4',
    '1703909',
    2022,
    635.02,
    21603.12,
    66.1,
    84669839.36,
    '{"agricultura": 23.5, "industria": 29.7, "servicos": 46.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5f9e3d0f-fa8a-441b-ab9b-7e3fc7776acb',
    '1703909',
    2023,
    696.07,
    22858.0,
    58.9,
    92809568.5,
    '{"agricultura": 9.2, "industria": 15.6, "servicos": 75.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '56fcb71d-20f6-4f45-81ed-7143ae9ebfdc',
    '1704105',
    2019,
    231.02,
    23708.8,
    69.7,
    32342591.05,
    '{"agricultura": 20.7, "industria": 23.1, "servicos": 56.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b718ba11-cf7b-4308-b5af-48de8be51cb6',
    '1704105',
    2020,
    268.52,
    28181.88,
    55.3,
    37592378.12,
    '{"agricultura": 15.6, "industria": 24.1, "servicos": 60.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7259f70e-5537-4e9b-a573-486c1599679f',
    '1704105',
    2021,
    279.38,
    28188.77,
    61.5,
    39113051.33,
    '{"agricultura": 8.3, "industria": 21.5, "servicos": 70.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9d30ea97-f663-4ddd-9ca1-ffbfa38a748b',
    '1704105',
    2022,
    293.1,
    30382.26,
    67.2,
    41033666.9,
    '{"agricultura": 24.5, "industria": 17.2, "servicos": 58.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd90b302d-e9d1-434f-bc54-2bcfe2d60c81',
    '1704105',
    2023,
    303.35,
    29909.78,
    69.2,
    42468301.19,
    '{"agricultura": 11.2, "industria": 23.6, "servicos": 65.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '91a48716-5a07-4743-96df-1879f310b0c5',
    '1705102',
    2019,
    605.57,
    20295.2,
    61.3,
    80742410.52,
    '{"agricultura": 21.9, "industria": 26.6, "servicos": 51.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3393d9aa-fbe4-4bd1-9b69-ab2c30a23867',
    '1705102',
    2020,
    591.37,
    20740.24,
    57.1,
    78848854.8,
    '{"agricultura": 22.9, "industria": 30.5, "servicos": 46.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '983e71ac-a10f-4b3d-ab00-3583e1464129',
    '1705102',
    2021,
    720.13,
    24053.34,
    57.7,
    96017736.7,
    '{"agricultura": 13.5, "industria": 26.1, "servicos": 60.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '75dd94b8-b1d2-4108-94be-5ba36a4a0911',
    '1705102',
    2022,
    649.3,
    22251.53,
    57.6,
    86573295.54,
    '{"agricultura": 9.7, "industria": 29.2, "servicos": 61.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2bdb2d96-ffa5-4802-bb53-ddd88af12126',
    '1705102',
    2023,
    692.26,
    22869.57,
    59.4,
    92301576.45,
    '{"agricultura": 19.1, "industria": 26.1, "servicos": 54.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '57b550fa-5795-43bc-a1a0-bada80c6d69a',
    '1704600',
    2019,
    265.41,
    27079.69,
    60.2,
    37157131.66,
    '{"agricultura": 15.8, "industria": 28.8, "servicos": 55.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4de5c332-0895-4120-ba74-d611978a71d3',
    '1704600',
    2020,
    251.39,
    24102.31,
    58.5,
    35194195.05,
    '{"agricultura": 17.3, "industria": 22.9, "servicos": 59.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ccc7f52e-cd06-43ad-8f16-bbb762ed6f3c',
    '1704600',
    2021,
    293.79,
    29311.55,
    57.3,
    41130549.26,
    '{"agricultura": 17.7, "industria": 31.5, "servicos": 50.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'fb5cdcc4-c4a5-48b2-8a49-c55dec23563e',
    '1704600',
    2022,
    284.56,
    28613.62,
    62.8,
    39838737.55,
    '{"agricultura": 19.0, "industria": 33.4, "servicos": 47.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '83fc9861-826a-47a9-beb5-6ed8ee92def5',
    '1704600',
    2023,
    280.47,
    27150.56,
    68.6,
    39265134.77,
    '{"agricultura": 8.5, "industria": 33.9, "servicos": 57.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5aaed0f2-18e8-4448-9a4b-b89581f376cf',
    '1705508',
    2019,
    617.61,
    19703.66,
    65.5,
    82348167.25,
    '{"agricultura": 16.4, "industria": 29.3, "servicos": 54.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6a205f69-3f49-4355-8776-4bdc7a01a057',
    '1705508',
    2020,
    605.13,
    20376.95,
    58.0,
    80684560.93,
    '{"agricultura": 10.7, "industria": 21.0, "servicos": 68.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '735b895e-3255-4357-b120-dc439f031bdc',
    '1705508',
    2021,
    708.98,
    23387.15,
    55.1,
    94530877.55,
    '{"agricultura": 24.7, "industria": 22.2, "servicos": 53.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e2e0023f-cbe2-4feb-8041-76dd6a8af7e8',
    '1705508',
    2022,
    651.4,
    22030.63,
    58.7,
    86853575.19,
    '{"agricultura": 12.1, "industria": 33.9, "servicos": 54.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9ed1e765-9aea-4a73-9142-b435c923245e',
    '1705508',
    2023,
    617.03,
    20964.04,
    56.7,
    82271264.82,
    '{"agricultura": 6.2, "industria": 24.9, "servicos": 69.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4290d252-e3db-4e43-893f-920a890d71aa',
    '1716703',
    2019,
    266.09,
    26664.52,
    60.2,
    37251934.68,
    '{"agricultura": 9.3, "industria": 34.1, "servicos": 56.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7de56b45-3437-42a7-ba3a-cb8f5aca2309',
    '1716703',
    2020,
    250.64,
    25393.85,
    65.2,
    35089220.48,
    '{"agricultura": 10.3, "industria": 28.6, "servicos": 61.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '13ec0e49-d2f0-4120-bc8f-5b68ef772b00',
    '1716703',
    2021,
    279.11,
    29312.14,
    62.3,
    39075423.72,
    '{"agricultura": 16.9, "industria": 19.5, "servicos": 63.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4595440b-e49c-439b-acfb-0883d837a86a',
    '1716703',
    2022,
    300.95,
    31179.96,
    66.0,
    42132861.67,
    '{"agricultura": 10.9, "industria": 15.3, "servicos": 73.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '269b590d-a6c8-4e5e-a578-a6988658977d',
    '1716703',
    2023,
    267.35,
    27311.54,
    57.9,
    37429377.85,
    '{"agricultura": 11.7, "industria": 26.4, "servicos": 62.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f69ba696-8fb8-40c1-97d6-b50ff605616f',
    '1705557',
    2019,
    674.76,
    23011.13,
    68.7,
    89967371.58,
    '{"agricultura": 19.1, "industria": 20.3, "servicos": 60.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a72ab3b1-2d3b-4edc-aedf-c6a31eac1dfa',
    '1705557',
    2020,
    606.39,
    20999.06,
    64.4,
    80851964.8,
    '{"agricultura": 20.6, "industria": 27.4, "servicos": 52.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ea42def4-8886-409d-8ec5-03078c6f5c8a',
    '1705557',
    2021,
    687.72,
    21885.24,
    61.8,
    91696227.53,
    '{"agricultura": 16.1, "industria": 18.5, "servicos": 65.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '56f79428-92cc-463f-be5d-ed6e0c1e0a45',
    '1705557',
    2022,
    749.76,
    26150.59,
    57.0,
    99968475.88,
    '{"agricultura": 23.2, "industria": 17.5, "servicos": 59.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '52b1f961-2cb9-41c8-accb-d2125a760dae',
    '1705557',
    2023,
    667.92,
    23160.3,
    62.9,
    89055989.81,
    '{"agricultura": 18.2, "industria": 17.1, "servicos": 64.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6f55e871-790a-4e84-a9bd-49bdd509d4bb',
    '1705607',
    2019,
    2241.35,
    33465.5,
    65.1,
    224135193.59,
    '{"agricultura": 7.7, "industria": 19.2, "servicos": 73.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ac8b0576-0872-4dd1-a2d4-74c74eff8893',
    '1705607',
    2020,
    2200.9,
    30645.05,
    56.1,
    220089688.5,
    '{"agricultura": 24.1, "industria": 21.4, "servicos": 54.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2b641136-d873-4df1-9548-bc830b3d90a7',
    '1705607',
    2021,
    2247.47,
    31423.48,
    62.4,
    224746984.23,
    '{"agricultura": 25.0, "industria": 16.5, "servicos": 58.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '92182ab2-700a-4600-8d91-3778ea9b9e6e',
    '1705607',
    2022,
    2361.78,
    34824.74,
    62.1,
    236177925.45,
    '{"agricultura": 11.8, "industria": 16.3, "servicos": 71.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '02eaaf2b-0617-4ef5-952e-9eaaf033c7d4',
    '1705607',
    2023,
    2430.41,
    35975.15,
    62.3,
    243040908.85,
    '{"agricultura": 20.7, "industria": 26.2, "servicos": 53.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '957479c9-74f5-4fad-88fd-d3c1d0a4742d',
    '1706001',
    2019,
    599.42,
    19910.46,
    63.5,
    79923257.4,
    '{"agricultura": 11.1, "industria": 23.8, "servicos": 65.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '32092d07-2dc4-4021-8033-fbc0da3279b2',
    '1706001',
    2020,
    703.71,
    22394.71,
    56.6,
    93827859.32,
    '{"agricultura": 15.8, "industria": 30.4, "servicos": 53.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7ffc4438-3fc9-4c05-a72c-318020b4be48',
    '1706001',
    2021,
    628.2,
    20067.83,
    67.0,
    83760450.76,
    '{"agricultura": 11.9, "industria": 19.7, "servicos": 68.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '782cb5b1-fa56-4d5a-b4c5-3499199e0325',
    '1706001',
    2022,
    684.97,
    21820.59,
    66.1,
    91329349.32,
    '{"agricultura": 10.7, "industria": 30.8, "servicos": 58.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3e1ecd1a-38c7-491b-aee4-4b7a59322172',
    '1706001',
    2023,
    632.6,
    20483.69,
    59.1,
    84346367.0,
    '{"agricultura": 24.7, "industria": 34.8, "servicos": 40.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ed2edb36-0831-47d9-ba98-4603a7ac9036',
    '1706100',
    2019,
    272.65,
    26578.98,
    56.0,
    38170606.36,
    '{"agricultura": 21.1, "industria": 16.7, "servicos": 62.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '46f6e2bc-4484-44e6-95d3-b0e8eea6615b',
    '1706100',
    2020,
    285.5,
    27383.49,
    68.8,
    39970032.96,
    '{"agricultura": 20.2, "industria": 28.3, "servicos": 51.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1910a559-9d13-4050-87e8-5fa259fc26cb',
    '1706100',
    2021,
    242.86,
    23944.03,
    63.7,
    34001003.25,
    '{"agricultura": 16.3, "industria": 26.0, "servicos": 57.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6501c753-c340-4933-a391-31e12b92eeb9',
    '1706100',
    2022,
    249.62,
    25867.43,
    63.4,
    34946895.01,
    '{"agricultura": 9.9, "industria": 22.6, "servicos": 67.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3f693649-6829-4331-b8b8-349aa3dbe827',
    '1706100',
    2023,
    277.17,
    28141.9,
    63.1,
    38803734.08,
    '{"agricultura": 5.8, "industria": 33.8, "servicos": 60.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '98b7a7fa-e8a3-44fe-95db-89907e11933c',
    '1706258',
    2019,
    637.54,
    20500.37,
    66.1,
    85005482.17,
    '{"agricultura": 18.2, "industria": 31.1, "servicos": 50.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3899ab51-3389-42d5-9e9d-5a6633890ebc',
    '1706258',
    2020,
    634.48,
    21999.27,
    62.4,
    84597475.74,
    '{"agricultura": 14.6, "industria": 24.6, "servicos": 60.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'eb47bf62-bbbc-473d-b5be-dcbb9295ec29',
    '1706258',
    2021,
    638.52,
    20715.7,
    55.0,
    85135984.87,
    '{"agricultura": 16.0, "industria": 23.1, "servicos": 60.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7f2a5ee9-b2b6-4270-89ab-e29603735192',
    '1706258',
    2022,
    651.24,
    20793.92,
    55.7,
    86832641.8,
    '{"agricultura": 9.7, "industria": 31.6, "servicos": 58.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9dbe24a4-7aac-4a2a-a30c-c1daa8181bea',
    '1706258',
    2023,
    703.37,
    22716.57,
    66.5,
    93783092.75,
    '{"agricultura": 15.4, "industria": 21.3, "servicos": 63.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '84b96954-9772-4584-884a-72c3a8d3875c',
    '1706506',
    2019,
    623.26,
    20476.91,
    62.4,
    83100746.17,
    '{"agricultura": 16.7, "industria": 19.4, "servicos": 63.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '938c72be-804a-4c75-b6d5-6d8f03c3552d',
    '1706506',
    2020,
    653.6,
    22279.18,
    66.9,
    87147236.03,
    '{"agricultura": 20.7, "industria": 24.6, "servicos": 54.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '98fe243c-9bfc-4d72-a596-a32063e57e31',
    '1706506',
    2021,
    714.28,
    24418.17,
    68.9,
    95237387.07,
    '{"agricultura": 16.1, "industria": 34.4, "servicos": 49.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'fa802d2f-bff8-414f-a7bd-9c422d6f0978',
    '1706506',
    2022,
    631.98,
    20208.4,
    60.5,
    84263638.71,
    '{"agricultura": 15.0, "industria": 31.1, "servicos": 53.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0966a228-26bd-44e1-9fe3-43fdf54499ac',
    '1706506',
    2023,
    732.41,
    24386.92,
    59.2,
    97654985.86,
    '{"agricultura": 21.1, "industria": 15.8, "servicos": 63.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4bf78c18-b142-4d0d-b5d2-fda72d48daf2',
    '1707009',
    2019,
    2052.56,
    28651.89,
    57.8,
    205256432.39,
    '{"agricultura": 24.4, "industria": 17.3, "servicos": 58.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b7a76781-583d-4633-a28e-281322ca7618',
    '1707009',
    2020,
    2311.54,
    32941.46,
    60.1,
    231153532.33,
    '{"agricultura": 12.2, "industria": 34.9, "servicos": 52.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1cd8d81b-4801-4dea-abc6-15b2956a5d0d',
    '1707009',
    2021,
    2271.41,
    31750.16,
    58.2,
    227140673.08,
    '{"agricultura": 17.7, "industria": 33.2, "servicos": 49.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9380fb3d-018a-476a-98b7-a84362b96a61',
    '1707009',
    2022,
    2151.36,
    30089.43,
    60.2,
    215136448.94,
    '{"agricultura": 12.0, "industria": 18.7, "servicos": 69.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e234a8ab-ebea-41fa-b53a-312cf0e94ec9',
    '1707009',
    2023,
    2026.65,
    27982.72,
    69.1,
    202664880.03,
    '{"agricultura": 21.2, "industria": 28.4, "servicos": 50.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'da52d4e7-b045-4d4d-9b29-308561320d40',
    '1707108',
    2019,
    638.41,
    21972.31,
    61.0,
    85120725.8,
    '{"agricultura": 7.2, "industria": 16.0, "servicos": 76.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'edd7a6b9-9e3e-4da1-8eeb-05d9d9226466',
    '1707108',
    2020,
    666.44,
    22817.73,
    60.1,
    88858306.23,
    '{"agricultura": 9.5, "industria": 20.9, "servicos": 69.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ca65613f-2087-4fdd-b139-c0d2d3375e69',
    '1707108',
    2021,
    710.98,
    22905.13,
    66.7,
    94796689.95,
    '{"agricultura": 5.9, "industria": 29.6, "servicos": 64.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'bf3468e8-8e08-4880-bea4-f00cf866f84e',
    '1707108',
    2022,
    657.78,
    21340.01,
    57.1,
    87704606.32,
    '{"agricultura": 14.7, "industria": 28.7, "servicos": 56.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1de7dac3-472a-4a94-a552-a2eac688a18b',
    '1707108',
    2023,
    665.88,
    22776.17,
    62.8,
    88784565.09,
    '{"agricultura": 24.5, "industria": 29.4, "servicos": 46.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2b46d3a2-1520-4261-85ca-47c425634e0d',
    '1707207',
    2019,
    674.7,
    22714.78,
    61.0,
    89959604.66,
    '{"agricultura": 12.6, "industria": 29.9, "servicos": 57.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ce029286-3f5f-42aa-ac2a-4074a44bc480',
    '1707207',
    2020,
    654.17,
    21302.26,
    58.0,
    87222801.4,
    '{"agricultura": 11.4, "industria": 26.6, "servicos": 61.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '78bc72aa-25e6-4209-9d19-6f6d0b78c12d',
    '1707207',
    2021,
    628.65,
    20419.42,
    65.6,
    83820377.86,
    '{"agricultura": 14.2, "industria": 24.6, "servicos": 61.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7365f759-4a25-4c93-a33a-005f6bcb5e84',
    '1707207',
    2022,
    623.71,
    20548.54,
    62.9,
    83161293.36,
    '{"agricultura": 24.0, "industria": 21.6, "servicos": 54.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '86afcf88-ce4b-46f8-8b77-0d6f0c08776d',
    '1707207',
    2023,
    764.14,
    25424.84,
    61.4,
    101885792.59,
    '{"agricultura": 9.4, "industria": 31.9, "servicos": 58.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'da362074-9e82-479b-8a72-abf56fbb0c1d',
    '1707306',
    2019,
    644.31,
    21626.28,
    59.7,
    85908240.52,
    '{"agricultura": 13.8, "industria": 28.8, "servicos": 57.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '49a1f34b-71df-406c-83eb-b476f612cf73',
    '1707306',
    2020,
    589.16,
    20264.14,
    56.6,
    78554596.49,
    '{"agricultura": 23.2, "industria": 16.5, "servicos": 60.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'db46478e-1575-4d23-a9ae-4839176111e1',
    '1707306',
    2021,
    619.13,
    21461.82,
    62.5,
    82550755.07,
    '{"agricultura": 16.3, "industria": 21.2, "servicos": 62.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9cc86aec-39ce-496b-b1d3-7b596bb71b6b',
    '1707306',
    2022,
    607.08,
    21066.66,
    56.5,
    80943725.82,
    '{"agricultura": 12.4, "industria": 26.7, "servicos": 60.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6fea2349-4812-4d03-96ea-172784893b8d',
    '1707306',
    2023,
    676.46,
    23667.44,
    69.7,
    90195050.66,
    '{"agricultura": 9.4, "industria": 17.1, "servicos": 73.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2a77aca7-5961-42d9-a848-68d408eb391a',
    '1707405',
    2019,
    259.99,
    25812.98,
    66.8,
    36398365.88,
    '{"agricultura": 12.4, "industria": 17.3, "servicos": 70.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1c3ecd06-48e4-4acf-9923-6c33500d5c0d',
    '1707405',
    2020,
    269.29,
    27012.74,
    66.2,
    37700602.74,
    '{"agricultura": 11.5, "industria": 21.0, "servicos": 67.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a483135a-aba4-445f-8e5b-c1ed3ca95670',
    '1707405',
    2021,
    299.05,
    28763.23,
    59.5,
    41867183.79,
    '{"agricultura": 15.0, "industria": 20.7, "servicos": 64.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '19b89d52-16f0-454c-a1e8-c65b9deb1361',
    '1707405',
    2022,
    248.82,
    25795.02,
    55.0,
    34834621.23,
    '{"agricultura": 19.2, "industria": 17.1, "servicos": 63.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '31090833-3e6c-424e-9762-bc208429ad3e',
    '1707405',
    2023,
    262.68,
    25737.82,
    62.6,
    36775230.92,
    '{"agricultura": 15.8, "industria": 23.8, "servicos": 60.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '29d16c2b-5499-484c-a759-c22e38c079fe',
    '1707652',
    2019,
    2195.37,
    30396.72,
    62.3,
    219537272.69,
    '{"agricultura": 16.1, "industria": 34.8, "servicos": 49.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2744b906-6f19-4278-9e68-570247174313',
    '1707652',
    2020,
    2057.93,
    28022.62,
    69.1,
    205792536.1,
    '{"agricultura": 22.5, "industria": 31.1, "servicos": 46.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '132dec9f-7ce2-4919-b983-157e7eed90dc',
    '1707652',
    2021,
    1955.06,
    26748.73,
    69.0,
    195506497.29,
    '{"agricultura": 6.0, "industria": 20.0, "servicos": 74.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4c886d2b-ea63-4413-ab26-b779b56da474',
    '1707652',
    2022,
    2342.39,
    35014.82,
    68.8,
    234238656.71,
    '{"agricultura": 12.6, "industria": 17.5, "servicos": 70.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ff8f6d83-12cb-4168-9f74-2ff760eb1260',
    '1707652',
    2023,
    2492.42,
    35216.65,
    58.6,
    249242325.59,
    '{"agricultura": 20.8, "industria": 25.4, "servicos": 53.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd9da376b-bea5-4c89-8b97-a0c208eecd88',
    '1707702',
    2019,
    261.08,
    26249.92,
    58.6,
    36551434.2,
    '{"agricultura": 15.1, "industria": 25.4, "servicos": 59.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '897e6139-d262-480e-bf5b-f2dce584e589',
    '1707702',
    2020,
    237.99,
    24063.74,
    62.0,
    33318655.53,
    '{"agricultura": 15.5, "industria": 20.7, "servicos": 63.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '65e31fed-87c7-4650-8ef9-3de4c906c96e',
    '1707702',
    2021,
    298.39,
    28494.37,
    66.9,
    41775023.03,
    '{"agricultura": 8.6, "industria": 17.1, "servicos": 74.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '13032e18-e20a-42dd-a917-30662e77ec75',
    '1707702',
    2022,
    260.92,
    25939.29,
    57.7,
    36529258.87,
    '{"agricultura": 5.8, "industria": 31.6, "servicos": 62.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2c314d20-f520-437f-b76f-94ad0b20479d',
    '1707702',
    2023,
    288.99,
    30247.63,
    59.6,
    40458016.04,
    '{"agricultura": 14.3, "industria": 31.2, "servicos": 54.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e7a21df1-4c23-4db7-ba8e-002a2498cbd2',
    '1708205',
    2019,
    280.27,
    27779.74,
    67.8,
    39237765.57,
    '{"agricultura": 18.2, "industria": 33.9, "servicos": 47.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9fdfb97f-aa9b-45c6-b3c8-bc41e532b3e4',
    '1708205',
    2020,
    273.5,
    27774.77,
    55.3,
    38289742.05,
    '{"agricultura": 14.0, "industria": 27.4, "servicos": 58.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7725b4cf-6f06-417f-8b34-eff6ce4e9e5c',
    '1708205',
    2021,
    246.93,
    24137.69,
    59.3,
    34569992.77,
    '{"agricultura": 17.8, "industria": 30.4, "servicos": 51.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'dd59399d-21b4-46b9-92f8-3f2fadd1866a',
    '1708205',
    2022,
    304.82,
    29995.85,
    66.9,
    42674489.21,
    '{"agricultura": 22.5, "industria": 15.5, "servicos": 62.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '02bdb717-ad71-4a91-ac64-df20363d8f93',
    '1708205',
    2023,
    284.15,
    29375.17,
    62.8,
    39780437.16,
    '{"agricultura": 19.7, "industria": 19.5, "servicos": 60.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '555dfc03-13fa-44a0-bbb3-417a1b523086',
    '1707553',
    2019,
    547.06,
    18179.46,
    62.3,
    72940842.87,
    '{"agricultura": 20.2, "industria": 27.6, "servicos": 52.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4581690c-2132-4852-a5eb-88c8c0e443a9',
    '1707553',
    2020,
    672.5,
    22919.38,
    56.6,
    89666725.4,
    '{"agricultura": 19.5, "industria": 26.8, "servicos": 53.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c5b90f40-3d0f-43f1-bb68-3243adcea5f5',
    '1707553',
    2021,
    604.33,
    20343.0,
    61.5,
    80577286.56,
    '{"agricultura": 15.8, "industria": 19.9, "servicos": 64.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '80f2de6e-14f7-4987-8709-b10c75206164',
    '1707553',
    2022,
    724.53,
    25143.48,
    69.4,
    96604621.03,
    '{"agricultura": 15.0, "industria": 23.2, "servicos": 61.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '118cb9b4-e418-4aa0-8ca2-5477e0c80b17',
    '1707553',
    2023,
    687.12,
    22965.29,
    62.8,
    91616201.6,
    '{"agricultura": 8.0, "industria": 25.2, "servicos": 66.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '489ff0e1-c7cf-4334-9ecb-f12229337024',
    '1708304',
    2019,
    267.9,
    25746.97,
    60.2,
    37505605.22,
    '{"agricultura": 14.8, "industria": 16.0, "servicos": 69.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ea3754f5-9726-47d7-b1af-f1f0e4191bc8',
    '1708304',
    2020,
    278.04,
    26806.58,
    55.9,
    38925291.95,
    '{"agricultura": 22.2, "industria": 20.6, "servicos": 57.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f888867f-ee01-4bf7-90bf-6306fde27b24',
    '1708304',
    2021,
    277.92,
    26705.35,
    55.0,
    38909159.84,
    '{"agricultura": 12.7, "industria": 27.5, "servicos": 59.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5653199a-1da0-4486-a308-9b37e181789f',
    '1708304',
    2022,
    277.05,
    26519.24,
    58.0,
    38786511.85,
    '{"agricultura": 22.6, "industria": 24.9, "servicos": 52.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '86a4235d-1a5a-49da-b271-c841fb285f01',
    '1708304',
    2023,
    257.51,
    25764.12,
    57.3,
    36051727.66,
    '{"agricultura": 19.4, "industria": 15.8, "servicos": 64.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9311d906-ac28-4c7e-8b13-9da7ad6d6df9',
    '1709005',
    2019,
    275.71,
    28342.24,
    57.4,
    38599860.28,
    '{"agricultura": 21.1, "industria": 20.2, "servicos": 58.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '60a91de6-8c23-4c55-b312-3d3886665e91',
    '1709005',
    2020,
    260.54,
    25548.64,
    56.3,
    36476298.9,
    '{"agricultura": 11.7, "industria": 31.4, "servicos": 56.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '04fb2f54-7f3b-43ae-b91f-b7cb7978053d',
    '1709005',
    2021,
    244.03,
    23805.19,
    60.5,
    34163778.27,
    '{"agricultura": 19.7, "industria": 21.2, "servicos": 59.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'feea8c2e-3ea3-443a-bf9f-958c1ee4f98f',
    '1709005',
    2022,
    300.36,
    29221.21,
    67.9,
    42051080.79,
    '{"agricultura": 8.6, "industria": 17.1, "servicos": 74.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ee3f899f-bff6-49fd-81b1-5cc34495a194',
    '1709005',
    2023,
    304.79,
    29359.9,
    65.0,
    42669923.59,
    '{"agricultura": 10.2, "industria": 34.1, "servicos": 55.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b0fefe1c-5515-4f29-b796-fadc759dcd2b',
    '1709302',
    2019,
    563.6,
    19488.9,
    67.3,
    75146597.49,
    '{"agricultura": 10.4, "industria": 34.5, "servicos": 55.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '008336dd-5c40-4386-93f6-f705471865e2',
    '1709302',
    2020,
    588.44,
    19957.83,
    55.9,
    78458222.19,
    '{"agricultura": 23.1, "industria": 28.5, "servicos": 48.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4e36c74e-e6f3-4dce-b4b9-34a66a7bb73b',
    '1709302',
    2021,
    623.18,
    21716.65,
    61.3,
    83090786.14,
    '{"agricultura": 14.2, "industria": 18.6, "servicos": 67.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f689f140-467a-45ea-969b-5b481711caa4',
    '1709302',
    2022,
    666.12,
    22302.05,
    56.2,
    88815695.68,
    '{"agricultura": 8.6, "industria": 19.3, "servicos": 72.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'cf6a1586-5411-4792-b7c9-b6390baf7e55',
    '1709302',
    2023,
    704.37,
    23798.57,
    62.9,
    93915501.49,
    '{"agricultura": 24.6, "industria": 28.8, "servicos": 46.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f5f7b65c-46bf-4bed-92a2-542bf6c91f7c',
    '1709500',
    2019,
    2039.98,
    27869.75,
    59.1,
    203998191.5,
    '{"agricultura": 21.2, "industria": 30.8, "servicos": 48.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c2d2c8af-cc8e-4ae0-bcfd-d69bfae8fbf8',
    '1709500',
    2020,
    2091.01,
    31231.95,
    64.2,
    209101015.99,
    '{"agricultura": 8.2, "industria": 23.0, "servicos": 68.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7c7eec02-abfe-4a87-a1e4-5cb22fef25df',
    '1709500',
    2021,
    2206.98,
    31212.2,
    56.3,
    220698375.84,
    '{"agricultura": 22.5, "industria": 33.4, "servicos": 44.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4f38c075-88e5-4d98-8cde-bccb62f13036',
    '1709500',
    2022,
    2012.96,
    28490.82,
    68.2,
    201296183.11,
    '{"agricultura": 21.1, "industria": 33.7, "servicos": 45.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3485e938-6782-4d1e-8954-d0c80a661eaa',
    '1709500',
    2023,
    2294.41,
    34174.47,
    64.2,
    229440551.78,
    '{"agricultura": 23.3, "industria": 32.9, "servicos": 43.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3ca1a28c-9549-4ddc-8a39-cf5c477bd287',
    '1709807',
    2019,
    1845.69,
    27243.0,
    67.1,
    184568617.72,
    '{"agricultura": 24.2, "industria": 34.5, "servicos": 41.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '90b60324-b299-409a-8757-fda99434a833',
    '1709807',
    2020,
    2354.99,
    33277.58,
    62.8,
    235498762.78,
    '{"agricultura": 22.9, "industria": 31.0, "servicos": 46.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '04040c08-1afd-4cce-bd6f-11d10fa41199',
    '1709807',
    2021,
    2389.89,
    33876.06,
    55.3,
    238988843.36,
    '{"agricultura": 24.9, "industria": 25.1, "servicos": 50.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3ce126d4-86d2-49d7-b151-6c7ce1a1f6de',
    '1709807',
    2022,
    2366.28,
    33594.69,
    69.4,
    236627523.56,
    '{"agricultura": 6.0, "industria": 21.2, "servicos": 72.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ff7dddc5-f825-477a-90a4-7666a313b832',
    '1709807',
    2023,
    2313.83,
    34005.47,
    65.8,
    231383440.93,
    '{"agricultura": 23.9, "industria": 22.9, "servicos": 53.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1f818358-819f-40b4-98e8-ed4b77958f32',
    '1710508',
    2019,
    651.5,
    21758.17,
    68.6,
    86867314.93,
    '{"agricultura": 8.8, "industria": 25.9, "servicos": 65.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1b9899fd-aa96-486a-9631-b2695e7fef91',
    '1710508',
    2020,
    701.54,
    22391.3,
    69.5,
    93538926.32,
    '{"agricultura": 24.9, "industria": 17.2, "servicos": 57.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '88aa9282-5e08-4b22-9801-ec7e4e870dd7',
    '1710508',
    2021,
    572.52,
    18762.48,
    65.7,
    76335788.49,
    '{"agricultura": 24.0, "industria": 28.5, "servicos": 47.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f893bf9f-670c-4ce5-ab9d-0a4f06c7f4a4',
    '1710508',
    2022,
    707.29,
    24642.61,
    64.8,
    94305644.13,
    '{"agricultura": 22.4, "industria": 20.6, "servicos": 57.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '14d03c2a-399d-4c25-98d3-40459de1bf6a',
    '1710508',
    2023,
    638.14,
    22076.98,
    64.1,
    85084681.06,
    '{"agricultura": 19.4, "industria": 15.7, "servicos": 65.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b9be3428-89f9-464f-b987-3d51a50053d4',
    '1710706',
    2019,
    2020.21,
    30349.9,
    55.7,
    202021087.67,
    '{"agricultura": 20.6, "industria": 30.5, "servicos": 48.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '27973a93-51eb-4742-a9b4-78f18f108055',
    '1710706',
    2020,
    2166.84,
    32559.56,
    68.1,
    216683869.7,
    '{"agricultura": 20.5, "industria": 18.2, "servicos": 61.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9008a00b-e4c2-4501-a9ae-189070e1f0f5',
    '1710706',
    2021,
    2140.21,
    30663.32,
    57.8,
    214020802.22,
    '{"agricultura": 19.7, "industria": 31.6, "servicos": 48.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'bbac7399-7446-4adc-8723-a629acc05128',
    '1710706',
    2022,
    2229.53,
    32697.71,
    61.5,
    222952628.91,
    '{"agricultura": 23.9, "industria": 22.6, "servicos": 53.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4511d315-e076-408e-b3db-5532da466c2b',
    '1710706',
    2023,
    2156.61,
    30960.82,
    66.3,
    215660669.55,
    '{"agricultura": 16.7, "industria": 31.4, "servicos": 51.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3bf4b32e-dcbc-41be-85af-277edebda17b',
    '1710904',
    2019,
    282.34,
    29176.01,
    58.1,
    39527076.14,
    '{"agricultura": 7.2, "industria": 21.0, "servicos": 71.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f67e1dfc-0c5c-4377-97fa-540f15c403d4',
    '1710904',
    2020,
    263.96,
    26451.16,
    60.2,
    36953858.65,
    '{"agricultura": 12.3, "industria": 23.6, "servicos": 64.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8f1bb136-2c1b-4c57-b028-998d62747873',
    '1710904',
    2021,
    284.73,
    27181.91,
    61.1,
    39862275.38,
    '{"agricultura": 13.5, "industria": 18.4, "servicos": 68.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a9be670f-54de-48bd-aa20-e001ecb1932c',
    '1710904',
    2022,
    266.9,
    28059.47,
    70.0,
    37366233.04,
    '{"agricultura": 24.0, "industria": 33.3, "servicos": 42.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '13e34d43-4b14-4c74-a9fd-409867791ad6',
    '1710904',
    2023,
    280.98,
    27417.68,
    67.8,
    39336692.5,
    '{"agricultura": 14.3, "industria": 15.3, "servicos": 70.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e1fcd96a-c457-4da0-81a9-49ffc206e923',
    '1711100',
    2019,
    631.14,
    20301.78,
    56.5,
    84152229.17,
    '{"agricultura": 15.9, "industria": 19.9, "servicos": 64.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ec4b045b-74ea-4dbe-a63f-41aae42c6267',
    '1711100',
    2020,
    569.43,
    18608.87,
    66.5,
    75924200.21,
    '{"agricultura": 11.9, "industria": 19.7, "servicos": 68.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8f550e03-a380-4166-91a4-1b7f09734e4f',
    '1711100',
    2021,
    625.56,
    20243.91,
    61.5,
    83407600.97,
    '{"agricultura": 10.9, "industria": 16.6, "servicos": 72.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8ece60f0-160e-41f1-954a-8fc2f6bd9823',
    '1711100',
    2022,
    676.42,
    22274.79,
    56.8,
    90189128.86,
    '{"agricultura": 5.2, "industria": 34.1, "servicos": 60.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b7c4bb90-58ed-464b-90d7-47fc82d24969',
    '1711100',
    2023,
    658.4,
    21951.86,
    68.6,
    87786948.15,
    '{"agricultura": 5.2, "industria": 34.0, "servicos": 60.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b8f2a549-4d2b-4953-82ba-34cc983445ef',
    '1711506',
    2019,
    673.96,
    22314.18,
    56.7,
    89860684.58,
    '{"agricultura": 18.4, "industria": 16.5, "servicos": 65.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1618095d-3879-4f6a-972e-954a89e76415',
    '1711506',
    2020,
    702.51,
    23223.59,
    59.0,
    93668459.74,
    '{"agricultura": 11.9, "industria": 25.0, "servicos": 63.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '66bf5338-7bad-4604-8212-62153af95707',
    '1711506',
    2021,
    585.34,
    18647.21,
    66.5,
    78044771.81,
    '{"agricultura": 17.5, "industria": 27.3, "servicos": 55.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '038df0eb-9b9b-4b2c-9118-2f0d99300f72',
    '1711506',
    2022,
    605.81,
    21233.27,
    67.6,
    80774172.25,
    '{"agricultura": 15.6, "industria": 27.8, "servicos": 56.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '00d5eb06-0256-441b-b0c8-6b18384fe940',
    '1711506',
    2023,
    740.4,
    24885.05,
    66.5,
    98720659.85,
    '{"agricultura": 15.7, "industria": 16.4, "servicos": 67.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4be08013-afa6-4ea4-8c0e-c2b81845c820',
    '1711803',
    2019,
    2106.57,
    29195.05,
    58.2,
    210656859.06,
    '{"agricultura": 12.0, "industria": 27.0, "servicos": 61.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '06e4dd4f-eb96-4af2-b9ea-df9bba6508e0',
    '1711803',
    2020,
    2057.97,
    30704.05,
    58.8,
    205796975.59,
    '{"agricultura": 14.4, "industria": 22.4, "servicos": 63.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'cdce2f22-04f3-475f-a670-a47702d428db',
    '1711803',
    2021,
    2159.95,
    31411.52,
    65.2,
    215995008.41,
    '{"agricultura": 10.5, "industria": 15.3, "servicos": 74.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6157efe8-c618-467f-b4ed-539f0849b040',
    '1711803',
    2022,
    1972.5,
    28703.45,
    69.7,
    197250105.9,
    '{"agricultura": 19.0, "industria": 16.3, "servicos": 64.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '537ab2ea-dc68-4ec0-8d86-7142a93fc665',
    '1711803',
    2023,
    2436.86,
    34805.38,
    57.5,
    243686415.86,
    '{"agricultura": 7.8, "industria": 15.6, "servicos": 76.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3b95947d-459b-41a6-975d-50c3d85e24b4',
    '1711902',
    2019,
    242.54,
    25498.51,
    64.6,
    33955861.94,
    '{"agricultura": 5.8, "industria": 25.7, "servicos": 68.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3c6ad7bb-b76b-41d0-a0de-d95dfc802621',
    '1711902',
    2020,
    293.79,
    30612.92,
    61.0,
    41130900.4,
    '{"agricultura": 6.0, "industria": 16.2, "servicos": 77.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '105c1a04-87fa-41ce-b92d-ed74f6a0a6e3',
    '1711902',
    2021,
    257.63,
    25601.36,
    69.5,
    36067709.06,
    '{"agricultura": 17.9, "industria": 22.2, "servicos": 60.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '242ce532-c51d-4359-9300-a81bf6536f37',
    '1711902',
    2022,
    247.26,
    23602.88,
    56.8,
    34616928.53,
    '{"agricultura": 20.1, "industria": 27.0, "servicos": 52.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'df31c863-3053-4ee1-bd71-82b2c759e831',
    '1711902',
    2023,
    258.12,
    24941.63,
    63.8,
    36136924.64,
    '{"agricultura": 5.6, "industria": 21.2, "servicos": 73.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6558e680-fba0-4213-845f-37db7790ed43',
    '1711951',
    2019,
    229.07,
    23928.24,
    55.0,
    32069108.13,
    '{"agricultura": 18.5, "industria": 21.6, "servicos": 59.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '59d56f4b-1158-45a0-8946-e55f5700a6bf',
    '1711951',
    2020,
    266.49,
    26422.23,
    62.5,
    37309250.73,
    '{"agricultura": 19.2, "industria": 34.0, "servicos": 46.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f4600246-af25-4d47-9643-80d79c401856',
    '1711951',
    2021,
    248.73,
    24285.61,
    68.0,
    34822651.77,
    '{"agricultura": 24.2, "industria": 25.8, "servicos": 50.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '203497a7-1c2b-4db8-b2ae-1992f89e9452',
    '1711951',
    2022,
    251.08,
    24678.57,
    66.9,
    35151169.13,
    '{"agricultura": 21.6, "industria": 27.3, "servicos": 51.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '84040cf6-8da3-4379-9667-b0bab111a62b',
    '1711951',
    2023,
    281.2,
    28930.22,
    62.9,
    39368249.44,
    '{"agricultura": 13.3, "industria": 34.5, "servicos": 52.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '69584713-773f-40a7-85bf-8c1fd3b83662',
    '1712009',
    2019,
    636.26,
    22299.86,
    60.1,
    84834599.05,
    '{"agricultura": 12.8, "industria": 18.0, "servicos": 69.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '24f2fae0-d13d-4fb6-a92f-6b148ba97fd8',
    '1712009',
    2020,
    654.9,
    21880.38,
    57.5,
    87320238.05,
    '{"agricultura": 12.8, "industria": 33.1, "servicos": 54.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '453b7afa-b40d-47c2-8385-84bb892597f9',
    '1712009',
    2021,
    657.75,
    22822.68,
    68.8,
    87699955.95,
    '{"agricultura": 8.8, "industria": 32.1, "servicos": 59.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a7e6faa7-24a3-44ba-8190-28062d7e1c02',
    '1712009',
    2022,
    603.03,
    19646.54,
    68.4,
    80404130.93,
    '{"agricultura": 20.7, "industria": 27.3, "servicos": 52.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3288f670-406e-45a0-8a44-733c65d654c5',
    '1712009',
    2023,
    724.44,
    23341.94,
    55.9,
    96592050.35,
    '{"agricultura": 12.3, "industria": 25.2, "servicos": 62.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8f38894a-3563-4b84-85e9-bb304dbbf3fa',
    '1712157',
    2019,
    229.13,
    23962.56,
    69.3,
    32078196.79,
    '{"agricultura": 18.6, "industria": 34.9, "servicos": 46.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0fc3645d-7176-4c70-859f-ed56fe016e02',
    '1712157',
    2020,
    273.01,
    28317.1,
    56.0,
    38220719.95,
    '{"agricultura": 7.5, "industria": 22.0, "servicos": 70.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6855ecb5-2c93-4d36-8dc0-5b9b0b5a8cb6',
    '1712157',
    2021,
    290.53,
    29160.89,
    57.3,
    40674188.44,
    '{"agricultura": 16.8, "industria": 24.3, "servicos": 58.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8d5de7af-fb9d-4057-ab3c-60f08c2e18c2',
    '1712157',
    2022,
    309.11,
    31841.07,
    64.1,
    43275837.13,
    '{"agricultura": 24.7, "industria": 25.4, "servicos": 49.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6eee3c30-a363-4988-a4a2-febb31b6c688',
    '1712157',
    2023,
    254.41,
    26374.95,
    63.3,
    35617784.99,
    '{"agricultura": 10.6, "industria": 34.8, "servicos": 54.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b63c00d7-0d43-4dd1-ac04-52cd96ad9ab4',
    '1712405',
    2019,
    262.04,
    25539.83,
    56.2,
    36685412.01,
    '{"agricultura": 11.2, "industria": 27.6, "servicos": 61.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '514ad881-e8ab-4a25-a3aa-590fc898ba6a',
    '1712405',
    2020,
    232.51,
    24126.79,
    56.4,
    32551381.61,
    '{"agricultura": 20.1, "industria": 32.1, "servicos": 47.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '296a2c9d-5889-45bf-995b-586a7c615333',
    '1712405',
    2021,
    261.63,
    27031.01,
    63.1,
    36628639.32,
    '{"agricultura": 13.5, "industria": 27.2, "servicos": 59.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '562790cb-cdeb-4151-9587-be9fc1cd2c25',
    '1712405',
    2022,
    259.54,
    24732.34,
    62.3,
    36335760.17,
    '{"agricultura": 15.0, "industria": 23.5, "servicos": 61.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f1ccfaee-1a03-450e-b8d6-540f1d40ada3',
    '1712405',
    2023,
    309.68,
    29673.9,
    57.9,
    43354748.19,
    '{"agricultura": 24.4, "industria": 30.8, "servicos": 44.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e4dfd3f2-a5b7-4895-826c-537f1f28418d',
    '1712454',
    2019,
    1946.74,
    28312.17,
    55.2,
    194674451.06,
    '{"agricultura": 6.2, "industria": 27.0, "servicos": 66.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ba2f53dc-39cb-4744-a207-c7c0a12ba2cc',
    '1712454',
    2020,
    2218.47,
    30514.56,
    60.3,
    221846972.56,
    '{"agricultura": 16.7, "industria": 27.2, "servicos": 56.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a43741a9-5e2b-4e66-bb9c-60442f74a678',
    '1712454',
    2021,
    2040.76,
    30517.0,
    59.9,
    204076362.58,
    '{"agricultura": 12.7, "industria": 29.0, "servicos": 58.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ac471b03-d7b8-4649-ae80-e4884ef4210c',
    '1712454',
    2022,
    1999.66,
    30062.36,
    67.4,
    199965794.77,
    '{"agricultura": 20.1, "industria": 18.6, "servicos": 61.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '21fe8c3c-603e-41f9-a683-60281ed9d5c8',
    '1712454',
    2023,
    2511.06,
    36895.86,
    66.5,
    251105848.3,
    '{"agricultura": 11.2, "industria": 34.6, "servicos": 54.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '983dbe74-2688-4763-b73f-1872ac0b1ff9',
    '1712504',
    2019,
    255.61,
    25640.23,
    55.9,
    35785044.03,
    '{"agricultura": 11.7, "industria": 30.6, "servicos": 57.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ba56e167-346d-441d-b7b3-dac1c9bec520',
    '1712504',
    2020,
    290.49,
    27840.73,
    56.3,
    40668618.52,
    '{"agricultura": 11.2, "industria": 22.0, "servicos": 66.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ccdc5f28-8d83-4903-9648-219556052293',
    '1712504',
    2021,
    253.6,
    24540.7,
    59.5,
    35504507.91,
    '{"agricultura": 21.3, "industria": 25.3, "servicos": 53.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3703bd39-65d3-40cc-9c15-27d50488de6b',
    '1712504',
    2022,
    246.17,
    25669.62,
    55.9,
    34464031.05,
    '{"agricultura": 7.8, "industria": 33.7, "servicos": 58.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3476e7e7-42a1-408e-ae41-48418bf5d253',
    '1712504',
    2023,
    289.51,
    27722.98,
    55.4,
    40531543.97,
    '{"agricultura": 20.4, "industria": 22.6, "servicos": 57.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '57f9e9bd-4d24-4e37-a02b-cd60d7218b53',
    '1712702',
    2019,
    249.2,
    26223.04,
    65.7,
    34887658.39,
    '{"agricultura": 9.7, "industria": 22.3, "servicos": 67.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b5cb1be1-4747-45da-b85e-d0dc1aa149ae',
    '1712702',
    2020,
    290.93,
    30441.83,
    66.7,
    40730560.79,
    '{"agricultura": 6.3, "industria": 16.6, "servicos": 77.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '854efe15-67d6-4c81-a8ae-6797f571d13d',
    '1712702',
    2021,
    273.92,
    26112.58,
    60.8,
    38348929.95,
    '{"agricultura": 16.4, "industria": 29.8, "servicos": 53.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '440ab706-8d85-42a4-a7db-8081aa8e2384',
    '1712702',
    2022,
    310.63,
    29773.98,
    67.8,
    43488470.98,
    '{"agricultura": 23.0, "industria": 32.3, "servicos": 44.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'cbb8bbbc-2feb-48ed-a163-3518dff50ca5',
    '1712702',
    2023,
    307.32,
    31149.24,
    67.2,
    43024575.21,
    '{"agricultura": 10.5, "industria": 28.4, "servicos": 61.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '09cb7281-ff9d-4b72-a848-3763e41ca847',
    '1712801',
    2019,
    627.22,
    21049.92,
    65.2,
    83629943.34,
    '{"agricultura": 20.6, "industria": 15.7, "servicos": 63.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f811d950-a0ff-476b-a0fd-243104bb954a',
    '1712801',
    2020,
    637.91,
    21885.93,
    65.9,
    85054575.66,
    '{"agricultura": 8.0, "industria": 32.8, "servicos": 59.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '450d8934-0629-4090-8b35-765cc370d52b',
    '1712801',
    2021,
    617.81,
    20067.2,
    67.7,
    82374516.01,
    '{"agricultura": 18.1, "industria": 24.5, "servicos": 57.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c7b940a3-4708-48e1-adcd-46556c49a6a4',
    '1712801',
    2022,
    718.99,
    23505.75,
    68.2,
    95865852.41,
    '{"agricultura": 24.6, "industria": 26.3, "servicos": 49.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5174ea6c-bf6f-4379-952d-0da2fd031da6',
    '1712801',
    2023,
    765.72,
    26535.06,
    68.9,
    102096298.65,
    '{"agricultura": 8.9, "industria": 20.8, "servicos": 70.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0ac2d78d-20f2-45ce-bc79-57d427c4ed8c',
    '1713205',
    2019,
    246.83,
    24767.36,
    63.5,
    34556407.22,
    '{"agricultura": 15.6, "industria": 27.6, "servicos": 56.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e0f06799-4ffb-4a18-9045-8af9bd05a89e',
    '1713205',
    2020,
    265.21,
    26662.48,
    60.3,
    37129639.3,
    '{"agricultura": 6.6, "industria": 31.6, "servicos": 61.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4137f2e4-94d9-4ef5-8a8b-38f1d2b83c12',
    '1713205',
    2021,
    261.64,
    25213.19,
    61.5,
    36629215.3,
    '{"agricultura": 18.1, "industria": 34.9, "servicos": 47.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8042a2c8-3934-49cc-a3b5-de471c0ffc72',
    '1713205',
    2022,
    290.36,
    29989.64,
    61.3,
    40650354.9,
    '{"agricultura": 13.9, "industria": 24.0, "servicos": 62.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '69be617d-0d1f-4a54-8073-c1087a65404e',
    '1713205',
    2023,
    298.51,
    28480.78,
    65.6,
    41790992.27,
    '{"agricultura": 6.8, "industria": 25.3, "servicos": 68.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c80d395d-aba2-46e7-96d5-0227626c889b',
    '1713304',
    2019,
    240.11,
    23507.78,
    59.3,
    33615191.18,
    '{"agricultura": 24.5, "industria": 23.9, "servicos": 51.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9d010ba5-4e5d-4a98-9b3b-b03b0eec1ccf',
    '1713304',
    2020,
    251.43,
    24243.41,
    63.0,
    35199977.95,
    '{"agricultura": 11.8, "industria": 19.5, "servicos": 68.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '96de0fb7-e303-4585-abcf-d352242aa055',
    '1713304',
    2021,
    255.18,
    26644.64,
    55.4,
    35724605.46,
    '{"agricultura": 21.6, "industria": 24.2, "servicos": 54.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '50d9b181-0a0a-4364-bf96-286241ff741b',
    '1713304',
    2022,
    309.13,
    32509.47,
    61.9,
    43278559.75,
    '{"agricultura": 21.8, "industria": 23.8, "servicos": 54.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '80d88121-c335-4385-b64e-03b9bb7d1982',
    '1713304',
    2023,
    290.08,
    28032.13,
    65.1,
    40610708.31,
    '{"agricultura": 13.4, "industria": 28.9, "servicos": 57.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '579c4c71-90c7-45f2-92fd-c4195ee017cf',
    '1713700',
    2019,
    281.25,
    27595.52,
    59.2,
    39375494.0,
    '{"agricultura": 24.4, "industria": 34.9, "servicos": 40.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f6f5dd8c-d317-4baa-a0a8-625990527e1d',
    '1713700',
    2020,
    279.59,
    28492.26,
    55.4,
    39143238.92,
    '{"agricultura": 14.1, "industria": 22.9, "servicos": 63.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ff61ab38-cc32-4ada-951e-64a68620967f',
    '1713700',
    2021,
    254.23,
    24216.69,
    58.6,
    35591748.16,
    '{"agricultura": 8.9, "industria": 31.0, "servicos": 60.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '220eeaf3-02b9-4ea7-aef9-5f84285d0253',
    '1713700',
    2022,
    295.5,
    30505.28,
    59.4,
    41370655.18,
    '{"agricultura": 17.3, "industria": 15.7, "servicos": 67.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0e24bb0b-b6c2-487a-a76c-ec1005dc4d25',
    '1713700',
    2023,
    304.39,
    29688.25,
    66.5,
    42615106.57,
    '{"agricultura": 18.8, "industria": 16.7, "servicos": 64.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9b0c1b05-4ba7-45db-8560-b9ff8dd024ac',
    '1713601',
    2019,
    567.46,
    18909.81,
    57.4,
    75661931.6,
    '{"agricultura": 11.4, "industria": 33.0, "servicos": 55.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e77e518b-0e4d-4b2a-bc3d-88be6860f82f',
    '1713601',
    2020,
    605.15,
    19792.36,
    60.4,
    80686834.76,
    '{"agricultura": 8.6, "industria": 27.8, "servicos": 63.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '676af64c-c0e1-4ed4-86fd-56d124cf171c',
    '1713601',
    2021,
    621.85,
    19844.7,
    59.4,
    82913801.58,
    '{"agricultura": 10.9, "industria": 26.2, "servicos": 62.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '79bdf4b5-e8bc-4048-b26c-0a6c872af4e7',
    '1713601',
    2022,
    643.71,
    22209.28,
    67.3,
    85828500.46,
    '{"agricultura": 5.2, "industria": 16.5, "servicos": 78.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2146823c-0243-43f7-aaf0-88e42fe45ead',
    '1713601',
    2023,
    640.83,
    21193.43,
    59.4,
    85443442.42,
    '{"agricultura": 12.6, "industria": 15.3, "servicos": 72.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6b6cee92-61c5-4281-a4eb-044070cfd280',
    '1713957',
    2019,
    648.37,
    21894.06,
    61.1,
    86449442.7,
    '{"agricultura": 23.5, "industria": 15.3, "servicos": 61.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '48937fb1-d34f-41bb-b705-809cbbd16b40',
    '1713957',
    2020,
    688.43,
    22412.11,
    69.3,
    91791022.77,
    '{"agricultura": 14.0, "industria": 31.2, "servicos": 54.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a3305b4f-1c6c-4a76-a72c-bcff43dbaeea',
    '1713957',
    2021,
    686.8,
    23034.55,
    67.2,
    91573086.71,
    '{"agricultura": 9.5, "industria": 26.4, "servicos": 64.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'bbbce264-fb33-4916-9fa9-7baf3789d571',
    '1713957',
    2022,
    625.82,
    20753.32,
    62.5,
    83442170.65,
    '{"agricultura": 23.8, "industria": 29.7, "servicos": 46.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '96077e41-59f4-40db-b53c-c46c8026d03b',
    '1713957',
    2023,
    690.76,
    22487.83,
    60.4,
    92101172.71,
    '{"agricultura": 20.2, "industria": 28.7, "servicos": 51.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '88beec67-2097-41d0-b51f-b6f0c85d0fc2',
    '1714203',
    2019,
    641.31,
    21102.1,
    68.7,
    85508503.38,
    '{"agricultura": 17.1, "industria": 28.8, "servicos": 54.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'dce4da0c-cd1c-4187-8100-dfe1e7a1548d',
    '1714203',
    2020,
    696.23,
    23556.34,
    68.6,
    92830825.58,
    '{"agricultura": 16.2, "industria": 16.7, "servicos": 67.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b9e178b4-37ad-43fb-b0a4-b14b167b3844',
    '1714203',
    2021,
    727.06,
    24797.26,
    56.8,
    96940772.59,
    '{"agricultura": 7.5, "industria": 28.9, "servicos": 63.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'aa4a2eb0-8512-4aad-b85b-db145e849810',
    '1714203',
    2022,
    636.84,
    21962.2,
    56.2,
    84911727.39,
    '{"agricultura": 16.0, "industria": 25.5, "servicos": 58.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7b663c25-eb37-498a-84ec-45eeb677bfe2',
    '1714203',
    2023,
    689.86,
    22434.38,
    56.6,
    91980961.63,
    '{"agricultura": 14.9, "industria": 34.2, "servicos": 50.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e7fe7b78-ca8f-4321-9d1c-f39963066eb7',
    '1714302',
    2019,
    265.63,
    25879.96,
    63.9,
    37188469.91,
    '{"agricultura": 15.8, "industria": 15.0, "servicos": 69.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '09a42910-b5d7-4ab0-9f24-ddf7c265cd74',
    '1714302',
    2020,
    254.58,
    25019.9,
    69.1,
    35640851.14,
    '{"agricultura": 5.5, "industria": 21.8, "servicos": 72.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '007d7562-fad4-478d-b87e-b7c12f7c5a8f',
    '1714302',
    2021,
    282.34,
    28090.6,
    57.9,
    39527406.24,
    '{"agricultura": 14.3, "industria": 16.6, "servicos": 69.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'bff8de6a-cb79-4629-9d2c-56a930b73455',
    '1714302',
    2022,
    291.65,
    28099.72,
    66.8,
    40830579.66,
    '{"agricultura": 22.1, "industria": 16.5, "servicos": 61.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '02701cd5-0e08-450e-a829-e0cdf07310be',
    '1714302',
    2023,
    289.51,
    30182.35,
    55.9,
    40531269.01,
    '{"agricultura": 11.6, "industria": 20.8, "servicos": 67.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '02275eeb-f6a2-41aa-91a3-50d8fef93727',
    '1714880',
    2019,
    227.84,
    23093.57,
    56.6,
    31897759.69,
    '{"agricultura": 5.0, "industria": 26.0, "servicos": 69.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ff1b2e5c-6799-49bd-9306-bfcae0b99a29',
    '1714880',
    2020,
    269.46,
    26889.22,
    64.7,
    37723963.71,
    '{"agricultura": 13.6, "industria": 15.8, "servicos": 70.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '94f9d979-f701-4de0-87f6-d06723648219',
    '1714880',
    2021,
    261.01,
    27228.27,
    59.5,
    36541426.56,
    '{"agricultura": 9.4, "industria": 25.7, "servicos": 65.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '07da17b2-4cdb-4d99-80b2-71ad7a8ea200',
    '1714880',
    2022,
    311.86,
    31735.24,
    62.6,
    43660713.22,
    '{"agricultura": 8.6, "industria": 32.7, "servicos": 58.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4c85fcb8-a2ee-4280-a97e-7da9685406c6',
    '1714880',
    2023,
    264.95,
    25963.03,
    56.6,
    37093376.61,
    '{"agricultura": 20.4, "industria": 31.7, "servicos": 47.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8814de8e-1c91-4478-98db-711f9824f0cb',
    '1715002',
    2019,
    548.2,
    17848.0,
    62.4,
    73093514.05,
    '{"agricultura": 14.6, "industria": 25.5, "servicos": 59.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2525867c-f517-40a7-9a65-3e87066c5041',
    '1715002',
    2020,
    687.7,
    23277.04,
    66.2,
    91692911.42,
    '{"agricultura": 5.7, "industria": 18.6, "servicos": 75.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'adacd140-a97d-42f1-a743-6da1e8ea3a75',
    '1715002',
    2021,
    666.44,
    21742.71,
    69.3,
    88858088.07,
    '{"agricultura": 14.7, "industria": 25.6, "servicos": 59.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '197f0c5b-a7f9-40f3-86fb-24720ca2e994',
    '1715002',
    2022,
    697.89,
    23419.94,
    66.5,
    93052103.58,
    '{"agricultura": 21.4, "industria": 15.7, "servicos": 62.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '11b48e2a-22c4-4b9f-ac23-82c02e282c2b',
    '1715002',
    2023,
    762.99,
    25859.78,
    69.9,
    101732365.3,
    '{"agricultura": 17.0, "industria": 24.9, "servicos": 58.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '03a4556e-f26b-4d84-af42-c5cddc3ff6eb',
    '1715101',
    2019,
    229.76,
    21940.58,
    64.1,
    32166652.27,
    '{"agricultura": 20.5, "industria": 21.3, "servicos": 58.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '10b65dc4-5e0b-4c9b-a496-12144ca63023',
    '1715101',
    2020,
    264.46,
    25596.57,
    56.2,
    37024929.46,
    '{"agricultura": 12.4, "industria": 26.2, "servicos": 61.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '935c2677-a9b8-4eed-957c-53228d27bb7b',
    '1715101',
    2021,
    263.08,
    26877.73,
    60.8,
    36831089.73,
    '{"agricultura": 21.8, "industria": 33.9, "servicos": 44.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd8c71291-aa6d-4dfe-860a-b720dc029dff',
    '1715101',
    2022,
    307.4,
    32273.08,
    57.8,
    43036146.26,
    '{"agricultura": 8.1, "industria": 26.9, "servicos": 64.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '159bc449-5068-42d3-827f-4943816cd901',
    '1715101',
    2023,
    288.26,
    29450.29,
    62.7,
    40356319.02,
    '{"agricultura": 15.9, "industria": 32.3, "servicos": 51.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '051d44ab-3039-4071-a1f5-7ed5972478de',
    '1715150',
    2019,
    597.5,
    20556.63,
    63.5,
    79666529.78,
    '{"agricultura": 8.9, "industria": 22.3, "servicos": 68.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c9ea70c7-8410-44d2-9eed-841f2eebec92',
    '1715150',
    2020,
    565.69,
    18499.93,
    62.8,
    75425438.26,
    '{"agricultura": 21.2, "industria": 29.4, "servicos": 49.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '192cac22-0a26-452e-a645-3763980261b1',
    '1715150',
    2021,
    651.72,
    21304.92,
    55.6,
    86895661.66,
    '{"agricultura": 19.5, "industria": 34.8, "servicos": 45.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0841487f-4e93-44fe-af15-d69edb9800f3',
    '1715150',
    2022,
    732.09,
    24630.48,
    66.1,
    97612234.96,
    '{"agricultura": 12.4, "industria": 20.7, "servicos": 66.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd0dde2a4-a24f-4628-8541-c5d7dd9eb261',
    '1715150',
    2023,
    686.61,
    24026.57,
    62.8,
    91547632.59,
    '{"agricultura": 5.5, "industria": 21.6, "servicos": 72.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3b9a0512-bc13-4234-9b3d-c209651645b8',
    '1715259',
    2019,
    2068.07,
    30492.12,
    67.3,
    206806687.43,
    '{"agricultura": 24.9, "industria": 24.6, "servicos": 50.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '130a9201-55b6-4fd1-8184-5cb0a90bf1d1',
    '1715259',
    2020,
    2148.65,
    32201.59,
    62.0,
    214865131.85,
    '{"agricultura": 20.9, "industria": 31.5, "servicos": 47.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8d7e3e16-d7d5-4759-b799-4ef19d169e93',
    '1715259',
    2021,
    2326.62,
    32494.76,
    61.0,
    232662460.96,
    '{"agricultura": 7.4, "industria": 28.1, "servicos": 64.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3503a313-98d8-464c-ac53-24e73aa8a654',
    '1715259',
    2022,
    2109.33,
    29880.12,
    60.2,
    210932753.73,
    '{"agricultura": 20.1, "industria": 24.0, "servicos": 55.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '41ed0944-4a06-4123-8f6b-e928845e6308',
    '1715259',
    2023,
    2053.21,
    30658.59,
    63.5,
    205320605.69,
    '{"agricultura": 7.8, "industria": 19.1, "servicos": 73.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f04e6fb6-5bab-4987-a9ef-3f6b89aea623',
    '1715507',
    2019,
    2188.37,
    31518.11,
    61.4,
    218836521.75,
    '{"agricultura": 13.0, "industria": 21.9, "servicos": 65.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e5b3b93f-3839-4da3-9eeb-cc8aef682842',
    '1715507',
    2020,
    2221.96,
    30534.85,
    57.5,
    222195995.49,
    '{"agricultura": 6.2, "industria": 34.5, "servicos": 59.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '13ae2b2a-526e-409e-9c50-919c8d66c586',
    '1715507',
    2021,
    2002.76,
    29331.61,
    55.2,
    200276212.39,
    '{"agricultura": 7.2, "industria": 18.1, "servicos": 74.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b5d4ad6a-409c-4439-bae4-b3a92586df1e',
    '1715507',
    2022,
    2418.88,
    33020.91,
    62.9,
    241888035.99,
    '{"agricultura": 5.4, "industria": 24.9, "servicos": 69.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '44525e8b-2e73-40b7-864a-cbe2a6d7c6da',
    '1715507',
    2023,
    2323.94,
    32154.62,
    56.6,
    232394282.87,
    '{"agricultura": 6.6, "industria": 25.2, "servicos": 68.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0f2ad222-fc19-4937-8c45-e2664395dfe9',
    '1721000',
    2019,
    11833.33,
    37277.25,
    56.9,
    1479165989.86,
    '{"agricultura": 16.2, "industria": 25.8, "servicos": 58.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5fc867c3-08a8-4727-9752-10760d2d170d',
    '1721000',
    2020,
    11335.15,
    37545.42,
    57.4,
    1416893908.72,
    '{"agricultura": 14.6, "industria": 19.2, "servicos": 66.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ced8d6ca-fcd1-4146-9a5e-9e5e4e3ff23d',
    '1721000',
    2021,
    12345.88,
    41331.48,
    62.5,
    1543234777.91,
    '{"agricultura": 23.6, "industria": 26.4, "servicos": 50.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2a4f5332-ea3e-4ed8-acc8-b45813fb2f4e',
    '1721000',
    2022,
    12524.72,
    39739.83,
    67.8,
    1565590326.36,
    '{"agricultura": 24.4, "industria": 32.8, "servicos": 42.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f20236a4-f178-4e32-b16a-8ebaba5168f2',
    '1721000',
    2023,
    15169.08,
    49753.92,
    58.2,
    1896134389.79,
    '{"agricultura": 24.4, "industria": 23.0, "servicos": 52.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '826b18b8-2a19-4054-b408-d1b7e5cfab9d',
    '1715705',
    2019,
    615.15,
    20338.92,
    65.4,
    82020079.01,
    '{"agricultura": 13.2, "industria": 27.9, "servicos": 58.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '41a52682-9e07-46ad-9aad-1566e1c04918',
    '1715705',
    2020,
    619.2,
    21357.64,
    56.1,
    82560108.6,
    '{"agricultura": 15.5, "industria": 30.8, "servicos": 53.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '355e470b-22c7-493d-a57f-f6a384384324',
    '1715705',
    2021,
    711.11,
    24542.25,
    57.1,
    94814893.52,
    '{"agricultura": 10.2, "industria": 34.1, "servicos": 55.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3d6f1617-eb9c-4a7d-915f-4f6efdfd0a51',
    '1715705',
    2022,
    715.79,
    23378.87,
    61.0,
    95438775.33,
    '{"agricultura": 17.7, "industria": 28.7, "servicos": 53.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '927206f6-4a9e-4a98-b40f-bbd3a87d36f4',
    '1715705',
    2023,
    760.03,
    26115.97,
    58.8,
    101336939.18,
    '{"agricultura": 22.3, "industria": 17.9, "servicos": 59.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f39813fb-61f2-4cb7-9df6-423012a56df3',
    '1713809',
    2019,
    586.21,
    19609.68,
    67.3,
    78161571.36,
    '{"agricultura": 11.8, "industria": 18.7, "servicos": 69.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '120aebd0-87b7-4ae0-b3e5-1905af3249b8',
    '1713809',
    2020,
    642.28,
    21314.97,
    69.2,
    85637881.82,
    '{"agricultura": 15.9, "industria": 31.6, "servicos": 52.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7f99f42a-50f0-4b90-a592-af51ee1fec28',
    '1713809',
    2021,
    724.16,
    25242.57,
    66.7,
    96554500.59,
    '{"agricultura": 10.6, "industria": 17.9, "servicos": 71.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0e109e77-53b4-48c1-a234-b5d0b1b9e16e',
    '1713809',
    2022,
    714.07,
    24945.52,
    65.3,
    95208716.14,
    '{"agricultura": 17.9, "industria": 20.3, "servicos": 61.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b7ab4a2d-9e1a-441e-a805-5ec79a6a8688',
    '1713809',
    2023,
    762.52,
    24435.2,
    63.6,
    101669973.27,
    '{"agricultura": 6.5, "industria": 18.6, "servicos": 74.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5a325cd7-85d6-4b94-810b-2ef1bcd03de0',
    '1715754',
    2019,
    581.12,
    20079.43,
    68.4,
    77482502.94,
    '{"agricultura": 20.9, "industria": 33.7, "servicos": 45.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '545a961e-418c-4507-bcb3-5fb4c80f3f6b',
    '1715754',
    2020,
    701.32,
    23754.3,
    64.5,
    93509603.78,
    '{"agricultura": 24.3, "industria": 31.8, "servicos": 43.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1c23af5f-d4a5-42cd-93a9-4ad88e837261',
    '1715754',
    2021,
    634.59,
    21405.67,
    66.0,
    84612348.68,
    '{"agricultura": 21.5, "industria": 16.6, "servicos": 61.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '55357b41-dee2-4a92-9ec3-55b925d50191',
    '1715754',
    2022,
    650.78,
    20818.33,
    61.1,
    86770803.92,
    '{"agricultura": 20.3, "industria": 16.0, "servicos": 63.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7bff6385-c9f2-41e4-87b7-44d1c94af81f',
    '1715754',
    2023,
    674.87,
    23666.49,
    57.2,
    89983153.46,
    '{"agricultura": 5.9, "industria": 25.4, "servicos": 68.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b2c21a96-42e7-4ebf-994b-ab3961c1bf4e',
    '1716208',
    2019,
    237.16,
    23659.49,
    57.0,
    33202779.15,
    '{"agricultura": 17.7, "industria": 29.2, "servicos": 53.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5bdce75f-f4d6-4aa0-a722-60673b7a588a',
    '1716208',
    2020,
    282.47,
    26981.61,
    65.6,
    39545861.23,
    '{"agricultura": 10.5, "industria": 28.5, "servicos": 61.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8422d585-ab24-43a3-95e7-bc38c6d4e5b7',
    '1716208',
    2021,
    272.88,
    27392.3,
    64.6,
    38203498.1,
    '{"agricultura": 18.7, "industria": 29.9, "servicos": 51.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '89cd856b-6ea6-4748-8362-cc8db01efa79',
    '1716208',
    2022,
    250.35,
    25698.12,
    64.4,
    35049147.04,
    '{"agricultura": 10.8, "industria": 32.5, "servicos": 56.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd79ce891-73d0-4df6-a0ee-51e3be839deb',
    '1716208',
    2023,
    272.19,
    25952.39,
    64.2,
    38106412.07,
    '{"agricultura": 13.7, "industria": 25.8, "servicos": 60.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b3701b5a-4810-4ea5-80c7-2bd8e796d04c',
    '1716109',
    2019,
    2255.74,
    32916.12,
    65.7,
    225574185.12,
    '{"agricultura": 12.4, "industria": 25.0, "servicos": 62.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1d134e3f-812a-495f-8802-c3243f389426',
    '1716109',
    2020,
    2004.12,
    27627.81,
    68.2,
    200412169.2,
    '{"agricultura": 6.4, "industria": 34.8, "servicos": 58.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9aa5aadf-6266-4445-8f51-5d2107f8f644',
    '1716109',
    2021,
    2132.95,
    29702.71,
    56.0,
    213295153.37,
    '{"agricultura": 20.8, "industria": 25.6, "servicos": 53.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '87cb9fff-741f-4a34-a7d1-c65ec43d1912',
    '1716109',
    2022,
    1970.38,
    26835.63,
    59.7,
    197037936.47,
    '{"agricultura": 13.1, "industria": 28.0, "servicos": 58.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1c17aa48-c60b-48ae-bdd9-37fcdc86a96a',
    '1716109',
    2023,
    2046.83,
    28512.08,
    60.0,
    204682545.79,
    '{"agricultura": 21.5, "industria": 31.8, "servicos": 46.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9234c19e-f44e-478f-9485-10892447410e',
    '1716307',
    2019,
    627.27,
    21734.88,
    65.6,
    83635813.62,
    '{"agricultura": 24.2, "industria": 34.2, "servicos": 41.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0d9af322-875e-4457-b651-d5f7f305eb82',
    '1716307',
    2020,
    680.32,
    21872.58,
    68.5,
    90709947.77,
    '{"agricultura": 15.4, "industria": 20.0, "servicos": 64.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f14fe442-cfc9-40dd-b494-745f470d066e',
    '1716307',
    2021,
    578.57,
    18517.29,
    66.0,
    77143020.31,
    '{"agricultura": 5.4, "industria": 31.4, "servicos": 63.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5868b503-4918-49b9-b748-098a08f544ac',
    '1716307',
    2022,
    725.79,
    25406.64,
    65.3,
    96772205.79,
    '{"agricultura": 5.9, "industria": 20.4, "servicos": 73.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9a1b32ea-6023-4a9d-b2fa-c0cb30e853ba',
    '1716307',
    2023,
    709.52,
    23086.48,
    66.1,
    94602230.94,
    '{"agricultura": 21.6, "industria": 29.4, "servicos": 49.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '27af3e54-e081-4c84-8bb4-4c9f3a0de9a9',
    '1716505',
    2019,
    636.06,
    22008.94,
    62.2,
    84807773.46,
    '{"agricultura": 15.9, "industria": 19.1, "servicos": 65.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3c17af48-9a28-47f2-807a-b3207e976b45',
    '1716505',
    2020,
    655.22,
    20973.04,
    56.2,
    87362514.22,
    '{"agricultura": 22.9, "industria": 32.8, "servicos": 44.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '64922716-03d6-4bbc-a186-42c5c48cddff',
    '1716505',
    2021,
    619.43,
    20222.29,
    61.7,
    82590517.76,
    '{"agricultura": 23.7, "industria": 28.8, "servicos": 47.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f1c9a59c-8c24-4399-b41b-06aa231c196e',
    '1716505',
    2022,
    733.51,
    25590.0,
    69.3,
    97801564.59,
    '{"agricultura": 6.9, "industria": 30.5, "servicos": 62.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '00aa1809-720c-402c-b5b4-7cdc7906a923',
    '1716505',
    2023,
    747.84,
    25195.19,
    68.0,
    99712491.0,
    '{"agricultura": 11.3, "industria": 25.3, "servicos": 63.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '63704a5a-4ed2-4707-85f7-9582476a3072',
    '1716604',
    2019,
    611.1,
    19885.56,
    59.7,
    81480429.45,
    '{"agricultura": 13.8, "industria": 23.7, "servicos": 62.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '280d0cf2-d454-44a3-9e24-be59af00b7d7',
    '1716604',
    2020,
    646.81,
    20796.31,
    55.2,
    86240911.17,
    '{"agricultura": 22.2, "industria": 20.1, "servicos": 57.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2ac6756e-935b-4f6a-8e40-bbb147c0b734',
    '1716604',
    2021,
    640.99,
    22311.43,
    65.5,
    85464692.3,
    '{"agricultura": 15.4, "industria": 31.7, "servicos": 52.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3b5c67d4-f836-4b62-9270-5692052959c9',
    '1716604',
    2022,
    647.45,
    20776.95,
    55.9,
    86326842.57,
    '{"agricultura": 10.1, "industria": 15.6, "servicos": 74.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '06a0179a-adbd-43e5-a19e-c0c5d5f8ce5a',
    '1716604',
    2023,
    744.69,
    25204.42,
    59.1,
    99291981.51,
    '{"agricultura": 13.1, "industria": 22.5, "servicos": 64.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5512ab6b-9bc0-44d3-a787-6cca9b97c54a',
    '1716653',
    2019,
    1887.52,
    25875.61,
    62.7,
    188752200.93,
    '{"agricultura": 21.9, "industria": 27.8, "servicos": 50.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9083c1c5-c1dd-48e5-8568-c332cf0af8ec',
    '1716653',
    2020,
    2169.31,
    30356.61,
    63.4,
    216931346.66,
    '{"agricultura": 23.9, "industria": 18.2, "servicos": 57.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '93d36975-25a8-49b6-b784-2a13dd97df25',
    '1716653',
    2021,
    2021.1,
    28440.89,
    57.3,
    202109505.8,
    '{"agricultura": 15.3, "industria": 20.5, "servicos": 64.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '14c9bd44-eafd-4b5b-aba7-4947372a2576',
    '1716653',
    2022,
    2242.14,
    31007.39,
    57.5,
    224214430.12,
    '{"agricultura": 23.5, "industria": 30.2, "servicos": 46.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '630f5180-7047-4cdd-9f6e-9c9d0aec116c',
    '1716653',
    2023,
    2374.72,
    34315.21,
    59.5,
    237471582.35,
    '{"agricultura": 9.6, "industria": 16.7, "servicos": 73.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd91d8ef6-9a15-4e5e-b878-3e46cf3448b8',
    '1717008',
    2019,
    279.6,
    29314.45,
    66.1,
    39144165.58,
    '{"agricultura": 12.1, "industria": 24.4, "servicos": 63.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd5ea08ad-8a30-4e36-901b-3a841d6004f4',
    '1717008',
    2020,
    287.7,
    28735.23,
    63.1,
    40277601.6,
    '{"agricultura": 10.1, "industria": 22.9, "servicos": 66.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd99f85d7-4f3a-4ed1-b2fc-cfde5e8f12d3',
    '1717008',
    2021,
    246.49,
    24397.58,
    60.9,
    34508429.8,
    '{"agricultura": 5.3, "industria": 16.6, "servicos": 78.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0858af44-6c97-4a03-b6ea-87920c806c3b',
    '1717008',
    2022,
    294.53,
    30673.95,
    58.7,
    41234376.75,
    '{"agricultura": 9.6, "industria": 27.9, "servicos": 62.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'aad513c4-5698-4ada-9ce7-bb6a3ab53e35',
    '1717008',
    2023,
    276.23,
    28574.34,
    58.9,
    38671934.27,
    '{"agricultura": 20.6, "industria": 25.2, "servicos": 54.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '17a4329d-c72a-4d28-98dd-378b44404194',
    '1717206',
    2019,
    275.69,
    26935.67,
    59.1,
    38596121.09,
    '{"agricultura": 21.7, "industria": 20.7, "servicos": 57.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '86e00c74-b449-4f7b-bfea-dd4bfbbf8376',
    '1717206',
    2020,
    270.83,
    28191.16,
    65.1,
    37916541.39,
    '{"agricultura": 17.0, "industria": 20.5, "servicos": 62.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2f56ad73-62ce-4c70-9674-e8dd6f440ceb',
    '1717206',
    2021,
    265.3,
    26066.19,
    68.8,
    37142240.36,
    '{"agricultura": 17.1, "industria": 28.0, "servicos": 54.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e19ab2f6-5e17-4b35-90b9-1f31820211b0',
    '1717206',
    2022,
    264.82,
    26578.17,
    59.5,
    37075482.95,
    '{"agricultura": 10.6, "industria": 23.8, "servicos": 65.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '165ee04f-aac6-425a-9802-52c6fb27eab6',
    '1717206',
    2023,
    287.37,
    29120.98,
    61.8,
    40231212.49,
    '{"agricultura": 23.5, "industria": 20.7, "servicos": 55.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '96c0edda-b5ba-4c49-b2e6-b8727770dcc8',
    '1717503',
    2019,
    279.68,
    26748.67,
    56.9,
    39155768.71,
    '{"agricultura": 8.4, "industria": 32.1, "servicos": 59.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2723ff3d-0226-4bf7-8319-298925de85ed',
    '1717503',
    2020,
    252.57,
    24402.43,
    58.9,
    35359119.63,
    '{"agricultura": 12.7, "industria": 19.5, "servicos": 67.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4bf5321b-6819-46fe-9d7c-d765659d01a0',
    '1717503',
    2021,
    284.91,
    29459.75,
    67.0,
    39886740.47,
    '{"agricultura": 8.7, "industria": 23.5, "servicos": 67.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8a799856-d702-4de2-bb82-10f57617d38c',
    '1717503',
    2022,
    259.38,
    25814.08,
    66.4,
    36313175.74,
    '{"agricultura": 15.8, "industria": 34.5, "servicos": 49.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd033f549-e922-47ef-bffd-fb94e55066a7',
    '1717503',
    2023,
    315.0,
    32984.54,
    62.5,
    44100324.28,
    '{"agricultura": 17.9, "industria": 27.6, "servicos": 54.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a1a3d85b-bbe6-409f-ac28-23878771cc7f',
    '1717800',
    2019,
    263.72,
    25185.57,
    58.7,
    36920529.88,
    '{"agricultura": 10.4, "industria": 15.6, "servicos": 74.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8d2ea596-58da-4994-a0a4-0b650d4c23f0',
    '1717800',
    2020,
    289.23,
    27725.64,
    57.0,
    40492738.1,
    '{"agricultura": 7.9, "industria": 29.6, "servicos": 62.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4743c1dc-ba5f-4f8a-84f8-6596695c585c',
    '1717800',
    2021,
    301.08,
    30876.55,
    59.6,
    42150808.46,
    '{"agricultura": 19.6, "industria": 16.3, "servicos": 64.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8d4fcc47-267a-477c-87ae-e3ba15c82f46',
    '1717800',
    2022,
    259.92,
    26297.17,
    65.6,
    36388969.29,
    '{"agricultura": 7.6, "industria": 17.7, "servicos": 74.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2596405f-8a42-4a17-8004-b87edf7385ab',
    '1717800',
    2023,
    276.88,
    26424.89,
    58.6,
    38763195.3,
    '{"agricultura": 14.4, "industria": 33.8, "servicos": 51.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '04e0b5d6-5a39-4f5c-bd33-fed7d2068515',
    '1717909',
    2019,
    678.13,
    21617.76,
    62.9,
    90416986.26,
    '{"agricultura": 19.4, "industria": 31.1, "servicos": 49.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '424da9e7-f723-4758-a990-01608e64217f',
    '1717909',
    2020,
    650.35,
    22565.96,
    58.7,
    86713469.65,
    '{"agricultura": 15.5, "industria": 17.3, "servicos": 67.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e8ce8e98-2044-45d0-a3ac-ef69d97b53dd',
    '1717909',
    2021,
    589.65,
    19460.4,
    60.6,
    78620017.86,
    '{"agricultura": 8.0, "industria": 21.2, "servicos": 70.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4adf90d6-b112-4596-b287-7b5386bf264e',
    '1717909',
    2022,
    745.26,
    26003.37,
    60.1,
    99367542.9,
    '{"agricultura": 6.4, "industria": 15.1, "servicos": 78.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '43db43c1-81cd-4769-ab93-7ecf2f2c6e01',
    '1717909',
    2023,
    675.07,
    21488.05,
    58.6,
    90009159.08,
    '{"agricultura": 6.7, "industria": 25.2, "servicos": 68.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'eedd5e63-e02b-4065-af16-c76b349c76eb',
    '1718006',
    2019,
    630.6,
    21050.06,
    62.0,
    84079543.27,
    '{"agricultura": 18.8, "industria": 28.8, "servicos": 52.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '617a3cef-cc54-4ab3-878b-a4f577e0cb70',
    '1718006',
    2020,
    703.7,
    23232.15,
    62.8,
    93826890.37,
    '{"agricultura": 19.0, "industria": 26.1, "servicos": 54.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '24429338-22bd-4311-ab0c-a1d934a6acae',
    '1718006',
    2021,
    602.99,
    20482.86,
    61.0,
    80399329.51,
    '{"agricultura": 8.6, "industria": 27.0, "servicos": 64.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '184a7175-95e7-4e20-845c-dbacb4ec427a',
    '1718006',
    2022,
    660.35,
    20988.15,
    55.3,
    88046686.66,
    '{"agricultura": 13.0, "industria": 29.9, "servicos": 57.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2c2bb62d-b9ab-4515-8472-31a4d7d150cc',
    '1718006',
    2023,
    671.54,
    22942.02,
    60.7,
    89538100.1,
    '{"agricultura": 10.9, "industria": 27.6, "servicos": 61.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b0b6facf-f719-4044-9800-bfd4e178c1ff',
    '1718204',
    2019,
    1905.27,
    28604.22,
    67.0,
    190526964.69,
    '{"agricultura": 24.9, "industria": 34.0, "servicos": 41.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f6dbe1d8-9024-4d69-a15c-71ca3caa6745',
    '1718204',
    2020,
    2004.04,
    29678.43,
    65.3,
    200403601.05,
    '{"agricultura": 8.4, "industria": 16.2, "servicos": 75.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e234abcc-6a0a-4994-9da2-4cd2199b1bb6',
    '1718204',
    2021,
    1970.18,
    27256.48,
    64.7,
    197018009.93,
    '{"agricultura": 7.9, "industria": 22.2, "servicos": 69.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0c79cd0e-ea77-4c9e-b2af-7e83659a55b8',
    '1718204',
    2022,
    1986.89,
    29331.52,
    55.5,
    198688807.56,
    '{"agricultura": 5.6, "industria": 23.1, "servicos": 71.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ffd270e1-e8c7-452c-a215-9bc199384f5f',
    '1718204',
    2023,
    2228.62,
    33224.8,
    67.6,
    222862024.3,
    '{"agricultura": 22.1, "industria": 25.5, "servicos": 52.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1511dd39-8a84-4f19-9a97-b0c691aee341',
    '1718303',
    2019,
    260.15,
    25333.41,
    67.7,
    36420835.82,
    '{"agricultura": 21.7, "industria": 15.2, "servicos": 63.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b338f9b1-c7ea-4124-9269-605babe4429c',
    '1718303',
    2020,
    249.93,
    25991.52,
    58.0,
    34990821.34,
    '{"agricultura": 22.9, "industria": 31.7, "servicos": 45.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9e2469ec-f19a-4d80-970d-d20b4dd83ebd',
    '1718303',
    2021,
    292.1,
    28030.03,
    66.2,
    40894127.22,
    '{"agricultura": 14.2, "industria": 22.3, "servicos": 63.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2460a4cf-9390-4567-ba04-c2783c0ec0d4',
    '1718303',
    2022,
    297.18,
    29924.25,
    61.8,
    41604876.65,
    '{"agricultura": 22.9, "industria": 34.1, "servicos": 43.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '481a2052-19d4-4517-acd4-6b69913c8119',
    '1718303',
    2023,
    285.44,
    28684.49,
    60.1,
    39961517.1,
    '{"agricultura": 13.5, "industria": 24.5, "servicos": 62.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3c93498c-d6d5-4b55-a2e0-3657b9c4f1d1',
    '1718402',
    2019,
    649.66,
    20888.61,
    64.9,
    86620892.01,
    '{"agricultura": 6.6, "industria": 16.8, "servicos": 76.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '01ed0656-e08a-4584-b0c6-8950df592dff',
    '1718402',
    2020,
    594.76,
    18970.39,
    67.4,
    79301270.21,
    '{"agricultura": 7.7, "industria": 16.3, "servicos": 76.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3ad1064e-6a39-4143-aaef-edeec075668f',
    '1718402',
    2021,
    674.53,
    22045.62,
    66.7,
    89937309.85,
    '{"agricultura": 10.1, "industria": 17.4, "servicos": 72.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e5a8e73b-8f8d-43ba-a42d-a378d82c9096',
    '1718402',
    2022,
    705.29,
    22606.03,
    69.2,
    94038064.1,
    '{"agricultura": 18.3, "industria": 18.6, "servicos": 63.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1d5c0307-a4c8-48d6-8539-b7a373c37dce',
    '1718402',
    2023,
    636.23,
    21035.23,
    57.6,
    84830860.26,
    '{"agricultura": 6.3, "industria": 32.6, "servicos": 61.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e627a645-75aa-4f27-b4a7-1a66907e22d0',
    '1718451',
    2019,
    591.43,
    19839.21,
    67.1,
    78856883.6,
    '{"agricultura": 22.7, "industria": 29.3, "servicos": 48.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5f03892b-92e4-4014-be61-c06a2dfa159e',
    '1718451',
    2020,
    685.69,
    22881.53,
    56.6,
    91425446.04,
    '{"agricultura": 13.0, "industria": 18.1, "servicos": 68.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '846b2ca1-2d77-4b3a-b329-fef91d8e016d',
    '1718451',
    2021,
    707.4,
    24340.94,
    61.6,
    94319533.8,
    '{"agricultura": 12.0, "industria": 17.8, "servicos": 70.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ddba97a8-f15d-4747-9db8-f575fe2d39c9',
    '1718451',
    2022,
    694.79,
    23213.08,
    67.4,
    92638771.55,
    '{"agricultura": 18.2, "industria": 33.9, "servicos": 47.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'be93eb79-e766-4971-90f0-5463383a9a61',
    '1718451',
    2023,
    730.74,
    24505.19,
    66.5,
    97432635.71,
    '{"agricultura": 11.8, "industria": 32.0, "servicos": 56.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9d57d134-46ce-4e1d-ab40-a6e37c76db1d',
    '1718501',
    2019,
    256.18,
    25498.14,
    65.6,
    35865171.55,
    '{"agricultura": 22.9, "industria": 28.1, "servicos": 48.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2d8ee6d9-706f-431b-96bb-9a7ee934fb76',
    '1718501',
    2020,
    248.52,
    26148.65,
    61.3,
    34792347.02,
    '{"agricultura": 7.2, "industria": 26.8, "servicos": 65.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b28c7e9a-d3dd-4f12-8397-c05cfd8559cd',
    '1718501',
    2021,
    249.79,
    25727.53,
    69.5,
    34970402.47,
    '{"agricultura": 21.0, "industria": 22.0, "servicos": 56.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '62b35279-f3e7-4106-b771-152b066e5a98',
    '1718501',
    2022,
    305.33,
    31032.12,
    68.8,
    42745503.08,
    '{"agricultura": 16.8, "industria": 28.0, "servicos": 55.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3ef299ce-302b-4c2e-9555-fd13dbca89ad',
    '1718501',
    2023,
    311.23,
    32416.39,
    64.2,
    43572172.13,
    '{"agricultura": 21.7, "industria": 22.6, "servicos": 55.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5ce56c53-aeab-448f-ad62-940e1b74f573',
    '1718550',
    2019,
    630.04,
    20082.83,
    68.8,
    84005136.94,
    '{"agricultura": 22.7, "industria": 18.8, "servicos": 58.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1f0630f0-3e71-422a-83a9-de1366d019c3',
    '1718550',
    2020,
    626.86,
    20463.64,
    66.8,
    83581672.1,
    '{"agricultura": 12.9, "industria": 35.0, "servicos": 52.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'affe89c9-11a2-46d9-a326-8542825de8b8',
    '1718550',
    2021,
    727.39,
    23388.89,
    57.4,
    96985937.4,
    '{"agricultura": 22.7, "industria": 20.9, "servicos": 56.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ce925659-7256-4658-a1c1-08635e7df470',
    '1718550',
    2022,
    697.85,
    23594.32,
    64.9,
    93046547.86,
    '{"agricultura": 20.5, "industria": 22.4, "servicos": 57.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3793f245-893b-4bec-bc47-53e2651bb7dc',
    '1718550',
    2023,
    620.26,
    21216.35,
    60.6,
    82701344.55,
    '{"agricultura": 12.0, "industria": 19.2, "servicos": 68.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9d46acb4-e43e-4770-8f04-e9b5c8dac356',
    '1718758',
    2019,
    286.17,
    27935.68,
    56.8,
    40064237.7,
    '{"agricultura": 12.4, "industria": 26.2, "servicos": 61.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '575329c2-d491-473f-ac5c-687a1e1d2a22',
    '1718758',
    2020,
    270.19,
    26314.26,
    65.2,
    37827272.23,
    '{"agricultura": 21.2, "industria": 26.6, "servicos": 52.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '37796d8e-4674-4579-84da-f5740957ea3c',
    '1718758',
    2021,
    258.53,
    24765.84,
    69.2,
    36194278.02,
    '{"agricultura": 19.6, "industria": 19.1, "servicos": 61.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '85614e7e-2b57-4fb4-b2c5-e50f9ee54c40',
    '1718758',
    2022,
    266.19,
    27019.21,
    59.3,
    37267053.2,
    '{"agricultura": 12.2, "industria": 25.2, "servicos": 62.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'df39f9a3-5d2b-46ca-ac94-75868559be95',
    '1718758',
    2023,
    280.78,
    28459.01,
    55.7,
    39308717.03,
    '{"agricultura": 5.3, "industria": 24.5, "servicos": 70.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3275d715-1a21-4bc1-a1a2-5f91b25d138f',
    '1718659',
    2019,
    226.79,
    23757.41,
    65.3,
    31750351.95,
    '{"agricultura": 17.7, "industria": 16.6, "servicos": 65.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'aaa41dec-e1d6-4832-a5be-5e826f440a2b',
    '1718659',
    2020,
    263.41,
    25995.28,
    67.4,
    36877418.36,
    '{"agricultura": 13.5, "industria": 29.5, "servicos": 57.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1ae1a99a-006b-4559-bd1a-2d51e28dd002',
    '1718659',
    2021,
    284.65,
    28671.12,
    57.2,
    39850560.49,
    '{"agricultura": 7.2, "industria": 16.8, "servicos": 76.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '452e6210-8507-4bf1-9261-de007e97433a',
    '1718659',
    2022,
    288.15,
    29993.55,
    69.5,
    40340728.21,
    '{"agricultura": 10.8, "industria": 27.8, "servicos": 61.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '013649b9-1885-47e8-b8fc-2c3046371d77',
    '1718659',
    2023,
    312.21,
    30238.33,
    61.9,
    43709511.85,
    '{"agricultura": 20.1, "industria": 26.7, "servicos": 53.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1481d1f4-f904-4bff-aa7c-f51d0e8e5916',
    '1718709',
    2019,
    277.68,
    27972.48,
    67.0,
    38875587.28,
    '{"agricultura": 10.3, "industria": 24.8, "servicos": 64.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '70051348-54a3-473b-868c-a612188ad59c',
    '1718709',
    2020,
    260.91,
    25720.3,
    62.0,
    36526941.65,
    '{"agricultura": 15.5, "industria": 19.1, "servicos": 65.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ff4efc42-55e5-42c5-b427-e0db27b73d48',
    '1718709',
    2021,
    260.22,
    25871.82,
    56.6,
    36430631.72,
    '{"agricultura": 7.5, "industria": 27.4, "servicos": 65.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6696262c-e644-4659-9479-2ebc6b053b57',
    '1718709',
    2022,
    294.56,
    30754.01,
    61.0,
    41238662.79,
    '{"agricultura": 5.7, "industria": 27.0, "servicos": 67.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4867c316-112c-426c-ae1e-327c14c40da9',
    '1718709',
    2023,
    300.47,
    29117.81,
    63.6,
    42065333.28,
    '{"agricultura": 24.0, "industria": 28.0, "servicos": 48.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'eabc313b-460a-4893-9199-96ebfeddb3e7',
    '1718808',
    2019,
    1843.45,
    25415.01,
    69.3,
    184345230.53,
    '{"agricultura": 11.0, "industria": 20.5, "servicos": 68.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '371f6f6a-477c-4d3d-a239-c67a751681f3',
    '1718808',
    2020,
    1880.35,
    25623.76,
    59.0,
    188034859.4,
    '{"agricultura": 22.0, "industria": 26.3, "servicos": 51.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f615fb3e-17b3-4cb4-a8dc-7833d32e8a95',
    '1718808',
    2021,
    2088.31,
    30599.23,
    58.3,
    208830562.51,
    '{"agricultura": 13.0, "industria": 15.6, "servicos": 71.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a13e31a6-9a71-4951-8235-0be7dae853e5',
    '1718808',
    2022,
    2087.42,
    31234.3,
    57.5,
    208741946.73,
    '{"agricultura": 12.5, "industria": 25.3, "servicos": 62.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8ede0e63-a0d5-4f70-8749-fe379c1b95d6',
    '1718808',
    2023,
    2178.73,
    31831.37,
    55.2,
    217872970.18,
    '{"agricultura": 12.4, "industria": 17.9, "servicos": 69.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5d1276be-8811-4bbd-ac1e-27d2e4844c29',
    '1718840',
    2019,
    596.38,
    19804.88,
    69.2,
    79517910.41,
    '{"agricultura": 9.4, "industria": 23.9, "servicos": 66.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '278006da-7f92-48e3-82ab-41a6da14ed1e',
    '1718840',
    2020,
    560.5,
    18988.41,
    67.4,
    74733322.85,
    '{"agricultura": 21.5, "industria": 32.2, "servicos": 46.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9b3df099-2f69-426e-820b-598a17d99305',
    '1718840',
    2021,
    592.02,
    19689.3,
    67.0,
    78935701.24,
    '{"agricultura": 15.2, "industria": 24.6, "servicos": 60.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '498e0792-8366-4e46-b018-cdf6e36f3a94',
    '1718840',
    2022,
    607.25,
    20592.5,
    63.3,
    80966964.74,
    '{"agricultura": 16.6, "industria": 21.8, "servicos": 61.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a101ecaa-eabc-4d2b-be27-6c809812233c',
    '1718840',
    2023,
    717.59,
    23380.25,
    65.9,
    95678238.1,
    '{"agricultura": 10.2, "industria": 29.5, "servicos": 60.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '48ed001b-de89-4bc4-8c6b-40a3619e58cb',
    '1718865',
    2019,
    551.37,
    19176.64,
    62.5,
    73515554.4,
    '{"agricultura": 22.1, "industria": 27.5, "servicos": 50.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e0ea01f5-9461-402d-b5a9-bfb4e062df17',
    '1718865',
    2020,
    562.02,
    18449.34,
    69.4,
    74936297.47,
    '{"agricultura": 14.9, "industria": 18.9, "servicos": 66.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '749b859a-f065-4277-b182-f00157143e4a',
    '1718865',
    2021,
    639.57,
    20830.8,
    68.6,
    85275741.43,
    '{"agricultura": 5.7, "industria": 26.2, "servicos": 68.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8c17f285-6997-46f3-9481-0cbabb4b057e',
    '1718865',
    2022,
    649.34,
    21474.17,
    69.5,
    86578135.72,
    '{"agricultura": 15.7, "industria": 33.3, "servicos": 51.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0479864a-7508-4ea8-bec1-8467ab8ee14f',
    '1718865',
    2023,
    700.38,
    23841.03,
    60.4,
    93383716.11,
    '{"agricultura": 24.5, "industria": 27.2, "servicos": 48.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'dca260b6-1dc3-4308-9bb1-123ad6ba6790',
    '1718881',
    2019,
    548.39,
    18123.35,
    63.5,
    73119263.11,
    '{"agricultura": 14.6, "industria": 20.1, "servicos": 65.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '243724aa-5e9d-40ad-8f08-18bf0ffb09b7',
    '1718881',
    2020,
    684.8,
    22449.53,
    68.7,
    91306745.74,
    '{"agricultura": 17.7, "industria": 32.1, "servicos": 50.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6947667f-4531-449d-9b20-5e9602dc0780',
    '1718881',
    2021,
    637.13,
    21894.57,
    59.3,
    84950939.99,
    '{"agricultura": 23.2, "industria": 34.0, "servicos": 42.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ce5f6130-a99c-49d7-9937-382aa8b29a3c',
    '1718881',
    2022,
    685.37,
    22718.4,
    66.7,
    91382508.42,
    '{"agricultura": 19.4, "industria": 19.4, "servicos": 61.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '59be674a-a811-40f1-88db-2f7bba4abcef',
    '1718881',
    2023,
    720.64,
    24320.56,
    62.5,
    96085658.47,
    '{"agricultura": 6.8, "industria": 30.8, "servicos": 62.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'e0642665-0219-4a4c-b3cd-417f0515ea62',
    '1718899',
    2019,
    679.26,
    21894.63,
    62.9,
    90567883.71,
    '{"agricultura": 18.5, "industria": 24.6, "servicos": 56.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'fd95a101-fa52-4519-8a3a-5d23a23c9c29',
    '1718899',
    2020,
    575.27,
    19336.13,
    62.5,
    76702568.69,
    '{"agricultura": 24.5, "industria": 19.9, "servicos": 55.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9dd79f92-81ba-4338-87f3-8cd2f3c0f459',
    '1718899',
    2021,
    573.56,
    18938.12,
    64.2,
    76474643.42,
    '{"agricultura": 10.5, "industria": 31.7, "servicos": 57.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0d0f3186-dbca-4866-9b92-2276c42305d4',
    '1718899',
    2022,
    736.85,
    24743.16,
    63.5,
    98246841.93,
    '{"agricultura": 14.9, "industria": 35.0, "servicos": 50.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b70932d7-54ee-48d4-94e6-c4a17dbffe89',
    '1718899',
    2023,
    750.88,
    26128.58,
    63.7,
    100117756.03,
    '{"agricultura": 17.4, "industria": 26.8, "servicos": 55.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'fc1e7bcd-7dc2-4f50-aaff-2a4285d06a62',
    '1718907',
    2019,
    675.82,
    22538.66,
    56.6,
    90109577.63,
    '{"agricultura": 22.8, "industria": 23.0, "servicos": 54.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '476c79f7-27ba-40d9-abcd-e8a9d4d00f7a',
    '1718907',
    2020,
    648.06,
    21120.32,
    60.9,
    86407434.12,
    '{"agricultura": 12.7, "industria": 28.8, "servicos": 58.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '14628f92-5c2e-4ba1-a7bd-988baf5c265b',
    '1718907',
    2021,
    644.93,
    20806.06,
    62.6,
    85990076.05,
    '{"agricultura": 7.3, "industria": 17.9, "servicos": 74.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '682e1b2d-f335-491b-9bb1-7dbcc2f5958a',
    '1718907',
    2022,
    734.66,
    23375.96,
    61.0,
    97954634.61,
    '{"agricultura": 14.1, "industria": 22.1, "servicos": 63.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ee9d65ab-efe5-40ef-8dc6-eec89f968bab',
    '1718907',
    2023,
    605.69,
    21057.13,
    62.3,
    80758323.94,
    '{"agricultura": 13.6, "industria": 16.2, "servicos": 70.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4941ffa8-c2b5-459b-817d-4f03a3e072fd',
    '1719004',
    2019,
    245.86,
    25554.34,
    67.9,
    34420160.36,
    '{"agricultura": 11.8, "industria": 20.1, "servicos": 68.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd7e17ae3-bea5-4289-8fff-8e5d43462f54',
    '1719004',
    2020,
    246.7,
    24515.62,
    57.8,
    34538094.98,
    '{"agricultura": 22.8, "industria": 32.0, "servicos": 45.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'cbbfe7a6-e6f9-4f1d-a908-c57016508f56',
    '1719004',
    2021,
    274.31,
    26442.42,
    58.7,
    38403919.64,
    '{"agricultura": 20.0, "industria": 30.4, "servicos": 49.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8e341f53-4eca-4740-860c-c0aabc242f3d',
    '1719004',
    2022,
    286.32,
    29862.76,
    63.4,
    40085381.97,
    '{"agricultura": 23.6, "industria": 28.6, "servicos": 47.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9e4c5907-bbb1-4d9b-b247-6a9e756bcd03',
    '1719004',
    2023,
    287.53,
    28397.8,
    55.6,
    40253876.47,
    '{"agricultura": 13.0, "industria": 20.3, "servicos": 66.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '66eca425-5a1e-4def-bc0d-0cd45f678c62',
    '1720002',
    2019,
    260.18,
    26468.16,
    60.5,
    36425476.05,
    '{"agricultura": 10.0, "industria": 17.0, "servicos": 73.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '80ea5d75-493d-4f2c-b98b-d0683a5d00b2',
    '1720002',
    2020,
    254.07,
    26476.23,
    59.8,
    35569226.5,
    '{"agricultura": 10.9, "industria": 21.2, "servicos": 67.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '879d4614-1e12-4004-94ff-08d95f1a6f53',
    '1720002',
    2021,
    251.58,
    24560.91,
    69.6,
    35220842.17,
    '{"agricultura": 9.9, "industria": 17.9, "servicos": 72.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '03839828-614d-4d00-9655-11b4ff9b1276',
    '1720002',
    2022,
    276.04,
    26339.84,
    55.0,
    38645817.2,
    '{"agricultura": 11.8, "industria": 24.6, "servicos": 63.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '47d43de7-a916-436d-b6ce-484f984d5df7',
    '1720002',
    2023,
    269.76,
    26405.37,
    60.7,
    37766021.63,
    '{"agricultura": 14.0, "industria": 25.7, "servicos": 60.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f4a8c0ca-cc46-489c-9760-3e8ef823a7eb',
    '1720655',
    2019,
    247.48,
    23789.59,
    59.1,
    34647636.71,
    '{"agricultura": 14.6, "industria": 33.9, "servicos": 51.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '37011a4b-824e-4186-ae16-ef572493021e',
    '1720655',
    2020,
    280.04,
    27779.11,
    63.9,
    39205765.12,
    '{"agricultura": 14.3, "industria": 19.6, "servicos": 66.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a016d9e5-7154-4087-9bef-9b2689ab18c7',
    '1720655',
    2021,
    249.35,
    25563.44,
    58.9,
    34908414.29,
    '{"agricultura": 5.4, "industria": 22.0, "servicos": 72.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'cbb5a7eb-54d8-45ed-add2-ee19ef150183',
    '1720655',
    2022,
    302.14,
    29136.1,
    56.4,
    42299795.46,
    '{"agricultura": 15.3, "industria": 21.3, "servicos": 63.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd0e30c38-b1a0-43ef-9664-b992fbf87028',
    '1720655',
    2023,
    273.12,
    26150.47,
    60.0,
    38236166.59,
    '{"agricultura": 16.1, "industria": 25.4, "servicos": 58.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '087232e0-1660-4b1f-9f40-4d2d82761911',
    '1720853',
    2019,
    2218.62,
    33331.56,
    57.3,
    221861536.59,
    '{"agricultura": 24.6, "industria": 18.4, "servicos": 57.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'aa8a40f8-004e-4e35-bf28-0ebee1b97a21',
    '1720853',
    2020,
    1854.37,
    27289.08,
    69.0,
    185437458.56,
    '{"agricultura": 17.5, "industria": 32.1, "servicos": 50.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7d37a22a-364f-4a51-af14-fb110462023f',
    '1720853',
    2021,
    2100.77,
    31116.04,
    63.1,
    210076843.52,
    '{"agricultura": 18.4, "industria": 15.3, "servicos": 66.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7c1125ed-dc72-47df-951d-3d48d43da05d',
    '1720853',
    2022,
    2216.12,
    30609.01,
    64.7,
    221612327.71,
    '{"agricultura": 22.1, "industria": 19.7, "servicos": 58.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b6dddddc-4f3b-41bb-9a7f-083fe9220b7a',
    '1720853',
    2023,
    2040.02,
    28789.09,
    55.8,
    204002364.9,
    '{"agricultura": 12.5, "industria": 29.2, "servicos": 58.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3ae3feac-dad4-432b-a0f7-51e9b40e2be0',
    '1720101',
    2019,
    2012.62,
    28973.18,
    62.1,
    201262226.43,
    '{"agricultura": 15.6, "industria": 31.5, "servicos": 52.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a9716dae-347c-4066-adac-8bdc26e46236',
    '1720101',
    2020,
    2352.26,
    32027.1,
    55.7,
    235226233.67,
    '{"agricultura": 12.1, "industria": 25.8, "servicos": 62.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b7ce2c29-464a-4550-b621-eb2841a17a83',
    '1720101',
    2021,
    2109.69,
    30001.67,
    68.4,
    210968717.99,
    '{"agricultura": 14.5, "industria": 30.6, "servicos": 55.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b8a9b86c-99db-4487-b64e-c67450e15281',
    '1720101',
    2022,
    2284.89,
    33327.31,
    56.3,
    228488691.46,
    '{"agricultura": 9.0, "industria": 31.0, "servicos": 60.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '539179d0-6fe9-4763-aaa5-7b72bd2ed65b',
    '1720101',
    2023,
    2315.79,
    34322.26,
    62.8,
    231579156.64,
    '{"agricultura": 7.6, "industria": 26.0, "servicos": 66.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd33fc3d5-77ac-428e-aa6f-a17140c767a4',
    '1720150',
    2019,
    257.67,
    26236.87,
    60.7,
    36074124.28,
    '{"agricultura": 9.4, "industria": 25.9, "servicos": 64.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '662d64dc-1de6-46ec-bd13-86a40f421123',
    '1720150',
    2020,
    274.23,
    26583.11,
    64.2,
    38392384.32,
    '{"agricultura": 15.3, "industria": 15.7, "servicos": 69.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'adfc5469-b78e-4de1-8c54-6401a424c3e6',
    '1720150',
    2021,
    273.61,
    28450.38,
    69.3,
    38305020.73,
    '{"agricultura": 14.0, "industria": 30.4, "servicos": 55.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '81afd585-3bea-4e46-836a-a825da8667b0',
    '1720150',
    2022,
    295.66,
    28352.57,
    58.7,
    41392477.87,
    '{"agricultura": 12.3, "industria": 15.6, "servicos": 72.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9684dca2-0d7a-4924-8958-0ca2a1c9c53a',
    '1720150',
    2023,
    294.92,
    29073.58,
    69.8,
    41289130.87,
    '{"agricultura": 23.8, "industria": 30.9, "servicos": 45.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2c64a1a2-a6d0-4064-ba38-87345f7dda20',
    '1720200',
    2019,
    259.74,
    25517.23,
    66.2,
    36363588.33,
    '{"agricultura": 24.2, "industria": 15.8, "servicos": 60.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '191bd45e-cae9-4fae-ac91-a13a43f12989',
    '1720200',
    2020,
    235.65,
    22556.9,
    58.8,
    32991268.66,
    '{"agricultura": 13.6, "industria": 32.1, "servicos": 54.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c664c955-8e7a-46e4-b167-3e926f1c9a23',
    '1720200',
    2021,
    278.26,
    28310.22,
    55.6,
    38956562.09,
    '{"agricultura": 18.5, "industria": 27.4, "servicos": 54.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3a434caf-19c5-47e0-b033-6bae8d803c02',
    '1720200',
    2022,
    255.98,
    25605.56,
    64.5,
    35837025.8,
    '{"agricultura": 16.9, "industria": 30.5, "servicos": 52.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '49c210c8-51ac-4407-a9b7-764d134f4d39',
    '1720200',
    2023,
    320.42,
    31662.02,
    55.5,
    44858747.27,
    '{"agricultura": 11.2, "industria": 20.7, "servicos": 68.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9efc8111-82e7-4f63-abdf-a15c590e27f9',
    '1720259',
    2019,
    570.12,
    19865.39,
    61.4,
    76015594.03,
    '{"agricultura": 11.9, "industria": 30.7, "servicos": 57.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c1f064ad-1877-4952-8994-832c8352a478',
    '1720259',
    2020,
    660.74,
    23007.73,
    58.8,
    88098142.53,
    '{"agricultura": 16.9, "industria": 25.1, "servicos": 58.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '90287d0f-f23c-49e9-9e42-88ff077f9774',
    '1720259',
    2021,
    578.71,
    19932.76,
    58.5,
    77161056.36,
    '{"agricultura": 11.7, "industria": 22.9, "servicos": 65.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'cb5b5d01-3179-4a54-ba9c-6d13dc8b6546',
    '1720259',
    2022,
    723.4,
    25103.24,
    64.9,
    96453338.91,
    '{"agricultura": 8.8, "industria": 16.5, "servicos": 74.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '11197d04-7265-4a03-b78d-e7dc21d99843',
    '1720259',
    2023,
    650.69,
    20991.27,
    56.6,
    86758314.12,
    '{"agricultura": 8.3, "industria": 22.8, "servicos": 68.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '93813b23-ae25-41e9-b663-d2395b92cd80',
    '1720309',
    2019,
    574.33,
    19785.3,
    63.8,
    76577017.65,
    '{"agricultura": 10.2, "industria": 31.1, "servicos": 58.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '630f1dfc-e044-4230-811a-3996144cc192',
    '1720309',
    2020,
    632.47,
    20361.43,
    58.0,
    84328907.64,
    '{"agricultura": 22.2, "industria": 21.0, "servicos": 56.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '0022906d-0f71-4b9b-b6a4-334c85795fad',
    '1720309',
    2021,
    606.98,
    20390.45,
    59.9,
    80931065.41,
    '{"agricultura": 20.7, "industria": 27.8, "servicos": 51.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6a9a205d-a0b6-4768-94a6-88f29db01e02',
    '1720309',
    2022,
    591.53,
    19481.35,
    67.7,
    78870892.78,
    '{"agricultura": 16.1, "industria": 32.4, "servicos": 51.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b0546681-db72-4da1-b8fb-5d6eb5c07e49',
    '1720309',
    2023,
    629.41,
    21478.62,
    55.3,
    83921272.14,
    '{"agricultura": 6.5, "industria": 33.0, "servicos": 60.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '87d6c069-7ab5-4e31-a38f-acf936ee1371',
    '1720499',
    2019,
    593.63,
    20412.11,
    67.5,
    79150002.63,
    '{"agricultura": 21.3, "industria": 27.1, "servicos": 51.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3e2971fa-3500-43e3-9c21-89dfc409ad2b',
    '1720499',
    2020,
    590.89,
    20251.06,
    59.9,
    78784743.09,
    '{"agricultura": 16.1, "industria": 15.7, "servicos": 68.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3b836346-658b-4a61-b056-103872df06f3',
    '1720499',
    2021,
    607.01,
    19322.77,
    59.1,
    80934084.06,
    '{"agricultura": 18.7, "industria": 21.3, "servicos": 59.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4770d658-dd86-44fe-ad9c-4ef4164c2e87',
    '1720499',
    2022,
    637.75,
    20365.76,
    70.0,
    85033852.02,
    '{"agricultura": 21.5, "industria": 25.9, "servicos": 52.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '2f2385af-07a5-498a-b20f-df85bb25f21c',
    '1720499',
    2023,
    763.87,
    24521.51,
    68.3,
    101849260.83,
    '{"agricultura": 12.0, "industria": 27.1, "servicos": 60.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ab0df2ba-f08c-4885-b197-b2125d8ee483',
    '1720804',
    2019,
    2274.97,
    33902.63,
    58.1,
    227496849.48,
    '{"agricultura": 11.1, "industria": 34.2, "servicos": 54.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '15afa0d4-99b4-4805-8e6e-bd963fd628da',
    '1720804',
    2020,
    1907.63,
    26047.29,
    56.8,
    190762569.57,
    '{"agricultura": 10.6, "industria": 15.0, "servicos": 74.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4fff4e3d-625a-4f41-a47f-ed1eed286528',
    '1720804',
    2021,
    2147.21,
    29510.92,
    56.7,
    214721425.86,
    '{"agricultura": 9.7, "industria": 25.5, "servicos": 64.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'ab622658-8e8b-4615-8ac3-7d3a549ae29f',
    '1720804',
    2022,
    2435.5,
    35105.76,
    67.0,
    243549691.01,
    '{"agricultura": 23.4, "industria": 27.0, "servicos": 49.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'bf766de9-a19d-4903-99c8-4eb87393a74e',
    '1720804',
    2023,
    2126.15,
    28960.64,
    65.3,
    212614542.45,
    '{"agricultura": 5.4, "industria": 17.6, "servicos": 77.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '471a9a14-3846-475c-9391-4a038bfe31dc',
    '1708254',
    2019,
    682.42,
    23132.13,
    60.2,
    90989460.91,
    '{"agricultura": 17.7, "industria": 25.6, "servicos": 56.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7b398725-c3ae-4bad-a332-02bf24051cea',
    '1708254',
    2020,
    609.35,
    21240.0,
    64.9,
    81247261.99,
    '{"agricultura": 15.2, "industria": 23.8, "servicos": 60.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b7ec8ef4-88f7-41b5-a0f4-6c7cd0785302',
    '1708254',
    2021,
    698.42,
    22374.52,
    58.2,
    93122736.16,
    '{"agricultura": 17.4, "industria": 17.8, "servicos": 64.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '163d0fac-ff3c-4287-9228-1d4963dc9587',
    '1708254',
    2022,
    679.35,
    23318.25,
    56.1,
    90580535.44,
    '{"agricultura": 22.5, "industria": 16.9, "servicos": 60.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5b3e6941-b869-449f-874e-dd4bab69ef95',
    '1708254',
    2023,
    655.11,
    21131.96,
    69.6,
    87348236.17,
    '{"agricultura": 7.4, "industria": 20.2, "servicos": 72.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9a3c7848-9d27-4d5c-922c-b1aab911e4e1',
    '1720903',
    2019,
    2154.04,
    32077.58,
    58.8,
    215404138.08,
    '{"agricultura": 17.9, "industria": 21.4, "servicos": 60.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f87d3216-5971-4546-83d2-e307ec149e62',
    '1720903',
    2020,
    2090.9,
    29683.03,
    68.4,
    209090229.36,
    '{"agricultura": 18.7, "industria": 16.0, "servicos": 65.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'd2a0e7b6-5cb0-43aa-8e72-e3d73b72100c',
    '1720903',
    2021,
    1988.41,
    27648.29,
    57.8,
    198840947.62,
    '{"agricultura": 15.9, "industria": 30.9, "servicos": 53.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '181c2abb-4cbb-4df3-a96c-0bb2124a5e96',
    '1720903',
    2022,
    2064.25,
    29956.18,
    69.7,
    206425043.0,
    '{"agricultura": 17.8, "industria": 31.4, "servicos": 50.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'fa2013cf-905a-4162-85f0-09567ad182e6',
    '1720903',
    2023,
    2401.98,
    35258.4,
    58.3,
    240197873.58,
    '{"agricultura": 10.2, "industria": 23.6, "servicos": 66.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '6d218402-5d0f-4aff-a1d0-4a90be0d08a8',
    '1720937',
    2019,
    568.69,
    18646.14,
    67.6,
    75825159.44,
    '{"agricultura": 9.7, "industria": 34.2, "servicos": 56.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4058b7ef-1a43-4cab-92d7-487814834ab0',
    '1720937',
    2020,
    621.73,
    20874.01,
    61.2,
    82897666.25,
    '{"agricultura": 5.5, "industria": 24.8, "servicos": 69.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '7a301fde-c37b-4a75-ad54-53ff66be9883',
    '1720937',
    2021,
    602.15,
    19949.89,
    62.4,
    80286328.36,
    '{"agricultura": 19.4, "industria": 21.4, "servicos": 59.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9d35595f-7b0d-450a-ab46-0992e688964b',
    '1720937',
    2022,
    660.02,
    21753.41,
    57.0,
    88002711.54,
    '{"agricultura": 14.8, "industria": 24.4, "servicos": 60.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a8f1e434-b771-4534-af02-dd443fb1397a',
    '1720937',
    2023,
    730.43,
    25328.84,
    57.1,
    97391076.65,
    '{"agricultura": 7.6, "industria": 34.2, "servicos": 58.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1932515f-2b16-473a-bf30-e7b7edbc579a',
    '1720978',
    2019,
    270.14,
    25776.53,
    64.9,
    37819326.86,
    '{"agricultura": 20.0, "industria": 24.7, "servicos": 55.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3394bcda-7c67-4693-8b85-906ff2bf206a',
    '1720978',
    2020,
    283.41,
    28492.44,
    64.0,
    39678003.86,
    '{"agricultura": 20.4, "industria": 15.9, "servicos": 63.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1f085872-6f1a-4f2c-88a4-0c6132a3872d',
    '1720978',
    2021,
    299.0,
    30500.52,
    60.9,
    41859528.68,
    '{"agricultura": 18.2, "industria": 15.0, "servicos": 66.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c56f6c11-e8e4-4c66-8f43-1ff480157a1a',
    '1720978',
    2022,
    287.44,
    27817.72,
    57.5,
    40241674.36,
    '{"agricultura": 10.0, "industria": 24.3, "servicos": 65.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '28c470a8-8b00-4eb8-84a2-9684ee395055',
    '1720978',
    2023,
    317.53,
    32451.04,
    65.3,
    44454684.38,
    '{"agricultura": 12.5, "industria": 22.0, "servicos": 65.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8c71dbf1-582d-417e-bb4c-150369bd4de2',
    '1721208',
    2019,
    629.15,
    20985.77,
    61.6,
    83887136.78,
    '{"agricultura": 13.9, "industria": 35.0, "servicos": 51.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'f9be41eb-de85-4e66-a939-1dfeabc7f5f1',
    '1721208',
    2020,
    637.49,
    21250.46,
    68.2,
    84998992.92,
    '{"agricultura": 18.8, "industria": 32.7, "servicos": 48.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1c5db1f4-00af-405f-9a90-99a98af4ee43',
    '1721208',
    2021,
    602.59,
    21073.23,
    64.8,
    80345216.89,
    '{"agricultura": 8.7, "industria": 32.4, "servicos": 58.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3b5ad46e-2744-44ef-97d8-30f57cc280ed',
    '1721208',
    2022,
    700.12,
    23475.96,
    63.1,
    93349821.74,
    '{"agricultura": 20.8, "industria": 27.7, "servicos": 51.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '4eeafe0d-6d16-4ab9-a3e9-a6443f8eaaf9',
    '1721208',
    2023,
    663.47,
    21153.14,
    61.3,
    88462447.8,
    '{"agricultura": 25.0, "industria": 24.0, "servicos": 51.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '34ce74c0-8d08-42c0-8701-986eba227303',
    '1721109',
    2019,
    244.4,
    24885.66,
    56.4,
    34216295.72,
    '{"agricultura": 10.9, "industria": 32.5, "servicos": 56.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '110a5ae5-a55f-45d8-81ef-0bfc8916c6dc',
    '1721109',
    2020,
    236.94,
    23559.7,
    62.2,
    33171590.22,
    '{"agricultura": 15.1, "industria": 20.6, "servicos": 64.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5c058171-d820-47bf-987e-d630efe6013d',
    '1721109',
    2021,
    250.81,
    24137.1,
    64.8,
    35113201.9,
    '{"agricultura": 16.7, "industria": 28.3, "servicos": 55.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3eb5bf03-bba9-4ae6-8b63-32dd1a351e4f',
    '1721109',
    2022,
    278.81,
    28270.81,
    67.7,
    39032942.23,
    '{"agricultura": 16.1, "industria": 24.9, "servicos": 59.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '90244409-de34-4a14-8c71-76946ec9b59b',
    '1721109',
    2023,
    290.06,
    27627.2,
    65.5,
    40608120.49,
    '{"agricultura": 22.5, "industria": 33.3, "servicos": 44.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '245162b7-695c-4267-bccb-5d73f3c077a4',
    '1721257',
    2019,
    270.58,
    26915.76,
    55.6,
    37881777.4,
    '{"agricultura": 9.4, "industria": 26.3, "servicos": 64.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'fd3dd68a-8fcb-4d66-a940-6dfe6e6629c6',
    '1721257',
    2020,
    234.93,
    24068.09,
    69.8,
    32890012.92,
    '{"agricultura": 10.5, "industria": 31.3, "servicos": 58.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '95c4803f-0e7a-40b0-aa60-164fc05d647f',
    '1721257',
    2021,
    262.86,
    27267.46,
    68.9,
    36800163.46,
    '{"agricultura": 13.5, "industria": 16.5, "servicos": 70.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '9fcff965-9a87-4f6a-b95b-b3343b258a17',
    '1721257',
    2022,
    307.61,
    31408.37,
    55.9,
    43065906.61,
    '{"agricultura": 10.3, "industria": 32.9, "servicos": 56.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'c8987ec6-4919-419f-994f-6030f3b8f703',
    '1721257',
    2023,
    259.84,
    25678.08,
    57.7,
    36377114.6,
    '{"agricultura": 20.0, "industria": 19.2, "servicos": 60.8}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '46cd6aa8-8018-4fa8-b069-a7e472cc4d12',
    '1721307',
    2019,
    275.54,
    27672.89,
    62.5,
    38575451.12,
    '{"agricultura": 23.9, "industria": 15.4, "servicos": 60.7}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b89f3361-5fbd-44c4-a4d5-7e90a52e9180',
    '1721307',
    2020,
    294.43,
    29671.72,
    58.1,
    41220543.92,
    '{"agricultura": 17.9, "industria": 22.6, "servicos": 59.5}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'bac66973-4c2a-4fa2-8eae-7619e5e6e26b',
    '1721307',
    2021,
    272.49,
    27410.24,
    66.4,
    38147929.63,
    '{"agricultura": 5.9, "industria": 21.1, "servicos": 72.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '3b128f2d-aec4-4eef-bdd9-04e70af6b370',
    '1721307',
    2022,
    293.93,
    30189.63,
    62.2,
    41149676.81,
    '{"agricultura": 13.9, "industria": 19.0, "servicos": 67.1}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '1ee21cc7-6f70-4ac9-a9d9-dcb8264e7655',
    '1721307',
    2023,
    266.62,
    26939.85,
    68.4,
    37327314.22,
    '{"agricultura": 13.2, "industria": 28.6, "servicos": 58.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '5a6b65df-fda0-43e8-ab00-a1faddd3cdac',
    '1722081',
    2019,
    283.7,
    28226.27,
    67.9,
    39718310.45,
    '{"agricultura": 23.4, "industria": 17.4, "servicos": 59.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '18fe3da7-5ac8-4772-8c13-6d8925f252e2',
    '1722081',
    2020,
    281.47,
    27434.13,
    67.4,
    39406378.4,
    '{"agricultura": 15.3, "industria": 20.2, "servicos": 64.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '117f2fe2-fa24-4d49-a895-82be9f969682',
    '1722081',
    2021,
    241.49,
    25020.02,
    63.1,
    33809049.94,
    '{"agricultura": 15.9, "industria": 23.4, "servicos": 60.6}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'b8adb530-db46-4eb9-ae0d-dfee6c295069',
    '1722081',
    2022,
    303.63,
    29189.95,
    60.0,
    42508738.05,
    '{"agricultura": 17.1, "industria": 20.0, "servicos": 62.9}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'fe4ca266-c805-4e40-ae83-944ecd959b2e',
    '1722081',
    2023,
    262.47,
    25730.29,
    63.7,
    36746455.54,
    '{"agricultura": 10.8, "industria": 24.9, "servicos": 64.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '19541bff-55b0-42ef-a1b4-a5e2a60d2ea7',
    '1722107',
    2019,
    597.73,
    20932.63,
    68.7,
    79697492.24,
    '{"agricultura": 24.5, "industria": 25.3, "servicos": 50.2}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'febab73f-1a4d-467f-84d8-1b5436086886',
    '1722107',
    2020,
    708.09,
    23881.52,
    59.1,
    94411625.48,
    '{"agricultura": 23.3, "industria": 34.5, "servicos": 42.3}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    'a5b27875-1f11-4ebe-b316-fd2899ae133c',
    '1722107',
    2021,
    633.26,
    21548.22,
    55.3,
    84434544.58,
    '{"agricultura": 12.6, "industria": 31.0, "servicos": 56.4}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '8b269d63-7929-428a-8b82-54e2dcf10ba4',
    '1722107',
    2022,
    595.95,
    18988.88,
    62.9,
    79459598.65,
    '{"agricultura": 5.7, "industria": 17.3, "servicos": 77.0}'::jsonb
);

INSERT INTO economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution)
VALUES (
    '31494eb8-52f7-49b3-9565-73ff0e95041f',
    '1722107',
    2023,
    644.0,
    20883.18,
    65.4,
    85866068.6,
    '{"agricultura": 7.3, "industria": 15.1, "servicos": 77.6}'::jsonb
);


-- Finalizar transação
COMMIT;

-- Verificação: Total de registros inseridos
SELECT COUNT(*) AS total_indicadores FROM economic_indicators;
