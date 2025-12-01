# 📄 Schema Completo do Banco de Dados (27 Tabelas)

**Data:** 01/12/2025  
**Fonte:** Extração direta do banco de dados Neon (PostgreSQL)

---

## 🎯 Resumo da Estrutura

O banco de dados é composto por **27 tabelas**, organizadas em 7 categorias principais. Esta estrutura suporta o ciclo completo de aprendizagem dos agentes, a gestão de conhecimento e a auditoria do sistema.

| Categoria | Tabelas | Descrição |
|---|---|---|
| **Agentes (Memória)** | 4 | Armazena as análises geradas por cada agente. |
| **Agentes (Aprendizado)** | 4 | Estrutura para aprendizados intermediários (atualmente não usada). |
| **Agentes (Learning Evolution)** | 4 | Armazena os aprendizados evolutivos de cada agente. |
| **Indicadores** | 4 | Contém os dados brutos para cada uma das 4 dimensões. |
| **Territórios** | 3 | Tabelas de referência para municípios, regiões e estado. |
| **RAG/Knowledge** | 2 | Base de conhecimento central e metadados. |
| **Auditoria** | 1 | Registra todos os eventos do sistema. |
| **Geoespacial (PostGIS)** | 4 | Tabelas de suporte para funcionalidades geoespaciais. |
| **Views** | 1 | View consolidada de todos os aprendizados. |

---

## 📊 Detalhamento das Tabelas

### 1. Agentes (Memória)

- `agent_econ_memory`
- `agent_social_memory`
- `agent_terra_memory`
- `agent_ambient_memory`

### 2. Agentes (Aprendizado)

- `agent_econ_learning`
- `agent_social_learning`
- `agent_terra_learning`
- `agent_ambient_learning`

### 3. Agentes (Learning Evolution)

- `agent_econ_learning_evolution`
- `agent_social_learning_evolution`
- `agent_terra_learning_evolution`
- `agent_ambient_learning_evolution`

### 4. Indicadores

- `economic_indicators`
- `social_indicators`
- `territorial_indicators`
- `environmental_indicators`

### 5. Territórios

- `territories`
- `immediate_regions`
- `intermediate_regions`

### 6. RAG/Knowledge

- `knowledge_base`
- `knowledge_base_metadata`

### 7. Auditoria

- `audit_trail`

### 8. Geoespacial (PostGIS)

- `geography_columns`
- `geometry_columns`
- `spatial_ref_sys`
- `spatial_relations`

### 9. Views

- `all_learning_evolution`

---

## 🚀 Próximos Passos

- **Investigar o uso das tabelas `*_learning`** para determinar se são legadas ou parte de uma funcionalidade futura.
- **Utilizar a view `all_learning_evolution`** no desenvolvimento do Agente Orquestrador para análises globais.
