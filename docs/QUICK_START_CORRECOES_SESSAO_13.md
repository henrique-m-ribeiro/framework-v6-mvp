# Quick Start - Correções da Sessão #13

**Framework de Inteligência Territorial V6.0**  
**Tempo Total:** 1h30 - 2h  
**Última Atualização:** 08/12/2025

---

## 🎯 OBJETIVO

Corrigir 2 problemas críticos:
1. **Orquestrador** não salva dados completos na `knowledge_base`
2. **Agentes** não salvam análises nas suas memórias

---

## ⚡ CHECKLIST RÁPIDO

### Preparação (5 min)
- [ ] Acesso ao n8n Cloud: https://galactic-ai.app.n8n.cloud
- [ ] Acesso ao banco PostgreSQL (Neon)
- [ ] Todos os workflows ativos

### Correção 1: Orquestrador (15 min)
- [ ] Abrir workflow "WF-AGENT-ORCHESTRATOR - Orquestrador Central V3.2"
- [ ] Localizar nó "PostgreSQL - Salvar na Knowledge Base"
- [ ] Substituir `$json` por `$input.first().json` (7 vezes)
- [ ] Salvar e testar

### Correção 2: Agente ECON (20 min)
- [ ] Abrir workflow "WF-AGENT-ECON - Especialista Econômico V6.1"
- [ ] Adicionar nó "PostgreSQL - Salvar na Memória"
- [ ] Configurar query SQL para `agent_econ_memory`
- [ ] Conectar ao fluxo
- [ ] Salvar e testar

### Correção 3: Agente SOCIAL (10 min)
- [ ] Replicar correção do ECON
- [ ] Trocar `agent_econ_memory` → `agent_social_memory`
- [ ] Trocar `'econ'` → `'social'`
- [ ] Salvar e testar

### Correção 4: Agente TERRA (10 min)
- [ ] Replicar correção do ECON
- [ ] Trocar `agent_econ_memory` → `agent_terra_memory`
- [ ] Trocar `'econ'` → `'terra'`
- [ ] Salvar e testar

### Correção 5: Agente AMBIENT (10 min)
- [ ] Replicar correção do ECON
- [ ] Trocar `agent_econ_memory` → `agent_ambient_memory`
- [ ] Trocar `'econ'` → `'ambient'`
- [ ] Salvar e testar

### Validação (30 min)
- [ ] Testar Agente ECON
- [ ] Testar Agente SOCIAL
- [ ] Testar Agente TERRA
- [ ] Testar Agente AMBIENT
- [ ] Executar query consolidada

---

## 🔧 CORREÇÃO #1: ORQUESTRADOR

### O Problema
```javascript
// ❌ ERRADO - contexto do próprio nó
'{{ $json.dimension || "unknown" }}'
```

### A Solução
```javascript
// ✅ CORRETO - contexto do nó anterior (HTTP Request)
'{{ $input.first().json.dimension || "unknown" }}'
```

### Onde Aplicar
Nó: **"PostgreSQL - Salvar na Knowledge Base"**

Substituir em **7 lugares**:
1. `$json.dimension` → `$input.first().json.dimension`
2. `$json.analysis_type` → `$input.first().json.analysis_type`
3. `$json.analysis_content` → `$input.first().json.analysis_content`
4. `$json.content` → `$input.first().json.content`
5. `$json.analysis_summary` → `$input.first().json.analysis_summary`
6. `$json.summary` → `$input.first().json.summary`
7. `$json.metadata` → `$input.first().json.metadata`
8. `$json.confidence_score` → `$input.first().json.confidence_score`
9. `$json.data_sources` → `$input.first().json.data_sources`
10. `$json.sources` → `$input.first().json.sources`

### Query Completa Corrigida

```sql
-- Salvar análise na knowledge_base (Camada 3: Memória Organizacional)
INSERT INTO knowledge_base (
  id,
  territory_id,
  dimension,
  analysis_type,
  content,
  summary,
  metadata,
  confidence_score,
  sources,
  created_at,
  updated_at,
  generated_by
)
VALUES (
  gen_random_uuid(),
  '{{ $('Webhook - Recebe Requisição').first().json.body.territory_id }}',
  '{{ $input.first().json.dimension || "unknown" }}',
  '{{ $input.first().json.analysis_type || "diagnostic" }}',
  '{{ $input.first().json.analysis_content || $input.first().json.content || "Análise não disponível" }}',
  '{{ $input.first().json.analysis_summary || $input.first().json.summary || "" }}',
  jsonb_build_object(
    'question', '{{ $('Webhook - Recebe Requisição').first().json.body.question }}',
    'routed_to', '{{ $('OpenAI - Roteador Inteligente').first().json.message }}',
    'orchestration_timestamp', NOW(),
    'agent_metadata', '{{ $input.first().json.metadata || \"{}\" }}'::jsonb
  ),
  {{ $input.first().json.confidence_score || 0.80 }},
  '{{ $input.first().json.data_sources || $input.first().json.sources || \"[]\" }}'::jsonb,
  NOW(),
  NOW(),
  'orchestrator-v3.2'
)
ON CONFLICT (territory_id, dimension, analysis_type, version)
DO UPDATE SET
  content = EXCLUDED.content,
  summary = EXCLUDED.summary,
  metadata = EXCLUDED.metadata,
  confidence_score = EXCLUDED.confidence_score,
  sources = EXCLUDED.sources,
  updated_at = NOW(),
  is_latest = TRUE
RETURNING id, territory_id, dimension, analysis_type, created_at;
```

### Teste Rápido

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/orchestrator \
  -H "Content-Type: application/json" \
  -d '{"territory_id": "1721000", "territory_name": "Palmas", "question": "Qual o PIB de Palmas?"}'
```

### Validação

```sql
SELECT dimension, LENGTH(content) FROM knowledge_base 
WHERE territory_id = '1721000' ORDER BY created_at DESC LIMIT 1;
-- Esperado: dimension = 'economic', LENGTH > 5000
```

---

## 🔧 CORREÇÃO #2: AGENTE ECON

### O Problema
Workflow **não tem nó** para salvar na memória.

### A Solução
Adicionar nó **"PostgreSQL - Salvar na Memória"** após "Preparar Dados para Salvar".

### Fluxo Correto
```
Preparar Dados para Salvar
  ↓
PostgreSQL - Salvar na Memória  ← NOVO NÓ
  ↓
Registrar Aprendizado Automático
```

### Query SQL para o Novo Nó

```sql
INSERT INTO agent_econ_memory (
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
  'econ',
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

### Configuração do Nó
- **Nome:** PostgreSQL - Salvar na Memória
- **Operation:** Execute Query
- **Return Output:** ✅ Habilitado
- **Continue On Fail:** ❌ Desabilitado

### Validação

```sql
SELECT COUNT(*) FROM agent_econ_memory WHERE territory_id = '1721000';
-- Esperado: 1+
```

---

## 🔧 CORREÇÕES #3, #4, #5: OUTROS AGENTES

### Replicação Rápida

Para cada agente (SOCIAL, TERRA, AMBIENT):

1. **Abrir workflow** do agente
2. **Adicionar nó PostgreSQL** após "Preparar Dados para Salvar"
3. **Copiar query** do Agente ECON
4. **Substituir:**
   - `agent_econ_memory` → `agent_X_memory`
   - `'econ'` → `'X'`
5. **Salvar e testar**

### Tabela de Referência

| Agente | Tabela | agent_id |
|--------|--------|----------|
| SOCIAL | agent_social_memory | 'social' |
| TERRA | agent_terra_memory | 'terra' |
| AMBIENT | agent_ambient_memory | 'ambient' |

---

## 🧪 VALIDAÇÃO RÁPIDA

### Query Consolidada

```sql
SELECT 
  'ECON' as agente, COUNT(*) as total
FROM agent_econ_memory WHERE territory_id = '1721000'
UNION ALL
SELECT 'SOCIAL', COUNT(*) FROM agent_social_memory WHERE territory_id = '1721000'
UNION ALL
SELECT 'TERRA', COUNT(*) FROM agent_terra_memory WHERE territory_id = '1721000'
UNION ALL
SELECT 'AMBIENT', COUNT(*) FROM agent_ambient_memory WHERE territory_id = '1721000';
```

**Resultado esperado:** Todos com total = 1+

---

## 🚨 TROUBLESHOOTING RÁPIDO

### Erro: "Invalid JSON in response body"
**Solução:** Já foi corrigido na Sessão #12 (Response Format: JSON)

### Erro: "Cannot read property 'dimension' of undefined"
**Solução:** Você esqueceu de trocar `$json` por `$input.first().json`

### Erro: "Table does not exist"
**Solução:** Verifique o nome da tabela (agent_econ_memory, não agent_economico_memory)

### Erro: Workflow executa mas não salva
**Solução:** Verifique se o nó está conectado ao fluxo principal

---

## 📊 MÉTRICAS DE SUCESSO

| Métrica | Meta |
|---------|------|
| knowledge_base.dimension | Correto (não "unknown") |
| knowledge_base.content_length | > 5000 |
| agent_econ_memory.count | 1+ |
| agent_social_memory.count | 1+ |
| agent_terra_memory.count | 1+ |
| agent_ambient_memory.count | 1+ |
| Taxa de sucesso | 100% (4/4 testes) |

---

## 📚 GUIAS COMPLETOS

Para instruções detalhadas, consulte:

1. **GUIA_CORRECAO_ORQUESTRADOR_SESSAO_13.md** (12 KB)
2. **GUIA_CORRECAO_AGENTE_ECON_SESSAO_13.md** (13 KB)
3. **GUIA_CORRECAO_AGENTES_RESTANTES_SESSAO_13.md** (11 KB)
4. **GUIA_TESTE_INTEGRACAO_COMPLETA_SESSAO_13.md** (13 KB)
5. **INDICE_GUIAS_SESSAO_13.md** (8 KB)

---

## 💡 DICAS PRO

1. **Faça backup** das queries antes de alterar
2. **Teste um por vez** (Orquestrador → ECON → SOCIAL → TERRA → AMBIENT)
3. **Use Find & Replace** para acelerar substituições
4. **Valide no banco** após cada correção
5. **Documente problemas** que encontrar

---

## 🎉 BOA SORTE!

Você está prestes a consolidar o Orquestrador e dar vida à memória dos agentes. 

**Lembre-se:** Cada correção é um passo para o futuro da gestão pública inteligente! 🚀

---

**Dúvidas?** Consulte os guias completos ou peça ajuda ao facilitador.

---

**Status:** ✅ QUICK START COMPLETO  
**Autor:** Manus AI (Facilitador)  
**Data:** 08/12/2025  
**Versão:** 1.0
