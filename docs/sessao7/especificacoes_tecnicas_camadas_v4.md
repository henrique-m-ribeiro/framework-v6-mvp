# Especificações Técnicas: Arquitetura de 4 Camadas (v4.0)

**Data:** 29/11/2025  
**Versão:** 1.0  
**Autor:** Manus AI

---

## 1. Introdução

Este documento fornece as especificações técnicas detalhadas para cada uma das quatro camadas do **Modelo Conceitual RAG Evolutivo v4.0**. O objetivo é servir como um guia para desenvolvedores e arquitetos de dados, detalhando o schema de cada tabela, os tipos de dados, as chaves e o propósito de cada campo.

---

## 2. Camada 0: Dados Estruturados (Ingestão)

**Objetivo:** Servir como a fonte primária de dados quantitativos brutos e pré-processados, formando a base factual para todas as análises dos agentes.

### 2.1. Tabela: `territories`

Armazena as entidades territoriais (Municípios e o Estado do Tocantins).

| Coluna | Tipo de Dado | Chave | Descrição |
| :--- | :--- | :--- | :--- |
| `id` | `INTEGER` | PK | Identificador único do território. |
| `name` | `VARCHAR(255)` | | Nome do território. |
| `type` | `VARCHAR(50)` | | Tipo de território ('Município', 'Estado'). |
| `area` | `NUMERIC(15, 2)` | | Área total em km². |
| `population` | `INTEGER` | | População total (último censo). |
| `centroid` | `GEOMETRY(Point, 4326)` | | Coordenadas geográficas do centroide. |
| `geom` | `GEOMETRY(MultiPolygon, 4326)` | | Geometria completa do território. |

### 2.2. Tabela: `economic_indicators` (e análogas)

Armazena séries temporais de indicadores. A estrutura é similar para `social_indicators`, `territorial_indicators` e `environmental_indicators`.

| Coluna | Tipo de Dado | Chave | Descrição |
| :--- | :--- | :--- | :--- |
| `id` | `SERIAL` | PK | Identificador único do registro. |
| `territory_id` | `INTEGER` | FK (`territories.id`) | Chave estrangeira para o território. |
| `year` | `INTEGER` | | Ano da medição do indicador. |
| `gdp` | `NUMERIC(20, 2)` | | Produto Interno Bruto (PIB) em milhões. |
| `gdp_per_capita` | `NUMERIC(15, 2)` | | PIB per capita. |
| `employment_rate` | `NUMERIC(5, 2)` | | Taxa de emprego formal (%). |
| `sector_distribution` | `JSONB` | | Distribuição setorial (ex: `{"servicos": 60, ...}`). |

### 2.3. Tabela: `spatial_relations`

Armazena relações espaciais pré-computadas para otimizar consultas geoespaciais.

| Coluna | Tipo de Dado | Chave | Descrição |
| :--- | :--- | :--- | :--- |
| `id` | `SERIAL` | PK | Identificador único da relação. |
| `territory1_id` | `INTEGER` | FK (`territories.id`) | ID do primeiro território. |
| `territory2_id` | `INTEGER` | FK (`territories.id`) | ID do segundo território. |
| `relation_type` | `VARCHAR(50)` | | Tipo de relação ('distance', 'neighbor'). |
| `distance_km` | `NUMERIC(10, 2)` | | Distância em quilômetros entre os centroides. |

---

## 3. Camada 1: Memória Especializada (Análise Contextual)

**Objetivo:** Armazenar as análises detalhadas e contextualizadas geradas por cada agente, formando a memória de trabalho individual de cada especialista.

### 3.1. Tabela: `agent_econ_memory` (e análogas)

Armazena as análises geradas pelo Agente ECON. A estrutura é idêntica para `agent_social_memory`, `agent_terra_memory` e `agent_ambient_memory`.

| Coluna | Tipo de Dado | Chave | Descrição |
| :--- | :--- | :--- | :--- |
| `id` | `UUID` | PK | Identificador único universal da análise. |
| `territory_id` | `INTEGER` | FK (`territories.id`) | Chave estrangeira para o território analisado. |
| `analysis_date` | `TIMESTAMPZ` | | Data e hora em que a análise foi gerada. |
| `analysis_content` | `TEXT` | | Conteúdo completo da análise em Markdown. |
| `summary` | `TEXT` | | Resumo executivo da análise. |
| `embedding_vector` | `VECTOR(1536)` | | Vetor de embedding para busca semântica. |
| `confidence_score` | `NUMERIC(3, 2)` | | Confiança do agente na análise (0.00 a 1.00). |
| `version` | `INTEGER` | | Número da versão da análise para este território. |
| `is_latest` | `BOOLEAN` | | `TRUE` se for a versão mais recente da análise. |
| `superseded_by` | `UUID` | FK (self) | ID da análise que substituiu esta (se houver). |
| `metadata` | `JSONB` | | Metadados da geração (modelo LLM, tempo, etc.). |
| `data_sources` | `JSONB` | | Fontes de dados utilizadas na análise. |
| `indicators_used` | `JSONB` | | Indicadores específicos utilizados. |
| `user_feedback` | `JSONB` | | Feedback do usuário sobre a análise (ex: `{"rating": 5, ...}`). |

---

## 4. Camada 2: Aprendizado Evolutivo (Extração de Padrões)

**Objetivo:** Armazenar heurísticas, padrões e insights recorrentes extraídos das análises da Camada 1, permitindo que os agentes aprendam com a experiência.

### 4.1. Tabela: `agent_econ_learning` (e análogas)

Armazena os aprendizados do Agente ECON. A estrutura é idêntica para as demais tabelas de aprendizado.

| Coluna | Tipo de Dado | Chave | Descrição |
| :--- | :--- | :--- | :--- |
| `id` | `UUID` | PK | Identificador único do aprendizado. |
| `pattern_description`| `TEXT` | | Descrição do padrão identificado. |
| `heuristic` | `TEXT` | | A regra ou insight derivado do padrão. |
| `confidence_score` | `NUMERIC(3, 2)` | | Força do padrão (frequência de observação). |
| `applicable_to` | `JSONB` | | Contextos onde o padrão se aplica (ex: `{"type": "municipio", "population_gt": 50000}`). |
| `examples` | `JSONB` | | IDs de análises da Camada 1 que exemplificam o padrão. |
| `created_at` | `TIMESTAMPZ` | | Data e hora da extração do aprendizado. |

---

## 5. Camada 3: Memória Organizacional (Conhecimento Consolidado)

**Objetivo:** Servir como a base de conhecimento central, validada e compartilhada, contendo as análises mais importantes e os relatórios multi-agente.

### 5.1. Tabela: `knowledge_base`

| Coluna | Tipo de Dado | Chave | Descrição |
| :--- | :--- | :--- | :--- |
| `id` | `UUID` | PK | Identificador único do conhecimento. |
| `territory_id` | `INTEGER` | FK (`territories.id`) | Território associado (pode ser nulo). |
| `dimension` | `VARCHAR(100)` | | Dimensão do conhecimento (economia, social, multi-agente). |
| `content` | `TEXT` | | Conteúdo completo do conhecimento em Markdown. |
| `summary` | `TEXT` | | Resumo executivo. |
| `confidence_score` | `NUMERIC(3, 2)` | | Confiança agregada no conhecimento. |
| `sources` | `JSONB` | | IDs de análises (Camada 1) ou aprendizados (Camada 2) que originaram este conhecimento. |
| `created_at` | `TIMESTAMPZ` | | Data de criação. |
| `updated_at` | `TIMESTAMPZ` | | Data da última atualização. |

---

## 6. Infraestrutura de Suporte

**Objetivo:** Fornecer governança, rastreabilidade e auditoria para todo o sistema.

### 6.1. Tabela: `audit_trail`

| Coluna | Tipo de Dado | Chave | Descrição |
| :--- | :--- | :--- | :--- |
| `event_id` | `UUID` | PK | Identificador único do evento. |
| `event_type` | `VARCHAR(100)` | | Tipo de evento (ex: `ANALYSIS_GENERATED`, `LEARNING_EXTRACTED`). |
| `agent_id` | `VARCHAR(100)` | | ID do agente que gerou o evento (ex: `AGENT_ECON`). |
| `territory_id` | `INTEGER` | FK (`territories.id`) | Território associado ao evento. |
| `input_data` | `JSONB` | | Dados de entrada para a operação. |
| `output_data` | `JSONB` | | Dados de saída da operação. |
| `success` | `BOOLEAN` | | `TRUE` se a operação foi bem-sucedida. |
| `error_message` | `TEXT` | | Mensagem de erro, se houver. |
| `duration_ms` | `INTEGER` | | Duração da operação em milissegundos. |
| `timestamp` | `TIMESTAMPZ` | | Data e hora do evento. |
