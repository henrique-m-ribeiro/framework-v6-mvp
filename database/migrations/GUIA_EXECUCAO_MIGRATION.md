# 🚀 Guia de Execução da Migration - knowledge_base V2.0

## 📋 Visão Geral

Este guia detalha o processo de execução da migration SQL para atualizar a tabela `knowledge_base` para a arquitetura V2.0.

---

## ⚠️ PRÉ-REQUISITOS

Antes de executar a migration, certifique-se de:

1. ✅ **Backup manual do banco** (além do backup automático da migration)
2. ✅ **Acesso ao banco Neon** com permissões de DDL (ALTER TABLE, CREATE INDEX)
3. ✅ **Janela de manutenção** (migration leva ~2-5 minutos)
4. ✅ **Workflows pausados** no n8n (evitar inserções durante migration)

---

## 🔧 OPÇÕES DE EXECUÇÃO

### **Opção 1: Via psql (Linha de Comando)**

```bash
# Conectar ao banco Neon
psql "postgresql://neondb_owner:npg_HPRVKaYAT4E5@ep-noisy-math-aeyq5dvn.c-2.us-east-2.aws.neon.tech:5432/neondb?sslmode=require"

# Executar migration
\i /home/ubuntu/MIGRATION_KNOWLEDGE_BASE_V2.sql

# Verificar resultados
SELECT COUNT(*) FROM knowledge_base;
SELECT question_type, COUNT(*) FROM knowledge_base GROUP BY question_type;
```

---

### **Opção 2: Via DBeaver / PgAdmin (GUI)**

1. Conectar ao banco Neon
2. Abrir arquivo `MIGRATION_KNOWLEDGE_BASE_V2.sql`
3. Executar script completo
4. Verificar mensagens de NOTICE para confirmar sucesso

---

### **Opção 3: Via n8n (Workflow de Migration)**

Criar workflow temporário no n8n:

```json
{
  "nodes": [
    {
      "name": "Execute Migration",
      "type": "n8n-nodes-base.postgres",
      "parameters": {
        "operation": "executeQuery",
        "query": "{{ $json.migration_sql }}",
        "additionalFields": {}
      }
    }
  ]
}
```

---

## 📊 FASES DA MIGRATION

A migration está dividida em **10 fases**:

### **Fase 1: Backup de Segurança** ✅
- Cria tabela `knowledge_base_backup_20251202`
- Copia todos os registros existentes
- Valida quantidade de registros copiados

### **Fase 2: Adicionar Novas Colunas** ✅
- `original_question` (TEXT)
- `question_type` (VARCHAR(50))
- `dimensions_analyzed` (VARCHAR(50)[])
- `source_analyses` (JSONB)
- `integrated_analysis` (TEXT)
- `executive_summary` (TEXT)
- `key_insights` (JSONB)
- `overall_confidence_score` (NUMERIC)
- `total_indicators_analyzed` (INTEGER)
- `orchestrator_version` (VARCHAR(20))
- `execution_time_seconds` (NUMERIC)

### **Fase 3: Migrar Dados Existentes** ✅
- Atualiza registros antigos com valores padrão
- Infere `question_type` baseado em `dimension`
- Cria `dimensions_analyzed` como array
- Copia `confidence_score` → `overall_confidence_score`
- Marca como `v1.0-legacy`

### **Fase 4: Adicionar Índices** ✅
- Índice para `question_type`
- Índice GIN para `dimensions_analyzed` (array)
- Índice composto `territory_id + question_type`
- Índice GIN para `source_analyses` (JSONB)
- Índice para `created_at DESC`
- Índice para `orchestrator_version`

### **Fase 5: Adicionar Constraints** ✅
- `question_type` deve ser valor válido
- `dimensions_analyzed` não pode ser vazio
- `overall_confidence_score` entre 0 e 1
- `total_indicators_analyzed` positivo
- `execution_time_seconds` positivo

### **Fase 6: Criar Função Auxiliar** ✅
- Função `insert_knowledge_base_v2()` para facilitar inserções
- Aceita todos os novos campos
- Mantém compatibilidade com colunas legadas

### **Fase 7: Criar View** ✅
- View `v_knowledge_base_multidimensional`
- Facilita consultas de análises multidimensionais
- Inclui flags `has_economic`, `has_social`, etc.

### **Fase 8: Estatísticas** ✅
- Exibe resumo da migration
- Conta registros por tipo
- Confirma sucesso

### **Fase 9: Exemplo de Uso** 📖
- Código comentado com exemplo de inserção

### **Fase 10: Rollback** 🔄
- Código comentado para reverter migration se necessário

---

## ✅ VALIDAÇÃO PÓS-MIGRATION

Após executar a migration, valide com estas queries:

### **1. Verificar estrutura da tabela**

```sql
SELECT 
    column_name, 
    data_type, 
    is_nullable, 
    column_default
FROM information_schema.columns
WHERE table_name = 'knowledge_base'
ORDER BY ordinal_position;
```

**Resultado esperado:** 28+ colunas (18 originais + 11 novas)

---

### **2. Verificar dados migrados**

```sql
SELECT 
    question_type,
    COUNT(*) AS total,
    AVG(overall_confidence_score) AS avg_confidence,
    AVG(array_length(dimensions_analyzed, 1)) AS avg_dimensions
FROM knowledge_base
GROUP BY question_type;
```

**Resultado esperado:**
```
question_type      | total | avg_confidence | avg_dimensions
-------------------+-------+----------------+---------------
single_dimension   |   X   |     0.85       |      1.0
unknown            |   Y   |     0.80       |      0.0
```

---

### **3. Verificar índices criados**

```sql
SELECT 
    indexname, 
    indexdef
FROM pg_indexes
WHERE tablename = 'knowledge_base'
AND indexname LIKE 'idx_knowledge_base_%';
```

**Resultado esperado:** 6 índices novos

---

### **4. Verificar constraints**

```sql
SELECT 
    conname AS constraint_name,
    contype AS constraint_type,
    pg_get_constraintdef(oid) AS definition
FROM pg_constraint
WHERE conrelid = 'knowledge_base'::regclass
AND conname LIKE 'chk_knowledge_base_%';
```

**Resultado esperado:** 5 constraints de validação

---

### **5. Testar função auxiliar**

```sql
-- Teste de inserção (não executar em produção sem ajustar valores)
SELECT insert_knowledge_base_v2(
    p_territory_id := '1721000',
    p_original_question := 'TESTE: Como está Palmas?',
    p_question_type := 'single_dimension',
    p_dimensions_analyzed := ARRAY['economic']::VARCHAR(50)[],
    p_integrated_analysis := 'Teste de inserção',
    p_executive_summary := 'Resumo de teste',
    p_key_insights := '{"economic": "Teste"}'::jsonb,
    p_source_analyses := '{"economic": "test-uuid"}'::jsonb,
    p_overall_confidence_score := 0.85,
    p_total_indicators_analyzed := 5,
    p_orchestrator_version := 'v2.0-test',
    p_execution_time_seconds := 10.5
);

-- Verificar inserção
SELECT * FROM knowledge_base WHERE original_question LIKE 'TESTE:%';

-- Deletar teste
DELETE FROM knowledge_base WHERE original_question LIKE 'TESTE:%';
```

---

### **6. Testar view**

```sql
SELECT * FROM v_knowledge_base_multidimensional LIMIT 5;
```

**Resultado esperado:** View funciona sem erros (pode estar vazia se não houver análises multidimensionais)

---

## 🔄 ROLLBACK (Se Necessário)

Se algo der errado, execute o rollback:

```sql
-- 1. Restaurar dados do backup
TRUNCATE TABLE knowledge_base;
INSERT INTO knowledge_base SELECT * FROM knowledge_base_backup_20251202;

-- 2. Remover colunas adicionadas
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS original_question;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS question_type;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS dimensions_analyzed;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS source_analyses;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS integrated_analysis;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS executive_summary;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS key_insights;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS overall_confidence_score;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS total_indicators_analyzed;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS orchestrator_version;
ALTER TABLE knowledge_base DROP COLUMN IF EXISTS execution_time_seconds;

-- 3. Remover índices
DROP INDEX IF EXISTS idx_knowledge_base_question_type;
DROP INDEX IF EXISTS idx_knowledge_base_dimensions_analyzed;
DROP INDEX IF EXISTS idx_knowledge_base_territory_question;
DROP INDEX IF EXISTS idx_knowledge_base_source_analyses;
DROP INDEX IF EXISTS idx_knowledge_base_created_at;
DROP INDEX IF EXISTS idx_knowledge_base_orchestrator_version;

-- 4. Remover função e view
DROP FUNCTION IF EXISTS insert_knowledge_base_v2;
DROP VIEW IF EXISTS v_knowledge_base_multidimensional;
```

---

## 📈 IMPACTO DA MIGRATION

### **Performance**

| Aspecto | Antes | Depois | Impacto |
|---------|-------|--------|---------|
| **Tamanho da tabela** | ~100 KB | ~120 KB | +20% (11 novas colunas) |
| **Índices** | 1 (PK) | 7 | +6 índices |
| **Queries de busca** | Scan completo | Índices otimizados | ✅ Mais rápido |
| **Inserções** | Simples | Mais campos | ⚠️ Levemente mais lento |

### **Compatibilidade**

- ✅ **Colunas antigas mantidas** (compatibilidade retroativa)
- ✅ **Dados existentes migrados** automaticamente
- ✅ **Workflows antigos continuam funcionando** (colunas legadas preservadas)
- ⚠️ **Novos workflows devem usar função `insert_knowledge_base_v2()`**

---

## 🎯 PRÓXIMOS PASSOS

Após executar a migration com sucesso:

1. ✅ **Atualizar workflows dos agentes** (remover salvamento em knowledge_base)
2. ✅ **Atualizar workflow do orquestrador** (adicionar salvamento consolidado)
3. ✅ **Testar fluxo completo** (pergunta → agente → orquestrador → knowledge_base)
4. ✅ **Documentar mudanças** no README do projeto
5. ✅ **Reativar workflows** no n8n

---

## 📞 SUPORTE

Se encontrar problemas durante a migration:

1. **Não entre em pânico** - o backup foi criado automaticamente
2. **Capture mensagens de erro** completas
3. **Execute queries de validação** para identificar o problema
4. **Execute rollback** se necessário
5. **Reporte o problema** com detalhes

---

## 📝 CHECKLIST DE EXECUÇÃO

- [ ] Backup manual do banco criado
- [ ] Workflows pausados no n8n
- [ ] Migration SQL executada
- [ ] Mensagens de NOTICE verificadas
- [ ] Queries de validação executadas
- [ ] Estrutura da tabela validada
- [ ] Índices verificados
- [ ] Constraints verificados
- [ ] Função auxiliar testada
- [ ] View testada
- [ ] Backup da migration confirmado
- [ ] Workflows reativados
- [ ] Teste end-to-end realizado

---

**Data de criação:** 02/12/2025  
**Versão:** 2.0  
**Autor:** Sistema de IA Territorial - Tocantins
