--
-- PostgreSQL database dump
--

\restrict vtEOybGl1fRl7CUm4hwdmHQ5gNbxF8SamBjSfhpgQm09QsaNchTLET1T4msApKV

-- Dumped from database version 16.9 (415ebe8)
-- Dumped by pg_dump version 16.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: vector; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA public;


--
-- Name: EXTENSION vector; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION vector IS 'vector data type and ivfflat and hnsw access methods';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: economic_indicators; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.economic_indicators (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    territory_id character varying NOT NULL,
    year integer NOT NULL,
    gdp real,
    gdp_per_capita real,
    employment_rate real,
    revenue real,
    sector_distribution json
);


ALTER TABLE public.economic_indicators OWNER TO neondb_owner;

--
-- Name: environmental_indicators; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.environmental_indicators (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    territory_id character varying NOT NULL,
    year integer NOT NULL,
    vegetation_coverage real,
    deforested_area real,
    water_quality real,
    co2_emissions real
);


ALTER TABLE public.environmental_indicators OWNER TO neondb_owner;

--
-- Name: indicator_metadata; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.indicator_metadata (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    dimension text NOT NULL,
    indicator_key text NOT NULL,
    indicator_name text NOT NULL,
    description text NOT NULL,
    unit text NOT NULL,
    interpretation_guide text
);


ALTER TABLE public.indicator_metadata OWNER TO neondb_owner;

--
-- Name: knowledge_base; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.knowledge_base (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    territory_id character varying,
    dimension text NOT NULL,
    content text NOT NULL,
    embedding text NOT NULL,
    metadata json,
    embedding_vector public.vector(1536)
);


ALTER TABLE public.knowledge_base OWNER TO neondb_owner;

--
-- Name: social_indicators; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.social_indicators (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    territory_id character varying NOT NULL,
    year integer NOT NULL,
    idhm real,
    population integer,
    literacy_rate real,
    income_per_capita real,
    education_metrics json,
    health_metrics json
);


ALTER TABLE public.social_indicators OWNER TO neondb_owner;

--
-- Name: territorial_indicators; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.territorial_indicators (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    territory_id character varying NOT NULL,
    year integer NOT NULL,
    urbanized_area real,
    density real,
    sanitation_coverage real,
    land_use json
);


ALTER TABLE public.territorial_indicators OWNER TO neondb_owner;

--
-- Name: territories; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.territories (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    type text NOT NULL,
    parent_id character varying,
    area real,
    metadata json,
    coordinates public.geography(Point,4326)
);


ALTER TABLE public.territories OWNER TO neondb_owner;

--
-- Data for Name: economic_indicators; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.economic_indicators (id, territory_id, year, gdp, gdp_per_capita, employment_rate, revenue, sector_distribution) FROM stdin;
19be0f53-9360-4b0e-9842-b1b8d76c4081	17	2019	50371.91	32794.98	63.6	9.514695e+09	{"servicos": 62.6, "industria": 15.3, "agricultura": 22.2}
a46e6a7e-b783-49ef-843c-8fa51988cf1c	17	2020	44660.8	27633.78	67.9	8.4359296e+09	{"servicos": 55.1, "industria": 33.8, "agricultura": 11.2}
d483e7e1-7de5-4009-8917-ed365b183861	17	2021	43999.1	27440.34	56.6	8.3109417e+09	{"servicos": 49.9, "industria": 26.1, "agricultura": 24.0}
dcba5e23-b9e6-445e-b5a0-7d1a6e3639db	17	2022	55839.74	34114.25	63	1.0547507e+10	{"servicos": 47.3, "industria": 28.9, "agricultura": 23.8}
0f6c3b2b-9303-4e0a-91a4-02de27325a55	17	2023	50171.68	31032.7	63.6	9.476874e+09	{"servicos": 50.6, "industria": 34.5, "agricultura": 14.9}
26e4de06-ef55-4f01-9880-242e797cd52b	1700251	2019	277.86	27484.03	59.7	3.8900892e+07	{"servicos": 75.1, "industria": 16.8, "agricultura": 8.0}
7fed3a79-c3b9-45cb-a5f9-f32316cf0ac4	1700251	2020	275.92	26628.13	65.8	3.8628892e+07	{"servicos": 49.9, "industria": 33.5, "agricultura": 16.6}
80c3a7e9-94bd-46ec-bbb2-7b51b2bd6018	1700251	2021	295.66	30454.93	64.2	4.1391904e+07	{"servicos": 64.0, "industria": 20.9, "agricultura": 15.1}
9791a201-970a-4e1f-bec4-446205ff9cbd	1700251	2022	300.15	29644.69	67.8	4.2021352e+07	{"servicos": 60.2, "industria": 32.0, "agricultura": 7.8}
42dd2b13-e42e-4eee-b809-fc6df7050977	1700251	2023	296.08	28400.71	67.5	4.145084e+07	{"servicos": 52.9, "industria": 31.6, "agricultura": 15.5}
9ee628e9-d70e-4351-9c7a-7c480bbf4c8d	1700301	2019	275.58	27230.89	69.8	3.8580728e+07	{"servicos": 54.3, "industria": 29.0, "agricultura": 16.7}
05b0107c-e219-4a09-b679-af3f1b753cf2	1700301	2020	273.96	28281.28	62.9	3.8354508e+07	{"servicos": 53.1, "industria": 24.4, "agricultura": 22.5}
8fa4df5c-f6ef-4df5-9540-1d96db87b030	1700301	2021	276.06	28143.73	59.1	3.8648656e+07	{"servicos": 67.4, "industria": 18.4, "agricultura": 14.2}
1907252e-1e06-494c-adf5-06a9bfe5aa2d	1700301	2022	279.91	26728.9	66.9	3.9186704e+07	{"servicos": 53.3, "industria": 25.4, "agricultura": 21.3}
4f35e385-5be3-4404-80c1-12bc39a79df4	1700301	2023	309.79	31213.52	68.7	4.3371184e+07	{"servicos": 54.4, "industria": 33.8, "agricultura": 11.8}
4fcaa131-19d7-4c06-b316-e322c0aa3b66	1700350	2019	225.24	22892.33	63.8	3.153327e+07	{"servicos": 70.9, "industria": 17.4, "agricultura": 11.6}
357f1d28-1d67-43e3-b1fc-a4a9ab472491	1700350	2020	269.84	26543.57	62.2	3.7777876e+07	{"servicos": 54.2, "industria": 28.2, "agricultura": 17.6}
fadac19a-ebb7-48f1-bdb4-1e0a85f72c6a	1700350	2021	260.08	24966.93	68.3	3.6411272e+07	{"servicos": 55.6, "industria": 31.0, "agricultura": 13.4}
ad6cfd2f-4e24-423b-acca-933e21c4d70f	1700350	2022	298.28	30983.33	66.1	4.1758708e+07	{"servicos": 76.5, "industria": 15.5, "agricultura": 7.9}
69ac4a2e-2665-4155-a117-09b4ef81cdba	1700350	2023	254.66	26455.85	63.4	3.5652968e+07	{"servicos": 52.6, "industria": 29.7, "agricultura": 17.7}
8d244a27-3fe9-4803-a67b-6ef7331a4015	1700400	2019	1874.05	27007.91	62.7	1.8740518e+08	{"servicos": 58.9, "industria": 33.4, "agricultura": 7.7}
36d5a4ee-b47a-4ed5-8d33-0c0128f2e96e	1700400	2020	2233.81	31116.81	59.9	2.2338136e+08	{"servicos": 61.0, "industria": 17.4, "agricultura": 21.6}
93418b91-2468-4283-8492-baeff24772b4	1700400	2021	2131.76	30571.62	67.5	2.1317594e+08	{"servicos": 49.1, "industria": 33.5, "agricultura": 17.4}
4f6e256c-267c-427a-9ca7-1d180e81b1b6	1700400	2022	2218.12	30680.72	64.3	2.2181243e+08	{"servicos": 62.2, "industria": 28.1, "agricultura": 9.7}
80c1c241-501c-42da-9596-757d575b7748	1700400	2023	2157.57	32323.18	66.5	2.157572e+08	{"servicos": 44.3, "industria": 31.3, "agricultura": 24.4}
bf3915a8-c321-4bfd-8746-5cbd016ed65e	1700707	2019	268.62	28258.3	65.4	3.7607276e+07	{"servicos": 51.4, "industria": 27.0, "agricultura": 21.6}
b62b1c37-d920-462b-82e6-571c652906a9	1700707	2020	265.62	27915.67	59.9	3.7186464e+07	{"servicos": 58.3, "industria": 19.7, "agricultura": 22.0}
de79f575-7e86-4552-89f4-1f6ff3102d82	1700707	2021	253.6	24384.23	58.3	3.550344e+07	{"servicos": 55.9, "industria": 28.0, "agricultura": 16.1}
b3dc1b03-cc9e-47b3-978a-19b44a969540	1700707	2022	247.72	23778.27	68.8	3.4681088e+07	{"servicos": 66.2, "industria": 19.8, "agricultura": 13.9}
ac91edec-e8b1-42ce-a84e-b60472dd44f3	1700707	2023	310.67	32667.88	68.9	4.3494016e+07	{"servicos": 58.8, "industria": 28.7, "agricultura": 12.5}
989af4c3-531c-4e31-a450-fc5962adb5ec	1701002	2019	642.56	22219.43	62.8	8.567517e+07	{"servicos": 56.6, "industria": 30.3, "agricultura": 13.1}
f95d1d2c-ed3c-47e9-9283-4b45e3f6b93b	1701002	2020	566.1	19401.58	55.2	7.5479896e+07	{"servicos": 58.5, "industria": 28.2, "agricultura": 13.3}
058a4e5f-599c-43b4-85e9-da6b6f1b5e79	1701002	2021	670.54	21548.28	57.5	8.940524e+07	{"servicos": 77.6, "industria": 15.3, "agricultura": 7.1}
7a30e60f-004a-4bf7-8e1f-ab093ac49256	1701002	2022	649.04	21154.31	58.5	8.653805e+07	{"servicos": 55.0, "industria": 21.4, "agricultura": 23.6}
033b84c5-8e7a-4e61-90d5-8ed48a18ee53	1701002	2023	662.59	22248.81	67.7	8.8345576e+07	{"servicos": 74.1, "industria": 18.7, "agricultura": 7.2}
49392db3-4471-4637-80af-9f9d823c65e4	1701051	2019	674.28	22998.05	57.8	8.9903976e+07	{"servicos": 60.3, "industria": 17.2, "agricultura": 22.5}
921511b9-8126-423a-9c23-7f35cb9de381	1701051	2020	642.26	21465.26	57.9	8.563495e+07	{"servicos": 59.4, "industria": 15.8, "agricultura": 24.8}
936922b4-9c0c-4a87-9e75-551a131056c3	1701051	2021	610.42	20282.33	66.3	8.138892e+07	{"servicos": 55.8, "industria": 26.9, "agricultura": 17.3}
c6a31cf9-6b80-4c4a-81c6-5a8d69069802	1701051	2022	626.4	20401.25	64	8.352e+07	{"servicos": 42.7, "industria": 34.6, "agricultura": 22.7}
74bef0db-a617-43d8-8f54-f8021b013af2	1701051	2023	764.05	25037.53	63.7	1.01872704e+08	{"servicos": 62.3, "industria": 32.2, "agricultura": 5.5}
36ddc7ad-3a46-4a24-a298-98132b1da71b	1701101	2019	596.51	19705.73	58.1	7.953497e+07	{"servicos": 44.5, "industria": 33.6, "agricultura": 21.9}
729c347e-21d9-4011-808a-efa736a2cb87	1701101	2020	709.94	22813.72	55.9	9.4658704e+07	{"servicos": 63.5, "industria": 18.8, "agricultura": 17.7}
9e223814-153e-4a90-9ffb-304bdf43440c	1701101	2021	579.16	18982	55.5	7.722129e+07	{"servicos": 64.5, "industria": 19.9, "agricultura": 15.6}
f960191e-74cf-4747-a487-ba75ef259c87	1701101	2022	695.49	23638.32	57.3	9.273155e+07	{"servicos": 64.4, "industria": 27.9, "agricultura": 7.7}
30dcb1e7-b126-4f43-a1b6-e105c4a2d114	1701101	2023	746.28	24619.08	55	9.9503736e+07	{"servicos": 45.8, "industria": 32.7, "agricultura": 21.5}
2c13c62e-7a73-420f-bdb5-eed2db0a3ed5	1701309	2019	239.29	23881.54	60.6	3.3501022e+07	{"servicos": 64.5, "industria": 29.5, "agricultura": 6.0}
7d3a96ef-a2cc-4fed-8182-e27bf51ca780	1701309	2020	285.48	27764.61	64.2	3.9966604e+07	{"servicos": 72.4, "industria": 17.2, "agricultura": 10.5}
a159c301-4bfa-4847-8e0a-3206499e93f6	1701309	2021	263.44	27450.17	67.9	3.68815e+07	{"servicos": 70.2, "industria": 24.1, "agricultura": 5.7}
c4a617cd-b734-450b-a017-249024795f39	1701309	2022	301.45	29522.52	57.8	4.2203616e+07	{"servicos": 57.5, "industria": 28.0, "agricultura": 14.5}
2c7fc6f9-2eb3-4455-953c-8b30a3c5e821	1701309	2023	256.34	26549.95	57.7	3.5887568e+07	{"servicos": 52.0, "industria": 27.2, "agricultura": 20.8}
2f87be09-9552-4492-9e54-fdfbaa77a426	1701903	2019	2035.61	28837.09	67	2.0356106e+08	{"servicos": 54.2, "industria": 27.5, "agricultura": 18.3}
691e0007-d159-4aab-bae4-8f0d6e0d29d1	1701903	2020	1918.47	27295.98	66.5	1.9184704e+08	{"servicos": 56.9, "industria": 33.4, "agricultura": 9.7}
c9ec37cf-be18-482f-ae03-a84a8a5c9d70	1701903	2021	2257.39	31093.91	58	2.2573867e+08	{"servicos": 57.5, "industria": 34.0, "agricultura": 8.5}
f23294f1-55f5-4cb0-8636-e3fb88bd2525	1701903	2022	2212.39	30316.26	64.6	2.2123896e+08	{"servicos": 64.5, "industria": 29.0, "agricultura": 6.5}
50cc4e1c-71e4-4b67-8c68-7f22b6a14e47	1701903	2023	2137.03	29204.38	63.6	2.1370306e+08	{"servicos": 67.4, "industria": 24.1, "agricultura": 8.5}
42015425-d8c2-4cc7-98b1-263f59800717	1702158	2019	265.11	26426.52	65.4	3.711552e+07	{"servicos": 73.8, "industria": 15.6, "agricultura": 10.6}
7d1f883e-14bb-4824-b4d3-163600e96c57	1702158	2020	237.11	23529.59	59.7	3.319508e+07	{"servicos": 61.2, "industria": 20.8, "agricultura": 18.0}
057018be-9624-4db1-85ce-11c43195b871	1702158	2021	287.17	27626.15	62.1	4.0204332e+07	{"servicos": 58.7, "industria": 24.0, "agricultura": 17.4}
f5842984-dfe0-4c77-8b09-704a3e676d6d	1702158	2022	245.8	24733.22	61.6	3.441182e+07	{"servicos": 49.9, "industria": 33.1, "agricultura": 16.9}
91d6c221-8d40-4ec2-bb85-e4dac49e2d97	1702158	2023	318.26	33180.1	55.7	4.4556888e+07	{"servicos": 58.1, "industria": 28.3, "agricultura": 13.6}
d83e80aa-a785-4fd0-aa94-c53318c508d0	1702208	2019	634.82	20445.68	60.5	8.46424e+07	{"servicos": 64.7, "industria": 15.1, "agricultura": 20.2}
812c9559-4a08-4757-a57f-aa297c8f1275	1702208	2020	565.95	19298.6	57.7	7.546012e+07	{"servicos": 77.2, "industria": 15.1, "agricultura": 7.6}
34da229a-55ca-43fe-a40a-101392da311b	1702208	2021	608.52	21142.53	67.6	8.1136584e+07	{"servicos": 48.5, "industria": 29.7, "agricultura": 21.7}
d0bba25c-5e5b-44b0-8d9a-00b11d3250ef	1702208	2022	634.72	20307.13	58.3	8.462928e+07	{"servicos": 74.2, "industria": 20.6, "agricultura": 5.2}
0db0be9f-c857-4e9c-aa71-a6dfa64c954f	1702208	2023	756.6	25738.28	59.9	1.00880344e+08	{"servicos": 61.6, "industria": 24.4, "agricultura": 14.1}
7b8c4eaf-c907-48fe-afbc-080e2ed75dba	1702000	2019	244.35	23333.36	58.3	3.4208568e+07	{"servicos": 76.6, "industria": 16.0, "agricultura": 7.4}
2aa6d55d-988c-42d6-bd16-5fed2d748c3c	1702000	2020	245.5	25533.12	68.9	3.4370132e+07	{"servicos": 64.9, "industria": 28.9, "agricultura": 6.2}
ab447aa2-b148-4561-8821-f09fe3560445	1702000	2021	261.78	25348.77	67.7	3.6648748e+07	{"servicos": 65.8, "industria": 23.0, "agricultura": 11.2}
685269e2-a0fd-48d5-b826-7e50fb578cfc	1702000	2022	252.14	24100.55	68.5	3.5299592e+07	{"servicos": 64.4, "industria": 21.9, "agricultura": 13.7}
ad3c315e-60b3-4873-9293-1443c5d640cd	1702000	2023	318.88	31522	64.2	4.464272e+07	{"servicos": 43.3, "industria": 34.1, "agricultura": 22.6}
d23a2517-c844-4783-ab2f-b2132fb22322	1702109	2019	4217.31	22659.33	61.1	4.7444733e+08	{"servicos": 60.1, "industria": 20.3, "agricultura": 19.6}
a5918c5d-b299-4ee0-bb1b-3f4b085840ac	1702109	2020	4526.09	24736.53	64.3	5.091854e+08	{"servicos": 71.8, "industria": 15.2, "agricultura": 13.0}
af4a214a-5ad0-4c9c-a3e3-bc6576fd5592	1702109	2021	4439.55	24044.08	69.1	4.9944902e+08	{"servicos": 74.8, "industria": 18.6, "agricultura": 6.6}
36d91fb0-41c8-4fa7-a4ed-829674db5f01	1702109	2022	4952.08	27323.3	64	5.5710854e+08	{"servicos": 72.9, "industria": 17.5, "agricultura": 9.6}
28c21141-919b-4b9b-b32b-b10fbd3fd05b	1702109	2023	4535.24	25360.35	66	5.1021485e+08	{"servicos": 72.7, "industria": 17.3, "agricultura": 10.0}
492cdcf6-f29a-47d6-b480-95559d287a0b	1702307	2019	274.05	27048.06	57.2	3.8367136e+07	{"servicos": 66.5, "industria": 23.9, "agricultura": 9.6}
fa71ad44-6962-4c68-8381-a2a9d0f9ecf5	1702307	2020	274.3	26324.04	64.3	3.8401508e+07	{"servicos": 70.7, "industria": 24.1, "agricultura": 5.2}
f7700e80-964a-42c6-9a20-a67fc84c4fd9	1702307	2021	298.05	31350.33	58.8	4.1726668e+07	{"servicos": 79.5, "industria": 15.0, "agricultura": 5.5}
ed8e7620-ccfd-4b03-8ffd-b986b60a9320	1702307	2022	276	29046.57	66.2	3.8640068e+07	{"servicos": 45.5, "industria": 33.2, "agricultura": 21.4}
8ba607b3-4089-42d3-bffe-14ef122eaa89	1702307	2023	295.57	28203.39	66.4	4.1380016e+07	{"servicos": 68.4, "industria": 26.0, "agricultura": 5.6}
b7d48bfd-da1d-4ac8-a4ec-e4cad697d237	1702406	2019	605.91	20718.38	58.1	8.078789e+07	{"servicos": 61.2, "industria": 17.6, "agricultura": 21.2}
870abd81-75d7-4e84-9be2-53be11cd76a4	1702406	2020	594.15	19023	68.8	7.921937e+07	{"servicos": 62.2, "industria": 28.2, "agricultura": 9.6}
4bd3cfba-2d4b-44e5-9004-2a37091df285	1702406	2021	710.22	24202.43	57.4	9.469604e+07	{"servicos": 58.8, "industria": 16.6, "agricultura": 24.6}
5387eada-fa6a-4b15-aab5-fd20fb12a88e	1702406	2022	621.39	20211.14	68.3	8.285221e+07	{"servicos": 60.6, "industria": 15.5, "agricultura": 23.9}
b925aab2-53ca-4b7e-8a8e-29bdb5b64eff	1702406	2023	611.47	19581.33	63.2	8.152884e+07	{"servicos": 65.6, "industria": 20.4, "agricultura": 14.0}
f4392f9d-14e7-4bbd-81e8-c87dfa9b5eb4	1702554	2019	629.44	20953.27	57.9	8.3924816e+07	{"servicos": 72.7, "industria": 21.4, "agricultura": 5.9}
e20b8f06-3333-4317-94d5-d137fee2de8f	1702554	2020	664.87	21705.19	58.6	8.8649784e+07	{"servicos": 54.7, "industria": 35.0, "agricultura": 10.3}
13e02f0d-57b3-4fbf-a30b-134634060ed4	1702554	2021	676.74	23144.96	61.4	9.02314e+07	{"servicos": 52.4, "industria": 24.2, "agricultura": 23.4}
b3de8f8f-fde0-41ec-9169-93e7393c3079	1702554	2022	692.47	23494.99	67.5	9.232904e+07	{"servicos": 55.2, "industria": 28.4, "agricultura": 16.4}
ab9a7f75-d41a-475b-a94f-2572a577e1c7	1702554	2023	652.59	22486.8	69.9	8.7011904e+07	{"servicos": 49.6, "industria": 34.2, "agricultura": 16.2}
d3eecb3d-cdf0-498c-a62d-453f2b50c987	1702703	2019	260.59	25195.06	59.8	3.6482956e+07	{"servicos": 62.0, "industria": 27.6, "agricultura": 10.4}
f8617cc6-3cd1-4c77-a7c8-1266b1879632	1702703	2020	277.37	28907.95	59.6	3.8832052e+07	{"servicos": 50.9, "industria": 31.4, "agricultura": 17.7}
75bb061d-51db-44ff-82e0-92d94ef5e483	1702703	2021	281.39	28150.25	63.3	3.9394584e+07	{"servicos": 58.4, "industria": 34.1, "agricultura": 7.5}
ab3ff1f9-8941-4944-bf2d-cb86d97fd4ee	1702703	2022	284.7	27296.69	63.2	3.9858624e+07	{"servicos": 62.8, "industria": 31.9, "agricultura": 5.3}
d2d4385e-320d-446f-b347-5cedb7e64831	1702703	2023	315.04	30124.67	56.4	4.4106136e+07	{"servicos": 60.1, "industria": 29.3, "agricultura": 10.6}
a0bf2bb2-8a38-4ac3-ab58-504eb84f6c16	1702901	2019	667.57	22239.15	59.4	8.9009984e+07	{"servicos": 62.3, "industria": 27.6, "agricultura": 10.1}
763cae05-2a85-41db-94af-925f066929cc	1702901	2020	615.81	21431.54	67.8	8.210851e+07	{"servicos": 56.0, "industria": 33.7, "agricultura": 10.3}
71e0d0d3-654d-4b9d-b8e4-4fb80dcc82ee	1702901	2021	681.27	23521.29	69.2	9.083608e+07	{"servicos": 58.7, "industria": 29.3, "agricultura": 12.0}
644794be-9a0d-43db-a893-9e4be5c5c084	1702901	2022	716.24	24896.13	64.7	9.549823e+07	{"servicos": 53.8, "industria": 24.8, "agricultura": 21.5}
405d715e-1396-4147-bb9d-408afd5a195a	1702901	2023	668.17	23433.93	70	8.9089544e+07	{"servicos": 55.0, "industria": 24.5, "agricultura": 20.6}
8b535c88-7822-42dd-a784-5003bdc12f97	1703008	2019	660.18	22985.17	59.4	8.8024e+07	{"servicos": 62.9, "industria": 15.5, "agricultura": 21.6}
26c1cb72-68a6-48f6-b5bf-9e694361a127	1703008	2020	570.61	18588.57	58.1	7.6081776e+07	{"servicos": 67.8, "industria": 21.8, "agricultura": 10.3}
358cac5d-0279-455d-a00b-7b1c9ec164d0	1703008	2021	644.44	22094.99	63.4	8.592596e+07	{"servicos": 56.1, "industria": 23.2, "agricultura": 20.7}
43d9223c-699b-44a1-a1a8-20f36bfae79e	1703008	2022	596.36	19340.88	56.2	7.9514224e+07	{"servicos": 50.0, "industria": 29.2, "agricultura": 20.9}
90d542f9-f41b-4a91-a2d9-2bff13701750	1703008	2023	631.97	21185.65	69.4	8.426239e+07	{"servicos": 65.5, "industria": 22.4, "agricultura": 12.1}
97ef0b4c-8a5f-4ff9-9afc-a7c3f3e83bd1	1703057	2019	1826.39	26933.56	58.3	1.8263918e+08	{"servicos": 63.3, "industria": 19.6, "agricultura": 17.1}
1b68d6d8-c6d4-4214-bf53-9e8b6b11bc0e	1703057	2020	2106.18	29226.87	59.8	2.1061758e+08	{"servicos": 58.2, "industria": 30.7, "agricultura": 11.0}
c83cef49-771e-40cd-b76f-58b3e0b99fb5	1703057	2021	2390.2	35612.42	55.2	2.3901986e+08	{"servicos": 66.3, "industria": 15.7, "agricultura": 18.0}
be457d9a-4e1f-42d7-a95f-4432d1662564	1703057	2022	1999.34	27988.66	62.7	1.9993419e+08	{"servicos": 51.2, "industria": 28.0, "agricultura": 20.8}
3856a52a-9937-48ba-89ea-5bf93962e74d	1703057	2023	2332.1	32790.61	61	2.3321008e+08	{"servicos": 49.3, "industria": 25.9, "agricultura": 24.9}
6410574d-736b-4ca1-b855-fdba4778bfd1	1703073	2019	1990.61	29799.04	61.5	1.9906059e+08	{"servicos": 53.7, "industria": 25.7, "agricultura": 20.6}
55507483-b73f-43d6-aec9-945262324e39	1703073	2020	2168.58	30688.63	57.9	2.1685811e+08	{"servicos": 54.1, "industria": 21.8, "agricultura": 24.2}
63d670c0-b101-42fc-9579-3925dc166242	1703073	2021	2255.02	31907.3	64.9	2.2550165e+08	{"servicos": 47.0, "industria": 33.8, "agricultura": 19.2}
b27c85f4-2ab2-4245-bac1-ad64f95a7816	1703073	2022	2189.63	29796.21	57.9	2.1896341e+08	{"servicos": 59.5, "industria": 31.0, "agricultura": 9.5}
9e46c63a-5b6d-4cd5-9ef7-03536ec7801b	1703073	2023	2296.94	32618.21	66.3	2.2969418e+08	{"servicos": 59.2, "industria": 25.2, "agricultura": 15.6}
13975085-1006-4916-b8aa-34afe3ecedf9	1703107	2019	642.64	21606.26	58.7	8.568468e+07	{"servicos": 67.6, "industria": 26.5, "agricultura": 5.9}
a017e839-a8fe-45f4-bced-c52b920248dd	1703107	2020	671.63	22223.07	57.6	8.9550104e+07	{"servicos": 77.0, "industria": 17.2, "agricultura": 5.7}
95ab5993-e303-495f-986b-7ff6041e629a	1703107	2021	705.15	24683.96	67.6	9.4019544e+07	{"servicos": 60.0, "industria": 28.4, "agricultura": 11.5}
5430a241-7d87-4aa1-bf60-63b0c375f7cb	1703107	2022	696.36	23524.94	55.4	9.284824e+07	{"servicos": 48.1, "industria": 35.0, "agricultura": 16.9}
c6a0edd0-f010-4708-8210-e500bf954390	1703107	2023	751.48	25535.26	58.7	1.0019697e+08	{"servicos": 58.7, "industria": 17.1, "agricultura": 24.2}
9b611e15-7b89-4699-a183-8657284e3317	1703206	2019	2133.5	29826.18	57.5	2.1334962e+08	{"servicos": 48.3, "industria": 32.3, "agricultura": 19.5}
dd1baf37-07df-43e3-a340-01643334658d	1703206	2020	1955.04	29310.13	66.7	1.9550446e+08	{"servicos": 69.0, "industria": 20.8, "agricultura": 10.2}
c4a1820e-8cdd-4caf-a689-87681e8838f2	1703206	2021	1938.78	26406.35	61.2	1.9387803e+08	{"servicos": 74.4, "industria": 15.0, "agricultura": 10.5}
8ef88c5c-faa9-420a-907f-656b2adbe6b1	1703206	2022	2360.99	32665.37	64.3	2.3609874e+08	{"servicos": 68.4, "industria": 17.2, "agricultura": 14.4}
2cec2fee-e0c2-4962-92a9-4468d2189a30	1703206	2023	2170.38	30610.08	58	2.1703774e+08	{"servicos": 58.8, "industria": 34.6, "agricultura": 6.6}
924e8d23-6b37-4608-b7de-f822d5a8372c	1703305	2019	540.55	17871.05	60.8	7.207276e+07	{"servicos": 63.4, "industria": 19.1, "agricultura": 17.4}
9620dc2b-4bf9-4281-be6e-bfffac4c1051	1703305	2020	680.63	21856.95	58.4	9.075004e+07	{"servicos": 48.8, "industria": 34.3, "agricultura": 16.9}
9c99fff1-7985-4072-83a6-a2936192f2f6	1703305	2021	613.48	20761.46	69.3	8.1797376e+07	{"servicos": 53.8, "industria": 33.8, "agricultura": 12.4}
ac93cd76-f2c7-42d1-a9d4-7010e5cf33af	1703305	2022	614.91	20521.69	68.9	8.1988256e+07	{"servicos": 66.0, "industria": 28.0, "agricultura": 6.0}
36963833-af2a-4a7e-821c-b5b460bb7707	1703305	2023	751.92	24949.93	55.4	1.0025547e+08	{"servicos": 51.1, "industria": 28.2, "agricultura": 20.6}
c5d465a8-3603-43d6-9ee0-98d59053c7ab	1703602	2019	283.52	27107.3	63.8	3.9692128e+07	{"servicos": 54.3, "industria": 23.0, "agricultura": 22.7}
8c22927c-4383-46ec-b1c9-078346f990c1	1703602	2020	271.94	27372.3	56.4	3.8072128e+07	{"servicos": 50.1, "industria": 34.9, "agricultura": 15.0}
028b7478-9d0a-4a4e-9b4a-c52c21a4680e	1703602	2021	284.78	28655.65	60.4	3.986918e+07	{"servicos": 61.4, "industria": 32.1, "agricultura": 6.5}
4635d876-f344-4a41-9a14-c5a764f437c6	1703602	2022	252.26	25652.28	56.6	3.5317032e+07	{"servicos": 57.6, "industria": 30.5, "agricultura": 11.8}
18f71837-e999-4b83-9595-65fe009a34ca	1703602	2023	300.66	30199.38	58.9	4.2093096e+07	{"servicos": 66.1, "industria": 19.0, "agricultura": 14.9}
7bd3d649-6fc2-4ce7-a486-5771f9261940	1703701	2019	579.82	19335.06	68.3	7.730932e+07	{"servicos": 58.4, "industria": 27.5, "agricultura": 14.1}
2e7033be-3bf0-4629-88db-71d307cd8ca0	1703701	2020	561.76	17871.61	55.7	7.490111e+07	{"servicos": 51.8, "industria": 29.0, "agricultura": 19.2}
56319be5-660e-4264-83ab-2a7e0046cf31	1703701	2021	685.64	21827.32	61.2	9.1418616e+07	{"servicos": 61.0, "industria": 32.5, "agricultura": 6.6}
02d42ec9-e8a0-420a-88c5-0fbcf8e4137d	1703701	2022	618.95	19914.77	63.6	8.2526824e+07	{"servicos": 61.5, "industria": 19.3, "agricultura": 19.2}
2af7b8de-6426-44a2-9e0b-48d112176245	1703701	2023	627.69	21845.7	59	8.369233e+07	{"servicos": 63.4, "industria": 26.0, "agricultura": 10.5}
88a92e17-79cb-4f30-83af-1045df9e7f80	1703800	2019	233.96	23961.2	66.9	3.2754e+07	{"servicos": 52.3, "industria": 34.6, "agricultura": 13.1}
0970fa5a-b1be-40fa-9643-5d359ccfc78e	1703800	2020	235.89	24687.13	62.8	3.3023976e+07	{"servicos": 52.5, "industria": 29.4, "agricultura": 18.0}
37e88e09-00cb-4065-9f0a-cbb5a440f25e	1703800	2021	281.5	29332.41	68.5	3.941044e+07	{"servicos": 48.7, "industria": 27.3, "agricultura": 24.0}
6d0cc169-3427-4a12-8118-d265e7a8ed4a	1703800	2022	266.03	26376.02	60.2	3.7243992e+07	{"servicos": 52.7, "industria": 25.8, "agricultura": 21.5}
205cd70f-780e-4ec2-9628-ccb013c840aa	1703800	2023	276.79	27832.44	55	3.8751108e+07	{"servicos": 63.1, "industria": 22.6, "agricultura": 14.3}
550c0461-693f-4706-8fe8-62de7e30acc5	1703826	2019	1804.89	26101.52	66	1.8048939e+08	{"servicos": 56.9, "industria": 29.8, "agricultura": 13.2}
b64cf892-0509-4f5a-a19e-f9a557eaf649	1703826	2020	1871.53	27561.44	64	1.871532e+08	{"servicos": 75.3, "industria": 19.6, "agricultura": 5.0}
f1f3afd3-c61e-4a76-8b2c-00263ad7979a	1703826	2021	2155.16	30183.1	59.1	2.1551637e+08	{"servicos": 43.8, "industria": 31.9, "agricultura": 24.3}
6e97506f-b0e4-4f1e-812a-ef634023f25c	1703826	2022	2119.96	28918.11	55.2	2.1199576e+08	{"servicos": 48.5, "industria": 32.6, "agricultura": 18.9}
e4f82696-9903-4d3b-b85a-689277276f52	1703826	2023	2081.56	30795.11	56.8	2.081565e+08	{"servicos": 49.1, "industria": 29.4, "agricultura": 21.5}
a5bc3499-9284-4dea-9d06-39950515edf2	1703842	2019	261.4	27062.69	60.3	3.6595792e+07	{"servicos": 75.6, "industria": 16.1, "agricultura": 8.3}
c5720b93-6ec2-424e-8456-7cf7bf868726	1703842	2020	237.05	22784.52	63.9	3.318702e+07	{"servicos": 63.2, "industria": 15.5, "agricultura": 21.3}
b249aa23-732f-40a9-a5cc-be113b15ff32	1703842	2021	255.6	25486.35	62.2	3.5784364e+07	{"servicos": 65.0, "industria": 27.8, "agricultura": 7.2}
f81cd98f-d64c-421e-86c8-592a3162f8dd	1703842	2022	264.58	26490.15	65.9	3.7041712e+07	{"servicos": 53.5, "industria": 28.1, "agricultura": 18.4}
80bbd759-3040-4c5e-8017-5cfa7b604eba	1703842	2023	301.03	29988.72	66.8	4.2143752e+07	{"servicos": 56.8, "industria": 32.2, "agricultura": 11.1}
415fa380-7697-4d91-acc2-2b8899ace55f	1703867	2019	2096.25	30538.03	59.4	2.0962526e+08	{"servicos": 52.9, "industria": 31.8, "agricultura": 15.2}
9329bd27-8d6d-493f-a059-d97e7c5c6f04	1703867	2020	2084.79	30326.49	60	2.0847947e+08	{"servicos": 60.7, "industria": 18.6, "agricultura": 20.7}
c0e3e5be-5a3a-4b61-b748-98436931ca96	1703867	2021	2126.93	30970.53	55.3	2.1269318e+08	{"servicos": 79.9, "industria": 15.1, "agricultura": 5.0}
bd6323fc-fa89-4bf3-84a2-cafe0e9d0080	1703867	2022	2247.7	31357	67.9	2.2477014e+08	{"servicos": 64.3, "industria": 16.8, "agricultura": 18.9}
9dba06f1-3352-4776-8656-55d46b094489	1703867	2023	2510.96	36526.23	57.8	2.510959e+08	{"servicos": 60.7, "industria": 22.8, "agricultura": 16.5}
0a569151-b1da-4a96-8cfb-ec5b609aabb5	1703883	2019	2031.96	29819.44	58.9	2.0319565e+08	{"servicos": 46.2, "industria": 33.2, "agricultura": 20.6}
2c12cb84-eea1-40b9-a6bc-b564c693ee87	1703883	2020	2210.03	31916.05	66.9	2.2100272e+08	{"servicos": 67.8, "industria": 20.2, "agricultura": 12.0}
f28880e4-d7f9-42ce-9bc1-296ba7cec7ea	1703883	2021	2396.82	34211.38	55.9	2.3968152e+08	{"servicos": 54.9, "industria": 32.9, "agricultura": 12.3}
ff8205d2-626e-405c-a7d0-71e975159183	1703883	2022	2006.34	29226.55	67.8	2.0063445e+08	{"servicos": 43.7, "industria": 34.7, "agricultura": 21.6}
4cd7e770-5c48-4a0a-9502-98c234d32e85	1703883	2023	2125.23	29787.26	61.5	2.1252315e+08	{"servicos": 51.6, "industria": 33.5, "agricultura": 14.9}
767ada93-f1b1-4e0a-9dfa-e53ed3a943f6	1703891	2019	227.22	22215.87	63.8	3.1811346e+07	{"servicos": 70.8, "industria": 15.2, "agricultura": 14.0}
36c6f0d5-7a73-40b5-b131-d1fb15f58a08	1703891	2020	242.41	25039.44	61.8	3.3936952e+07	{"servicos": 51.4, "industria": 34.0, "agricultura": 14.6}
a661ef86-0741-4bcb-9155-914ddfa5a301	1703891	2021	243.44	24973.51	65.6	3.4081848e+07	{"servicos": 55.9, "industria": 28.6, "agricultura": 15.5}
81132b29-647b-4374-953b-6c910fcbd605	1703891	2022	287.45	27970.02	56.2	4.0242708e+07	{"servicos": 63.1, "industria": 15.5, "agricultura": 21.4}
2b4ad32d-00fd-40c6-b245-dc1bcd7c00cd	1703891	2023	267.98	26564.18	57.9	3.7517128e+07	{"servicos": 70.6, "industria": 17.2, "agricultura": 12.3}
d73b15ad-16bf-49e3-a909-c6b82464b3ca	1703909	2019	606.92	21070.55	65.5	8.0922136e+07	{"servicos": 63.7, "industria": 15.1, "agricultura": 21.2}
3b8dc63e-f661-4939-8264-b64b5f21a1e8	1703909	2020	683.7	21841.22	55.4	9.1159416e+07	{"servicos": 59.6, "industria": 22.9, "agricultura": 17.5}
15560fe7-f798-454b-a6e7-72970e41ae3d	1703909	2021	614.62	19722.74	55.5	8.1949296e+07	{"servicos": 58.1, "industria": 24.4, "agricultura": 17.5}
9fe1e8d4-c0b7-462d-9a4e-24ebc216cdf4	1703909	2022	635.02	21603.12	66.1	8.466984e+07	{"servicos": 46.8, "industria": 29.7, "agricultura": 23.5}
5f9e3d0f-fa8a-441b-ab9b-7e3fc7776acb	1703909	2023	696.07	22858	58.9	9.280957e+07	{"servicos": 75.3, "industria": 15.6, "agricultura": 9.2}
56fcb71d-20f6-4f45-81ed-7143ae9ebfdc	1704105	2019	231.02	23708.8	69.7	3.2342592e+07	{"servicos": 56.3, "industria": 23.1, "agricultura": 20.7}
b718ba11-cf7b-4308-b5af-48de8be51cb6	1704105	2020	268.52	28181.88	55.3	3.759238e+07	{"servicos": 60.3, "industria": 24.1, "agricultura": 15.6}
7259f70e-5537-4e9b-a573-486c1599679f	1704105	2021	279.38	28188.77	61.5	3.9113052e+07	{"servicos": 70.1, "industria": 21.5, "agricultura": 8.3}
9d30ea97-f663-4ddd-9ca1-ffbfa38a748b	1704105	2022	293.1	30382.26	67.2	4.1033668e+07	{"servicos": 58.3, "industria": 17.2, "agricultura": 24.5}
d90b302d-e9d1-434f-bc54-2bcfe2d60c81	1704105	2023	303.35	29909.78	69.2	4.24683e+07	{"servicos": 65.3, "industria": 23.6, "agricultura": 11.2}
91a48716-5a07-4743-96df-1879f310b0c5	1705102	2019	605.57	20295.2	61.3	8.074241e+07	{"servicos": 51.5, "industria": 26.6, "agricultura": 21.9}
3393d9aa-fbe4-4bd1-9b69-ab2c30a23867	1705102	2020	591.37	20740.24	57.1	7.8848856e+07	{"servicos": 46.7, "industria": 30.5, "agricultura": 22.9}
983e71ac-a10f-4b3d-ab00-3583e1464129	1705102	2021	720.13	24053.34	57.7	9.6017736e+07	{"servicos": 60.4, "industria": 26.1, "agricultura": 13.5}
75dd94b8-b1d2-4108-94be-5ba36a4a0911	1705102	2022	649.3	22251.53	57.6	8.6573296e+07	{"servicos": 61.2, "industria": 29.2, "agricultura": 9.7}
2bdb2d96-ffa5-4802-bb53-ddd88af12126	1705102	2023	692.26	22869.57	59.4	9.2301576e+07	{"servicos": 54.8, "industria": 26.1, "agricultura": 19.1}
57b550fa-5795-43bc-a1a0-bada80c6d69a	1704600	2019	265.41	27079.69	60.2	3.7157132e+07	{"servicos": 55.3, "industria": 28.8, "agricultura": 15.8}
4de5c332-0895-4120-ba74-d611978a71d3	1704600	2020	251.39	24102.31	58.5	3.5194196e+07	{"servicos": 59.8, "industria": 22.9, "agricultura": 17.3}
ccc7f52e-cd06-43ad-8f16-bbb762ed6f3c	1704600	2021	293.79	29311.55	57.3	4.1130548e+07	{"servicos": 50.8, "industria": 31.5, "agricultura": 17.7}
fb5cdcc4-c4a5-48b2-8a49-c55dec23563e	1704600	2022	284.56	28613.62	62.8	3.9838736e+07	{"servicos": 47.6, "industria": 33.4, "agricultura": 19.0}
83fc9861-826a-47a9-beb5-6ed8ee92def5	1704600	2023	280.47	27150.56	68.6	3.9265136e+07	{"servicos": 57.6, "industria": 33.9, "agricultura": 8.5}
5aaed0f2-18e8-4448-9a4b-b89581f376cf	1705508	2019	617.61	19703.66	65.5	8.234817e+07	{"servicos": 54.3, "industria": 29.3, "agricultura": 16.4}
6a205f69-3f49-4355-8776-4bdc7a01a057	1705508	2020	605.13	20376.95	58	8.068456e+07	{"servicos": 68.3, "industria": 21.0, "agricultura": 10.7}
735b895e-3255-4357-b120-dc439f031bdc	1705508	2021	708.98	23387.15	55.1	9.453088e+07	{"servicos": 53.0, "industria": 22.2, "agricultura": 24.7}
e2e0023f-cbe2-4feb-8041-76dd6a8af7e8	1705508	2022	651.4	22030.63	58.7	8.6853576e+07	{"servicos": 54.0, "industria": 33.9, "agricultura": 12.1}
9ed1e765-9aea-4a73-9142-b435c923245e	1705508	2023	617.03	20964.04	56.7	8.2271264e+07	{"servicos": 69.0, "industria": 24.9, "agricultura": 6.2}
4290d252-e3db-4e43-893f-920a890d71aa	1716703	2019	266.09	26664.52	60.2	3.7251936e+07	{"servicos": 56.6, "industria": 34.1, "agricultura": 9.3}
7de56b45-3437-42a7-ba3a-cb8f5aca2309	1716703	2020	250.64	25393.85	65.2	3.508922e+07	{"servicos": 61.1, "industria": 28.6, "agricultura": 10.3}
13ec0e49-d2f0-4120-bc8f-5b68ef772b00	1716703	2021	279.11	29312.14	62.3	3.9075424e+07	{"servicos": 63.6, "industria": 19.5, "agricultura": 16.9}
4595440b-e49c-439b-acfb-0883d837a86a	1716703	2022	300.95	31179.96	66	4.213286e+07	{"servicos": 73.8, "industria": 15.3, "agricultura": 10.9}
269b590d-a6c8-4e5e-a578-a6988658977d	1716703	2023	267.35	27311.54	57.9	3.7429376e+07	{"servicos": 62.0, "industria": 26.4, "agricultura": 11.7}
f69ba696-8fb8-40c1-97d6-b50ff605616f	1705557	2019	674.76	23011.13	68.7	8.996737e+07	{"servicos": 60.7, "industria": 20.3, "agricultura": 19.1}
a72ab3b1-2d3b-4edc-aedf-c6a31eac1dfa	1705557	2020	606.39	20999.06	64.4	8.085197e+07	{"servicos": 52.0, "industria": 27.4, "agricultura": 20.6}
ea42def4-8886-409d-8ec5-03078c6f5c8a	1705557	2021	687.72	21885.24	61.8	9.1696224e+07	{"servicos": 65.5, "industria": 18.5, "agricultura": 16.1}
56f79428-92cc-463f-be5d-ed6e0c1e0a45	1705557	2022	749.76	26150.59	57	9.996847e+07	{"servicos": 59.3, "industria": 17.5, "agricultura": 23.2}
52b1f961-2cb9-41c8-accb-d2125a760dae	1705557	2023	667.92	23160.3	62.9	8.905599e+07	{"servicos": 64.8, "industria": 17.1, "agricultura": 18.2}
6f55e871-790a-4e84-a9bd-49bdd509d4bb	1705607	2019	2241.35	33465.5	65.1	2.241352e+08	{"servicos": 73.1, "industria": 19.2, "agricultura": 7.7}
ac8b0576-0872-4dd1-a2d4-74c74eff8893	1705607	2020	2200.9	30645.05	56.1	2.200897e+08	{"servicos": 54.5, "industria": 21.4, "agricultura": 24.1}
2b641136-d873-4df1-9548-bc830b3d90a7	1705607	2021	2247.47	31423.48	62.4	2.2474699e+08	{"servicos": 58.5, "industria": 16.5, "agricultura": 25.0}
92182ab2-700a-4600-8d91-3778ea9b9e6e	1705607	2022	2361.78	34824.74	62.1	2.3617792e+08	{"servicos": 71.8, "industria": 16.3, "agricultura": 11.8}
02eaaf2b-0617-4ef5-952e-9eaaf033c7d4	1705607	2023	2430.41	35975.15	62.3	2.4304091e+08	{"servicos": 53.1, "industria": 26.2, "agricultura": 20.7}
957479c9-74f5-4fad-88fd-d3c1d0a4742d	1706001	2019	599.42	19910.46	63.5	7.9923256e+07	{"servicos": 65.2, "industria": 23.8, "agricultura": 11.1}
32092d07-2dc4-4021-8033-fbc0da3279b2	1706001	2020	703.71	22394.71	56.6	9.3827856e+07	{"servicos": 53.8, "industria": 30.4, "agricultura": 15.8}
7ffc4438-3fc9-4c05-a72c-318020b4be48	1706001	2021	628.2	20067.83	67	8.376045e+07	{"servicos": 68.4, "industria": 19.7, "agricultura": 11.9}
782cb5b1-fa56-4d5a-b4c5-3499199e0325	1706001	2022	684.97	21820.59	66.1	9.132935e+07	{"servicos": 58.5, "industria": 30.8, "agricultura": 10.7}
3e1ecd1a-38c7-491b-aee4-4b7a59322172	1706001	2023	632.6	20483.69	59.1	8.434637e+07	{"servicos": 40.5, "industria": 34.8, "agricultura": 24.7}
ed2edb36-0831-47d9-ba98-4603a7ac9036	1706100	2019	272.65	26578.98	56	3.8170608e+07	{"servicos": 62.1, "industria": 16.7, "agricultura": 21.1}
46f6e2bc-4484-44e6-95d3-b0e8eea6615b	1706100	2020	285.5	27383.49	68.8	3.9970032e+07	{"servicos": 51.5, "industria": 28.3, "agricultura": 20.2}
1910a559-9d13-4050-87e8-5fa259fc26cb	1706100	2021	242.86	23944.03	63.7	3.4001004e+07	{"servicos": 57.7, "industria": 26.0, "agricultura": 16.3}
6501c753-c340-4933-a391-31e12b92eeb9	1706100	2022	249.62	25867.43	63.4	3.4946896e+07	{"servicos": 67.4, "industria": 22.6, "agricultura": 9.9}
3f693649-6829-4331-b8b8-349aa3dbe827	1706100	2023	277.17	28141.9	63.1	3.8803736e+07	{"servicos": 60.5, "industria": 33.8, "agricultura": 5.8}
98b7a7fa-e8a3-44fe-95db-89907e11933c	1706258	2019	637.54	20500.37	66.1	8.500548e+07	{"servicos": 50.7, "industria": 31.1, "agricultura": 18.2}
3899ab51-3389-42d5-9e9d-5a6633890ebc	1706258	2020	634.48	21999.27	62.4	8.459747e+07	{"servicos": 60.8, "industria": 24.6, "agricultura": 14.6}
eb47bf62-bbbc-473d-b5be-dcbb9295ec29	1706258	2021	638.52	20715.7	55	8.5135984e+07	{"servicos": 60.9, "industria": 23.1, "agricultura": 16.0}
7f2a5ee9-b2b6-4270-89ab-e29603735192	1706258	2022	651.24	20793.92	55.7	8.683264e+07	{"servicos": 58.7, "industria": 31.6, "agricultura": 9.7}
9dbe24a4-7aac-4a2a-a30c-c1daa8181bea	1706258	2023	703.37	22716.57	66.5	9.3783096e+07	{"servicos": 63.3, "industria": 21.3, "agricultura": 15.4}
84b96954-9772-4584-884a-72c3a8d3875c	1706506	2019	623.26	20476.91	62.4	8.3100744e+07	{"servicos": 63.9, "industria": 19.4, "agricultura": 16.7}
938c72be-804a-4c75-b6d5-6d8f03c3552d	1706506	2020	653.6	22279.18	66.9	8.714724e+07	{"servicos": 54.8, "industria": 24.6, "agricultura": 20.7}
98fe243c-9bfc-4d72-a596-a32063e57e31	1706506	2021	714.28	24418.17	68.9	9.5237384e+07	{"servicos": 49.5, "industria": 34.4, "agricultura": 16.1}
fa802d2f-bff8-414f-a7bd-9c422d6f0978	1706506	2022	631.98	20208.4	60.5	8.426364e+07	{"servicos": 53.9, "industria": 31.1, "agricultura": 15.0}
0966a228-26bd-44e1-9fe3-43fdf54499ac	1706506	2023	732.41	24386.92	59.2	9.7654984e+07	{"servicos": 63.1, "industria": 15.8, "agricultura": 21.1}
4bf78c18-b142-4d0d-b5d2-fda72d48daf2	1707009	2019	2052.56	28651.89	57.8	2.0525643e+08	{"servicos": 58.3, "industria": 17.3, "agricultura": 24.4}
b7a76781-583d-4633-a28e-281322ca7618	1707009	2020	2311.54	32941.46	60.1	2.3115354e+08	{"servicos": 52.9, "industria": 34.9, "agricultura": 12.2}
1cd8d81b-4801-4dea-abc6-15b2956a5d0d	1707009	2021	2271.41	31750.16	58.2	2.2714067e+08	{"servicos": 49.1, "industria": 33.2, "agricultura": 17.7}
9380fb3d-018a-476a-98b7-a84362b96a61	1707009	2022	2151.36	30089.43	60.2	2.1513645e+08	{"servicos": 69.3, "industria": 18.7, "agricultura": 12.0}
e234a8ab-ebea-41fa-b53a-312cf0e94ec9	1707009	2023	2026.65	27982.72	69.1	2.0266488e+08	{"servicos": 50.4, "industria": 28.4, "agricultura": 21.2}
da52d4e7-b045-4d4d-9b29-308561320d40	1707108	2019	638.41	21972.31	61	8.512073e+07	{"servicos": 76.8, "industria": 16.0, "agricultura": 7.2}
edd7a6b9-9e3e-4da1-8eeb-05d9d9226466	1707108	2020	666.44	22817.73	60.1	8.8858304e+07	{"servicos": 69.6, "industria": 20.9, "agricultura": 9.5}
ca65613f-2087-4fdd-b139-c0d2d3375e69	1707108	2021	710.98	22905.13	66.7	9.479669e+07	{"servicos": 64.5, "industria": 29.6, "agricultura": 5.9}
bf3468e8-8e08-4880-bea4-f00cf866f84e	1707108	2022	657.78	21340.01	57.1	8.770461e+07	{"servicos": 56.6, "industria": 28.7, "agricultura": 14.7}
1de7dac3-472a-4a94-a552-a2eac688a18b	1707108	2023	665.88	22776.17	62.8	8.878457e+07	{"servicos": 46.1, "industria": 29.4, "agricultura": 24.5}
2b46d3a2-1520-4261-85ca-47c425634e0d	1707207	2019	674.7	22714.78	61	8.995961e+07	{"servicos": 57.5, "industria": 29.9, "agricultura": 12.6}
ce029286-3f5f-42aa-ac2a-4074a44bc480	1707207	2020	654.17	21302.26	58	8.72228e+07	{"servicos": 61.9, "industria": 26.6, "agricultura": 11.4}
78bc72aa-25e6-4209-9d19-6f6d0b78c12d	1707207	2021	628.65	20419.42	65.6	8.3820376e+07	{"servicos": 61.2, "industria": 24.6, "agricultura": 14.2}
7365f759-4a25-4c93-a33a-005f6bcb5e84	1707207	2022	623.71	20548.54	62.9	8.3161296e+07	{"servicos": 54.4, "industria": 21.6, "agricultura": 24.0}
86afcf88-ce4b-46f8-8b77-0d6f0c08776d	1707207	2023	764.14	25424.84	61.4	1.0188579e+08	{"servicos": 58.7, "industria": 31.9, "agricultura": 9.4}
da362074-9e82-479b-8a72-abf56fbb0c1d	1707306	2019	644.31	21626.28	59.7	8.590824e+07	{"servicos": 57.4, "industria": 28.8, "agricultura": 13.8}
49a1f34b-71df-406c-83eb-b476f612cf73	1707306	2020	589.16	20264.14	56.6	7.85546e+07	{"servicos": 60.3, "industria": 16.5, "agricultura": 23.2}
db46478e-1575-4d23-a9ae-4839176111e1	1707306	2021	619.13	21461.82	62.5	8.255075e+07	{"servicos": 62.5, "industria": 21.2, "agricultura": 16.3}
9cc86aec-39ce-496b-b1d3-7b596bb71b6b	1707306	2022	607.08	21066.66	56.5	8.094373e+07	{"servicos": 60.8, "industria": 26.7, "agricultura": 12.4}
6fea2349-4812-4d03-96ea-172784893b8d	1707306	2023	676.46	23667.44	69.7	9.019505e+07	{"servicos": 73.4, "industria": 17.1, "agricultura": 9.4}
2a77aca7-5961-42d9-a848-68d408eb391a	1707405	2019	259.99	25812.98	66.8	3.6398364e+07	{"servicos": 70.2, "industria": 17.3, "agricultura": 12.4}
1c3ecd06-48e4-4acf-9923-6c33500d5c0d	1707405	2020	269.29	27012.74	66.2	3.7700604e+07	{"servicos": 67.5, "industria": 21.0, "agricultura": 11.5}
a483135a-aba4-445f-8e5b-c1ed3ca95670	1707405	2021	299.05	28763.23	59.5	4.1867184e+07	{"servicos": 64.3, "industria": 20.7, "agricultura": 15.0}
19b89d52-16f0-454c-a1e8-c65b9deb1361	1707405	2022	248.82	25795.02	55	3.483462e+07	{"servicos": 63.7, "industria": 17.1, "agricultura": 19.2}
31090833-3e6c-424e-9762-bc208429ad3e	1707405	2023	262.68	25737.82	62.6	3.6775232e+07	{"servicos": 60.4, "industria": 23.8, "agricultura": 15.8}
29d16c2b-5499-484c-a759-c22e38c079fe	1707652	2019	2195.37	30396.72	62.3	2.1953728e+08	{"servicos": 49.1, "industria": 34.8, "agricultura": 16.1}
2744b906-6f19-4278-9e68-570247174313	1707652	2020	2057.93	28022.62	69.1	2.0579254e+08	{"servicos": 46.4, "industria": 31.1, "agricultura": 22.5}
132dec9f-7ce2-4919-b983-157e7eed90dc	1707652	2021	1955.06	26748.73	69	1.955065e+08	{"servicos": 74.0, "industria": 20.0, "agricultura": 6.0}
4c886d2b-ea63-4413-ab26-b779b56da474	1707652	2022	2342.39	35014.82	68.8	2.3423866e+08	{"servicos": 70.0, "industria": 17.5, "agricultura": 12.6}
ff8f6d83-12cb-4168-9f74-2ff760eb1260	1707652	2023	2492.42	35216.65	58.6	2.4924232e+08	{"servicos": 53.9, "industria": 25.4, "agricultura": 20.8}
d9da376b-bea5-4c89-8b97-a0c208eecd88	1707702	2019	261.08	26249.92	58.6	3.6551436e+07	{"servicos": 59.5, "industria": 25.4, "agricultura": 15.1}
897e6139-d262-480e-bf5b-f2dce584e589	1707702	2020	237.99	24063.74	62	3.3318656e+07	{"servicos": 63.8, "industria": 20.7, "agricultura": 15.5}
65e31fed-87c7-4650-8ef9-3de4c906c96e	1707702	2021	298.39	28494.37	66.9	4.1775024e+07	{"servicos": 74.3, "industria": 17.1, "agricultura": 8.6}
13032e18-e20a-42dd-a917-30662e77ec75	1707702	2022	260.92	25939.29	57.7	3.652926e+07	{"servicos": 62.6, "industria": 31.6, "agricultura": 5.8}
2c314d20-f520-437f-b76f-94ad0b20479d	1707702	2023	288.99	30247.63	59.6	4.0458016e+07	{"servicos": 54.5, "industria": 31.2, "agricultura": 14.3}
e7a21df1-4c23-4db7-ba8e-002a2498cbd2	1708205	2019	280.27	27779.74	67.8	3.9237764e+07	{"servicos": 47.9, "industria": 33.9, "agricultura": 18.2}
9fdfb97f-aa9b-45c6-b3c8-bc41e532b3e4	1708205	2020	273.5	27774.77	55.3	3.8289744e+07	{"servicos": 58.6, "industria": 27.4, "agricultura": 14.0}
7725b4cf-6f06-417f-8b34-eff6ce4e9e5c	1708205	2021	246.93	24137.69	59.3	3.4569992e+07	{"servicos": 51.8, "industria": 30.4, "agricultura": 17.8}
dd59399d-21b4-46b9-92f8-3f2fadd1866a	1708205	2022	304.82	29995.85	66.9	4.2674488e+07	{"servicos": 62.0, "industria": 15.5, "agricultura": 22.5}
02bdb717-ad71-4a91-ac64-df20363d8f93	1708205	2023	284.15	29375.17	62.8	3.9780436e+07	{"servicos": 60.9, "industria": 19.5, "agricultura": 19.7}
555dfc03-13fa-44a0-bbb3-417a1b523086	1707553	2019	547.06	18179.46	62.3	7.294084e+07	{"servicos": 52.3, "industria": 27.6, "agricultura": 20.2}
4581690c-2132-4852-a5eb-88c8c0e443a9	1707553	2020	672.5	22919.38	56.6	8.966673e+07	{"servicos": 53.8, "industria": 26.8, "agricultura": 19.5}
c5b90f40-3d0f-43f1-bb68-3243adcea5f5	1707553	2021	604.33	20343	61.5	8.057729e+07	{"servicos": 64.3, "industria": 19.9, "agricultura": 15.8}
80f2de6e-14f7-4987-8709-b10c75206164	1707553	2022	724.53	25143.48	69.4	9.6604624e+07	{"servicos": 61.8, "industria": 23.2, "agricultura": 15.0}
118cb9b4-e418-4aa0-8ca2-5477e0c80b17	1707553	2023	687.12	22965.29	62.8	9.16162e+07	{"servicos": 66.8, "industria": 25.2, "agricultura": 8.0}
489ff0e1-c7cf-4334-9ecb-f12229337024	1708304	2019	267.9	25746.97	60.2	3.7505604e+07	{"servicos": 69.3, "industria": 16.0, "agricultura": 14.8}
ea3754f5-9726-47d7-b1af-f1f0e4191bc8	1708304	2020	278.04	26806.58	55.9	3.8925292e+07	{"servicos": 57.2, "industria": 20.6, "agricultura": 22.2}
f888867f-ee01-4bf7-90bf-6306fde27b24	1708304	2021	277.92	26705.35	55	3.890916e+07	{"servicos": 59.8, "industria": 27.5, "agricultura": 12.7}
5653199a-1da0-4486-a308-9b37e181789f	1708304	2022	277.05	26519.24	58	3.8786512e+07	{"servicos": 52.5, "industria": 24.9, "agricultura": 22.6}
86a4235d-1a5a-49da-b271-c841fb285f01	1708304	2023	257.51	25764.12	57.3	3.6051728e+07	{"servicos": 64.7, "industria": 15.8, "agricultura": 19.4}
9311d906-ac28-4c7e-8b13-9da7ad6d6df9	1709005	2019	275.71	28342.24	57.4	3.859986e+07	{"servicos": 58.7, "industria": 20.2, "agricultura": 21.1}
60a91de6-8c23-4c55-b312-3d3886665e91	1709005	2020	260.54	25548.64	56.3	3.64763e+07	{"servicos": 56.9, "industria": 31.4, "agricultura": 11.7}
04fb2f54-7f3b-43ae-b91f-b7cb7978053d	1709005	2021	244.03	23805.19	60.5	3.416378e+07	{"servicos": 59.1, "industria": 21.2, "agricultura": 19.7}
feea8c2e-3ea3-443a-bf9f-958c1ee4f98f	1709005	2022	300.36	29221.21	67.9	4.205108e+07	{"servicos": 74.2, "industria": 17.1, "agricultura": 8.6}
ee3f899f-bff6-49fd-81b1-5cc34495a194	1709005	2023	304.79	29359.9	65	4.2669924e+07	{"servicos": 55.7, "industria": 34.1, "agricultura": 10.2}
b0fefe1c-5515-4f29-b796-fadc759dcd2b	1709302	2019	563.6	19488.9	67.3	7.51466e+07	{"servicos": 55.1, "industria": 34.5, "agricultura": 10.4}
008336dd-5c40-4386-93f6-f705471865e2	1709302	2020	588.44	19957.83	55.9	7.8458224e+07	{"servicos": 48.3, "industria": 28.5, "agricultura": 23.1}
4e36c74e-e6f3-4dce-b4b9-34a66a7bb73b	1709302	2021	623.18	21716.65	61.3	8.3090784e+07	{"servicos": 67.3, "industria": 18.6, "agricultura": 14.2}
f689f140-467a-45ea-969b-5b481711caa4	1709302	2022	666.12	22302.05	56.2	8.8815696e+07	{"servicos": 72.1, "industria": 19.3, "agricultura": 8.6}
cf6a1586-5411-4792-b7c9-b6390baf7e55	1709302	2023	704.37	23798.57	62.9	9.3915504e+07	{"servicos": 46.5, "industria": 28.8, "agricultura": 24.6}
f5f7b65c-46bf-4bed-92a2-542bf6c91f7c	1709500	2019	2039.98	27869.75	59.1	2.0399819e+08	{"servicos": 48.0, "industria": 30.8, "agricultura": 21.2}
c2d2c8af-cc8e-4ae0-bcfd-d69bfae8fbf8	1709500	2020	2091.01	31231.95	64.2	2.0910101e+08	{"servicos": 68.8, "industria": 23.0, "agricultura": 8.2}
7c7eec02-abfe-4a87-a1e4-5cb22fef25df	1709500	2021	2206.98	31212.2	56.3	2.2069837e+08	{"servicos": 44.1, "industria": 33.4, "agricultura": 22.5}
4f38c075-88e5-4d98-8cde-bccb62f13036	1709500	2022	2012.96	28490.82	68.2	2.0129618e+08	{"servicos": 45.2, "industria": 33.7, "agricultura": 21.1}
3485e938-6782-4d1e-8954-d0c80a661eaa	1709500	2023	2294.41	34174.47	64.2	2.2944054e+08	{"servicos": 43.8, "industria": 32.9, "agricultura": 23.3}
3ca1a28c-9549-4ddc-8a39-cf5c477bd287	1709807	2019	1845.69	27243	67.1	1.8456862e+08	{"servicos": 41.3, "industria": 34.5, "agricultura": 24.2}
90b60324-b299-409a-8757-fda99434a833	1709807	2020	2354.99	33277.58	62.8	2.3549877e+08	{"servicos": 46.1, "industria": 31.0, "agricultura": 22.9}
04040c08-1afd-4cce-bd6f-11d10fa41199	1709807	2021	2389.89	33876.06	55.3	2.3898885e+08	{"servicos": 50.0, "industria": 25.1, "agricultura": 24.9}
3ce126d4-86d2-49d7-b151-6c7ce1a1f6de	1709807	2022	2366.28	33594.69	69.4	2.3662752e+08	{"servicos": 72.9, "industria": 21.2, "agricultura": 6.0}
ff7dddc5-f825-477a-90a4-7666a313b832	1709807	2023	2313.83	34005.47	65.8	2.3138344e+08	{"servicos": 53.3, "industria": 22.9, "agricultura": 23.9}
1f818358-819f-40b4-98e8-ed4b77958f32	1710508	2019	651.5	21758.17	68.6	8.686731e+07	{"servicos": 65.3, "industria": 25.9, "agricultura": 8.8}
1b9899fd-aa96-486a-9631-b2695e7fef91	1710508	2020	701.54	22391.3	69.5	9.353893e+07	{"servicos": 57.9, "industria": 17.2, "agricultura": 24.9}
88aa9282-5e08-4b22-9801-ec7e4e870dd7	1710508	2021	572.52	18762.48	65.7	7.633579e+07	{"servicos": 47.6, "industria": 28.5, "agricultura": 24.0}
f893bf9f-670c-4ce5-ab9d-0a4f06c7f4a4	1710508	2022	707.29	24642.61	64.8	9.430565e+07	{"servicos": 57.1, "industria": 20.6, "agricultura": 22.4}
14d03c2a-399d-4c25-98d3-40459de1bf6a	1710508	2023	638.14	22076.98	64.1	8.508468e+07	{"servicos": 65.0, "industria": 15.7, "agricultura": 19.4}
b9be3428-89f9-464f-b987-3d51a50053d4	1710706	2019	2020.21	30349.9	55.7	2.0202109e+08	{"servicos": 48.9, "industria": 30.5, "agricultura": 20.6}
27973a93-51eb-4742-a9b4-78f18f108055	1710706	2020	2166.84	32559.56	68.1	2.1668387e+08	{"servicos": 61.2, "industria": 18.2, "agricultura": 20.5}
9008a00b-e4c2-4501-a9ae-189070e1f0f5	1710706	2021	2140.21	30663.32	57.8	2.140208e+08	{"servicos": 48.7, "industria": 31.6, "agricultura": 19.7}
bbac7399-7446-4adc-8723-a629acc05128	1710706	2022	2229.53	32697.71	61.5	2.2295262e+08	{"servicos": 53.5, "industria": 22.6, "agricultura": 23.9}
4511d315-e076-408e-b3db-5532da466c2b	1710706	2023	2156.61	30960.82	66.3	2.1566067e+08	{"servicos": 51.9, "industria": 31.4, "agricultura": 16.7}
3bf4b32e-dcbc-41be-85af-277edebda17b	1710904	2019	282.34	29176.01	58.1	3.9527076e+07	{"servicos": 71.8, "industria": 21.0, "agricultura": 7.2}
f67e1dfc-0c5c-4377-97fa-540f15c403d4	1710904	2020	263.96	26451.16	60.2	3.695386e+07	{"servicos": 64.1, "industria": 23.6, "agricultura": 12.3}
8f1bb136-2c1b-4c57-b028-998d62747873	1710904	2021	284.73	27181.91	61.1	3.9862276e+07	{"servicos": 68.0, "industria": 18.4, "agricultura": 13.5}
a9be670f-54de-48bd-aa20-e001ecb1932c	1710904	2022	266.9	28059.47	70	3.7366232e+07	{"servicos": 42.7, "industria": 33.3, "agricultura": 24.0}
13e34d43-4b14-4c74-a9fd-409867791ad6	1710904	2023	280.98	27417.68	67.8	3.9336692e+07	{"servicos": 70.4, "industria": 15.3, "agricultura": 14.3}
e1fcd96a-c457-4da0-81a9-49ffc206e923	1711100	2019	631.14	20301.78	56.5	8.415223e+07	{"servicos": 64.2, "industria": 19.9, "agricultura": 15.9}
ec4b045b-74ea-4dbe-a63f-41aae42c6267	1711100	2020	569.43	18608.87	66.5	7.59242e+07	{"servicos": 68.4, "industria": 19.7, "agricultura": 11.9}
8f550e03-a380-4166-91a4-1b7f09734e4f	1711100	2021	625.56	20243.91	61.5	8.34076e+07	{"servicos": 72.5, "industria": 16.6, "agricultura": 10.9}
8ece60f0-160e-41f1-954a-8fc2f6bd9823	1711100	2022	676.42	22274.79	56.8	9.018913e+07	{"servicos": 60.8, "industria": 34.1, "agricultura": 5.2}
b7c4bb90-58ed-464b-90d7-47fc82d24969	1711100	2023	658.4	21951.86	68.6	8.778695e+07	{"servicos": 60.7, "industria": 34.0, "agricultura": 5.2}
b8f2a549-4d2b-4953-82ba-34cc983445ef	1711506	2019	673.96	22314.18	56.7	8.986069e+07	{"servicos": 65.1, "industria": 16.5, "agricultura": 18.4}
1618095d-3879-4f6a-972e-954a89e76415	1711506	2020	702.51	23223.59	59	9.3668456e+07	{"servicos": 63.1, "industria": 25.0, "agricultura": 11.9}
66bf5338-7bad-4604-8212-62153af95707	1711506	2021	585.34	18647.21	66.5	7.804477e+07	{"servicos": 55.2, "industria": 27.3, "agricultura": 17.5}
038df0eb-9b9b-4b2c-9118-2f0d99300f72	1711506	2022	605.81	21233.27	67.6	8.0774176e+07	{"servicos": 56.6, "industria": 27.8, "agricultura": 15.6}
00d5eb06-0256-441b-b0c8-6b18384fe940	1711506	2023	740.4	24885.05	66.5	9.8720656e+07	{"servicos": 67.9, "industria": 16.4, "agricultura": 15.7}
4be08013-afa6-4ea4-8c0e-c2b81845c820	1711803	2019	2106.57	29195.05	58.2	2.1065686e+08	{"servicos": 61.0, "industria": 27.0, "agricultura": 12.0}
06e4dd4f-eb96-4af2-b9ea-df9bba6508e0	1711803	2020	2057.97	30704.05	58.8	2.0579698e+08	{"servicos": 63.3, "industria": 22.4, "agricultura": 14.4}
cdce2f22-04f3-475f-a670-a47702d428db	1711803	2021	2159.95	31411.52	65.2	2.1599501e+08	{"servicos": 74.2, "industria": 15.3, "agricultura": 10.5}
6157efe8-c618-467f-b4ed-539f0849b040	1711803	2022	1972.5	28703.45	69.7	1.9725011e+08	{"servicos": 64.7, "industria": 16.3, "agricultura": 19.0}
537ab2ea-dc68-4ec0-8d86-7142a93fc665	1711803	2023	2436.86	34805.38	57.5	2.4368642e+08	{"servicos": 76.6, "industria": 15.6, "agricultura": 7.8}
3b95947d-459b-41a6-975d-50c3d85e24b4	1711902	2019	242.54	25498.51	64.6	3.395586e+07	{"servicos": 68.5, "industria": 25.7, "agricultura": 5.8}
3c6ad7bb-b76b-41d0-a0de-d95dfc802621	1711902	2020	293.79	30612.92	61	4.11309e+07	{"servicos": 77.8, "industria": 16.2, "agricultura": 6.0}
105c1a04-87fa-41ce-b92d-ed74f6a0a6e3	1711902	2021	257.63	25601.36	69.5	3.6067708e+07	{"servicos": 60.0, "industria": 22.2, "agricultura": 17.9}
242ce532-c51d-4359-9300-a81bf6536f37	1711902	2022	247.26	23602.88	56.8	3.4616928e+07	{"servicos": 52.9, "industria": 27.0, "agricultura": 20.1}
df31c863-3053-4ee1-bd71-82b2c759e831	1711902	2023	258.12	24941.63	63.8	3.6136924e+07	{"servicos": 73.2, "industria": 21.2, "agricultura": 5.6}
6558e680-fba0-4213-845f-37db7790ed43	1711951	2019	229.07	23928.24	55	3.2069108e+07	{"servicos": 59.9, "industria": 21.6, "agricultura": 18.5}
59d56f4b-1158-45a0-8946-e55f5700a6bf	1711951	2020	266.49	26422.23	62.5	3.7309252e+07	{"servicos": 46.8, "industria": 34.0, "agricultura": 19.2}
f4600246-af25-4d47-9643-80d79c401856	1711951	2021	248.73	24285.61	68	3.4822652e+07	{"servicos": 50.0, "industria": 25.8, "agricultura": 24.2}
203497a7-1c2b-4db8-b2ae-1992f89e9452	1711951	2022	251.08	24678.57	66.9	3.5151168e+07	{"servicos": 51.1, "industria": 27.3, "agricultura": 21.6}
84040cf6-8da3-4379-9667-b0bab111a62b	1711951	2023	281.2	28930.22	62.9	3.9368248e+07	{"servicos": 52.2, "industria": 34.5, "agricultura": 13.3}
69584713-773f-40a7-85bf-8c1fd3b83662	1712009	2019	636.26	22299.86	60.1	8.48346e+07	{"servicos": 69.2, "industria": 18.0, "agricultura": 12.8}
24f2fae0-d13d-4fb6-a92f-6b148ba97fd8	1712009	2020	654.9	21880.38	57.5	8.732024e+07	{"servicos": 54.2, "industria": 33.1, "agricultura": 12.8}
453b7afa-b40d-47c2-8385-84bb892597f9	1712009	2021	657.75	22822.68	68.8	8.769995e+07	{"servicos": 59.1, "industria": 32.1, "agricultura": 8.8}
a7e6faa7-24a3-44ba-8190-28062d7e1c02	1712009	2022	603.03	19646.54	68.4	8.040413e+07	{"servicos": 52.0, "industria": 27.3, "agricultura": 20.7}
3288f670-406e-45a0-8a44-733c65d654c5	1712009	2023	724.44	23341.94	55.9	9.659205e+07	{"servicos": 62.5, "industria": 25.2, "agricultura": 12.3}
8f38894a-3563-4b84-85e9-bb304dbbf3fa	1712157	2019	229.13	23962.56	69.3	3.2078196e+07	{"servicos": 46.5, "industria": 34.9, "agricultura": 18.6}
0fc3645d-7176-4c70-859f-ed56fe016e02	1712157	2020	273.01	28317.1	56	3.822072e+07	{"servicos": 70.4, "industria": 22.0, "agricultura": 7.5}
6855ecb5-2c93-4d36-8dc0-5b9b0b5a8cb6	1712157	2021	290.53	29160.89	57.3	4.0674188e+07	{"servicos": 58.9, "industria": 24.3, "agricultura": 16.8}
8d5de7af-fb9d-4057-ab3c-60f08c2e18c2	1712157	2022	309.11	31841.07	64.1	4.3275836e+07	{"servicos": 49.9, "industria": 25.4, "agricultura": 24.7}
6eee3c30-a363-4988-a4a2-febb31b6c688	1712157	2023	254.41	26374.95	63.3	3.5617784e+07	{"servicos": 54.6, "industria": 34.8, "agricultura": 10.6}
b63c00d7-0d43-4dd1-ac04-52cd96ad9ab4	1712405	2019	262.04	25539.83	56.2	3.6685412e+07	{"servicos": 61.2, "industria": 27.6, "agricultura": 11.2}
514ad881-e8ab-4a25-a3aa-590fc898ba6a	1712405	2020	232.51	24126.79	56.4	3.2551382e+07	{"servicos": 47.8, "industria": 32.1, "agricultura": 20.1}
296a2c9d-5889-45bf-995b-586a7c615333	1712405	2021	261.63	27031.01	63.1	3.662864e+07	{"servicos": 59.3, "industria": 27.2, "agricultura": 13.5}
562790cb-cdeb-4151-9587-be9fc1cd2c25	1712405	2022	259.54	24732.34	62.3	3.633576e+07	{"servicos": 61.5, "industria": 23.5, "agricultura": 15.0}
f1ccfaee-1a03-450e-b8d6-540f1d40ada3	1712405	2023	309.68	29673.9	57.9	4.3354748e+07	{"servicos": 44.7, "industria": 30.8, "agricultura": 24.4}
e4dfd3f2-a5b7-4895-826c-537f1f28418d	1712454	2019	1946.74	28312.17	55.2	1.9467445e+08	{"servicos": 66.8, "industria": 27.0, "agricultura": 6.2}
ba2f53dc-39cb-4744-a207-c7c0a12ba2cc	1712454	2020	2218.47	30514.56	60.3	2.2184698e+08	{"servicos": 56.0, "industria": 27.2, "agricultura": 16.7}
a43741a9-5e2b-4e66-bb9c-60442f74a678	1712454	2021	2040.76	30517	59.9	2.0407637e+08	{"servicos": 58.4, "industria": 29.0, "agricultura": 12.7}
ac471b03-d7b8-4649-ae80-e4884ef4210c	1712454	2022	1999.66	30062.36	67.4	1.9996579e+08	{"servicos": 61.3, "industria": 18.6, "agricultura": 20.1}
21fe8c3c-603e-41f9-a683-60281ed9d5c8	1712454	2023	2511.06	36895.86	66.5	2.5110586e+08	{"servicos": 54.2, "industria": 34.6, "agricultura": 11.2}
983dbe74-2688-4763-b73f-1872ac0b1ff9	1712504	2019	255.61	25640.23	55.9	3.5785044e+07	{"servicos": 57.7, "industria": 30.6, "agricultura": 11.7}
ba56e167-346d-441d-b7b3-dac1c9bec520	1712504	2020	290.49	27840.73	56.3	4.066862e+07	{"servicos": 66.7, "industria": 22.0, "agricultura": 11.2}
ccdc5f28-8d83-4903-9648-219556052293	1712504	2021	253.6	24540.7	59.5	3.5504508e+07	{"servicos": 53.4, "industria": 25.3, "agricultura": 21.3}
3703bd39-65d3-40cc-9c15-27d50488de6b	1712504	2022	246.17	25669.62	55.9	3.4464032e+07	{"servicos": 58.4, "industria": 33.7, "agricultura": 7.8}
3476e7e7-42a1-408e-ae41-48418bf5d253	1712504	2023	289.51	27722.98	55.4	4.0531544e+07	{"servicos": 57.0, "industria": 22.6, "agricultura": 20.4}
57f9e9bd-4d24-4e37-a02b-cd60d7218b53	1712702	2019	249.2	26223.04	65.7	3.488766e+07	{"servicos": 67.9, "industria": 22.3, "agricultura": 9.7}
b5cb1be1-4747-45da-b85e-d0dc1aa149ae	1712702	2020	290.93	30441.83	66.7	4.073056e+07	{"servicos": 77.1, "industria": 16.6, "agricultura": 6.3}
854efe15-67d6-4c81-a8ae-6797f571d13d	1712702	2021	273.92	26112.58	60.8	3.8348928e+07	{"servicos": 53.8, "industria": 29.8, "agricultura": 16.4}
440ab706-8d85-42a4-a7db-8081aa8e2384	1712702	2022	310.63	29773.98	67.8	4.3488472e+07	{"servicos": 44.7, "industria": 32.3, "agricultura": 23.0}
cbb8bbbc-2feb-48ed-a163-3518dff50ca5	1712702	2023	307.32	31149.24	67.2	4.3024576e+07	{"servicos": 61.2, "industria": 28.4, "agricultura": 10.5}
09cb7281-ff9d-4b72-a848-3763e41ca847	1712801	2019	627.22	21049.92	65.2	8.3629944e+07	{"servicos": 63.7, "industria": 15.7, "agricultura": 20.6}
f811d950-a0ff-476b-a0fd-243104bb954a	1712801	2020	637.91	21885.93	65.9	8.5054576e+07	{"servicos": 59.1, "industria": 32.8, "agricultura": 8.0}
450d8934-0629-4090-8b35-765cc370d52b	1712801	2021	617.81	20067.2	67.7	8.237452e+07	{"servicos": 57.4, "industria": 24.5, "agricultura": 18.1}
c7b940a3-4708-48e1-adcd-46556c49a6a4	1712801	2022	718.99	23505.75	68.2	9.5865856e+07	{"servicos": 49.2, "industria": 26.3, "agricultura": 24.6}
5174ea6c-bf6f-4379-952d-0da2fd031da6	1712801	2023	765.72	26535.06	68.9	1.02096296e+08	{"servicos": 70.2, "industria": 20.8, "agricultura": 8.9}
0ac2d78d-20f2-45ce-bc79-57d427c4ed8c	1713205	2019	246.83	24767.36	63.5	3.4556408e+07	{"servicos": 56.8, "industria": 27.6, "agricultura": 15.6}
e0f06799-4ffb-4a18-9045-8af9bd05a89e	1713205	2020	265.21	26662.48	60.3	3.712964e+07	{"servicos": 61.9, "industria": 31.6, "agricultura": 6.6}
4137f2e4-94d9-4ef5-8a8b-38f1d2b83c12	1713205	2021	261.64	25213.19	61.5	3.6629216e+07	{"servicos": 47.0, "industria": 34.9, "agricultura": 18.1}
8042a2c8-3934-49cc-a3b5-de471c0ffc72	1713205	2022	290.36	29989.64	61.3	4.0650356e+07	{"servicos": 62.2, "industria": 24.0, "agricultura": 13.9}
69be617d-0d1f-4a54-8073-c1087a65404e	1713205	2023	298.51	28480.78	65.6	4.1790992e+07	{"servicos": 68.0, "industria": 25.3, "agricultura": 6.8}
c80d395d-aba2-46e7-96d5-0227626c889b	1713304	2019	240.11	23507.78	59.3	3.3615192e+07	{"servicos": 51.7, "industria": 23.9, "agricultura": 24.5}
9d010ba5-4e5d-4a98-9b3b-b03b0eec1ccf	1713304	2020	251.43	24243.41	63	3.5199976e+07	{"servicos": 68.6, "industria": 19.5, "agricultura": 11.8}
96de0fb7-e303-4585-abcf-d352242aa055	1713304	2021	255.18	26644.64	55.4	3.5724604e+07	{"servicos": 54.2, "industria": 24.2, "agricultura": 21.6}
50d9b181-0a0a-4364-bf96-286241ff741b	1713304	2022	309.13	32509.47	61.9	4.327856e+07	{"servicos": 54.4, "industria": 23.8, "agricultura": 21.8}
80d88121-c335-4385-b64e-03b9bb7d1982	1713304	2023	290.08	28032.13	65.1	4.0610708e+07	{"servicos": 57.7, "industria": 28.9, "agricultura": 13.4}
579c4c71-90c7-45f2-92fd-c4195ee017cf	1713700	2019	281.25	27595.52	59.2	3.9375496e+07	{"servicos": 40.7, "industria": 34.9, "agricultura": 24.4}
f6f5dd8c-d317-4baa-a0a8-625990527e1d	1713700	2020	279.59	28492.26	55.4	3.914324e+07	{"servicos": 63.0, "industria": 22.9, "agricultura": 14.1}
ff61ab38-cc32-4ada-951e-64a68620967f	1713700	2021	254.23	24216.69	58.6	3.5591748e+07	{"servicos": 60.1, "industria": 31.0, "agricultura": 8.9}
220eeaf3-02b9-4ea7-aef9-5f84285d0253	1713700	2022	295.5	30505.28	59.4	4.1370656e+07	{"servicos": 67.0, "industria": 15.7, "agricultura": 17.3}
0e24bb0b-b6c2-487a-a76c-ec1005dc4d25	1713700	2023	304.39	29688.25	66.5	4.2615108e+07	{"servicos": 64.4, "industria": 16.7, "agricultura": 18.8}
9b0c1b05-4ba7-45db-8560-b9ff8dd024ac	1713601	2019	567.46	18909.81	57.4	7.566193e+07	{"servicos": 55.6, "industria": 33.0, "agricultura": 11.4}
e77e518b-0e4d-4b2a-bc3d-88be6860f82f	1713601	2020	605.15	19792.36	60.4	8.068683e+07	{"servicos": 63.6, "industria": 27.8, "agricultura": 8.6}
676af64c-c0e1-4ed4-86fd-56d124cf171c	1713601	2021	621.85	19844.7	59.4	8.29138e+07	{"servicos": 62.9, "industria": 26.2, "agricultura": 10.9}
79bdf4b5-e8bc-4048-b26c-0a6c872af4e7	1713601	2022	643.71	22209.28	67.3	8.5828504e+07	{"servicos": 78.3, "industria": 16.5, "agricultura": 5.2}
2146823c-0243-43f7-aaf0-88e42fe45ead	1713601	2023	640.83	21193.43	59.4	8.544344e+07	{"servicos": 72.1, "industria": 15.3, "agricultura": 12.6}
6b6cee92-61c5-4281-a4eb-044070cfd280	1713957	2019	648.37	21894.06	61.1	8.644944e+07	{"servicos": 61.3, "industria": 15.3, "agricultura": 23.5}
48937fb1-d34f-41bb-b705-809cbbd16b40	1713957	2020	688.43	22412.11	69.3	9.1791024e+07	{"servicos": 54.7, "industria": 31.2, "agricultura": 14.0}
a3305b4f-1c6c-4a76-a72c-bcff43dbaeea	1713957	2021	686.8	23034.55	67.2	9.157309e+07	{"servicos": 64.1, "industria": 26.4, "agricultura": 9.5}
bbbce264-fb33-4916-9fa9-7baf3789d571	1713957	2022	625.82	20753.32	62.5	8.344217e+07	{"servicos": 46.5, "industria": 29.7, "agricultura": 23.8}
96077e41-59f4-40db-b53c-c46c8026d03b	1713957	2023	690.76	22487.83	60.4	9.2101176e+07	{"servicos": 51.1, "industria": 28.7, "agricultura": 20.2}
88beec67-2097-41d0-b51f-b6f0c85d0fc2	1714203	2019	641.31	21102.1	68.7	8.5508504e+07	{"servicos": 54.2, "industria": 28.8, "agricultura": 17.1}
dce4da0c-cd1c-4187-8100-dfe1e7a1548d	1714203	2020	696.23	23556.34	68.6	9.2830824e+07	{"servicos": 67.2, "industria": 16.7, "agricultura": 16.2}
b9e178b4-37ad-43fb-b0a4-b14b167b3844	1714203	2021	727.06	24797.26	56.8	9.6940776e+07	{"servicos": 63.6, "industria": 28.9, "agricultura": 7.5}
aa4a2eb0-8512-4aad-b85b-db145e849810	1714203	2022	636.84	21962.2	56.2	8.491173e+07	{"servicos": 58.4, "industria": 25.5, "agricultura": 16.0}
7b663c25-eb37-498a-84ec-45eeb677bfe2	1714203	2023	689.86	22434.38	56.6	9.198096e+07	{"servicos": 50.9, "industria": 34.2, "agricultura": 14.9}
e7fe7b78-ca8f-4321-9d1c-f39963066eb7	1714302	2019	265.63	25879.96	63.9	3.7188468e+07	{"servicos": 69.2, "industria": 15.0, "agricultura": 15.8}
09a42910-b5d7-4ab0-9f24-ddf7c265cd74	1714302	2020	254.58	25019.9	69.1	3.5640852e+07	{"servicos": 72.7, "industria": 21.8, "agricultura": 5.5}
007d7562-fad4-478d-b87e-b7c12f7c5a8f	1714302	2021	282.34	28090.6	57.9	3.9527408e+07	{"servicos": 69.1, "industria": 16.6, "agricultura": 14.3}
bff8de6a-cb79-4629-9d2c-56a930b73455	1714302	2022	291.65	28099.72	66.8	4.083058e+07	{"servicos": 61.4, "industria": 16.5, "agricultura": 22.1}
02701cd5-0e08-450e-a829-e0cdf07310be	1714302	2023	289.51	30182.35	55.9	4.0531268e+07	{"servicos": 67.7, "industria": 20.8, "agricultura": 11.6}
02275eeb-f6a2-41aa-91a3-50d8fef93727	1714880	2019	227.84	23093.57	56.6	3.189776e+07	{"servicos": 69.0, "industria": 26.0, "agricultura": 5.0}
ff1b2e5c-6799-49bd-9306-bfcae0b99a29	1714880	2020	269.46	26889.22	64.7	3.7723964e+07	{"servicos": 70.7, "industria": 15.8, "agricultura": 13.6}
94f9d979-f701-4de0-87f6-d06723648219	1714880	2021	261.01	27228.27	59.5	3.6541428e+07	{"servicos": 65.0, "industria": 25.7, "agricultura": 9.4}
07da17b2-4cdb-4d99-80b2-71ad7a8ea200	1714880	2022	311.86	31735.24	62.6	4.3660712e+07	{"servicos": 58.6, "industria": 32.7, "agricultura": 8.6}
4c85fcb8-a2ee-4280-a97e-7da9685406c6	1714880	2023	264.95	25963.03	56.6	3.7093376e+07	{"servicos": 47.8, "industria": 31.7, "agricultura": 20.4}
8814de8e-1c91-4478-98db-711f9824f0cb	1715002	2019	548.2	17848	62.4	7.309351e+07	{"servicos": 59.9, "industria": 25.5, "agricultura": 14.6}
2525867c-f517-40a7-9a65-3e87066c5041	1715002	2020	687.7	23277.04	66.2	9.169291e+07	{"servicos": 75.7, "industria": 18.6, "agricultura": 5.7}
adacd140-a97d-42f1-a743-6da1e8ea3a75	1715002	2021	666.44	21742.71	69.3	8.885809e+07	{"servicos": 59.7, "industria": 25.6, "agricultura": 14.7}
197f0c5b-a7f9-40f3-86fb-24720ca2e994	1715002	2022	697.89	23419.94	66.5	9.3052104e+07	{"servicos": 62.9, "industria": 15.7, "agricultura": 21.4}
11b48e2a-22c4-4b9f-ac23-82c02e282c2b	1715002	2023	762.99	25859.78	69.9	1.0173237e+08	{"servicos": 58.2, "industria": 24.9, "agricultura": 17.0}
03a4556e-f26b-4d84-af42-c5cddc3ff6eb	1715101	2019	229.76	21940.58	64.1	3.2166652e+07	{"servicos": 58.2, "industria": 21.3, "agricultura": 20.5}
10b65dc4-5e0b-4c9b-a496-12144ca63023	1715101	2020	264.46	25596.57	56.2	3.7024928e+07	{"servicos": 61.4, "industria": 26.2, "agricultura": 12.4}
935c2677-a9b8-4eed-957c-53228d27bb7b	1715101	2021	263.08	26877.73	60.8	3.6831088e+07	{"servicos": 44.3, "industria": 33.9, "agricultura": 21.8}
d8c71291-aa6d-4dfe-860a-b720dc029dff	1715101	2022	307.4	32273.08	57.8	4.3036148e+07	{"servicos": 64.9, "industria": 26.9, "agricultura": 8.1}
159bc449-5068-42d3-827f-4943816cd901	1715101	2023	288.26	29450.29	62.7	4.035632e+07	{"servicos": 51.8, "industria": 32.3, "agricultura": 15.9}
051d44ab-3039-4071-a1f5-7ed5972478de	1715150	2019	597.5	20556.63	63.5	7.966653e+07	{"servicos": 68.9, "industria": 22.3, "agricultura": 8.9}
c9ea70c7-8410-44d2-9eed-841f2eebec92	1715150	2020	565.69	18499.93	62.8	7.542544e+07	{"servicos": 49.3, "industria": 29.4, "agricultura": 21.2}
192cac22-0a26-452e-a645-3763980261b1	1715150	2021	651.72	21304.92	55.6	8.6895664e+07	{"servicos": 45.7, "industria": 34.8, "agricultura": 19.5}
0841487f-4e93-44fe-af15-d69edb9800f3	1715150	2022	732.09	24630.48	66.1	9.761223e+07	{"servicos": 66.9, "industria": 20.7, "agricultura": 12.4}
d0dde2a4-a24f-4628-8541-c5d7dd9eb261	1715150	2023	686.61	24026.57	62.8	9.154763e+07	{"servicos": 72.9, "industria": 21.6, "agricultura": 5.5}
3b9a0512-bc13-4234-9b3d-c209651645b8	1715259	2019	2068.07	30492.12	67.3	2.0680669e+08	{"servicos": 50.5, "industria": 24.6, "agricultura": 24.9}
130a9201-55b6-4fd1-8184-5cb0a90bf1d1	1715259	2020	2148.65	32201.59	62	2.1486514e+08	{"servicos": 47.6, "industria": 31.5, "agricultura": 20.9}
8d7e3e16-d7d5-4759-b799-4ef19d169e93	1715259	2021	2326.62	32494.76	61	2.3266246e+08	{"servicos": 64.6, "industria": 28.1, "agricultura": 7.4}
3503a313-98d8-464c-ac53-24e73aa8a654	1715259	2022	2109.33	29880.12	60.2	2.1093275e+08	{"servicos": 55.9, "industria": 24.0, "agricultura": 20.1}
41ed0944-4a06-4123-8f6b-e928845e6308	1715259	2023	2053.21	30658.59	63.5	2.0532061e+08	{"servicos": 73.1, "industria": 19.1, "agricultura": 7.8}
f04e6fb6-5bab-4987-a9ef-3f6b89aea623	1715507	2019	2188.37	31518.11	61.4	2.1883653e+08	{"servicos": 65.1, "industria": 21.9, "agricultura": 13.0}
e5b3b93f-3839-4da3-9eeb-cc8aef682842	1715507	2020	2221.96	30534.85	57.5	2.22196e+08	{"servicos": 59.3, "industria": 34.5, "agricultura": 6.2}
13ae2b2a-526e-409e-9c50-919c8d66c586	1715507	2021	2002.76	29331.61	55.2	2.0027621e+08	{"servicos": 74.7, "industria": 18.1, "agricultura": 7.2}
b5d4ad6a-409c-4439-bae4-b3a92586df1e	1715507	2022	2418.88	33020.91	62.9	2.4188803e+08	{"servicos": 69.7, "industria": 24.9, "agricultura": 5.4}
44525e8b-2e73-40b7-864a-cbe2a6d7c6da	1715507	2023	2323.94	32154.62	56.6	2.3239429e+08	{"servicos": 68.3, "industria": 25.2, "agricultura": 6.6}
0f2ad222-fc19-4937-8c45-e2664395dfe9	1721000	2019	11833.33	37277.25	56.9	1.479166e+09	{"servicos": 58.0, "industria": 25.8, "agricultura": 16.2}
5fc867c3-08a8-4727-9752-10760d2d170d	1721000	2020	11335.15	37545.42	57.4	1.416894e+09	{"servicos": 66.2, "industria": 19.2, "agricultura": 14.6}
ced8d6ca-fcd1-4146-9a5e-9e5e4e3ff23d	1721000	2021	12345.88	41331.48	62.5	1.5432348e+09	{"servicos": 50.0, "industria": 26.4, "agricultura": 23.6}
2a4f5332-ea3e-4ed8-acc8-b45813fb2f4e	1721000	2022	12524.72	39739.83	67.8	1.5655903e+09	{"servicos": 42.7, "industria": 32.8, "agricultura": 24.4}
f20236a4-f178-4e32-b16a-8ebaba5168f2	1721000	2023	15169.08	49753.92	58.2	1.8961344e+09	{"servicos": 52.6, "industria": 23.0, "agricultura": 24.4}
826b18b8-2a19-4054-b408-d1b7e5cfab9d	1715705	2019	615.15	20338.92	65.4	8.202008e+07	{"servicos": 58.9, "industria": 27.9, "agricultura": 13.2}
41a52682-9e07-46ad-9aad-1566e1c04918	1715705	2020	619.2	21357.64	56.1	8.256011e+07	{"servicos": 53.7, "industria": 30.8, "agricultura": 15.5}
355e470b-22c7-493d-a57f-f6a384384324	1715705	2021	711.11	24542.25	57.1	9.4814896e+07	{"servicos": 55.7, "industria": 34.1, "agricultura": 10.2}
3d6f1617-eb9c-4a7d-915f-4f6efdfd0a51	1715705	2022	715.79	23378.87	61	9.5438776e+07	{"servicos": 53.6, "industria": 28.7, "agricultura": 17.7}
927206f6-4a9e-4a98-b40f-bbd3a87d36f4	1715705	2023	760.03	26115.97	58.8	1.01336936e+08	{"servicos": 59.8, "industria": 17.9, "agricultura": 22.3}
f39813fb-61f2-4cb7-9df6-423012a56df3	1713809	2019	586.21	19609.68	67.3	7.816157e+07	{"servicos": 69.5, "industria": 18.7, "agricultura": 11.8}
120aebd0-87b7-4ae0-b3e5-1905af3249b8	1713809	2020	642.28	21314.97	69.2	8.563788e+07	{"servicos": 52.5, "industria": 31.6, "agricultura": 15.9}
7f99f42a-50f0-4b90-a592-af51ee1fec28	1713809	2021	724.16	25242.57	66.7	9.6554504e+07	{"servicos": 71.5, "industria": 17.9, "agricultura": 10.6}
0e109e77-53b4-48c1-a234-b5d0b1b9e16e	1713809	2022	714.07	24945.52	65.3	9.520872e+07	{"servicos": 61.7, "industria": 20.3, "agricultura": 17.9}
b7ab4a2d-9e1a-441e-a805-5ec79a6a8688	1713809	2023	762.52	24435.2	63.6	1.01669976e+08	{"servicos": 74.9, "industria": 18.6, "agricultura": 6.5}
5a325cd7-85d6-4b94-810b-2ef1bcd03de0	1715754	2019	581.12	20079.43	68.4	7.7482504e+07	{"servicos": 45.4, "industria": 33.7, "agricultura": 20.9}
545a961e-418c-4507-bcb3-5fb4c80f3f6b	1715754	2020	701.32	23754.3	64.5	9.35096e+07	{"servicos": 43.9, "industria": 31.8, "agricultura": 24.3}
1c23af5f-d4a5-42cd-93a9-4ad88e837261	1715754	2021	634.59	21405.67	66	8.461235e+07	{"servicos": 61.9, "industria": 16.6, "agricultura": 21.5}
55357b41-dee2-4a92-9ec3-55b925d50191	1715754	2022	650.78	20818.33	61.1	8.67708e+07	{"servicos": 63.7, "industria": 16.0, "agricultura": 20.3}
7bff6385-c9f2-41e4-87b7-44d1c94af81f	1715754	2023	674.87	23666.49	57.2	8.998315e+07	{"servicos": 68.7, "industria": 25.4, "agricultura": 5.9}
b2c21a96-42e7-4ebf-994b-ab3961c1bf4e	1716208	2019	237.16	23659.49	57	3.320278e+07	{"servicos": 53.1, "industria": 29.2, "agricultura": 17.7}
5bdce75f-f4d6-4aa0-a722-60673b7a588a	1716208	2020	282.47	26981.61	65.6	3.954586e+07	{"servicos": 61.0, "industria": 28.5, "agricultura": 10.5}
8422d585-ab24-43a3-95e7-bc38c6d4e5b7	1716208	2021	272.88	27392.3	64.6	3.82035e+07	{"servicos": 51.5, "industria": 29.9, "agricultura": 18.7}
89cd856b-6ea6-4748-8362-cc8db01efa79	1716208	2022	250.35	25698.12	64.4	3.5049148e+07	{"servicos": 56.7, "industria": 32.5, "agricultura": 10.8}
d79ce891-73d0-4df6-a0ee-51e3be839deb	1716208	2023	272.19	25952.39	64.2	3.8106412e+07	{"servicos": 60.5, "industria": 25.8, "agricultura": 13.7}
b3701b5a-4810-4ea5-80c7-2bd8e796d04c	1716109	2019	2255.74	32916.12	65.7	2.2557419e+08	{"servicos": 62.6, "industria": 25.0, "agricultura": 12.4}
1d134e3f-812a-495f-8802-c3243f389426	1716109	2020	2004.12	27627.81	68.2	2.0041218e+08	{"servicos": 58.8, "industria": 34.8, "agricultura": 6.4}
9aa5aadf-6266-4445-8f51-5d2107f8f644	1716109	2021	2132.95	29702.71	56	2.1329515e+08	{"servicos": 53.7, "industria": 25.6, "agricultura": 20.8}
87cb9fff-741f-4a34-a7d1-c65ec43d1912	1716109	2022	1970.38	26835.63	59.7	1.9703794e+08	{"servicos": 58.9, "industria": 28.0, "agricultura": 13.1}
1c17aa48-c60b-48ae-bdd9-37fcdc86a96a	1716109	2023	2046.83	28512.08	60	2.0468254e+08	{"servicos": 46.7, "industria": 31.8, "agricultura": 21.5}
9234c19e-f44e-478f-9485-10892447410e	1716307	2019	627.27	21734.88	65.6	8.3635816e+07	{"servicos": 41.7, "industria": 34.2, "agricultura": 24.2}
0d9af322-875e-4457-b651-d5f7f305eb82	1716307	2020	680.32	21872.58	68.5	9.0709944e+07	{"servicos": 64.7, "industria": 20.0, "agricultura": 15.4}
f14fe442-cfc9-40dd-b494-745f470d066e	1716307	2021	578.57	18517.29	66	7.7143024e+07	{"servicos": 63.2, "industria": 31.4, "agricultura": 5.4}
5868b503-4918-49b9-b748-098a08f544ac	1716307	2022	725.79	25406.64	65.3	9.677221e+07	{"servicos": 73.7, "industria": 20.4, "agricultura": 5.9}
9a1b32ea-6023-4a9d-b2fa-c0cb30e853ba	1716307	2023	709.52	23086.48	66.1	9.460223e+07	{"servicos": 49.0, "industria": 29.4, "agricultura": 21.6}
27af3e54-e081-4c84-8bb4-4c9f3a0de9a9	1716505	2019	636.06	22008.94	62.2	8.4807776e+07	{"servicos": 65.0, "industria": 19.1, "agricultura": 15.9}
3c17af48-9a28-47f2-807a-b3207e976b45	1716505	2020	655.22	20973.04	56.2	8.736251e+07	{"servicos": 44.3, "industria": 32.8, "agricultura": 22.9}
64922716-03d6-4bbc-a186-42c5c48cddff	1716505	2021	619.43	20222.29	61.7	8.259052e+07	{"servicos": 47.6, "industria": 28.8, "agricultura": 23.7}
f1c9a59c-8c24-4399-b41b-06aa231c196e	1716505	2022	733.51	25590	69.3	9.780157e+07	{"servicos": 62.6, "industria": 30.5, "agricultura": 6.9}
00aa1809-720c-402c-b5b4-7cdc7906a923	1716505	2023	747.84	25195.19	68	9.971249e+07	{"servicos": 63.4, "industria": 25.3, "agricultura": 11.3}
63704a5a-4ed2-4707-85f7-9582476a3072	1716604	2019	611.1	19885.56	59.7	8.148043e+07	{"servicos": 62.4, "industria": 23.7, "agricultura": 13.8}
280d0cf2-d454-44a3-9e24-be59af00b7d7	1716604	2020	646.81	20796.31	55.2	8.624091e+07	{"servicos": 57.6, "industria": 20.1, "agricultura": 22.2}
2ac6756e-935b-4f6a-8e40-bbb147c0b734	1716604	2021	640.99	22311.43	65.5	8.5464696e+07	{"servicos": 52.9, "industria": 31.7, "agricultura": 15.4}
3b5c67d4-f836-4b62-9270-5692052959c9	1716604	2022	647.45	20776.95	55.9	8.632684e+07	{"servicos": 74.3, "industria": 15.6, "agricultura": 10.1}
06a0179a-adbd-43e5-a19e-c0c5d5f8ce5a	1716604	2023	744.69	25204.42	59.1	9.9291984e+07	{"servicos": 64.4, "industria": 22.5, "agricultura": 13.1}
5512ab6b-9bc0-44d3-a787-6cca9b97c54a	1716653	2019	1887.52	25875.61	62.7	1.8875221e+08	{"servicos": 50.3, "industria": 27.8, "agricultura": 21.9}
9083c1c5-c1dd-48e5-8568-c332cf0af8ec	1716653	2020	2169.31	30356.61	63.4	2.1693134e+08	{"servicos": 57.9, "industria": 18.2, "agricultura": 23.9}
93d36975-25a8-49b6-b784-2a13dd97df25	1716653	2021	2021.1	28440.89	57.3	2.021095e+08	{"servicos": 64.2, "industria": 20.5, "agricultura": 15.3}
14c9bd44-eafd-4b5b-aba7-4947372a2576	1716653	2022	2242.14	31007.39	57.5	2.2421443e+08	{"servicos": 46.3, "industria": 30.2, "agricultura": 23.5}
630f5180-7047-4cdd-9f6e-9c9d0aec116c	1716653	2023	2374.72	34315.21	59.5	2.3747158e+08	{"servicos": 73.7, "industria": 16.7, "agricultura": 9.6}
d91d8ef6-9a15-4e5e-b878-3e46cf3448b8	1717008	2019	279.6	29314.45	66.1	3.9144164e+07	{"servicos": 63.5, "industria": 24.4, "agricultura": 12.1}
d5ea08ad-8a30-4e36-901b-3a841d6004f4	1717008	2020	287.7	28735.23	63.1	4.02776e+07	{"servicos": 66.9, "industria": 22.9, "agricultura": 10.1}
d99f85d7-4f3a-4ed1-b2fc-cfde5e8f12d3	1717008	2021	246.49	24397.58	60.9	3.4508428e+07	{"servicos": 78.1, "industria": 16.6, "agricultura": 5.3}
0858af44-6c97-4a03-b6ea-87920c806c3b	1717008	2022	294.53	30673.95	58.7	4.1234376e+07	{"servicos": 62.5, "industria": 27.9, "agricultura": 9.6}
aad513c4-5698-4ada-9ce7-bb6a3ab53e35	1717008	2023	276.23	28574.34	58.9	3.8671936e+07	{"servicos": 54.2, "industria": 25.2, "agricultura": 20.6}
17a4329d-c72a-4d28-98dd-378b44404194	1717206	2019	275.69	26935.67	59.1	3.859612e+07	{"servicos": 57.6, "industria": 20.7, "agricultura": 21.7}
86e00c74-b449-4f7b-bfea-dd4bfbbf8376	1717206	2020	270.83	28191.16	65.1	3.791654e+07	{"servicos": 62.5, "industria": 20.5, "agricultura": 17.0}
2f56ad73-62ce-4c70-9674-e8dd6f440ceb	1717206	2021	265.3	26066.19	68.8	3.714224e+07	{"servicos": 54.9, "industria": 28.0, "agricultura": 17.1}
e19ab2f6-5e17-4b35-90b9-1f31820211b0	1717206	2022	264.82	26578.17	59.5	3.7075484e+07	{"servicos": 65.6, "industria": 23.8, "agricultura": 10.6}
165ee04f-aac6-425a-9802-52c6fb27eab6	1717206	2023	287.37	29120.98	61.8	4.0231212e+07	{"servicos": 55.9, "industria": 20.7, "agricultura": 23.5}
96c0edda-b5ba-4c49-b2e6-b8727770dcc8	1717503	2019	279.68	26748.67	56.9	3.9155768e+07	{"servicos": 59.6, "industria": 32.1, "agricultura": 8.4}
2723ff3d-0226-4bf7-8319-298925de85ed	1717503	2020	252.57	24402.43	58.9	3.535912e+07	{"servicos": 67.7, "industria": 19.5, "agricultura": 12.7}
4bf5321b-6819-46fe-9d7c-d765659d01a0	1717503	2021	284.91	29459.75	67	3.988674e+07	{"servicos": 67.9, "industria": 23.5, "agricultura": 8.7}
8a799856-d702-4de2-bb82-10f57617d38c	1717503	2022	259.38	25814.08	66.4	3.6313176e+07	{"servicos": 49.6, "industria": 34.5, "agricultura": 15.8}
d033f549-e922-47ef-bffd-fb94e55066a7	1717503	2023	315	32984.54	62.5	4.4100324e+07	{"servicos": 54.5, "industria": 27.6, "agricultura": 17.9}
a1a3d85b-bbe6-409f-ac28-23878771cc7f	1717800	2019	263.72	25185.57	58.7	3.6920528e+07	{"servicos": 74.0, "industria": 15.6, "agricultura": 10.4}
8d2ea596-58da-4994-a0a4-0b650d4c23f0	1717800	2020	289.23	27725.64	57	4.049274e+07	{"servicos": 62.6, "industria": 29.6, "agricultura": 7.9}
4743c1dc-ba5f-4f8a-84f8-6596695c585c	1717800	2021	301.08	30876.55	59.6	4.2150808e+07	{"servicos": 64.0, "industria": 16.3, "agricultura": 19.6}
8d4fcc47-267a-477c-87ae-e3ba15c82f46	1717800	2022	259.92	26297.17	65.6	3.6388968e+07	{"servicos": 74.8, "industria": 17.7, "agricultura": 7.6}
2596405f-8a42-4a17-8004-b87edf7385ab	1717800	2023	276.88	26424.89	58.6	3.8763196e+07	{"servicos": 51.7, "industria": 33.8, "agricultura": 14.4}
04e0b5d6-5a39-4f5c-bd33-fed7d2068515	1717909	2019	678.13	21617.76	62.9	9.0416984e+07	{"servicos": 49.6, "industria": 31.1, "agricultura": 19.4}
424da9e7-f723-4758-a990-01608e64217f	1717909	2020	650.35	22565.96	58.7	8.671347e+07	{"servicos": 67.2, "industria": 17.3, "agricultura": 15.5}
e8ce8e98-2044-45d0-a3ac-ef69d97b53dd	1717909	2021	589.65	19460.4	60.6	7.8620016e+07	{"servicos": 70.8, "industria": 21.2, "agricultura": 8.0}
4adf90d6-b112-4596-b287-7b5386bf264e	1717909	2022	745.26	26003.37	60.1	9.9367544e+07	{"servicos": 78.5, "industria": 15.1, "agricultura": 6.4}
43db43c1-81cd-4769-ab93-7ecf2f2c6e01	1717909	2023	675.07	21488.05	58.6	9.000916e+07	{"servicos": 68.1, "industria": 25.2, "agricultura": 6.7}
eedd5e63-e02b-4065-af16-c76b349c76eb	1718006	2019	630.6	21050.06	62	8.4079544e+07	{"servicos": 52.3, "industria": 28.8, "agricultura": 18.8}
617a3cef-cc54-4ab3-878b-a4f577e0cb70	1718006	2020	703.7	23232.15	62.8	9.382689e+07	{"servicos": 54.9, "industria": 26.1, "agricultura": 19.0}
24429338-22bd-4311-ab0c-a1d934a6acae	1718006	2021	602.99	20482.86	61	8.039933e+07	{"servicos": 64.4, "industria": 27.0, "agricultura": 8.6}
184a7175-95e7-4e20-845c-dbacb4ec427a	1718006	2022	660.35	20988.15	55.3	8.804669e+07	{"servicos": 57.2, "industria": 29.9, "agricultura": 13.0}
2c2bb62d-b9ab-4515-8472-31a4d7d150cc	1718006	2023	671.54	22942.02	60.7	8.9538104e+07	{"servicos": 61.5, "industria": 27.6, "agricultura": 10.9}
b0b6facf-f719-4044-9800-bfd4e178c1ff	1718204	2019	1905.27	28604.22	67	1.9052696e+08	{"servicos": 41.1, "industria": 34.0, "agricultura": 24.9}
f6dbe1d8-9024-4d69-a15c-71ca3caa6745	1718204	2020	2004.04	29678.43	65.3	2.004036e+08	{"servicos": 75.3, "industria": 16.2, "agricultura": 8.4}
e234abcc-6a0a-4994-9da2-4cd2199b1bb6	1718204	2021	1970.18	27256.48	64.7	1.9701802e+08	{"servicos": 69.9, "industria": 22.2, "agricultura": 7.9}
0c79cd0e-ea77-4c9e-b2af-7e83659a55b8	1718204	2022	1986.89	29331.52	55.5	1.986888e+08	{"servicos": 71.3, "industria": 23.1, "agricultura": 5.6}
ffd270e1-e8c7-452c-a215-9bc199384f5f	1718204	2023	2228.62	33224.8	67.6	2.2286203e+08	{"servicos": 52.4, "industria": 25.5, "agricultura": 22.1}
1511dd39-8a84-4f19-9a97-b0c691aee341	1718303	2019	260.15	25333.41	67.7	3.6420836e+07	{"servicos": 63.1, "industria": 15.2, "agricultura": 21.7}
b338f9b1-c7ea-4124-9269-605babe4429c	1718303	2020	249.93	25991.52	58	3.499082e+07	{"servicos": 45.3, "industria": 31.7, "agricultura": 22.9}
9e2469ec-f19a-4d80-970d-d20b4dd83ebd	1718303	2021	292.1	28030.03	66.2	4.0894128e+07	{"servicos": 63.5, "industria": 22.3, "agricultura": 14.2}
2460a4cf-9390-4567-ba04-c2783c0ec0d4	1718303	2022	297.18	29924.25	61.8	4.1604876e+07	{"servicos": 43.0, "industria": 34.1, "agricultura": 22.9}
481a2052-19d4-4517-acd4-6b69913c8119	1718303	2023	285.44	28684.49	60.1	3.9961516e+07	{"servicos": 62.0, "industria": 24.5, "agricultura": 13.5}
3c93498c-d6d5-4b55-a2e0-3657b9c4f1d1	1718402	2019	649.66	20888.61	64.9	8.6620896e+07	{"servicos": 76.5, "industria": 16.8, "agricultura": 6.6}
01ed0656-e08a-4584-b0c6-8950df592dff	1718402	2020	594.76	18970.39	67.4	7.930127e+07	{"servicos": 76.0, "industria": 16.3, "agricultura": 7.7}
3ad1064e-6a39-4143-aaef-edeec075668f	1718402	2021	674.53	22045.62	66.7	8.993731e+07	{"servicos": 72.5, "industria": 17.4, "agricultura": 10.1}
e5a8e73b-8f8d-43ba-a42d-a378d82c9096	1718402	2022	705.29	22606.03	69.2	9.4038064e+07	{"servicos": 63.1, "industria": 18.6, "agricultura": 18.3}
1d5c0307-a4c8-48d6-8539-b7a373c37dce	1718402	2023	636.23	21035.23	57.6	8.4830864e+07	{"servicos": 61.1, "industria": 32.6, "agricultura": 6.3}
e627a645-75aa-4f27-b4a7-1a66907e22d0	1718451	2019	591.43	19839.21	67.1	7.885688e+07	{"servicos": 48.0, "industria": 29.3, "agricultura": 22.7}
5f03892b-92e4-4014-be61-c06a2dfa159e	1718451	2020	685.69	22881.53	56.6	9.142545e+07	{"servicos": 68.9, "industria": 18.1, "agricultura": 13.0}
846b2ca1-2d77-4b3a-b329-fef91d8e016d	1718451	2021	707.4	24340.94	61.6	9.4319536e+07	{"servicos": 70.2, "industria": 17.8, "agricultura": 12.0}
ddba97a8-f15d-4747-9db8-f575fe2d39c9	1718451	2022	694.79	23213.08	67.4	9.263877e+07	{"servicos": 47.9, "industria": 33.9, "agricultura": 18.2}
be93eb79-e766-4971-90f0-5463383a9a61	1718451	2023	730.74	24505.19	66.5	9.743263e+07	{"servicos": 56.2, "industria": 32.0, "agricultura": 11.8}
9d57d134-46ce-4e1d-ab40-a6e37c76db1d	1718501	2019	256.18	25498.14	65.6	3.5865172e+07	{"servicos": 48.9, "industria": 28.1, "agricultura": 22.9}
2d8ee6d9-706f-431b-96bb-9a7ee934fb76	1718501	2020	248.52	26148.65	61.3	3.4792348e+07	{"servicos": 65.9, "industria": 26.8, "agricultura": 7.2}
b28c7e9a-d3dd-4f12-8397-c05cfd8559cd	1718501	2021	249.79	25727.53	69.5	3.4970404e+07	{"servicos": 56.9, "industria": 22.0, "agricultura": 21.0}
62b35279-f3e7-4106-b771-152b066e5a98	1718501	2022	305.33	31032.12	68.8	4.2745504e+07	{"servicos": 55.2, "industria": 28.0, "agricultura": 16.8}
3ef299ce-302b-4c2e-9555-fd13dbca89ad	1718501	2023	311.23	32416.39	64.2	4.3572172e+07	{"servicos": 55.7, "industria": 22.6, "agricultura": 21.7}
5ce56c53-aeab-448f-ad62-940e1b74f573	1718550	2019	630.04	20082.83	68.8	8.4005136e+07	{"servicos": 58.4, "industria": 18.8, "agricultura": 22.7}
1f0630f0-3e71-422a-83a9-de1366d019c3	1718550	2020	626.86	20463.64	66.8	8.358167e+07	{"servicos": 52.1, "industria": 35.0, "agricultura": 12.9}
affe89c9-11a2-46d9-a326-8542825de8b8	1718550	2021	727.39	23388.89	57.4	9.6985936e+07	{"servicos": 56.4, "industria": 20.9, "agricultura": 22.7}
ce925659-7256-4658-a1c1-08635e7df470	1718550	2022	697.85	23594.32	64.9	9.3046544e+07	{"servicos": 57.2, "industria": 22.4, "agricultura": 20.5}
3793f245-893b-4bec-bc47-53e2651bb7dc	1718550	2023	620.26	21216.35	60.6	8.2701344e+07	{"servicos": 68.8, "industria": 19.2, "agricultura": 12.0}
9d46acb4-e43e-4770-8f04-e9b5c8dac356	1718758	2019	286.17	27935.68	56.8	4.0064236e+07	{"servicos": 61.4, "industria": 26.2, "agricultura": 12.4}
575329c2-d491-473f-ac5c-687a1e1d2a22	1718758	2020	270.19	26314.26	65.2	3.7827272e+07	{"servicos": 52.2, "industria": 26.6, "agricultura": 21.2}
37796d8e-4674-4579-84da-f5740957ea3c	1718758	2021	258.53	24765.84	69.2	3.619428e+07	{"servicos": 61.4, "industria": 19.1, "agricultura": 19.6}
85614e7e-2b57-4fb4-b2c5-e50f9ee54c40	1718758	2022	266.19	27019.21	59.3	3.7267052e+07	{"servicos": 62.6, "industria": 25.2, "agricultura": 12.2}
df39f9a3-5d2b-46ca-ac94-75868559be95	1718758	2023	280.78	28459.01	55.7	3.9308716e+07	{"servicos": 70.2, "industria": 24.5, "agricultura": 5.3}
3275d715-1a21-4bc1-a1a2-5f91b25d138f	1718659	2019	226.79	23757.41	65.3	3.1750352e+07	{"servicos": 65.8, "industria": 16.6, "agricultura": 17.7}
aaa41dec-e1d6-4832-a5be-5e826f440a2b	1718659	2020	263.41	25995.28	67.4	3.687742e+07	{"servicos": 57.1, "industria": 29.5, "agricultura": 13.5}
1ae1a99a-006b-4559-bd1a-2d51e28dd002	1718659	2021	284.65	28671.12	57.2	3.985056e+07	{"servicos": 76.0, "industria": 16.8, "agricultura": 7.2}
452e6210-8507-4bf1-9261-de007e97433a	1718659	2022	288.15	29993.55	69.5	4.0340728e+07	{"servicos": 61.4, "industria": 27.8, "agricultura": 10.8}
013649b9-1885-47e8-b8fc-2c3046371d77	1718659	2023	312.21	30238.33	61.9	4.3709512e+07	{"servicos": 53.1, "industria": 26.7, "agricultura": 20.1}
1481d1f4-f904-4bff-aa7c-f51d0e8e5916	1718709	2019	277.68	27972.48	67	3.8875588e+07	{"servicos": 64.9, "industria": 24.8, "agricultura": 10.3}
70051348-54a3-473b-868c-a612188ad59c	1718709	2020	260.91	25720.3	62	3.652694e+07	{"servicos": 65.4, "industria": 19.1, "agricultura": 15.5}
ff4efc42-55e5-42c5-b427-e0db27b73d48	1718709	2021	260.22	25871.82	56.6	3.6430632e+07	{"servicos": 65.1, "industria": 27.4, "agricultura": 7.5}
6696262c-e644-4659-9479-2ebc6b053b57	1718709	2022	294.56	30754.01	61	4.1238664e+07	{"servicos": 67.3, "industria": 27.0, "agricultura": 5.7}
4867c316-112c-426c-ae1e-327c14c40da9	1718709	2023	300.47	29117.81	63.6	4.2065332e+07	{"servicos": 48.0, "industria": 28.0, "agricultura": 24.0}
eabc313b-460a-4893-9199-96ebfeddb3e7	1718808	2019	1843.45	25415.01	69.3	1.8434523e+08	{"servicos": 68.4, "industria": 20.5, "agricultura": 11.0}
371f6f6a-477c-4d3d-a239-c67a751681f3	1718808	2020	1880.35	25623.76	59	1.8803486e+08	{"servicos": 51.6, "industria": 26.3, "agricultura": 22.0}
f615fb3e-17b3-4cb4-a8dc-7833d32e8a95	1718808	2021	2088.31	30599.23	58.3	2.0883056e+08	{"servicos": 71.4, "industria": 15.6, "agricultura": 13.0}
a13e31a6-9a71-4951-8235-0be7dae853e5	1718808	2022	2087.42	31234.3	57.5	2.0874195e+08	{"servicos": 62.2, "industria": 25.3, "agricultura": 12.5}
8ede0e63-a0d5-4f70-8749-fe379c1b95d6	1718808	2023	2178.73	31831.37	55.2	2.1787298e+08	{"servicos": 69.7, "industria": 17.9, "agricultura": 12.4}
5d1276be-8811-4bbd-ac1e-27d2e4844c29	1718840	2019	596.38	19804.88	69.2	7.951791e+07	{"servicos": 66.7, "industria": 23.9, "agricultura": 9.4}
278006da-7f92-48e3-82ab-41a6da14ed1e	1718840	2020	560.5	18988.41	67.4	7.473332e+07	{"servicos": 46.3, "industria": 32.2, "agricultura": 21.5}
9b3df099-2f69-426e-820b-598a17d99305	1718840	2021	592.02	19689.3	67	7.8935704e+07	{"servicos": 60.2, "industria": 24.6, "agricultura": 15.2}
498e0792-8366-4e46-b018-cdf6e36f3a94	1718840	2022	607.25	20592.5	63.3	8.096697e+07	{"servicos": 61.6, "industria": 21.8, "agricultura": 16.6}
a101ecaa-eabc-4d2b-be27-6c809812233c	1718840	2023	717.59	23380.25	65.9	9.567824e+07	{"servicos": 60.3, "industria": 29.5, "agricultura": 10.2}
48ed001b-de89-4bc4-8c6b-40a3619e58cb	1718865	2019	551.37	19176.64	62.5	7.351555e+07	{"servicos": 50.4, "industria": 27.5, "agricultura": 22.1}
e0ea01f5-9461-402d-b5a9-bfb4e062df17	1718865	2020	562.02	18449.34	69.4	7.4936296e+07	{"servicos": 66.2, "industria": 18.9, "agricultura": 14.9}
749b859a-f065-4277-b182-f00157143e4a	1718865	2021	639.57	20830.8	68.6	8.5275744e+07	{"servicos": 68.1, "industria": 26.2, "agricultura": 5.7}
8c17f285-6997-46f3-9481-0cbabb4b057e	1718865	2022	649.34	21474.17	69.5	8.6578136e+07	{"servicos": 51.0, "industria": 33.3, "agricultura": 15.7}
0479864a-7508-4ea8-bec1-8467ab8ee14f	1718865	2023	700.38	23841.03	60.4	9.338372e+07	{"servicos": 48.3, "industria": 27.2, "agricultura": 24.5}
dca260b6-1dc3-4308-9bb1-123ad6ba6790	1718881	2019	548.39	18123.35	63.5	7.3119264e+07	{"servicos": 65.3, "industria": 20.1, "agricultura": 14.6}
243724aa-5e9d-40ad-8f08-18bf0ffb09b7	1718881	2020	684.8	22449.53	68.7	9.1306744e+07	{"servicos": 50.2, "industria": 32.1, "agricultura": 17.7}
6947667f-4531-449d-9b20-5e9602dc0780	1718881	2021	637.13	21894.57	59.3	8.4950936e+07	{"servicos": 42.7, "industria": 34.0, "agricultura": 23.2}
ce5f6130-a99c-49d7-9937-382aa8b29a3c	1718881	2022	685.37	22718.4	66.7	9.138251e+07	{"servicos": 61.3, "industria": 19.4, "agricultura": 19.4}
59be674a-a811-40f1-88db-2f7bba4abcef	1718881	2023	720.64	24320.56	62.5	9.6085656e+07	{"servicos": 62.4, "industria": 30.8, "agricultura": 6.8}
e0642665-0219-4a4c-b3cd-417f0515ea62	1718899	2019	679.26	21894.63	62.9	9.056788e+07	{"servicos": 56.9, "industria": 24.6, "agricultura": 18.5}
fd95a101-fa52-4519-8a3a-5d23a23c9c29	1718899	2020	575.27	19336.13	62.5	7.670257e+07	{"servicos": 55.6, "industria": 19.9, "agricultura": 24.5}
9dd79f92-81ba-4338-87f3-8cd2f3c0f459	1718899	2021	573.56	18938.12	64.2	7.647464e+07	{"servicos": 57.8, "industria": 31.7, "agricultura": 10.5}
0d0f3186-dbca-4866-9b92-2276c42305d4	1718899	2022	736.85	24743.16	63.5	9.824684e+07	{"servicos": 50.1, "industria": 35.0, "agricultura": 14.9}
b70932d7-54ee-48d4-94e6-c4a17dbffe89	1718899	2023	750.88	26128.58	63.7	1.0011776e+08	{"servicos": 55.9, "industria": 26.8, "agricultura": 17.4}
fc1e7bcd-7dc2-4f50-aaff-2a4285d06a62	1718907	2019	675.82	22538.66	56.6	9.0109576e+07	{"servicos": 54.2, "industria": 23.0, "agricultura": 22.8}
476c79f7-27ba-40d9-abcd-e8a9d4d00f7a	1718907	2020	648.06	21120.32	60.9	8.640743e+07	{"servicos": 58.4, "industria": 28.8, "agricultura": 12.7}
14628f92-5c2e-4ba1-a7bd-988baf5c265b	1718907	2021	644.93	20806.06	62.6	8.599008e+07	{"servicos": 74.8, "industria": 17.9, "agricultura": 7.3}
682e1b2d-f335-491b-9bb1-7dbcc2f5958a	1718907	2022	734.66	23375.96	61	9.795463e+07	{"servicos": 63.9, "industria": 22.1, "agricultura": 14.1}
ee9d65ab-efe5-40ef-8dc6-eec89f968bab	1718907	2023	605.69	21057.13	62.3	8.075832e+07	{"servicos": 70.2, "industria": 16.2, "agricultura": 13.6}
4941ffa8-c2b5-459b-817d-4f03a3e072fd	1719004	2019	245.86	25554.34	67.9	3.442016e+07	{"servicos": 68.0, "industria": 20.1, "agricultura": 11.8}
d7e17ae3-bea5-4289-8fff-8e5d43462f54	1719004	2020	246.7	24515.62	57.8	3.4538096e+07	{"servicos": 45.1, "industria": 32.0, "agricultura": 22.8}
cbbfe7a6-e6f9-4f1d-a908-c57016508f56	1719004	2021	274.31	26442.42	58.7	3.840392e+07	{"servicos": 49.6, "industria": 30.4, "agricultura": 20.0}
8e341f53-4eca-4740-860c-c0aabc242f3d	1719004	2022	286.32	29862.76	63.4	4.008538e+07	{"servicos": 47.7, "industria": 28.6, "agricultura": 23.6}
9e4c5907-bbb1-4d9b-b247-6a9e756bcd03	1719004	2023	287.53	28397.8	55.6	4.0253876e+07	{"servicos": 66.7, "industria": 20.3, "agricultura": 13.0}
66eca425-5a1e-4def-bc0d-0cd45f678c62	1720002	2019	260.18	26468.16	60.5	3.6425476e+07	{"servicos": 73.0, "industria": 17.0, "agricultura": 10.0}
80ea5d75-493d-4f2c-b98b-d0683a5d00b2	1720002	2020	254.07	26476.23	59.8	3.5569228e+07	{"servicos": 67.9, "industria": 21.2, "agricultura": 10.9}
879d4614-1e12-4004-94ff-08d95f1a6f53	1720002	2021	251.58	24560.91	69.6	3.5220844e+07	{"servicos": 72.2, "industria": 17.9, "agricultura": 9.9}
03839828-614d-4d00-9655-11b4ff9b1276	1720002	2022	276.04	26339.84	55	3.8645816e+07	{"servicos": 63.6, "industria": 24.6, "agricultura": 11.8}
47d43de7-a916-436d-b6ce-484f984d5df7	1720002	2023	269.76	26405.37	60.7	3.776602e+07	{"servicos": 60.3, "industria": 25.7, "agricultura": 14.0}
f4a8c0ca-cc46-489c-9760-3e8ef823a7eb	1720655	2019	247.48	23789.59	59.1	3.4647636e+07	{"servicos": 51.4, "industria": 33.9, "agricultura": 14.6}
37011a4b-824e-4186-ae16-ef572493021e	1720655	2020	280.04	27779.11	63.9	3.9205764e+07	{"servicos": 66.1, "industria": 19.6, "agricultura": 14.3}
a016d9e5-7154-4087-9bef-9b2689ab18c7	1720655	2021	249.35	25563.44	58.9	3.4908416e+07	{"servicos": 72.6, "industria": 22.0, "agricultura": 5.4}
cbb5a7eb-54d8-45ed-add2-ee19ef150183	1720655	2022	302.14	29136.1	56.4	4.2299796e+07	{"servicos": 63.4, "industria": 21.3, "agricultura": 15.3}
d0e30c38-b1a0-43ef-9664-b992fbf87028	1720655	2023	273.12	26150.47	60	3.8236168e+07	{"servicos": 58.5, "industria": 25.4, "agricultura": 16.1}
087232e0-1660-4b1f-9f40-4d2d82761911	1720853	2019	2218.62	33331.56	57.3	2.2186154e+08	{"servicos": 57.0, "industria": 18.4, "agricultura": 24.6}
aa8a40f8-004e-4e35-bf28-0ebee1b97a21	1720853	2020	1854.37	27289.08	69	1.8543746e+08	{"servicos": 50.4, "industria": 32.1, "agricultura": 17.5}
7d37a22a-364f-4a51-af14-fb110462023f	1720853	2021	2100.77	31116.04	63.1	2.1007685e+08	{"servicos": 66.3, "industria": 15.3, "agricultura": 18.4}
7c1125ed-dc72-47df-951d-3d48d43da05d	1720853	2022	2216.12	30609.01	64.7	2.2161232e+08	{"servicos": 58.2, "industria": 19.7, "agricultura": 22.1}
b6dddddc-4f3b-41bb-9a7f-083fe9220b7a	1720853	2023	2040.02	28789.09	55.8	2.0400237e+08	{"servicos": 58.2, "industria": 29.2, "agricultura": 12.5}
3ae3feac-dad4-432b-a0f7-51e9b40e2be0	1720101	2019	2012.62	28973.18	62.1	2.0126222e+08	{"servicos": 52.9, "industria": 31.5, "agricultura": 15.6}
a9716dae-347c-4066-adac-8bdc26e46236	1720101	2020	2352.26	32027.1	55.7	2.3522624e+08	{"servicos": 62.1, "industria": 25.8, "agricultura": 12.1}
b7ce2c29-464a-4550-b621-eb2841a17a83	1720101	2021	2109.69	30001.67	68.4	2.1096872e+08	{"servicos": 55.0, "industria": 30.6, "agricultura": 14.5}
b8a9b86c-99db-4487-b64e-c67450e15281	1720101	2022	2284.89	33327.31	56.3	2.2848869e+08	{"servicos": 60.0, "industria": 31.0, "agricultura": 9.0}
539179d0-6fe9-4763-aaa5-7b72bd2ed65b	1720101	2023	2315.79	34322.26	62.8	2.3157915e+08	{"servicos": 66.5, "industria": 26.0, "agricultura": 7.6}
d33fc3d5-77ac-428e-aa6f-a17140c767a4	1720150	2019	257.67	26236.87	60.7	3.6074124e+07	{"servicos": 64.6, "industria": 25.9, "agricultura": 9.4}
662d64dc-1de6-46ec-bd13-86a40f421123	1720150	2020	274.23	26583.11	64.2	3.8392384e+07	{"servicos": 69.0, "industria": 15.7, "agricultura": 15.3}
adfc5469-b78e-4de1-8c54-6401a424c3e6	1720150	2021	273.61	28450.38	69.3	3.830502e+07	{"servicos": 55.6, "industria": 30.4, "agricultura": 14.0}
81afd585-3bea-4e46-836a-a825da8667b0	1720150	2022	295.66	28352.57	58.7	4.1392476e+07	{"servicos": 72.1, "industria": 15.6, "agricultura": 12.3}
9684dca2-0d7a-4924-8958-0ca2a1c9c53a	1720150	2023	294.92	29073.58	69.8	4.1289132e+07	{"servicos": 45.4, "industria": 30.9, "agricultura": 23.8}
2c64a1a2-a6d0-4064-ba38-87345f7dda20	1720200	2019	259.74	25517.23	66.2	3.6363588e+07	{"servicos": 60.0, "industria": 15.8, "agricultura": 24.2}
191bd45e-cae9-4fae-ac91-a13a43f12989	1720200	2020	235.65	22556.9	58.8	3.2991268e+07	{"servicos": 54.4, "industria": 32.1, "agricultura": 13.6}
c664c955-8e7a-46e4-b167-3e926f1c9a23	1720200	2021	278.26	28310.22	55.6	3.8956564e+07	{"servicos": 54.1, "industria": 27.4, "agricultura": 18.5}
3a434caf-19c5-47e0-b033-6bae8d803c02	1720200	2022	255.98	25605.56	64.5	3.5837024e+07	{"servicos": 52.6, "industria": 30.5, "agricultura": 16.9}
49c210c8-51ac-4407-a9b7-764d134f4d39	1720200	2023	320.42	31662.02	55.5	4.4858748e+07	{"servicos": 68.2, "industria": 20.7, "agricultura": 11.2}
9efc8111-82e7-4f63-abdf-a15c590e27f9	1720259	2019	570.12	19865.39	61.4	7.601559e+07	{"servicos": 57.4, "industria": 30.7, "agricultura": 11.9}
c1f064ad-1877-4952-8994-832c8352a478	1720259	2020	660.74	23007.73	58.8	8.8098144e+07	{"servicos": 58.0, "industria": 25.1, "agricultura": 16.9}
90287d0f-f23c-49e9-9e42-88ff077f9774	1720259	2021	578.71	19932.76	58.5	7.7161056e+07	{"servicos": 65.3, "industria": 22.9, "agricultura": 11.7}
cb5b5d01-3179-4a54-ba9c-6d13dc8b6546	1720259	2022	723.4	25103.24	64.9	9.6453336e+07	{"servicos": 74.6, "industria": 16.5, "agricultura": 8.8}
11197d04-7265-4a03-b78d-e7dc21d99843	1720259	2023	650.69	20991.27	56.6	8.675831e+07	{"servicos": 68.9, "industria": 22.8, "agricultura": 8.3}
93813b23-ae25-41e9-b663-d2395b92cd80	1720309	2019	574.33	19785.3	63.8	7.6577016e+07	{"servicos": 58.8, "industria": 31.1, "agricultura": 10.2}
630f1dfc-e044-4230-811a-3996144cc192	1720309	2020	632.47	20361.43	58	8.4328904e+07	{"servicos": 56.8, "industria": 21.0, "agricultura": 22.2}
0022906d-0f71-4b9b-b6a4-334c85795fad	1720309	2021	606.98	20390.45	59.9	8.0931064e+07	{"servicos": 51.5, "industria": 27.8, "agricultura": 20.7}
6a9a205d-a0b6-4768-94a6-88f29db01e02	1720309	2022	591.53	19481.35	67.7	7.8870896e+07	{"servicos": 51.4, "industria": 32.4, "agricultura": 16.1}
b0546681-db72-4da1-b8fb-5d6eb5c07e49	1720309	2023	629.41	21478.62	55.3	8.392127e+07	{"servicos": 60.5, "industria": 33.0, "agricultura": 6.5}
87d6c069-7ab5-4e31-a38f-acf936ee1371	1720499	2019	593.63	20412.11	67.5	7.915e+07	{"servicos": 51.6, "industria": 27.1, "agricultura": 21.3}
3e2971fa-3500-43e3-9c21-89dfc409ad2b	1720499	2020	590.89	20251.06	59.9	7.8784744e+07	{"servicos": 68.2, "industria": 15.7, "agricultura": 16.1}
3b836346-658b-4a61-b056-103872df06f3	1720499	2021	607.01	19322.77	59.1	8.093409e+07	{"servicos": 59.9, "industria": 21.3, "agricultura": 18.7}
4770d658-dd86-44fe-ad9c-4ef4164c2e87	1720499	2022	637.75	20365.76	70	8.5033856e+07	{"servicos": 52.6, "industria": 25.9, "agricultura": 21.5}
2f2385af-07a5-498a-b20f-df85bb25f21c	1720499	2023	763.87	24521.51	68.3	1.01849264e+08	{"servicos": 60.9, "industria": 27.1, "agricultura": 12.0}
ab0df2ba-f08c-4885-b197-b2125d8ee483	1720804	2019	2274.97	33902.63	58.1	2.2749685e+08	{"servicos": 54.7, "industria": 34.2, "agricultura": 11.1}
15afa0d4-99b4-4805-8e6e-bd963fd628da	1720804	2020	1907.63	26047.29	56.8	1.9076258e+08	{"servicos": 74.4, "industria": 15.0, "agricultura": 10.6}
4fff4e3d-625a-4f41-a47f-ed1eed286528	1720804	2021	2147.21	29510.92	56.7	2.1472142e+08	{"servicos": 64.8, "industria": 25.5, "agricultura": 9.7}
ab622658-8e8b-4615-8ac3-7d3a549ae29f	1720804	2022	2435.5	35105.76	67	2.435497e+08	{"servicos": 49.6, "industria": 27.0, "agricultura": 23.4}
bf766de9-a19d-4903-99c8-4eb87393a74e	1720804	2023	2126.15	28960.64	65.3	2.1261454e+08	{"servicos": 77.0, "industria": 17.6, "agricultura": 5.4}
471a9a14-3846-475c-9391-4a038bfe31dc	1708254	2019	682.42	23132.13	60.2	9.0989464e+07	{"servicos": 56.7, "industria": 25.6, "agricultura": 17.7}
7b398725-c3ae-4bad-a332-02bf24051cea	1708254	2020	609.35	21240	64.9	8.1247264e+07	{"servicos": 60.9, "industria": 23.8, "agricultura": 15.2}
b7ec8ef4-88f7-41b5-a0f4-6c7cd0785302	1708254	2021	698.42	22374.52	58.2	9.3122736e+07	{"servicos": 64.8, "industria": 17.8, "agricultura": 17.4}
163d0fac-ff3c-4287-9228-1d4963dc9587	1708254	2022	679.35	23318.25	56.1	9.0580536e+07	{"servicos": 60.6, "industria": 16.9, "agricultura": 22.5}
5b3e6941-b869-449f-874e-dd4bab69ef95	1708254	2023	655.11	21131.96	69.6	8.734824e+07	{"servicos": 72.3, "industria": 20.2, "agricultura": 7.4}
9a3c7848-9d27-4d5c-922c-b1aab911e4e1	1720903	2019	2154.04	32077.58	58.8	2.1540414e+08	{"servicos": 60.6, "industria": 21.4, "agricultura": 17.9}
f87d3216-5971-4546-83d2-e307ec149e62	1720903	2020	2090.9	29683.03	68.4	2.0909022e+08	{"servicos": 65.3, "industria": 16.0, "agricultura": 18.7}
d2a0e7b6-5cb0-43aa-8e72-e3d73b72100c	1720903	2021	1988.41	27648.29	57.8	1.9884094e+08	{"servicos": 53.2, "industria": 30.9, "agricultura": 15.9}
181c2abb-4cbb-4df3-a96c-0bb2124a5e96	1720903	2022	2064.25	29956.18	69.7	2.0642504e+08	{"servicos": 50.8, "industria": 31.4, "agricultura": 17.8}
fa2013cf-905a-4162-85f0-09567ad182e6	1720903	2023	2401.98	35258.4	58.3	2.4019787e+08	{"servicos": 66.2, "industria": 23.6, "agricultura": 10.2}
6d218402-5d0f-4aff-a1d0-4a90be0d08a8	1720937	2019	568.69	18646.14	67.6	7.582516e+07	{"servicos": 56.1, "industria": 34.2, "agricultura": 9.7}
4058b7ef-1a43-4cab-92d7-487814834ab0	1720937	2020	621.73	20874.01	61.2	8.2897664e+07	{"servicos": 69.7, "industria": 24.8, "agricultura": 5.5}
7a301fde-c37b-4a75-ad54-53ff66be9883	1720937	2021	602.15	19949.89	62.4	8.028633e+07	{"servicos": 59.2, "industria": 21.4, "agricultura": 19.4}
9d35595f-7b0d-450a-ab46-0992e688964b	1720937	2022	660.02	21753.41	57	8.800271e+07	{"servicos": 60.8, "industria": 24.4, "agricultura": 14.8}
a8f1e434-b771-4534-af02-dd443fb1397a	1720937	2023	730.43	25328.84	57.1	9.739108e+07	{"servicos": 58.3, "industria": 34.2, "agricultura": 7.6}
1932515f-2b16-473a-bf30-e7b7edbc579a	1720978	2019	270.14	25776.53	64.9	3.7819328e+07	{"servicos": 55.3, "industria": 24.7, "agricultura": 20.0}
3394bcda-7c67-4693-8b85-906ff2bf206a	1720978	2020	283.41	28492.44	64	3.9678004e+07	{"servicos": 63.7, "industria": 15.9, "agricultura": 20.4}
1f085872-6f1a-4f2c-88a4-0c6132a3872d	1720978	2021	299	30500.52	60.9	4.1859528e+07	{"servicos": 66.7, "industria": 15.0, "agricultura": 18.2}
c56f6c11-e8e4-4c66-8f43-1ff480157a1a	1720978	2022	287.44	27817.72	57.5	4.0241676e+07	{"servicos": 65.7, "industria": 24.3, "agricultura": 10.0}
28c470a8-8b00-4eb8-84a2-9684ee395055	1720978	2023	317.53	32451.04	65.3	4.4454684e+07	{"servicos": 65.5, "industria": 22.0, "agricultura": 12.5}
8c71dbf1-582d-417e-bb4c-150369bd4de2	1721208	2019	629.15	20985.77	61.6	8.3887136e+07	{"servicos": 51.2, "industria": 35.0, "agricultura": 13.9}
f9be41eb-de85-4e66-a939-1dfeabc7f5f1	1721208	2020	637.49	21250.46	68.2	8.499899e+07	{"servicos": 48.5, "industria": 32.7, "agricultura": 18.8}
1c5db1f4-00af-405f-9a90-99a98af4ee43	1721208	2021	602.59	21073.23	64.8	8.0345216e+07	{"servicos": 58.8, "industria": 32.4, "agricultura": 8.7}
3b5ad46e-2744-44ef-97d8-30f57cc280ed	1721208	2022	700.12	23475.96	63.1	9.3349824e+07	{"servicos": 51.4, "industria": 27.7, "agricultura": 20.8}
4eeafe0d-6d16-4ab9-a3e9-a6443f8eaaf9	1721208	2023	663.47	21153.14	61.3	8.846245e+07	{"servicos": 51.0, "industria": 24.0, "agricultura": 25.0}
34ce74c0-8d08-42c0-8701-986eba227303	1721109	2019	244.4	24885.66	56.4	3.4216296e+07	{"servicos": 56.6, "industria": 32.5, "agricultura": 10.9}
110a5ae5-a55f-45d8-81ef-0bfc8916c6dc	1721109	2020	236.94	23559.7	62.2	3.317159e+07	{"servicos": 64.2, "industria": 20.6, "agricultura": 15.1}
5c058171-d820-47bf-987e-d630efe6013d	1721109	2021	250.81	24137.1	64.8	3.51132e+07	{"servicos": 55.0, "industria": 28.3, "agricultura": 16.7}
3eb5bf03-bba9-4ae6-8b63-32dd1a351e4f	1721109	2022	278.81	28270.81	67.7	3.9032944e+07	{"servicos": 59.0, "industria": 24.9, "agricultura": 16.1}
90244409-de34-4a14-8c71-76946ec9b59b	1721109	2023	290.06	27627.2	65.5	4.060812e+07	{"servicos": 44.2, "industria": 33.3, "agricultura": 22.5}
245162b7-695c-4267-bccb-5d73f3c077a4	1721257	2019	270.58	26915.76	55.6	3.7881776e+07	{"servicos": 64.3, "industria": 26.3, "agricultura": 9.4}
fd3dd68a-8fcb-4d66-a940-6dfe6e6629c6	1721257	2020	234.93	24068.09	69.8	3.2890012e+07	{"servicos": 58.2, "industria": 31.3, "agricultura": 10.5}
95c4803f-0e7a-40b0-aa60-164fc05d647f	1721257	2021	262.86	27267.46	68.9	3.6800164e+07	{"servicos": 70.0, "industria": 16.5, "agricultura": 13.5}
9fcff965-9a87-4f6a-b95b-b3343b258a17	1721257	2022	307.61	31408.37	55.9	4.3065908e+07	{"servicos": 56.7, "industria": 32.9, "agricultura": 10.3}
c8987ec6-4919-419f-994f-6030f3b8f703	1721257	2023	259.84	25678.08	57.7	3.6377116e+07	{"servicos": 60.8, "industria": 19.2, "agricultura": 20.0}
46cd6aa8-8018-4fa8-b069-a7e472cc4d12	1721307	2019	275.54	27672.89	62.5	3.8575452e+07	{"servicos": 60.7, "industria": 15.4, "agricultura": 23.9}
b89f3361-5fbd-44c4-a4d5-7e90a52e9180	1721307	2020	294.43	29671.72	58.1	4.1220544e+07	{"servicos": 59.5, "industria": 22.6, "agricultura": 17.9}
bac66973-4c2a-4fa2-8eae-7619e5e6e26b	1721307	2021	272.49	27410.24	66.4	3.8147928e+07	{"servicos": 72.9, "industria": 21.1, "agricultura": 5.9}
3b128f2d-aec4-4eef-bdd9-04e70af6b370	1721307	2022	293.93	30189.63	62.2	4.1149676e+07	{"servicos": 67.1, "industria": 19.0, "agricultura": 13.9}
1ee21cc7-6f70-4ac9-a9d9-dcb8264e7655	1721307	2023	266.62	26939.85	68.4	3.7327316e+07	{"servicos": 58.3, "industria": 28.6, "agricultura": 13.2}
5a6b65df-fda0-43e8-ab00-a1faddd3cdac	1722081	2019	283.7	28226.27	67.9	3.9718312e+07	{"servicos": 59.2, "industria": 17.4, "agricultura": 23.4}
18fe3da7-5ac8-4772-8c13-6d8925f252e2	1722081	2020	281.47	27434.13	67.4	3.940638e+07	{"servicos": 64.6, "industria": 20.2, "agricultura": 15.3}
117f2fe2-fa24-4d49-a895-82be9f969682	1722081	2021	241.49	25020.02	63.1	3.3809048e+07	{"servicos": 60.6, "industria": 23.4, "agricultura": 15.9}
b8adb530-db46-4eb9-ae0d-dfee6c295069	1722081	2022	303.63	29189.95	60	4.250874e+07	{"servicos": 62.9, "industria": 20.0, "agricultura": 17.1}
fe4ca266-c805-4e40-ae83-944ecd959b2e	1722081	2023	262.47	25730.29	63.7	3.6746456e+07	{"servicos": 64.3, "industria": 24.9, "agricultura": 10.8}
19541bff-55b0-42ef-a1b4-a5e2a60d2ea7	1722107	2019	597.73	20932.63	68.7	7.9697496e+07	{"servicos": 50.2, "industria": 25.3, "agricultura": 24.5}
febab73f-1a4d-467f-84d8-1b5436086886	1722107	2020	708.09	23881.52	59.1	9.4411624e+07	{"servicos": 42.3, "industria": 34.5, "agricultura": 23.3}
a5b27875-1f11-4ebe-b316-fd2899ae133c	1722107	2021	633.26	21548.22	55.3	8.4434544e+07	{"servicos": 56.4, "industria": 31.0, "agricultura": 12.6}
8b269d63-7929-428a-8b82-54e2dcf10ba4	1722107	2022	595.95	18988.88	62.9	7.94596e+07	{"servicos": 77.0, "industria": 17.3, "agricultura": 5.7}
31494eb8-52f7-49b3-9565-73ff0e95041f	1722107	2023	644	20883.18	65.4	8.586607e+07	{"servicos": 77.6, "industria": 15.1, "agricultura": 7.3}
\.


--
-- Data for Name: environmental_indicators; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.environmental_indicators (id, territory_id, year, vegetation_coverage, deforested_area, water_quality, co2_emissions) FROM stdin;
54deb7f8-34b6-40c0-b91a-ae3a4da1efe3	17	2019	90.9	494.4	63.7	87443.72
e0aa7f86-2c59-4a8e-9d1f-b498ea5badb6	17	2020	91.1	60.36	61.6	21565.31
cde58694-9bab-4d48-91e6-b253011b4b40	17	2021	80.9	406.15	85.7	122256.69
278c213d-71fb-4c32-86cd-36ae70c3fd7a	17	2022	89.3	380	69.5	115549.59
94185165-89c2-462e-b66b-994d443faf2c	17	2023	94.6	404.26	93.6	26640.46
beadce12-bced-4a30-820b-9337211f1aad	1700251	2019	76	426.09	89.4	81081.64
14313a9a-74e2-4827-9763-46d36827c0d0	1700251	2020	55.1	100.42	83.6	96642.7
2d0cf4d7-deb2-45df-a92c-1b8240f6ee27	1700251	2021	78.3	214.84	66	76439.72
632ccd26-ad00-4480-aa70-96c96f915bd5	1700251	2022	83.8	426.02	87.6	38312.15
84b8f89d-e881-49e4-bdf6-a5e661e09509	1700251	2023	93.9	337.02	73.9	66960.86
e87daa71-b533-4517-8e9b-8f4161ef80bd	1700301	2019	85.5	483.67	60.8	126328.4
6e14b8b9-87e3-4112-b56c-c2ef40f8850c	1700301	2020	65.9	432.51	64	89878.1
d325c3eb-32d4-4c69-a38b-d1d5951830ed	1700301	2021	64.4	33.65	93.6	52429.48
a586e97b-3123-4da2-846d-2607bb8d02cb	1700301	2022	90.8	345.15	94.3	148412.84
f787fa81-b809-40bd-ab86-236ebf478cf4	1700301	2023	56.4	149.91	79.7	134354.34
15410c6b-2926-49c2-b284-bb22a5d930ea	1700350	2019	61.8	284.17	90.5	122230.48
6bb7feb5-7c59-4855-888e-d99fc1e8fabc	1700350	2020	63.7	373.26	76.9	93639
e915832f-3655-471b-84b1-f89ed42dd803	1700350	2021	72.5	152.84	66.8	102898.14
6ac23e08-658f-4a89-a9da-f06892fba892	1700350	2022	65.5	479.25	88.1	135163.88
f8cfb864-1646-4b5b-8b4c-40f04d629f72	1700350	2023	92.5	181.03	67.6	130347.31
f6b03aea-d412-4cee-890a-cfa9a256cbd0	1700400	2019	66.8	382.24	82.2	118266.47
208b2b79-dda0-4056-845c-d520269d68b4	1700400	2020	85.4	441.71	83.8	72396.48
7b2d8d00-c949-4a7a-aec7-d4aa67b2e147	1700400	2021	60.2	108.66	86.6	127816.24
e8903684-20b8-4973-8602-c19b591a8cf8	1700400	2022	88.4	126.28	79.9	54252.21
89d7ad8d-55bf-4a89-90a4-6a2940bc771d	1700400	2023	87.4	19.82	76.9	119473.04
f5404eec-5703-4f68-9edb-e1ddbee49ec4	1700707	2019	57.9	329.82	60.5	45912.25
40411075-95b1-42a9-a76d-edc60ac663ee	1700707	2020	83.9	335.34	93.9	17441.59
c4b29cb1-da71-4494-92a7-505b7e65f647	1700707	2021	68.2	42.36	68.6	124743.76
7ecefb9d-c128-45c7-8bdf-ee7ccd7b6827	1700707	2022	85.8	123.39	75.2	80133.13
ee13eacc-c25e-4273-93bf-fdafabfbe097	1700707	2023	56.7	82.87	75.3	36445.16
2642f8c2-7606-41e2-943d-ff07fbecf762	1701002	2019	94	97.64	61.9	117575.82
3f74cd88-276e-47b0-95c4-5ad0ae2eaaa7	1701002	2020	65.7	160.66	89.8	111406.62
4458ca58-355f-4d3b-a453-58db7ebf6a96	1701002	2021	84.7	331.51	90.2	7384.16
68a5ea3e-5c8d-44a7-888c-54418f7d098c	1701002	2022	87.8	48.43	93.1	107242.04
cb77c883-de2c-4288-b1b4-a391ca40727c	1701002	2023	75.6	382.95	82.9	13274.89
dda8f89a-0723-4eea-a388-f4003b5ac147	1701051	2019	84.6	496.57	64.5	99489.94
8dc8a380-5455-4073-bcda-ae1111a190dd	1701051	2020	94.7	68.43	73.9	137246.06
2361284e-5aad-4b67-9738-a2a03abcfaf4	1701051	2021	56.5	197.12	69.8	141456.56
df29de84-2dfa-48f9-9bc9-e20172f28153	1701051	2022	78.1	112.32	80.4	122488.75
cf39522e-7c3f-4023-8eec-aef9c176b6f3	1701051	2023	77.7	201.64	69.8	19346.45
cf7fc52a-ca0e-4968-aade-98c876cff30c	1701101	2019	86.5	473.84	78.5	77382.27
e9098fac-2a57-4ad7-be9d-36ac9191877e	1701101	2020	62.5	404.61	76.5	69562.27
8dbaa783-8d32-4587-946f-31d2d0f31c7f	1701101	2021	90.3	150.14	67.1	104127.31
bb5dd9f1-a36e-4a06-86ce-a63feb3d683d	1701101	2022	89.1	166.48	82	80817.16
18383128-dd83-4604-af8f-45b5fa35b083	1701101	2023	93.8	265.54	76.2	30670.49
b2b4a6c0-7d6b-43e1-b457-72cd8e174e04	1701309	2019	60	77.4	91	109434.32
37127757-5ae2-4d04-b3ed-cf01ff599060	1701309	2020	92.9	60.45	65.1	72502.32
9b144250-4d10-4a3a-8db6-0e8dc731f4b2	1701309	2021	64	385.19	61.6	54185.48
d7a3c269-6d89-4d58-9917-6b763faaf4ec	1701309	2022	92.6	441.16	63.4	134999.62
5f4a6544-d30b-4d02-ab95-1005ed720029	1701309	2023	78.9	356.63	88.4	70313.53
ea6e48d3-8c87-4499-93d9-4dae57268413	1701903	2019	80.1	476.55	81.3	142856.78
4ea3a45d-afe2-4115-a616-b7d616ee978c	1701903	2020	78.3	265.25	86.2	76414.68
8da95563-0189-4e05-9353-3d10c27bcb41	1701903	2021	83.2	239.48	70.4	91180.82
8ee1ff40-ca11-4c62-84f0-6a9af79187be	1701903	2022	56.7	482.6	73	97330.58
733ef768-58f4-472c-a40f-85a7ee877bba	1701903	2023	68.5	204.38	73.7	55498.84
eaa71288-4a01-4fc5-bebd-e4b3c0945e57	1702000	2019	92.8	457.8	71.3	109502.3
532e93af-2060-4f80-b98a-1592c51eee87	1702000	2020	67.4	89.9	80.7	128455.21
fddf6aa7-db41-4504-82de-9b55d9a3346d	1702000	2021	71.5	57.35	95	9037.14
4a649003-91b9-4b7e-b562-b3a5cccaa397	1702000	2022	61.1	286.83	65.7	88971.62
c849e464-8dd4-46bb-b1f6-b269ebc7964b	1702000	2023	87.9	79.13	62.5	29936.78
21a90e7b-fbc1-4bc8-9b96-2fe7e0146cd4	1702109	2019	88.5	147.59	72.5	131524.3
122538eb-af56-476a-9364-54f01fe8252b	1702109	2020	77.9	274.67	67	22219.85
da5d0578-d16d-433a-8dcc-669ee5654188	1702109	2021	77.3	16.09	63.3	104808.94
5685c27a-9267-4bad-bb2c-9a3070dc8ce1	1702109	2022	83.5	96.12	73.8	102654.17
2a807b56-545e-4ebd-ad0c-726bcdd659db	1702109	2023	94.1	352.18	83.9	88699.77
fd10279e-70e5-4ff0-8382-531da03fbbc3	1702158	2019	81.5	459.62	71.6	53421.07
80305840-24d7-4eaa-98ad-7844b7a32e2e	1702158	2020	80.8	43.38	93.2	90543.28
bad8820a-5edb-4a02-bb8f-1421f2eda67e	1702158	2021	61.1	211.11	84	42962.82
2a99e8b1-f6cf-48d2-857e-54ef7f4b88ab	1702158	2022	77.8	337.55	93.4	60497.68
8cfc5c9c-6cba-4a1a-ba1b-7ac7fb112949	1702158	2023	82.7	456.74	74.8	114618.07
9ce1d743-fe87-46f0-8833-d990e2375d95	1702208	2019	90.7	406.41	92.2	78531.98
84f03bf7-82c8-4cfb-b6be-be0ea4d85d53	1702208	2020	57.2	200.57	94.1	88876.38
73933bea-2ad4-4757-9116-a3fb25b21d26	1702208	2021	93.6	159.57	82.1	147548.38
08e7737e-4b72-4f09-a13c-0cc6355fff64	1702208	2022	64	325.69	81.1	13006
c3bbddff-e2a1-4c7b-a07a-d578d5bd7b93	1702208	2023	84.9	106.24	94.6	79387.8
9bffdbef-2973-4612-8301-90f83ede536e	1702307	2019	72.1	124.63	91.3	14333.39
09f00f9e-94f6-4088-a8e9-a5ec998f07b4	1702307	2020	83	53.82	90.5	117719.45
f2d8b82b-f8d7-4ceb-9aff-894790a83eb8	1702307	2021	73.2	216.99	94.1	18902.22
be55ab79-7133-4dca-a48d-78daa5f101cb	1702307	2022	77.3	482.96	64.5	96676.67
2d2ff454-ffab-4ff0-be50-df94bf8858f8	1702307	2023	84.7	385.81	90.6	6563.23
2e412e67-6dd2-47b9-87a1-1decfaf14df7	1702406	2019	67.6	125.12	72.4	31284.91
f7553535-0837-4e9e-bbdd-83d45bed7cbd	1702406	2020	72.4	287.56	63.3	140697.55
ff030572-47be-4a8d-8551-7dccff28a3b9	1702406	2021	69.7	154.99	86.7	82603.74
1f21890e-10cb-4e20-924e-c65270d836d8	1702406	2022	92.1	160.11	92.7	5673.62
6d5ecc9a-a035-471f-ba9c-1b7544c53ae3	1702406	2023	59.5	384.84	60.9	62390.03
f65845a4-7b9f-480c-b5dc-6e164f65834f	1702554	2019	65.6	237.04	77.8	146546.88
8dac1383-2dca-4548-9e9e-b66cf75e4034	1702554	2020	66.1	288.45	86.1	28779.95
d837c1cf-a871-4cb4-96fe-a2b133f14c0e	1702554	2021	84.8	168.8	74.4	110055.55
48358e1f-b955-456c-ac18-910579d84cc2	1702554	2022	89.3	165.06	91.7	47762.82
9a28c1d0-cf56-4297-a405-21fb216b1fb2	1702554	2023	62.8	15.67	72.8	28180.57
ac2f9c72-bb60-4d12-95db-bf1f1dd886cd	1702703	2019	64.9	240.43	62	78777.31
e678b6e7-dc28-4dea-8bae-dc047f8b05fb	1702703	2020	61.9	131.49	85.9	104450.82
ef5777b2-2420-478c-be8f-7cf00571863e	1702703	2021	55.9	471.77	60.6	32695.7
22a7f068-56ba-4252-92bb-11eb6f546a74	1702703	2022	92.4	182.96	83	78974.96
369cc884-2534-40d2-801e-9c0ce7eadfa3	1702703	2023	75.8	122.08	90.6	90061.03
a9284bf7-a242-4632-be2e-e9f2957f4932	1702901	2019	59.9	403.18	60.4	132940.55
c5da7f56-1d2f-4905-9bdb-5517ae498388	1702901	2020	74	300.45	68.7	117891.81
f7a402ed-77c4-4860-8d7e-7aee67066979	1702901	2021	83.7	42.36	91.5	28739.66
b5ffecd6-2578-469b-9538-49353076fdf7	1702901	2022	66.4	135.72	72.1	110759.88
e4124aa3-ff95-4dd0-9f9c-7f7a3659e273	1702901	2023	80.4	417.45	66.6	148891.23
749978d4-61f8-4759-884e-332f9e550089	1703008	2019	76.1	273.82	91.7	123653.44
e3ec55fe-4989-468f-a9d5-ed394008aeb6	1703008	2020	62.6	81.98	83.8	123317.32
95cad72a-2c4a-447e-a046-5846546aabc3	1703008	2021	64.4	341.45	60.5	16441.37
1bc3e362-0d08-4d7c-965b-60e5f582ec4c	1703008	2022	90.1	255.04	81.4	22925.33
f710d6bf-4234-4dfd-9db2-f49d2ae03263	1703008	2023	87.8	203.27	78.3	69142.66
6a93fb49-59f3-4151-a52b-69d3993eb957	1703057	2019	71.1	495.89	64.6	147495.9
e4531e94-37b8-4ae1-a1d6-b82d2bd1704d	1703057	2020	67.1	448.31	89.5	38298.9
25449bd7-933c-4f1e-96ba-ae788f8a93f4	1703057	2021	55.5	99.35	80	54350.6
90b575d6-4b43-4efa-a08a-37641dac267b	1703057	2022	62.3	248.23	93.5	110030.41
887a1627-803a-42d6-afaa-175ba7932e0c	1703057	2023	75.1	149.95	69	89079.65
d612f898-7368-42e4-966f-1cafacb46a52	1703073	2019	71.4	206.69	62.4	14272.03
80a36eb8-8ce6-441b-ae58-51204b6e11d8	1703073	2020	57.7	463.35	63.3	37581.14
6e4ca7cc-0817-4d99-b1fc-9ffd6ef81813	1703073	2021	84.2	121.64	93.4	113702.49
28d51a10-053f-4cf2-aa60-b2c7c77fcd62	1703073	2022	61.5	259.67	69.4	46298.5
cb9c2b0b-7020-40c9-9d7b-9eaab6ede117	1703073	2023	75.4	376.93	86.6	129488.1
a00e7e59-faec-4a50-ae57-58fd1112c504	1703107	2019	93.5	363.49	61	129725.96
cdacc023-1235-4234-98c5-e631db326d8c	1703107	2020	75.3	273.69	81.8	50158.8
8704b742-e1bd-4b08-9fc8-e234f1b2276e	1703107	2021	92.3	88.53	76.4	126167.5
396cec52-77d4-426f-ac25-6326eb6652dd	1703107	2022	85.9	439.82	91.2	78521.57
5fadea50-c5e1-47c1-96a8-cc7c6a60ee69	1703107	2023	65.8	220.44	68.4	89832.8
3816e8cb-0436-44b3-b4b6-f61673fe033f	1703206	2019	59.6	46.06	69.2	17767.49
f40c63d8-df96-4262-8578-b7f61d648cf7	1703206	2020	71.3	44.6	93.7	144808.08
fc426053-c145-48cd-a9b3-7fef9d08c0e1	1703206	2021	80.1	85.97	83.4	84594.82
84e1ad35-340e-4280-8eb1-fdfd217f812f	1703206	2022	90.2	314.07	79.4	21509.67
44934665-29e8-4ec3-8091-4ff3bd8effea	1703206	2023	84.6	466.18	72.9	38323.17
2f4280dd-0554-4a1b-a1ad-b8c3268deece	1703305	2019	70.6	235.97	84.7	123073.41
66a19b50-b63d-4c41-bf47-5b391cab6975	1703305	2020	61.7	25.45	62.4	29184.6
4dad7ede-c22e-40ed-84de-293ea1d53417	1703305	2021	55.8	202.21	86.5	49003.08
b942be5c-bfcb-4030-a0ec-d005398c17c3	1703305	2022	59.2	41.84	88.2	71186.2
20352717-08d7-4af5-9ea8-1c290d71426c	1703305	2023	81.5	287.96	86.1	19094.19
29220bad-67f0-41ba-8ae4-c15d527b347f	1703602	2019	81.4	85.86	63.1	132534.86
a9c32710-a547-48cf-843a-1752e7cc3142	1703602	2020	80	50.48	76.5	99641.36
8dda97e1-d108-4d58-a8cb-043508886208	1703602	2021	63.1	456.45	78.4	70817.66
3010d67b-e6ae-4e19-8e9e-2b74490e4ba5	1703602	2022	74.2	114.76	87.2	59699.65
c2db8ced-ffbd-426a-a466-cb16fa05e25a	1703602	2023	88.5	293.44	61.2	11228.82
91834adc-c382-42c1-8d1b-a87a2a5af61f	1703701	2019	92.3	314.47	82.5	56472.24
52cd0dbd-88d0-4406-be39-d9bd5e37488e	1703701	2020	90.2	193.46	69.8	37236.8
8dde16d9-bc50-4f85-a64c-7439d030b619	1703701	2021	70.2	144.89	76	78217.67
2d0791a4-3c7c-4e3a-a7f1-68a10a2db23e	1703701	2022	57.3	80.86	66.1	77194.34
341304a6-b29b-48c8-b19d-ef028e643a1f	1703701	2023	62.6	216.22	67.6	102537.05
c0fec7fb-c4fa-47ba-9bac-ca09f3c87876	1703800	2019	66.9	413.9	84.1	119438.38
5ba1b0b8-fd8f-415f-826a-6d4bcf5a7f6b	1703800	2020	92.2	397.94	79.8	135650.12
83da252b-f868-41b6-ad19-1c434663e1af	1703800	2021	57.2	46.1	67.2	49498.62
dc29acf7-3ec3-405c-93be-d2e438a0c3f5	1703800	2022	59.6	251.12	72.9	57621.65
457aee6b-907e-493b-a8ea-982630ff81b6	1703800	2023	88.7	408.83	77.5	31763
15dd69f3-fdff-485d-aa23-16845e616446	1703826	2019	57.1	398.79	73.2	50560.28
d01a1f64-f358-46f0-95ac-6697ba28df09	1703826	2020	80	22.67	85.5	96504.96
2e1b72e6-3ee9-45b5-9d5a-a9369574046a	1703826	2021	70	223.45	72.5	32291.45
bacc1200-f010-4a71-851d-089c97c99608	1703826	2022	89.6	495.67	78.7	39073.52
6e30e9c9-f90a-4785-99f5-f8b86ba915d0	1703826	2023	92.1	422.13	82.7	100055.13
5c2173fa-7b3a-4897-b914-1772b99e774a	1703842	2019	60	408.27	67.9	26565.3
65760f34-1371-4f24-a716-8bba4b6055c1	1703842	2020	72.9	257.59	82.8	35710.44
20672b5e-8004-4d4f-ba0e-908c9aabdb1b	1703842	2021	71.6	228.87	83.2	111570.95
923dd6e1-3444-4e7c-b4ad-64382479c395	1703842	2022	57.7	403.62	73.7	95180.66
3af2b602-1cdb-41ed-b521-87dbccc846db	1703842	2023	76	409.88	65.4	55311.69
6b00de23-7890-47ec-9a15-714162908fb4	1703867	2019	64.7	437.61	63.2	127988.57
66ebd17d-75a1-4d08-a9d5-d5cd452e4760	1703867	2020	90.3	81.49	73.3	70134.2
307794b8-1333-49ff-913d-c0556fb7a229	1703867	2021	57.4	399.99	94.4	40860.05
f18934e9-cc80-4a4e-9f37-50a788864bff	1703867	2022	84.2	301.23	60.2	132993.33
dd558372-8cad-435f-a661-d916114bbed1	1703867	2023	68.3	104.44	69	140192.3
5d58c24c-2a52-4603-a9ba-0831eb5daeba	1703883	2019	65.2	219.9	78.4	130998.92
ead0d9e1-9c25-4551-893d-09749c35abd0	1703883	2020	67.5	431.41	71.4	86567.29
1cfd63ab-15ad-457f-a9ca-a9ca9dd414fe	1703883	2021	78.9	327.14	83.1	96401.97
a81a199f-024b-42a9-b472-de0588bb9ea1	1703883	2022	63.3	24.89	70.3	66934.94
5d4e8713-9355-484c-b778-8c3eca5e207d	1703883	2023	72.4	364.63	91	125115.84
282090c6-f87b-4327-978f-288e9c792d00	1703891	2019	83.9	135.89	94.1	137611.27
2cb0a2e4-4ba5-437e-b526-d710a1bf9d00	1703891	2020	67.7	255.82	67.6	29243.07
8ef2d556-e657-46e5-8311-400898458371	1703891	2021	62.8	127.3	71	135742.17
b54a148b-911d-4557-8e78-0145d0d5642d	1703891	2022	86.2	16.7	74.1	76673.23
e1cf0d5b-5d3d-42c6-bb5c-e94f4ac83433	1703891	2023	86.4	178.39	94.4	68846.99
0b097d88-b9ba-4063-a797-b0c759a4c769	1703909	2019	67.3	474.13	61.3	56693.64
5239c89c-2beb-4332-bdd0-e1e0793a7a14	1703909	2020	72.1	481.43	92	111513.62
9ef50a99-7495-482d-ba0b-ba5b8fb9aee0	1703909	2021	55.2	209.9	76.1	60976.48
ec982603-5f34-40a5-b6d9-e57376537ed4	1703909	2022	90.7	304.99	80	20178.5
a2be935c-1dde-42d8-9baf-78eea2b7ef41	1703909	2023	56.6	82.58	82.5	31347.79
6e0fde60-9693-4e6e-a2b7-b16002806e03	1704105	2019	62	332.53	88.5	29919.28
0cff7bbb-2496-4008-929e-0fa5180c062e	1704105	2020	88	206.09	61.4	103736.57
9e090b86-f82b-490d-bd89-11b2908001f1	1704105	2021	73.6	305.63	60.6	101273.07
28f01331-48b7-4533-ad1b-b389f41ddd89	1704105	2022	92.3	149.11	83.4	126039.87
dc7cf431-1f51-4d57-8aad-0627a99f1169	1704105	2023	61.6	15.63	70	61144.89
986d77c0-2a08-4e40-80d7-69d321aca850	1704600	2019	83	199.58	68.4	63029.99
558a1db8-6886-4f30-a9b1-b48f485bc973	1704600	2020	81.2	304.42	67.8	79630.19
408fa6b4-7371-46a0-b675-fab493b059b6	1704600	2021	80.1	73.69	86.4	73974.24
6dbbdfdb-7971-4dc9-9133-58b6ee1cf79f	1704600	2022	73.2	57.09	70.8	108431.44
b7bfd394-dce2-4cdd-bd8a-1fdf765399b7	1704600	2023	71.9	373.36	75.2	110034.46
13fd4daf-0dd5-45c6-9f4d-814938342f51	1705102	2019	73.5	412.73	81.9	48505.31
d41cb1f4-ac03-4da4-ac6c-62e1845218fa	1705102	2020	60.8	117.92	65.4	127624.56
aba56492-657e-49ab-bcd1-bbdd0f418f94	1705102	2021	75.2	183.59	79.1	116942.48
2d2be8b4-3c2a-475b-b03c-685e38ed2050	1705102	2022	75.6	230.3	79.3	16006.9
0bc59a75-0a5c-4135-951f-afb5509969c3	1705102	2023	68.2	406.58	80.6	67900.16
f01434d2-7aa6-4a05-96e6-83e44f5170bb	1705508	2019	68.6	351.06	76.8	127959.08
364bd598-eabf-423c-86c0-4056e596e228	1705508	2020	70.9	329.54	77	95467.15
4d6f4303-9f26-4852-87ab-16f3971edca6	1705508	2021	70.8	379.46	83.2	100727.27
7f261869-4af2-4255-af28-97deeb13a82f	1705508	2022	93.1	171.25	60.7	117407.23
1f54c102-f444-4e1f-ad99-3c8d43592f80	1705508	2023	80.2	300.24	83.3	51313.79
7d5f1894-ad17-48ef-8b2b-31c5ccc3eadc	1705557	2019	81.1	46.48	79	10327.3
46354854-1943-4bcc-8f9d-904543ca2aef	1705557	2020	74.1	460.66	86.9	74187.6
31777429-77de-46cb-ab9e-e780f276b94f	1705557	2021	79.3	384.6	67.6	44870.46
8837e2a0-c88f-47a8-a582-d7e85ffc74e1	1705557	2022	63.6	320.01	89.4	139190.8
00385728-65ce-4650-a883-2ed63e73c5a9	1705557	2023	63.6	25.25	90.4	42886.85
894998b7-8080-4242-a6f5-e32cdfa8b25a	1705607	2019	84.8	231.72	78.9	7993.51
a216df27-2946-429e-8a31-486364d32d01	1705607	2020	68	125.53	65.6	129276.06
0364bc43-7071-49f3-b326-30e9b18974be	1705607	2021	62.3	306.76	85.6	13714.45
50133a4d-6d3d-4177-95d6-1eebd458c894	1705607	2022	69.1	408.35	79.3	102654.05
2b4ace71-feb6-46f7-b7de-6ed8a2e7c6a5	1705607	2023	55.1	137.91	76.6	114950.8
34dc4bb9-161f-49f9-a3a1-2f3057924356	1706001	2019	57.2	132.16	75.9	18169.26
a83e5172-3fa6-496a-b107-05ee616d0458	1706001	2020	87.4	496.37	69	52418.53
1ca0c215-aa76-45cf-9559-44858279bf4b	1706001	2021	62.6	447.13	68.1	111911.54
6f178d23-423b-43e5-a943-30761d965c3b	1706001	2022	88.5	116.73	81	101640.28
bb5c4c44-6657-48d4-acf8-105082535dfe	1706001	2023	60.4	454.06	81.1	131267.84
8c25ad80-cadb-4365-a3ae-c84525767a9c	1706100	2019	88.3	336.01	80.9	10851.78
39231c91-d8a7-4f72-abc3-4bc85f48eace	1706100	2020	74.6	499.55	80.3	86174.13
76b6f9ae-609e-4c11-97f4-2ac16f19363d	1706100	2021	71.2	150.6	67	8276.26
16a5709a-4cd7-4980-8556-e4111f661c06	1706100	2022	90.6	284.41	88.5	29401.7
2adb90a7-3d91-4446-8ce0-6029a415dd6e	1706100	2023	55.4	20.9	73.2	96907.49
da5da2e5-84c7-4ff2-9e9a-6f0a159fe21a	1706258	2019	77.4	404.62	82.4	108973.14
eaff0ff8-6f8e-41f3-9327-0158ceb2cd0e	1706258	2020	90.7	23.89	73.5	107023.9
e03ec684-67a8-46c8-a2c1-e8ae1e96b93d	1706258	2021	87	95.49	84.8	141197.33
06d29f5f-de70-4644-871f-2c17e69c2b06	1706258	2022	75.3	378.42	88.4	7958.91
b4fc8f36-19b3-4eb9-be7e-1e4a3cc40d34	1706258	2023	91.2	498.34	65.2	136437.81
75f388df-6287-4760-a61f-8fd17911fb30	1706506	2019	55.3	74.32	87.9	138048.52
d087cc5b-ab20-4b01-86fa-44cb19ae9a0b	1706506	2020	62	65.6	77.2	40717.32
1b9a91a9-5591-4a50-9a1f-18504bc4d890	1706506	2021	79.6	153.15	65.7	124169.67
007ce17b-8db2-457d-9b9f-2db78a00e776	1706506	2022	76.6	340.69	85.6	88207.16
166fc603-4243-461f-8117-9aea82249930	1706506	2023	74.8	42.06	66.6	117591.4
3eb80e5b-3957-4b1b-8f42-d5683181f5af	1707009	2019	74.1	443.12	71.1	22267.68
7c40046d-138e-4e6c-ab44-a6819eacbd25	1707009	2020	74.9	419.1	70.7	29810.51
6d2cbac1-0916-4920-ae48-16ee3da08092	1707009	2021	58.8	372.14	91.2	120033.77
407283cb-274c-4e7e-adc7-9fed8cf72e28	1707009	2022	86.3	59.61	67.4	58992
a67e6cdc-bd34-4471-94ad-def9e34f6c72	1707009	2023	86.4	157.15	72.3	30075.08
280bc74a-0c27-453d-b907-fe480eb130bb	1707108	2019	88.5	65.11	71.8	72254.23
d4faf17b-e288-4656-9b65-dc98034a34d3	1707108	2020	90.7	69.69	92.8	47936.35
94d4aa72-a586-4955-aef9-eeb58ee1d2c8	1707108	2021	82.4	188.78	92.7	146951.23
155d8575-a0a8-4e95-aacc-3af611cf03cd	1707108	2022	82.3	319.76	94.4	71850.45
a18d1bfd-ac16-40e0-9f50-6463e8e58b71	1707108	2023	72.3	113.4	89.3	109343.74
c0a01752-1471-4cc2-b459-66335b8c2d53	1707207	2019	70.9	241.09	83.6	63186.9
c40ba372-0c1c-4925-8175-b7d4c1e20620	1707207	2020	57.9	82.93	72.2	10231.45
d1481484-3d0a-40a3-afa3-955ea7c963b8	1707207	2021	74.8	409.38	70.2	49153.13
ae9d598e-071d-4c4a-be79-11b3202309bb	1707207	2022	56.2	396.08	69.9	72743.03
4fcdcfeb-90c7-485a-94ea-a022d1a93ebf	1707207	2023	71.3	128.66	62.5	91317.98
d5849bac-f6fd-42b9-b252-b007d4fd9160	1707306	2019	69.3	90.79	65.3	77544.24
27cd8aba-17f4-4679-b63d-811830732c28	1707306	2020	57.2	296.36	91	39421.66
f8fac092-f2b5-447a-a8f0-84483e7f20bd	1707306	2021	78.6	35.63	62.3	9242.68
08faa62d-3ab9-4b48-bc7f-e60d3fd9d478	1707306	2022	60.4	83.7	69.8	122256.04
10fd05eb-e99c-4afd-9299-2521cc34869f	1707306	2023	88.2	105.1	66.7	21022.04
5c500d79-f812-45cf-a665-cea73d01574a	1707405	2019	78.4	51.7	82.3	124488.21
901e2937-4eac-4707-b729-843d70677be4	1707405	2020	80.9	432.98	65.9	131448.78
5de40421-4963-4f56-a4a7-e81d9d1b0231	1707405	2021	74.8	10.05	75.1	147839.64
517b22d7-0a8c-4df9-b378-818c9d544a53	1707405	2022	67.3	330.26	80.5	122310.78
94a602ab-3085-455a-bfc5-e8f1e3f86774	1707405	2023	64.3	85.98	81.7	34547.37
23c35a5a-1b88-43d7-8331-23c8d0511bf5	1707553	2019	67.7	25.22	73.2	31201.49
72d3293e-6b5f-45c0-a4d1-38d0ba765594	1707553	2020	74.5	22.41	83.7	67412
2cb1dc6e-6ca4-4b04-90e9-d040efdfa97f	1707553	2021	86.7	436.97	63.4	146156.08
a8451d02-b2c2-47b9-bce3-5c9fc76df37d	1707553	2022	60.6	248.4	83.2	79026.27
f0a68cf1-009d-43ec-93e6-f8d7b965239a	1707553	2023	88.5	445.86	75.4	102787.73
ee81d434-c102-421a-a425-2486f88bd903	1707652	2019	73.4	427.97	70	51617.4
d204eb8b-a1b7-4c1a-a74d-21588ee9f746	1707652	2020	66.5	251.79	61	9629.17
7325ecfe-8eac-431d-8a57-386bf214340b	1707652	2021	60.2	417.48	85.4	63969.84
7f2bf21a-3123-45ef-80fa-f671bbb6c67d	1707652	2022	90.1	110.23	68.6	121926.76
40d623bd-9638-4e40-8381-6ec6bc83aaed	1707652	2023	85.1	228.47	71.7	140170.12
b2105bd4-04cd-4de2-9087-52b439824335	1707702	2019	79.4	372.3	82	88373.63
aaabbf24-2000-4803-b667-fa82a606e39e	1707702	2020	89.1	392.61	69.4	18450.7
4180f735-e650-4cd1-80dc-bfb34da4306f	1707702	2021	81.5	144.33	67.7	79422.16
51cdad41-964b-41f2-9df7-9fdd54a0c181	1707702	2022	93.1	303.85	80.5	145380.3
7f1b3f0e-beae-435f-b377-a72f5a586913	1707702	2023	61.2	438.02	72	104091.76
cee6ac79-16f5-4461-81dc-5c53a4f12193	1708205	2019	66.6	412.46	64.5	29673.82
5541d164-2249-4793-a4f1-3a3335e48e05	1708205	2020	93.7	99.75	73.2	148929.1
1a6a44d3-8c66-4ddd-8712-5f85f09c8c41	1708205	2021	76.6	354.23	80	11762.23
6869541e-f257-4d00-b10e-512f4bdbf449	1708205	2022	59.4	467.82	79.8	41234.51
a9bba8c8-19db-432a-bfc9-887e2eebdbfd	1708205	2023	88.1	77.94	94.9	132590.02
483ce6ff-23d9-4487-874c-a235f4299dec	1708254	2019	58.1	67.12	61.5	44492.38
18809002-007a-43f3-8c4c-c60b42bbe920	1708254	2020	81.8	223.29	78	121343.41
f545990d-5c71-4f64-9b65-28fc5c9e13f6	1708254	2021	55.2	21.96	84	81955.4
1d8911bc-9dd1-46ab-8560-a6ce4ac7878b	1708254	2022	59.4	196.92	82.7	83662.95
424f7788-18a2-48e1-846c-5b1450492421	1708254	2023	65.5	298.59	83.7	80495.99
62ae82a7-a3d3-4af3-b11f-fc18644bf910	1708304	2019	71.5	441.13	61.9	92334.15
8107f970-2c85-44e6-b731-4f47fedf5ba8	1708304	2020	74.4	450.53	93.5	136632.3
f9a2c079-86a8-45ef-a232-547993118f3b	1708304	2021	75.6	382.18	92.9	69981.08
8f3e3575-c470-4b3e-9d09-f11e6e74f600	1708304	2022	71	260.28	93.2	127762.27
b0c946b2-7665-450e-a5c2-b9875e83c80f	1708304	2023	74.4	13.52	72.7	12112.51
69d63dc8-de68-41a5-b254-8d310d170b4e	1709005	2019	91.8	97.76	61.3	14692.77
333aa0c2-18cd-4977-a647-6d81ed3476d2	1709005	2020	57	231.92	88.6	31493.67
c1c02047-5ad4-4f0a-9c4e-8a0206680d51	1709005	2021	86.1	242.57	67.1	134905.94
873bbad8-c7e1-4be6-b4e3-011ca4fc8e60	1709005	2022	72.6	274.84	66	6557.71
e01eb1e2-0459-4ede-824d-3842e9cdebfd	1709005	2023	78.1	493.76	63.1	137429.34
fd306380-20ff-4a1b-a5eb-565a656af9a9	1709302	2019	63.7	151.04	60.6	148680.81
da8b67f2-1675-4ce2-af39-112707835479	1709302	2020	77.5	208.78	92.2	34253.55
33437f90-9521-4ebe-9ab8-2df29891e92a	1709302	2021	58.7	313.02	92.4	47711.52
090e9b4c-40d3-406a-b156-abbd58001e47	1709302	2022	65.7	380.61	75.8	135910.64
186616ab-8ddb-4c07-a1b6-712c47d16073	1709302	2023	84.2	379.49	86.6	59092.55
bd8e8d6e-1c10-493f-bdab-19ce95f4e1a5	1709500	2019	92.1	200.38	86.7	94158.61
bfdb1b50-51c6-41c4-bac4-26a2f6d97aa8	1709500	2020	78.7	271.71	73.8	25259.68
286d9864-c251-48ae-8872-192ab671263e	1709500	2021	78	301.01	88.7	36339.47
3917e744-f462-4ebe-abcc-7ca58001c4b9	1709500	2022	79.9	212.9	74.8	89022.82
143ee5c4-0a2c-4b9e-9ec0-62e15cb7c933	1709500	2023	61.4	196.31	62.7	23577.11
227c8335-e38d-4cea-b5b6-02bba83b80ca	1709807	2019	59	148.02	89.2	134572.45
066f590d-ee42-4d7b-bf04-5894f1e0537e	1709807	2020	58.5	303.73	67.3	148757.23
e5af9664-2d87-4ef8-ac86-fbb87979caca	1709807	2021	60.8	285.2	79.1	129932.83
40d873d4-1d95-44c1-92a6-dd0395057074	1709807	2022	93.2	268.22	82.4	76205.96
fe69a539-3b52-46b9-9b0b-84941bc934c4	1709807	2023	81.5	11.23	87.5	144637.75
bbfca8d1-4550-44aa-8807-a521fb204564	1710508	2019	63.4	207.28	61.6	135869.03
f8bc1f4a-73a9-4c90-96bd-7c0079fb976b	1710508	2020	93.1	63.53	72	112188.69
7d41f95e-6b7d-4ac6-8950-a4129d7857b3	1710508	2021	93.2	330.49	92.4	106972.46
3cdb0734-7758-4cb8-9729-d8ce088404a1	1710508	2022	58.6	66.75	75.4	88902.13
38bfd785-6576-4801-9247-83bf47b1a6aa	1710508	2023	85.9	274.73	94.2	36025.62
38603a36-734b-4348-9406-4b844654545f	1710706	2019	56.4	243.99	78.8	47633.59
5a827eb0-cc16-437d-ba34-d8e2620ea0a2	1710706	2020	68	229.72	76.3	89327.11
0b71e30d-583b-4af5-9237-61707a7a08c8	1710706	2021	77.5	104.09	83	16780.59
6b0c09dc-0970-46c9-84a1-9251f4b8bb83	1710706	2022	57.7	234.59	68.3	49214.76
034ceff0-096e-4b5c-83ab-207c77096130	1710706	2023	81.5	50.34	70.2	5226.76
ed52eca1-3514-4f57-921d-2477f629d867	1710904	2019	57.4	415.34	69.3	144940.33
ad823915-6ff6-44ee-97c7-c2367303bc26	1710904	2020	68.2	231.46	70.6	38111.91
aaa62a5a-ea08-4fc8-8c10-b9577aa0351a	1710904	2021	94.2	161.12	82.9	34669.47
b60e2e54-0c10-4b1d-9bb8-0e3080246088	1710904	2022	93.5	102.46	93	63921.54
add4605c-d6a8-4997-b623-66b5422a42ca	1710904	2023	84.5	319.66	84.5	40792.5
27ff6ea0-910e-486f-826a-e582dbf14b9d	1711100	2019	58.2	154.83	66.1	147321.53
99668249-e9e2-4a70-b95b-9906c393dee2	1711100	2020	84.7	338.87	78.1	73362.5
9b9f60ed-8824-443b-9cc6-80075f8c364e	1711100	2021	75.6	325.22	79.6	91913.92
cfa7833f-3f49-451e-8b0a-2e1a4411f266	1711100	2022	89.8	140.04	91.3	105537.5
bd657a47-520a-4e27-b40a-69fa824130e6	1711100	2023	94.7	105.69	75.2	135669.19
09192908-18e8-44bd-a008-50c7a85177e3	1711506	2019	84.2	325.11	64.8	125343.18
18bbe5dc-0c13-43fe-88a9-f3519f522200	1711506	2020	55.8	29.35	67.2	141603.66
aee33c36-e3b4-4ea7-a8d8-e3bad0883d14	1711506	2021	71.7	353.6	63.8	44424.86
8c0a8014-7c88-46c7-bd3d-dba19a54f6ff	1711506	2022	84.3	203.91	71.5	141775.12
8bccbab4-f386-4c3c-bca0-3acc1547820a	1711506	2023	74.6	104.45	81.4	119386.09
0d513fa3-b4d0-490f-b9b8-132343b2aaab	1711803	2019	75.4	80.95	72.4	10379.9
5ae62dbd-2761-4d7c-847b-75b46630395d	1711803	2020	63.5	108.82	73.9	133722.36
44b2425f-8acb-4205-bbb2-f875f62793c0	1711803	2021	66.3	435.71	71.9	91723.4
de820ec9-c211-4c95-a299-1bca730515e8	1711803	2022	83.1	84.09	72.7	139354.17
911973b1-5c22-477f-9ac9-fb27639e3adc	1711803	2023	70.6	199.7	72.1	65780.78
dd642079-face-4266-aced-8bc2769a5acd	1711902	2019	70.4	73.31	79.2	42315.48
ab83c596-e106-47a1-aa5f-4f8fbc842752	1711902	2020	70.4	194.44	72.1	36087.25
126c9e3f-f0ab-4f73-8d56-6a2cdc31717c	1711902	2021	59.9	391.71	66.2	65522.3
5e7ee678-028d-4e0a-b26c-1425b51b0e83	1711902	2022	62.9	189.35	66.4	53287.98
fd6c082d-37f1-409c-8408-8eb1e113f239	1711902	2023	57.5	373.95	82.1	148031.92
1b423309-3ae8-4336-ba72-114198cc18d8	1711951	2019	65.3	229.41	83.1	125089
edda7533-7664-4d27-a9a2-1a0ef43187b1	1711951	2020	66.6	70.77	85.4	38895.26
29d4871a-76c0-4b4e-9d07-039bf04e04c3	1711951	2021	91.1	436.89	75.7	22272.5
8d4882f9-bbcc-451f-8210-a289f3d5b246	1711951	2022	77.3	325.75	94.5	98755.03
1eebb931-e4bb-41f6-bb9e-ec626127d5c3	1711951	2023	70.5	267.07	66.9	149762.62
788c7483-0ca2-458e-b85a-b04af5a698ca	1712009	2019	64.9	247.3	68.9	11699.29
33b4e7d3-e8c9-4f6a-a214-3b5eebb266a8	1712009	2020	92.8	75.62	67.5	15992.74
8879ccfe-80dd-4bc5-a023-bda6f72671d2	1712009	2021	78.5	231.11	82	133551.78
4cf33305-7530-4873-9ab7-8a84ff8976bc	1712009	2022	71.8	110.99	71	103156.36
9a8ef0db-3279-4d0a-93a1-54b12f7ce636	1712009	2023	61.2	274.56	76.8	137300.55
7b0dc672-ee6b-428c-b618-28afc3518e82	1712157	2019	75.1	358.27	64.6	125117.45
15d56109-c179-4e3f-ad2e-1a74aeb70b6d	1712157	2020	57.8	318.15	94.2	135572.44
259db4fb-e3cb-4391-adf0-50cf0b8bc3c9	1712157	2021	91.6	406.76	64.1	42700.64
5d28a0dd-ee3e-466a-93a2-70ce9e256415	1712157	2022	71	402.41	63.6	95075.61
6cacd4c2-52e7-49ec-ba73-dfcc4bca0ce8	1712157	2023	86.6	165.34	78.1	135174.36
e5876953-ac9a-44c8-ab08-2542f01f5c04	1712405	2019	67.3	320.77	83.6	126858.71
6e776114-de18-4d12-9f18-33715ab29b9c	1712405	2020	90.9	498.4	75.7	19167.58
6d63194d-e026-41bd-9f3b-eafca65fc495	1712405	2021	83.1	361.93	91.3	64143.8
39d8808e-b87a-4d0b-a2ec-1f137b3710ce	1712405	2022	77.1	232.13	77.5	66052.57
56232a2a-79cc-4798-bc8d-a1385e4edc23	1712405	2023	77.1	139.66	87.5	130316.09
fb54708e-cf2d-4579-a822-3b4135e28529	1712454	2019	77.2	140.17	92.1	36544.57
cea94a66-3c95-4c20-a85d-127da2bcc9c3	1712454	2020	80.7	408.72	70.5	94819.42
685eec28-2bcd-4149-8d8a-fc80f47ac3dd	1712454	2021	58.7	210.98	73.4	47145.21
55dda2cc-5191-471b-bc37-d113af8a07d6	1712454	2022	91.2	478.08	65.1	13907.73
7a57a87c-fa2b-4914-b5f3-9a4810145da6	1712454	2023	74.3	403.94	85	29104.97
d2a6c276-79ba-44f4-a936-5dbd59a378f6	1712504	2019	90.1	131.91	83.7	93119.63
2ef92e15-8c8e-4367-93ad-b2984c8a8a08	1712504	2020	76.9	312.44	73	112839.22
dcf339e8-a4b0-4476-a29c-9a272d6134ef	1712504	2021	66.8	80.82	86.2	46745.66
bb7907df-442b-4a3f-975a-8c343b43bbbe	1712504	2022	68.5	136.23	73.4	53716.74
6c5989bc-294c-4879-b46e-b2615fcc8ad6	1712504	2023	65.9	41.52	88.4	34225.67
4c467c85-7f4b-4e98-a1fb-d3095b274027	1712702	2019	55.6	165.62	69.8	110148.84
ab9ddd01-5326-49ce-8a28-407701688dc8	1712702	2020	92.6	60.67	92.2	96295.12
4e45cbf8-b265-4102-a46d-626063988c8a	1712702	2021	64.2	157.64	83.4	148135.73
e970eab7-9ed8-405e-af28-791c9840dc25	1712702	2022	68.8	39.38	83.2	117609.33
da11876d-92e6-467b-8ea0-08f2d65b4ede	1712702	2023	89.6	212.72	92.4	12484.03
3fc8fc33-47a1-486a-ae15-14c22f254cec	1712801	2019	60.2	65.42	88.5	71346.81
d2473fd6-059d-45fd-b791-35011ba0fa83	1712801	2020	91.6	450.58	66.8	6159.21
22135555-86b1-428d-8895-57a7ebd7fb9a	1712801	2021	59.7	227.23	92.1	60269.73
3abb2857-c540-4fee-bcd1-5a6583915487	1712801	2022	88.8	457.59	88.7	99674.89
dd198c50-1dbe-4709-b249-6d4352ed6a71	1712801	2023	83.8	361.04	75.4	34544.65
1206e66b-54a4-438c-9a26-8532abfbeab1	1713205	2019	68.4	321.64	85.1	73661.23
c7129062-c175-4e02-b2bc-be481bfaa755	1713205	2020	80.4	393.42	84.6	88118.7
bf58735a-98a4-4b84-a7ae-7ed559fd8f3c	1713205	2021	55.4	68.13	86.9	42845.05
83b8fae4-a654-4c02-ab79-89e2524895fb	1713205	2022	85	238.71	93	106825.91
4c206405-66d8-4eb5-8b6c-30ce4f50d637	1713205	2023	60.1	65.7	85.7	46262.62
d3a20584-e370-4549-bb2a-52a363528b6f	1713304	2019	94.9	197.03	73.1	23792.28
0152c5ad-2ccf-429f-9925-e50b9fa47f39	1713304	2020	69.9	301.37	86.5	83302.31
bd4aeb0a-72fb-4577-bf83-b1b74bb4c970	1713304	2021	70.9	173.15	72.4	143174.44
93ce543c-7fbb-490a-93e0-7b7300e592a9	1713304	2022	66.9	477.8	65.3	101569.84
2ccc6e18-7ebd-4887-bdc1-b682d450263f	1713304	2023	75.6	219.96	69.7	68637.88
e4d7591a-605a-4ada-a50f-c21ad34ea507	1713601	2019	84.9	346.04	73.7	115018.62
0d3d174c-dba0-4b65-b63c-eb5d811ca66e	1713601	2020	61.2	182.54	79.8	124635.34
23d1089d-9748-412b-b47f-4077c49c423c	1713601	2021	64.9	359	85.6	77004.32
e8bbac10-8508-412d-a09f-908208ca057f	1713601	2022	90.4	389.82	88.8	6759.76
e0fd33cb-c198-402a-a5f1-1e120b129438	1713601	2023	90.9	222.77	74.9	39039.52
caf1abd8-b0dd-45f0-a583-f6f23e4e9dd6	1713700	2019	87.6	259.21	89.5	25115.16
7ccd632c-d1e9-4b7e-af98-32b5bad0ed78	1713700	2020	85.8	34.84	93.1	118842.4
a0fab752-3036-4589-b4ab-bdce9a8cf9d3	1713700	2021	68	303.38	81.5	114627.21
f7150858-0d96-4b19-9863-9db3643014d8	1713700	2022	89.1	300.05	83.1	17153.18
215a8d50-5efb-4650-bd63-5f21048ad213	1713700	2023	67	124.77	64.7	114301.23
17da3dba-094b-418c-9970-73894cf06cb2	1713809	2019	63.4	409.31	86	89695.5
488b1dad-185f-45cc-8c93-654b78c8a797	1713809	2020	89.6	25.66	64.1	83416.79
efb704eb-615b-4665-abf5-b31729fca140	1713809	2021	84.9	276.89	81	8665.51
d551085c-30f7-4eeb-b71f-bce1d9258e6a	1713809	2022	79.6	18.61	66.6	14624.65
57877165-7b5b-4744-b231-17bdcd6f631d	1713809	2023	62.3	109.6	74.5	43301.64
abb29775-6b8c-4e8e-ad70-f5380b0963f9	1713957	2019	73.4	64.86	63.1	113875.22
ba666d5c-b065-43b6-aa9a-d771047ff1e8	1713957	2020	86.5	60.48	93.7	94684.19
b55c678d-a5b8-4a08-92f4-d5a91911f0dc	1713957	2021	70.9	297.32	63.7	16171.14
5765e76b-1f1e-47c9-9353-6dd459643072	1713957	2022	59.3	83.83	82.6	147503.78
9c39e807-9fa6-4db7-acb7-794f7e99aec1	1713957	2023	70.4	106.41	61.6	18824.56
0d035785-2919-46ce-861e-1cd06d21c533	1714203	2019	66.6	159.01	77.6	82138.03
824a085f-71f1-4555-955a-0725be0848f1	1714203	2020	75.3	251.51	88	140870.12
0eb0c6f3-c22d-4ec7-876c-bfb07dc9ace3	1714203	2021	57.1	246.83	60.8	37361.98
3c50aac1-f6af-4877-997f-f08fda2d312d	1714203	2022	87.6	28.81	86.4	122767.5
4383d6d3-a83d-4e47-a5a6-d0539fbb1fc4	1714203	2023	83.6	458.12	73.4	33709.18
512a6def-d6fa-4442-b0ec-262c02276a29	1714302	2019	56.1	404.81	78.2	94275.1
978262cf-460d-41cb-8bb5-6fa33845c4f2	1714302	2020	66.3	251.45	81.7	24963.8
54167b35-01c2-4dad-be80-511047f9f9b6	1714302	2021	57.1	356.88	79	124522.49
0aa558e9-ff61-4ae8-9578-b2adb02eda5c	1714302	2022	82.6	430.39	85.6	56261.73
d0a4a417-a51b-4f98-950a-a18b305ef769	1714302	2023	62.8	334.31	80.3	67442.82
b719cd46-bd9f-48bb-adf3-d0823559dc39	1714880	2019	77.1	86.02	77	63284.98
d70112ef-2f3f-4202-8ae5-7253cad99e2d	1714880	2020	65.6	417.73	64.9	148895.45
593d4871-48bd-45cb-8141-2304907b2401	1714880	2021	77.8	386.48	79.1	118539.87
457d1d35-05bd-492a-a76d-16e6f79fc004	1714880	2022	61	167.43	60.3	109958.44
cb832e01-56fe-4513-a591-aff48448348c	1714880	2023	55.7	109.5	62.8	13795.26
699c9ff7-806c-4830-8ba1-938f07fa744c	1715002	2019	94	310.54	76.5	98298.16
ee111161-225d-48f2-bd99-760eff7a17b5	1715002	2020	61.9	144.6	90.6	28209.36
6fff0709-af93-4a90-aeed-09231e4dfdab	1715002	2021	77.8	472.61	73.8	51663.98
94184e6d-6525-449b-ab82-dc69b7fb183f	1715002	2022	90	220.8	78.8	11492.65
8a3e79b5-95a7-4b17-9399-ea14cb33f91a	1715002	2023	56.3	306.22	75.2	37344.4
e16c9c17-5fe8-46f3-8675-83f2ece8f61a	1715101	2019	63.3	486.07	86.8	13833.33
c94d4599-f566-42be-ab4c-16afb7ee7e0a	1715101	2020	84.1	281.43	68.8	10736.14
185f5533-78c8-4402-af13-17f9c18b4496	1715101	2021	82.2	395.7	61.7	65863.58
7c90181e-cd31-4814-9a1d-b72b135f21bb	1715101	2022	73.4	332.82	74.9	61124
d38c71e6-710e-4630-a0fa-6ab3a6f0b082	1715101	2023	77.2	236.85	65	122215
fba815d4-f20c-4f04-b6f1-66faa47c541c	1715150	2019	91.5	460.41	92.8	87241.98
9bfa6ee3-8e0c-44c1-a3d4-e0cd6ba54c4b	1715150	2020	81	321.76	73.8	68290.9
a83b16d0-7715-47cd-a491-5ac0382d51b7	1715150	2021	65.5	203.93	91.8	107786.75
3adaae58-6b85-456e-ac2c-e25c0d9fe8bc	1715150	2022	68.1	373.12	89.7	59108.12
de4f3d06-e499-4500-bdf0-b666b950eef2	1715150	2023	58.4	186.54	82.7	55199.53
b4fb711c-25cc-449f-9ace-e37d01c98aa9	1715259	2019	74.3	358.79	80.5	76403.09
b7ce2d0c-1d93-4fdf-a6e7-b8a79eaac1f9	1715259	2020	76	138.48	82.2	21778.49
3c3c5ba5-889b-43a1-88ff-b5eb16b02af3	1715259	2021	87.8	251.23	78.7	35756.96
e7b18fc3-9012-4b29-8011-cceb64fe1b9e	1715259	2022	83.2	314.76	76.5	111737.89
8aaba973-7401-4b08-ae7b-c4a265de7200	1715259	2023	88.4	127.03	85.9	10325.74
7a96a364-66f9-4756-a22d-27bfdeeb9704	1715507	2019	71.2	154.55	75.8	77692.81
60fce984-1401-44ac-b7b0-e82cfd4e910a	1715507	2020	74.6	150.18	94.9	35020.83
20a67c19-1dcb-4cc0-a04a-14b83bb2eb5d	1715507	2021	90.2	271.15	78.4	66910.73
cd8d70d4-0416-42f5-80a5-ccb1cc8cefa4	1715507	2022	76.8	327.75	73.4	24078.58
198d33b7-3ca1-4fc0-8965-efa1f97ce43e	1715507	2023	77.3	35.05	74.3	41824.9
cb38260a-588b-477f-99cc-b875182d0175	1715705	2019	63.8	104.22	89.4	95598.86
2c7905dc-106f-4bfa-804d-9334ca0aaa59	1715705	2020	70.3	131.39	78.2	39040.01
2e6e2c4a-ec82-40c4-aebf-5dca6f6255d4	1715705	2021	68.7	457.26	72.5	76305.67
d3f78f98-41a0-4c0f-bcf4-aebdcb120f40	1715705	2022	71.1	475.87	76.4	52506.05
4897836a-25fa-4446-8b75-1773041a41bd	1715705	2023	85.5	457.36	74.6	84845.55
c042ffe8-9880-4d51-a37a-ee5d82408795	1715754	2019	80.3	357.29	89.4	43974.78
83a80848-8a56-4809-8de1-78529f9af370	1715754	2020	74	419.29	62.3	56367.57
41996599-d820-4df5-a461-8a9f0f43c371	1715754	2021	57.3	383.79	79.6	55526.89
60131b85-8c71-4313-b6ba-444b53e60a3b	1715754	2022	66.9	62.1	69.8	136193.31
e22db9ad-19b8-4213-9e9d-f46e434e44c1	1715754	2023	65.1	191.59	94	56620.01
325ee8ba-2046-45a5-87ee-9243a93220bb	1716109	2019	69.2	422.27	91.7	60290.96
d972333a-2dcb-458c-844c-687696dc5e3e	1716109	2020	81.2	463.93	90.8	34477.31
9312dd84-632f-44ad-8c9a-7cb822a270da	1716109	2021	76.2	74.55	89	24677.33
1cee1ee0-536c-497a-a3da-d48495f303f4	1716109	2022	90.7	390.53	63	130105.69
3ad21507-3512-4c06-9092-2fe2c0430572	1716109	2023	67.2	439.07	66.8	56529.53
8a10337b-4579-47ee-a95f-0909aec8bc12	1716208	2019	84.4	381.56	91.5	141374.72
cbd6d021-0716-410e-b1f3-a1e768fb2691	1716208	2020	67.3	296.7	79	89428.25
73107eb0-b89f-4660-9c3d-e4c0da4a7ca9	1716208	2021	58.2	226.29	89.9	15223.32
7fed994a-2c21-48e9-b92d-a71c7b7bb681	1716208	2022	79.1	21.02	86	24464.82
8e993cb2-7e90-4215-bb20-8008bc8796fd	1716208	2023	88.9	154.28	63.6	65033.64
ba71bcc8-9050-4868-b5c0-274bab4a5466	1716307	2019	65.6	30.34	70.6	14920.59
b46846d8-91b2-4c42-b828-05c24c72b834	1716307	2020	82.4	334.07	74	38674.17
348617f4-fac2-49af-bbc0-1a3b33d3c5b6	1716307	2021	85.7	443.99	87.6	122889.58
6c321d55-f496-4567-bf66-079c05ea66bc	1716307	2022	62.7	233.55	82.8	139172.44
7441518b-c995-4f8a-9b06-8e181a878c66	1716307	2023	62.1	72.47	76.6	128059.29
0335c7ca-0222-4c04-ae88-8d5f2638d82f	1716505	2019	76.1	408.76	60.2	91117.25
28cd979e-5efc-4915-8e2d-a050620b481b	1716505	2020	65.3	94.33	78.1	7219.12
14ec726b-74f0-4e08-978a-a39c02cf5832	1716505	2021	58.6	345.17	92.7	48846.85
9c7316a1-5fb3-4e39-9b26-c5be323a7836	1716505	2022	71	389.93	93.4	115623.66
d6abfe31-84bf-42b2-af6f-00531f33ad19	1716505	2023	82.2	311.22	76.1	137119.73
5e9ae1c3-2945-4579-bda9-80b44943e1f2	1716604	2019	89.5	447.89	92.4	114781.8
8a86b33a-104a-466d-a7ed-7a4c87000ba7	1716604	2020	70.3	385.82	65.2	99413.73
bb5aebec-42d6-4458-94a0-5f2997c6d588	1716604	2021	73.6	360.14	67.5	130181.82
502ded4c-b05b-4a42-9efc-c603bf88a13b	1716604	2022	58.3	222.43	63.8	27516.5
5cfbef9e-4910-4c5d-9d81-9567f33aaa59	1716604	2023	58.8	344.43	87.7	7874.11
6fc6c303-2eec-44f6-9b79-01ff4832299c	1716653	2019	94.7	37.08	76.7	16951.92
ec84c718-6788-4579-b5a4-a140ca20462a	1716653	2020	75.1	303.65	84.4	115763.7
e74d5a28-636c-441d-9d61-d81aaccb4ba3	1716653	2021	55.5	187.47	74.6	110976.93
e1b1058e-4966-4c75-aa62-7020ec3adf6f	1716653	2022	90.3	420.31	93	73135.82
320c8f6b-651d-41b4-b742-05603f1dcddb	1716653	2023	77.1	417.4	83.5	148307.98
6c57ec9c-1c29-4df0-81fb-11b2dd17f2e7	1716703	2019	93.8	456.43	66.4	109157.19
d5151fa7-2d3d-42df-b70f-e55b627addb8	1716703	2020	88.9	248.63	90.8	44480.18
06b688bf-7692-4b6d-a03c-56173381ce32	1716703	2021	70.6	425.14	80	59801.71
6f362652-e00d-4b3b-84c0-96da45dc8277	1716703	2022	79.5	415.67	92.1	31542.67
2fdc59b2-c0b5-4d53-85a0-165974c79fe1	1716703	2023	78.2	460.05	84.5	52398.24
619870b3-a28c-4ace-bff2-508fa3c9af9c	1717008	2019	86.7	272.57	63.9	88572.99
b21e202f-51bf-40d5-adac-59247adcf62b	1717008	2020	87.9	179.43	78.6	14521.07
3c19866a-61fb-4a0d-82a0-4f7a5e45f428	1717008	2021	92.5	20.98	82.5	30672.17
d8427d17-bad5-46d3-b562-fdbb682c96ab	1717008	2022	59.3	449.82	83.1	142962.61
01bf4d91-fa5e-47b4-a154-b6dc452e69bb	1717008	2023	62.6	111.93	72.1	33457.29
6122132f-7f8b-499b-9ad3-8fbc149b5274	1717206	2019	55	355.71	71.5	27951.01
dd91236f-efb6-411c-be9b-ec8c01534e61	1717206	2020	90.7	121.24	74.8	112579.8
4e5eccb7-818c-48f5-8edb-9d9e1d9236b7	1717206	2021	57.9	240.58	67.2	126670.09
34c0ebea-bc6b-44c8-8153-0e18682cd5c4	1717206	2022	61	384.42	84.2	117703.9
d9ae4228-5e51-4363-bc6c-0a3a64b05321	1717206	2023	58.9	141.29	85.6	39755.71
16bf3a1f-ece1-406d-9305-da3043c1c958	1717503	2019	68.6	268.33	75	30508.95
97294944-dd71-499b-82d5-98f64ad7c0a6	1717503	2020	62	260.06	66.6	9599.93
4697b537-ec9e-407d-8ad5-a3a4fbd2ff43	1717503	2021	60.4	48.73	92.9	125612.15
693b02ae-6a6b-4c3f-9be2-4a4545b7fc58	1717503	2022	86.2	163.3	70.4	46263.92
315d76ba-afc1-497f-9d24-a4707ef6d25b	1717503	2023	78.6	240.82	63.4	60842.41
645c9cfb-9f07-4dd9-acaa-e43550e0458f	1717800	2019	88.4	144.81	80.4	30805.52
c49897e0-9abe-4302-b2c4-b7dd8a58a90b	1717800	2020	79.1	165.49	78.7	126986.06
96cb7dbe-99ef-4301-8ed8-aa8336c6f03d	1717800	2021	68.2	52.63	81.1	84671.3
340a4721-a478-47ab-a8d2-62e1b285623a	1717800	2022	85	149.36	83.7	46816.14
6e1d0fa3-fd77-471f-a59e-0520ba776751	1717800	2023	88.8	145.64	79.1	88534.85
514f303a-921a-402c-ac4f-9bb1de0b0175	1717909	2019	68	271.61	84.8	108124.54
4fe05b7a-4c3c-4608-ae56-b50e1d4ae33c	1717909	2020	93.8	406.08	78.6	48929.11
a345e12e-2eef-4858-8e30-c767bfd35a4d	1717909	2021	89.9	291.06	93.4	17141.93
8b3f878e-310f-490f-96c7-8edb785a9afa	1717909	2022	56	115.84	94.2	113749.92
1542e062-5f56-4068-b339-a486bac12cb9	1717909	2023	94.2	179.14	77.4	149800.1
6ca17d58-c039-4b56-951c-e833d33edae3	1718006	2019	76.3	406.68	69.1	117821.45
3fd56ec6-c1fe-4d8d-b812-4d2a345f37e4	1718006	2020	87.6	39.38	85.4	73730.15
c6c201b9-031c-42c9-b41e-4097e0421c2e	1718006	2021	75.8	111.23	73.3	23282.15
ced885ba-44ce-4fb2-9f45-dbfa393b26f1	1718006	2022	79	21.63	60.5	133287.25
d7ba7657-b1ce-4175-a659-a082a8964055	1718006	2023	86.5	27.41	92.8	11592.47
6db6e24b-2086-483a-b5c8-2796bb8bc510	1718204	2019	88.2	316.89	69.3	84708.17
c8b0e4dc-c81f-463d-8f9b-76d1abbe35a9	1718204	2020	85.4	336.99	90.8	115621.65
86334ac7-9117-409b-b2e6-329538a4560d	1718204	2021	83.2	205.64	62.9	7446.34
f506ea8d-0b9b-49c8-8461-8ebf5eba9e99	1718204	2022	70.3	309.51	75.8	70282.18
f4f18c7e-35a5-43a1-9edd-5fd067cd11e5	1718204	2023	83.8	411.65	76.9	88505.35
5d38969d-e364-47a0-bb29-2f25fff7ec0d	1718303	2019	55.9	120.37	75.7	20898.54
aa81cce8-1e88-4b5a-9f13-71f3df016ee1	1718303	2020	91.6	286.46	78.4	52246.71
f28f128c-1094-4eaf-87b4-95ce0e3a2968	1718303	2021	78.7	107.64	65.2	140928.64
584141f8-0b77-450a-a6e4-dcd834be7042	1718303	2022	89.1	54.53	61	58028.08
a05d8fbd-df06-4c56-9547-876f20a9d886	1718303	2023	59.2	309.33	80.5	126138.92
e1e47241-e2ad-434c-8277-4d99c53e84f5	1718402	2019	73.5	490.36	69.1	41411.49
5f906650-85e6-4c11-a4c9-0acbdb7f719f	1718402	2020	72.3	253	69.9	75522.68
0f04422c-eb54-4d66-a281-3ee01600a593	1718402	2021	73.6	402.29	72.9	84077.54
0f4aea0a-c68c-455a-97b1-a29c4eba0112	1718402	2022	82.7	102.38	67.8	98031.44
14cd72a6-4851-4c1b-bed1-813a7175c07e	1718402	2023	84.6	211.79	71.5	10997.61
847104e2-d7f5-4cbd-b80c-ec39fb02925d	1718451	2019	68.7	178.01	83.9	143553.98
ea12d661-3443-4b56-b1c3-9f7e46c94574	1718451	2020	83.3	257.25	90.2	79896.24
6e5cc5b4-5d5c-4298-b0aa-e57323a8b46d	1718451	2021	78.1	102.93	85.6	112200.64
a9acaedc-7d8e-4617-88e1-a6ca853d887f	1718451	2022	83.8	10.27	61.4	77771.79
552775cd-ffbd-4ec6-a588-33bdf5a5f7dc	1718451	2023	79.3	198.76	68.4	52695.61
5da56964-351f-4836-bd66-7d6f4bf0e64d	1718501	2019	76	271.17	87.2	15584.09
c6475955-ac6a-40be-abaa-6c47cbeff33e	1718501	2020	64.8	258.47	74.6	91127.35
b3bef576-2963-4806-8d43-f93b9deb09a6	1718501	2021	69.7	19.46	84.9	50861.38
835a5c91-68e1-45dc-a6c7-c7764ec22c97	1718501	2022	78.5	323.82	75.4	44540.32
2f69eff5-0448-4aac-9444-23836f092aab	1718501	2023	94.9	140.49	77	33061.56
f95d9090-c26a-47f4-8532-fe971a31d5a1	1718550	2019	70.9	493.37	89.9	41321.3
c8b3a96b-e5a1-4c9b-b38a-107363a3fc3c	1718550	2020	82.5	490.83	92.9	131786.2
7f573901-5edd-4048-8a58-466c9ecdc0bf	1718550	2021	68.5	209.44	76.9	11283.93
b09f09ea-9bb8-422f-af50-9d1037159e36	1718550	2022	55.9	402.5	90.5	59379.59
9d341f27-2a59-4d06-aa65-cb10041534c6	1718550	2023	79.5	391.36	64.3	82322.31
f312d4fd-27f4-464d-9e18-08f1809cf955	1718659	2019	91.2	418.4	72.9	60373.95
316263f2-f6ff-4733-a282-d96350f102de	1718659	2020	60	240.49	63.9	123436.21
7fd6e872-1639-4b19-9189-4d8e4ca83c42	1718659	2021	69.6	44.55	94.7	131303.53
1536d659-3a57-4cd0-b018-9cd7716986f9	1718659	2022	77.4	477.48	87.7	46007.32
4a1fc056-9068-4660-a1e6-dd3073c6b51d	1718659	2023	85.5	186.81	78.6	29550.44
22d5775a-93c4-4a55-a943-85bae8039062	1718709	2019	75.1	448.45	86.3	71440.04
fe664466-c4d8-4db1-9575-bf318822ada7	1718709	2020	56.9	192.26	65	11182.66
3d8d4452-2b72-4ab0-aade-7d1c3980676f	1718709	2021	80.1	489.58	74.4	135949.48
c3fb0ed5-ec9f-419d-b194-a58091130e8a	1718709	2022	86	58.9	88.2	55639.18
f3b49926-853e-4736-8bae-f13cff1b160d	1718709	2023	71.4	131.33	63.7	92624.19
ab0ee287-7931-425b-bfe9-c9a596f53a6b	1718758	2019	92.3	497.49	76.9	57022.57
fc824de2-755e-4338-bfd9-d9ceb41e050c	1718758	2020	59.5	187.45	90.1	24505.71
ceedfd92-4177-48c1-8da5-434eae18d794	1718758	2021	74.6	311.09	90.8	148082.97
7824133b-d029-46ea-9c16-4b3cc5e2c2e3	1718758	2022	91.8	115.68	73	123697.91
629232c6-c51b-4129-b0e3-9d60e5e833a8	1718758	2023	74.5	181.19	61.4	126648.88
5d2162b4-dd1b-4e96-a1b6-b3709f20a30d	1718808	2019	70.4	288.34	88.2	68140.75
19299523-5e3a-4a9a-89f9-a7ee73d6297d	1718808	2020	70	70.45	80.8	67666.59
bcc3933e-9f25-4095-97b4-8e8567de3a50	1718808	2021	90.2	322.03	73.1	108909.74
a323b79b-4d4a-47a1-9f9e-624055c9385f	1718808	2022	63.5	82.65	74.8	84356.63
daa8915c-adee-4de9-8515-f384ffc01629	1718808	2023	69.5	115.86	80.6	105263.47
63eaa876-76f3-42d4-82e3-bbb50c1c984e	1718840	2019	65.2	206.65	65.3	47189.21
f2525740-04a1-412e-917e-04eea0dc76f4	1718840	2020	60.5	415.73	74.9	149395.53
a2dc1252-9ec7-40e4-bda2-4bb854a51bd5	1718840	2021	55.1	323.45	87.5	72227.97
cf6e8f64-ea8f-47d9-988f-5f6374d38c45	1718840	2022	66.2	391.17	77	8125.12
440ce742-80a0-4470-b332-6972627484a0	1718840	2023	67.1	25	67.7	72597.02
24dd341f-565e-4b77-94dc-fa429a2f7be8	1718865	2019	92.7	170.27	78.6	119799.31
f9224f19-8747-428d-a649-9ea69096d82d	1718865	2020	63.1	97.17	65.7	87491.01
78da780d-046c-4f49-a11b-3fe4197d934a	1718865	2021	76.1	499.41	84.5	101076.58
b5214ee1-0f87-4781-a852-ea8e06f370e9	1718865	2022	64.1	284.33	69.4	98596.14
9d818498-6446-479f-8d2e-d475e0cbff13	1718865	2023	92.8	56.12	87.4	132146.81
22888f5c-67c1-44a8-a207-5e0f96e33072	1718881	2019	74.8	273.02	81.9	108072.06
3aacca58-c679-453a-a871-0902f8483de3	1718881	2020	55	392.22	61.1	137460.11
b792f70f-a770-47fc-ae7c-70cec3c53940	1718881	2021	88.5	365.46	78.9	104608.04
7db02b02-141d-4681-ae57-3f4cd8927ea1	1718881	2022	57.5	373.19	78.1	101090.46
a5c04cfa-4e21-40d2-ae64-32088a06291a	1718881	2023	80.4	24.3	90	72179.79
0d2d3e8e-0353-4c03-9003-bd1e1d4eaf7b	1718899	2019	87.2	136.6	62.2	59160.5
c6b4acf4-35a5-44b0-97bf-8d995b48c532	1718899	2020	72.6	180.31	62.9	98250.26
c6fa1b04-b242-4199-897e-47235e8cc0e5	1718899	2021	90.1	278.02	73.9	16204.13
6a0590d5-6be2-43ea-a7db-ffab4469bcdb	1718899	2022	71.5	187.54	88.8	116643.35
de3fad88-df9f-4a79-b7cc-5dd40fa01f11	1718899	2023	94.8	437.37	89.2	8644.77
3204ce47-2906-4ffb-b7ec-c5c7652c6975	1718907	2019	73.4	278.4	73.5	31674.7
402f537c-9059-47c8-86cf-d11b87b98473	1718907	2020	72.8	156.13	73	147820.33
d4d60f0e-c672-4e95-b706-5d6366ac7a0f	1718907	2021	77.8	492.95	87.1	126865.3
ec2cdf51-11be-4a8e-80d2-71efbde7488e	1718907	2022	93.5	132.14	66.2	133614.3
27ef1965-4627-4620-9c0b-be3316857d49	1718907	2023	94.5	258.24	89.4	34378.72
982cdcab-f1f1-4627-99f1-fb3010cfa8ea	1719004	2019	92.1	37.96	75.9	58597.06
6d38585c-8e34-4a08-bffe-e1a836ce8ee4	1719004	2020	85.9	355.32	64.5	63289.13
6b8ee739-d9a7-40e2-8d23-c1da5d58f533	1719004	2021	84.4	177.78	70.2	45846.36
72eb7655-b991-451e-9972-6f0000841dae	1719004	2022	60.1	199.74	83.6	147828.16
80ac9e93-ad0d-4276-943d-3776216e07e4	1719004	2023	82.2	441.7	84.3	133674.08
641b1ca2-83b6-4e90-a1ce-410316eacb38	1720002	2019	63.3	132.21	86.5	32362.96
d0c32ae8-c09e-4733-97e9-36be7c9247d4	1720002	2020	84.9	276.37	90	142338.4
989ea743-c657-472e-9005-e33c04f86932	1720002	2021	61.6	139.67	71.1	26621.53
5dde28df-2c64-48fc-bdb9-460041ee86f2	1720002	2022	77.4	168.48	75.1	37799.81
5ae62423-fd53-4dac-9e86-78c5c834415f	1720002	2023	88.2	25.4	81.8	100901.54
77119a3d-5a62-440f-a682-8bb4ab4aa4a8	1720101	2019	61.7	135.35	91	94347.19
ccfba132-0de8-4d7a-8c4f-c4ad86179504	1720101	2020	65.8	82.39	62.1	43018.86
fb127724-f363-4c62-b239-aab54404c588	1720101	2021	57.4	88.9	67	43078.04
a33b4c33-c68e-4266-838d-f5ae32897959	1720101	2022	72.5	191.35	70.2	51558.58
74143085-b7a2-43fa-b804-e15074bdf0f3	1720101	2023	87.5	282.45	65.4	113848.68
ba823e0a-d448-45fb-a255-e0ea009d9ddb	1720150	2019	84.7	350.65	86.1	73873.75
46065f0a-c454-416a-936f-37148e94b665	1720150	2020	76.3	479.47	65.4	46592.97
6df5e3ab-10f8-444c-854b-1309d4cf4cbe	1720150	2021	59.3	451.03	65.6	79078.71
3c1eb3c4-1bd5-4ef3-bcad-d0f1103f61dd	1720150	2022	86.2	177.91	80.2	114280.88
d7db5fdd-9dcb-4644-b907-411e60306f61	1720150	2023	58.6	123.02	66.8	78656.06
a81bf61c-020f-4a56-8447-28de156273e7	1720200	2019	59.6	110.92	81.2	70624.11
2e933894-daeb-4513-bbf2-c1ae9a065b08	1720200	2020	71.8	365.08	90	78739.98
0bb6bbcb-d8f0-44af-aff1-da090ecbc870	1720200	2021	93.2	38.31	78.8	9550.35
bd390e59-8031-44ca-8cd6-53a22f276789	1720200	2022	78.3	453.29	84.1	101929.13
3251afb0-278d-4eeb-9255-f71bcfd4c477	1720200	2023	84.8	190.25	91.8	27734.28
fe84b7fe-7934-40e2-84ae-03e850d8e84b	1720259	2019	67.3	499.16	67.8	10275.49
7595ed43-d88f-4f03-9806-cb17e0f9cb0e	1720259	2020	85.6	374.57	75.6	13213.22
cf25ab0d-b35d-46bd-8ae4-2f48632dbf26	1720259	2021	63.4	401.86	87.9	113527.08
b3a1e154-a9bf-4500-82cd-60a995f6c5f1	1720259	2022	88.9	286.05	77.4	103437.41
52be6e92-9ec0-462c-9215-0c8da61ab4d9	1720259	2023	81.1	135.96	80.8	72556.72
bd4256f9-0a40-499f-ae5e-11e57b409611	1720309	2019	86.7	337.72	87.3	124453.86
2af5c5cf-5669-406f-afd5-bc27a5431340	1720309	2020	62.9	222.53	61.3	58184.19
152cf5f5-1121-4498-a904-587866a8ba57	1720309	2021	72.8	232.08	66.9	78580.02
8f4ad1f6-fa03-4def-8255-aac7379e4aa9	1720309	2022	83.9	223.12	92.5	35761.89
67ebeb6b-9bcd-4181-ae91-ef09d1b6b5b5	1720309	2023	82.4	207.71	90.4	49290.14
6c009c37-bbcf-4cfa-8505-63483e1edf01	1720499	2019	86.3	173.52	79.2	94836.88
f4ab2e88-b426-4085-af5e-d4ebe313b456	1720499	2020	57	307.02	63.6	93152.9
9be0a510-f49f-4e9f-bbaf-24fc3a7059a7	1720499	2021	89.1	23.81	66.1	115522.84
adb5ef09-7b45-4202-af5c-77d519e0a466	1720499	2022	76.1	497.84	80.9	82525.98
e0077e80-bdea-452b-9ff8-33761099dbd1	1720499	2023	75.3	470.82	81.4	83990.48
de73036a-b4d4-4d18-8633-e6f113c78027	1720655	2019	77	378.09	69.7	30777.54
a3b90794-cc3d-4ebc-b382-9a6162875abe	1720655	2020	59.5	210.95	92.6	51747.94
7166ede0-8cb7-4050-a90e-e182d69ee743	1720655	2021	89.9	147.83	81	49553.25
dd790d4b-70c5-4fc5-87d5-7c2fec29e151	1720655	2022	65.3	345.21	86.1	98598.95
0edea7bb-71b9-4e44-abde-739371fa8f96	1720655	2023	87.9	187.22	66.5	148633.2
4a58e48e-fbf2-4599-88df-e2b5061afbdc	1720804	2019	68.9	372.73	65.6	139442.45
c458cf8c-6ef1-4e36-8943-9cd0c5f2dd7d	1720804	2020	89.7	489.06	70.1	77891.48
370105a4-a45d-43fa-9f4d-ca74cba39c34	1720804	2021	87.6	306.6	94.5	10394.08
c60463b9-74ef-45a6-9be3-6af05e51613f	1720804	2022	67	218.67	82.3	92326.35
a902c9fc-7f46-4c6f-91d4-0d70120b3622	1720804	2023	57.7	309.61	82.9	144737.5
9c1facc4-cd79-435d-a77c-5f353c5a19fe	1720853	2019	90.3	459.41	75.3	70543.61
b19bf7f8-ca1b-400d-9bea-1c115a093afb	1720853	2020	94.1	257.78	88.5	51128.58
54624723-ca74-41ea-a470-77832715d434	1720853	2021	55.8	419.82	67.6	126603.79
8166001f-64fb-409f-8160-14ee1ebddba1	1720853	2022	87.8	299.54	75.2	6336.93
dc71343c-cebc-4dbe-a793-d1a52adbd791	1720853	2023	89.1	479.7	70.6	78719.74
9e13f1e5-5ac9-424b-bab9-629882cfb036	1720903	2019	74	418.77	80.7	57065.64
0bd5d8a7-c817-4762-9fa8-2f93efd415c9	1720903	2020	56.5	318.88	82	46548.74
8b97ebb0-c4a9-48ce-9fdf-2795195c2480	1720903	2021	73.2	497.39	71.1	32203.2
752eb8b4-5729-4629-823a-3bd10d7423c2	1720903	2022	86.9	118.62	70.5	136879.1
131d99f3-7231-49a2-93a7-1b5e127e1105	1720903	2023	91.3	285.36	77.6	145240.4
1fa2f499-7b5b-4cac-b7fa-2d6ab31fd8b6	1720937	2019	94.7	244.1	69	133890.02
07e799ae-8199-473c-b2c3-888f4246b41f	1720937	2020	65	471.47	68.8	7387.46
d0ac0eb3-f2ae-40bf-a538-948acd472a71	1720937	2021	77.5	433.26	83.1	12986.69
e9224d79-785c-4f33-84bf-133d34dbb037	1720937	2022	71.8	124.27	82.5	124080.84
cadcfa51-bc1b-4589-8c5a-b3ac8f557548	1720937	2023	90.7	384.95	86.8	17878.67
7a53baa6-2e3a-4a85-8339-6ae74e041aaf	1720978	2019	78.5	334.39	86.4	113593.04
7a623218-5b6a-4ccc-98b3-4ea3885ea003	1720978	2020	56.5	68.49	74.2	39458.05
717884e2-92db-4516-a0e3-ba9dbd5d2508	1720978	2021	77.7	119.57	94.7	10365.44
7dcc2150-4ba8-4a79-a24f-a7d75fc42755	1720978	2022	65.8	70.08	62.6	111569.48
8cf6eb5d-5f16-49b3-afd1-0635ca87a19b	1720978	2023	68	29.21	72.9	85138.47
a1860630-a05e-4cd7-9cee-3ea11447e2d4	1721000	2019	90.1	17.34	79.8	48654.25
4f0a55f4-d0d3-4af9-9ac7-a95b190b461c	1721000	2020	61.5	465.61	70.6	80829.49
eb8700e3-aac2-432a-b497-a73349f7068f	1721000	2021	89.1	190.68	63.5	137812.4
3c4e683a-7a70-4107-bc04-6f25c11f3c2c	1721000	2022	86.8	475.92	87.9	15933.42
e2a0474c-322d-4697-b520-a32c21ed0008	1721000	2023	74.7	278.43	85.3	16393.14
f80b9bf3-68aa-450d-af89-d54cce9c29aa	1721109	2019	80.6	282.41	94.7	142136.98
437d874e-8e18-445c-9571-ddd3da415589	1721109	2020	55.5	345.89	77.6	20581.11
e7930c3a-8e56-41fc-890a-7fb649b7f7ab	1721109	2021	72.1	38.17	94.2	87065.58
9019d197-fa4b-4da4-863f-837edd8489f8	1721109	2022	91.1	245.48	90.8	83813.72
a845a4c6-717f-4c89-9c73-68b36811c2f0	1721109	2023	93	435.7	80.5	33948.6
fd075bfe-808a-469b-b613-ed5b85d9229e	1721208	2019	63	428.1	62.4	141222.14
88673b73-8141-4a46-8000-8967df22563b	1721208	2020	91.2	403.29	66.7	107292.11
350b5726-82d8-468d-8895-664aedcd3db4	1721208	2021	81.9	166.55	71.4	111240.99
192ef8a7-f434-4ed2-8f6c-6a1d20e519f5	1721208	2022	71.5	60.17	70	103420.54
0f8ed215-766b-4f87-b5a0-91d6d2e8dea7	1721208	2023	61	290.71	70.1	139846.69
bdc03908-2cf6-49c3-a2d8-edab6c572cfb	1721257	2019	58.9	373.37	75.5	68529.88
d63d9fd3-d19a-4025-be61-b5e9a5b91a7c	1721257	2020	89.4	445.06	65.8	31315.7
f30ce9b4-cfe4-417b-9940-7253019ace83	1721257	2021	78.8	131.16	72.9	128923.18
2254f96d-ff7d-454c-8988-a8801b26888e	1721257	2022	74.3	231.24	71.9	14524.31
036dfc60-b006-4ecc-a22f-5eafa34160f3	1721257	2023	79.7	466.19	84.8	39720.52
56fa76ff-799d-4570-bae6-2c0d64ba1dd0	1721307	2019	89.3	196.75	72.8	128009.78
04cc242b-3d26-416b-93d7-78b08e8b2c0b	1721307	2020	79.5	347.86	73.8	119785.71
ba27929c-e61c-4bcd-9b7b-3de28d3339ad	1721307	2021	90.5	96.8	92.4	141922.05
b085cb3c-fba0-45d7-a856-0673d3ae4c46	1721307	2022	76	256.06	63.9	64824.94
786cae0b-611c-4a20-b5ad-1d907c11c6a3	1721307	2023	67.7	370.15	76.1	57982.51
47dcee78-8a80-4317-ad72-a24194ba359e	1722081	2019	59.7	281.69	94.2	124311.63
1fd409d9-9dcd-4a76-84da-6ed1408f9ac3	1722081	2020	82.2	90.22	85.9	127069.79
324380c2-0f98-41b9-baeb-d3b3b50282ef	1722081	2021	83.1	156.83	88.6	8093.77
3e03baaa-f0f5-4512-9df0-8c39ad5a7df8	1722081	2022	62.4	158.34	74.5	105734.07
4f110f4f-6aa2-4030-aa83-ff65d3364341	1722081	2023	73.6	295.38	78.4	20118.3
22de463e-2ab7-45b6-a2f2-72db4372dc0b	1722107	2019	92.4	111.56	92.8	106523.81
c9b44712-7e5d-4cb2-8573-8699ba9b1ca7	1722107	2020	80.9	389.26	64.8	71117.63
cfa0b438-268d-4a5f-b2b1-a28a391f324e	1722107	2021	70.2	166.76	76.6	29300.53
f0e37523-d7e6-45cc-90d7-ed88cdf1a7a0	1722107	2022	85.6	43.98	82.5	19890.67
7091c91d-aaad-43f5-aa1a-224828dc5135	1722107	2023	77	356.72	67.5	27244.03
\.


--
-- Data for Name: indicator_metadata; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.indicator_metadata (id, dimension, indicator_key, indicator_name, description, unit, interpretation_guide) FROM stdin;
\.


--
-- Data for Name: knowledge_base; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.knowledge_base (id, territory_id, dimension, content, embedding, metadata, embedding_vector) FROM stdin;
\.


--
-- Data for Name: social_indicators; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.social_indicators (id, territory_id, year, idhm, population, literacy_rate, income_per_capita, education_metrics, health_metrics) FROM stdin;
7ae3f447-c4cc-4d1d-88ee-26026bf65ce0	1700251	2019	0.71	2579	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
be205338-2668-46e6-a67a-4ee176ad1f26	1700251	2020	0.714	2594	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
2a8717d9-828d-4b7e-87c3-5519f8f96614	1700251	2021	0.717	2609	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
4beb4f8c-0f62-4e82-abc4-33caa085f8a9	1700301	2019	0.71	6733	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
fb142f69-1ccb-45a0-a871-213d62ef596f	1700301	2020	0.714	6892	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
1eeb27dd-6502-487a-af9a-485424a90061	1700301	2021	0.717	7049	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
fd67669e-570b-4dcf-a6fa-d48e19b6342d	1700350	2019	0.71	5390	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
74bbf183-4482-4b92-82bd-3e826b97ccb3	1700350	2020	0.714	5346	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
e8e4df5e-da23-4666-b915-9fe2061d0ff7	1700350	2021	0.717	5303	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
7c9d26e6-cceb-491a-bca7-3ccfff0a1ced	1700400	2019	0.71	7055	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
c90363b6-3d2b-4465-88f5-4ee72e4266cc	1700400	2020	0.714	6979	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
9aedea69-1c87-4e3a-ad9d-3dafa58455e8	1700400	2021	0.717	6905	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
2c922719-8788-43cb-9ee9-c52e992e281e	1700707	2019	0.71	8412	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
3da80177-311a-4abf-96ec-4bcb16d82e2a	1700707	2020	0.714	8396	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
c53a7446-253a-428f-a91e-0b8231b36256	1700707	2021	0.717	8381	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
3824b27e-d51e-4419-962e-4e4bea66d7a9	1701002	2019	0.71	9549	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
001b0ee2-6c2e-4abb-ae69-790a3fe49c90	1701002	2020	0.714	9492	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
59890433-231f-46e8-8c2b-ad2dfe6ec810	1701002	2021	0.717	9435	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
21045bae-85f9-4753-a2a1-e538ec53b0f5	1701051	2019	0.71	3433	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
d917f895-68d1-4b6e-93ed-684b3a2e5513	1701051	2020	0.714	3454	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
928620c1-cd76-446f-8ef1-10201e055185	1701051	2021	0.717	3475	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
36f87339-4939-4d48-813c-6c783918d578	1701101	2019	0.71	4795	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
b62694cc-ed2f-41ae-8e7f-7395253e6b0a	1701101	2020	0.714	4848	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
f6b4adc2-4a8f-4aba-ae3d-a3545a9d21fd	1701101	2021	0.717	4901	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
2f8ecddd-ca0d-40a2-a13d-098571f5d332	1701309	2019	0.71	5758	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
5c2fbc54-29a8-4f4a-b67d-8d2fd78fa6e1	1701309	2020	0.714	5731	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
dbce8c77-acf3-4175-8c64-f9f1da4a1109	1701309	2021	0.717	5705	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
fad96005-0fba-44c2-b3fc-7d938b64f564	1701903	2019	0.71	7086	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
6496451d-9083-498c-a01d-1486b30a25c8	1701903	2020	0.714	7155	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
48ab54ee-7491-4bb9-bbd0-f2899b0be98c	1701903	2021	0.717	7223	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
27c20306-f044-4c6b-9275-e11c0c3d2795	1702000	2019	0.71	8517	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
ea024714-cf31-432c-8770-812160304f7f	1702000	2020	0.714	8467	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
b5594277-f400-42ef-b507-7e79e747aec2	1702000	2021	0.717	8418	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
e1dbbe03-3f34-4784-8d5c-6a21a248cf7a	1702109	2019	0.76	180470	90.4	977.5	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.1, "taxa_conclusao_medio": 76.8, "taxa_conclusao_fundamental": 85.9}	{"expectativa_vida": 74.2, "cobertura_vacinal": 87.4, "mortalidade_infantil": 16.2, "leitos_por_mil_habitantes": 2.18}
93437b13-df95-4431-90fa-0e85f7bc56e9	1702109	2020	0.764	183381	90.6	997.05	{"ideb_anos_finais": 4.3, "ideb_anos_iniciais": 5.1, "taxa_conclusao_medio": 77.0, "taxa_conclusao_fundamental": 86.1}	{"expectativa_vida": 74.3, "cobertura_vacinal": 87.6, "mortalidade_infantil": 16.0, "leitos_por_mil_habitantes": 2.2}
fa40bf0b-76eb-4c6e-965d-35faa433e19d	1702109	2021	0.767	186245	90.7	1016.99	{"ideb_anos_finais": 4.3, "ideb_anos_iniciais": 5.1, "taxa_conclusao_medio": 77.1, "taxa_conclusao_fundamental": 86.2}	{"expectativa_vida": 74.4, "cobertura_vacinal": 87.7, "mortalidade_infantil": 16.0, "leitos_por_mil_habitantes": 2.2}
0c977d8a-37fc-4e1a-8f40-d15cbe072c55	1702158	2019	0.71	5729	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
43f0cbb5-445a-4aed-aa6e-0eae59d7b543	1702158	2020	0.714	5793	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
21e11694-2251-4504-9df0-170bb60ed60f	1702158	2021	0.717	5856	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
f6579f89-9b13-478c-a17b-b4975525edb5	1702208	2020	0.734	36170	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
dfb76a93-b502-4808-ad5e-3c33f1c92b7d	1702208	2021	0.737	36573	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
b5e3fe6e-2514-46f0-9214-fcbe3ee35e83	1702307	2019	0.71	6643	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
84b326d9-7eff-4af0-9c6e-d2dac1f76b3f	1702307	2020	0.714	6616	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
3421b480-f929-4f0d-b180-fd2e6ba8e299	1702307	2021	0.717	6590	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
eeea798f-d373-4d78-b6e2-f055941626b0	1702406	2019	0.73	10567	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
2f58147b-807c-484d-88a5-5aeda8ee9d44	1702406	2020	0.734	10534	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
894a5587-0252-47d1-90d6-09fec172b2da	1702406	2021	0.737	10502	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
02252aaf-e863-4f6d-89b1-e63e92c7f385	1702554	2019	0.73	18412	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
723f69b2-1bce-4efb-8f50-9a2c744ae03c	1702554	2020	0.734	18643	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
42fbd0df-c8fc-4eef-9233-0a8bbdea92db	1702554	2021	0.737	18870	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
3ca397eb-6f06-47bb-ad2c-02bb949bd9d3	1702703	2019	0.71	3757	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
62aa6c57-d9d3-4c9c-8d0c-70e4bd6dd274	1702703	2020	0.714	3783	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
2b91aae0-e4f5-410e-84ef-ce6ed26852c7	1702703	2021	0.717	3809	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
daf0966e-7a14-4380-95c1-d24f0045c476	1702901	2019	0.71	9756	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
db8ca369-39d3-4327-ae3e-e799f13c5b33	1702901	2020	0.714	9787	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
aadc0f2f-ddf8-4981-9e3a-e207aa188f79	1702901	2021	0.717	9817	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
62a83a30-7e2a-4836-a332-a624c7d35c10	1703008	2019	0.73	10664	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
ec6846fa-41bc-418a-80ee-c0604f71904a	1703008	2020	0.734	10666	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
850cf2a4-7fae-42c5-b7c3-1f0d889a24d6	1703008	2021	0.737	10668	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
2a757559-ca0d-4971-911c-a9e5dc2240c1	1703057	2019	0.71	3553	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
c465e4b4-088a-406d-9643-065a5e838245	1703057	2020	0.714	3592	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
d2f932e1-dceb-411c-9833-50e4021764df	1703057	2021	0.717	3631	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
2a8828fd-9a85-4c04-a1f5-46d3e90b6623	1703073	2019	0.71	4591	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
f833440f-c4d3-43ad-bc29-68bca1efdf9d	1703073	2020	0.714	4632	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
afdbe3e1-f18b-465a-b146-eb8833cb8be9	1703073	2021	0.717	4673	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
e05abee2-1389-4628-8e11-0e3ac5019fab	1703107	2019	0.71	5632	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
bc74fc43-4438-4cdd-8c5c-eafdfd2af7e0	1703107	2020	0.714	5651	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
8dacb624-0d61-42c2-9e07-9773d3275b2e	1703107	2021	0.717	5669	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
08447f03-08b1-46c5-aa2a-1b8395be7a5b	1703206	2019	0.71	4459	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
cec39122-5f10-472d-bc6a-7f62d9ffed7e	1703206	2020	0.714	4448	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
e65930dc-aee5-4ac5-ac87-81ad83c79879	1703206	2021	0.717	4439	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
66c35038-4a96-4c40-849f-eefd97ced460	1703305	2019	0.71	4894	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
414aff3e-4328-4c9c-b86c-8b1c8e34c25b	1703305	2020	0.714	5008	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
cd465fa2-b121-4a49-95e8-212f7676edc8	1703305	2021	0.717	5120	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
7259195b-0616-4b39-a80f-6abc9ebe8cb3	1703602	2019	0.71	2201	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
b4804b5d-0e69-4029-94a3-33909a96b744	1703602	2020	0.714	2211	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
6d4453af-0646-455c-8461-6b1228ae8708	1703602	2021	0.717	2221	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
f9569b18-2bc1-4519-bf6a-ba8ce819c9a4	1703701	2019	0.71	5497	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
7c018cb3-45a5-4b35-88bc-118f00198cf8	1703701	2020	0.714	5519	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
33fe6008-7b76-4e95-ab6e-e291b9d7920f	1703701	2021	0.717	5540	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
893194ac-844c-42b1-b1ad-f5df6a38b943	1703800	2019	0.73	11348	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
c812ed8e-3d51-447d-8be0-b3ce16af555d	1703800	2020	0.734	11497	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
efab21bf-bac1-423b-8fbd-8587c9c7595f	1703800	2021	0.737	11644	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
8fa5b971-f13f-4d20-b57e-e57c2cadbd57	1703826	2019	0.71	2275	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
d233bc2b-9f2b-4588-ae34-c5f90210e9e5	1703826	2020	0.714	2284	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
b0173c34-accb-4a5d-84e7-8c19085a1062	1703826	2021	0.717	2293	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
dfe15604-b738-4b68-b4ad-4585b8ae209b	1703842	2019	0.73	10116	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
6929e000-817f-4d45-894f-14a818919b5d	1703842	2020	0.734	10312	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
8cd7730d-a381-4a37-aaeb-1db073db9e0c	1703842	2021	0.737	10505	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
7ff71d2b-5bd6-419d-812f-14a39b7125f8	1703867	2019	0.71	4382	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
59c61af8-34ac-4f7b-b47b-a3921beee16a	1703867	2020	0.714	4441	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
1f6df91d-2a1b-4ae6-9319-193c237b863f	1703867	2021	0.717	4499	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
4fe06336-99d9-4f34-a7d2-cae27c0666cf	1703883	2019	0.71	2580	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
c3177ce5-3aa5-49ee-af3c-22112fd10b64	1703883	2020	0.714	2603	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
da5208a9-5d49-473e-a6ea-e981f39ae23c	1703883	2021	0.717	2627	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
084c8844-b419-4356-a52e-3aa1112abf80	1703891	2019	0.71	4095	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
1e0d1150-c125-4f09-a562-3e35f243dc2e	1703891	2020	0.714	4130	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
8eec66f1-ee6a-465f-880b-e912464becec	1703891	2021	0.717	4165	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
4168956a-60ee-4219-9ddd-484dfb46323b	1703909	2019	0.71	5369	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
a69e01b6-a5f2-49d2-a5d1-f67f76699380	1703909	2020	0.714	5442	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
27a72460-b9c2-4d01-a096-d7148fc07413	1703909	2021	0.717	5514	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
a1232f7b-c3ea-45cc-90ff-800bee8e4449	1704105	2019	0.71	2905	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
b9d206ee-b358-43cb-8802-43a85fb21723	1704105	2020	0.714	2936	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
34355275-0bec-4294-bb96-6e9933883778	1704105	2021	0.717	2966	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
8d0dbc5d-d72a-42c5-96ca-eba34b82f3ee	1704600	2019	0.71	1406	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
060dee36-77b8-43bf-b47d-fb8cadbadfca	1704600	2020	0.714	1410	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
b29ef7d0-fb4e-42d0-9a4d-e2ad7fb4501b	1704600	2021	0.717	1415	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
bf9006db-2de8-446a-a9f0-3b5b20a44d10	1705102	2019	0.71	3333	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
8273ab2e-1f8b-4ec0-8a96-9ce1df45ea4f	1705102	2020	0.714	3331	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
4225347b-1576-4b25-8ca7-8998717cd75c	1705102	2021	0.717	3330	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
06f08250-e95f-4c05-8245-a77772aa4243	1705508	2019	0.73	35424	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
82fcf95e-f2fd-4e07-916a-59d806e4fa69	1705508	2020	0.734	35851	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
e632301c-f600-429f-85a6-090a2839cb43	1705508	2021	0.737	36271	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
9dcd78dc-1b36-436e-876c-c388fb21230c	1705557	2019	0.71	4852	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
86a67f55-d654-4bf7-a3df-790f4f74fb70	1705557	2020	0.714	4861	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
add68b41-96b2-4fee-9f16-a3371438d354	1705557	2021	0.717	4870	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
244f1583-e7aa-411a-ae65-a99c7006a8fd	1705607	2019	0.71	4105	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
007249f0-6f79-49ff-9502-815ba2fa1bcf	1705607	2020	0.714	4087	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
f13cec8d-3669-434f-bc65-0b8e59b63fb1	1705607	2021	0.717	4070	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
686e7bfa-aea8-46a8-a15d-df35be263b92	1706001	2019	0.71	5588	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
359fea94-2a20-48cb-aa26-ec93b077247d	1706001	2020	0.714	5639	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
49cb8d41-769a-49aa-8de2-5ea707da6e0e	1706001	2021	0.717	5690	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
9f9e4669-d41c-4f92-b9e6-7bcd5a45cfd0	1706100	2019	0.71	7289	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
e01d1098-0568-40c9-9730-d559ef26ae40	1706100	2020	0.714	7278	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
4fe13ddb-16e2-4989-897e-1bc8acfd1735	1706100	2021	0.717	7268	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
ec230061-92a7-4b2d-ac94-82680a3e03d6	1706258	2019	0.71	1722	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
4b92ca2c-0b73-4d2c-88a5-80543b8f0731	1706258	2020	0.714	1735	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
dfdc0440-219c-4221-ad51-b386518112fd	1706258	2021	0.717	1749	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
ae3a73ce-0dff-4d1a-9ae7-743600b1da96	1706506	2019	0.71	6097	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
022b2e3d-023a-4782-a5ef-47ae034f5ae9	1706506	2020	0.714	6174	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
b9b37157-78de-492f-a564-e4359c0385f3	1706506	2021	0.717	6250	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
1fe290a2-4c69-4939-9a32-a4c91fba9bd1	1707009	2019	0.73	22139	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
7d0370ae-8e91-4ad2-945a-851aabb13fa7	1707009	2020	0.734	22424	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
96ec2360-57b8-4541-aaed-c0d18df927c8	1707009	2021	0.737	22704	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
fecc1c1a-b37b-4e51-bc65-25293f5dc36a	1707108	2019	0.71	6900	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
f113e8dc-9aa3-4464-b76c-15c8c0f86b90	1707108	2020	0.714	6943	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
e590cd23-7929-40f5-bee6-898e26d6c781	1707108	2021	0.717	6986	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
5f30b251-891d-4102-898f-976fb1a3311f	1707207	2019	0.71	7198	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
689c5a41-18ed-4f1f-bd2e-494efaeb079f	1707207	2020	0.714	7185	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
19a8f789-e7d3-4fbd-bbf8-1572cfaf8f07	1707207	2021	0.717	7173	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
6801caeb-bac5-46d5-a677-0b2fced94374	1707306	2019	0.71	4686	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
02dd627c-f927-4c02-8de7-f3d5fe7eecf6	1707306	2020	0.714	4686	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
781ead24-591f-4d39-b0b5-49be37ea41d6	1707306	2021	0.717	4686	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
1c3dc18a-c5a8-49b0-be7f-c7c080713294	1707405	2019	0.73	10996	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
7eb5b5f4-9962-46fb-9d2f-c92417848ab3	1707405	2020	0.734	11139	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
a0774f49-50ca-4715-93c9-d63b1f775672	1707405	2021	0.737	11280	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
0af7d247-fbfa-44a6-a999-0dd8cadd4eca	1707553	2019	0.71	3835	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
d0e477d3-46c6-4e41-b9fb-ade99919ed17	1707553	2020	0.714	3830	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
a01787e5-237e-4c3f-975f-e2c94f91b32b	1707553	2021	0.717	3824	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
799ad378-d6df-4a47-b8fa-8883c6ddc654	1707652	2019	0.71	5263	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
961f6f05-80e1-4cd2-977f-e6feff3ee8c6	1707652	2020	0.714	5243	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
c05bd91e-8522-47b1-a89e-2c92a16e1851	1707652	2021	0.717	5222	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
003ae433-7a0e-434b-a512-d532f826286e	1707702	2019	0.71	8856	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
6c6e383c-159a-4350-bc33-a6b3b4f48573	1707702	2020	0.714	8874	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
72911795-4399-4238-99df-97ab9bd89f3d	1707702	2021	0.717	8892	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
1471f909-4efc-4721-86fa-ad80d4b173a3	1708205	2019	0.73	18440	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
4359d9fc-fe68-4383-b0bb-eb5ba99f6f95	1708205	2020	0.734	18399	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
70178c17-7f24-4943-8c0a-9bfd5d26e2f8	1708205	2021	0.737	18358	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
c17d53b8-4768-435a-abcb-c19f17a2e400	1708254	2019	0.71	2589	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
5b395e19-c791-4b73-9868-8726814bef45	1708254	2020	0.714	2602	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
26360a2f-6c97-44b0-8f0f-58dd1b1247af	1708254	2021	0.717	2615	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
871c06c3-3b9c-4e22-b6d8-15f826f13a5a	1708304	2019	0.71	5123	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
4ccea11f-a631-486a-a26e-be29c3d9391e	1708304	2020	0.714	5130	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
28ae4b82-5f5d-4a72-a6c9-c80626261f4d	1708304	2021	0.717	5136	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
dbab073c-9045-4ab9-aecc-a15b3c82975c	1709005	2019	0.73	13019	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
7cd79720-7dec-4744-8681-89972cd9c9c1	1709005	2020	0.734	13095	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
d661dc50-53d0-4377-8c21-afbb3dc38ffa	1709005	2021	0.737	13169	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
5a5580ab-a531-433e-ae63-cadcb7100abc	1709302	2019	0.73	25923	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
f0ffb28c-b8a0-4ccb-b9ba-dd03fb36a18d	1709302	2020	0.734	26165	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
cc38ac12-ca8b-428b-bcbd-43cb30d443a5	1709302	2021	0.737	26403	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
683a8be8-52a5-4164-9968-f66d0eb42520	1709500	2019	0.74	86647	89	892.5	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.6, "taxa_conclusao_fundamental": 84.5}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.6, "mortalidade_infantil": 16.8, "leitos_por_mil_habitantes": 2.12}
caba6078-a204-4da3-886f-b637d27ab11b	1709500	2020	0.744	87545	89.4	910.35	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 76.0, "taxa_conclusao_fundamental": 84.9}	{"expectativa_vida": 73.9, "cobertura_vacinal": 86.8, "mortalidade_infantil": 16.6, "leitos_por_mil_habitantes": 2.14}
a715cc84-c11b-4b7f-907a-cd8db144bb99	1709500	2021	0.747	88428	89.7	928.56	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 76.2, "taxa_conclusao_fundamental": 85.2}	{"expectativa_vida": 74.0, "cobertura_vacinal": 86.9, "mortalidade_infantil": 16.6, "leitos_por_mil_habitantes": 2.14}
6d453f7a-ad51-4382-b23f-86e9a6043a0d	1709807	2019	0.71	2015	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
4698fcd9-cf31-4361-8c23-061c8143f248	1709807	2020	0.714	2052	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
199b8daa-d365-4a3d-943c-4359cfa3b25d	1709807	2021	0.717	2088	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
34229a44-2445-45dc-bc5e-631220c26eb5	1710508	2019	0.71	7433	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
b5475f04-784c-495d-ae5e-35efa7a827d8	1710508	2020	0.714	7452	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
f2a159ce-ab3a-4cb1-b6fe-127b7416beb0	1710508	2021	0.717	7471	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
1828a6ad-111e-4ba9-9b19-b1b783ba9048	1710706	2019	0.71	5864	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
382babd4-e289-4bec-9c2a-79c191082fab	1710706	2020	0.714	5832	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
9256cc78-49aa-42a9-8c92-61fc71ffca4f	1710706	2021	0.717	5801	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
8e33e892-865a-4702-a25f-525c30720c03	1710904	2019	0.71	3777	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
247657bc-301f-443d-aecb-0afe64a709c6	1710904	2020	0.714	3795	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
182cae7e-f326-4139-bcac-5dfbc7e7a9e1	1710904	2021	0.717	3814	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
f056b818-da15-4a49-826f-f4a4efcf7f24	1711100	2019	0.71	2427	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
101d03ae-5105-4a89-ab03-a03871acf2e9	1711100	2020	0.714	2420	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
b36ae21b-6351-417e-909f-ffc412f0b5a2	1711100	2021	0.717	2412	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
07b87d52-8551-4d88-95b3-4fb560661b7f	1711506	2019	0.71	3849	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
2c0ba55a-63df-4087-a44b-d67302de52fb	1711506	2020	0.714	3878	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
de7d72da-64ea-4d63-b74f-a4146bb264c9	1711506	2021	0.717	3906	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
08d47fb9-dbf5-4209-898a-a8c54d88bcc9	1711803	2019	0.71	2193	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
ca6f322f-6a3f-4742-8262-c78b50df7291	1711803	2020	0.714	2184	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
a283a0cc-8528-4ce6-b111-2ed94e4657b1	1711803	2021	0.717	2174	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
3411bd6b-d592-4402-b9e9-67ab5d7d4348	1711902	2019	0.73	13357	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
5ccd1932-f2c5-4fd8-b404-bbd9011f8633	1711902	2020	0.734	13676	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
9e4947b2-f88c-4de6-ae01-7cc5b71c9f57	1711902	2021	0.737	13989	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
c972135c-5854-4ec0-81e4-2fe8449f1d7a	1711951	2019	0.71	4316	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
86bb7edf-97af-41ff-bf82-b26b29491cad	1711951	2020	0.714	4393	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
d86e9758-4796-4ecd-a3c7-abf2c2a1be53	1711951	2021	0.717	4470	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
bb6e9486-a02c-46b5-a7a5-4e01aa783473	1712009	2019	0.71	3134	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
c346ad55-3f90-4b57-a142-488b84012b90	1712009	2020	0.714	3167	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
bf5edfd5-5cf9-475d-bcd9-7733be5a3a3e	1712009	2021	0.717	3199	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
de7ee172-05b8-4a55-baa0-9d66a00d1c01	1720101	2020	0.714	5391	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
a19f5ee0-8b3f-43c6-93fc-b20f1645ce43	1720101	2021	0.717	5457	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
a767160c-078a-40dc-8e96-ebd0d73c27a3	1720150	2019	0.71	1585	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
e69b1d42-35fa-4889-8bd4-aa6c9d23a1af	1720150	2020	0.714	1598	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
a1de800d-ee5c-4d03-8b78-4857c19a1c1e	1720150	2021	0.717	1610	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
2fe4b9fc-cc87-463e-853b-d4d94fcf177d	1720200	2019	0.73	12139	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
77ef76c7-e4ce-41f4-9b08-f4075546de9f	1720200	2020	0.734	12294	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
c04c5921-d11f-48df-ab22-65e3f7c87179	1720200	2021	0.737	12445	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
3c0f658e-0b1d-4427-a180-795c7571d470	1720259	2019	0.71	3082	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
e1d9ccb3-0e90-4074-8fdc-3e00160e5230	1720259	2020	0.714	3094	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
b5d69413-5626-4f6c-832a-4929080ef4fc	1720259	2021	0.717	3106	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
46e5468e-2608-4b55-9bd3-66a61329d2e3	1720309	2019	0.71	4805	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
2e8a52b8-b3b4-426c-8591-5f2e44d5b9c7	1720309	2020	0.714	4852	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
c2cdbdaf-8c24-4502-a2d2-d050c85888b4	1720309	2021	0.717	4898	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
b18516a6-44e1-48e4-abc2-e9e31e87a4c7	1720499	2019	0.71	3960	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
622315a3-9664-4637-830c-21c27b30c4f9	1720499	2020	0.714	3904	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
d5759cdc-5957-49d3-ab2f-3d55a197ec0a	1720499	2021	0.717	3848	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
4d83b618-2880-4f5e-937b-f1d315fcb7ef	1720655	2019	0.71	5403	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
146c5757-45a3-4b08-b651-3a36b87519a1	1720655	2020	0.714	5428	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
971da1b2-2875-4baa-a132-f3b8fab0b14e	1720655	2021	0.717	5452	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
ff63e0a6-fe3a-4a21-a5ce-1a13970104be	1720804	2019	0.71	9029	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
ab1ceab9-cbf5-46df-b2d3-2969889cc97a	1720804	2020	0.714	8997	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
5468b78e-de8b-4c61-972c-c634778fd03b	1720804	2021	0.717	8965	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
adc9250c-762f-4570-b8e8-7c8e6eae4cde	1720853	2019	0.71	1966	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
fdb5e595-8c87-4faf-a8a6-541167573f4f	1720853	2020	0.714	1986	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
37f14692-b985-477e-a66d-0a6f8676b75e	1720853	2021	0.717	2007	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
64cb8a18-e420-4afb-b34b-cd448f587e16	1720903	2019	0.73	16683	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
7750d65a-e968-499d-9730-7492067b1911	1720903	2020	0.734	16825	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
3717b2d2-1e17-472b-8fd7-d265032f9788	1720903	2021	0.737	16966	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
7843b8f9-1207-4028-a869-fee6c10d9785	1720937	2019	0.71	2148	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
7f35de31-507c-4815-9f51-6092b033646e	1720937	2020	0.714	2166	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
19e63ba4-e44a-4118-ba92-b72d8a44d298	1720937	2021	0.717	2183	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
b33cb3aa-b302-424b-860c-5696f801bca7	1720978	2019	0.71	2793	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
2cb4ed67-d996-42bc-950f-0993ad428425	1720978	2020	0.714	2812	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
356a7f2f-bf64-410c-b6bf-c2e7e29a85d6	1720978	2021	0.717	2831	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
77cf647b-25b3-463e-a59f-179fa42c29f5	1721000	2019	0.78	299127	91.2	1105	{"ideb_anos_finais": 4.3, "ideb_anos_iniciais": 5.2, "taxa_conclusao_medio": 77.5, "taxa_conclusao_fundamental": 86.6}	{"expectativa_vida": 74.6, "cobertura_vacinal": 88.2, "mortalidade_infantil": 15.6, "leitos_por_mil_habitantes": 2.24}
9187de57-fe94-4164-9c46-38605c6bc648	1721000	2020	0.784	306296	91.4	1127.1	{"ideb_anos_finais": 4.3, "ideb_anos_iniciais": 5.2, "taxa_conclusao_medio": 77.7, "taxa_conclusao_fundamental": 86.8}	{"expectativa_vida": 74.7, "cobertura_vacinal": 88.4, "mortalidade_infantil": 15.4, "leitos_por_mil_habitantes": 2.26}
3de0c016-f2ec-4d8d-8c1b-32ec8c9facb7	1721000	2021	0.787	313349	91.5	1149.64	{"ideb_anos_finais": 4.4, "ideb_anos_iniciais": 5.2, "taxa_conclusao_medio": 77.8, "taxa_conclusao_fundamental": 86.9}	{"expectativa_vida": 74.8, "cobertura_vacinal": 88.5, "mortalidade_infantil": 15.4, "leitos_por_mil_habitantes": 2.26}
fe194ff0-e4e8-45f4-ba6f-c9328947a8d6	1721109	2019	0.71	7545	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
ee39eb6c-3602-48c8-a0c6-384d67009ef4	1721109	2020	0.714	7617	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
cf82b847-f34a-47b8-91d1-88b5735ff3f4	1721109	2021	0.717	7688	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
21f1e20f-1239-4d67-851f-850e124054c8	1721208	2019	0.73	22870	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
aae36c2a-3771-4c91-8e63-06b60548c5f7	1721208	2020	0.734	22845	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
7a9c752f-241b-418f-a393-ab1d5fd8782e	1721208	2021	0.737	22820	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
0c601d6b-3a40-4cb6-b718-cc919c6ad874	1721257	2019	0.71	1891	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
1ad61baa-d18c-4fc6-bcb0-d1a374bddb26	1721257	2020	0.714	1922	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
fd8a9589-990b-4923-801f-9ac04a12060b	1721257	2021	0.717	1952	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
62ee2c13-a6fb-4d5d-848e-c118b41e5b76	1721307	2019	0.71	2671	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
febd6635-9b87-48ac-85fe-a760cc21ef27	1721307	2020	0.714	2729	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
582825e4-3d78-4de0-8faf-614f8af4ebb4	1721307	2021	0.717	2785	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
a4a16495-12dc-4df1-9450-ff3f358e63bb	1722081	2019	0.73	11683	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
61e02baa-702e-4423-817a-dc039e52e6a9	1722081	2020	0.734	11734	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
b8d12362-09d9-4d3d-b0ea-8135eb937999	1722081	2021	0.737	11783	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
7e5e110b-77f2-4801-997e-16768c394b85	1722107	2019	0.73	11540	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
eff406fb-1d2d-4fe5-bad8-3117c9f34c7e	1722107	2020	0.734	11520	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
9dc263dd-4c95-4b05-8581-cedb3808cd65	1722107	2021	0.737	11500	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
e7aaa86c-9f74-4807-9f2c-de5a70dc85f1	1716703	2019	0.71	8205	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
9bd6c78f-b5d4-4dd2-b01b-45c157b3ac5e	1716703	2020	0.714	8141	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
05eb59b1-9b4b-4f9f-9e36-fa8ec0a18bf5	1716703	2021	0.717	8078	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
2cc37ac0-a168-42d1-a22e-1c49ec7a9ae2	1712157	2019	0.71	1923	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
0ac5e77f-101f-4645-abcc-70d49c7eb3b5	1712157	2020	0.714	1954	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
c1035884-5df1-41ec-bd1e-4f2d63bf692f	1712157	2021	0.717	1984	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
c98a80fb-0033-4c98-8b12-b994cff953c5	1712405	2019	0.71	3740	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
33474c50-7f05-46f4-bd19-dcbab30274a2	1712405	2020	0.714	3733	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
87cbe393-f87a-4d6f-a1e2-d77a7a373714	1712405	2021	0.717	3727	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
821362e7-772b-4ad3-a4b3-c836f571690f	1712454	2019	0.71	3108	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
6f08a480-2bcf-496c-8277-5f1fc15b70ba	1712454	2020	0.714	3154	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
926ff553-68e9-4785-baa4-5cf7b3ab7f02	1712454	2021	0.717	3200	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
86b57643-0d71-401e-9598-e3125e24b701	1712504	2019	0.71	5175	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
8312e257-7cb6-41cb-9f92-d63eb809be63	1712504	2020	0.714	5254	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
f90016c8-a06e-4ead-a84f-0f708a3fd81e	1712504	2021	0.717	5332	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
7821b3b6-5fb3-4568-ad34-928e325b7725	1712702	2019	0.71	2684	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
3cee57d0-416a-4fcd-a37c-d02e36641729	1712702	2020	0.714	2729	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
bd90afab-21c6-431b-aab0-b7051be02bfa	1712702	2021	0.717	2773	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
c8c98ce0-98dc-4d8e-a8d8-bb62d7e67fe8	1712801	2019	0.71	3426	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
1ba65b4d-9467-417b-b618-4b3177e8a6d1	1712801	2020	0.714	3448	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
26253db3-d5cc-4a28-aeed-449e1888f7fb	1712801	2021	0.717	3470	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
10f47dd7-e6c5-48f5-97ed-6178753d37e7	1713205	2019	0.73	18248	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
e21a889a-4dc0-46c1-8521-c4732f9da9cc	1713205	2020	0.734	17936	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
94f2d378-f91b-45a1-a28f-49d3e04d02ab	1713205	2021	0.737	17628	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
2db4730d-ec39-403c-b4e3-bd8044585c28	1713304	2019	0.73	13434	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
50104b45-9a3c-45cc-b95a-134ac14c9e85	1713304	2020	0.734	13493	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
7871443b-8246-4fa6-aa82-e1fbc4af3d33	1713304	2021	0.737	13551	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
3d7aa4dc-9a5f-43ff-b1c6-de718045b0ed	1713700	2019	0.71	2279	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
20196f2a-73e2-44f9-92e2-6526f4f1dc4e	1713700	2020	0.714	2295	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
09984b5b-509b-4d78-a797-4d4bf224e23e	1713700	2021	0.717	2311	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
eaa582ca-b944-438a-9c87-36fbb9deb0fc	1713601	2019	0.71	7947	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
4197e86d-ad04-424c-ab4d-42cb3641bc3b	1713601	2020	0.714	8066	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
002b6027-feb9-4d92-af31-15670f3bae88	1713601	2021	0.717	8182	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
142d6c04-7d7b-48f9-b6f2-4b176f7b5c90	1713957	2019	0.71	3551	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
6ccdf818-0d26-425b-b037-b589b97f79be	1713957	2020	0.714	3587	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
339a306a-62f6-4bae-8333-2b1aadec129f	1713957	2021	0.717	3623	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
7b7a7e2c-59c9-4dec-a0ec-2c587badb113	1714203	2019	0.71	9244	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
94a8440a-9759-4812-9f3f-45c0a2e8230b	1714203	2020	0.714	9250	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
6992edee-9c42-4a7f-9cfd-1fe8aad2d5bf	1714203	2021	0.717	9256	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
f75cb633-5b3b-456f-b705-2ed98629a26b	1714302	2019	0.71	3898	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
7e5b69f8-fa97-4cf2-ac12-50ee6794a83a	1714302	2020	0.714	3834	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
c5db3305-a420-4621-9fbc-a5a527442646	1714302	2021	0.717	3772	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
a04c5dde-5196-48b4-bc80-5efe1e1b4931	1714880	2019	0.73	11819	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
ab003f5b-f1be-4d83-b856-0d0512b61b3e	1714880	2020	0.734	11917	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
54ab549e-1714-44c6-a29d-b798ab802f96	1714880	2021	0.737	12014	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
b427e110-c6e3-4de2-8333-cde2e46f6c65	1715002	2019	0.71	4260	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
4522cf5e-6d4c-419c-aa38-ee5b3db072f1	1715002	2020	0.714	4304	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
a8c9391c-1f5c-41c6-a29f-269281ab626e	1715002	2021	0.717	4348	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
adab7af3-4e88-479e-9fec-d20590595614	1715101	2019	0.71	4342	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
fbe76114-a269-4131-ac4b-083326df1a5a	1715101	2020	0.714	4397	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
fa04aa25-f9bc-4077-b67d-30e6619a741e	1715101	2021	0.717	4450	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
8a85ef17-9302-4de6-a38b-cbe523da4e55	1715150	2019	0.71	2332	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
fa2d08ad-72cf-4a78-b901-5cb673134b12	1715150	2020	0.714	2332	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
3ffdcb04-3102-4159-aa82-f7f1d9130cab	1715150	2021	0.717	2332	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
0a0a5f28-c5d4-4a12-8ef6-6390b016ee0a	1715259	2019	0.71	2722	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
59f61062-5789-4fe0-b143-2199831b9c95	1715259	2020	0.714	2745	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
28f61c9d-ae7d-4c6c-a3d8-334a0a816cd5	1715259	2021	0.717	2768	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
1535707a-a51b-4413-9cbc-ff1b0eb47b6e	1715507	2019	0.71	1112	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
612478ca-56b2-4a9b-955b-653fa0b701b3	1715507	2020	0.714	1118	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
cdd696e6-bcfe-479d-bb45-312a590239a4	1715507	2021	0.717	1124	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
d58e0fc1-f556-4f04-badb-17d89376c48a	1715705	2019	0.71	6026	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
26a6a7ad-20b7-4f08-9f0a-e23a7041d2a6	1715705	2020	0.714	6131	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
95f3d893-35b6-4079-91bd-5d3dfe9356a8	1715705	2021	0.717	6234	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
d1f5db1a-adf1-431b-a215-a26d8a76bc70	1713809	2019	0.71	6658	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
6567e591-c901-4283-9b9d-fc33bfbcfbf3	1713809	2020	0.714	6745	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
52c4f435-1b93-4c06-8e2d-3e67456f7b20	1713809	2021	0.717	6830	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
5edfb20a-8f16-48f8-97b5-73ad154ed4db	1715754	2019	0.71	7659	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
4d5235e3-c3f3-495f-87bf-059a1c103fa0	1715754	2020	0.714	7676	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
e0433284-d492-40f1-b15e-7662e3c60e4f	1715754	2021	0.717	7694	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
cbf23ce7-8226-414c-819a-02fd5a48a997	1716208	2019	0.73	10449	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
004095f0-8257-4acd-aaf2-b8a729a78313	1716208	2020	0.734	10437	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
f85c7653-d43e-437e-9999-9490f93c6b31	1716208	2021	0.737	10426	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
859460f4-7c8e-4863-9b98-d62aa42f19d0	1716109	2019	0.74	51252	89	892.5	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.6, "taxa_conclusao_fundamental": 84.5}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.6, "mortalidade_infantil": 16.8, "leitos_por_mil_habitantes": 2.12}
f42ab908-ed6e-4691-9c2a-fc01915974f2	1716109	2020	0.744	51891	89.4	910.35	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 76.0, "taxa_conclusao_fundamental": 84.9}	{"expectativa_vida": 73.9, "cobertura_vacinal": 86.8, "mortalidade_infantil": 16.6, "leitos_por_mil_habitantes": 2.14}
0b3633d7-1d2e-41f9-b8b8-ee869351b9d4	1716109	2021	0.747	52521	89.7	928.56	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 76.2, "taxa_conclusao_fundamental": 85.2}	{"expectativa_vida": 74.0, "cobertura_vacinal": 86.9, "mortalidade_infantil": 16.6, "leitos_por_mil_habitantes": 2.14}
d241a05d-bc21-44ee-a0e6-e98845a4ee67	1716307	2019	0.71	4849	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
2d3552cf-1294-4d82-9191-4175174eddb7	1716307	2020	0.714	4867	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
20a06e8a-861a-4628-8e81-fc87f5abc7b2	1716307	2021	0.717	4885	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
e7dd6a4e-ed1a-4372-8d77-0ce26be74c11	1716505	2019	0.73	13578	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
33e649cf-6a92-42e9-8c68-9034e68f488a	1716505	2020	0.734	13773	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
d973c8da-2762-4a98-b34f-d538203f3e12	1716505	2021	0.737	13964	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
6514c975-9c34-4b80-aa41-3c7be57609c3	1716604	2019	0.73	11749	88	850	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 74.8, "taxa_conclusao_fundamental": 83.6}	{"expectativa_vida": 73.6, "cobertura_vacinal": 86.2, "mortalidade_infantil": 17.1, "leitos_por_mil_habitantes": 2.09}
70207b01-51ea-4dd9-a739-afed9e55ba9d	1716604	2020	0.734	11873	88.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.1, "taxa_conclusao_fundamental": 84.0}	{"expectativa_vida": 73.7, "cobertura_vacinal": 86.4, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.1}
4e5abc20-886b-4372-b168-b6c68fbfbbec	1716604	2021	0.737	11996	88.7	884.34	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.4, "taxa_conclusao_fundamental": 84.3}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.5, "mortalidade_infantil": 16.9, "leitos_por_mil_habitantes": 2.11}
ce93dd5a-484b-4a6d-80de-3b310223bff2	1716653	2019	0.71	5477	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
0f2b2011-f65b-4d55-bcc6-b29b191282dd	1716653	2020	0.714	5512	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
44de7515-4366-4924-a189-b76cd78196ad	1716653	2021	0.717	5546	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
27dbfefd-8f1f-47ed-bb7a-8514b33d8521	1717008	2019	0.71	4447	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
9dad50ef-de7a-4096-b5ab-58ae94698c54	1717008	2020	0.714	4430	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
33ff1834-8da0-4b49-be1c-cf9865640fad	1717008	2021	0.717	4414	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
ded47a37-fff9-4b46-bdf5-8198fde9ab3c	1717206	2019	0.71	3028	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
9935415a-be48-41f1-9f0e-1b08b9c6b556	1717206	2020	0.714	3033	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
9cc31821-c8c1-4833-90dd-4ee431912a71	1717206	2021	0.717	3038	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
e21c4063-e7d4-4b48-b4c0-5919d0945422	1717503	2019	0.71	7654	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
f1b8984e-c173-4aea-9d5f-9e4a63e151b0	1717503	2020	0.714	7743	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
9871bc50-0821-4bbe-860b-55d0e44e10ac	1717503	2021	0.717	7830	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
b087e361-937a-4cf1-a06d-9f9cd969afe7	1717800	2019	0.71	4596	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
5d25a667-9cc8-491b-a9a9-05e0a27bcb10	1717800	2020	0.714	4591	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
60f460a6-6ea7-4b90-bda5-b82228ec20ec	1717800	2021	0.717	4586	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
75ac1254-96b0-4675-89ba-89a16a1e4991	1717909	2019	0.71	8039	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
eb6bce9d-b49d-44ec-9303-dc4e9dd6dd42	1717909	2020	0.714	8116	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
d319a706-bf36-46fd-9c51-7a1c4939986b	1717909	2021	0.717	8192	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
b4e0bc16-2c44-45ca-aec4-0a4099603cdf	1718006	2019	0.71	3139	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
7730a2ae-a8ae-4e3d-9530-a40de9472867	1718006	2020	0.714	3170	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
354cf1cf-1fd8-4a6c-aef9-579854c2c1b2	1718006	2021	0.717	3200	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
bd72ecbf-47e4-45d7-ae45-d49beb6d6225	1718204	2019	0.74	53010	89	892.5	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 75.6, "taxa_conclusao_fundamental": 84.5}	{"expectativa_vida": 73.8, "cobertura_vacinal": 86.6, "mortalidade_infantil": 16.8, "leitos_por_mil_habitantes": 2.12}
796798ce-3718-4585-b67f-bc74eeb855fa	1718204	2020	0.744	53316	89.4	910.35	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 76.0, "taxa_conclusao_fundamental": 84.9}	{"expectativa_vida": 73.9, "cobertura_vacinal": 86.8, "mortalidade_infantil": 16.6, "leitos_por_mil_habitantes": 2.14}
9a15b176-bea1-47a6-8e55-3ffb2067f23f	1718204	2021	0.747	53618	89.7	928.56	{"ideb_anos_finais": 4.2, "ideb_anos_iniciais": 5.0, "taxa_conclusao_medio": 76.2, "taxa_conclusao_fundamental": 85.2}	{"expectativa_vida": 74.0, "cobertura_vacinal": 86.9, "mortalidade_infantil": 16.6, "leitos_por_mil_habitantes": 2.14}
46874ad2-0bbe-4a0b-bab0-6b2dbd532eed	1718303	2019	0.71	8432	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
0a90a861-4551-476c-97f4-88c078dc9799	1718303	2020	0.714	8498	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
fe271726-9831-44c4-aa51-dea0acb9d141	1718303	2021	0.717	8563	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
359546cb-0c61-4cf6-bafd-cd7aa2506578	1718402	2019	0.71	3684	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
181dac57-77d2-42f7-9898-3edf68647228	1718402	2020	0.714	3676	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
39b9f8f5-d82d-4bb6-b7b2-b0e37805c276	1718402	2021	0.717	3668	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
3eb2ba32-5d16-4e68-ac23-9d2a4307d3a0	1718451	2019	0.71	2688	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
ba3099aa-9774-4c4e-ab93-37b840b7ecd9	1718451	2020	0.714	2717	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
cc6041be-15a9-4ba4-ac7a-4712a93fad6f	1718451	2021	0.717	2746	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
ad2e8acf-2908-4883-a103-298436661c50	1718501	2019	0.71	4293	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
690838bd-2b71-4d33-90c6-b1f822c0c406	1718501	2020	0.714	4342	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
79312661-b4aa-422c-a7e3-af6e88d9ca32	1718501	2021	0.717	4389	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
15d2495e-76fa-400f-b6ed-112cdcfe909d	1718550	2020	0.714	4684	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
8ec0be4b-8f07-49fd-a439-0e12de98ac85	1718550	2021	0.717	4723	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
2eae0d92-ca5c-434b-a3ee-a561d9c5933b	1718758	2019	0.71	6478	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
6feaee63-a6fe-4308-b6c5-8d8a9c205d67	1718758	2020	0.714	6488	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
83cbef97-01b1-45ec-916a-abf85420b87c	1718758	2021	0.717	6498	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
855517e5-5abc-4574-9061-60f2b06199aa	1718659	2019	0.71	2130	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
30ea8753-054b-4b4b-9712-9cb5e62d1c74	1718659	2020	0.714	2171	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
521add28-8055-4470-950b-f8e8b133d4db	1718659	2021	0.717	2211	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
a6b00f86-119b-4041-b4d6-db5012c72683	1718709	2019	0.71	2834	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
0cb5b942-8cc9-41c5-9764-44343827e462	1718709	2020	0.714	2856	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
ad6049b7-8b5d-4c65-937d-067609f26be2	1718709	2021	0.717	2879	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
aa6a5fc4-9c90-408a-8f14-2853b5face70	1718808	2019	0.71	4711	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
370a5120-5212-4039-aa77-9797d686eaff	1718808	2020	0.714	4794	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
dfe4c04d-0974-4edc-8787-aa4799681504	1718808	2021	0.717	4876	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
6eb53812-f853-49bd-8cf1-14be06d2ec93	1718840	2019	0.71	3375	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
4cd0cfaa-dc48-4716-a370-df6a32eacfca	1718840	2020	0.714	3373	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
8468fe3f-cd33-4313-9071-4bcc3a46fe1d	1718840	2021	0.717	3371	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
aec1c334-a585-4fb2-9633-5b0f98ade6ac	1718865	2019	0.71	7512	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
78804500-4a01-4413-9b95-61c6f1320bf2	1718865	2020	0.714	7595	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
803ecf90-3409-4eb5-967e-179a8171aeff	1718865	2021	0.717	7678	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
bcf6f828-e128-4fd5-a1b7-13c90e0f0e4b	1718881	2019	0.71	3434	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
63dc12f2-3694-4a07-9dad-8f5c1f30b525	1718881	2020	0.714	3486	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
2b018139-e9f3-4f6c-b90e-b3951c5f8a46	1718881	2021	0.717	3537	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
a19869ee-5682-4d17-bcd4-6b51985c77f8	1718899	2019	0.71	2365	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
887729d5-7fa3-445b-b8fe-f1253c297132	1718899	2020	0.714	2386	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
41c9091f-bfa9-44a8-969d-227a67be4a43	1718899	2021	0.717	2407	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
761d4bbf-8ce1-4b3e-b0c1-ac86ac79f8ae	1718907	2019	0.71	4829	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
09fb7286-d96c-48b8-85ae-7de65bb1ffcf	1718907	2020	0.714	4846	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
5d87706a-132f-475a-a075-f929162fac1c	1718907	2021	0.717	4864	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
abed61cb-4d76-4c19-8975-cdfdc2865b06	1719004	2019	0.71	2866	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
493ea25c-8492-413f-8a91-63a8b900854e	1719004	2020	0.714	2897	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
dec908b1-0864-4dbe-9b24-d55e0c1d6bf5	1719004	2021	0.717	2928	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
bfa35ee9-75ab-4c7f-9367-bbf4ca6c434a	1720002	2019	0.71	2529	86	850	{"ideb_anos_finais": 4.0, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.1, "taxa_conclusao_fundamental": 81.7}	{"expectativa_vida": 73.2, "cobertura_vacinal": 85.4, "mortalidade_infantil": 17.7, "leitos_por_mil_habitantes": 2.03}
f561d2ce-42d9-45dc-bdd3-1c2c3051144d	1720002	2020	0.714	2530	86.4	867	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.4, "taxa_conclusao_fundamental": 82.1}	{"expectativa_vida": 73.3, "cobertura_vacinal": 85.6, "mortalidade_infantil": 17.6, "leitos_por_mil_habitantes": 2.04}
5aabe6ac-b86f-420b-a9cf-38570889c904	1720002	2021	0.717	2530	86.7	884.34	{"ideb_anos_finais": 4.1, "ideb_anos_iniciais": 4.9, "taxa_conclusao_medio": 73.7, "taxa_conclusao_fundamental": 82.4}	{"expectativa_vida": 73.4, "cobertura_vacinal": 85.7, "mortalidade_infantil": 17.5, "leitos_por_mil_habitantes": 2.05}
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: cloud_admin
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: territorial_indicators; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.territorial_indicators (id, territory_id, year, urbanized_area, density, sanitation_coverage, land_use) FROM stdin;
8f4ec256-0361-4809-83e1-be03a2ee854b	17	2019	64	108.23	90.3	{"agricultura": 44.3, "pecuaria": 13.5, "florestal": 18.5, "urbano": 3.3, "outros": 2.8}
1ba47c55-5e04-4a95-88c7-205d2a9f2c8e	17	2020	55.4	154.46	65.6	{"agricultura": 58.5, "pecuaria": 26.1, "florestal": 23.1, "urbano": 7.0, "outros": 2.4}
b5bf629d-a6d9-4c2f-b5c0-28fc9202cc03	17	2021	74.3	189.66	37.6	{"agricultura": 47.8, "pecuaria": 38.3, "florestal": 34.0, "urbano": 6.1, "outros": 9.9}
539453e8-5749-4864-a4f6-b91d64f31f83	17	2022	85.7	25.09	36.8	{"agricultura": 25.8, "pecuaria": 38.1, "florestal": 21.7, "urbano": 11.6, "outros": 7.8}
1c615116-23fe-4848-80cd-c001ce347f10	17	2023	35.2	138.87	46.7	{"agricultura": 48.7, "pecuaria": 24.6, "florestal": 40.4, "urbano": 12.5, "outros": 2.4}
29c4d0a9-0934-42dc-8948-9d1f72c2a954	1700251	2019	16.5	166.82	79.2	{"agricultura": 51.3, "pecuaria": 29.8, "florestal": 23.3, "urbano": 4.3, "outros": 3.2}
a5f9a45f-c796-4518-b2af-7c4c3b7e1a9d	1700251	2020	80	119.36	79.7	{"agricultura": 49.1, "pecuaria": 16.3, "florestal": 20.0, "urbano": 6.0, "outros": 7.7}
d7c3f0d6-f463-4da2-93f8-355aa4c52074	1700251	2021	80.8	7.58	40.7	{"agricultura": 35.8, "pecuaria": 34.8, "florestal": 44.4, "urbano": 4.5, "outros": 5.6}
05a2e74a-1bf4-4937-ab46-f9a1207d8343	1700251	2022	15.2	24.33	71.3	{"agricultura": 48.7, "pecuaria": 26.6, "florestal": 22.3, "urbano": 6.1, "outros": 4.4}
4da20a11-098b-4e29-b915-1706dfde61cc	1700251	2023	16.1	105.55	42.2	{"agricultura": 31.0, "pecuaria": 17.5, "florestal": 26.8, "urbano": 8.0, "outros": 7.7}
758a75df-3357-49cc-a8ca-8e88c956870e	1700301	2019	47.2	51.83	37.9	{"agricultura": 39.7, "pecuaria": 33.6, "florestal": 41.1, "urbano": 4.1, "outros": 8.4}
9121058c-1c5c-4898-8b88-a4d1e96d1dfb	1700301	2020	30.8	86.03	38.9	{"agricultura": 54.9, "pecuaria": 37.2, "florestal": 22.1, "urbano": 3.2, "outros": 1.8}
fbbe2f8d-f71a-477b-a165-d166a803fb0c	1700301	2021	11.4	166.24	82.6	{"agricultura": 32.5, "pecuaria": 21.2, "florestal": 26.2, "urbano": 11.9, "outros": 2.8}
3ee1ce9b-930f-4ab2-bed5-d2467dc5b733	1700301	2022	54.1	73.42	54.8	{"agricultura": 48.2, "pecuaria": 18.0, "florestal": 28.2, "urbano": 10.2, "outros": 9.6}
1b918b38-5c90-4a37-9492-a51bd251d13f	1700301	2023	24.6	159.87	39.8	{"agricultura": 55.0, "pecuaria": 17.0, "florestal": 17.4, "urbano": 2.5, "outros": 2.8}
c0f12218-280d-4e46-afde-b47d4626ddc1	1700350	2019	14.4	28.79	70.1	{"agricultura": 50.1, "pecuaria": 35.5, "florestal": 44.9, "urbano": 12.2, "outros": 4.2}
546bb96a-33f2-4321-9aed-354dc447d042	1700350	2020	27	157.16	40.4	{"agricultura": 44.7, "pecuaria": 13.8, "florestal": 29.6, "urbano": 6.6, "outros": 4.7}
1a7096c5-3d88-434c-a4a0-069133bb5288	1700350	2021	69.8	99.13	51.6	{"agricultura": 42.6, "pecuaria": 38.6, "florestal": 26.5, "urbano": 9.0, "outros": 3.3}
75f5e358-da00-4655-af22-e3219b16ad5e	1700350	2022	50.8	30.26	63.5	{"agricultura": 37.6, "pecuaria": 11.1, "florestal": 26.9, "urbano": 3.7, "outros": 2.1}
93a5e9f7-1c28-4fd1-bcdf-22f04f133733	1700350	2023	68.5	11.44	66.2	{"agricultura": 52.2, "pecuaria": 36.7, "florestal": 16.2, "urbano": 13.0, "outros": 7.9}
4c9cdd39-d6d9-4d1d-99af-90d6f011d814	1700400	2019	38.3	4.8	48.9	{"agricultura": 47.7, "pecuaria": 32.0, "florestal": 29.3, "urbano": 11.7, "outros": 2.2}
06a79225-9f11-4057-b349-15185a54f481	1700400	2020	54.7	46.82	38.2	{"agricultura": 36.3, "pecuaria": 24.5, "florestal": 25.2, "urbano": 2.9, "outros": 3.2}
c4826e60-40c7-4ce9-a4f8-9f603eb45249	1700400	2021	11.8	152.38	93.1	{"agricultura": 58.2, "pecuaria": 24.6, "florestal": 48.3, "urbano": 4.1, "outros": 5.8}
229755d1-3c35-4277-8602-974d6b8222e4	1700400	2022	52.6	58.75	88.3	{"agricultura": 32.6, "pecuaria": 20.3, "florestal": 25.3, "urbano": 10.3, "outros": 6.9}
58306dd1-6789-4175-a2f3-492c30e60977	1700400	2023	50.9	37.33	74.4	{"agricultura": 38.9, "pecuaria": 21.8, "florestal": 43.7, "urbano": 12.0, "outros": 4.8}
9463158e-c703-4f79-b79e-1858114f3176	1700707	2019	57.7	53.55	74.3	{"agricultura": 36.2, "pecuaria": 28.5, "florestal": 43.6, "urbano": 6.0, "outros": 4.6}
67535b26-3485-4163-9bca-b86d14cc1dd7	1700707	2020	15.1	64.56	38.4	{"agricultura": 48.7, "pecuaria": 14.2, "florestal": 19.9, "urbano": 4.1, "outros": 7.4}
546fec2b-9532-46fb-b357-a62d64fab9b2	1700707	2021	54.2	112.3	38.1	{"agricultura": 27.1, "pecuaria": 30.7, "florestal": 49.1, "urbano": 7.6, "outros": 9.7}
5cb5728f-33d1-4968-891c-0526608366d3	1700707	2022	85.9	96.91	58.5	{"agricultura": 54.2, "pecuaria": 33.0, "florestal": 37.1, "urbano": 4.2, "outros": 3.8}
e4b3f164-908e-483d-a044-4a1df3a020b8	1700707	2023	64.8	89.99	93.1	{"agricultura": 30.9, "pecuaria": 24.7, "florestal": 44.6, "urbano": 5.0, "outros": 6.4}
11303a55-9429-4f17-bb5a-b2161cfd0fa7	1701002	2019	53.9	7.34	87.7	{"agricultura": 47.4, "pecuaria": 25.9, "florestal": 26.5, "urbano": 4.8, "outros": 5.0}
6c8d4a9d-e86a-4a8d-b5a7-af675b5aa52e	1701002	2020	60.9	168.54	49.8	{"agricultura": 38.5, "pecuaria": 15.7, "florestal": 44.8, "urbano": 7.2, "outros": 5.5}
4adc790c-e9a2-48cc-8fbd-17bf8342a180	1701002	2021	16.7	88.68	75.4	{"agricultura": 41.0, "pecuaria": 37.2, "florestal": 36.3, "urbano": 14.4, "outros": 3.6}
2552b4a4-246a-4b8c-b849-66469d6e3d15	1701002	2022	15	138.54	68.3	{"agricultura": 46.4, "pecuaria": 39.4, "florestal": 39.0, "urbano": 14.1, "outros": 4.5}
35b94718-cbd3-419b-beda-5204fdfc5a09	1701002	2023	10.9	56.09	44.2	{"agricultura": 33.8, "pecuaria": 28.9, "florestal": 34.9, "urbano": 4.4, "outros": 7.4}
ceb16aa4-cca5-4c6f-a60c-9d677ccc377d	1701051	2019	22.1	63.99	63.7	{"agricultura": 46.9, "pecuaria": 30.2, "florestal": 44.4, "urbano": 13.0, "outros": 6.2}
a8fc6dec-8a80-448d-b583-935bb1780155	1701051	2020	65.2	167.35	93.2	{"agricultura": 30.7, "pecuaria": 17.1, "florestal": 19.6, "urbano": 8.0, "outros": 9.1}
aa32c888-d069-4cd7-b337-3c263ac13209	1701051	2021	59.1	161.21	40.1	{"agricultura": 23.0, "pecuaria": 13.3, "florestal": 31.1, "urbano": 11.4, "outros": 3.9}
cf13fbb4-ec59-4227-a4ef-698ac9f19f24	1701051	2022	25.8	179.5	49.1	{"agricultura": 56.2, "pecuaria": 20.4, "florestal": 28.8, "urbano": 6.5, "outros": 9.9}
c232d52d-512d-4af3-8583-e58de9200a1f	1701051	2023	46.4	122.14	43.3	{"agricultura": 35.6, "pecuaria": 32.7, "florestal": 17.4, "urbano": 7.2, "outros": 7.9}
64753181-4d6e-4901-adbb-83a97f498224	1701101	2019	11.7	187.27	56	{"agricultura": 29.8, "pecuaria": 36.4, "florestal": 45.0, "urbano": 5.1, "outros": 6.1}
7cbd76d0-0913-4e70-8e5f-57c45a2d207b	1701101	2020	7.8	42.01	61.8	{"agricultura": 21.0, "pecuaria": 34.5, "florestal": 22.7, "urbano": 6.8, "outros": 7.2}
a79d2edf-034e-4515-a30d-fc62172a1a76	1701101	2021	75.6	140.62	55.8	{"agricultura": 51.2, "pecuaria": 27.9, "florestal": 22.4, "urbano": 3.8, "outros": 8.6}
1b0ffd46-b35f-4429-a490-5d4cc5d74364	1701101	2022	8.8	124.19	81.8	{"agricultura": 47.0, "pecuaria": 37.1, "florestal": 26.4, "urbano": 12.3, "outros": 2.9}
24d2ad01-8fe2-48f0-8904-8236b88d909e	1701101	2023	84.3	138.47	85.9	{"agricultura": 22.8, "pecuaria": 23.2, "florestal": 48.5, "urbano": 14.0, "outros": 1.0}
588ef853-ff20-47ea-b5a5-bd6e3bdb6d93	1701309	2019	28.6	35.25	40.1	{"agricultura": 43.7, "pecuaria": 11.5, "florestal": 16.4, "urbano": 4.7, "outros": 5.8}
1928f5dc-b533-4b60-b51d-65c9097034d0	1701309	2020	58.9	28.48	59.1	{"agricultura": 33.5, "pecuaria": 16.3, "florestal": 15.6, "urbano": 6.7, "outros": 8.7}
1c44b38a-5e6f-4127-b087-a6784089131b	1701309	2021	55.4	6.97	56.1	{"agricultura": 31.7, "pecuaria": 28.2, "florestal": 24.2, "urbano": 9.4, "outros": 1.8}
477a794a-d2fb-4fbd-b470-0166c0fcae64	1701309	2022	41.9	161.86	91.7	{"agricultura": 25.8, "pecuaria": 14.5, "florestal": 17.4, "urbano": 6.3, "outros": 7.1}
5acaf612-6fdc-493e-9431-360837037fc5	1701309	2023	65.3	71.76	67.4	{"agricultura": 25.1, "pecuaria": 30.5, "florestal": 23.0, "urbano": 14.5, "outros": 5.9}
39893933-0172-4915-badc-7c9f1cc95edf	1701903	2019	52.4	1.37	47.3	{"agricultura": 51.3, "pecuaria": 36.5, "florestal": 40.7, "urbano": 7.8, "outros": 7.6}
e5955a22-1ac2-4e13-8868-f3bd2f942464	1701903	2020	78.3	153.81	75.5	{"agricultura": 51.8, "pecuaria": 36.1, "florestal": 21.0, "urbano": 4.1, "outros": 9.5}
3a8a842c-ce75-429b-9db5-088ce61d30bc	1701903	2021	13.7	67.19	42.3	{"agricultura": 48.7, "pecuaria": 33.6, "florestal": 21.5, "urbano": 7.1, "outros": 2.4}
9a938ee2-afdc-428b-a3c2-7d1d0519649a	1701903	2022	86.9	106.4	36.9	{"agricultura": 40.8, "pecuaria": 18.5, "florestal": 42.6, "urbano": 4.1, "outros": 3.6}
1535f05a-e0d4-4209-bdb2-5ccfb06b8398	1701903	2023	5.7	60.45	61.3	{"agricultura": 26.2, "pecuaria": 34.4, "florestal": 16.0, "urbano": 9.9, "outros": 2.8}
a1198eed-a6cc-48ed-a53d-39683a4fddbb	1702000	2019	23.8	99.79	53.3	{"agricultura": 46.5, "pecuaria": 21.8, "florestal": 46.2, "urbano": 12.0, "outros": 9.2}
092047ea-e811-46f9-9c05-4c85366b49e6	1702000	2020	84.4	24.07	88.9	{"agricultura": 23.0, "pecuaria": 29.0, "florestal": 49.6, "urbano": 10.0, "outros": 9.7}
6b959764-f7ca-4267-b940-ba7f219b98cd	1702000	2021	29.1	38.78	92.5	{"agricultura": 28.4, "pecuaria": 34.0, "florestal": 18.7, "urbano": 9.4, "outros": 5.0}
42007345-b114-4d50-9684-25b32d731b3f	1702000	2022	9	9.6	85.3	{"agricultura": 33.0, "pecuaria": 10.4, "florestal": 45.2, "urbano": 13.6, "outros": 1.9}
d1262a44-114a-4e29-9e59-c1d82b78052c	1702000	2023	10.2	172.63	87.5	{"agricultura": 50.0, "pecuaria": 11.5, "florestal": 28.4, "urbano": 7.8, "outros": 2.6}
dc1f3d1f-d066-4030-9274-e64f27ff2fd0	1702109	2019	82.2	164.68	47.1	{"agricultura": 24.0, "pecuaria": 39.0, "florestal": 27.9, "urbano": 7.5, "outros": 9.9}
b437e569-26ca-4c9a-8a6e-2e70eeb2ca91	1702109	2020	78.8	162.22	51.8	{"agricultura": 43.9, "pecuaria": 27.7, "florestal": 35.5, "urbano": 14.4, "outros": 2.1}
de5492a3-caea-4b00-aca1-f18deb9629ff	1702109	2021	45.7	79.86	37.9	{"agricultura": 48.0, "pecuaria": 23.4, "florestal": 33.3, "urbano": 12.4, "outros": 9.8}
f73e70af-17b4-4adf-901d-8ab5724677db	1702109	2022	72.4	108.06	93.4	{"agricultura": 30.1, "pecuaria": 19.6, "florestal": 27.9, "urbano": 8.7, "outros": 4.1}
dc8446dc-429c-4864-b2fd-487b9f9f7c22	1702109	2023	33.2	19.04	71.2	{"agricultura": 47.7, "pecuaria": 35.2, "florestal": 24.4, "urbano": 12.4, "outros": 7.9}
efdc61ae-4499-4446-84e8-4230e961ae77	1702158	2019	86.3	35.18	68.2	{"agricultura": 57.3, "pecuaria": 27.4, "florestal": 31.9, "urbano": 3.5, "outros": 6.7}
4e060264-7564-4bca-aac0-dd51ee889a13	1702158	2020	92.6	142.12	88.9	{"agricultura": 40.1, "pecuaria": 14.7, "florestal": 36.4, "urbano": 14.9, "outros": 2.3}
cd10271e-98c0-476b-b9df-7750c4565a34	1702158	2021	55.7	141.56	66.8	{"agricultura": 35.5, "pecuaria": 10.8, "florestal": 23.5, "urbano": 10.1, "outros": 5.3}
e2bf00d4-69a6-43ca-a705-71201b45a303	1702158	2022	22.8	120.89	60.8	{"agricultura": 43.6, "pecuaria": 33.6, "florestal": 16.3, "urbano": 13.5, "outros": 6.1}
366d8178-a220-4154-97f8-f38667136d92	1702158	2023	63.6	10.42	61	{"agricultura": 29.0, "pecuaria": 28.0, "florestal": 47.2, "urbano": 12.7, "outros": 5.8}
aaec1480-04c1-4280-bcbb-e2e2fe2a3497	1702208	2019	27.9	55.07	61.4	{"agricultura": 55.2, "pecuaria": 24.6, "florestal": 38.5, "urbano": 2.2, "outros": 6.0}
23b67b82-29cd-42a5-b0b0-24c08dee1a59	1702208	2020	9.5	152.17	68.5	{"agricultura": 37.2, "pecuaria": 10.8, "florestal": 19.9, "urbano": 10.1, "outros": 2.4}
1ed8146c-87f1-47e3-865c-01b3c9e50449	1702208	2021	54.3	48.96	81.1	{"agricultura": 53.7, "pecuaria": 15.6, "florestal": 43.4, "urbano": 9.0, "outros": 7.5}
e3382559-3ebd-4085-be93-714e0ce1af1a	1702208	2022	94.8	41.87	37.5	{"agricultura": 52.9, "pecuaria": 20.2, "florestal": 18.5, "urbano": 14.6, "outros": 6.2}
21b77aee-0f64-4f7d-b3ab-f2e631288639	1702208	2023	10.1	72.59	54.3	{"agricultura": 40.2, "pecuaria": 38.9, "florestal": 20.8, "urbano": 9.4, "outros": 6.3}
59f8ebd8-9487-4931-a1ee-9a550da9441f	1702307	2019	83.3	105.9	66	{"agricultura": 37.9, "pecuaria": 14.0, "florestal": 42.8, "urbano": 9.3, "outros": 8.1}
f2f37bbd-723f-425b-a9f3-0674266c1bf6	1702307	2020	48.4	52.41	72.6	{"agricultura": 27.8, "pecuaria": 10.2, "florestal": 33.3, "urbano": 8.9, "outros": 1.8}
a06f9a33-3621-42fd-a46a-3ca6528825d3	1702307	2021	15.1	43.17	73.5	{"agricultura": 52.6, "pecuaria": 14.4, "florestal": 19.5, "urbano": 11.9, "outros": 1.8}
73f5f0d6-0137-46ee-ad10-fca092e7ae9c	1702307	2022	73.3	160.54	71.7	{"agricultura": 57.4, "pecuaria": 25.0, "florestal": 16.5, "urbano": 9.9, "outros": 6.0}
03f0afeb-716a-4dc7-b590-f20d347cf5b3	1702307	2023	70.9	51.29	77.3	{"agricultura": 44.5, "pecuaria": 13.6, "florestal": 48.3, "urbano": 6.9, "outros": 4.4}
2131373d-cabf-4714-b0ac-9788ecd6ea8e	1702406	2019	30	176.76	83.7	{"agricultura": 46.0, "pecuaria": 27.7, "florestal": 28.8, "urbano": 7.0, "outros": 4.1}
7e9c6db2-d601-42cf-b1c3-6d3464ddee42	1702406	2020	52.9	176.59	45.9	{"agricultura": 33.0, "pecuaria": 22.7, "florestal": 49.1, "urbano": 4.3, "outros": 9.8}
8312618c-dc6e-4b35-8c71-54b348976ae4	1702406	2021	63.7	150.39	79.9	{"agricultura": 33.7, "pecuaria": 17.6, "florestal": 37.5, "urbano": 6.0, "outros": 6.3}
cf35f5c7-cefe-4e8c-8783-3a261c4f23dd	1702406	2022	63.4	35.25	63	{"agricultura": 48.6, "pecuaria": 38.3, "florestal": 22.9, "urbano": 8.2, "outros": 8.7}
f39e2065-1a61-46b2-aef0-9ebd120aa0d4	1702406	2023	73.3	74.36	51.7	{"agricultura": 20.1, "pecuaria": 37.1, "florestal": 20.6, "urbano": 4.4, "outros": 3.0}
010bf029-d1ca-40fe-840c-7567b6ca0f53	1702554	2019	75	105.6	36.5	{"agricultura": 40.1, "pecuaria": 34.2, "florestal": 45.6, "urbano": 3.9, "outros": 6.4}
e35c39e5-6eb2-4fdc-8aef-ae239a938660	1702554	2020	73.1	127.5	71.2	{"agricultura": 54.3, "pecuaria": 38.3, "florestal": 19.0, "urbano": 9.6, "outros": 9.0}
29d5e1b5-e232-43c2-97be-353af9aa0f87	1702554	2021	79.9	89.39	41.3	{"agricultura": 48.2, "pecuaria": 11.6, "florestal": 17.5, "urbano": 11.1, "outros": 7.8}
e6ca9c64-8e90-44ba-a541-457bc4e3c1c0	1702554	2022	44.2	51.53	35.2	{"agricultura": 42.8, "pecuaria": 33.4, "florestal": 30.0, "urbano": 2.4, "outros": 2.9}
50d3936f-8c3f-4872-954c-e2ac9f98e86c	1702554	2023	54.2	121.98	69.2	{"agricultura": 33.9, "pecuaria": 30.9, "florestal": 48.8, "urbano": 7.7, "outros": 5.4}
967cf3d1-8eb7-4d14-940a-97476fbf8a7f	1702703	2019	10.1	42.92	40.7	{"agricultura": 23.1, "pecuaria": 32.4, "florestal": 18.2, "urbano": 10.0, "outros": 7.6}
b4910ca6-592a-406e-a59b-e2eec4e65c47	1702703	2020	7.1	83.38	56.2	{"agricultura": 46.6, "pecuaria": 27.4, "florestal": 17.3, "urbano": 6.7, "outros": 6.1}
df4ac755-f424-4102-b5c2-2d894cae97b5	1702703	2021	65.9	48.77	52	{"agricultura": 51.1, "pecuaria": 11.2, "florestal": 46.6, "urbano": 2.5, "outros": 9.8}
d4f9663a-7c94-42ae-bf5a-42562df9f27c	1702703	2022	35.4	121.37	94.9	{"agricultura": 51.5, "pecuaria": 16.7, "florestal": 20.6, "urbano": 9.1, "outros": 3.0}
a00563f8-de3e-4d46-9385-f8fc53c918c7	1702703	2023	40.6	132.65	45	{"agricultura": 26.5, "pecuaria": 23.1, "florestal": 39.2, "urbano": 8.4, "outros": 4.8}
87793687-dc13-458c-9d8d-49eea0648615	1702901	2019	66.1	82.13	84.4	{"agricultura": 28.4, "pecuaria": 30.6, "florestal": 37.1, "urbano": 11.7, "outros": 8.2}
0a67c829-688d-45bd-b7be-96aa94196ffe	1702901	2020	79.7	95.64	84.2	{"agricultura": 36.4, "pecuaria": 23.9, "florestal": 26.4, "urbano": 3.3, "outros": 1.4}
1bf089f8-fbbb-4c32-9199-36be20505579	1702901	2021	8.3	130.75	78.9	{"agricultura": 48.9, "pecuaria": 26.1, "florestal": 17.7, "urbano": 2.7, "outros": 5.9}
869c0433-1f49-4dc4-b3f0-2eefefbb1ebc	1702901	2022	78.6	84.01	41	{"agricultura": 49.3, "pecuaria": 39.9, "florestal": 25.6, "urbano": 9.3, "outros": 3.9}
69a97dea-014b-4385-b486-4f453fa6c76a	1702901	2023	69.7	122.01	85.7	{"agricultura": 39.6, "pecuaria": 36.3, "florestal": 47.5, "urbano": 3.0, "outros": 8.4}
bd19ab30-2b30-4d3b-a739-fcc6dddea907	1703008	2019	45.1	109.85	49.1	{"agricultura": 48.8, "pecuaria": 37.5, "florestal": 18.0, "urbano": 13.0, "outros": 5.1}
f44e1d1f-5664-46dc-9a87-f35fdcd8efc5	1703008	2020	64.9	178.64	88.3	{"agricultura": 52.1, "pecuaria": 12.0, "florestal": 34.5, "urbano": 4.3, "outros": 6.3}
188203be-0121-40da-a806-87fd0461ec92	1703008	2021	18.1	75.57	50.7	{"agricultura": 55.4, "pecuaria": 31.4, "florestal": 15.9, "urbano": 11.5, "outros": 1.0}
13490444-9658-4116-ab77-d0735772c822	1703008	2022	90.1	48.95	36.5	{"agricultura": 40.5, "pecuaria": 39.2, "florestal": 32.3, "urbano": 6.0, "outros": 9.5}
31f0b2f0-b2e8-494e-bfc7-9bb464c7c809	1703008	2023	86.5	30.19	89	{"agricultura": 24.5, "pecuaria": 38.8, "florestal": 46.7, "urbano": 4.2, "outros": 3.5}
262c3fdb-305c-46e0-9373-4e9e4ab4dd44	1703057	2019	42.4	136.84	88.8	{"agricultura": 54.6, "pecuaria": 18.0, "florestal": 32.5, "urbano": 7.7, "outros": 3.7}
b37a9f64-f11d-48d4-9e36-03a42cfbc764	1703057	2020	75.3	42.54	36.7	{"agricultura": 53.9, "pecuaria": 28.8, "florestal": 26.3, "urbano": 14.4, "outros": 2.6}
6a1b9003-a05a-42ef-a894-f2e5ba6a4af8	1703057	2021	5	159.32	54.6	{"agricultura": 40.0, "pecuaria": 10.8, "florestal": 35.5, "urbano": 4.6, "outros": 4.8}
cbbc50b3-ba8f-40c9-b0a8-70769783f926	1703057	2022	42.3	189.56	82.9	{"agricultura": 31.5, "pecuaria": 29.1, "florestal": 46.2, "urbano": 13.5, "outros": 7.4}
95713715-53ac-429e-952e-190c82c27a38	1703057	2023	29.8	175.9	65.5	{"agricultura": 36.9, "pecuaria": 36.2, "florestal": 23.2, "urbano": 11.4, "outros": 9.8}
978e725e-c6a2-453d-ac25-7c5b0423333a	1703073	2019	59.5	72.91	69.3	{"agricultura": 53.9, "pecuaria": 38.1, "florestal": 42.6, "urbano": 6.6, "outros": 3.9}
3f0fd974-6003-4168-82cc-c49ad3a795f7	1703073	2020	10.9	1.66	40.7	{"agricultura": 29.2, "pecuaria": 23.1, "florestal": 32.4, "urbano": 11.1, "outros": 4.6}
1c6b3a14-24cd-416b-8b7c-b550e7185acc	1703073	2021	77.3	38.96	64.4	{"agricultura": 35.3, "pecuaria": 32.7, "florestal": 38.4, "urbano": 13.7, "outros": 5.1}
67d4f49a-eea2-448c-9b7f-cb0b1e4977f3	1703073	2022	18.7	69.55	67.7	{"agricultura": 49.8, "pecuaria": 15.3, "florestal": 30.2, "urbano": 6.3, "outros": 5.5}
9f732b77-46f2-4638-9d39-ede778f0eba2	1703073	2023	77.7	105.96	58.7	{"agricultura": 40.8, "pecuaria": 12.5, "florestal": 24.9, "urbano": 8.3, "outros": 5.8}
dc1e8c6f-8367-46f2-8b49-574e17e9aaa5	1703107	2019	5.5	18.09	73.8	{"agricultura": 58.1, "pecuaria": 35.2, "florestal": 45.6, "urbano": 11.2, "outros": 8.0}
c7d0c02e-03d2-4f1c-8959-2a4e25b2894c	1703107	2020	12.9	95.31	60.5	{"agricultura": 25.5, "pecuaria": 12.5, "florestal": 27.8, "urbano": 6.2, "outros": 6.6}
a2e8ae92-36a7-4160-89bc-3fd6db44e216	1703107	2021	34.4	68.91	82.1	{"agricultura": 54.6, "pecuaria": 24.9, "florestal": 31.2, "urbano": 3.5, "outros": 2.7}
7b559575-e7c5-4cd2-bedf-4a79cc15f122	1703107	2022	47.1	140.19	66.2	{"agricultura": 51.7, "pecuaria": 21.3, "florestal": 43.6, "urbano": 3.1, "outros": 6.4}
a3a7b447-cc25-41b2-af13-9fe642080a38	1703107	2023	62.3	30.39	75.3	{"agricultura": 35.7, "pecuaria": 26.2, "florestal": 39.5, "urbano": 3.5, "outros": 9.1}
4b95de72-6dc6-4046-8785-7ac80deb6b0e	1703206	2019	16.1	20.37	69.5	{"agricultura": 21.2, "pecuaria": 20.6, "florestal": 22.7, "urbano": 3.0, "outros": 9.2}
2c665a01-aa18-4708-9a25-28d0d5dabf2a	1703206	2020	37.8	18.87	59	{"agricultura": 55.4, "pecuaria": 21.8, "florestal": 18.7, "urbano": 6.1, "outros": 8.3}
70ce2b1b-401d-4544-86d9-100a17c5a579	1703206	2021	37.4	159.57	69.5	{"agricultura": 58.4, "pecuaria": 36.0, "florestal": 36.6, "urbano": 8.4, "outros": 6.3}
c1314534-f68e-484d-85a0-76f29a545bad	1703206	2022	15.3	49.41	61.7	{"agricultura": 41.6, "pecuaria": 14.2, "florestal": 16.2, "urbano": 13.9, "outros": 4.6}
ae25e9a4-53ed-4382-9ea3-6f01b2037da8	1703206	2023	66.2	117.2	90	{"agricultura": 46.6, "pecuaria": 34.4, "florestal": 18.2, "urbano": 12.6, "outros": 7.5}
dc4a61cb-2691-4494-8321-b1436f3481c6	1703305	2019	22.4	3.38	55.8	{"agricultura": 44.5, "pecuaria": 37.9, "florestal": 32.2, "urbano": 7.1, "outros": 7.3}
97da6562-b3af-40a9-b257-886b5554e19b	1703305	2020	40	122.94	74.7	{"agricultura": 45.8, "pecuaria": 36.2, "florestal": 25.9, "urbano": 13.0, "outros": 6.0}
c01210c8-cd83-4ed8-a42c-040a0130404b	1703305	2021	59.8	170.51	89.1	{"agricultura": 46.5, "pecuaria": 19.4, "florestal": 30.1, "urbano": 4.3, "outros": 9.2}
722055eb-3f11-4405-86f0-03d615187eab	1703305	2022	14.5	97.47	44.4	{"agricultura": 59.2, "pecuaria": 27.2, "florestal": 37.4, "urbano": 13.7, "outros": 7.0}
66b799b4-b93b-42f9-ac84-dd6f9ab1efda	1703305	2023	54.6	28.39	72.2	{"agricultura": 44.7, "pecuaria": 16.1, "florestal": 30.2, "urbano": 4.3, "outros": 8.8}
6b7e4f0c-2448-4bfa-8231-98bcd4ab9fd6	1703602	2019	49.8	5.58	42	{"agricultura": 40.7, "pecuaria": 16.3, "florestal": 46.9, "urbano": 10.4, "outros": 7.4}
9fa2b50e-64eb-4bf2-8c48-e7a62b4e5e57	1703602	2020	64.5	159.61	80	{"agricultura": 59.3, "pecuaria": 24.9, "florestal": 38.7, "urbano": 8.9, "outros": 2.4}
3fe1c4f9-9a0d-45eb-8e4a-8146bdc6d50e	1703602	2021	83.1	118.47	53.6	{"agricultura": 58.0, "pecuaria": 12.6, "florestal": 18.2, "urbano": 5.2, "outros": 2.4}
a42ea375-f5c0-42bc-815e-00e2c9019710	1703602	2022	56.4	89.07	69.7	{"agricultura": 52.7, "pecuaria": 33.3, "florestal": 36.4, "urbano": 7.3, "outros": 6.9}
fafb22aa-228f-4047-80dd-8b0e3e2e0e76	1703602	2023	8.1	139.81	71.7	{"agricultura": 58.9, "pecuaria": 21.4, "florestal": 20.3, "urbano": 9.6, "outros": 2.2}
6f8ec682-7e7b-4faa-b143-0dface6c294f	1703701	2019	74.4	15.5	90.9	{"agricultura": 21.5, "pecuaria": 38.5, "florestal": 27.4, "urbano": 2.4, "outros": 8.2}
3cb83ce5-ecb1-4998-bad9-f61c41504ba0	1703701	2020	17	61.46	50.8	{"agricultura": 54.9, "pecuaria": 28.3, "florestal": 48.1, "urbano": 5.3, "outros": 9.4}
cdc213a9-494d-4705-95ec-a61fd5adf72c	1703701	2021	28.8	187.05	64.4	{"agricultura": 30.0, "pecuaria": 25.8, "florestal": 16.3, "urbano": 7.8, "outros": 4.5}
35b1545a-26ab-448c-9770-3c1e24c77431	1703701	2022	56	165.91	43.6	{"agricultura": 48.2, "pecuaria": 17.5, "florestal": 42.2, "urbano": 4.8, "outros": 4.4}
7ac3cc20-fa69-464d-ad8a-bb0e895e1491	1703701	2023	44.8	124.29	51	{"agricultura": 45.8, "pecuaria": 10.1, "florestal": 29.3, "urbano": 3.0, "outros": 1.4}
b364d602-efe0-4013-b038-bfb81172d224	1703800	2019	24.6	86.2	49.7	{"agricultura": 42.1, "pecuaria": 20.2, "florestal": 46.9, "urbano": 6.0, "outros": 4.2}
c5da59d8-4dd7-47fd-8d06-e47b3b30d10d	1703800	2020	31.6	91.34	53.5	{"agricultura": 55.1, "pecuaria": 15.4, "florestal": 21.1, "urbano": 8.5, "outros": 8.1}
8cc26485-5cf8-47f1-ab34-2c948b4e019a	1703800	2021	24	12.05	47.9	{"agricultura": 48.2, "pecuaria": 35.3, "florestal": 43.4, "urbano": 10.3, "outros": 7.2}
9e09157a-6703-40b2-bd1f-c7fc1dc0782e	1703800	2022	19.8	89.26	36.6	{"agricultura": 37.4, "pecuaria": 21.3, "florestal": 24.5, "urbano": 6.1, "outros": 7.7}
5d183545-8cc7-4edb-ba8c-5c695cdecf91	1703800	2023	69.7	3.49	94	{"agricultura": 50.0, "pecuaria": 25.3, "florestal": 23.8, "urbano": 13.7, "outros": 9.3}
c4f96d69-6422-43a2-8ec8-fd4eb551e327	1703826	2019	31.4	127.63	64.9	{"agricultura": 27.7, "pecuaria": 17.2, "florestal": 28.5, "urbano": 13.1, "outros": 6.3}
4a9e7b02-a3b2-4c80-9d43-3420a2316761	1703826	2020	21.5	104.95	38.1	{"agricultura": 45.6, "pecuaria": 20.6, "florestal": 17.4, "urbano": 13.3, "outros": 1.2}
234d8c3b-315d-45c5-9729-ae0157510292	1703826	2021	68.7	170.38	59.2	{"agricultura": 23.4, "pecuaria": 13.4, "florestal": 31.4, "urbano": 9.8, "outros": 1.0}
e8219548-45b8-4d4e-8fd9-a52a13fabc3e	1703826	2022	61.4	89.91	42.2	{"agricultura": 50.6, "pecuaria": 28.3, "florestal": 29.6, "urbano": 6.6, "outros": 1.7}
51a1a3d4-107e-4023-beed-440c3028a561	1703826	2023	84.6	35.34	51.9	{"agricultura": 21.0, "pecuaria": 38.3, "florestal": 41.4, "urbano": 10.8, "outros": 2.9}
0931aac8-f18e-4d4b-8312-a566f03d7fa2	1703842	2019	92.1	129.29	45.7	{"agricultura": 55.8, "pecuaria": 27.2, "florestal": 15.9, "urbano": 13.3, "outros": 8.3}
4e49f254-2fcd-436a-9beb-bc7d0ce6ac07	1703842	2020	13	13.99	69.6	{"agricultura": 59.5, "pecuaria": 14.3, "florestal": 16.6, "urbano": 2.4, "outros": 7.8}
b1978b6d-b75a-4d7e-93dd-fb1822dc0293	1703842	2021	70.5	123.92	36.9	{"agricultura": 57.7, "pecuaria": 38.5, "florestal": 37.1, "urbano": 11.7, "outros": 2.7}
eeca2180-21a9-437b-b7c0-bd09e863de19	1703842	2022	46.6	24.65	80.2	{"agricultura": 45.4, "pecuaria": 19.9, "florestal": 26.1, "urbano": 6.4, "outros": 6.8}
efe484d3-6577-4339-adeb-621ff63c218b	1703842	2023	68	126.98	64.7	{"agricultura": 45.7, "pecuaria": 20.9, "florestal": 29.1, "urbano": 5.2, "outros": 2.1}
5d936b64-9ca6-43c2-a4ba-fdbc6883546c	1703867	2019	55.1	41.49	90.8	{"agricultura": 23.7, "pecuaria": 16.0, "florestal": 37.9, "urbano": 12.5, "outros": 8.5}
4157756f-7d06-49dc-b963-d5877b0dace8	1703867	2020	65.1	33.16	52.3	{"agricultura": 59.2, "pecuaria": 26.4, "florestal": 48.0, "urbano": 13.8, "outros": 3.8}
e965a6e9-a3e3-4c09-aa85-763695245df3	1703867	2021	78.8	102.33	61.9	{"agricultura": 56.6, "pecuaria": 15.1, "florestal": 32.7, "urbano": 14.6, "outros": 4.2}
711a2b42-6b34-4be3-bea5-7ade696c4a1e	1703867	2022	54.8	161.79	60.1	{"agricultura": 46.3, "pecuaria": 33.8, "florestal": 44.4, "urbano": 5.3, "outros": 1.4}
384d1e0e-bd7e-4d3e-83f9-0f90a6758707	1703867	2023	44.6	132.39	88	{"agricultura": 31.9, "pecuaria": 24.9, "florestal": 43.9, "urbano": 4.9, "outros": 7.1}
d73fe4a6-c925-4099-935f-6435f0af012e	1703883	2019	33.9	6.46	80.1	{"agricultura": 22.4, "pecuaria": 36.2, "florestal": 37.6, "urbano": 6.7, "outros": 3.3}
4c012b19-291d-4592-a780-f534e9bac9fe	1703883	2020	7.8	25.76	56	{"agricultura": 33.5, "pecuaria": 10.1, "florestal": 24.3, "urbano": 3.1, "outros": 8.3}
2df51877-e957-410b-aac1-51cffa041f71	1703883	2021	87.2	185.47	83.1	{"agricultura": 25.2, "pecuaria": 31.8, "florestal": 46.3, "urbano": 9.2, "outros": 5.4}
e974647d-9711-4425-a504-1d15f9f31474	1703883	2022	45.9	37.3	75.4	{"agricultura": 31.3, "pecuaria": 16.5, "florestal": 42.6, "urbano": 2.1, "outros": 5.7}
486e3842-6701-4e1f-b769-c49522ff0e92	1703883	2023	21.2	169.09	80.8	{"agricultura": 41.5, "pecuaria": 21.8, "florestal": 31.1, "urbano": 9.7, "outros": 7.2}
d0e8276a-7ea2-493b-a6c9-1807da3de872	1703891	2019	27.5	148.99	54.4	{"agricultura": 28.6, "pecuaria": 34.6, "florestal": 41.3, "urbano": 5.3, "outros": 6.2}
ce40abac-1831-48c6-bc05-7a8b02216506	1703891	2020	85.1	146.82	57.1	{"agricultura": 55.7, "pecuaria": 38.0, "florestal": 40.8, "urbano": 6.2, "outros": 1.8}
dc4b6823-7570-4cb2-886e-2efc795a0406	1703891	2021	22.7	29.12	50.6	{"agricultura": 35.0, "pecuaria": 28.4, "florestal": 25.8, "urbano": 12.4, "outros": 5.4}
9031b3cf-9e68-4394-bee2-a3c8781d401e	1703891	2022	60.1	51.05	55.4	{"agricultura": 31.9, "pecuaria": 29.8, "florestal": 15.7, "urbano": 11.9, "outros": 7.3}
f3e8d989-85c9-4d2f-a22f-c26b8660cf8a	1703891	2023	64.7	64.24	75.5	{"agricultura": 22.7, "pecuaria": 27.8, "florestal": 44.2, "urbano": 9.3, "outros": 6.9}
16108b68-4353-4fd0-aac5-7bdc1a2fe2bd	1703909	2019	89.4	101.19	40	{"agricultura": 38.5, "pecuaria": 10.8, "florestal": 21.0, "urbano": 2.4, "outros": 9.7}
1c42b219-cfab-461d-82ad-4349ad63a0cb	1703909	2020	52.3	42.95	50.4	{"agricultura": 29.2, "pecuaria": 33.9, "florestal": 31.1, "urbano": 7.9, "outros": 9.7}
111f76cb-440c-467a-938f-c2cbcc072ec8	1703909	2021	45.8	149.88	65.6	{"agricultura": 27.3, "pecuaria": 25.0, "florestal": 24.4, "urbano": 8.5, "outros": 6.4}
2d116dfd-7b70-42e2-8b4b-b9cb937270d5	1703909	2022	81.8	71.23	93.1	{"agricultura": 47.6, "pecuaria": 11.8, "florestal": 29.7, "urbano": 2.3, "outros": 7.6}
e1d4e187-98ea-4d38-ac83-7333659d67f6	1703909	2023	16.6	55.8	55.7	{"agricultura": 25.6, "pecuaria": 36.5, "florestal": 31.9, "urbano": 10.8, "outros": 8.5}
eba1d6ec-8eb0-4dba-a503-8ca9fc081be8	1704105	2019	60.7	167.82	53.1	{"agricultura": 47.6, "pecuaria": 21.3, "florestal": 26.4, "urbano": 14.5, "outros": 5.4}
42246ce5-b2af-47ae-b3a7-e89c27d4c773	1704105	2020	28.8	44.21	41.5	{"agricultura": 48.2, "pecuaria": 32.2, "florestal": 37.8, "urbano": 4.3, "outros": 1.2}
73afec7f-d61c-4ae4-af79-442104c220c5	1704105	2021	91.8	84.34	54	{"agricultura": 42.6, "pecuaria": 16.0, "florestal": 46.7, "urbano": 11.4, "outros": 1.5}
a663b14f-e730-4bb2-8704-4134e0e055a8	1704105	2022	94.4	10.64	87.1	{"agricultura": 59.9, "pecuaria": 10.8, "florestal": 48.6, "urbano": 13.4, "outros": 6.5}
d8b7d4ca-5cef-4c5b-910c-531d15ec38ff	1704105	2023	92.4	133.95	90.2	{"agricultura": 36.3, "pecuaria": 34.5, "florestal": 25.3, "urbano": 10.2, "outros": 4.6}
c51b7eb2-e5ce-4a50-922a-c28d48b6cfbb	1704600	2019	28	64.97	39.2	{"agricultura": 37.3, "pecuaria": 24.2, "florestal": 34.3, "urbano": 10.0, "outros": 7.2}
f01e688c-ad34-45e4-a6d2-1831aa60f16e	1704600	2020	89.6	31.74	53.8	{"agricultura": 58.2, "pecuaria": 15.3, "florestal": 32.2, "urbano": 14.8, "outros": 9.8}
c5ee36ce-8a64-4b94-833c-1545dc5ba2cf	1704600	2021	92	28.96	94.7	{"agricultura": 33.5, "pecuaria": 20.8, "florestal": 33.2, "urbano": 12.4, "outros": 2.7}
a1f5f5dd-53f2-41da-906c-429de27da586	1704600	2022	77.5	131.52	83.9	{"agricultura": 53.9, "pecuaria": 14.8, "florestal": 28.4, "urbano": 10.6, "outros": 1.1}
47c3251f-6029-4191-b349-576695858da3	1704600	2023	23.2	80.19	41.2	{"agricultura": 24.1, "pecuaria": 38.3, "florestal": 30.9, "urbano": 13.6, "outros": 7.5}
c57d8e71-09cd-4186-a8b5-2ce2002cbfee	1705102	2019	22	57.01	50.2	{"agricultura": 31.1, "pecuaria": 35.5, "florestal": 36.8, "urbano": 10.3, "outros": 2.1}
c23506ed-4929-4f37-8c4b-7e6b0d976f88	1705102	2020	55	108.31	85.2	{"agricultura": 37.8, "pecuaria": 38.5, "florestal": 41.3, "urbano": 13.8, "outros": 6.0}
017737bd-25c2-4892-a19c-058c2b526a6d	1705102	2021	82.1	107.66	64.6	{"agricultura": 50.7, "pecuaria": 15.8, "florestal": 37.7, "urbano": 14.1, "outros": 3.2}
dc65d901-2879-483e-8c8c-562c04a34790	1705102	2022	53.3	42.05	88.3	{"agricultura": 20.4, "pecuaria": 30.6, "florestal": 44.6, "urbano": 2.9, "outros": 9.0}
ce7b00bd-b92e-4d91-947f-4929a70094a1	1705102	2023	17.8	103.68	59.9	{"agricultura": 36.0, "pecuaria": 32.8, "florestal": 16.0, "urbano": 12.6, "outros": 5.8}
d7611660-a521-47a2-a05a-e8a1eaf73ccc	1705508	2019	11.6	23.69	62	{"agricultura": 45.6, "pecuaria": 39.4, "florestal": 42.0, "urbano": 9.8, "outros": 6.9}
4d95e809-17dd-4e56-8073-8244365e1ead	1705508	2020	5.3	38.89	42.2	{"agricultura": 22.0, "pecuaria": 19.1, "florestal": 38.0, "urbano": 11.1, "outros": 10.0}
f63791c1-1c88-4933-a75a-e057c3c899cc	1705508	2021	30.4	173.62	63.7	{"agricultura": 53.9, "pecuaria": 39.0, "florestal": 16.3, "urbano": 6.8, "outros": 8.7}
931afe67-746f-4aa8-b296-1fe2ee9d0dea	1705508	2022	6.2	8.09	70.9	{"agricultura": 49.3, "pecuaria": 34.0, "florestal": 30.9, "urbano": 8.1, "outros": 4.8}
274ad6f7-a38a-4a08-bded-ab351d27e589	1705508	2023	20.8	188.78	38.8	{"agricultura": 25.5, "pecuaria": 11.9, "florestal": 44.1, "urbano": 13.5, "outros": 4.2}
bd0a0d36-97e1-40da-aecf-ade0d4e8a981	1705557	2019	17	27.42	90.3	{"agricultura": 54.8, "pecuaria": 12.7, "florestal": 29.0, "urbano": 4.6, "outros": 4.0}
0d90347c-dee3-4c81-9dd4-095bf81605af	1705557	2020	76.7	58.51	74.3	{"agricultura": 54.8, "pecuaria": 17.7, "florestal": 48.5, "urbano": 8.0, "outros": 7.7}
7c66bd6c-5893-4b52-a294-22850a0b7871	1705557	2021	44	13.82	92.6	{"agricultura": 58.7, "pecuaria": 13.5, "florestal": 18.2, "urbano": 5.6, "outros": 6.6}
7388275d-2a27-44a2-9045-20136a047f6e	1705557	2022	50.8	144.56	85.1	{"agricultura": 36.4, "pecuaria": 27.6, "florestal": 19.2, "urbano": 11.1, "outros": 3.9}
0a74c32a-3d3f-4e57-8bab-233ffe6e7a2a	1705557	2023	19.4	169.97	93.2	{"agricultura": 54.4, "pecuaria": 13.6, "florestal": 27.7, "urbano": 2.9, "outros": 3.6}
47ff05c5-a347-423d-9e09-c426f8d03b2e	1705607	2019	16.7	78.2	76.4	{"agricultura": 22.4, "pecuaria": 21.9, "florestal": 26.7, "urbano": 7.2, "outros": 9.5}
680fc574-979d-4452-9c16-fe363327f1b9	1705607	2020	23.4	174.18	58.8	{"agricultura": 45.9, "pecuaria": 38.1, "florestal": 30.8, "urbano": 14.8, "outros": 5.4}
055d604b-5da5-4afe-8c83-d5a5d83ffd57	1705607	2021	15.9	188.54	46	{"agricultura": 34.7, "pecuaria": 12.8, "florestal": 23.7, "urbano": 8.2, "outros": 2.5}
1608362c-d55c-4823-a427-bda153b612e3	1705607	2022	23.4	3.82	45.9	{"agricultura": 37.1, "pecuaria": 26.6, "florestal": 46.4, "urbano": 11.3, "outros": 7.3}
d7910340-4238-49b5-a325-915a090bfcaa	1705607	2023	13.1	157.49	90.1	{"agricultura": 32.9, "pecuaria": 14.0, "florestal": 21.0, "urbano": 12.6, "outros": 1.8}
0ecf0956-1377-4970-858c-a6056f4793bc	1706001	2019	85.5	138.31	91.6	{"agricultura": 42.1, "pecuaria": 12.3, "florestal": 48.3, "urbano": 9.4, "outros": 6.6}
7a96027e-facd-4d12-9338-776e6ebe009a	1706001	2020	54	97.22	60.7	{"agricultura": 38.5, "pecuaria": 24.0, "florestal": 22.8, "urbano": 3.0, "outros": 5.5}
7c269a30-fdec-4b11-9807-d54348224f5f	1706001	2021	60.2	119.05	92.8	{"agricultura": 41.4, "pecuaria": 19.2, "florestal": 38.7, "urbano": 4.3, "outros": 8.8}
5ecc9391-00ea-4c7a-b5ab-27fbe8478bcc	1706001	2022	22.6	157.44	51.6	{"agricultura": 28.8, "pecuaria": 38.0, "florestal": 26.6, "urbano": 8.6, "outros": 8.9}
32860d9c-75e3-492f-a2d8-96364da4e2b2	1706001	2023	75.9	123.19	62.1	{"agricultura": 55.5, "pecuaria": 18.1, "florestal": 39.3, "urbano": 10.6, "outros": 6.7}
d925416d-2a19-45c2-9679-3fbe28a5cb5b	1706100	2019	26.8	63.38	75.7	{"agricultura": 55.1, "pecuaria": 18.7, "florestal": 35.6, "urbano": 11.8, "outros": 1.6}
7e7a6be1-16cb-4885-a6dc-04277d97dcae	1706100	2020	65.4	62.49	69.5	{"agricultura": 33.7, "pecuaria": 13.4, "florestal": 45.4, "urbano": 10.5, "outros": 4.4}
4c162642-9d26-48a6-9908-07e9b2fef349	1706100	2021	52.5	91.03	52.3	{"agricultura": 49.4, "pecuaria": 39.5, "florestal": 27.0, "urbano": 9.5, "outros": 1.6}
08725478-4771-4418-9cc5-8bf7063472b5	1706100	2022	71.6	88.64	92.6	{"agricultura": 23.6, "pecuaria": 33.8, "florestal": 24.6, "urbano": 13.3, "outros": 2.2}
4735895f-8d1f-40d8-9366-926dac0b38d1	1706100	2023	21.5	37.1	63.3	{"agricultura": 30.0, "pecuaria": 11.1, "florestal": 38.8, "urbano": 7.1, "outros": 7.5}
2f63e681-f298-4c9e-aa91-5a1fac96fc8e	1706258	2019	46.3	16.9	36.7	{"agricultura": 37.6, "pecuaria": 12.2, "florestal": 23.8, "urbano": 9.0, "outros": 6.0}
25c04c88-1bf5-4f79-9359-2307370b95db	1706258	2020	57.7	7.44	45	{"agricultura": 41.5, "pecuaria": 25.8, "florestal": 21.1, "urbano": 12.7, "outros": 8.6}
6fbeb5b3-7b76-4876-981d-1e8cea5736aa	1706258	2021	16.3	49.13	37.5	{"agricultura": 33.7, "pecuaria": 15.8, "florestal": 46.5, "urbano": 10.6, "outros": 6.2}
80fc5336-f692-4db5-b3f5-7a5bbdde923c	1706258	2022	11.8	31.79	50	{"agricultura": 42.5, "pecuaria": 22.2, "florestal": 36.2, "urbano": 3.6, "outros": 7.8}
4401c9cd-942a-4ba2-9039-896a29e60705	1706258	2023	11.9	97.28	91.7	{"agricultura": 50.3, "pecuaria": 38.8, "florestal": 47.7, "urbano": 6.8, "outros": 1.2}
af1e2f3a-aa57-4a5d-aba7-07784786e196	1706506	2019	8.7	176.44	65.4	{"agricultura": 57.1, "pecuaria": 31.9, "florestal": 32.1, "urbano": 6.8, "outros": 7.3}
f07f2e01-2540-4823-b9fd-75590aa261d6	1706506	2020	57.5	88.97	71.2	{"agricultura": 35.6, "pecuaria": 11.1, "florestal": 17.4, "urbano": 8.9, "outros": 6.7}
eaecafc2-de41-4d36-bf00-b4a0e37d128f	1706506	2021	19.1	140.58	70.9	{"agricultura": 35.8, "pecuaria": 21.5, "florestal": 39.9, "urbano": 10.5, "outros": 4.5}
77d848a8-fff4-4b21-9fc8-45d6dac35b96	1706506	2022	33.4	95.75	81.7	{"agricultura": 36.9, "pecuaria": 11.8, "florestal": 41.3, "urbano": 7.7, "outros": 5.7}
04f268bf-607d-4fa1-be4b-8359a74d17c1	1706506	2023	36.4	89.2	79.1	{"agricultura": 46.0, "pecuaria": 11.6, "florestal": 21.6, "urbano": 6.0, "outros": 2.5}
dce58c75-1818-48fe-8109-ada02fe8df2d	1707009	2019	70.9	64.1	59.8	{"agricultura": 53.4, "pecuaria": 32.7, "florestal": 29.8, "urbano": 12.8, "outros": 7.2}
cb34169b-6746-4c19-ad55-dab5f15cab9e	1707009	2020	84.6	79.6	80.4	{"agricultura": 36.9, "pecuaria": 13.3, "florestal": 39.1, "urbano": 7.7, "outros": 6.3}
6630449e-c18d-4741-aee1-ef8842874e49	1707009	2021	66.8	181.56	35.7	{"agricultura": 32.5, "pecuaria": 30.4, "florestal": 39.4, "urbano": 9.2, "outros": 3.3}
f58384bf-0484-4e9b-8ec3-ea66445a6390	1707009	2022	12.4	32.86	73.2	{"agricultura": 51.5, "pecuaria": 21.3, "florestal": 33.3, "urbano": 11.7, "outros": 7.1}
c53e6be7-1bb0-4d72-9f68-5968cdffb4c6	1707009	2023	25.1	64.71	36.7	{"agricultura": 28.9, "pecuaria": 13.4, "florestal": 19.0, "urbano": 14.5, "outros": 2.3}
505ed356-0498-41a8-9f28-792ce4cdddba	1707108	2019	31.6	39.77	56.2	{"agricultura": 35.6, "pecuaria": 23.9, "florestal": 40.3, "urbano": 7.3, "outros": 9.9}
bc68ae80-e7e8-4af6-91c9-4a7dcfd8bed9	1707108	2020	34.9	29.83	55.4	{"agricultura": 57.4, "pecuaria": 16.7, "florestal": 25.1, "urbano": 9.3, "outros": 1.4}
be6ac9e4-e715-4042-b4ea-92422cc8c66c	1707108	2021	89.6	36.05	60.8	{"agricultura": 43.1, "pecuaria": 18.9, "florestal": 39.3, "urbano": 2.0, "outros": 1.4}
b0e4ea81-57fd-425f-ab0a-a62d3873d857	1707108	2022	57.4	184.15	64.4	{"agricultura": 27.8, "pecuaria": 38.8, "florestal": 35.2, "urbano": 8.1, "outros": 3.1}
108043b3-e4d8-4bdb-b8b8-e560edb3b057	1707108	2023	62.3	189.25	76.2	{"agricultura": 52.2, "pecuaria": 24.8, "florestal": 41.5, "urbano": 3.0, "outros": 9.6}
581e9ffe-fd94-4d66-a3d2-a736eabfeb32	1707207	2019	77.7	154.69	55.3	{"agricultura": 29.1, "pecuaria": 24.8, "florestal": 17.8, "urbano": 6.1, "outros": 3.1}
55e5df41-81ac-4007-8fc8-cc49ed11bd78	1707207	2020	8.3	25.49	82.7	{"agricultura": 43.5, "pecuaria": 16.7, "florestal": 34.9, "urbano": 12.4, "outros": 7.8}
51346062-09fc-4fb7-aea9-80681ac3ba9b	1707207	2021	54.2	86.22	90.4	{"agricultura": 41.5, "pecuaria": 18.1, "florestal": 44.3, "urbano": 14.9, "outros": 9.5}
17aa2d39-d458-4a62-af30-05694986fc5f	1707207	2022	24.2	175.57	50.6	{"agricultura": 44.6, "pecuaria": 25.3, "florestal": 26.6, "urbano": 6.7, "outros": 9.5}
a8dd2383-d87c-4024-aeff-0b24521700a1	1707207	2023	63.9	8.65	81.5	{"agricultura": 48.8, "pecuaria": 20.0, "florestal": 40.7, "urbano": 7.0, "outros": 9.1}
59234c89-49b2-4b7a-8f89-4dceeaa561c1	1707306	2019	41.6	10.23	64.5	{"agricultura": 30.5, "pecuaria": 30.5, "florestal": 21.7, "urbano": 9.5, "outros": 3.1}
48100224-00da-4b77-9817-ff3da734fb42	1707306	2020	7.1	159.38	51.5	{"agricultura": 42.3, "pecuaria": 14.8, "florestal": 27.3, "urbano": 14.1, "outros": 8.0}
a2389374-9d2f-4de2-8301-f48baaf4e5c8	1707306	2021	92.5	100.49	49.7	{"agricultura": 56.4, "pecuaria": 21.0, "florestal": 36.3, "urbano": 6.2, "outros": 2.7}
b90ba02d-1c64-4fce-bc8f-d31d8a671dd1	1707306	2022	74.6	127.28	63.1	{"agricultura": 20.1, "pecuaria": 12.7, "florestal": 26.6, "urbano": 11.1, "outros": 5.3}
ddebeaaa-7f73-4eec-a2a6-c919cd135854	1707306	2023	52.8	55.59	40.3	{"agricultura": 59.7, "pecuaria": 16.7, "florestal": 44.6, "urbano": 9.2, "outros": 3.0}
4b4ef357-171e-41a4-b094-ea258efd5540	1707405	2019	42.4	89.88	62.1	{"agricultura": 22.6, "pecuaria": 35.1, "florestal": 47.7, "urbano": 6.9, "outros": 6.5}
066d33a0-ebd2-47fb-854a-854b4139adfa	1707405	2020	92.4	93.93	56.4	{"agricultura": 52.5, "pecuaria": 33.7, "florestal": 45.4, "urbano": 15.0, "outros": 7.7}
e0c97433-9f90-4e08-86c8-13d62ce87adb	1707405	2021	42.3	141.31	62.9	{"agricultura": 20.3, "pecuaria": 20.1, "florestal": 21.6, "urbano": 8.4, "outros": 3.4}
a8472311-1624-4fbd-a00f-b6120f62ebc7	1707405	2022	55	86.98	56.4	{"agricultura": 24.9, "pecuaria": 29.6, "florestal": 28.7, "urbano": 10.1, "outros": 9.5}
e9779b7b-c1c1-43b0-939e-5fa2f51f676e	1707405	2023	49	149.68	94.3	{"agricultura": 22.8, "pecuaria": 27.6, "florestal": 26.7, "urbano": 13.5, "outros": 5.2}
4834e76c-bc78-44e8-b90a-56c0634162aa	1707553	2019	17.1	127.5	60.8	{"agricultura": 37.0, "pecuaria": 33.0, "florestal": 40.9, "urbano": 8.1, "outros": 5.3}
439cfdd9-9217-4391-bd1d-99237677cde9	1707553	2020	18.1	107.87	38.7	{"agricultura": 45.8, "pecuaria": 35.4, "florestal": 27.6, "urbano": 10.9, "outros": 2.1}
fd79d713-9c1d-4982-8a3c-d1fee228f687	1707553	2021	85.6	20.45	35.5	{"agricultura": 32.3, "pecuaria": 24.5, "florestal": 25.9, "urbano": 2.3, "outros": 7.6}
5a827a07-84ea-42ed-b507-c2f244de3fbb	1707553	2022	21.8	187.35	43.4	{"agricultura": 52.6, "pecuaria": 39.5, "florestal": 28.9, "urbano": 14.0, "outros": 6.2}
90e0f8cc-4799-4493-8376-9d0db29b91ea	1707553	2023	20.5	77.11	38.4	{"agricultura": 52.2, "pecuaria": 18.9, "florestal": 32.9, "urbano": 12.7, "outros": 3.1}
b4a8a321-46d2-468d-a06e-fc4128815358	1707652	2019	73.4	162.51	83.5	{"agricultura": 51.3, "pecuaria": 21.9, "florestal": 27.0, "urbano": 7.9, "outros": 7.4}
38cb9f06-0951-4691-905a-efbd2816b531	1707652	2020	89.9	103.61	48.1	{"agricultura": 58.3, "pecuaria": 11.1, "florestal": 16.0, "urbano": 2.3, "outros": 2.2}
8ddfc321-25d5-4d55-a895-aab6cc5c4e95	1707652	2021	67.2	158.52	47.3	{"agricultura": 58.0, "pecuaria": 16.4, "florestal": 20.8, "urbano": 2.3, "outros": 7.6}
ae5d85be-e0ad-4ce6-8541-67f5214104e4	1707652	2022	78	32.88	35.3	{"agricultura": 31.6, "pecuaria": 16.6, "florestal": 39.6, "urbano": 2.1, "outros": 9.0}
6d061df4-8408-4e5e-aaa3-c96dd0b378f9	1707652	2023	12.1	186.8	66.4	{"agricultura": 26.7, "pecuaria": 26.0, "florestal": 34.5, "urbano": 11.2, "outros": 6.6}
caf9fcc6-bd79-4ce6-aed5-070596ee7845	1707702	2019	48.7	158.03	92.1	{"agricultura": 34.2, "pecuaria": 10.3, "florestal": 42.3, "urbano": 5.2, "outros": 9.6}
d678daf8-87b9-40ba-b9fb-49e1129dbe96	1707702	2020	25	137.45	92.9	{"agricultura": 35.9, "pecuaria": 30.1, "florestal": 33.1, "urbano": 7.4, "outros": 9.9}
b653f7a9-c4d1-42c6-bf5e-5bf3efa5305d	1707702	2021	9.2	57.79	55.1	{"agricultura": 35.8, "pecuaria": 15.8, "florestal": 24.8, "urbano": 2.7, "outros": 9.4}
8133131e-e442-4847-8123-b5f14fb888b9	1707702	2022	5.2	183.39	55.4	{"agricultura": 54.3, "pecuaria": 21.0, "florestal": 40.6, "urbano": 14.4, "outros": 9.6}
9057f0a0-0ad7-4731-b729-2445c77d4d52	1707702	2023	48.2	70.3	76.8	{"agricultura": 29.9, "pecuaria": 24.8, "florestal": 18.6, "urbano": 13.4, "outros": 5.2}
0070130c-3a98-4b86-abed-05fa9acff85a	1708205	2019	55.4	29.88	90.2	{"agricultura": 46.6, "pecuaria": 24.6, "florestal": 16.8, "urbano": 6.2, "outros": 8.8}
5b69bb58-4a90-4e60-8839-4db40e7d10b0	1708205	2020	66.8	24.04	49.4	{"agricultura": 54.3, "pecuaria": 10.8, "florestal": 47.5, "urbano": 10.3, "outros": 4.3}
94477c45-106b-4ffd-8443-7e1fed19a735	1708205	2021	62.4	28.61	56.8	{"agricultura": 31.9, "pecuaria": 35.6, "florestal": 38.0, "urbano": 9.9, "outros": 4.6}
f7078989-ed66-4ea4-9503-3e674fe7aefd	1708205	2022	60.1	81.08	73.1	{"agricultura": 56.5, "pecuaria": 36.9, "florestal": 22.0, "urbano": 14.9, "outros": 9.3}
25c80275-5094-4188-905f-b8801b79750b	1708205	2023	37.3	36.65	45.8	{"agricultura": 33.1, "pecuaria": 20.9, "florestal": 39.9, "urbano": 10.5, "outros": 8.5}
2a38d9f4-a7be-4f61-9e4a-8c8609528a89	1708254	2019	89.4	174.47	40.8	{"agricultura": 25.2, "pecuaria": 10.4, "florestal": 36.1, "urbano": 14.7, "outros": 5.7}
cae86002-9d7d-41f8-be4a-0c67d06016df	1708254	2020	56.4	48.93	55.3	{"agricultura": 20.2, "pecuaria": 15.5, "florestal": 23.7, "urbano": 2.3, "outros": 5.5}
9bd6c7be-b6a4-4c37-96ac-677128456384	1708254	2021	84.5	114.29	89.4	{"agricultura": 56.7, "pecuaria": 19.0, "florestal": 40.5, "urbano": 13.3, "outros": 2.5}
c82715b0-a3e2-4372-a5b4-3672f4bf57d6	1708254	2022	66.3	37.21	86.7	{"agricultura": 33.7, "pecuaria": 33.3, "florestal": 21.1, "urbano": 8.4, "outros": 7.2}
c482d705-54ed-4525-a4f8-0386edac13fa	1708254	2023	91.4	102.9	69.8	{"agricultura": 26.3, "pecuaria": 37.3, "florestal": 49.0, "urbano": 2.0, "outros": 7.4}
0f0bd32b-3fa3-4cd8-82a3-f8cd708d498b	1708304	2019	63.1	20.76	62.4	{"agricultura": 46.5, "pecuaria": 17.3, "florestal": 35.3, "urbano": 6.0, "outros": 3.7}
4845068a-3876-42d1-99cf-ffa345cfec8d	1708304	2020	39	58.17	67.6	{"agricultura": 41.0, "pecuaria": 25.3, "florestal": 31.3, "urbano": 5.7, "outros": 9.6}
46e0465d-ce61-4995-ab1a-90280f40e7c8	1708304	2021	16.2	26.21	54.2	{"agricultura": 37.1, "pecuaria": 14.2, "florestal": 47.4, "urbano": 12.1, "outros": 1.4}
e90b74fd-0657-4d5f-abbd-fb430f1584c0	1708304	2022	65.1	51.53	88.7	{"agricultura": 33.1, "pecuaria": 16.5, "florestal": 43.8, "urbano": 11.7, "outros": 5.4}
b22c0bfa-d177-4252-8e80-2fc24c6a74f8	1708304	2023	7.8	79.05	35.2	{"agricultura": 27.4, "pecuaria": 22.2, "florestal": 41.7, "urbano": 9.3, "outros": 8.9}
911711e7-73ed-4733-8383-ccb790c09493	1709005	2019	62.4	178.31	59	{"agricultura": 50.4, "pecuaria": 22.8, "florestal": 26.0, "urbano": 8.0, "outros": 5.9}
b10a6210-ec11-46ed-a42f-eab1391c62e3	1709005	2020	27.7	48.02	48.5	{"agricultura": 53.7, "pecuaria": 14.2, "florestal": 46.8, "urbano": 14.3, "outros": 9.8}
706eb042-e78d-45e0-93f6-f41907f1fe7d	1709005	2021	23.4	62.03	51.8	{"agricultura": 22.5, "pecuaria": 32.5, "florestal": 36.6, "urbano": 13.7, "outros": 1.5}
d985348e-5c67-4a3a-a6f7-48b89945b921	1709005	2022	25.7	51.83	65.4	{"agricultura": 44.0, "pecuaria": 13.2, "florestal": 36.9, "urbano": 10.8, "outros": 6.0}
32dbd6f1-121b-455c-a5c5-18f8fe6d2356	1709005	2023	10.6	154.25	90.7	{"agricultura": 28.9, "pecuaria": 28.5, "florestal": 23.0, "urbano": 12.5, "outros": 9.8}
ecac11f2-149d-4051-8189-8fd85c29043d	1709302	2019	13.6	114.73	91.6	{"agricultura": 40.0, "pecuaria": 33.9, "florestal": 29.8, "urbano": 12.6, "outros": 9.7}
998c5b03-bc98-44c7-a6c3-730beb17f20e	1709302	2020	69.3	151.14	87.3	{"agricultura": 32.2, "pecuaria": 19.4, "florestal": 29.0, "urbano": 8.3, "outros": 8.4}
5d0e3f08-1907-4eef-a738-4b88f937aa2a	1709302	2021	89.9	16.42	64.3	{"agricultura": 22.1, "pecuaria": 10.7, "florestal": 37.1, "urbano": 8.0, "outros": 7.4}
9370b327-69b0-4246-8491-3e47707c5457	1709302	2022	43.8	88.19	60.9	{"agricultura": 42.1, "pecuaria": 16.8, "florestal": 34.2, "urbano": 6.3, "outros": 5.2}
10984db0-6c82-4f8b-8ff1-4cde8e5559f4	1709302	2023	42	12.86	46.5	{"agricultura": 37.7, "pecuaria": 29.6, "florestal": 45.8, "urbano": 10.2, "outros": 9.6}
169fb7f5-d2de-4c17-9830-fc112206ee76	1709500	2019	18.7	80.52	94.8	{"agricultura": 24.1, "pecuaria": 29.4, "florestal": 30.9, "urbano": 11.3, "outros": 1.1}
0fe18e16-7a71-4b79-9010-acce8db1d8cf	1709500	2020	29.2	167.28	35.3	{"agricultura": 47.5, "pecuaria": 12.5, "florestal": 47.6, "urbano": 11.7, "outros": 8.9}
84bc478b-ac16-4cae-815d-5407d58d63ea	1709500	2021	63.9	29.47	46.4	{"agricultura": 51.7, "pecuaria": 39.6, "florestal": 36.7, "urbano": 11.9, "outros": 7.0}
627d0c23-f34c-4727-b8e2-126404b8768f	1709500	2022	90.1	172.63	39.9	{"agricultura": 20.1, "pecuaria": 38.2, "florestal": 44.0, "urbano": 7.2, "outros": 1.6}
74117141-2a14-4255-a9a3-add0421870ff	1709500	2023	28.7	65.86	49	{"agricultura": 46.6, "pecuaria": 26.6, "florestal": 28.4, "urbano": 3.1, "outros": 8.3}
0ee0a57c-4d69-47a1-acc4-224f276940a5	1709807	2019	45.7	114.85	63.7	{"agricultura": 53.0, "pecuaria": 20.2, "florestal": 34.8, "urbano": 7.9, "outros": 2.0}
c246eb08-4836-4a03-996d-88ad46991466	1709807	2020	55.3	158.76	74	{"agricultura": 50.9, "pecuaria": 26.8, "florestal": 33.0, "urbano": 7.9, "outros": 5.1}
892b26be-1a34-403d-a8e5-38b565ddb4c7	1709807	2021	18.1	118.08	72.8	{"agricultura": 37.5, "pecuaria": 28.9, "florestal": 27.3, "urbano": 8.6, "outros": 8.5}
248fa93e-cbea-4db2-8cb9-2a124c66a5e2	1709807	2022	37.7	62.57	47.8	{"agricultura": 37.4, "pecuaria": 32.4, "florestal": 21.0, "urbano": 14.9, "outros": 8.3}
afdee6c4-1a31-4689-9667-32864241c0b2	1709807	2023	46.8	38.28	92.4	{"agricultura": 21.9, "pecuaria": 17.4, "florestal": 26.9, "urbano": 5.2, "outros": 9.2}
e44c7d42-c686-4a86-a2cd-b8ffe3b2fa05	1710508	2019	29.5	96.28	40	{"agricultura": 40.5, "pecuaria": 14.9, "florestal": 45.7, "urbano": 8.0, "outros": 3.0}
526aeb58-8fa8-4a93-a65c-25dfad3c6c37	1710508	2020	92.4	102.97	59.3	{"agricultura": 34.8, "pecuaria": 16.0, "florestal": 22.6, "urbano": 13.1, "outros": 3.7}
e7a334ca-b6fb-4935-a0e0-fbdf7c0f6e95	1710508	2021	46.8	41.52	70.3	{"agricultura": 54.4, "pecuaria": 23.6, "florestal": 27.7, "urbano": 6.4, "outros": 7.8}
9c69ed97-b931-42ec-bf3f-08f77f2e4204	1710508	2022	69.5	169.64	74.5	{"agricultura": 42.4, "pecuaria": 29.5, "florestal": 23.3, "urbano": 4.0, "outros": 3.5}
46cd7e72-2422-4f9e-948d-cd78f45cde04	1710508	2023	41.5	89.03	35.7	{"agricultura": 59.8, "pecuaria": 13.0, "florestal": 16.9, "urbano": 3.2, "outros": 7.6}
252116a9-684f-4fa2-bf1f-1dfc0990df93	1710706	2019	74.4	143.62	71.9	{"agricultura": 43.3, "pecuaria": 35.8, "florestal": 27.0, "urbano": 4.5, "outros": 7.0}
cc25a2b1-d8c0-4236-8d70-935ae4677756	1710706	2020	49.4	148.71	36	{"agricultura": 59.4, "pecuaria": 23.7, "florestal": 43.0, "urbano": 5.2, "outros": 7.7}
7918e01d-d595-45c0-be95-dbeb5188ca98	1710706	2021	87.9	94.78	38.7	{"agricultura": 54.0, "pecuaria": 16.4, "florestal": 30.9, "urbano": 7.1, "outros": 9.7}
758d6aeb-2b57-4a89-82fb-8804a29b8fda	1710706	2022	36.1	28.66	91.2	{"agricultura": 46.0, "pecuaria": 39.5, "florestal": 23.5, "urbano": 2.7, "outros": 5.5}
8d08e5ca-d125-4e86-b7be-314ce0a785f2	1710706	2023	41.9	163.94	89.8	{"agricultura": 25.7, "pecuaria": 25.8, "florestal": 38.6, "urbano": 2.9, "outros": 6.2}
d8c87635-f8f5-499c-b729-80452cc8ce78	1710904	2019	67.1	159.09	38	{"agricultura": 45.7, "pecuaria": 11.4, "florestal": 34.3, "urbano": 14.8, "outros": 5.5}
741eb130-7839-4f06-ac3b-3fda01696382	1710904	2020	41.7	138.28	40.3	{"agricultura": 41.1, "pecuaria": 14.9, "florestal": 48.5, "urbano": 8.2, "outros": 9.6}
1ef17ceb-f9b0-4f79-9566-94c3c71d8528	1710904	2021	70.2	69.4	89.3	{"agricultura": 45.5, "pecuaria": 37.0, "florestal": 44.3, "urbano": 10.9, "outros": 1.4}
13d46c2c-d861-4a97-afb6-46fb0f320c40	1710904	2022	91.4	24.32	85.6	{"agricultura": 36.0, "pecuaria": 33.5, "florestal": 25.2, "urbano": 5.9, "outros": 9.7}
ad09c87f-550c-4c72-83bd-f018359bf7e9	1710904	2023	24.4	1.41	50.1	{"agricultura": 53.7, "pecuaria": 27.2, "florestal": 22.1, "urbano": 3.8, "outros": 7.0}
e9d09a50-01b6-492c-833c-31dabf759fc5	1711100	2019	82.8	79.34	36	{"agricultura": 31.0, "pecuaria": 29.0, "florestal": 37.0, "urbano": 5.8, "outros": 8.2}
3bd445c5-553a-4168-8846-3c7588a1c664	1711100	2020	55.2	107.68	62.2	{"agricultura": 30.9, "pecuaria": 37.5, "florestal": 45.3, "urbano": 9.5, "outros": 3.0}
68b1ccec-a13f-42cc-a87f-72a91082d968	1711100	2021	67.3	49.2	71.7	{"agricultura": 21.6, "pecuaria": 13.7, "florestal": 22.9, "urbano": 9.4, "outros": 6.0}
8f52de3b-90c0-4adc-810e-ecfd51f76323	1711100	2022	18.8	143.36	76.7	{"agricultura": 36.7, "pecuaria": 38.6, "florestal": 28.8, "urbano": 5.3, "outros": 1.8}
62f68eac-f4ee-4418-8e17-0de1337d7249	1711100	2023	70.2	160.05	58.7	{"agricultura": 24.0, "pecuaria": 23.4, "florestal": 19.6, "urbano": 14.6, "outros": 5.6}
610a45e0-7927-4c42-891b-37b583fd3f84	1711506	2019	23.1	65.39	66.5	{"agricultura": 38.0, "pecuaria": 18.0, "florestal": 46.1, "urbano": 4.9, "outros": 5.3}
95baf3bc-fd19-48b9-81b0-fa9d8286209e	1711506	2020	13.4	107.89	54.5	{"agricultura": 29.1, "pecuaria": 11.2, "florestal": 41.6, "urbano": 11.5, "outros": 1.8}
07106ce4-970b-4154-a295-bb3c77d20500	1711506	2021	53.8	173.79	84	{"agricultura": 24.5, "pecuaria": 11.0, "florestal": 49.5, "urbano": 10.6, "outros": 5.1}
69fb691e-2455-4949-9cd3-9181e1f4d175	1711506	2022	78.8	70.22	46.5	{"agricultura": 29.6, "pecuaria": 32.5, "florestal": 24.7, "urbano": 3.7, "outros": 5.0}
b4141696-0181-43e9-8fe9-3da8785cfefb	1711506	2023	89.4	87.37	39.6	{"agricultura": 47.0, "pecuaria": 37.0, "florestal": 22.6, "urbano": 5.8, "outros": 6.1}
559f8119-1306-4245-97f0-a84ed9422729	1711803	2019	31.1	184.56	64.5	{"agricultura": 26.4, "pecuaria": 35.8, "florestal": 33.6, "urbano": 3.5, "outros": 4.9}
b26de06c-69ec-439f-9ccc-fb88705effe8	1711803	2020	71.4	62.9	35.1	{"agricultura": 52.1, "pecuaria": 27.9, "florestal": 19.3, "urbano": 11.4, "outros": 7.1}
c46fc7a9-aa64-4e11-8f6c-85f948d7af1f	1711803	2021	11.7	45.98	38.9	{"agricultura": 33.9, "pecuaria": 14.8, "florestal": 39.0, "urbano": 11.6, "outros": 4.8}
91edbc1b-efa8-4919-8f37-5012e50f4a1e	1711803	2022	39.8	147.98	38.6	{"agricultura": 40.4, "pecuaria": 37.1, "florestal": 30.2, "urbano": 11.5, "outros": 1.9}
ae083718-6e7f-452f-8836-e1ee9fb9474a	1711803	2023	69.3	45.97	90.9	{"agricultura": 36.8, "pecuaria": 30.5, "florestal": 27.2, "urbano": 3.6, "outros": 4.3}
9a76fc10-edb0-4377-b4c1-6a354cce4ff2	1711902	2019	9.2	17.54	51.8	{"agricultura": 58.9, "pecuaria": 18.7, "florestal": 37.5, "urbano": 7.3, "outros": 4.7}
81a657b6-1268-4e94-9fe7-11274f261d97	1711902	2020	64.3	119.85	55.9	{"agricultura": 43.1, "pecuaria": 18.0, "florestal": 31.7, "urbano": 8.9, "outros": 6.9}
a714d74b-d3ce-4477-b833-d0f418f6fdc9	1711902	2021	9.7	16.69	94.9	{"agricultura": 46.5, "pecuaria": 20.9, "florestal": 18.0, "urbano": 5.9, "outros": 5.1}
43413a99-ae8f-4641-bb47-ea29088fd407	1711902	2022	30.6	88.09	77.5	{"agricultura": 30.5, "pecuaria": 30.1, "florestal": 37.8, "urbano": 6.6, "outros": 1.7}
d7df8ca3-63af-4c0e-950d-70a159c49697	1711902	2023	50.5	64.87	39.4	{"agricultura": 48.6, "pecuaria": 33.2, "florestal": 16.2, "urbano": 3.9, "outros": 4.4}
b98eac6f-6b54-4c9d-8199-53b789fe7bf7	1711951	2019	24	52.76	72.5	{"agricultura": 44.8, "pecuaria": 19.4, "florestal": 29.1, "urbano": 8.4, "outros": 2.3}
1476f1ae-a6e6-4dee-94e3-efd5aa496d79	1711951	2020	60.5	161.64	85.8	{"agricultura": 36.5, "pecuaria": 27.6, "florestal": 39.0, "urbano": 7.0, "outros": 2.2}
27ab99b4-177a-4a45-995b-81dbfcb450b2	1711951	2021	83.4	45.18	74.8	{"agricultura": 59.0, "pecuaria": 36.3, "florestal": 30.4, "urbano": 3.0, "outros": 7.9}
52304ea4-8a0e-4892-a126-1531b2496223	1711951	2022	44.5	136.44	88.6	{"agricultura": 28.6, "pecuaria": 29.6, "florestal": 15.1, "urbano": 3.1, "outros": 6.9}
d8ffc80b-5d64-4fd5-b561-9afad65995ab	1711951	2023	80	28.85	54.6	{"agricultura": 43.2, "pecuaria": 21.3, "florestal": 23.9, "urbano": 2.5, "outros": 2.4}
b0147a1e-4584-45d8-8478-2ad03ddacd9c	1712009	2019	54	112.83	71.2	{"agricultura": 32.4, "pecuaria": 11.6, "florestal": 34.8, "urbano": 8.4, "outros": 5.5}
3727c161-07be-4037-be99-d084a4a42433	1712009	2020	48	121.03	65.2	{"agricultura": 59.0, "pecuaria": 34.7, "florestal": 41.9, "urbano": 10.7, "outros": 7.3}
da46db84-94dc-45c9-9274-42e40ac643a2	1712009	2021	20.2	189.74	46.7	{"agricultura": 20.8, "pecuaria": 11.1, "florestal": 25.9, "urbano": 4.5, "outros": 5.9}
dfcebae5-8f1e-4e24-b651-f196adb86f1a	1712009	2022	78.3	11.57	53	{"agricultura": 48.1, "pecuaria": 35.1, "florestal": 26.9, "urbano": 6.2, "outros": 6.8}
7daa9d74-9b50-47e6-b4b9-e8ff66c8932e	1712009	2023	41.7	139.78	89.2	{"agricultura": 37.1, "pecuaria": 25.0, "florestal": 34.2, "urbano": 12.4, "outros": 3.9}
52ff7649-a03e-4d91-9345-bf8ffbdaa3ec	1712157	2019	48.1	68.4	84.9	{"agricultura": 30.7, "pecuaria": 39.2, "florestal": 36.9, "urbano": 13.9, "outros": 8.9}
b7e209df-1662-4ed2-86b9-f826c722a09c	1712157	2020	18.5	28.13	74.2	{"agricultura": 44.8, "pecuaria": 10.2, "florestal": 16.3, "urbano": 4.3, "outros": 5.9}
9ab69869-5e86-4712-90e9-cb171458cb01	1712157	2021	15.6	67.6	74.6	{"agricultura": 22.9, "pecuaria": 21.4, "florestal": 21.2, "urbano": 8.9, "outros": 8.6}
c14e2264-d0aa-40cd-bbb0-f099b33dbe4d	1712157	2022	22.4	169.18	59.4	{"agricultura": 24.4, "pecuaria": 27.2, "florestal": 18.1, "urbano": 4.9, "outros": 3.8}
07ba0d41-6c9e-493b-924e-561a587d8834	1712157	2023	36	172.75	76.3	{"agricultura": 50.8, "pecuaria": 13.9, "florestal": 21.7, "urbano": 9.5, "outros": 9.2}
5d64095c-eec9-44f6-a397-5a147ae110fc	1712405	2019	78.7	138.9	67.8	{"agricultura": 24.5, "pecuaria": 21.3, "florestal": 16.1, "urbano": 6.7, "outros": 8.6}
dd9ddb07-0449-49c4-888d-1989d9f8eaa5	1712405	2020	32.4	159.47	80.9	{"agricultura": 42.5, "pecuaria": 12.3, "florestal": 29.7, "urbano": 13.1, "outros": 5.8}
334d71a7-cde9-4f29-b061-0efd0c5326fe	1712405	2021	56.9	164.47	50.9	{"agricultura": 29.3, "pecuaria": 34.0, "florestal": 37.3, "urbano": 7.9, "outros": 4.4}
99b7254a-aebe-4bd9-b5e2-23d8bd89914e	1712405	2022	92.8	84.47	80.9	{"agricultura": 31.0, "pecuaria": 13.1, "florestal": 29.3, "urbano": 3.0, "outros": 5.8}
d00da1ed-2caa-4a32-a6a3-f7a07bc0dfcc	1712405	2023	41.5	152.36	91	{"agricultura": 26.5, "pecuaria": 30.5, "florestal": 23.1, "urbano": 3.3, "outros": 7.8}
c9004fee-c2cc-4e56-81df-c8db4df0953a	1712454	2019	41.9	3.92	53.6	{"agricultura": 28.3, "pecuaria": 12.7, "florestal": 16.0, "urbano": 7.8, "outros": 2.9}
c8204ff4-0825-4cb1-b021-b65b4e8f2203	1712454	2020	87.9	28.25	69.2	{"agricultura": 29.2, "pecuaria": 34.6, "florestal": 48.8, "urbano": 5.6, "outros": 4.5}
896d3ef7-b523-4906-8476-d9b4654b884c	1712454	2021	74.8	125.46	36.4	{"agricultura": 39.4, "pecuaria": 18.2, "florestal": 31.1, "urbano": 3.8, "outros": 2.9}
97b3262b-917d-449c-a86f-ff12fa63614b	1712454	2022	88.7	103.78	44.9	{"agricultura": 53.0, "pecuaria": 36.8, "florestal": 26.2, "urbano": 5.5, "outros": 1.4}
b19367c3-b176-4943-bf69-8c4cdfc99095	1712454	2023	23	43.74	52.3	{"agricultura": 28.4, "pecuaria": 24.2, "florestal": 27.7, "urbano": 10.6, "outros": 1.1}
3911a072-b1e1-4bd1-9b69-55249c8b3901	1712504	2019	9.1	9.89	60.2	{"agricultura": 56.2, "pecuaria": 10.5, "florestal": 15.3, "urbano": 9.4, "outros": 3.3}
f1bd11da-132c-471e-8a14-0a13f0da1f75	1712504	2020	66	130.55	89	{"agricultura": 30.4, "pecuaria": 14.8, "florestal": 21.4, "urbano": 3.5, "outros": 1.5}
95a175e0-d1b2-48e3-a1a2-cb5b8d2579f5	1712504	2021	21	70.93	38.4	{"agricultura": 58.0, "pecuaria": 18.0, "florestal": 15.1, "urbano": 14.3, "outros": 8.0}
2a399a26-5dfc-483d-89ed-c9d4f0ae1205	1712504	2022	91	19.1	50.7	{"agricultura": 26.1, "pecuaria": 30.5, "florestal": 43.2, "urbano": 4.1, "outros": 1.7}
ffb9ac74-6518-40f9-95e6-3da319d32abd	1712504	2023	84.4	21.51	51	{"agricultura": 56.5, "pecuaria": 36.2, "florestal": 39.2, "urbano": 14.5, "outros": 8.2}
36e79f93-7b2e-4348-b83e-692422b34ef4	1712702	2019	32.9	30.92	92.2	{"agricultura": 31.1, "pecuaria": 15.1, "florestal": 22.4, "urbano": 12.3, "outros": 1.5}
2aca4e5c-8bd3-4198-ba8b-5a56ccdfd2d6	1712702	2020	21.2	25.43	53.9	{"agricultura": 42.6, "pecuaria": 22.1, "florestal": 23.4, "urbano": 8.3, "outros": 5.9}
f840ae97-2620-44ba-82b6-7028eb30d8a9	1712702	2021	63.1	108.8	85.9	{"agricultura": 20.6, "pecuaria": 24.0, "florestal": 38.2, "urbano": 11.9, "outros": 6.7}
847cb485-9ec1-4140-803e-1a7c34652fb2	1712702	2022	41.9	65.52	57.2	{"agricultura": 49.7, "pecuaria": 22.4, "florestal": 41.2, "urbano": 9.8, "outros": 6.3}
5aee23c2-86eb-4fde-aa01-6dbf2c016ae1	1712702	2023	11.3	159.4	65.7	{"agricultura": 35.7, "pecuaria": 31.8, "florestal": 22.0, "urbano": 9.3, "outros": 2.9}
0a1ea86d-94d1-4ae8-9c49-301c27be8e0b	1712801	2019	52.2	51.59	54.3	{"agricultura": 37.5, "pecuaria": 24.3, "florestal": 48.2, "urbano": 9.4, "outros": 4.4}
e0b7503f-93a6-4edf-b852-6c28241cae11	1712801	2020	30	176.26	41	{"agricultura": 59.0, "pecuaria": 30.7, "florestal": 32.4, "urbano": 7.7, "outros": 2.1}
388a9f65-464e-463a-9ae3-a059f742d2e6	1712801	2021	36.7	135.36	44	{"agricultura": 28.6, "pecuaria": 29.4, "florestal": 27.5, "urbano": 14.5, "outros": 5.3}
066d0255-86f4-4ad3-9937-3933e67dfc7c	1712801	2022	67.5	46.22	91.5	{"agricultura": 44.5, "pecuaria": 33.6, "florestal": 39.9, "urbano": 11.6, "outros": 4.5}
eacb4080-c2ce-451c-a12b-fd917791253a	1712801	2023	46.6	12.68	84.4	{"agricultura": 52.8, "pecuaria": 27.1, "florestal": 28.3, "urbano": 12.0, "outros": 5.3}
a571c010-b145-43fe-8164-4d7a8cbbbd86	1713205	2019	48.9	125.28	63.2	{"agricultura": 24.1, "pecuaria": 11.4, "florestal": 31.9, "urbano": 14.5, "outros": 5.7}
223d327c-7fa3-4e42-88f7-9033e7dcdb3b	1713205	2020	22.5	133.05	73.3	{"agricultura": 34.9, "pecuaria": 15.3, "florestal": 23.2, "urbano": 5.8, "outros": 4.5}
e895a30f-6abb-4cc3-8aec-0e7451e7660b	1713205	2021	86.5	19.32	76.4	{"agricultura": 41.2, "pecuaria": 12.5, "florestal": 29.6, "urbano": 14.5, "outros": 6.8}
47fca4de-9526-41f1-a658-9f241142646a	1713205	2022	37.6	161.9	56.6	{"agricultura": 48.3, "pecuaria": 23.8, "florestal": 20.9, "urbano": 10.9, "outros": 8.9}
9fcbb9f2-2ce0-4c1e-aca1-7dbe1c3a68cd	1713205	2023	10.7	73.39	63	{"agricultura": 53.4, "pecuaria": 23.0, "florestal": 39.4, "urbano": 3.0, "outros": 5.6}
9ca366de-670c-42d3-9bb5-514d67d0a406	1713304	2019	44.3	134.77	87	{"agricultura": 43.6, "pecuaria": 25.8, "florestal": 16.1, "urbano": 11.8, "outros": 10.0}
ef1bb4c5-8d60-4c4f-b01e-dd4f36999dbb	1713304	2020	70.1	51.05	82.8	{"agricultura": 30.0, "pecuaria": 35.4, "florestal": 26.2, "urbano": 7.1, "outros": 4.9}
ae209f54-c59a-4b79-b295-a6aaefb754fe	1713304	2021	32	29.02	93.6	{"agricultura": 30.2, "pecuaria": 22.4, "florestal": 46.4, "urbano": 9.5, "outros": 9.9}
ab6b71b3-ecd2-44d5-9309-cbba8288a4b0	1713304	2022	19.4	170.64	77.3	{"agricultura": 29.4, "pecuaria": 21.7, "florestal": 16.8, "urbano": 12.6, "outros": 2.3}
dd1b0cf7-b84f-45bf-8417-59886331b479	1713304	2023	40.4	30.55	51.6	{"agricultura": 49.5, "pecuaria": 23.2, "florestal": 41.0, "urbano": 8.8, "outros": 1.9}
2f18cfcb-8ebd-4344-8d4d-e5a02a829bf8	1713601	2019	48.1	177.82	74.5	{"agricultura": 44.7, "pecuaria": 26.0, "florestal": 38.9, "urbano": 13.5, "outros": 2.8}
29eaced8-5898-4f0d-8bcc-da0d2d8c8567	1713601	2020	24.4	15.1	86.3	{"agricultura": 51.6, "pecuaria": 34.6, "florestal": 44.2, "urbano": 8.3, "outros": 6.7}
250bf11e-5129-47fe-8d52-ee20d95a4e76	1713601	2021	40.5	177.4	65.6	{"agricultura": 28.4, "pecuaria": 25.4, "florestal": 21.7, "urbano": 12.6, "outros": 2.9}
164dfd7e-d8c0-4963-8280-68552dad40ed	1713601	2022	87.2	91.58	75.5	{"agricultura": 40.1, "pecuaria": 25.3, "florestal": 27.8, "urbano": 10.7, "outros": 1.3}
4fce18f9-fc6f-4df4-9c31-5058460ba757	1713601	2023	50.6	70.62	88.7	{"agricultura": 56.2, "pecuaria": 37.7, "florestal": 25.3, "urbano": 5.6, "outros": 2.5}
b5fadbcd-157c-4c5c-a017-ac929563c13b	1713700	2019	39.3	170.28	86.7	{"agricultura": 22.7, "pecuaria": 33.3, "florestal": 35.1, "urbano": 8.3, "outros": 2.3}
888ea9be-50d6-4d49-af97-3574474ab099	1713700	2020	8.2	62.55	64.9	{"agricultura": 20.5, "pecuaria": 32.2, "florestal": 49.2, "urbano": 11.8, "outros": 9.9}
f8c79761-94b8-4f37-8a08-ba80b6d66250	1713700	2021	92.9	157.44	91.1	{"agricultura": 48.8, "pecuaria": 38.5, "florestal": 34.2, "urbano": 6.3, "outros": 7.8}
d00230e6-868c-425d-96d0-0a266a07d615	1713700	2022	84.7	57.36	94.8	{"agricultura": 50.9, "pecuaria": 35.5, "florestal": 44.3, "urbano": 4.6, "outros": 2.1}
0ce5c9bf-05f9-4137-95de-68113e0a2685	1713700	2023	34.1	47.99	49	{"agricultura": 27.8, "pecuaria": 39.7, "florestal": 28.8, "urbano": 9.1, "outros": 1.5}
2e0a19d4-21ca-492c-980b-40c0507217fc	1713809	2019	42.3	121.63	66.8	{"agricultura": 25.5, "pecuaria": 10.4, "florestal": 37.2, "urbano": 6.8, "outros": 2.0}
e34c2b84-c858-450b-8c55-2425301fa859	1713809	2020	18	63.3	84.1	{"agricultura": 55.7, "pecuaria": 35.4, "florestal": 42.3, "urbano": 3.7, "outros": 7.7}
85b73fe5-5c86-40f0-aa85-e20cb20060e3	1713809	2021	22.9	153.36	55.8	{"agricultura": 52.3, "pecuaria": 21.3, "florestal": 21.3, "urbano": 12.4, "outros": 8.3}
0ffc355f-c9a8-4227-b73a-e9ac6a338e93	1713809	2022	85.3	166.99	46.2	{"agricultura": 37.6, "pecuaria": 29.3, "florestal": 35.8, "urbano": 4.4, "outros": 1.8}
8dd83ba3-e4a2-42bb-a996-e155b2fd1557	1713809	2023	67.5	130.62	45.6	{"agricultura": 36.9, "pecuaria": 18.5, "florestal": 40.9, "urbano": 5.6, "outros": 3.4}
434e9eb7-f019-4e7e-8095-1f519a05b397	1713957	2019	72.9	129.94	81.8	{"agricultura": 26.8, "pecuaria": 22.3, "florestal": 45.8, "urbano": 6.2, "outros": 8.7}
561dcf4c-d169-4a39-be79-22d02af77fa0	1713957	2020	57.5	23.36	49	{"agricultura": 51.7, "pecuaria": 26.9, "florestal": 46.1, "urbano": 6.1, "outros": 4.9}
9a7f02af-54b2-4cf6-9d42-f55aa9fecb16	1713957	2021	40.7	136.17	77.4	{"agricultura": 31.0, "pecuaria": 28.9, "florestal": 47.9, "urbano": 9.7, "outros": 7.1}
3f43e731-3649-4e68-a26f-391c9276dd89	1713957	2022	71.5	166.95	54.4	{"agricultura": 59.8, "pecuaria": 32.3, "florestal": 32.6, "urbano": 9.2, "outros": 8.6}
6ad9c7bb-06a6-43b6-b940-b190c5182ad2	1713957	2023	74.7	54.85	60.4	{"agricultura": 32.1, "pecuaria": 11.9, "florestal": 29.4, "urbano": 6.9, "outros": 3.2}
104e2f6c-3e56-4933-8dc5-2a5bccfe2b58	1714203	2019	79.2	60.18	56	{"agricultura": 53.3, "pecuaria": 39.1, "florestal": 30.0, "urbano": 10.2, "outros": 7.8}
3fa44f4c-265c-4d7b-9c73-221817ccda7e	1714203	2020	39.1	107.77	44.4	{"agricultura": 53.0, "pecuaria": 12.1, "florestal": 25.2, "urbano": 8.7, "outros": 3.8}
5a31b7b2-2524-4fe7-a1a3-1d2f8ba41fb7	1714203	2021	49.1	66.38	82	{"agricultura": 58.4, "pecuaria": 13.7, "florestal": 41.4, "urbano": 13.1, "outros": 5.4}
6285d26b-2ac1-44c2-ae47-fd2d5c55a844	1714203	2022	75.5	132.61	86.7	{"agricultura": 25.7, "pecuaria": 25.7, "florestal": 36.0, "urbano": 11.7, "outros": 4.2}
e04f152e-f0c4-430e-846b-a8eae27eb97f	1714203	2023	10.6	137.99	91.7	{"agricultura": 22.2, "pecuaria": 21.8, "florestal": 30.7, "urbano": 9.5, "outros": 5.4}
f87f6194-b93f-4191-9b52-db9876a8e01d	1714302	2019	72.4	166.97	90.5	{"agricultura": 35.3, "pecuaria": 24.3, "florestal": 29.7, "urbano": 4.5, "outros": 6.1}
11b2debf-f130-4fd0-beea-aa3a4cceaf5e	1714302	2020	15	29.26	47.8	{"agricultura": 24.4, "pecuaria": 39.2, "florestal": 37.1, "urbano": 5.7, "outros": 4.2}
0c543e74-7a17-4191-8e80-0bf41a2c93b8	1714302	2021	64.2	45.34	86.7	{"agricultura": 56.0, "pecuaria": 11.9, "florestal": 20.4, "urbano": 10.0, "outros": 8.1}
9c9a69ed-9cd8-4206-9a0b-8dce9b591bfe	1714302	2022	43.1	147.05	88.9	{"agricultura": 33.0, "pecuaria": 36.0, "florestal": 30.8, "urbano": 14.9, "outros": 4.8}
4769cb14-f4b9-48c5-873f-cc4190c9f402	1714302	2023	16.7	186.22	58.9	{"agricultura": 24.3, "pecuaria": 27.4, "florestal": 23.5, "urbano": 12.1, "outros": 2.0}
8f872885-dc72-4df3-bc4a-7c5299ec191c	1714880	2019	58.9	11.44	59.3	{"agricultura": 57.7, "pecuaria": 29.1, "florestal": 28.6, "urbano": 3.2, "outros": 8.4}
f5efa98b-a550-4e69-a044-60b9b6290eca	1714880	2020	50.4	90.94	83.9	{"agricultura": 57.7, "pecuaria": 34.6, "florestal": 26.8, "urbano": 7.9, "outros": 8.3}
7ad68e01-07b7-440c-84db-3185bdd537f0	1714880	2021	74.2	3.65	81.9	{"agricultura": 23.2, "pecuaria": 20.9, "florestal": 25.4, "urbano": 14.6, "outros": 1.7}
60e5dd11-6dfc-41c6-afd4-4029ece4a3dc	1714880	2022	10.1	153.82	86.1	{"agricultura": 39.9, "pecuaria": 19.7, "florestal": 43.2, "urbano": 3.0, "outros": 6.3}
38149e06-deae-478f-b514-ccd16ef68086	1714880	2023	22.9	59.6	53.2	{"agricultura": 23.0, "pecuaria": 22.4, "florestal": 49.8, "urbano": 9.4, "outros": 6.9}
83e8cfc0-67a2-48a3-969a-ed0f1ed3f07d	1715002	2019	18.9	54.28	62.5	{"agricultura": 50.0, "pecuaria": 30.9, "florestal": 15.5, "urbano": 11.3, "outros": 8.5}
0e214e8d-66b1-4c0f-916e-091cf93b68f2	1715002	2020	41.3	159.37	50.4	{"agricultura": 36.9, "pecuaria": 15.6, "florestal": 26.9, "urbano": 5.0, "outros": 7.6}
ee34cd54-2327-4d08-be27-49352f6e417b	1715002	2021	67.5	188.61	47.2	{"agricultura": 55.1, "pecuaria": 30.0, "florestal": 16.8, "urbano": 12.6, "outros": 9.5}
7df75ddb-9c02-4fdf-bc19-4723257702fb	1715002	2022	34.7	117.47	77.9	{"agricultura": 59.1, "pecuaria": 14.8, "florestal": 29.1, "urbano": 8.1, "outros": 5.9}
6df06d06-c16a-4e2f-b249-d0e7f7f760ae	1715002	2023	64.6	173.79	73.1	{"agricultura": 52.1, "pecuaria": 35.7, "florestal": 29.8, "urbano": 7.3, "outros": 1.1}
a94c539d-7388-49d8-8a53-bdc01085c9c8	1715101	2019	43	98.4	41.3	{"agricultura": 45.1, "pecuaria": 20.5, "florestal": 19.6, "urbano": 13.4, "outros": 5.2}
704d265c-be9f-4704-b5c5-61c4912ae65e	1715101	2020	55.7	160.23	39.7	{"agricultura": 20.7, "pecuaria": 26.7, "florestal": 37.4, "urbano": 2.9, "outros": 9.6}
45979cf8-fbdb-4b69-9670-8ea59791b334	1715101	2021	63.8	58.81	41.8	{"agricultura": 24.2, "pecuaria": 39.5, "florestal": 48.3, "urbano": 14.7, "outros": 3.6}
900f1ea9-315b-4821-ba18-c37c837ff065	1715101	2022	23	45.34	90.3	{"agricultura": 43.8, "pecuaria": 36.1, "florestal": 38.7, "urbano": 14.9, "outros": 1.1}
4ca2c425-fb84-47f1-a666-261a688aeb18	1715101	2023	74.9	81.4	63.1	{"agricultura": 54.7, "pecuaria": 11.8, "florestal": 40.8, "urbano": 3.3, "outros": 8.9}
8305c6f0-b8ad-44db-b94d-3430e961a2cc	1715150	2019	45.6	166.52	72.1	{"agricultura": 30.1, "pecuaria": 18.7, "florestal": 26.3, "urbano": 11.8, "outros": 6.1}
9819b3cc-c0de-4bb3-9cd2-cc89a03f0486	1715150	2020	52.6	169.74	40.8	{"agricultura": 32.1, "pecuaria": 29.4, "florestal": 21.9, "urbano": 5.0, "outros": 8.9}
bfb5e360-c3e7-4b00-80f5-7feda665abbb	1715150	2021	36.5	184.46	80.3	{"agricultura": 43.9, "pecuaria": 32.9, "florestal": 40.5, "urbano": 10.3, "outros": 7.6}
764a0020-f715-475e-84bb-806ce13ecb40	1715150	2022	32.1	166.06	60.9	{"agricultura": 31.8, "pecuaria": 21.4, "florestal": 23.6, "urbano": 11.7, "outros": 5.9}
7adb0123-49d8-478d-86d9-e3e75f0a6856	1715150	2023	81.7	139.06	50.1	{"agricultura": 44.5, "pecuaria": 15.3, "florestal": 33.8, "urbano": 3.2, "outros": 4.8}
8d85a8fe-fde8-4348-9a11-1da084223eb1	1715259	2019	85.1	119.94	35.2	{"agricultura": 31.5, "pecuaria": 12.0, "florestal": 25.9, "urbano": 12.8, "outros": 3.5}
1af09be8-18f5-4f8b-bb80-0a62238e7c58	1715259	2020	13.7	96.28	81.3	{"agricultura": 57.1, "pecuaria": 30.1, "florestal": 35.9, "urbano": 10.6, "outros": 8.9}
6a1d54d6-17f9-4e2d-8dd4-24684306ccc1	1715259	2021	34.5	46.1	35.6	{"agricultura": 47.9, "pecuaria": 17.8, "florestal": 45.6, "urbano": 8.8, "outros": 6.0}
b3789d53-2666-49a3-bed5-74356b942c58	1715259	2022	94.8	9.38	91	{"agricultura": 25.5, "pecuaria": 25.7, "florestal": 38.9, "urbano": 4.9, "outros": 2.4}
061e6a8b-7dd4-4a49-b942-e34bbae050c8	1715259	2023	75.5	45.22	90.4	{"agricultura": 58.6, "pecuaria": 22.6, "florestal": 26.3, "urbano": 13.4, "outros": 6.1}
b655611f-efff-4dc3-9588-922508d35114	1715507	2019	45.9	59.51	82.9	{"agricultura": 48.4, "pecuaria": 24.7, "florestal": 19.7, "urbano": 4.9, "outros": 2.8}
30d37efd-f8ac-41eb-882e-f2452b9271be	1715507	2020	65.4	173.36	81.6	{"agricultura": 22.6, "pecuaria": 39.6, "florestal": 29.6, "urbano": 7.3, "outros": 7.5}
f45715ae-0d0b-4e0a-837e-33bef185bcc1	1715507	2021	35.3	129	76.6	{"agricultura": 32.0, "pecuaria": 19.5, "florestal": 16.9, "urbano": 8.7, "outros": 8.0}
fd8537fe-a278-491c-97b6-b8b6b8c6725b	1715507	2022	32.4	29.08	80.5	{"agricultura": 59.9, "pecuaria": 25.9, "florestal": 43.1, "urbano": 4.2, "outros": 7.5}
84e516c1-9f02-4ff5-92f6-6e6c91ea653d	1715507	2023	57.3	132.49	44.7	{"agricultura": 56.8, "pecuaria": 25.6, "florestal": 24.8, "urbano": 9.1, "outros": 5.9}
e26305b9-6100-4bfd-9ebd-3994813a7180	1715705	2019	73.3	29.3	54.6	{"agricultura": 25.7, "pecuaria": 28.1, "florestal": 44.2, "urbano": 14.4, "outros": 9.8}
88c18908-d6e7-43c4-a2ec-2ac40e285997	1715705	2020	46.5	120.95	39.8	{"agricultura": 30.8, "pecuaria": 32.3, "florestal": 41.4, "urbano": 8.6, "outros": 8.9}
b377f1b5-dde7-4f98-bbba-cb80b3ce0233	1715705	2021	76.2	177.09	60.5	{"agricultura": 57.5, "pecuaria": 18.4, "florestal": 23.6, "urbano": 14.8, "outros": 7.5}
c3403d0d-8ce1-4ecd-a761-192d8cd8d3cd	1715705	2022	90.3	22.37	94.5	{"agricultura": 26.3, "pecuaria": 12.8, "florestal": 34.2, "urbano": 14.8, "outros": 9.7}
a5d4e9f1-4aba-4a15-a8b5-101b668b5e09	1715705	2023	40	80.32	71.1	{"agricultura": 36.0, "pecuaria": 21.7, "florestal": 48.7, "urbano": 3.3, "outros": 4.5}
d0e38335-16c3-4ae3-a984-f378f6c55718	1715754	2019	72.2	16.55	78.5	{"agricultura": 27.1, "pecuaria": 25.9, "florestal": 20.1, "urbano": 12.0, "outros": 4.1}
2932c363-d580-4e5d-9228-d9a7cab7ea5a	1715754	2020	88.8	170.1	84.5	{"agricultura": 35.8, "pecuaria": 16.9, "florestal": 18.6, "urbano": 5.1, "outros": 4.9}
1fee2f20-4c31-4ab2-90f8-b69bf1b7ce9e	1715754	2021	27.8	126.21	69.9	{"agricultura": 48.3, "pecuaria": 13.9, "florestal": 32.8, "urbano": 5.7, "outros": 9.4}
25c05198-e842-4fd3-970e-71328365ad5d	1715754	2022	83.5	4.65	70.1	{"agricultura": 34.7, "pecuaria": 11.2, "florestal": 19.0, "urbano": 9.9, "outros": 8.7}
6b3ca374-3045-41a7-8c14-4fa41d56970a	1715754	2023	64.1	76.4	52.1	{"agricultura": 21.1, "pecuaria": 35.4, "florestal": 24.8, "urbano": 11.3, "outros": 8.3}
186b6158-e71b-40f0-b4d2-a6fcc53faa2e	1716109	2019	15.8	156.08	87.9	{"agricultura": 49.2, "pecuaria": 16.5, "florestal": 23.0, "urbano": 7.4, "outros": 5.5}
d01872c6-3670-454e-8364-27a92657d421	1716109	2020	20	170.6	54.5	{"agricultura": 45.6, "pecuaria": 31.0, "florestal": 18.6, "urbano": 6.8, "outros": 8.8}
18276501-3a8b-4af9-ba52-7b127c22edd5	1716109	2021	44.3	26.01	57.1	{"agricultura": 50.9, "pecuaria": 38.2, "florestal": 31.4, "urbano": 7.9, "outros": 6.2}
72f229f0-48a6-4344-bf81-2159e2dd8728	1716109	2022	26.1	69.15	46.8	{"agricultura": 27.2, "pecuaria": 19.5, "florestal": 40.8, "urbano": 6.4, "outros": 4.3}
bcb8ca27-e2ec-48a9-81d5-8a65085a8d87	1716109	2023	43	153.25	88.8	{"agricultura": 22.7, "pecuaria": 29.3, "florestal": 39.5, "urbano": 3.1, "outros": 2.1}
75fb4656-9b27-4678-aa40-795ddfbf6091	1716208	2019	38.4	135.78	62.2	{"agricultura": 52.6, "pecuaria": 33.3, "florestal": 38.1, "urbano": 6.8, "outros": 8.5}
d75840c8-8664-4f46-b654-27f0eca1b678	1716208	2020	25.7	99.79	62.7	{"agricultura": 48.1, "pecuaria": 34.8, "florestal": 18.1, "urbano": 12.8, "outros": 5.1}
73093732-648c-488b-8373-370e7eefe59e	1716208	2021	61.6	171.96	40.2	{"agricultura": 50.5, "pecuaria": 13.8, "florestal": 34.8, "urbano": 4.6, "outros": 8.7}
778bcbf1-f771-489a-a19b-2297fb471b9d	1716208	2022	88.4	120.55	85.4	{"agricultura": 59.2, "pecuaria": 28.7, "florestal": 38.4, "urbano": 8.5, "outros": 7.0}
d3bf76be-d8fb-4cfe-827d-02bdf05a3c67	1716208	2023	23.8	165.73	80	{"agricultura": 55.1, "pecuaria": 38.5, "florestal": 20.4, "urbano": 4.2, "outros": 2.8}
aff8bf67-442d-4aff-ba24-00a6cfd18af3	1716307	2019	30.9	120.91	76.9	{"agricultura": 48.7, "pecuaria": 20.9, "florestal": 37.3, "urbano": 2.8, "outros": 4.7}
1e581d29-3b69-4f95-847c-c3a8e4c9c6cc	1716307	2020	28.8	162.03	50.2	{"agricultura": 49.0, "pecuaria": 28.4, "florestal": 30.1, "urbano": 9.1, "outros": 2.6}
a9a80da0-68e6-46c8-b392-292f8414221e	1716307	2021	52.3	39.5	90.8	{"agricultura": 32.7, "pecuaria": 23.7, "florestal": 19.8, "urbano": 13.8, "outros": 4.7}
d804a545-ad3d-44b9-897f-48890941cbec	1716307	2022	17.4	54	83	{"agricultura": 42.3, "pecuaria": 28.2, "florestal": 15.8, "urbano": 7.8, "outros": 2.7}
e42496c6-7eea-4edf-b042-c8762667f85f	1716307	2023	40.4	74.37	86.8	{"agricultura": 20.5, "pecuaria": 17.7, "florestal": 45.0, "urbano": 8.1, "outros": 2.5}
c903203b-bf9c-48c3-9a58-87ffe252fc85	1716505	2019	17.1	178.44	74.9	{"agricultura": 55.0, "pecuaria": 11.4, "florestal": 48.9, "urbano": 7.7, "outros": 6.0}
f1e70f05-c3ed-46d8-8bf8-d65a0d6e9047	1716505	2020	32.9	48.86	89.5	{"agricultura": 33.8, "pecuaria": 33.6, "florestal": 19.0, "urbano": 12.3, "outros": 1.0}
6ec2e088-0348-422a-8f10-bdfafb8d0598	1716505	2021	95	118.04	46.4	{"agricultura": 25.7, "pecuaria": 29.8, "florestal": 41.5, "urbano": 3.8, "outros": 9.5}
a7fb3df3-c185-46c2-ad99-c685fd8fe388	1716505	2022	59.2	158.05	91.5	{"agricultura": 27.8, "pecuaria": 16.4, "florestal": 33.7, "urbano": 5.6, "outros": 2.3}
6c99da40-c8b4-4b79-9a75-f0a12335b98f	1716505	2023	65.6	139	47.4	{"agricultura": 46.2, "pecuaria": 22.1, "florestal": 49.4, "urbano": 12.2, "outros": 4.1}
39d2f175-803a-4e8e-b5e8-b35259da7568	1716604	2019	82.6	113.92	85.4	{"agricultura": 49.9, "pecuaria": 36.6, "florestal": 22.9, "urbano": 8.7, "outros": 6.3}
d98fd743-be74-4249-aec4-ce13979206b9	1716604	2020	83.5	16.79	38.2	{"agricultura": 50.3, "pecuaria": 21.4, "florestal": 26.2, "urbano": 6.6, "outros": 5.7}
ba7fb290-0f6a-47e8-bc34-169473ddca2c	1716604	2021	50.7	133.38	43.4	{"agricultura": 55.3, "pecuaria": 10.9, "florestal": 29.9, "urbano": 2.4, "outros": 9.5}
abb1cc47-2a90-44b8-a8e2-5a064a389e8a	1716604	2022	91.8	142.26	38.9	{"agricultura": 34.8, "pecuaria": 19.3, "florestal": 40.4, "urbano": 8.4, "outros": 8.4}
61e6163a-43f9-45d0-b273-d397cbbf7f72	1716604	2023	47	31.19	60.7	{"agricultura": 36.3, "pecuaria": 37.2, "florestal": 26.0, "urbano": 10.4, "outros": 2.9}
3c945e7b-5090-4c5b-b8d4-bccd96968e44	1716653	2019	73.8	63.49	40.6	{"agricultura": 59.9, "pecuaria": 28.7, "florestal": 16.0, "urbano": 4.7, "outros": 2.2}
12203333-baee-49c2-affc-1d90d3d1b882	1716653	2020	17	63.23	90.6	{"agricultura": 43.0, "pecuaria": 30.9, "florestal": 28.3, "urbano": 7.6, "outros": 7.0}
0e155e79-9db7-49a3-b7f4-506a7f8e6648	1716653	2021	11.6	107.03	44.9	{"agricultura": 25.1, "pecuaria": 25.8, "florestal": 42.2, "urbano": 13.4, "outros": 4.2}
f084f14a-fafb-47b5-a096-d3b39d9773da	1716653	2022	33.9	14.56	64.7	{"agricultura": 20.1, "pecuaria": 12.3, "florestal": 32.6, "urbano": 4.4, "outros": 8.5}
1d513b14-d410-4cd3-b1c5-9023c38fd754	1716653	2023	81.1	100.15	68.8	{"agricultura": 29.6, "pecuaria": 25.3, "florestal": 50.0, "urbano": 12.8, "outros": 2.1}
1b7a0555-a7a8-4848-ace8-7c13458dc16c	1716703	2019	36.6	20.89	83.2	{"agricultura": 29.7, "pecuaria": 32.6, "florestal": 33.8, "urbano": 12.1, "outros": 7.4}
d16406be-b421-444a-8352-cb7d19e549de	1716703	2020	63.3	185.8	52.7	{"agricultura": 47.7, "pecuaria": 32.0, "florestal": 28.3, "urbano": 13.4, "outros": 6.7}
ea1039bb-a3ec-400e-b83c-95bd13212754	1716703	2021	35.7	129.28	48.9	{"agricultura": 33.2, "pecuaria": 33.9, "florestal": 18.4, "urbano": 13.2, "outros": 5.8}
7fba4b9b-2e84-4acb-823d-c702f5812e2a	1716703	2022	10.4	10.54	75.3	{"agricultura": 34.7, "pecuaria": 34.2, "florestal": 45.1, "urbano": 15.0, "outros": 3.5}
20eec4b0-855e-4dbe-92c2-27e54183fb87	1716703	2023	74.2	83.94	48	{"agricultura": 40.1, "pecuaria": 36.4, "florestal": 47.2, "urbano": 3.8, "outros": 4.0}
cd55bb9c-2a98-4a7b-a810-1121719854aa	1717008	2019	44	21.42	71.8	{"agricultura": 42.5, "pecuaria": 23.9, "florestal": 17.4, "urbano": 13.4, "outros": 2.3}
b456b363-c7db-4ec6-a0c9-10522ebced88	1717008	2020	49.9	33.08	49.7	{"agricultura": 29.7, "pecuaria": 18.8, "florestal": 36.4, "urbano": 7.2, "outros": 9.6}
cd0d4764-94b4-49da-b0e0-68be23b90e73	1717008	2021	58.3	121.9	61.2	{"agricultura": 56.9, "pecuaria": 22.6, "florestal": 34.4, "urbano": 13.6, "outros": 3.0}
19a839c3-df4e-43df-89e3-cda4266de0be	1717008	2022	23.1	150.53	50	{"agricultura": 47.2, "pecuaria": 33.0, "florestal": 28.6, "urbano": 9.2, "outros": 7.0}
49af1585-db35-4886-a077-daf9dfe261fc	1717008	2023	65.5	145.18	36.8	{"agricultura": 47.1, "pecuaria": 29.9, "florestal": 22.4, "urbano": 3.8, "outros": 8.0}
7d23bb4c-3300-4cb9-8298-02d873086729	1717206	2019	80	171.1	85.2	{"agricultura": 28.5, "pecuaria": 31.9, "florestal": 16.1, "urbano": 14.6, "outros": 1.4}
c82d7560-533e-4042-9671-e153b0523196	1717206	2020	66.8	177.06	88.2	{"agricultura": 39.0, "pecuaria": 36.3, "florestal": 33.1, "urbano": 4.9, "outros": 3.8}
693d73d7-6c7a-45be-b62d-8f856aeafff8	1717206	2021	80	100.87	36.6	{"agricultura": 51.2, "pecuaria": 22.4, "florestal": 38.3, "urbano": 10.3, "outros": 8.0}
d662b203-f942-4693-928a-0c0fb6337de8	1717206	2022	55.5	151.06	74.7	{"agricultura": 20.9, "pecuaria": 36.7, "florestal": 31.2, "urbano": 7.5, "outros": 5.9}
0339f45b-e3d5-4031-8827-ce33305841c3	1717206	2023	24.9	72.71	81.2	{"agricultura": 41.5, "pecuaria": 28.2, "florestal": 23.6, "urbano": 13.7, "outros": 6.3}
046f0fdb-2292-493b-9202-e123bb17a9d7	1717503	2019	27.7	109.5	81.1	{"agricultura": 46.4, "pecuaria": 31.2, "florestal": 40.3, "urbano": 9.0, "outros": 6.0}
69ee087c-1f56-4415-bde3-be8575439dab	1717503	2020	71.7	140.35	75.2	{"agricultura": 30.1, "pecuaria": 23.9, "florestal": 40.7, "urbano": 5.4, "outros": 8.1}
67048a0b-8bb3-4359-942f-f583b911fd11	1717503	2021	52.9	176.6	62.9	{"agricultura": 21.2, "pecuaria": 35.7, "florestal": 28.7, "urbano": 5.8, "outros": 4.8}
e019aafd-1b38-4b8b-b07b-95ae67ef867c	1717503	2022	35.2	100.73	54.9	{"agricultura": 54.3, "pecuaria": 29.8, "florestal": 36.4, "urbano": 2.1, "outros": 9.9}
ea4e87e3-4329-4584-921c-dd729f379e19	1717503	2023	83.1	124.65	60.2	{"agricultura": 42.1, "pecuaria": 23.5, "florestal": 22.6, "urbano": 6.4, "outros": 2.7}
8f403f63-a69a-4ee8-8ec5-2e56389a8e5b	1717800	2019	57.8	19.05	92.5	{"agricultura": 54.1, "pecuaria": 24.7, "florestal": 19.7, "urbano": 14.2, "outros": 8.8}
61285629-265c-415b-abd0-d002ff2b7dac	1717800	2020	81.6	175.41	47.8	{"agricultura": 21.3, "pecuaria": 16.5, "florestal": 25.6, "urbano": 14.1, "outros": 8.6}
feaa1dc7-1e4e-4f09-b94d-a9a0561e43cd	1717800	2021	16.7	170.67	84.1	{"agricultura": 41.0, "pecuaria": 26.0, "florestal": 15.2, "urbano": 8.4, "outros": 2.1}
5953aba2-42af-42b9-958b-f18be68a4105	1717800	2022	62.2	55.72	73.7	{"agricultura": 30.8, "pecuaria": 18.4, "florestal": 25.0, "urbano": 13.1, "outros": 4.8}
b7c364bb-1926-415f-92f1-2150643d0f05	1717800	2023	50.5	181.43	80.1	{"agricultura": 52.1, "pecuaria": 20.0, "florestal": 32.9, "urbano": 8.6, "outros": 5.9}
af761aac-0a43-489c-afc0-87bae0113494	1717909	2019	17.1	131.39	48.9	{"agricultura": 41.6, "pecuaria": 15.5, "florestal": 26.1, "urbano": 8.7, "outros": 2.4}
84783c10-0cb1-4a93-abbe-59ba7c067081	1717909	2020	89.9	58.31	93.7	{"agricultura": 33.1, "pecuaria": 23.2, "florestal": 36.1, "urbano": 11.5, "outros": 6.0}
c2d8503a-fbf1-4049-b43b-ea0730b46363	1717909	2021	41.6	156.35	90.8	{"agricultura": 40.3, "pecuaria": 24.2, "florestal": 30.7, "urbano": 6.5, "outros": 6.4}
431819af-b279-4378-a4df-e61d639b15b6	1717909	2022	75.6	110.51	66.7	{"agricultura": 31.7, "pecuaria": 11.9, "florestal": 49.5, "urbano": 9.6, "outros": 6.0}
0d90058a-1a30-4120-b8a0-10091c6cde5a	1717909	2023	61	24.95	36.6	{"agricultura": 31.2, "pecuaria": 35.8, "florestal": 36.6, "urbano": 2.1, "outros": 2.5}
6994fe19-79a6-4618-91f5-0c16dc21ff30	1718006	2019	50.8	13.55	61	{"agricultura": 26.1, "pecuaria": 30.5, "florestal": 48.8, "urbano": 2.3, "outros": 5.7}
9996a07d-c302-439e-8615-2b5cbf47cfcf	1718006	2020	24.6	183.51	45.6	{"agricultura": 35.1, "pecuaria": 27.7, "florestal": 47.5, "urbano": 7.0, "outros": 8.4}
30bca449-4a43-4bbe-bad1-219c5bc94377	1718006	2021	44	173.38	39.8	{"agricultura": 41.3, "pecuaria": 11.8, "florestal": 28.4, "urbano": 12.8, "outros": 8.2}
42f3d8ea-0aef-40e0-bf82-dfad98637cd7	1718006	2022	24.5	65.18	78.4	{"agricultura": 59.2, "pecuaria": 27.8, "florestal": 36.9, "urbano": 4.5, "outros": 7.8}
42187827-439c-4766-8e38-159d8fa99ab4	1718006	2023	68.7	121.72	65	{"agricultura": 52.3, "pecuaria": 23.6, "florestal": 34.0, "urbano": 11.5, "outros": 1.5}
ce96d51c-5ed8-4b41-86e3-801316b67d02	1718204	2019	44.6	138.45	67.2	{"agricultura": 21.5, "pecuaria": 12.2, "florestal": 24.7, "urbano": 5.9, "outros": 1.3}
5d9d480a-a148-4f9b-9fe4-b432f1366590	1718204	2020	80.9	131.78	36.8	{"agricultura": 34.1, "pecuaria": 35.0, "florestal": 41.0, "urbano": 3.2, "outros": 2.4}
11cd3940-30da-420f-8166-3e5751ff632c	1718204	2021	25.8	133.23	45.7	{"agricultura": 45.0, "pecuaria": 24.1, "florestal": 45.3, "urbano": 12.6, "outros": 8.4}
cde7d42a-2168-41bb-aa54-809d6279a6bb	1718204	2022	39.3	106.16	82	{"agricultura": 49.2, "pecuaria": 18.2, "florestal": 19.9, "urbano": 7.9, "outros": 5.5}
e8de1c59-b48e-4446-97cb-926cf513c082	1718204	2023	60.7	26.25	75.6	{"agricultura": 43.3, "pecuaria": 14.3, "florestal": 45.4, "urbano": 14.7, "outros": 7.6}
3f010523-97b8-4cf7-add3-7c02e9a0346a	1718303	2019	83.7	189.68	63.9	{"agricultura": 41.0, "pecuaria": 29.0, "florestal": 27.9, "urbano": 3.6, "outros": 5.8}
42f53dbc-42af-4464-bd77-3cfb371babba	1718303	2020	85.5	46.26	70.6	{"agricultura": 32.7, "pecuaria": 10.8, "florestal": 32.8, "urbano": 3.3, "outros": 2.3}
7666a933-0a1d-49fe-922e-1f27a4c583e4	1718303	2021	79.4	114.49	46.5	{"agricultura": 46.6, "pecuaria": 21.0, "florestal": 36.4, "urbano": 5.2, "outros": 4.5}
f9544dff-e8be-4e5e-95d7-cff80390754a	1718303	2022	26.9	76.96	72	{"agricultura": 36.0, "pecuaria": 19.7, "florestal": 43.0, "urbano": 8.7, "outros": 4.3}
a51d329d-a854-4817-a87e-2073d5f8d8f5	1718303	2023	61.2	68.68	41.8	{"agricultura": 38.0, "pecuaria": 28.0, "florestal": 15.3, "urbano": 13.6, "outros": 1.3}
7d0ca128-4a9e-498c-a67f-015a3f74435f	1718402	2019	58.3	172.91	54.7	{"agricultura": 49.4, "pecuaria": 35.3, "florestal": 44.8, "urbano": 11.6, "outros": 8.4}
92021163-a1f4-4604-a206-b17ed33d6bb2	1718402	2020	38.6	77.86	92.1	{"agricultura": 32.8, "pecuaria": 22.3, "florestal": 31.4, "urbano": 10.5, "outros": 3.9}
7d77a7cd-951e-47bd-8e77-d31150a2cab0	1718402	2021	82.8	177.53	37.8	{"agricultura": 30.5, "pecuaria": 14.6, "florestal": 49.8, "urbano": 3.2, "outros": 10.0}
b6f39f38-e47a-442e-95ec-3ad0ca1c314e	1718402	2022	35	156.52	85.7	{"agricultura": 58.1, "pecuaria": 19.2, "florestal": 25.1, "urbano": 13.7, "outros": 1.5}
f8e8cf30-d189-4eb6-996b-c6497011860d	1718402	2023	10.4	49.28	51.4	{"agricultura": 40.1, "pecuaria": 37.7, "florestal": 49.0, "urbano": 2.1, "outros": 1.4}
34ef64ba-5e50-4c21-a76e-aee8f2632355	1718451	2019	56.2	28.24	61.1	{"agricultura": 28.2, "pecuaria": 33.4, "florestal": 17.5, "urbano": 6.0, "outros": 3.8}
0dfa7ce0-695a-4335-a58a-f63cb2b09f2f	1718451	2020	17.8	36.07	92	{"agricultura": 48.9, "pecuaria": 17.3, "florestal": 28.7, "urbano": 6.4, "outros": 6.1}
abdacfc6-40e9-49a9-b650-822e3b02cb81	1718451	2021	20.2	72.82	55.6	{"agricultura": 56.5, "pecuaria": 34.4, "florestal": 35.4, "urbano": 12.9, "outros": 4.4}
dd89c4e3-7fe4-404e-8ffe-1df18e749d23	1718451	2022	18.8	42.47	48.9	{"agricultura": 59.1, "pecuaria": 31.0, "florestal": 27.4, "urbano": 4.5, "outros": 2.7}
7ffdea05-98c9-445d-bfc9-b406d5a27389	1718451	2023	16.8	187.79	64.3	{"agricultura": 58.0, "pecuaria": 27.9, "florestal": 40.3, "urbano": 10.1, "outros": 2.1}
6818c899-3814-46a9-b830-9439e042be68	1718501	2019	32.8	122.47	78.1	{"agricultura": 53.0, "pecuaria": 23.7, "florestal": 17.6, "urbano": 7.2, "outros": 5.2}
4a7c74d3-e240-47cf-8106-1e76f1dd0e19	1718501	2020	45.9	20.22	56	{"agricultura": 31.4, "pecuaria": 36.4, "florestal": 42.5, "urbano": 3.9, "outros": 3.0}
92c73353-8534-44d1-9c4f-81eb19284f73	1718501	2021	37.1	67.4	76.9	{"agricultura": 57.2, "pecuaria": 20.8, "florestal": 21.7, "urbano": 13.7, "outros": 7.3}
e9c2c956-3802-433e-8f5a-b8984b128ead	1718501	2022	57	86.67	72.2	{"agricultura": 20.3, "pecuaria": 28.5, "florestal": 25.6, "urbano": 4.7, "outros": 4.4}
98d4bc99-3267-45ba-b516-318c437ef609	1718501	2023	81	126.67	40.1	{"agricultura": 39.5, "pecuaria": 11.4, "florestal": 42.6, "urbano": 6.3, "outros": 9.4}
460637f6-6e36-419e-9b8e-16b4f5b02f0d	1718550	2019	11	62.81	90.7	{"agricultura": 42.1, "pecuaria": 26.3, "florestal": 38.2, "urbano": 5.9, "outros": 1.4}
e4b8a085-7dcc-4508-a235-40ffdc3c65bf	1718550	2020	54.3	89.83	81.3	{"agricultura": 42.6, "pecuaria": 36.4, "florestal": 47.1, "urbano": 5.4, "outros": 8.1}
f3974d02-40db-4962-870c-3a25ae194027	1718550	2021	56.3	6.21	48.4	{"agricultura": 53.1, "pecuaria": 14.3, "florestal": 26.9, "urbano": 2.9, "outros": 1.7}
b7c53b0e-af28-4265-bac0-09aeab44bbe5	1718550	2022	14.8	150.78	41.8	{"agricultura": 32.2, "pecuaria": 22.9, "florestal": 47.4, "urbano": 13.5, "outros": 4.5}
3cd3fd31-9b1e-44ee-a43a-9d4d0ffb5235	1718550	2023	19.4	134.1	39.4	{"agricultura": 44.8, "pecuaria": 14.7, "florestal": 32.0, "urbano": 13.5, "outros": 3.0}
c3f6aecd-0d43-43ec-99f9-e9067c1f4749	1718659	2019	81.3	172.36	86.4	{"agricultura": 54.3, "pecuaria": 21.9, "florestal": 35.6, "urbano": 11.5, "outros": 5.4}
aa6d0f9c-96b1-4aac-a9d4-af94f990d882	1718659	2020	36.2	32.41	92.1	{"agricultura": 24.4, "pecuaria": 34.1, "florestal": 40.2, "urbano": 12.1, "outros": 4.9}
6035c50c-b520-474a-844f-0d7fc2c6ab8f	1718659	2021	8.9	121.18	78.4	{"agricultura": 42.8, "pecuaria": 33.4, "florestal": 20.5, "urbano": 7.2, "outros": 6.0}
5487efc7-4e9d-43d3-bf19-4464f26d083f	1718659	2022	20.7	155.65	76.9	{"agricultura": 22.6, "pecuaria": 12.2, "florestal": 24.8, "urbano": 12.5, "outros": 4.2}
8f65ffcf-913e-478b-a095-7f8876695a28	1718659	2023	83.8	50.65	83.2	{"agricultura": 51.8, "pecuaria": 38.3, "florestal": 25.9, "urbano": 6.9, "outros": 2.3}
320b6664-bab2-4438-bd7a-382b77c2224f	1718709	2019	38.5	81	80	{"agricultura": 24.6, "pecuaria": 11.4, "florestal": 17.4, "urbano": 5.0, "outros": 1.5}
9c1f67e6-489e-491d-9fb2-066270059089	1718709	2020	5.6	188.44	40.7	{"agricultura": 49.6, "pecuaria": 31.0, "florestal": 40.6, "urbano": 8.1, "outros": 1.7}
2a59abb6-e780-45ba-a45e-c6b8cc3556f5	1718709	2021	6.4	33.34	39	{"agricultura": 43.9, "pecuaria": 10.2, "florestal": 38.8, "urbano": 9.7, "outros": 3.7}
90f6c9fc-a359-42a1-9263-62a296972476	1718709	2022	85.2	53.77	40.4	{"agricultura": 59.9, "pecuaria": 19.2, "florestal": 15.8, "urbano": 5.2, "outros": 8.6}
060b8fc6-8b51-4273-9573-f0b31fe24f02	1718709	2023	23.2	66.32	85.8	{"agricultura": 57.0, "pecuaria": 26.4, "florestal": 42.3, "urbano": 4.7, "outros": 7.2}
89e7ed32-4b77-43bd-993d-41462ca24fcd	1718758	2019	86.8	126.09	81	{"agricultura": 52.4, "pecuaria": 23.7, "florestal": 34.9, "urbano": 13.2, "outros": 6.0}
0ac2a3e0-e7f2-42b9-a638-386314a2922c	1718758	2020	29.4	185.85	49.3	{"agricultura": 42.1, "pecuaria": 13.5, "florestal": 15.2, "urbano": 4.2, "outros": 5.7}
393084cd-6608-44ec-bcb6-af3a1f3c3291	1718758	2021	45.9	24.79	71.1	{"agricultura": 40.7, "pecuaria": 33.5, "florestal": 37.9, "urbano": 4.4, "outros": 2.3}
1f1fb679-cf43-403d-a626-6529ad02e0df	1718758	2022	53.2	119.94	81.4	{"agricultura": 48.3, "pecuaria": 37.9, "florestal": 30.3, "urbano": 5.2, "outros": 5.1}
ad8c790a-7b6f-4378-be22-8b6ec5de9fd6	1718758	2023	27	120.9	61.6	{"agricultura": 21.5, "pecuaria": 33.1, "florestal": 44.0, "urbano": 2.6, "outros": 4.7}
19e653c8-5f66-4ff2-ac81-61f184482f3c	1718808	2019	32.6	121.67	66.9	{"agricultura": 53.2, "pecuaria": 32.8, "florestal": 26.4, "urbano": 6.6, "outros": 1.3}
872fcdc9-2ced-429a-8d6a-0352f381de90	1718808	2020	14.2	6.35	35.8	{"agricultura": 41.1, "pecuaria": 36.0, "florestal": 30.4, "urbano": 13.6, "outros": 5.1}
5cfda5d2-7737-4c53-8cf2-86de06895177	1718808	2021	34.4	116.19	39.4	{"agricultura": 59.4, "pecuaria": 35.8, "florestal": 30.8, "urbano": 9.5, "outros": 8.4}
0834e730-8d30-43d1-b2e7-4b7d834a294f	1718808	2022	36.6	188.95	72.3	{"agricultura": 52.2, "pecuaria": 15.7, "florestal": 30.2, "urbano": 7.2, "outros": 8.1}
b29a93ba-3469-4d50-90ef-e945ef41d949	1718808	2023	85.9	47.1	94	{"agricultura": 41.9, "pecuaria": 34.0, "florestal": 48.1, "urbano": 10.4, "outros": 7.0}
bc8b24be-a913-43f0-8260-c8c3213c070c	1718840	2019	84.4	9.83	48.9	{"agricultura": 34.2, "pecuaria": 36.6, "florestal": 43.7, "urbano": 11.3, "outros": 5.2}
cfeb5b2a-07d2-4e19-82a1-316c9d543853	1718840	2020	50.6	119.77	70.9	{"agricultura": 58.8, "pecuaria": 22.8, "florestal": 48.7, "urbano": 6.0, "outros": 2.8}
7c9afe97-d404-4b33-adc8-6dbc5f4805ab	1718840	2021	85.1	62.53	44.9	{"agricultura": 29.9, "pecuaria": 33.1, "florestal": 24.2, "urbano": 7.9, "outros": 6.9}
04f6e0f9-b000-453a-9cf5-45d537d841dc	1718840	2022	41.6	57.77	61.9	{"agricultura": 41.2, "pecuaria": 30.8, "florestal": 21.1, "urbano": 5.4, "outros": 3.9}
49f73137-1ffe-4835-8593-6aad02337a88	1718840	2023	84.8	180.99	45.1	{"agricultura": 33.9, "pecuaria": 28.8, "florestal": 48.2, "urbano": 3.8, "outros": 8.0}
3404c467-99f5-4606-9f39-9412bea7ad56	1718865	2019	45.6	118.18	82.5	{"agricultura": 42.9, "pecuaria": 29.0, "florestal": 39.6, "urbano": 12.5, "outros": 10.0}
af10db6c-6658-427a-9a7c-b3ad4b42090d	1718865	2020	80.8	54.23	39.8	{"agricultura": 28.2, "pecuaria": 31.8, "florestal": 49.4, "urbano": 14.2, "outros": 7.2}
fbdc0b06-fd83-4904-bdc4-753b273290f3	1718865	2021	53.3	168.11	88	{"agricultura": 22.3, "pecuaria": 16.9, "florestal": 27.6, "urbano": 7.9, "outros": 5.1}
1314fc08-b665-443a-a110-559a1d89287c	1718865	2022	78.1	103.5	69.5	{"agricultura": 26.6, "pecuaria": 10.1, "florestal": 35.0, "urbano": 2.5, "outros": 5.3}
4b5ca7fa-8f9b-4481-a625-e7b9e0478985	1718865	2023	7.3	57.86	81.4	{"agricultura": 41.0, "pecuaria": 29.1, "florestal": 48.4, "urbano": 10.2, "outros": 6.3}
052316ff-779d-45f0-80e2-844c3e7ad22e	1718881	2019	94.9	35.44	44.8	{"agricultura": 41.7, "pecuaria": 39.0, "florestal": 33.1, "urbano": 13.3, "outros": 2.4}
1fffb4fd-a277-4212-af74-038feed6a08f	1718881	2020	14.7	183.91	65.4	{"agricultura": 20.5, "pecuaria": 24.6, "florestal": 47.3, "urbano": 12.1, "outros": 1.3}
b03fca7e-e4ee-4459-b79a-bb51d1214f0a	1718881	2021	32.9	43.21	71.2	{"agricultura": 52.9, "pecuaria": 23.1, "florestal": 46.9, "urbano": 14.0, "outros": 5.4}
bf347a11-c50c-415a-a76d-75243457cf35	1718881	2022	79.3	141.5	61.3	{"agricultura": 52.9, "pecuaria": 11.7, "florestal": 43.3, "urbano": 13.0, "outros": 4.7}
4c5e8d1f-ed79-431d-b053-e09ae74d7316	1718881	2023	68.7	61.65	78.9	{"agricultura": 23.4, "pecuaria": 26.3, "florestal": 41.0, "urbano": 14.3, "outros": 6.3}
7f671d4c-ee53-4c63-875b-c8363b80fb1d	1718899	2019	45.4	73.09	66.8	{"agricultura": 52.2, "pecuaria": 29.9, "florestal": 23.1, "urbano": 10.2, "outros": 2.0}
e28fe5e6-cff4-4c4b-ad0e-a0845eb50271	1718899	2020	18.3	187.4	40.3	{"agricultura": 41.0, "pecuaria": 24.1, "florestal": 46.1, "urbano": 6.1, "outros": 3.0}
c7f5d929-3616-4e9e-8f6b-ffede512b703	1718899	2021	80.6	157.88	54.9	{"agricultura": 32.4, "pecuaria": 26.1, "florestal": 17.4, "urbano": 15.0, "outros": 8.9}
65fa5afc-9fc6-4ed4-bbe1-e56b35d363b3	1718899	2022	87	112.87	44.4	{"agricultura": 49.7, "pecuaria": 15.9, "florestal": 48.1, "urbano": 8.0, "outros": 9.2}
105cf5ff-6345-49af-aa31-e7c2096e0b5d	1718899	2023	26.5	36.94	79.1	{"agricultura": 42.6, "pecuaria": 17.6, "florestal": 39.6, "urbano": 14.7, "outros": 6.7}
91dc91c2-412c-46db-8903-7699bfac5cd0	1718907	2019	36	151.77	62.7	{"agricultura": 55.6, "pecuaria": 27.9, "florestal": 23.5, "urbano": 10.3, "outros": 4.7}
718ce7b6-4cd5-4d5b-a2bb-cbb2bda0016f	1718907	2020	90.6	174.76	92.5	{"agricultura": 47.6, "pecuaria": 16.7, "florestal": 19.5, "urbano": 2.2, "outros": 4.7}
040e517f-0520-4cf6-b23b-bfc1fb26b14f	1718907	2021	27.8	48.88	86.2	{"agricultura": 39.6, "pecuaria": 17.0, "florestal": 31.4, "urbano": 12.9, "outros": 9.6}
4ea093d0-fb70-41d3-a97f-cc87c43e15e2	1718907	2022	59.3	150.86	52.7	{"agricultura": 56.0, "pecuaria": 18.4, "florestal": 23.0, "urbano": 7.2, "outros": 5.0}
e75b6648-06be-4e72-a085-6fc35f0ef7b4	1718907	2023	14.2	91.65	49.4	{"agricultura": 54.0, "pecuaria": 14.0, "florestal": 42.0, "urbano": 6.7, "outros": 3.8}
06cc9efa-22db-4f6d-96c7-11cd7cabaeee	1719004	2019	13	180.7	39.5	{"agricultura": 59.7, "pecuaria": 15.6, "florestal": 33.6, "urbano": 11.5, "outros": 5.1}
bffd7327-c66d-415d-800f-4421f8d96698	1719004	2020	18.2	177.86	36.1	{"agricultura": 42.6, "pecuaria": 22.4, "florestal": 39.5, "urbano": 11.6, "outros": 4.7}
442bade8-6d7c-4f1b-9db6-39c16b7eaa95	1719004	2021	61.6	28.48	86.3	{"agricultura": 34.1, "pecuaria": 26.3, "florestal": 26.1, "urbano": 7.3, "outros": 6.6}
6165e675-90b6-4062-bd73-e345aa283bdd	1719004	2022	78.5	15.75	40.2	{"agricultura": 46.8, "pecuaria": 19.9, "florestal": 39.9, "urbano": 6.2, "outros": 7.3}
dcf4b411-c189-402e-b48e-6f7bfa767e86	1719004	2023	85.3	137.5	46.5	{"agricultura": 46.6, "pecuaria": 39.5, "florestal": 19.5, "urbano": 9.1, "outros": 6.6}
06fe3a7b-dcf4-4e1c-b08a-bbe7101b8181	1720002	2019	67.4	70.31	94.7	{"agricultura": 33.1, "pecuaria": 16.3, "florestal": 16.1, "urbano": 13.9, "outros": 8.3}
efd7ecc0-3787-477e-90dd-f142d517cc88	1720002	2020	22	165.49	39.9	{"agricultura": 29.1, "pecuaria": 32.5, "florestal": 44.3, "urbano": 3.4, "outros": 5.4}
113fa883-a81a-47a3-a444-fad96113aa0d	1720002	2021	49.3	9.46	39.8	{"agricultura": 46.7, "pecuaria": 25.8, "florestal": 49.0, "urbano": 12.6, "outros": 7.6}
4744316b-ae7e-4e1f-83b7-dd6fa44d3e73	1720002	2022	17.8	146.35	45.1	{"agricultura": 53.0, "pecuaria": 18.6, "florestal": 19.9, "urbano": 7.0, "outros": 3.4}
1584c785-3795-48fb-b3b3-512192bb1485	1720002	2023	83.1	40.51	85.1	{"agricultura": 31.1, "pecuaria": 17.0, "florestal": 44.5, "urbano": 6.7, "outros": 3.9}
ef36e1e5-1b36-47a6-ac97-b55902f6bc94	1720101	2019	65	167.43	90.3	{"agricultura": 31.8, "pecuaria": 13.0, "florestal": 49.6, "urbano": 13.8, "outros": 1.8}
3c9dbdd6-3c0f-43d6-8d6b-2ce46af63cd1	1720101	2020	64.5	71.82	43.8	{"agricultura": 40.0, "pecuaria": 21.4, "florestal": 23.4, "urbano": 10.1, "outros": 4.8}
1ee71b46-7211-4c33-a186-c9b158e58252	1720101	2021	7.7	55.86	77.5	{"agricultura": 55.6, "pecuaria": 30.0, "florestal": 28.1, "urbano": 10.1, "outros": 4.6}
cf248875-94e2-49bc-b268-e25c21d18f12	1720101	2022	47.6	74.86	92.6	{"agricultura": 42.5, "pecuaria": 33.4, "florestal": 16.9, "urbano": 9.5, "outros": 6.5}
b0d27a96-a35c-44ac-9338-3a7bb96b65cd	1720101	2023	5.4	155.3	77.1	{"agricultura": 59.2, "pecuaria": 34.3, "florestal": 29.1, "urbano": 13.1, "outros": 9.9}
94df560e-be04-4802-9619-8d291c7d463e	1720150	2019	14.2	86.27	35.3	{"agricultura": 43.9, "pecuaria": 26.1, "florestal": 18.3, "urbano": 5.9, "outros": 3.6}
81decf1c-d409-4bda-9d29-d53ebfd5d3f7	1720150	2020	29.7	98.85	93.2	{"agricultura": 33.0, "pecuaria": 31.9, "florestal": 19.7, "urbano": 12.0, "outros": 2.8}
7e972a14-f1a8-419c-bfbd-b3c847f8fd48	1720150	2021	45.8	161.51	91.4	{"agricultura": 22.3, "pecuaria": 10.8, "florestal": 43.7, "urbano": 14.9, "outros": 6.8}
908bacf8-3527-4dd4-afa9-816bf049eff6	1720150	2022	16.2	124.69	51.4	{"agricultura": 25.6, "pecuaria": 24.1, "florestal": 41.7, "urbano": 10.4, "outros": 7.4}
f8a3c09d-437c-44cf-b730-b272dbd335d1	1720150	2023	89.3	21.2	65	{"agricultura": 49.0, "pecuaria": 13.2, "florestal": 34.5, "urbano": 8.4, "outros": 2.9}
ca9054f8-4a01-4185-bbdc-87fa9d473ab7	1720200	2019	87.6	117.15	76.3	{"agricultura": 47.5, "pecuaria": 11.9, "florestal": 17.0, "urbano": 12.3, "outros": 2.1}
5ba30123-e623-425f-a2e5-a6a38d4ea0be	1720200	2020	27.1	157.93	84.3	{"agricultura": 60.0, "pecuaria": 21.5, "florestal": 22.0, "urbano": 11.2, "outros": 2.2}
92df183a-b763-48fb-a465-6d50db03411d	1720200	2021	53.3	145.7	55.5	{"agricultura": 29.8, "pecuaria": 38.0, "florestal": 26.5, "urbano": 7.4, "outros": 5.9}
34b3f69d-488c-44d9-a6b7-9a6c797c9e09	1720200	2022	36.7	178.03	91.5	{"agricultura": 36.0, "pecuaria": 25.8, "florestal": 15.7, "urbano": 6.2, "outros": 1.0}
8d5dbd53-ee84-4115-83e2-99faac76d6f9	1720200	2023	84.8	110.96	37.5	{"agricultura": 39.6, "pecuaria": 31.7, "florestal": 37.9, "urbano": 9.1, "outros": 3.9}
974a0141-2b06-491c-ad6a-915baee98624	1720259	2019	24	95.17	80.3	{"agricultura": 29.3, "pecuaria": 10.8, "florestal": 44.8, "urbano": 6.2, "outros": 1.7}
87f3092d-45f4-4c22-842a-ec29197f46f1	1720259	2020	49.9	18.14	89.2	{"agricultura": 49.5, "pecuaria": 31.2, "florestal": 37.5, "urbano": 4.4, "outros": 3.0}
06581497-5e80-4ede-ba90-83f0438501d0	1720259	2021	50	188.35	48.7	{"agricultura": 22.0, "pecuaria": 39.3, "florestal": 34.2, "urbano": 3.4, "outros": 4.2}
2be5fb78-f75c-40be-9c9e-679651911c3d	1720259	2022	80.4	47.92	75.8	{"agricultura": 35.4, "pecuaria": 24.3, "florestal": 41.4, "urbano": 4.9, "outros": 4.7}
c822bb63-fff0-4f94-85a9-bb28a3fa966e	1720259	2023	71.2	109.85	65.6	{"agricultura": 32.2, "pecuaria": 16.2, "florestal": 25.9, "urbano": 11.6, "outros": 4.0}
d35cb5fa-64a3-42a4-ab6f-1566ae79f45b	1720309	2019	36.8	62.35	46.1	{"agricultura": 58.6, "pecuaria": 39.9, "florestal": 21.1, "urbano": 13.6, "outros": 9.5}
b6221e5e-9826-4e78-a830-84e1d24a7e63	1720309	2020	31.2	22.86	80.5	{"agricultura": 33.1, "pecuaria": 26.9, "florestal": 16.5, "urbano": 14.3, "outros": 1.0}
3d3bfa3b-42a9-4359-8ed2-d6e3ace002f9	1720309	2021	80.4	26.17	60.1	{"agricultura": 37.1, "pecuaria": 16.5, "florestal": 16.1, "urbano": 11.3, "outros": 3.6}
5c235d3d-4b75-4ce1-ba7b-945a211aafd4	1720309	2022	39.4	145.96	51.8	{"agricultura": 45.2, "pecuaria": 39.9, "florestal": 39.8, "urbano": 5.7, "outros": 2.5}
e9e0ad9b-384a-4231-a9f4-06aff1a89407	1720309	2023	7.5	87.23	90.6	{"agricultura": 51.1, "pecuaria": 21.4, "florestal": 46.7, "urbano": 14.0, "outros": 1.7}
87b5e447-6fcb-4aec-9541-f248f443436f	1720499	2019	10.3	169.26	67.6	{"agricultura": 45.6, "pecuaria": 31.8, "florestal": 31.6, "urbano": 14.2, "outros": 8.9}
a5f03a5a-51ca-47e8-84ec-5d1dc11ba4c7	1720499	2020	53.2	72.48	92.7	{"agricultura": 46.8, "pecuaria": 15.6, "florestal": 23.7, "urbano": 10.6, "outros": 6.0}
893d177c-bbce-418c-ba41-ef49ae73b951	1720499	2021	83.4	47.65	49.3	{"agricultura": 22.1, "pecuaria": 17.9, "florestal": 34.0, "urbano": 2.7, "outros": 9.2}
ca4f2b13-eb8e-4fdc-92a1-78500a8dc14b	1720499	2022	84.7	110.82	90.3	{"agricultura": 51.4, "pecuaria": 35.5, "florestal": 19.9, "urbano": 14.9, "outros": 5.9}
fa16999c-2eee-4c1b-b6ed-3f4e264394d9	1720499	2023	31	24.31	69.9	{"agricultura": 31.5, "pecuaria": 12.3, "florestal": 25.7, "urbano": 11.7, "outros": 5.8}
348cb1a1-7a18-4b51-85d6-021a5901a036	1720655	2019	80.1	67.5	59.6	{"agricultura": 21.0, "pecuaria": 12.7, "florestal": 46.6, "urbano": 10.1, "outros": 5.2}
0125a8ff-c69a-4d4d-9ee7-8c3df09209c2	1720655	2020	83.1	37.22	58.6	{"agricultura": 32.6, "pecuaria": 33.8, "florestal": 32.4, "urbano": 10.3, "outros": 2.4}
36902b5c-7355-4fec-8ab5-09ef8da5856a	1720655	2021	36.1	154.58	42	{"agricultura": 30.0, "pecuaria": 24.3, "florestal": 41.4, "urbano": 10.2, "outros": 9.7}
9f2f2e97-653b-4e96-8c45-f1de7e6e16bc	1720655	2022	61.9	100.15	87.3	{"agricultura": 56.9, "pecuaria": 25.9, "florestal": 31.2, "urbano": 4.5, "outros": 3.9}
77129a09-763d-4c3c-8d40-44f03325995d	1720655	2023	20.6	70.28	45.1	{"agricultura": 39.7, "pecuaria": 14.3, "florestal": 22.2, "urbano": 3.0, "outros": 6.7}
2e7f6ca1-fbd9-4905-86b9-ac3dd7020adf	1720804	2019	15.6	111.47	51.3	{"agricultura": 38.4, "pecuaria": 29.0, "florestal": 19.5, "urbano": 10.1, "outros": 6.3}
e437b4ad-1645-42ab-86e6-057590464fea	1720804	2020	87.8	62.43	77.8	{"agricultura": 43.0, "pecuaria": 39.4, "florestal": 16.1, "urbano": 5.9, "outros": 8.8}
36b4fc18-2a07-412b-9274-5f4a20e92841	1720804	2021	42.3	162.2	78.2	{"agricultura": 29.8, "pecuaria": 27.7, "florestal": 42.3, "urbano": 8.3, "outros": 9.4}
3f1f835f-f3d4-42d4-9bd9-b43aae76d72b	1720804	2022	43	175.72	77	{"agricultura": 27.1, "pecuaria": 13.0, "florestal": 24.2, "urbano": 3.1, "outros": 9.5}
f06f7a75-1d5b-4b78-987e-b95f33217268	1720804	2023	63.7	64.64	92.6	{"agricultura": 27.9, "pecuaria": 16.5, "florestal": 43.1, "urbano": 6.2, "outros": 9.7}
5026dea7-9992-4b18-8560-626597a0c2f5	1720853	2019	12.3	186.43	49.5	{"agricultura": 58.0, "pecuaria": 25.0, "florestal": 37.0, "urbano": 12.2, "outros": 5.6}
0ba4d769-2fc1-46d4-bd2b-0c7c62aa428c	1720853	2020	15.7	104.88	87	{"agricultura": 49.7, "pecuaria": 28.9, "florestal": 44.3, "urbano": 12.3, "outros": 1.6}
a2f2476c-7168-4bbb-bb03-14f2b0f06e37	1720853	2021	10.6	158.14	64.9	{"agricultura": 28.1, "pecuaria": 30.5, "florestal": 28.6, "urbano": 11.9, "outros": 1.6}
ec799cb5-c2f4-402d-aaf9-1204bd8473f0	1720853	2022	66.6	47.87	55	{"agricultura": 29.8, "pecuaria": 15.0, "florestal": 46.1, "urbano": 2.7, "outros": 9.8}
2ca4c939-736b-4214-8e7b-f4236242dcc0	1720853	2023	82.7	106.15	72.7	{"agricultura": 44.1, "pecuaria": 16.7, "florestal": 40.8, "urbano": 8.2, "outros": 1.5}
6f5eb4bf-3e61-4492-8326-00b098601991	1720903	2019	47.6	8.68	56.2	{"agricultura": 52.2, "pecuaria": 30.4, "florestal": 34.4, "urbano": 9.1, "outros": 9.5}
8a331ecc-72ae-41b8-ae33-cd7386e73cce	1720903	2020	32.4	21.67	51.5	{"agricultura": 59.1, "pecuaria": 19.6, "florestal": 21.3, "urbano": 7.3, "outros": 2.3}
8543a94a-1aba-461d-ac22-7d867d7d6549	1720903	2021	74.4	70.22	93	{"agricultura": 20.7, "pecuaria": 17.5, "florestal": 15.6, "urbano": 10.3, "outros": 3.9}
b12b9e92-7f57-43f6-ada0-1fae89b1a318	1720903	2022	66.8	164.9	60.3	{"agricultura": 49.7, "pecuaria": 35.5, "florestal": 48.0, "urbano": 2.0, "outros": 4.6}
9d871a0c-ed07-4fec-9209-a6003a2996bd	1720903	2023	93.4	66.73	93.9	{"agricultura": 39.5, "pecuaria": 28.9, "florestal": 21.3, "urbano": 8.7, "outros": 6.2}
7ae2dd03-8d61-407c-bcec-e9aa3593e70f	1720937	2019	74.4	89.02	89	{"agricultura": 27.1, "pecuaria": 27.4, "florestal": 22.6, "urbano": 3.2, "outros": 2.5}
add12fc2-3804-4623-a6f4-62249c3689e5	1720937	2020	12.2	15.83	85	{"agricultura": 28.4, "pecuaria": 12.0, "florestal": 45.5, "urbano": 13.5, "outros": 4.5}
028fdb6f-f2fd-4ea0-a965-30af0cea3f0e	1720937	2021	45.7	133.27	61.4	{"agricultura": 25.8, "pecuaria": 11.3, "florestal": 34.7, "urbano": 3.6, "outros": 9.9}
e4b489bf-b966-46c0-9212-448fb5470955	1720937	2022	66.6	119.42	79.8	{"agricultura": 52.7, "pecuaria": 17.3, "florestal": 48.8, "urbano": 5.0, "outros": 9.9}
71ca0626-772e-4bd5-a6fe-e4856bdf56a5	1720937	2023	57.6	133.66	87.8	{"agricultura": 55.8, "pecuaria": 26.7, "florestal": 21.8, "urbano": 14.7, "outros": 1.2}
66e54a7e-8baf-49fa-8262-d9a285fbe14e	1720978	2019	32.6	30.88	52.6	{"agricultura": 30.8, "pecuaria": 18.4, "florestal": 41.9, "urbano": 4.0, "outros": 5.6}
ddfb3ba8-7051-4e47-a97b-9ee714852d28	1720978	2020	26.3	86.1	43	{"agricultura": 24.4, "pecuaria": 36.7, "florestal": 33.7, "urbano": 7.4, "outros": 4.8}
641e937a-6316-4afe-9736-ab06cd422a44	1720978	2021	41.2	82.41	37.2	{"agricultura": 42.6, "pecuaria": 37.7, "florestal": 41.2, "urbano": 10.5, "outros": 1.8}
126a17ae-f26c-4205-93f6-e37bc2a9b699	1720978	2022	41.5	48.95	48.6	{"agricultura": 25.8, "pecuaria": 17.0, "florestal": 16.2, "urbano": 8.4, "outros": 9.3}
dcc31024-69ee-4a75-98e7-14478f623e88	1720978	2023	17.3	86.32	82.7	{"agricultura": 24.3, "pecuaria": 33.1, "florestal": 41.1, "urbano": 3.9, "outros": 6.5}
d7a027d4-4f68-4afb-a63f-0a7847de8a3c	1721000	2019	27.5	24.83	89.5	{"agricultura": 55.8, "pecuaria": 22.2, "florestal": 28.0, "urbano": 5.7, "outros": 8.7}
98e5e6f9-f879-4f47-82d5-3572022d840e	1721000	2020	57.9	6.69	35.9	{"agricultura": 56.9, "pecuaria": 33.0, "florestal": 26.0, "urbano": 12.5, "outros": 3.5}
81d89e1b-71a3-40de-a90f-0ebdf64fff70	1721000	2021	67.3	59.1	56.1	{"agricultura": 44.3, "pecuaria": 31.5, "florestal": 40.0, "urbano": 10.5, "outros": 2.3}
cc0fa002-d88f-4d6b-9176-fa56d78030f8	1721000	2022	43.6	78.01	66.6	{"agricultura": 58.0, "pecuaria": 37.4, "florestal": 20.3, "urbano": 14.2, "outros": 5.3}
65dd247e-363f-4f10-97f5-4b3299941648	1721000	2023	52.3	120.45	49.5	{"agricultura": 44.3, "pecuaria": 17.0, "florestal": 33.7, "urbano": 3.2, "outros": 4.6}
26d040a3-ab06-4241-9d52-d2f4627d224d	1721109	2019	73.8	161.13	69.7	{"agricultura": 30.6, "pecuaria": 23.6, "florestal": 45.8, "urbano": 11.8, "outros": 9.7}
173d0db9-e054-46a4-b879-b473ad9645e8	1721109	2020	64.5	135.41	39	{"agricultura": 46.7, "pecuaria": 12.7, "florestal": 34.1, "urbano": 6.9, "outros": 5.9}
5a988abe-f7c3-4106-9b90-6927fbe5e629	1721109	2021	42.8	26.78	94.9	{"agricultura": 54.0, "pecuaria": 31.8, "florestal": 47.0, "urbano": 9.0, "outros": 5.8}
a17964c6-c028-42dc-a9aa-4d2fda23f6f8	1721109	2022	14.7	47.98	55.5	{"agricultura": 50.3, "pecuaria": 17.7, "florestal": 33.1, "urbano": 8.8, "outros": 7.7}
f0fab77d-962d-4e05-b96b-9f8e8d908b37	1721109	2023	84.9	88.54	80.7	{"agricultura": 49.6, "pecuaria": 11.4, "florestal": 35.7, "urbano": 8.5, "outros": 8.6}
61f9d4d9-df66-4ecb-88ee-3b097f0346ae	1721208	2019	67.9	165.95	38	{"agricultura": 28.0, "pecuaria": 21.2, "florestal": 27.5, "urbano": 2.0, "outros": 8.1}
31525d88-6486-4540-af4b-9e32c7c48e3a	1721208	2020	31.6	149.42	75	{"agricultura": 45.2, "pecuaria": 36.6, "florestal": 30.1, "urbano": 7.0, "outros": 3.9}
bd539d7e-c661-44cc-9f73-e2cb81fd0d2d	1721208	2021	49.4	185.55	90.4	{"agricultura": 20.8, "pecuaria": 37.5, "florestal": 20.9, "urbano": 9.5, "outros": 7.8}
2e790662-85cc-4d33-b1a5-b5d31babe748	1721208	2022	75.1	44	43.7	{"agricultura": 28.0, "pecuaria": 22.6, "florestal": 35.0, "urbano": 4.1, "outros": 5.2}
df3e611a-47b7-4486-89ba-e0806f0d12a9	1721208	2023	80.1	145.9	64.1	{"agricultura": 56.2, "pecuaria": 13.1, "florestal": 32.9, "urbano": 11.9, "outros": 5.3}
0287ad97-df40-4ce0-9066-cf29bd4002c7	1721257	2019	42.3	63.59	63.9	{"agricultura": 33.1, "pecuaria": 14.4, "florestal": 18.1, "urbano": 6.5, "outros": 4.5}
a5f145d7-bb2b-46ac-937c-2651117fa8db	1721257	2020	92.7	59.99	82.6	{"agricultura": 29.0, "pecuaria": 12.4, "florestal": 48.5, "urbano": 11.4, "outros": 6.4}
f84216ae-d645-484b-b504-bf2f8125d2b6	1721257	2021	84.7	38.49	91.3	{"agricultura": 34.2, "pecuaria": 18.9, "florestal": 27.7, "urbano": 7.9, "outros": 1.3}
4c49de6c-d1c9-4dff-b03e-4254bfb10fde	1721257	2022	49	1.35	37.2	{"agricultura": 49.8, "pecuaria": 37.7, "florestal": 37.6, "urbano": 2.6, "outros": 6.8}
93f72e39-2e39-458c-9682-87140d8b4e6d	1721257	2023	70.4	159.39	70.2	{"agricultura": 26.4, "pecuaria": 11.0, "florestal": 43.2, "urbano": 4.8, "outros": 4.8}
247a5a85-7586-443e-b195-88d2c0fa5df2	1721307	2019	71.1	148.74	50	{"agricultura": 36.7, "pecuaria": 32.2, "florestal": 41.3, "urbano": 8.1, "outros": 3.6}
1ea4fd4e-7576-4e25-86d9-c6ead919ee28	1721307	2020	8.2	92.46	45.1	{"agricultura": 45.3, "pecuaria": 32.3, "florestal": 25.9, "urbano": 3.7, "outros": 9.5}
c5e9d318-24f1-495e-b838-899c7ee6ad10	1721307	2021	62.2	12.51	40.6	{"agricultura": 56.8, "pecuaria": 35.1, "florestal": 43.2, "urbano": 6.6, "outros": 4.0}
58ea3a14-a43f-4b31-9f8b-d4f0a3bd8f80	1721307	2022	20.4	137.09	78.7	{"agricultura": 41.3, "pecuaria": 12.3, "florestal": 28.9, "urbano": 10.1, "outros": 7.4}
1ccf7bdb-232c-46ea-9bfd-d1ce238c8f2f	1721307	2023	84.9	30.34	62.1	{"agricultura": 50.3, "pecuaria": 17.7, "florestal": 22.8, "urbano": 14.1, "outros": 9.9}
e0405fc5-2133-42c8-a4f0-8374acbc0d89	1722081	2019	76.3	172.34	41.2	{"agricultura": 24.9, "pecuaria": 29.0, "florestal": 35.8, "urbano": 10.1, "outros": 5.5}
8d0525ba-d36e-4064-9d37-0b7183cf5fad	1722081	2020	91.1	61.82	53.6	{"agricultura": 43.3, "pecuaria": 33.3, "florestal": 45.9, "urbano": 14.8, "outros": 6.5}
c954edaf-223a-446a-8837-4df206c8543d	1722081	2021	49.3	20.55	55.9	{"agricultura": 53.3, "pecuaria": 20.1, "florestal": 38.2, "urbano": 5.6, "outros": 1.4}
a76af36a-4425-4611-a6dd-f99e8d5c0895	1722081	2022	28.7	97.34	45.1	{"agricultura": 23.0, "pecuaria": 24.7, "florestal": 42.4, "urbano": 2.9, "outros": 9.5}
bb4cd04e-ed93-484a-8674-c06b52c9d96b	1722081	2023	73.4	156.83	88.9	{"agricultura": 57.8, "pecuaria": 31.3, "florestal": 47.0, "urbano": 10.7, "outros": 2.4}
98dd6675-52de-4b1d-87f6-dec0be708b4b	1722107	2019	90.4	13.66	73.4	{"agricultura": 58.0, "pecuaria": 21.7, "florestal": 40.7, "urbano": 5.7, "outros": 9.8}
a7fe7a8d-2578-41ee-b82e-dd8d4b349ce4	1722107	2020	23.7	124.96	48.4	{"agricultura": 48.7, "pecuaria": 26.2, "florestal": 43.8, "urbano": 12.4, "outros": 9.2}
580dae6b-5d46-4199-8cc4-1da9ac0c6066	1722107	2021	47.8	140.15	79.2	{"agricultura": 35.4, "pecuaria": 23.6, "florestal": 46.8, "urbano": 7.6, "outros": 9.6}
9496fbce-4842-4829-958e-0f85486419a6	1722107	2022	16.2	150.04	79.3	{"agricultura": 37.4, "pecuaria": 39.0, "florestal": 20.8, "urbano": 10.2, "outros": 8.0}
cda2ad14-9aca-4e79-898a-98b566cc41fd	1722107	2023	88.9	160.92	80.8	{"agricultura": 28.3, "pecuaria": 16.9, "florestal": 25.1, "urbano": 7.0, "outros": 2.5}
\.


--
-- Data for Name: territories; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.territories (id, name, type, parent_id, area, metadata, coordinates) FROM stdin;
17	Tocantins	Estado	\N	\N	{"regiao": "Norte", "codigo_ibge": "17"}	0101000020E6100000F78777CAB42A48C047FAFE17195E24C0
1700251	Abreulândia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1700251", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E61000002B0CDB60F29348C0243E1CC98A3E23C0
1700301	Aguiarnópolis	Município	17	\N	{"uf": "TO", "codigo_ibge": "1700301", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E610000068A961646EBC47C08B20297D7C3D1AC0
1700350	Aliança do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1700350", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Gurupi"}	0101000020E6100000083FCCB96F7848C0EDCA78A5769C26C0
1700400	Almas	Município	17	\N	{"uf": "TO", "codigo_ibge": "1700400", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E610000098D3AFBECB9547C0B0B1A60DE22227C0
1700707	Alvorada	Município	17	\N	{"uf": "TO", "codigo_ibge": "1700707", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Gurupi"}	0101000020E6100000C6353E93FD8F48C0B08F4E5DF9F428C0
1701002	Ananás	Município	17	\N	{"uf": "TO", "codigo_ibge": "1701002", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E6100000BFF2203D450A48C0E7678FBC187719C0
1701051	Angico	Município	17	\N	{"uf": "TO", "codigo_ibge": "1701051", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E61000003707BE58CEEE47C00DBED5DFB78E19C0
1701101	Aparecida do Rio Negro	Município	17	\N	{"uf": "TO", "codigo_ibge": "1701101", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Porto Nacional"}	0101000020E6100000B767F1BD1AFD47C07728AF3A17E723C0
1701309	Aragominas	Município	17	\N	{"uf": "TO", "codigo_ibge": "1701309", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E61000006138D730434348C05DB6E74361A91CC0
1701903	Araguacema	Município	17	\N	{"uf": "TO", "codigo_ibge": "1701903", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E61000001874E72E2EC748C017CF45E80C9D21C0
1702000	Araguaçu	Município	17	\N	{"uf": "TO", "codigo_ibge": "1702000", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Rio Formoso"}	0101000020E6100000E31C75745CE948C0F148BC3C9DDB29C0
1702109	Araguaína	Município	17	\N	{"uf": "TO", "codigo_ibge": "1702109", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E6100000B0F0E489D61948C040FCFCF7E0C51CC0
1702158	Araguanã	Município	17	\N	{"uf": "TO", "codigo_ibge": "1702158", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E610000070A58DD9485248C0E1664C1CD4511AC0
1702208	Araguatins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1702208", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E61000000546A863DF0E48C0D43549E29B9C16C0
1702307	Arapoema	Município	17	\N	{"uf": "TO", "codigo_ibge": "1702307", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E61000009D0BC803368848C08877CAB447A11EC0
1702406	Arraias	Município	17	\N	{"uf": "TO", "codigo_ibge": "1702406", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E6100000687D25EBCB7847C0AE6F16E588DB29C0
1702554	Augustinópolis	Município	17	\N	{"uf": "TO", "codigo_ibge": "1702554", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E6100000E506E863E3F147C0881634886ADD15C0
1702703	Aurora do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1702703", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E610000001DC2C5E2C3447C0EBE2361AC06B29C0
1702901	Axixá do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1702901", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E6100000BBD05CA791E247C071E316F3737316C0
1703008	Babaçulândia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1703008", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E6100000AE9AE7887CE147C0B3614D6551D01CC0
1703057	Bandeirantes do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1703057", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E61000009CC58B85214A48C061DADC3DE50D1FC0
1703073	Barra do Ouro	Município	17	\N	{"uf": "TO", "codigo_ibge": "1703073", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Jalapão"}	0101000020E61000007715527E52D647C0BF524C9473D81EC0
1703107	Barrolândia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1703107", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E610000067D718CFFB5C48C0E469F981ABAC23C0
1703206	Bernardo Sayão	Município	17	\N	{"uf": "TO", "codigo_ibge": "1703206", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E6100000EACBD24ECD7248C0BB3775D487841FC0
1703305	Bom Jesus do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1703305", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Porto Nacional"}	0101000020E610000084B70721201548C0E92B483316ED21C0
1703602	Brasilândia do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1703602", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E610000067EB85A7FC3D48C007674BB1FEC620C0
1703701	Brejinho de Nazaré	Município	17	\N	{"uf": "TO", "codigo_ibge": "1703701", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Gurupi"}	0101000020E6100000533C2EAA454848C0E4A25A44140726C0
1703800	Buriti do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1703800", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E610000033BED474E21C48C0AF3209CD644615C0
1703826	Cachoeirinha	Município	17	\N	{"uf": "TO", "codigo_ibge": "1703826", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E61000009961A3ACDFF547C0F51263997E7918C0
1703842	Campos Lindos	Município	17	\N	{"uf": "TO", "codigo_ibge": "1703842", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Jalapão"}	0101000020E61000008C193CA7B46647C00268EFE76FE51FC0
1703867	Cariri do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1703867", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Gurupi"}	0101000020E610000037C9EAB1889448C0F7DBE8ADCBC627C0
1703883	Carmolândia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1703883", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E6100000A9177C9A933248C05CE509849D221CC0
1703891	Carrasco Bonito	Município	17	\N	{"uf": "TO", "codigo_ibge": "1703891", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E6100000FA522E43D20448C0BFDEB364444815C0
1703909	Caseara	Município	17	\N	{"uf": "TO", "codigo_ibge": "1703909", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E6100000C5B4256195FA48C05437177FDB8B22C0
1704105	Centenário	Município	17	\N	{"uf": "TO", "codigo_ibge": "1704105", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Jalapão"}	0101000020E6100000A85BD141F2AA47C0DE0CED52D9EA21C0
1704600	Chapada de Areia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1704600", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Rio Formoso"}	0101000020E61000006110A2C6CE9648C0743804D8914824C0
1705102	Chapada da Natividade	Município	17	\N	{"uf": "TO", "codigo_ibge": "1705102", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E61000005AC466367EE047C01448E4164E3927C0
1705508	Colinas do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1705508", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E61000001624C7E75F3C48C0C487C89F5E1F20C0
1705557	Combinado	Município	17	\N	{"uf": "TO", "codigo_ibge": "1705557", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E610000013DB38BDE64547C0414063CB97A029C0
1705607	Conceição do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1705607", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E6100000CAF962EFC5A547C0CB129D65167128C0
1706001	Couto Magalhães	Município	17	\N	{"uf": "TO", "codigo_ibge": "1706001", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E6100000927A4FE5B49648C0B5FCC0559EB820C0
1706100	Cristalândia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1706100", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Rio Formoso"}	0101000020E6100000AD68739CDB9848C0C39E76F86B3225C0
1706258	Crixás do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1706258", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Gurupi"}	0101000020E610000045D7851F9C7548C0617715AD373526C0
1706506	Darcinópolis	Município	17	\N	{"uf": "TO", "codigo_ibge": "1706506", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E6100000DD8A0E924FE047C0DB40704B9AD51AC0
1707009	Dianópolis	Município	17	\N	{"uf": "TO", "codigo_ibge": "1707009", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E6100000CD57C9C7EE6847C07EE200FA7D3F27C0
1707108	Divinópolis do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1707108", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E6100000EA2521EC6F9B48C0FBC3E0AB679A23C0
1707207	Dois Irmãos do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1707207", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E6100000F82D84E6848848C0AD0A1EF00A8222C0
1707306	Dueré	Município	17	\N	{"uf": "TO", "codigo_ibge": "1707306", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Rio Formoso"}	0101000020E61000004F5AB8ACC2A248C07C992842EAAE26C0
1707405	Esperantina	Município	17	\N	{"uf": "TO", "codigo_ibge": "1707405", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E61000004FB39B74B64448C0E778605B9A7615C0
1707553	Fátima	Município	17	\N	{"uf": "TO", "codigo_ibge": "1707553", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Rio Formoso"}	0101000020E6100000F3F807DB997348C0342669A3DF8325C0
1707652	Figueirópolis	Município	17	\N	{"uf": "TO", "codigo_ibge": "1707652", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Gurupi"}	0101000020E6100000522D7D433C9648C0108D9367034528C0
1707702	Filadélfia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1707702", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E61000003753211E89BF47C02F127FB9BB5B1DC0
1708205	Formoso do Araguaia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1708205", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Rio Formoso"}	0101000020E6100000E04092A34AC348C0553948E3AB9C27C0
1708254	Tabocão	Município	17	\N	{"uf": "TO", "codigo_ibge": "1708254", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E61000001E54E23AC64248C061116855F01C22C0
1708304	Goianorte	Município	17	\N	{"uf": "TO", "codigo_ibge": "1708304", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E61000006F0B3B31907748C0186C34CA448B21C0
1709005	Goiatins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1709005", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Jalapão"}	0101000020E610000039F471C861A847C08852318452DA1EC0
1709302	Guaraí	Município	17	\N	{"uf": "TO", "codigo_ibge": "1709302", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E61000005E10919A764148C08D429259BDAB21C0
1709500	Gurupi	Município	17	\N	{"uf": "TO", "codigo_ibge": "1709500", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Gurupi"}	0101000020E6100000D34F38BBB58848C086E63A8DB47427C0
1709807	Ipueiras	Município	17	\N	{"uf": "TO", "codigo_ibge": "1709807", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Porto Nacional"}	0101000020E6100000F40BC050D13848C087B3113E4A7B26C0
1710508	Itacajá	Município	17	\N	{"uf": "TO", "codigo_ibge": "1710508", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Jalapão"}	0101000020E610000014B35E0CE5E247C053E8BCC62EC920C0
1710706	Itaguatins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1710706", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E61000002A63320BA3BD47C064FC451A261417C0
1710904	Itapiratins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1710904", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Jalapão"}	0101000020E610000094EA4CEB800D48C04AE5924F34C420C0
1711100	Itaporã do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1711100", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E6100000501BD5E9405848C0B3CEF8BEB82421C0
1711506	Jaú do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1711506", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Gurupi"}	0101000020E6100000C679EEF3CE4B48C0857E01182A4E29C0
1711803	Juarina	Município	17	\N	{"uf": "TO", "codigo_ibge": "1711803", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E6100000D4426E2B628C48C0F3EA77BC243D20C0
1711902	Lagoa da Confusão	Município	17	\N	{"uf": "TO", "codigo_ibge": "1711902", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Rio Formoso"}	0101000020E6100000780F2B37ACCF48C04B94BDA59C9325C0
1711951	Lagoa do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1711951", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Jalapão"}	0101000020E6100000862172FA7AC847C018AF1E9CF49724C0
1712009	Lajeado	Município	17	\N	{"uf": "TO", "codigo_ibge": "1712009", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Porto Nacional"}	0101000020E6100000C120448D9D2D48C04DDC2A88818223C0
1712157	Lavandeira	Município	17	\N	{"uf": "TO", "codigo_ibge": "1712157", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E61000007FCEEEDAEF4047C0ADAAF298DC9329C0
1712405	Lizarda	Município	17	\N	{"uf": "TO", "codigo_ibge": "1712405", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Jalapão"}	0101000020E6100000D4D51D8B6D5647C09A56AFC7E93023C0
1712454	Luzinópolis	Município	17	\N	{"uf": "TO", "codigo_ibge": "1712454", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E6100000D65B5E1498ED47C0E71835046CC418C0
1712504	Marianópolis do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1712504", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E6100000A38F9EC7CDD348C042DC8B1EAE9723C0
1712702	Mateiros	Município	17	\N	{"uf": "TO", "codigo_ibge": "1712702", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Jalapão"}	0101000020E610000092CCEA1D6E3547C0327D0ADBAA1725C0
1712801	Maurilândia do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1712801", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E610000017BB7D5699C147C08BFB8F4C87CE17C0
1713205	Miracema do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1713205", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E61000009BEB8F8BC53248C0412F3773A31F23C0
1713304	Miranorte	Município	17	\N	{"uf": "TO", "codigo_ibge": "1713304", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E610000061FC34EECD4B48C063B83A00E20E23C0
1713601	Monte do Carmo	Município	17	\N	{"uf": "TO", "codigo_ibge": "1713601", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Porto Nacional"}	0101000020E6100000845CF3F45B0E48C011853BBC8C8725C0
1713700	Monte Santo do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1713700", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E610000056C09888127F48C0A43E24D7A80224C0
1713809	Palmeiras do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1713809", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E610000097C80567F0C547C0CA1B60E63B701AC0
1713957	Muricilândia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1713957", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E6100000ABECBB22F84D48C0D99942E735961CC0
1714203	Natividade	Município	17	\N	{"uf": "TO", "codigo_ibge": "1714203", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E6100000F3AE7AC03CDD47C0A081FD7C006B27C0
1714302	Nazaré	Município	17	\N	{"uf": "TO", "codigo_ibge": "1714302", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E6100000A8B4B409E6D447C0EC4A708F4A7E19C0
1714880	Nova Olinda	Município	17	\N	{"uf": "TO", "codigo_ibge": "1714880", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E6100000399B8E006E3648C088F6B182DF861EC0
1715002	Nova Rosalândia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1715002", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Rio Formoso"}	0101000020E610000015ADDC0BCC7448C0F2CEA10C552125C0
1715101	Novo Acordo	Município	17	\N	{"uf": "TO", "codigo_ibge": "1715101", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Jalapão"}	0101000020E610000081762C5B90D647C048A643A7E7ED23C0
1715150	Novo Alegre	Município	17	\N	{"uf": "TO", "codigo_ibge": "1715150", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E6100000A3AAAEE87B4947C053EA92718CD429C0
1715259	Novo Jardim	Município	17	\N	{"uf": "TO", "codigo_ibge": "1715259", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E6100000C48833750D5047C07353B93FCDA327C0
1715507	Oliveira de Fátima	Município	17	\N	{"uf": "TO", "codigo_ibge": "1715507", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Rio Formoso"}	0101000020E6100000700F9DF9307448C0C0CC77F0136B25C0
1715705	Palmeirante	Município	17	\N	{"uf": "TO", "codigo_ibge": "1715705", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E6100000EF61E58695F647C093533BC3D46E1FC0
1715754	Palmeirópolis	Município	17	\N	{"uf": "TO", "codigo_ibge": "1715754", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Gurupi"}	0101000020E61000001FCC37EC083448C0CFD90242EB152AC0
1716109	Paraíso do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1716109", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Rio Formoso"}	0101000020E61000008237A451817148C0066BF706BA5924C0
1716208	Paranã	Município	17	\N	{"uf": "TO", "codigo_ibge": "1716208", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E6100000E085ADD9CAEF47C0EECF4543C63B29C0
1716307	Pau D'Arco	Município	17	\N	{"uf": "TO", "codigo_ibge": "1716307", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E6100000B24C1AFE2EAF48C0A62B3300AF2A1EC0
1716505	Pedro Afonso	Município	17	\N	{"uf": "TO", "codigo_ibge": "1716505", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Porto Nacional"}	0101000020E6100000BE3C539E2F1648C05B1E108D93F321C0
1716604	Peixe	Município	17	\N	{"uf": "TO", "codigo_ibge": "1716604", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Gurupi"}	0101000020E6100000F1811DFF054548C0CE97CDD2041428C0
1716653	Pequizeiro	Município	17	\N	{"uf": "TO", "codigo_ibge": "1716653", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E6100000DC4B1AA3757748C01650A8A78F3021C0
1716703	Colméia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1716703", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E610000065EE10B5236048C0361E6CB1DB7721C0
1717008	Pindorama do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1717008", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E6100000AF5A99F04BC947C039B69E211C4326C0
1717206	Piraquê	Município	17	\N	{"uf": "TO", "codigo_ibge": "1717206", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E6100000C8C15BD6B32548C0B4C9E1934E141BC0
1717503	Pium	Município	17	\N	{"uf": "TO", "codigo_ibge": "1717503", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Rio Formoso"}	0101000020E61000000BD869FF5E9648C058B730C15FE224C0
1717800	Ponte Alta do Bom Jesus	Município	17	\N	{"uf": "TO", "codigo_ibge": "1717800", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E6100000FC5EF9E2413D47C0E8DB82A5BA2C28C0
1717909	Ponte Alta do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1717909", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Jalapão"}	0101000020E6100000E5E6C017CBC447C0DD02AED0AC7D25C0
1718006	Porto Alegre do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718006", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E61000007CF1457BBC8647C029194A37D33627C0
1718204	Porto Nacional	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718204", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Porto Nacional"}	0101000020E610000073C57BC49E3448C0D6FB32BD696725C0
1718303	Praia Norte	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718303", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E61000005E2C0C91D3E747C0C9E7154F3D9215C0
1718402	Presidente Kennedy	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718402", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E6100000A0EA460EC74048C01AEC3CE0701121C0
1718451	Pugmil	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718451", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Rio Formoso"}	0101000020E6100000368BBC51D07248C0CAD70A3FDDD924C0
1718501	Recursolândia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718501", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Jalapão"}	0101000020E61000003F8974E4ED9E47C01DF521B9467921C0
1718550	Riachinho	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718550", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E6100000506EDBF7A81148C0D8F8A7AF42C519C0
1718659	Rio da Conceição	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718659", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E61000006AF981AB3C7147C008CDAE7B2BCA26C0
1718709	Rio dos Bois	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718709", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E61000000A3A1048784448C08C474ECBB4AE22C0
1718758	Rio Sono	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718758", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Jalapão"}	0101000020E61000008E5C925E2FF347C0613E0FA441B022C0
1718808	Sampaio	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718808", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E61000006BEF535568F047C0E7A7380EBC6A15C0
1718840	Sandolândia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718840", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Rio Formoso"}	0101000020E6100000FA19283ADCF648C05B96AFCBF01329C0
1718865	Santa Fé do Araguaia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718865", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E6100000B1F215EEA65848C0662E7079AC991CC0
1718881	Santa Maria do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718881", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Porto Nacional"}	0101000020E6100000CFDE7426C8DF47C0CAC6DEE6E88C21C0
1718899	Santa Rita do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718899", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Gurupi"}	0101000020E610000043C3071B437448C06ACA04B28DBA25C0
1718907	Santa Rosa do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1718907", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E6100000C1A73979910F48C0ECFB709010E526C0
1719004	Santa Tereza do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1719004", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Jalapão"}	0101000020E61000002C6C617193E747C02FC4EA8F309024C0
1720002	Santa Terezinha do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1720002", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E6100000459BE3DC26D647C028EC472F0FBE19C0
1720101	São Bento do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1720101", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E610000097C4591135F347C0284701A2601618C0
1720150	São Félix do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1720150", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Jalapão"}	0101000020E6100000AF795567B55447C0B4E55C8AAB5224C0
1720200	São Miguel do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1720200", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E6100000C13170E591C947C091836D1F4D3816C0
1720259	São Salvador do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1720259", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Gurupi"}	0101000020E610000081C4C0841B1E48C06D36FBA82B8029C0
1720309	São Sebastião do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1720309", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E6100000B33973B44F1A48C0CFABF01DEB0815C0
1720499	São Valério	Município	17	\N	{"uf": "TO", "codigo_ibge": "1720499", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E61000000EA14ACD1E1E48C026016A6AD9F227C0
1720655	Silvanópolis	Município	17	\N	{"uf": "TO", "codigo_ibge": "1720655", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Porto Nacional"}	0101000020E6100000BFF04A92E71548C00165F8F47D4D26C0
1720804	Sítio Novo do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1720804", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E61000005364085B47D147C08774D3C1556916C0
1720853	Sucupira	Município	17	\N	{"uf": "TO", "codigo_ibge": "1720853", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Gurupi"}	0101000020E6100000B60B72BCA77448C0D65416855DF827C0
1720903	Taguatinga	Município	17	\N	{"uf": "TO", "codigo_ibge": "1720903", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E610000033D879C0E13747C0268FA7E507CE28C0
1720937	Taipas do Tocantins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1720937", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Dianópolis"}	0101000020E6100000DD54EE4FF37E47C0B96DDFA3FE6228C0
1720978	Talismã	Município	17	\N	{"uf": "TO", "codigo_ibge": "1720978", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Gurupi"}	0101000020E6100000FBC67CE5E68B48C09624CFF57D9829C0
1721000	Palmas	Município	17	\N	{"uf": "TO", "codigo_ibge": "1721000", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Porto Nacional"}	0101000020E6100000F78777CAB42A48C047FAFE17195E24C0
1721109	Tocantínia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1721109", "mesorregiao": "Oriental do Tocantins", "microrregiao": "Porto Nacional"}	0101000020E6100000C2A6CEA3E22F48C06058FE7C5B2023C0
1721208	Tocantinópolis	Município	17	\N	{"uf": "TO", "codigo_ibge": "1721208", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Bico do Papagaio"}	0101000020E6100000D8028C78FCB547C04C2C3AA3F74F19C0
1721257	Tupirama	Município	17	\N	{"uf": "TO", "codigo_ibge": "1721257", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E610000092BC299B281848C0DFE819B105F321C0
1721307	Tupiratins	Município	17	\N	{"uf": "TO", "codigo_ibge": "1721307", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Miracema do Tocantins"}	0101000020E61000003C16DBA4A21048C0FE58D29B9BCC20C0
1722081	Wanderlândia	Município	17	\N	{"uf": "TO", "codigo_ibge": "1722081", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E610000038AA89F491FB47C03018B72CBA681BC0
1722107	Xambioá	Município	17	\N	{"uf": "TO", "codigo_ibge": "1722107", "mesorregiao": "Ocidental do Tocantins", "microrregiao": "Araguaína"}	0101000020E6100000C1351C3B4D4448C018AEB3C645A219C0
\.


--
-- Name: economic_indicators economic_indicators_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.economic_indicators
    ADD CONSTRAINT economic_indicators_pkey PRIMARY KEY (id);


--
-- Name: environmental_indicators environmental_indicators_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.environmental_indicators
    ADD CONSTRAINT environmental_indicators_pkey PRIMARY KEY (id);


--
-- Name: indicator_metadata indicator_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.indicator_metadata
    ADD CONSTRAINT indicator_metadata_pkey PRIMARY KEY (id);


--
-- Name: knowledge_base knowledge_base_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.knowledge_base
    ADD CONSTRAINT knowledge_base_pkey PRIMARY KEY (id);


--
-- Name: social_indicators social_indicators_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.social_indicators
    ADD CONSTRAINT social_indicators_pkey PRIMARY KEY (id);


--
-- Name: territorial_indicators territorial_indicators_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.territorial_indicators
    ADD CONSTRAINT territorial_indicators_pkey PRIMARY KEY (id);


--
-- Name: territories territories_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.territories
    ADD CONSTRAINT territories_pkey PRIMARY KEY (id);


--
-- Name: idx_knowledge_base_embedding; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX idx_knowledge_base_embedding ON public.knowledge_base USING ivfflat (embedding_vector public.vector_cosine_ops) WITH (lists='10');


--
-- Name: idx_territories_coordinates; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX idx_territories_coordinates ON public.territories USING gist (coordinates);


--
-- Name: economic_indicators economic_indicators_territory_id_territories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.economic_indicators
    ADD CONSTRAINT economic_indicators_territory_id_territories_id_fk FOREIGN KEY (territory_id) REFERENCES public.territories(id);


--
-- Name: environmental_indicators environmental_indicators_territory_id_territories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.environmental_indicators
    ADD CONSTRAINT environmental_indicators_territory_id_territories_id_fk FOREIGN KEY (territory_id) REFERENCES public.territories(id);


--
-- Name: knowledge_base knowledge_base_territory_id_territories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.knowledge_base
    ADD CONSTRAINT knowledge_base_territory_id_territories_id_fk FOREIGN KEY (territory_id) REFERENCES public.territories(id);


--
-- Name: social_indicators social_indicators_territory_id_territories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.social_indicators
    ADD CONSTRAINT social_indicators_territory_id_territories_id_fk FOREIGN KEY (territory_id) REFERENCES public.territories(id);


--
-- Name: territorial_indicators territorial_indicators_territory_id_territories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.territorial_indicators
    ADD CONSTRAINT territorial_indicators_territory_id_territories_id_fk FOREIGN KEY (territory_id) REFERENCES public.territories(id);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

\unrestrict vtEOybGl1fRl7CUm4hwdmHQ5gNbxF8SamBjSfhpgQm09QsaNchTLET1T4msApKV

