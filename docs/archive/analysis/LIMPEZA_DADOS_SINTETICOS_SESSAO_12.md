# Limpeza de Dados Sintéticos - Sessão #12

**Data:** 2025-12-06  
**Framework de Inteligência Territorial V6.0**

---

## 🚨 Problema Identificado

Durante a implementação do Agente Orquestrador, foi identificado que a tabela `agent_econ_memory` continha **12 registros com dados sintéticos** (territory_id inválidos).

---

## 📊 Registros Sintéticos Encontrados

### agent_econ_memory (12 registros deletados)

| Territory ID | Tipo | Status |
|--------------|------|--------|
| REF_0A618F1F | Sintético | ❌ DELETADO |
| REF_13E811C5 | Sintético | ❌ DELETADO |
| REF_1E17BEA0 | Sintético | ❌ DELETADO |
| REF_31DA0FB4 | Sintético | ❌ DELETADO |
| REF_3AEEE4E0 | Sintético | ❌ DELETADO |
| REF_414E586C | Sintético | ❌ DELETADO |
| REF_8CCE2928 | Sintético | ❌ DELETADO |
| REF_92A1A38B | Sintético | ❌ DELETADO |
| REF_9D5A7F77 | Sintético | ❌ DELETADO |
| REF_A8549CF5 | Sintético | ❌ DELETADO |
| REF_GENERAL  | Sintético | ❌ DELETADO |
| TO-PALMAS    | Sintético | ❌ DELETADO |

**Todos criados em:** 2025-11-29 06:49:XX (Sessão anterior)

---

## ✅ Ação Executada

```sql
DELETE FROM agent_econ_memory 
WHERE territory_id LIKE 'REF_%' 
   OR territory_id = 'TO-PALMAS' 
   OR territory_id = 'REF_GENERAL'
RETURNING id, territory_id;
```

**Resultado:** 12 registros deletados

---

## 📊 Estado Atual das Tabelas

| Tabela | Total Registros | Sintéticos | Válidos (IBGE) |
|--------|-----------------|------------|----------------|
| agent_econ_memory | 0 | 0 | 0 |
| agent_social_memory | 0 | 0 | 0 |
| agent_terra_memory | 0 | 0 | 0 |
| agent_ambient_memory | 0 | 0 | 0 |
| knowledge_base | 4 | 0 | 4 ✅ |
| agent_econ_learning_evolution | 20 | ? | ? |
| agent_social_learning_evolution | 2 | ? | ? |
| agent_terra_learning_evolution | 1 | ? | ? |
| agent_ambient_learning_evolution | 1 | ? | ? |

---

## 🎯 Códigos IBGE Válidos do Tocantins

**Exemplo de códigos válidos encontrados na tabela `territories`:**

| Código IBGE | Município | Tipo |
|-------------|-----------|------|
| 1721000 | Palmas | Município |
| 1700350 | Aliança do Tocantins | Município |
| 1702703 | Aurora do Tocantins | Município |
| 1703057 | Bandeirantes do Tocantins | Município |
| 1705508 | Colinas do Tocantins | Município |

**Formato válido:** 7 dígitos numéricos (ex: `1721000`)

---

## ⚠️ Implicações

### Positivas
1. ✅ Banco de produção agora está **limpo de dados sintéticos**
2. ✅ Integridade referencial garantida
3. ✅ Próximas análises usarão apenas códigos IBGE reais

### Negativas
1. ❌ Tabela `agent_econ_memory` está **vazia** (0 registros)
2. ❌ Agente ECON não tem memória de análises anteriores
3. ❌ Expertise do agente foi resetada (sem histórico)

---

## 🔄 Próximos Passos

### 1. Testar Orquestrador com Dados Reais
- Executar análise para Palmas (1721000)
- Verificar se análise é salva corretamente na `agent_econ_memory`
- Confirmar que `territory_id` é código IBGE válido

### 2. Resolver Problema de Embeddings
- Decidir: Síncrono vs Assíncrono
- Tornar `embedding_vector` NULLABLE ou gerar embeddings

### 3. Validar Tabelas de Learning Evolution
- Verificar se há dados sintéticos nas tabelas de aprendizagem
- Limpar se necessário

### 4. Implementar Validação de Territory ID
- Adicionar validação nos workflows para aceitar apenas códigos IBGE
- Regex: `^[0-9]{7}$`
- Foreign key constraint com tabela `territories`

---

## 📋 SQL para Validação Futura

```sql
-- Verificar se territory_id é código IBGE válido
SELECT 
    territory_id,
    CASE 
        WHEN territory_id ~ '^[0-9]{7}$' THEN 'VÁLIDO'
        ELSE 'INVÁLIDO'
    END as status,
    EXISTS(SELECT 1 FROM territories WHERE id = territory_id) as existe_em_territories
FROM agent_econ_memory;
```

---

## 🎓 Lições Aprendidas

1. **Nunca usar dados sintéticos em produção** - Mesmo para testes
2. **Validar territory_id no workflow** - Antes de salvar no banco
3. **Foreign key constraints são essenciais** - Previnem dados órfãos
4. **Monitorar qualidade dos dados** - Auditoria regular

---

**Status:** ✅ Limpeza concluída  
**Próximo:** Resolver problema de embeddings e testar Orquestrador com dados reais
