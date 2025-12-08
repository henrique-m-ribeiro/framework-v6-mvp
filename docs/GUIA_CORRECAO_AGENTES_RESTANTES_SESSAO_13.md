# Guia Rápido: Correção dos Agentes SOCIAL, TERRA e AMBIENT

**Sessão #13 - Framework de Inteligência Territorial V6.0**  
**Objetivo:** Adicionar salvamento de análises na memória dos agentes restantes  
**Tempo Estimado:** 10 minutos por agente (30 minutos total)  
**Dificuldade:** ⭐⭐ Intermediária (você já fez isso no Agente ECON!)

---

## 📋 PRÉ-REQUISITOS

- ✅ Correção do Agente ECON já aplicada (guia anterior)
- ✅ Acesso ao n8n Cloud
- ✅ Credenciais do banco PostgreSQL configuradas

---

## 🎯 O QUE VOCÊ VAI FAZER

Aplicar a **mesma correção** que você fez no Agente ECON nos outros 3 agentes, apenas trocando:
- Nome da tabela
- `agent_id`

É basicamente **copiar e colar** com pequenos ajustes! 🚀

---

## 📝 CORREÇÃO DO AGENTE SOCIAL

### Passo 1: Abrir o Workflow

1. No n8n Cloud, abra: **"WF-AGENT-SOCIAL - Especialista Social V6.1 (Multidimensional)"**

### Passo 2: Adicionar Novo Nó PostgreSQL

1. Localize o nó **"Preparar Dados para Salvar"**
2. Adicione um novo nó **PostgreSQL** entre ele e o próximo nó
3. Renomeie para: **"PostgreSQL - Salvar na Memória"**

### Passo 3: Configurar a Query SQL

Cole esta query no campo "Query":

```sql
-- ========================================
-- SALVAR ANÁLISE NA MEMÓRIA DO AGENTE SOCIAL
-- ========================================

INSERT INTO agent_social_memory (
  id,
  agent_id,
  territory_id,
  analysis_content,
  analysis_summary,
  confidence_score,
  metadata,
  time_range,
  data_sources,
  indicators_used,
  embedding_vector,
  created_at,
  updated_at
)
VALUES (
  '{{ $json.id }}',
  'social',
  '{{ $json.territory_id }}',
  '{{ $json.analysis_content }}',
  '{{ $json.analysis_summary }}',
  {{ $json.confidence_score || 0.75 }},
  '{{ $json.metadata || "{}" }}'::jsonb,
  '{{ $json.time_range || "{}" }}'::jsonb,
  '{{ $json.data_sources || "[]" }}'::jsonb,
  '{{ $json.indicators_used || "[]" }}'::jsonb,
  NULL,
  NOW(),
  NOW()
)
ON CONFLICT (id) DO UPDATE SET
  analysis_content = EXCLUDED.analysis_content,
  analysis_summary = EXCLUDED.analysis_summary,
  confidence_score = EXCLUDED.confidence_score,
  metadata = EXCLUDED.metadata,
  updated_at = NOW()
RETURNING id, agent_id, territory_id, created_at;
```

### Passo 4: Configurar Opções

- **Return Output**: ✅ Habilitado
- **Continue On Fail**: ❌ Desabilitado

### Passo 5: Salvar e Ativar

1. Salve o workflow
2. Ative o workflow

### Passo 6: Testar

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/orchestrator \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "territory_name": "Palmas",
    "question": "Como está a educação em Palmas?"
  }'
```

**Validação:**
```sql
SELECT COUNT(*) FROM agent_social_memory WHERE territory_id = '1721000';
-- Esperado: 1 registro
```

---

## 📝 CORREÇÃO DO AGENTE TERRA

### Passo 1: Abrir o Workflow

1. No n8n Cloud, abra: **"WF-AGENT-TERRA - Especialista Territorial V6.1 (Multidimensional)"**

### Passo 2: Adicionar Novo Nó PostgreSQL

1. Localize o nó **"Preparar Dados para Salvar"**
2. Adicione um novo nó **PostgreSQL** entre ele e o próximo nó
3. Renomeie para: **"PostgreSQL - Salvar na Memória"**

### Passo 3: Configurar a Query SQL

Cole esta query no campo "Query":

```sql
-- ========================================
-- SALVAR ANÁLISE NA MEMÓRIA DO AGENTE TERRA
-- ========================================

INSERT INTO agent_terra_memory (
  id,
  agent_id,
  territory_id,
  analysis_content,
  analysis_summary,
  confidence_score,
  metadata,
  time_range,
  data_sources,
  indicators_used,
  embedding_vector,
  created_at,
  updated_at
)
VALUES (
  '{{ $json.id }}',
  'terra',
  '{{ $json.territory_id }}',
  '{{ $json.analysis_content }}',
  '{{ $json.analysis_summary }}',
  {{ $json.confidence_score || 0.75 }},
  '{{ $json.metadata || "{}" }}'::jsonb,
  '{{ $json.time_range || "{}" }}'::jsonb,
  '{{ $json.data_sources || "[]" }}'::jsonb,
  '{{ $json.indicators_used || "[]" }}'::jsonb,
  NULL,
  NOW(),
  NOW()
)
ON CONFLICT (id) DO UPDATE SET
  analysis_content = EXCLUDED.analysis_content,
  analysis_summary = EXCLUDED.analysis_summary,
  confidence_score = EXCLUDED.confidence_score,
  metadata = EXCLUDED.metadata,
  updated_at = NOW()
RETURNING id, agent_id, territory_id, created_at;
```

### Passo 4: Configurar Opções

- **Return Output**: ✅ Habilitado
- **Continue On Fail**: ❌ Desabilitado

### Passo 5: Salvar e Ativar

1. Salve o workflow
2. Ative o workflow

### Passo 6: Testar

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/orchestrator \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "territory_name": "Palmas",
    "question": "Como está a urbanização de Palmas?"
  }'
```

**Validação:**
```sql
SELECT COUNT(*) FROM agent_terra_memory WHERE territory_id = '1721000';
-- Esperado: 1 registro
```

---

## 📝 CORREÇÃO DO AGENTE AMBIENT

### Passo 1: Abrir o Workflow

1. No n8n Cloud, abra: **"WF-AGENT-AMBIENT - Especialista Ambiental V6.1 (Multidimensional)"**

### Passo 2: Adicionar Novo Nó PostgreSQL

1. Localize o nó **"Preparar Dados para Salvar"**
2. Adicione um novo nó **PostgreSQL** entre ele e o próximo nó
3. Renomeie para: **"PostgreSQL - Salvar na Memória"**

### Passo 3: Configurar a Query SQL

Cole esta query no campo "Query":

```sql
-- ========================================
-- SALVAR ANÁLISE NA MEMÓRIA DO AGENTE AMBIENT
-- ========================================

INSERT INTO agent_ambient_memory (
  id,
  agent_id,
  territory_id,
  analysis_content,
  analysis_summary,
  confidence_score,
  metadata,
  time_range,
  data_sources,
  indicators_used,
  embedding_vector,
  created_at,
  updated_at
)
VALUES (
  '{{ $json.id }}',
  'ambient',
  '{{ $json.territory_id }}',
  '{{ $json.analysis_content }}',
  '{{ $json.analysis_summary }}',
  {{ $json.confidence_score || 0.75 }},
  '{{ $json.metadata || "{}" }}'::jsonb,
  '{{ $json.time_range || "{}" }}'::jsonb,
  '{{ $json.data_sources || "[]" }}'::jsonb,
  '{{ $json.indicators_used || "[]" }}'::jsonb,
  NULL,
  NOW(),
  NOW()
)
ON CONFLICT (id) DO UPDATE SET
  analysis_content = EXCLUDED.analysis_content,
  analysis_summary = EXCLUDED.analysis_summary,
  confidence_score = EXCLUDED.confidence_score,
  metadata = EXCLUDED.metadata,
  updated_at = NOW()
RETURNING id, agent_id, territory_id, created_at;
```

### Passo 4: Configurar Opções

- **Return Output**: ✅ Habilitado
- **Continue On Fail**: ❌ Desabilitado

### Passo 5: Salvar e Ativar

1. Salve o workflow
2. Ative o workflow

### Passo 6: Testar

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/orchestrator \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "territory_name": "Palmas",
    "question": "Como está o meio ambiente em Palmas?"
  }'
```

**Validação:**
```sql
SELECT COUNT(*) FROM agent_ambient_memory WHERE territory_id = '1721000';
-- Esperado: 1 registro
```

---

## ✅ CHECKLIST GERAL

Marque cada agente após concluir:

### Agente SOCIAL
- [ ] Nó PostgreSQL adicionado
- [ ] Query SQL configurada
- [ ] Workflow salvo e ativo
- [ ] Teste executado com sucesso
- [ ] Banco validado (1+ registro)

### Agente TERRA
- [ ] Nó PostgreSQL adicionado
- [ ] Query SQL configurada
- [ ] Workflow salvo e ativo
- [ ] Teste executado com sucesso
- [ ] Banco validado (1+ registro)

### Agente AMBIENT
- [ ] Nó PostgreSQL adicionado
- [ ] Query SQL configurada
- [ ] Workflow salvo e ativo
- [ ] Teste executado com sucesso
- [ ] Banco validado (1+ registro)

---

## 🧪 VALIDAÇÃO FINAL COMPLETA

Após corrigir todos os agentes, execute esta query para validar:

```sql
-- Verificar se todos os agentes estão salvando na memória
SELECT 
  'ECON' as agente,
  COUNT(*) as total_analises
FROM agent_econ_memory
WHERE territory_id = '1721000'

UNION ALL

SELECT 
  'SOCIAL' as agente,
  COUNT(*) as total_analises
FROM agent_social_memory
WHERE territory_id = '1721000'

UNION ALL

SELECT 
  'TERRA' as agente,
  COUNT(*) as total_analises
FROM agent_terra_memory
WHERE territory_id = '1721000'

UNION ALL

SELECT 
  'AMBIENT' as agente,
  COUNT(*) as total_analises
FROM agent_ambient_memory
WHERE territory_id = '1721000';
```

**Resultado esperado:**

| agente | total_analises |
|--------|----------------|
| ECON | 1 |
| SOCIAL | 1 |
| TERRA | 1 |
| AMBIENT | 1 |

---

## 📊 TABELA DE REFERÊNCIA RÁPIDA

Use esta tabela como guia rápido:

| Agente | Workflow | Tabela | agent_id | Pergunta de Teste |
|--------|----------|--------|----------|-------------------|
| ECON | WF-AGENT-ECON V6.1 | agent_econ_memory | 'econ' | "Qual o PIB de Palmas?" |
| SOCIAL | WF-AGENT-SOCIAL V6.1 | agent_social_memory | 'social' | "Como está a educação em Palmas?" |
| TERRA | WF-AGENT-TERRA V6.1 | agent_terra_memory | 'terra' | "Como está a urbanização de Palmas?" |
| AMBIENT | WF-AGENT-AMBIENT V6.1 | agent_ambient_memory | 'ambient' | "Como está o meio ambiente em Palmas?" |

---

## 🎓 DICA PRO

Para acelerar o processo:

1. **Copie a query do Agente ECON** que você já configurou
2. **Use Find & Replace** (Ctrl+H ou Cmd+H) para trocar:
   - `agent_econ_memory` → `agent_social_memory` (para SOCIAL)
   - `'econ'` → `'social'` (para SOCIAL)
3. **Repita** para TERRA e AMBIENT

Isso economiza tempo e reduz erros de digitação! ⚡

---

## 🚨 TROUBLESHOOTING COMUM

### Problema: "Table 'agent_X_memory' does not exist"

**Solução:** Verifique se você digitou corretamente o nome da tabela:
- `agent_social_memory` (não `agent_sociais_memory`)
- `agent_terra_memory` (não `agent_territorial_memory`)
- `agent_ambient_memory` (não `agent_ambiental_memory`)

---

### Problema: Teste retorna erro 500

**Solução:** Verifique se:
1. O Orquestrador foi corrigido (guia anterior)
2. O agente está ativo
3. As credenciais PostgreSQL estão configuradas

---

## 📚 PRÓXIMOS PASSOS

Após concluir todas as correções:

1. ✅ **Teste Completo de Integração** - Testar todos os 4 agentes
2. ✅ **Validação de Dados** - Verificar qualidade das análises salvas
3. ✅ **Análise Multidimensional** - Implementar chamada a múltiplos agentes
4. ✅ **Documentação** - Atualizar estado do projeto

**Próximo guia:** `GUIA_TESTE_INTEGRACAO_COMPLETA_SESSAO_13.md`

---

## 🎉 PARABÉNS!

Ao concluir este guia, você terá:

- ✅ **4 agentes** com memória funcional
- ✅ **Sistema RAG** operacional para cada agente
- ✅ **Aprendizado evolutivo** com contexto histórico
- ✅ **Base sólida** para análise multidimensional

**Você está construindo o futuro da gestão pública inteligente!** 🚀

---

**Status:** ✅ GUIA COMPLETO  
**Próximo:** Teste de Integração Completa  
**Autor:** Manus AI (Facilitador)  
**Data:** 06/12/2025  
**Versão:** 1.0
