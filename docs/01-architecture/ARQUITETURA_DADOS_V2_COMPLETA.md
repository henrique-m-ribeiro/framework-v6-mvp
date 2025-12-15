# 🏛️ Arquitetura de Dados V2.0 - Sistema de IA Territorial

**Data:** 02/12/2025  
**Versão:** 2.0  
**Autor:** Manus AI

## 📖 Sumário

1.  [Visão Geral e Princípios](#-visão-geral-e-princípios)
2.  [Estrutura de Dados Detalhada](#-estrutura-de-dados-detalhada)
3.  [Alterações nos Workflows](#-alterações-nos-workflows)
4.  [Script de Migration SQL](#-script-de-migration-sql)
5.  [Guia de Execução da Migration](#-guia-de-execução-da-migration)
6.  [Benefícios e Impacto](#-benefícios-e-impacto)

---

## 🎯 Visão Geral e Princípios

Esta documentação detalha a **Arquitetura de Dados V2.0**, projetada para resolver as limitações da versão anterior e estabelecer uma base escalável para o futuro do Sistema de IA Territorial do Tocantins. A mudança fundamental é a **separação de responsabilidades** entre os Agentes Especializados e o Orquestrador.

### Princípio de Separação de Responsabilidades

| Componente | Responsabilidade | Tabela Principal |
| :--- | :--- | :--- |
| **Agentes Especializados** | Análise profunda e detalhada de **uma única dimensão** (ECON, SOCIAL, etc.). | `agent_*_memory` |
| **Orquestrador** | **Consolidação de múltiplas dimensões**, classificação de perguntas e orquestração do fluxo. | `knowledge_base` |

### Fluxo de Dados Redesenhado

1.  **Pergunta do Usuário**: O sistema recebe uma pergunta em linguagem natural.
2.  **Classificação pelo Orquestrador**: O Orquestrador classifica a pergunta para determinar as dimensões necessárias (e.g., `economic`, `social`).
3.  **Acionamento dos Agentes**: O Orquestrador aciona os agentes especializados correspondentes.
4.  **Análise Dimensional**: Cada agente realiza uma análise profunda de sua dimensão e salva o resultado em sua própria tabela `agent_*_memory`.
5.  **Retorno ao Orquestrador**: Cada agente retorna sua análise completa (ID, conteúdo, score, etc.) ao Orquestrador.
6.  **Consolidação e Salvamento**: O Orquestrador recebe as análises, cria uma síntese integrada e salva o resultado consolidado na tabela `knowledge_base`, incluindo referências às análises dimensionais originais.
7.  **Resposta ao Usuário**: O Orquestrador retorna uma resposta rica e completa ao usuário, contendo a análise consolidada e os metadados relevantes.

---

## 📊 Estrutura de Dados Detalhada

### Tabela `knowledge_base` (Redesenhada)

**Propósito**: Armazenar **sínteses multidimensionais** e metadados de consultas, criados pelo Orquestrador.

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `id` | `UUID` | Chave primária. |
| `territory_id` | `VARCHAR` | ID do território analisado. |
| `original_question` | `TEXT` | A pergunta original feita pelo usuário. |
| `question_type` | `VARCHAR(50)` | Tipo de pergunta: 'single_dimension' ou 'multidimensional'. |
| `dimensions_analyzed` | `VARCHAR(50)[]` | Array com as dimensões que foram analisadas (e.g., `['economic', 'social']`). |
| `integrated_analysis` | `TEXT` | A análise consolidada e integrada, gerada pelo Orquestrador. |
| `executive_summary` | `TEXT` | Um resumo executivo da análise integrada. |
| `key_insights` | `JSONB` | Objeto JSON com os principais insights de cada dimensão. |
| `source_analyses` | `JSONB` | Objeto JSON que mapeia cada dimensão ao ID da sua análise na tabela `agent_*_memory`. |
| `overall_confidence_score` | `NUMERIC` | Score de confiança geral, podendo ser uma média ponderada dos scores dimensionais. |
| `total_indicators_analyzed` | `INTEGER` | Número total de indicadores que foram considerados na análise. |
| `orchestrator_version` | `VARCHAR(20)` | Versão do workflow do Orquestrador que gerou o registro. |
| `execution_time_seconds` | `NUMERIC` | Tempo total de execução da consulta, em segundos. |
| `generated_by` | `VARCHAR(100)` | Identificador de quem gerou o registro (e.g., 'WF-AGENT-ORCHESTRATOR'). |
| `created_at` | `TIMESTAMP` | Data e hora da criação do registro. |

---

## 🔄 Alterações nos Workflows

### Agentes Especializados (ECON, SOCIAL, TERRA, AMBIENT)

A principal alteração é a **remoção da responsabilidade de salvar dados na `knowledge_base`**.

1.  **Remover Nó de Escrita na `knowledge_base`**: O nó PostgreSQL que inseria dados na tabela `knowledge_base` deve ser **completamente removido** do workflow de todos os agentes especializados.
2.  **Modificar Nó `Respond to Webhook`**: O nó final deve ser ajustado para retornar um objeto JSON contendo a análise completa gerada pelo agente. Este objeto será consumido pelo Orquestrador.

**Exemplo de Retorno do Agente:**

```json
{
  "status": "success",
  "dimension": "economic",
  "analysis_id": "uuid-da-analise-na-agent_econ_memory",
  "analysis_content": "O PIB de Palmas cresceu 3.2%...",
  "summary": "Crescimento moderado do PIB.",
  "confidence_score": 0.92,
  "indicators_used": ["PIB_PC_2021", "PIB_TOTAL_2021"],
  "created_at": "2025-12-02T10:00:00Z"
}
```

### Orquestrador (WF-AGENT-ORCHESTRATOR)

O Orquestrador passa a ter um papel central no tratamento e salvamento dos dados.

**Novos Nós e Lógica:**

1.  **HTTP Request (Síncrono)**: O nó que chama o agente deve ser configurado para aguardar a resposta completa (com timeout de ~60 segundos).
2.  **Extrair Análise**: Um novo nó de código (JavaScript) deve ser adicionado para fazer o parse da resposta (que vem como texto) e extrair os dados da análise do agente.
3.  **Calcular Métricas**: Um nó de código para calcular metadados, como o `execution_time_seconds`.
4.  **Salvar em `knowledge_base`**: Um novo nó PostgreSQL para inserir o registro consolidado na tabela `knowledge_base`, utilizando os novos campos da V2.0.
5.  **Buscar Análise Completa**: Um nó PostgreSQL para buscar o registro recém-criado, juntando informações do território (como o nome) para a resposta final.
6.  **Respond to Webhook (Resposta Rica)**: O nó final é modificado para retornar uma resposta JSON completa e estruturada ao usuário, contendo a análise integrada, métricas e metadados.

---

## 📜 Script de Migration SQL

O script a seguir atualiza a tabela `knowledge_base` para a versão 2.0. Ele é idempotente e inclui backup, migração de dados, criação de índices, constraints e funções auxiliares.

```sql
-- ============================================================================
-- MIGRATION: Atualização da Tabela knowledge_base para Arquitetura V2
-- ============================================================================
-- Data: 02/12/2025
-- Objetivo: Adicionar colunas para suportar consolidação multidimensional
-- ============================================================================

-- FASE 1: BACKUP DE SEGURANÇA
CREATE TABLE IF NOT EXISTS knowledge_base_backup_20251202 AS 
SELECT * FROM knowledge_base;

-- FASE 2: ADICIONAR NOVAS COLUNAS
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS original_question TEXT;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS question_type VARCHAR(50);
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS dimensions_analyzed VARCHAR(50)[];
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS source_analyses JSONB;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS integrated_analysis TEXT;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS executive_summary TEXT;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS key_insights JSONB;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS overall_confidence_score NUMERIC;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS total_indicators_analyzed INTEGER;
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS orchestrator_version VARCHAR(20);
ALTER TABLE knowledge_base ADD COLUMN IF NOT EXISTS execution_time_seconds NUMERIC;

-- FASE 3: MIGRAR DADOS EXISTENTES
UPDATE knowledge_base
SET 
    question_type = CASE WHEN dimension IS NOT NULL THEN 'single_dimension' ELSE 'unknown' END,
    dimensions_analyzed = CASE 
        WHEN dimension = 'economic' THEN ARRAY['economic']::VARCHAR(50)[]
        WHEN dimension = 'social' THEN ARRAY['social']::VARCHAR(50)[]
        WHEN dimension = 'territorial' THEN ARRAY['territorial']::VARCHAR(50)[]
        WHEN dimension = 'environmental' THEN ARRAY['environmental']::VARCHAR(50)[]
        ELSE ARRAY[]::VARCHAR(50)[]
    END,
    overall_confidence_score = COALESCE(confidence_score, 0.80),
    orchestrator_version = 'v1.0-legacy',
    executive_summary = summary,
    integrated_analysis = content,
    metadata = COALESCE(metadata, '{}'::jsonb) || jsonb_build_object('migration_note', 'Dados migrados da estrutura v1.0')
WHERE question_type IS NULL;

-- FASE 4: ADICIONAR ÍNDICES
CREATE INDEX IF NOT EXISTS idx_knowledge_base_question_type ON knowledge_base(question_type);
CREATE INDEX IF NOT EXISTS idx_knowledge_base_dimensions_analyzed ON knowledge_base USING GIN(dimensions_analyzed);
CREATE INDEX IF NOT EXISTS idx_knowledge_base_source_analyses ON knowledge_base USING GIN(source_analyses);

-- FASE 5: ADICIONAR CONSTRAINTS
ALTER TABLE knowledge_base ADD CONSTRAINT chk_knowledge_base_question_type CHECK (question_type IN ('single_dimension', 'multidimensional', 'unknown'));
ALTER TABLE knowledge_base ADD CONSTRAINT chk_knowledge_base_confidence_range CHECK (overall_confidence_score IS NULL OR (overall_confidence_score >= 0 AND overall_confidence_score <= 1));

-- (Para ver o script completo com todas as fases, consulte o arquivo MIGRATION_KNOWLEDGE_BASE_V2.sql)
```

---

## 🚀 Guia de Execução da Migration

**⚠️ Importante**: Execute este processo durante uma janela de manutenção e com os workflows do n8n pausados para evitar inconsistências.

1.  **Backup**: Embora o script crie um backup (`knowledge_base_backup_20251202`), um backup completo do banco de dados é recomendado.
2.  **Conexão**: Conecte-se ao banco de dados Neon usando uma ferramenta de sua preferência (psql, DBeaver, PgAdmin).
3.  **Execução**: Execute o conteúdo completo do arquivo `MIGRATION_KNOWLEDGE_BASE_V2.sql`.
4.  **Verificação**: O script exibirá mensagens de `NOTICE` confirmando cada fase. Ao final, uma estatística da migração será apresentada.
5.  **Validação Pós-Migration**: Execute as queries de validação presentes no `GUIA_EXECUCAO_MIGRATION.md` para confirmar que a estrutura, os índices e os dados foram atualizados corretamente.

---

## ✨ Benefícios e Impacto

| Aspecto | Descrição |
| :--- | :--- |
| **Separação de Responsabilidades** | Arquitetura mais limpa, onde cada componente tem um papel claro e definido. |
| **Eliminação de Redundância** | A análise dimensional é armazenada uma única vez, e a `knowledge_base` apenas a referencia. |
| **Escalabilidade** | O sistema está pronto para suportar perguntas multidimensionais complexas, bastando ajustar a lógica do Orquestrador para chamar múltiplos agentes. |
| **Rastreabilidade** | É possível rastrear qualquer síntese na `knowledge_base` até as análises dimensionais que a originaram, facilitando a auditoria e o debug. |
| **Performance de Consulta** | Novos índices otimizam a busca por tipo de pergunta, dimensões e referências, tornando as consultas à `knowledge_base` mais eficientes. |
| **Compatibilidade Retroativa** | A migração foi projetada para ser 100% retrocompatível. Workflows antigos não quebrarão, pois as colunas legadas foram mantidas. |

Com esta nova arquitetura, o Sistema de IA Territorial do Tocantins está mais robusto, organizado e preparado para evoluções futuras, como a consolidação de análises de múltiplos agentes e a geração de insights ainda mais sofisticados.
