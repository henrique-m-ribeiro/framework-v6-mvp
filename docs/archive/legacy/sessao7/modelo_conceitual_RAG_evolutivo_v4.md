# Modelo Conceitual RAG Evolutivo v4.0

**Data:** 29/11/2025  
**Versão:** 4.0  
**Autores:** Henrique Ribeiro, Manus AI

---

## 1. Introdução

O Modelo Conceitual RAG Evolutivo v4.0 representa a evolução do modelo v3.0, integrando as descobertas da análise da estrutura de banco de dados existente e do workflow do Agente ECON V2. A principal inovação é a formalização da **"Camada 0: Dados Estruturados"** e a documentação detalhada do **fluxo de dados completo** entre as camadas, consolidando a arquitetura de superinteligência territorial.

Este modelo descreve uma arquitetura de **4 camadas** projetada para permitir que um sistema multi-agentes não apenas acesse e processe informações, mas também **aprenda e evolua sua expertise** ao longo do tempo, mimetizando o desenvolvimento de um especialista humano.

## 2. Arquitetura de 4 Camadas

A arquitetura é composta por quatro camadas hierárquicas, cada uma com uma função específica no ciclo de vida do conhecimento:

1.  **Camada 0: Dados Estruturados (Ingestão)**
2.  **Camada 1: Memória Especializada (Análise Contextual)**
3.  **Camada 2: Aprendizado Evolutivo (Extração de Padrões)**
4.  **Camada 3: Memória Organizacional (Conhecimento Consolidado)**

### 2.1. Camada 0: Dados Estruturados (Ingestão)

**Status:** ✅ **Implementada e Populada**

**Função:** Servir como a **fonte primária de dados quantitativos** para o sistema. Esta camada armazena indicadores brutos, séries temporais e dados geoespaciais, que são a matéria-prima para as análises dos agentes.

**Componentes:**

| Tabela | Registros | Função |
| :--- | :--- | :--- |
| `economic_indicators` | 700 | Indicadores econômicos por território/ano |
| `social_indicators` | 1.114 | Indicadores sociais (IDHM, população, etc.) |
| `territorial_indicators` | 700 | Indicadores territoriais (área urbanizada, densidade) |
| `environmental_indicators` | 1.400 | Indicadores ambientais (desmatamento, CO2) |
| `indicator_metadata` | 35 | Metadados dos indicadores (descrição, fonte, unidade) |
| `territories` | 140 | Entidades territoriais (municípios + estado) |
| `spatial_relations` | 190 | Relações espaciais pré-computadas |

**Fluxo de Dados:**
- **Entrada:** Dados de APIs oficiais (IBGE, INPE, DataSUS), planilhas, documentos.
- **Processo:** Um **Agente de Extração de Dados (Data Collector)** é responsável por popular e atualizar essas tabelas.
- **Saída:** Dados estruturados e limpos, prontos para serem consumidos pela Camada 1.

### 2.2. Camada 1: Memória Especializada (Análise Contextual)

**Status:** ✅ **Implementada** (parcialmente populada)

**Função:** Armazenar as **análises detalhadas e contextualizadas** geradas por cada agente especializado. Esta é a memória de trabalho de cada agente, onde eles registram suas conclusões sobre territórios específicos.

**Componentes:**

| Tabela | Registros | Função |
| :--- | :--- | :--- |
| `agent_econ_memory` | 11 | Análises econômicas por território |
| `agent_social_memory` | 0 | Análises sociais por território |
| `agent_terra_memory` | 0 | Análises territoriais por território |
| `agent_ambient_memory` | 0 | Análises ambientais por território |

**Estrutura Chave:**
- `analysis_content` (TEXT): A análise completa em Markdown.
- `embedding_vector` (VECTOR): O vetor de embedding para busca semântica.
- `confidence_score` (NUMERIC): A confiança do agente na análise (0-1).
- `version`, `is_latest`, `superseded_by`: Campos para versionamento e iteração.
- `metadata`, `data_sources`, `indicators_used` (JSONB): Metadados ricos para rastreabilidade.

**Fluxo de Dados:**
- **Entrada:** Dados da Camada 0 + análises prévias da própria Camada 1 (via busca semântica).
- **Processo:** O agente especializado (ex: Agente ECON) gera uma análise usando LLM.
- **Saída:** Uma nova entrada na tabela de memória do agente, incluindo a análise, o embedding e os metadados.

### 2.3. Camada 2: Aprendizado Evolutivo (Extração de Padrões)

**Status:** ✅ **Implementada** (vazia)

**Função:** Extrair **padrões, heurísticas e insights recorrentes** das análises da Camada 1. Esta camada permite que os agentes aprendam com suas experiências e desenvolvam uma expertise que vai além da simples geração de análises.

**Componentes:**

| Tabela | Registros | Função |
| :--- | :--- | :--- |
| `agent_econ_learning` | 0 | Padrões econômicos recorrentes |
| `agent_social_learning` | 0 | Padrões sociais recorrentes |
| `agent_terra_learning` | 0 | Padrões territoriais recorrentes |
| `agent_ambient_learning` | 0 | Padrões ambientais recorrentes |

**Estrutura Chave:**
- `pattern_description` (TEXT): Descrição do padrão identificado.
- `heuristic` (TEXT): A regra ou insight derivado do padrão.
- `confidence_score` (NUMERIC): A força do padrão (quantas vezes foi observado).
- `applicable_to` (JSONB): Contextos onde o padrão se aplica.
- `examples` (JSONB): Exemplos de análises que geraram o padrão.

**Fluxo de Dados:**
- **Entrada:** Análises da Camada 1.
- **Processo:** Um **Ciclo de Aprendizagem Evolutiva** (workflow n8n periódico) analisa as memórias dos agentes, identifica padrões recorrentes e os armazena.
- **Saída:** Novas entradas nas tabelas de aprendizado, que serão usadas como contexto de alto nível em futuras análises.

### 2.4. Camada 3: Memória Organizacional (Conhecimento Consolidado)

**Status:** ✅ **Implementada e Populada**

**Função:** Servir como a **base de conhecimento central e consolidada** do sistema. Armazena as análises mais importantes, relatórios multi-agente e conhecimento validado que deve ser compartilhado entre todos os agentes.

**Componentes:**

| Tabela | Registros | Função |
| :--- | :--- | :--- |
| `knowledge_base` | 1 | Conhecimento consolidado e multi-agente |

**Estrutura Chave:**
- `content` (TEXT): O conteúdo do conhecimento.
- `summary` (TEXT): Resumo executivo.
- `dimension` (VARCHAR): A dimensão do conhecimento (economia, social, etc.).
- `sources` (JSONB): As fontes que originaram o conhecimento.

**Fluxo de Dados:**
- **Entrada:** Análises validadas da Camada 1 e padrões fortes da Camada 2.
- **Processo:** Um processo de **curadoria humana ou semi-automatizada** promove o conhecimento mais relevante para a Camada 3.
- **Saída:** Conhecimento de alta qualidade, disponível para todos os agentes e para o usuário final via aplicação web.

## 3. Fluxo de Dados Completo: O Ciclo de Vida do Conhecimento

O fluxo de dados completo descreve como a informação é transformada em conhecimento e, finalmente, em expertise.

**Passo 1: Ingestão (Camada 0)**
- O **Agente de Extração de Dados** coleta dados de APIs e os armazena nas tabelas de indicadores (`economic_indicators`, `social_indicators`, etc.).

**Passo 2: Geração da Análise (Camada 1)**
- Um agente especializado (ex: Agente ECON) é ativado.
- Ele consulta os dados da **Camada 0** (indicadores) e busca análises prévias na **Camada 1** (sua própria memória) via busca semântica.
- Ele também consulta os padrões da **Camada 2** (seus aprendizados) para obter contexto de alto nível.
- Com todo esse contexto, ele gera uma nova análise usando LLM.
- A nova análise é salva na **Camada 1** (`agent_econ_memory`), incluindo o embedding.

**Passo 3: Aprendizado (Camada 2)**
- Periodicamente, o **Ciclo de Aprendizagem Evolutiva** analisa as análises na **Camada 1**.
- Ele identifica padrões recorrentes (ex: "municípios com vocação turística e baixo saneamento têm crescimento limitado").
- Esses padrões são salvos como heurísticas na **Camada 2** (`agent_econ_learning`).

**Passo 4: Consolidação (Camada 3)**
- As análises mais importantes da **Camada 1** e os padrões mais fortes da **Camada 2** são promovidos para a **Camada 3** (`knowledge_base`).
- Este conhecimento consolidado se torna a "verdade" do sistema, acessível a todos.

**Passo 5: Feedback e Iteração**
- O usuário interage com o conhecimento na **Camada 3** (via aplicação web).
- O feedback do usuário (`user_feedback` na Camada 1) e o uso das análises retroalimentam o sistema, influenciando o `confidence_score` e o ciclo de aprendizagem.

## 4. Infraestrutura de Suporte

Além das 4 camadas, duas tabelas são cruciais para a governança e funcionamento do sistema:

- **`audit_trail`:** Registra todas as ações significativas de todos os agentes, garantindo rastreabilidade e auditoria completa.
- **`spatial_relations`:** Armazena distâncias e relações de vizinhança pré-computadas, otimizando as consultas do Agente TERRA.

## 5. Conclusão

O Modelo Conceitual RAG Evolutivo v4.0 fornece uma **arquitetura completa e robusta** para a construção de um sistema de superinteligência territorial. Ele formaliza o fluxo de dados desde a ingestão de dados brutos até a consolidação do conhecimento, passando pela análise contextual e pelo aprendizado evolutivo.

Com esta arquitetura, o sistema não é apenas um recuperador de informações, mas um **ecossistema de agentes que aprendem, evoluem e colaboram** para gerar insights cada vez mais profundos e precisos sobre o território.
