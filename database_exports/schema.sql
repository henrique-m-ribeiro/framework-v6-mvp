--
-- PostgreSQL database dump
--

\restrict aAwObrBxEqpMDy8NU9cflPkzaKaXuUxPubKb9MLRAh5sg04Qy1sroDnNuyfIBdh

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
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: vector; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA public;


--
-- Name: EXTENSION vector; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION vector IS 'vector data type and ivfflat and hnsw access methods';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: economic_indicators; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: environmental_indicators; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: indicator_metadata; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: knowledge_base; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: social_indicators; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: territorial_indicators; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: territories; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: economic_indicators economic_indicators_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.economic_indicators
    ADD CONSTRAINT economic_indicators_pkey PRIMARY KEY (id);


--
-- Name: environmental_indicators environmental_indicators_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.environmental_indicators
    ADD CONSTRAINT environmental_indicators_pkey PRIMARY KEY (id);


--
-- Name: indicator_metadata indicator_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indicator_metadata
    ADD CONSTRAINT indicator_metadata_pkey PRIMARY KEY (id);


--
-- Name: knowledge_base knowledge_base_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_base
    ADD CONSTRAINT knowledge_base_pkey PRIMARY KEY (id);


--
-- Name: social_indicators social_indicators_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.social_indicators
    ADD CONSTRAINT social_indicators_pkey PRIMARY KEY (id);


--
-- Name: territorial_indicators territorial_indicators_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.territorial_indicators
    ADD CONSTRAINT territorial_indicators_pkey PRIMARY KEY (id);


--
-- Name: territories territories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.territories
    ADD CONSTRAINT territories_pkey PRIMARY KEY (id);


--
-- Name: idx_knowledge_base_embedding; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_knowledge_base_embedding ON public.knowledge_base USING ivfflat (embedding_vector public.vector_cosine_ops) WITH (lists='10');


--
-- Name: idx_territories_coordinates; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_territories_coordinates ON public.territories USING gist (coordinates);


--
-- Name: economic_indicators economic_indicators_territory_id_territories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.economic_indicators
    ADD CONSTRAINT economic_indicators_territory_id_territories_id_fk FOREIGN KEY (territory_id) REFERENCES public.territories(id);


--
-- Name: environmental_indicators environmental_indicators_territory_id_territories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.environmental_indicators
    ADD CONSTRAINT environmental_indicators_territory_id_territories_id_fk FOREIGN KEY (territory_id) REFERENCES public.territories(id);


--
-- Name: knowledge_base knowledge_base_territory_id_territories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_base
    ADD CONSTRAINT knowledge_base_territory_id_territories_id_fk FOREIGN KEY (territory_id) REFERENCES public.territories(id);


--
-- Name: social_indicators social_indicators_territory_id_territories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.social_indicators
    ADD CONSTRAINT social_indicators_territory_id_territories_id_fk FOREIGN KEY (territory_id) REFERENCES public.territories(id);


--
-- Name: territorial_indicators territorial_indicators_territory_id_territories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.territorial_indicators
    ADD CONSTRAINT territorial_indicators_territory_id_territories_id_fk FOREIGN KEY (territory_id) REFERENCES public.territories(id);


--
-- PostgreSQL database dump complete
--

\unrestrict aAwObrBxEqpMDy8NU9cflPkzaKaXuUxPubKb9MLRAh5sg04Qy1sroDnNuyfIBdh

