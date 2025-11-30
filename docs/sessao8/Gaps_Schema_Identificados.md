# Análise de Gaps de Schema: Documentação vs. Realidade

**Projeto:** Framework de Superinteligência Territorial V6.0  
**Data:** 30/11/2025

---

## 🚨 Problema Crítico Identificado

Durante a implementação da Fase 2 do MVP (Ciclo de Aprendizagem Evolutiva), identificamos **incompatibilidades críticas** entre o schema das tabelas documentado no **Modelo Conceitual v4.0** e o schema real das tabelas no banco de dados PostgreSQL. Esses gaps impediram a conclusão dos testes de validação e destacam a necessidade de um alinhamento rigoroso entre a documentação e a implementação.

---

## 🔬 Análise Detalhada dos Gaps

### 1. Tabela `agent_econ_learning`

| Gap | Descrição |
|:---|:---|
| **Campos Ausentes** | A tabela existente não possui os campos essenciais para o ciclo de aprendizagem, como `agent_id`, `source_analysis_ids`, `learning_content`, `synthesis`, `novelty`, `redundancy`, `contradictions`, `confidence_score`, `version` e `is_latest`. |
| **Propósito Divergente** | A tabela existente parece ter sido criada para armazenar aprendizados genéricos ou curados, enquanto o ciclo de aprendizagem requer uma estrutura para armazenar aprendizados evolutivos automáticos. |

**Solução Implementada:**

- ✅ **Criamos novas tabelas** `agent_*_learning_evolution` com o schema correto e otimizado para o ciclo de aprendizagem.
- ✅ **Mantivemos a tabela original** para evitar quebras no aplicativo Replit, caso ele a utilize.

### 2. Tabela `agent_econ_memory`

| Gap | Descrição |
|:---|:---|
| **Campo `agent_id` Ausente** | A tabela existente não possui o campo `agent_id`, o que impede a associação de análises a agentes específicos. Este campo é **fundamental** para o funcionamento do ciclo de aprendizagem e para a evolução individual de cada agente. |
| **Nomenclatura Divergente** | O campo `analysis_content` na tabela real corresponde ao campo `content` na documentação. |

**Solução Proposta:**

- ⚠️ **É necessário criar e executar uma migração** para adicionar o campo `agent_id` (tipo `VARCHAR(255)`) à tabela `agent_econ_memory` e às outras tabelas de memória (`agent_social_memory`, `agent_terra_memory`, `agent_ambient_memory`).
- ⚠️ **É necessário popular o novo campo `agent_id`** com o ID do agente correspondente para todos os registros existentes.

---

## 💥 Impacto no Projeto

- **Bloqueio dos Testes:** A ausência do campo `agent_id` na tabela `agent_econ_memory` impede a execução dos testes de validação do ciclo de aprendizagem.
- **Risco de Inconsistência:** A divergência entre a documentação e a realidade pode levar a erros de desenvolvimento e a uma compreensão incorreta da arquitetura.
- **Atraso na Fase 2:** A necessidade de criar e executar migrações adiciona um passo extra à implementação da Fase 2.

---

## 🚀 Recomendações e Próximos Passos

1. **Priorizar a Migração:** A próxima sessão deve começar com a criação e execução da migração para adicionar o campo `agent_id` às tabelas de memória.

2. **Atualizar a Documentação:** Após a migração, o Modelo Conceitual v4.0 e a documentação de arquitetura devem ser atualizados para refletir o schema real e as decisões tomadas.

3. **Revisão de Schemas:** Antes de iniciar novas fases de desenvolvimento, é crucial realizar uma revisão completa dos schemas de todas as tabelas envolvidas para garantir o alinhamento.

---

Com a resolução desses gaps, o projeto estará em uma base muito mais sólida para avançar com a implementação do Ciclo de Aprendizagem Evolutiva e as fases subsequentes.
