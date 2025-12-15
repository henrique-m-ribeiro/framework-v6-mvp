# Arquitetura Atual do Banco de Dados

**Data:** 29 de novembro de 2025  
**Projeto:** Framework de Superinteligência Territorial V6.0  
**Versão:** 4.0

---

## 🎯 Objetivo

Documentar a arquitetura atual do banco de dados PostgreSQL (Neon), incluindo todas as tabelas, relacionamentos e o fluxo de dados entre as 4 camadas do Modelo Conceitual RAG Evolutivo v4.0.

---

## 📊 Infraestrutura

- **Provedor:** Neon (PostgreSQL serverless)
- **Host:** `ep-noisy-math-aeyq5dvn.c-2.us-east-2.aws.neon.tech`
- **Porta:** `5432`
- **Banco de Dados:** `neondb`
- **Usuário:** `neondb_owner`
- **Extensões:**
  - `pgvector` (v0.8.0) - para embeddings vetoriais
  - `PostGIS` (v3.3.3) - para dados geoespaciais

---

## 🏛️ Arquitetura de 4 Camadas

![Diagrama do Fluxo de Dados v4.0](../sessao7/diagrama_fluxo_dados_v4.png)

### Camada 0: Dados Estruturados

**Função:** Fonte primária de dados quantitativos e factuais.

| Tabela | Descrição | Registros Atuais |
|:---|:---|:---:|
| `economic_indicators` | Indicadores econômicos (PIB, massa salarial, etc.) | 700 |
| `social_indicators` | Indicadores sociais (IDH, Gini, etc.) | 0 |
| `environmental_indicators` | Indicadores ambientais (desmatamento, etc.) | 0 |
| `territorial_indicators` | Indicadores territoriais (área, população, etc.) | 0 |
| `institutional_indicators` | Indicadores institucionais (gastos públicos, etc.) | 0 |

### Camada 1: Memória Especializada

**Função:** Armazenar documentos de referência curados para cada agente.

| Tabela | Descrição | Registros Atuais |
|:---|:---|:---:|
| `agent_econ_memory` | Memória do Agente ECON | 11 |
| `agent_social_memory` | Memória do Agente SOCIAL | 0 |
| `agent_terra_memory` | Memória do Agente TERRA | 190 |
| `agent_ambient_memory` | Memória do Agente AMBIENT | 0 |

### Camada 2: Aprendizado Evolutivo

**Função:** Armazenar padrões, heurísticas e aprendizados descobertos pelos agentes.

| Tabela | Descrição | Registros Atuais |
|:---|:---|:---:|
| `agent_econ_learning` | Aprendizados do Agente ECON | 0 |
| `agent_social_learning` | Aprendizados do Agente SOCIAL | 0 |
| `agent_terra_learning` | Aprendizados do Agente TERRA | 0 |
| `agent_ambient_learning` | Aprendizados do Agente AMBIENT | 0 |

### Camada 3: Memória Organizacional

**Função:** Armazenar as análises completas geradas pelos agentes.

| Tabela | Descrição | Registros Atuais |
|:---|:---|:---:|
| `knowledge_base` | Base de conhecimento com análises completas | 0 |

---

## 🛠️ Infraestrutura de Suporte

| Tabela | Descrição | Registros Atuais |
|:---|:---|:---:|
| `territories` | Cadastro de territórios (municípios, estados, etc.) | 139 |
| `audit_trail` | Tabela de auditoria para rastreabilidade de eventos | 83 |
| `spatial_relations` | Relações espaciais pré-computadas (distâncias, vizinhança) | 190 |

---

## 🔄 Fluxo de Dados

1. **Coleta:** Scripts em `scripts/data_collection/` coletam dados de fontes externas e populam a **Camada 0**.
2. **Curadoria:** Documentos de referência são curados e armazenados na **Camada 1**.
3. **Geração de Análise:**
   - Um agente é ativado (ex: Agente ECON).
   - Ele consulta a **Camada 0** (dados estruturados) e a **Camada 1** (documentos de referência).
   - Ele gera uma análise completa.
4. **Armazenamento:**
   - A análise completa é salva na **Camada 3** (`knowledge_base`).
   - Padrões e heurísticas identificados na análise são salvos na **Camada 2** (`agent_econ_learning`).
5. **Consumo:**
   - O aplicativo web no Replit consulta a **Camada 0** e a **Camada 3** para exibir dados e análises.
   - O chatbot de IA usa o conteúdo da **Camada 3** para responder perguntas.

---

## 🔗 Dependências

- O **aplicativo web no Replit** depende diretamente do schema e dos dados das Camadas 0 e 3.
- Os **workflows no n8n** dependem do schema de todas as 4 camadas.

Qualquer alteração no schema do banco de dados deve considerar o impacto nesses dois componentes.

---

**Última atualização:** 29 de novembro de 2025, 19:50 GMT-3
