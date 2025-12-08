# Análise do Schema Real do Banco de Dados - Sessão #13

**Data:** 08/12/2025  
**Objetivo:** Validar proposta de arquitetura de IDs consistentes à luz do schema real do PostgreSQL (Neon)

---

## 📊 Schema da Tabela `knowledge_base`

### Estrutura Completa

| Campo | Tipo | Nullable | Default | Observação |
|-------|------|----------|---------|------------|
| `id` | VARCHAR | NO | `gen_random_uuid()` | **UUID gerado automaticamente** |
| `territory_id` | VARCHAR | YES | - | Código IBGE do município |
| `dimension` | TEXT | NO | - | economic, social, territorial, environmental |
| `content` | TEXT | NO | - | Análise completa (5.000+ caracteres) |
| `embedding` | TEXT | YES | - | (Legado, não usado) |
| `metadata` | JSONB | YES | - | Metadados da análise |
| `embedding_vector` | VECTOR(1536) | YES | - | Vetor para RAG |
| `analysis_type` | VARCHAR(50) | YES | `'diagnostic'` | Tipo de análise |
| `summary` | TEXT | YES | - | Resumo executivo |
| `version` | INTEGER | YES | `1` | Versão da análise |
| `is_latest` | BOOLEAN | YES | `true` | Se é a versão mais recente |
| `confidence_score` | NUMERIC(3,2) | YES | `0.80` | Confiança da análise |
| `sources` | JSONB | YES | - | Fontes de dados utilizadas |
| `created_at` | TIMESTAMPTZ | YES | `now()` | Data de criação |
| `updated_at` | TIMESTAMPTZ | YES | `now()` | Data de atualização |
| `generated_by` | VARCHAR | YES | - | Identificador do gerador |
| `original_question` | TEXT | YES | - | Pergunta original do usuário |

### ⚠️ Descoberta Crítica #1: Campo `id` é VARCHAR, não UUID

**Implicação:** O campo `id` aceita qualquer string, não apenas UUIDs! Isso significa que podemos usar IDs customizados.

---

## 📊 Schema da Tabela `agent_econ_memory`

### Estrutura Completa

| Campo | Tipo | Nullable | Default | Observação |
|-------|------|----------|---------|------------|
| `id` | **UUID** | NO | `gen_random_uuid()` | **UUID nativo (diferente da knowledge_base!)** |
| `territory_id` | VARCHAR | NO | - | Código IBGE do município |
| `analysis_content` | TEXT | NO | - | Análise completa |
| `analysis_summary` | TEXT | NO | - | Resumo executivo |
| `embedding_vector` | VECTOR(1536) | YES | - | Vetor para RAG |
| `metadata` | JSONB | NO | `'{}'` | Metadados da análise |
| `confidence_score` | NUMERIC | YES | - | Confiança da análise |
| `user_feedback` | JSONB | YES | `'{}'` | Feedback dos usuários |
| `iterations` | INTEGER | YES | `1` | Número de iterações |
| `analysis_date` | DATE | NO | - | Data da análise |
| `time_range` | JSONB | NO | - | Período analisado |
| `data_sources` | JSONB | NO | - | Fontes de dados |
| `indicators_used` | JSONB | NO | - | Indicadores utilizados |
| `version` | INTEGER | YES | `1` | Versão da análise |
| `is_latest` | BOOLEAN | YES | `true` | Se é a versão mais recente |
| `superseded_by` | UUID | YES | - | ID da versão que substituiu esta |
| `created_at` | TIMESTAMP | YES | `now()` | Data de criação |
| `updated_at` | TIMESTAMP | YES | `now()` | Data de atualização |
| `generated_by` | VARCHAR | YES | `'WF-AGENT-ECON'` | Identificador do gerador |
| `agent_id` | VARCHAR | NO | - | ID do agente (econ, social, etc.) |

### ⚠️ Descoberta Crítica #2: Campo `id` é UUID nativo

**Implicação:** A tabela `agent_econ_memory` usa UUID nativo do PostgreSQL, que é mais restritivo que VARCHAR.

---

## 🚨 PROBLEMA IDENTIFICADO: Incompatibilidade de Tipos

### Situação Atual

```
knowledge_base.id = VARCHAR (aceita qualquer string)
agent_econ_memory.id = UUID (aceita apenas UUIDs válidos)
```

### Implicação para a Proposta de Arquitetura

A proposta original de usar IDs customizados como `"20251208135210-1721000"` **NÃO FUNCIONA** para `agent_econ_memory` porque:

1. ✅ `knowledge_base.id` aceitaria (é VARCHAR)
2. ❌ `agent_econ_memory.id` **rejeitaria** (é UUID nativo)

---

## ✅ SOLUÇÕES POSSÍVEIS

### Solução 1: Usar UUIDs em Todo o Sistema (Recomendada)

**Vantagens:**
- ✅ Compatível com ambas as tabelas
- ✅ Padrão da indústria
- ✅ Globalmente único
- ✅ Não requer sincronização

**Desvantagens:**
- ❌ Menos legível para humanos
- ❌ Não contém informação semântica

**Implementação:**
```javascript
// No Orquestrador
{
  "analysis_id": "{{ $now.toISO() }}-{{ $json.territory_id }}"  // ❌ NÃO FUNCIONA
}

// CORRETO:
{
  "analysis_id": "{{ $('Function').first().json.uuid }}"  // ✅ UUID real
}
```

### Solução 2: Alterar Schema da `agent_econ_memory` para VARCHAR

**Vantagens:**
- ✅ Permite IDs customizados legíveis
- ✅ Consistência com `knowledge_base`
- ✅ IDs semânticos (contêm informação)

**Desvantagens:**
- ❌ Requer migração do banco de dados
- ❌ Perde validação automática de UUID
- ❌ Pode quebrar código existente

**Implementação:**
```sql
ALTER TABLE agent_econ_memory 
ALTER COLUMN id TYPE VARCHAR;

ALTER TABLE agent_econ_memory 
ALTER COLUMN superseded_by TYPE VARCHAR;
```

### Solução 3: Manter Sistemas Separados (Não Recomendada)

**Descrição:** Cada sistema gera seu próprio ID independente.

**Vantagens:**
- ✅ Não requer mudanças

**Desvantagens:**
- ❌ Perde rastreabilidade
- ❌ Dificulta auditoria
- ❌ Não resolve o problema original

---

## 🎯 RECOMENDAÇÃO FINAL

### Opção A: Usar UUIDs Reais (Implementação Imediata)

**Para o MVP, esta é a melhor opção:**

1. **Orquestrador gera UUID real** usando função JavaScript ou nó Code
2. **Envia UUID para o agente** no payload
3. **Agente usa o UUID recebido** em ambas as tabelas
4. **Rastreabilidade mantida** através do UUID

**Código para gerar UUID no n8n:**

```javascript
// Nó "Function" ou "Code" no Orquestrador
const { v4: uuidv4 } = require('uuid');

return {
  analysis_id: uuidv4(),
  territory_id: $input.first().json.territory_id,
  territory_name: $input.first().json.territory_name,
  question: $input.first().json.question,
  requested_at: new Date().toISOString()
};
```

### Opção B: Migrar Schema (Longo Prazo)

**Para a versão final do sistema:**

1. Alterar `agent_econ_memory.id` para VARCHAR
2. Alterar `agent_social_memory.id` para VARCHAR
3. Alterar `agent_terra_memory.id` para VARCHAR
4. Alterar `agent_ambient_memory.id` para VARCHAR
5. Usar IDs semânticos: `{timestamp}-{territory_id}-{dimension}`

---

## 📋 CHECKLIST DE VALIDAÇÃO

- [x] Schema da `knowledge_base` extraído
- [x] Schema da `agent_econ_memory` extraído
- [x] Incompatibilidade de tipos identificada
- [x] Soluções propostas e avaliadas
- [x] Recomendação final definida
- [ ] Implementação da solução escolhida
- [ ] Testes de integração

---

## 🔄 PRÓXIMOS PASSOS

1. **Decisão do usuário:** Escolher entre Opção A (UUID real) ou Opção B (migração)
2. **Implementação:** Aplicar a solução escolhida
3. **Testes:** Validar que IDs são consistentes entre tabelas
4. **Documentação:** Atualizar guias com a solução implementada

---

**Conclusão:** A proposta de IDs customizados é **tecnicamente viável**, mas requer **migração do schema** da tabela `agent_econ_memory`. Para o MVP, **usar UUIDs reais** é a solução mais rápida e segura.
