# Diagnóstico de Problemas de Salvamento - Sessão #13

**Data:** 06 de dezembro de 2025  
**Framework:** Inteligência Territorial V6.0  
**Workflows Analisados:**
- Orquestrador V3.2 (Corrigido)
- Agente ECON V6.1 (Multidimensional)
- Agente SOCIAL V6.1 (Multidimensional)
- Agente TERRA V6.1 (Multidimensional)
- Agente AMBIENT V6.1 (Multidimensional)

---

## 🔍 METODOLOGIA DE ANÁLISE

Foram criados scripts Python personalizados para analisar os workflows JSON exportados do n8n Cloud, identificando:

1. **Estrutura de nós** e tipos
2. **Queries SQL** de salvamento
3. **Referências de dados** entre nós
4. **Conexões** e fluxo de dados
5. **Presença/ausência** de nós críticos

---

## 🚨 PROBLEMA #1: Orquestrador Salva Dados Incompletos na `knowledge_base`

### Evidência do Banco de Dados

```sql
SELECT 
    id,
    territory_id,
    dimension,
    analysis_type,
    LENGTH(content) as content_length,
    created_at
FROM knowledge_base
WHERE id = 'c7c7432f-7e8a-4a64-be3c-ede10002ced9';
```

| Campo | Valor Esperado | Valor Real | Status |
|-------|----------------|------------|--------|
| territory_id | 1721000 | 1721000 | ✅ |
| dimension | economic | **unknown** | ❌ |
| content_length | 5.473 | **22** | ❌ |
| analysis_type | diagnostic | diagnostic | ✅ |

### Análise do Workflow

**Nó:** `PostgreSQL - Salvar na Knowledge Base`

**Query SQL Atual:**

```sql
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
  '{{ $json.dimension || "unknown" }}',  -- ❌ PROBLEMA AQUI
  '{{ $json.analysis_type || "diagnostic" }}',  -- ❌ PROBLEMA AQUI
  '{{ $json.analysis_content || $json.content || "Análise não disponível" }}',  -- ❌ PROBLEMA AQUI
  '{{ $json.analysis_summary || $json.summary || "" }}',  -- ❌ PROBLEMA AQUI
  jsonb_build_object(
    'question', '{{ $('Webhook - Recebe Requisição').first().json.body.question }}',
    'routed_to', '{{ $('OpenAI - Roteador Inteligente').first().json.message }}',
    'orchestration_timestamp', NOW(),
    'agent_metadata', '{{ $json.metadata || \"{}\" }}'::jsonb  -- ❌ PROBLEMA AQUI
  ),
  {{ $json.confidence_score || 0.80 }},  -- ❌ PROBLEMA AQUI
  '{{ $json.data_sources || $json.sources || \"[]\" }}'::jsonb,  -- ❌ PROBLEMA AQUI
  NOW(),
  NOW(),
  'orchestrator-v3.2'
)
RETURNING id, territory_id, dimension, analysis_type, created_at;
```

### Causa Raiz

O nó está usando `$json` para referenciar os dados, mas **`$json` refere-se ao contexto do próprio nó**, não à resposta do HTTP Request que chamou o agente.

**Fluxo de conexões identificado:**
```
HTTP Request - Chamar Agente ECON 
  ↓
PostgreSQL - Salvar na Knowledge Base
```

Quando o nó PostgreSQL executa, o `$json` está vazio ou contém apenas os dados do próprio nó, não a resposta do agente ECON.

### Solução

**Trocar todas as referências de:**
```javascript
$json.campo
```

**Para:**
```javascript
$input.first().json.campo
```

Ou, de forma mais explícita (se houver múltiplos agentes):
```javascript
$('HTTP Request - Chamar Agente ECON').first().json.campo
```

### Query SQL Corrigida

```sql
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
  '{{ $input.first().json.dimension || "unknown" }}',  -- ✅ CORRIGIDO
  '{{ $input.first().json.analysis_type || "diagnostic" }}',  -- ✅ CORRIGIDO
  '{{ $input.first().json.analysis_content || $input.first().json.content || "Análise não disponível" }}',  -- ✅ CORRIGIDO
  '{{ $input.first().json.analysis_summary || $input.first().json.summary || "" }}',  -- ✅ CORRIGIDO
  jsonb_build_object(
    'question', '{{ $('Webhook - Recebe Requisição').first().json.body.question }}',
    'routed_to', '{{ $('OpenAI - Roteador Inteligente').first().json.message }}',
    'orchestration_timestamp', NOW(),
    'agent_metadata', '{{ $input.first().json.metadata || \"{}\" }}'::jsonb  -- ✅ CORRIGIDO
  ),
  {{ $input.first().json.confidence_score || 0.80 }},  -- ✅ CORRIGIDO
  '{{ $input.first().json.data_sources || $input.first().json.sources || \"[]\" }}'::jsonb,  -- ✅ CORRIGIDO
  NOW(),
  NOW(),
  'orchestrator-v3.2'
)
RETURNING id, territory_id, dimension, analysis_type, created_at;
```

### Impacto da Correção

- ✅ `dimension` será preenchido corretamente (ex: "economic", "social", "territorial", "environmental")
- ✅ `content` terá a análise completa (5.473+ caracteres)
- ✅ `summary` terá o resumo executivo
- ✅ `confidence_score` terá o valor real do agente (ex: 0.92)
- ✅ `metadata` terá os metadados completos da análise
- ✅ `sources` terá as fontes de dados utilizadas

---

## 🚨 PROBLEMA #2: Agente ECON Não Salva na Sua Memória

### Evidência do Banco de Dados

```sql
SELECT COUNT(*) FROM agent_econ_memory;
-- Resultado: 0 registros
```

Após a execução bem-sucedida do Agente ECON na Sessão #12, a tabela `agent_econ_memory` está vazia.

### Análise do Workflow

**Nós PostgreSQL encontrados no workflow do Agente ECON V6.1:**

1. **Consultar Memória e Aprendizados** - SELECT FROM agent_econ_memory
2. **Consultar Dados PostgreSQL** - SELECT FROM múltiplas tabelas de indicadores
3. **Registrar Aprendizado Automático** - INSERT INTO agent_econ_learning_evolution
4. **Atualizar Expertise** - SELECT FROM get_agent_expertise()
5. **Registrar Auditoria do Ciclo** - INSERT INTO audit_trail

### Causa Raiz

**O workflow do Agente ECON V6.1 NÃO TEM um nó para salvar na memória (`agent_econ_memory`).**

O agente:
- ✅ Consulta a memória (nó "Consultar Memória e Aprendizados")
- ✅ Registra aprendizado (nó "Registrar Aprendizado Automático")
- ✅ Atualiza expertise (nó "Atualizar Expertise")
- ✅ Registra auditoria (nó "Registrar Auditoria do Ciclo")
- ❌ **NÃO salva a análise gerada na sua memória**

### Fluxo de Dados Identificado

```
Gerar Análise com OpenAI
  ↓
Estruturar Resposta
  ↓
Preparar Dados para Salvar
  ↓
Respond to Webhook
```

O fluxo termina na resposta ao webhook, **sem passar por um nó de salvamento na memória**.

### Solução

**Adicionar um novo nó PostgreSQL após "Preparar Dados para Salvar":**

**Nome do nó:** `PostgreSQL - Salvar na Memória`

**Posição no fluxo:**
```
Preparar Dados para Salvar
  ↓
PostgreSQL - Salvar na Memória  ← NOVO NÓ
  ↓
Registrar Aprendizado Automático
```

**Query SQL para o novo nó:**

```sql
-- ========================================
-- SALVAR ANÁLISE NA MEMÓRIA DO AGENTE ECON
-- ========================================

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
  NULL,  -- Embedding será gerado de forma assíncrona
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

**Tipo:** PostgreSQL  
**Operação:** Execute Query  
**Query:** (acima)  
**Opções:**
- ✅ Return Output: Habilitado
- ✅ Continue On Fail: Desabilitado (para detectar erros)

### Impacto da Correção

- ✅ Agente ECON terá memória de análises anteriores
- ✅ RAG do agente funcionará corretamente
- ✅ Expertise evoluirá com contexto histórico
- ✅ Análises futuras poderão referenciar análises passadas
- ✅ Sistema de aprendizagem evolutiva funcionará plenamente

---

## 🔄 PROBLEMA #3: Mesmo Problema nos Outros Agentes

### Análise Rápida

Os workflows dos agentes **SOCIAL**, **TERRA** e **AMBIENT** foram replicados a partir do template do agente ECON. Portanto, **o mesmo problema deve existir nos 3 agentes**.

### Confirmação Necessária

Verificar se os workflows dos agentes SOCIAL, TERRA e AMBIENT também **não têm nó de salvamento na memória**.

### Solução

Aplicar a **mesma correção** nos 3 agentes, apenas trocando:
- `agent_econ_memory` → `agent_social_memory`
- `agent_econ_memory` → `agent_terra_memory`
- `agent_econ_memory` → `agent_ambient_memory`

E ajustando o `agent_id`:
- `'econ'` → `'social'`
- `'econ'` → `'terra'`
- `'econ'` → `'ambient'`

---

## 📋 CHECKLIST DE CORREÇÕES

### Orquestrador V3.2

- [ ] Abrir workflow no n8n Cloud
- [ ] Ir no nó "PostgreSQL - Salvar na Knowledge Base"
- [ ] Trocar todas as referências de `$json.campo` para `$input.first().json.campo`
- [ ] Salvar e ativar o workflow
- [ ] Testar com payload de exemplo
- [ ] Validar salvamento no banco

### Agente ECON V6.1

- [ ] Abrir workflow no n8n Cloud
- [ ] Adicionar novo nó "PostgreSQL - Salvar na Memória" após "Preparar Dados para Salvar"
- [ ] Configurar query SQL de INSERT INTO agent_econ_memory
- [ ] Conectar o nó ao fluxo principal
- [ ] Salvar e ativar o workflow
- [ ] Testar com payload de exemplo
- [ ] Validar salvamento no banco

### Agente SOCIAL V6.1

- [ ] Aplicar mesma correção do Agente ECON
- [ ] Trocar `agent_econ_memory` → `agent_social_memory`
- [ ] Trocar `agent_id` → `'social'`
- [ ] Testar e validar

### Agente TERRA V6.1

- [ ] Aplicar mesma correção do Agente ECON
- [ ] Trocar `agent_econ_memory` → `agent_terra_memory`
- [ ] Trocar `agent_id` → `'terra'`
- [ ] Testar e validar

### Agente AMBIENT V6.1

- [ ] Aplicar mesma correção do Agente ECON
- [ ] Trocar `agent_econ_memory` → `agent_ambient_memory`
- [ ] Trocar `agent_id` → `'ambient'`
- [ ] Testar e validar

---

## 🧪 PLANO DE TESTES

### Teste 1: Orquestrador + Agente ECON

**Payload:**
```json
{
  "territory_id": "1721000",
  "territory_name": "Palmas",
  "question": "Qual o PIB de Palmas?"
}
```

**Validações:**
```sql
-- 1. Verificar salvamento na knowledge_base
SELECT 
    id,
    territory_id,
    dimension,
    analysis_type,
    LENGTH(content) as content_length,
    confidence_score
FROM knowledge_base
WHERE territory_id = '1721000'
ORDER BY created_at DESC
LIMIT 1;

-- Esperado:
-- dimension = 'economic'
-- content_length > 5000
-- confidence_score > 0.80

-- 2. Verificar salvamento na agent_econ_memory
SELECT 
    id,
    agent_id,
    territory_id,
    LENGTH(analysis_content) as content_length,
    confidence_score
FROM agent_econ_memory
WHERE territory_id = '1721000'
ORDER BY created_at DESC
LIMIT 1;

-- Esperado:
-- agent_id = 'econ'
-- content_length > 5000
-- confidence_score > 0.80
```

### Teste 2: Agente SOCIAL

**Payload:**
```json
{
  "territory_id": "1721000",
  "territory_name": "Palmas",
  "question": "Como está a educação em Palmas?"
}
```

**Validação:**
```sql
SELECT COUNT(*) FROM agent_social_memory WHERE territory_id = '1721000';
-- Esperado: 1 registro
```

### Teste 3: Agente TERRA

**Payload:**
```json
{
  "territory_id": "1721000",
  "territory_name": "Palmas",
  "question": "Como está a urbanização de Palmas?"
}
```

**Validação:**
```sql
SELECT COUNT(*) FROM agent_terra_memory WHERE territory_id = '1721000';
-- Esperado: 1 registro
```

### Teste 4: Agente AMBIENT

**Payload:**
```json
{
  "territory_id": "1721000",
  "territory_name": "Palmas",
  "question": "Como está o meio ambiente em Palmas?"
}
```

**Validação:**
```sql
SELECT COUNT(*) FROM agent_ambient_memory WHERE territory_id = '1721000';
-- Esperado: 1 registro
```

---

## 📊 MÉTRICAS DE SUCESSO

| Métrica | Antes | Depois (Esperado) |
|---------|-------|-------------------|
| knowledge_base.content_length | 22 chars | 5.000+ chars |
| knowledge_base.dimension | "unknown" | "economic" |
| agent_econ_memory.count | 0 | 1+ |
| agent_social_memory.count | 0 | 1+ |
| agent_terra_memory.count | 0 | 1+ |
| agent_ambient_memory.count | 0 | 1+ |

---

## 🎓 APRENDIZADOS

### Lição #1: Contexto de Dados no n8n

No n8n, `$json` refere-se ao **contexto do nó atual**, não ao nó anterior. Para acessar dados de nós anteriores, use:
- `$input.first().json` (nó imediatamente anterior)
- `$('Nome do Nó').first().json` (nó específico)

### Lição #2: Importância de Testes End-to-End

O Orquestrador executou "com sucesso", mas salvou dados incompletos. Apenas um teste de validação do banco revelou o problema.

### Lição #3: Replicação de Workflows Propaga Erros

Os 4 agentes foram replicados a partir do mesmo template. Um erro no template foi propagado para todos os agentes.

**Solução:** Sempre validar o template antes de replicar.

---

## 📚 DOCUMENTAÇÃO RELACIONADA

- [TESTE_ORQUESTRADOR_SUCESSO_SESSAO_12.md](TESTE_ORQUESTRADOR_SUCESSO_SESSAO_12.md)
- [DIARIO_PESQUISA_ACAO_2025-12-06_SESSAO_12.md](diarios/DIARIO_PESQUISA_ACAO_2025-12-06_SESSAO_12.md)
- [PENDENCIAS_TECNICAS.md](PENDENCIAS_TECNICAS.md)

---

**Status:** ✅ DIAGNÓSTICO COMPLETO  
**Próximo:** Implementar correções no n8n Cloud  
**Autor:** Manus AI (Facilitador)  
**Data:** 06/12/2025
