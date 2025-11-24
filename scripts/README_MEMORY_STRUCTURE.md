# Script de Criação da Estrutura de Memória Distribuída

**Framework de Inteligência Territorial V6.0**  
**Data:** 24 de novembro de 2025  
**Versão:** 1.0.0

---

## 🎯 OBJETIVO

Este script cria a estrutura de banco de dados para **memória distribuída por agente**, permitindo que cada agente especialista evolua como um especialista humano ao longo do tempo.

---

## 📋 O QUE O SCRIPT FAZ

### 1. Cria Tabelas de Memória Individual

Para cada um dos 4 agentes (ECON, SOCIAL, TERRA, AMBIENT):

- **`agent_*_memory`**: Armazena todas as análises geradas
  - Conteúdo da análise
  - Embedding vetorial (1536 dimensões)
  - Metadados, confidence score, feedback
  - Versionamento e rastreabilidade

### 2. Cria Tabelas de Aprendizado

Para cada agente:

- **`agent_*_learning`**: Armazena aprendizados acumulados
  - Padrões identificados
  - Insights únicos
  - Metodologias aprimoradas
  - Correções de erros

### 3. Cria Índices Otimizados

- **IVFFlat** para busca vetorial semântica (pgvector)
- **B-tree** para busca por território e data
- **GIN** para busca em metadados JSONB

### 4. Cria Triggers, Views e Funções

- **Triggers**: Atualização automática de timestamps
- **Views**: Estatísticas de memória e aprendizado
- **Funções**: Busca semântica auxiliar

---

## 🚀 COMO USAR

### Pré-requisitos

1. **PostgreSQL com pgvector instalado** (já está no Replit)
2. **Python 3.11+** (já está no Replit)
3. **Variável de ambiente `DATABASE_URL` configurada**

### Passo 1: Verificar Variável de Ambiente

No Replit, verifique se `DATABASE_URL` está configurada:

```bash
echo $DATABASE_URL
```

Se não estiver, configure no arquivo `.env` ou nas Secrets do Replit:

```
DATABASE_URL=postgresql://usuario:senha@host:5432/database
```

### Passo 2: Executar o Script

No Shell do Replit:

```bash
python3 scripts/create_agent_memory_structure.py
```

### Passo 3: Verificar Resultado

O script irá:

1. ✅ Conectar ao PostgreSQL
2. ✅ Executar o script SQL
3. ✅ Verificar tabelas criadas
4. ✅ Verificar índices criados
5. ✅ Verificar views criadas
6. ✅ Mostrar estatísticas iniciais

**Output esperado:**

```
======================================================================
    FRAMEWORK V6.0 - CRIAR ESTRUTURA DE MEMÓRIA DISTRIBUÍDA
======================================================================

Data: 24/11/2025 15:30:00
Objetivo: Criar tabelas de memória individual para os 4 agentes

ℹ️  Lendo arquivo SQL: /home/ubuntu/framework-v6-mvp/scripts/create_agent_memory_structure.sql
✅ Arquivo SQL lido com sucesso (15000 caracteres)
ℹ️  Conectando ao PostgreSQL...
✅ Conexão estabelecida com sucesso!
ℹ️  Executando script SQL...
✅ Script SQL executado com sucesso!
ℹ️  Verificando tabelas criadas...
✅ 8 tabelas criadas:
  • agent_ambient_learning (8192 bytes)
  • agent_ambient_memory (8192 bytes)
  • agent_econ_learning (8192 bytes)
  • agent_econ_memory (8192 bytes)
  • agent_social_learning (8192 bytes)
  • agent_social_memory (8192 bytes)
  • agent_terra_learning (8192 bytes)
  • agent_terra_memory (8192 bytes)
ℹ️  Verificando índices criados...
✅ 24 índices criados:
  • agent_ambient_learning: 3 índices
  • agent_ambient_memory: 5 índices
  • agent_econ_learning: 3 índices
  • agent_econ_memory: 5 índices
  • agent_social_learning: 3 índices
  • agent_social_memory: 5 índices
  • agent_terra_learning: 3 índices
  • agent_terra_memory: 5 índices
ℹ️  Verificando views criadas...
✅ 2 views criadas:
  • v_agent_learning_stats
  • v_agent_memory_stats
ℹ️  Consultando estatísticas iniciais...
ℹ️  Nenhuma análise ainda (tabelas vazias - OK para início)

======================================================================
              ✅ ESTRUTURA CRIADA COM SUCESSO!
======================================================================

Próximos passos:
  1. Importar workflows dos 4 agentes no n8n Cloud
  2. Configurar credenciais (OpenAI + PostgreSQL)
  3. Modificar workflows para salvamento duplo
  4. Testar com 1 município (Palmas)
  5. Popular com 20 municípios × 4 dimensões

ℹ️  Conexão com banco de dados fechada
```

---

## 🔍 VERIFICAÇÃO MANUAL

Se quiser verificar manualmente no PostgreSQL:

### Listar Tabelas Criadas

```sql
SELECT tablename, 
       pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE tablename LIKE 'agent_%'
ORDER BY tablename;
```

### Listar Índices Criados

```sql
SELECT indexname, tablename
FROM pg_indexes
WHERE tablename LIKE 'agent_%'
ORDER BY tablename, indexname;
```

### Consultar Estatísticas

```sql
SELECT * FROM v_agent_memory_stats;
```

### Testar Busca Vetorial

```sql
-- Após popular algumas análises
SELECT 
  territory_id,
  analysis_summary,
  confidence_score
FROM agent_econ_memory
WHERE is_latest = true
ORDER BY embedding_vector <=> '[0.1, 0.2, ...]'::vector(1536)
LIMIT 5;
```

---

## ⚠️ TROUBLESHOOTING

### Erro: "Variável de ambiente DATABASE_URL não encontrada"

**Solução:**
1. Configure `DATABASE_URL` no arquivo `.env` do projeto
2. Ou configure nas Secrets do Replit
3. Ou exporte manualmente: `export DATABASE_URL="postgresql://..."`

### Erro: "psycopg2 não encontrado"

**Solução:**
```bash
pip3 install psycopg2-binary
```

### Erro: "Extensão vector não encontrada"

**Solução:**
```sql
CREATE EXTENSION IF NOT EXISTS vector;
```

### Erro: "Tabelas já existem"

**Solução:**
O script usa `CREATE TABLE IF NOT EXISTS`, então é seguro executar múltiplas vezes. Se quiser recriar do zero:

```sql
-- CUIDADO: Isso apaga todos os dados!
DROP TABLE IF EXISTS agent_econ_memory CASCADE;
DROP TABLE IF EXISTS agent_econ_learning CASCADE;
DROP TABLE IF EXISTS agent_social_memory CASCADE;
DROP TABLE IF EXISTS agent_social_learning CASCADE;
DROP TABLE IF EXISTS agent_terra_memory CASCADE;
DROP TABLE IF EXISTS agent_terra_learning CASCADE;
DROP TABLE IF EXISTS agent_ambient_memory CASCADE;
DROP TABLE IF EXISTS agent_ambient_learning CASCADE;
```

Depois execute o script novamente.

---

## 📊 ESTRUTURA CRIADA

### Tabelas de Memória (4x)

```
agent_econ_memory
agent_social_memory
agent_terra_memory
agent_ambient_memory
```

**Colunas principais:**
- `id` (UUID)
- `territory_id` (VARCHAR)
- `analysis_content` (TEXT)
- `analysis_summary` (TEXT)
- `embedding_vector` (vector(1536))
- `confidence_score` (NUMERIC)
- `metadata` (JSONB)
- `analysis_date` (DATE)
- `created_at`, `updated_at` (TIMESTAMP)

### Tabelas de Aprendizado (4x)

```
agent_econ_learning
agent_social_learning
agent_terra_learning
agent_ambient_learning
```

**Colunas principais:**
- `id` (UUID)
- `learning_type` (VARCHAR)
- `title` (TEXT)
- `description` (TEXT)
- `confidence` (NUMERIC)
- `embedding_vector` (vector(1536))
- `times_applied` (INTEGER)
- `is_active` (BOOLEAN)

### Views (2x)

```
v_agent_memory_stats      -- Estatísticas de memória por agente
v_agent_learning_stats    -- Estatísticas de aprendizado por agente
```

### Função Auxiliar

```
search_agent_memory(agent, query_embedding, limit)
```

Busca análises similares na memória de um agente específico.

---

## 🎓 PRÓXIMOS PASSOS

Após executar este script com sucesso, você está pronto para:

1. **Fase 2:** Importar workflows no n8n Cloud
2. **Fase 2:** Modificar workflows para salvamento duplo
3. **Fase 2:** Popular knowledge_base com 80 análises
4. **Fase 3:** Atualizar workflows com consulta de memória

---

## 📚 DOCUMENTAÇÃO RELACIONADA

- [Análise de Workflows e Proposta de Memória Distribuída](../analise_workflows_memoria_distribuida.md)
- [Opção C (Híbrida) Detalhada](../opcao_c_hibrida_detalhada.md)
- [Memória no PostgreSQL vs. n8n](../memoria_postgresql_vs_n8n.md)

---

**Framework de Inteligência Territorial V6.0**  
**Script de Criação da Estrutura de Memória Distribuída**  
**Preparado por:** Manus AI  
**Data:** 24 de novembro de 2025
