# Guia Passo a Passo: Correção do Orquestrador V3.2

**Sessão #13 - Framework de Inteligência Territorial V6.0**  
**Objetivo:** Corrigir o salvamento de dados na `knowledge_base`  
**Tempo Estimado:** 10-15 minutos  
**Dificuldade:** ⭐⭐ Intermediária

---

## 📋 PRÉ-REQUISITOS

- ✅ Acesso ao n8n Cloud (https://galactic-ai.app.n8n.cloud)
- ✅ Workflow "WF-AGENT-ORCHESTRATOR - Orquestrador Central V3.2" ativo
- ✅ Credenciais do banco PostgreSQL configuradas

---

## 🎯 PROBLEMA A SER CORRIGIDO

O Orquestrador está salvando dados incompletos na `knowledge_base`:
- `dimension` = "unknown" (deveria ser "economic", "social", etc.)
- `content` = 22 caracteres (deveria ter 5.000+ caracteres)
- `summary`, `confidence_score`, `metadata` = vazios ou incorretos

**Causa:** O nó PostgreSQL está usando `$json` (contexto errado) em vez de `$input.first().json` (contexto correto).

---

## 📝 PASSO 1: Acessar o Workflow do Orquestrador

1. Faça login no n8n Cloud: https://galactic-ai.app.n8n.cloud
2. No menu lateral esquerdo, clique em **"Workflows"**
3. Localize e abra o workflow: **"WF-AGENT-ORCHESTRATOR - Orquestrador Central V3.2"**
4. O workflow deve abrir no editor visual

---

## 📝 PASSO 2: Localizar o Nó de Salvamento

1. No canvas do workflow, localize o nó chamado:
   ```
   PostgreSQL - Salvar na Knowledge Base
   ```

2. **Dica visual:** Este nó geralmente está conectado aos 4 nós HTTP Request:
   - HTTP Request - Chamar Agente ECON
   - HTTP Request - Chamar Agente SOCIAL
   - HTTP Request - Chamar Agente TERRA
   - HTTP Request - Chamar Agente AMBIENT

3. Clique no nó para selecioná-lo
4. O painel de configuração deve abrir à direita

---

## 📝 PASSO 3: Abrir o Editor de Query SQL

1. No painel de configuração do nó, você verá:
   - **Operation:** Execute Query
   - **Query:** (campo de texto grande)

2. Clique no campo **Query** para abrir o editor de SQL

3. Você verá uma query SQL começando com:
   ```sql
   -- Salvar análise na knowledge_base (Camada 3: Memória Organizacional)
   INSERT INTO knowledge_base (
   ```

---

## 📝 PASSO 4: Fazer Backup da Query Atual

**IMPORTANTE:** Antes de fazer qualquer alteração, copie a query atual para um arquivo de texto como backup.

1. Selecione todo o texto da query (Ctrl+A ou Cmd+A)
2. Copie (Ctrl+C ou Cmd+C)
3. Cole em um arquivo de texto local e salve como `backup_query_orquestrador.sql`

---

## 📝 PASSO 5: Aplicar as Correções na Query

Você precisa fazer **7 substituições** na query. Vou listar cada uma:

### Substituição 1: Campo `dimension`

**Encontre esta linha:**
```sql
'{{ $json.dimension || "unknown" }}',
```

**Substitua por:**
```sql
'{{ $input.first().json.dimension || "unknown" }}',
```

---

### Substituição 2: Campo `analysis_type`

**Encontre esta linha:**
```sql
'{{ $json.analysis_type || "diagnostic" }}',
```

**Substitua por:**
```sql
'{{ $input.first().json.analysis_type || "diagnostic" }}',
```

---

### Substituição 3: Campo `content`

**Encontre esta linha:**
```sql
'{{ $json.analysis_content || $json.content || "Análise não disponível" }}',
```

**Substitua por:**
```sql
'{{ $input.first().json.analysis_content || $input.first().json.content || "Análise não disponível" }}',
```

---

### Substituição 4: Campo `summary`

**Encontre esta linha:**
```sql
'{{ $json.analysis_summary || $json.summary || "" }}',
```

**Substitua por:**
```sql
'{{ $input.first().json.analysis_summary || $input.first().json.summary || "" }}',
```

---

### Substituição 5: Campo `metadata` (dentro do jsonb_build_object)

**Encontre esta linha:**
```sql
'agent_metadata', '{{ $json.metadata || \"{}\" }}'::jsonb
```

**Substitua por:**
```sql
'agent_metadata', '{{ $input.first().json.metadata || \"{}\" }}'::jsonb
```

---

### Substituição 6: Campo `confidence_score`

**Encontre esta linha:**
```sql
{{ $json.confidence_score || 0.80 }},
```

**Substitua por:**
```sql
{{ $input.first().json.confidence_score || 0.80 }},
```

---

### Substituição 7: Campo `sources`

**Encontre esta linha:**
```sql
'{{ $json.data_sources || $json.sources || \"[]\" }}'::jsonb,
```

**Substitua por:**
```sql
'{{ $input.first().json.data_sources || $input.first().json.sources || \"[]\" }}'::jsonb,
```

---

## 📝 PASSO 6: Query SQL Completa Corrigida

Para facilitar, aqui está a **query completa corrigida** que você pode copiar e colar:

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

**Como usar:**
1. Selecione toda a query atual no editor do n8n
2. Delete (Backspace ou Delete)
3. Cole a query corrigida acima
4. Verifique se não há erros de formatação

---

## 📝 PASSO 7: Salvar as Alterações

1. Após colar a query corrigida, clique no botão **"Execute Node"** (ícone de play) para testar a sintaxe
   - **Nota:** O nó pode falhar porque não há dados de entrada, mas isso é normal
   - O importante é verificar se não há erros de sintaxe SQL

2. Se não houver erros de sintaxe, clique em **"Save"** (Salvar) no canto superior direito do workflow

3. O n8n salvará automaticamente as alterações

---

## 📝 PASSO 8: Ativar o Workflow

1. Verifique se o workflow está **ATIVO** (toggle no canto superior direito deve estar verde)
2. Se estiver inativo, clique no toggle para ativar

---

## 🧪 PASSO 9: Testar a Correção

Agora vamos testar se a correção funcionou:

### 9.1. Executar um Teste

Use o curl ou Postman para enviar uma requisição ao webhook do Orquestrador:

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/orchestrator \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "territory_name": "Palmas",
    "question": "Qual o PIB de Palmas?"
  }'
```

### 9.2. Verificar a Execução no n8n

1. No n8n, clique na aba **"Executions"** (Execuções) no menu lateral
2. Localize a execução mais recente do Orquestrador
3. Clique nela para ver os detalhes
4. Verifique se todos os nós executaram com sucesso (ícone verde ✓)

### 9.3. Validar no Banco de Dados

Execute esta query no banco PostgreSQL para verificar se os dados foram salvos corretamente:

```sql
SELECT 
    id,
    territory_id,
    dimension,
    analysis_type,
    LENGTH(content) as content_length,
    LENGTH(summary) as summary_length,
    confidence_score,
    created_at
FROM knowledge_base
WHERE territory_id = '1721000'
ORDER BY created_at DESC
LIMIT 1;
```

**Resultado esperado:**
- `dimension` = **"economic"** (não "unknown")
- `content_length` > **5000** (não 22)
- `summary_length` > **100**
- `confidence_score` > **0.80**

---

## ✅ CHECKLIST DE VALIDAÇÃO

Marque cada item após validar:

- [ ] Query SQL foi alterada com sucesso
- [ ] Workflow foi salvo
- [ ] Workflow está ativo
- [ ] Teste foi executado sem erros
- [ ] Execução aparece como "Succeeded" no n8n
- [ ] Banco de dados tem registro com `dimension` correto
- [ ] Banco de dados tem registro com `content_length` > 5000
- [ ] Banco de dados tem registro com `summary_length` > 100
- [ ] Banco de dados tem registro com `confidence_score` > 0.80

---

## 🚨 TROUBLESHOOTING

### Problema: "Syntax error in SQL query"

**Solução:** Verifique se você copiou a query completa corretamente. Preste atenção especial às aspas duplas (`\"`) que devem ser escapadas.

---

### Problema: "Cannot read property 'dimension' of undefined"

**Solução:** Isso pode acontecer se o agente não retornou o campo `dimension`. Verifique se o agente ECON está retornando todos os campos esperados.

**Query de diagnóstico:**
```sql
-- Ver o que o agente ECON está retornando
SELECT * FROM agent_econ_memory ORDER BY created_at DESC LIMIT 1;
```

---

### Problema: Workflow executa mas `dimension` ainda é "unknown"

**Solução:** Isso significa que o agente não está retornando o campo `dimension`. Você precisará corrigir o workflow do agente ECON também (próximo guia).

---

### Problema: `content_length` ainda é 22

**Solução:** Verifique se você substituiu corretamente a linha do campo `content`. Deve ser:
```sql
'{{ $input.first().json.analysis_content || $input.first().json.content || "Análise não disponível" }}',
```

---

## 📊 COMPARAÇÃO: ANTES vs. DEPOIS

| Campo | Antes (Errado) | Depois (Correto) |
|-------|----------------|------------------|
| dimension | "unknown" | "economic" |
| content_length | 22 chars | 5.000+ chars |
| summary_length | 0 chars | 100+ chars |
| confidence_score | 0.80 (padrão) | 0.92 (real) |
| metadata | "{}" | {...} completo |

---

## 🎓 O QUE VOCÊ APRENDEU

### Conceito: Contexto de Dados no n8n

No n8n, existem diferentes formas de acessar dados:

1. **`$json`** - Dados do **próprio nó** (contexto atual)
2. **`$input.first().json`** - Dados do **nó anterior** (contexto de entrada)
3. **`$('Nome do Nó').first().json`** - Dados de um **nó específico**

**Regra de ouro:** Quando você quer acessar dados de um nó anterior (como a resposta de um HTTP Request), use `$input.first().json` ou `$('Nome do Nó').first().json`.

---

## 📚 PRÓXIMOS PASSOS

Após concluir esta correção, você deve:

1. ✅ **Corrigir o Agente ECON** - Adicionar nó de salvamento na memória
2. ✅ **Corrigir o Agente SOCIAL** - Adicionar nó de salvamento na memória
3. ✅ **Corrigir o Agente TERRA** - Adicionar nó de salvamento na memória
4. ✅ **Corrigir o Agente AMBIENT** - Adicionar nó de salvamento na memória

**Próximo guia:** `GUIA_CORRECAO_AGENTE_ECON_SESSAO_13.md`

---

## 📞 SUPORTE

Se você encontrar problemas durante a correção:

1. Verifique o backup que você fez no Passo 4
2. Consulte a seção de Troubleshooting acima
3. Verifique os logs de execução no n8n (aba "Executions")
4. Consulte a documentação completa: `DIAGNOSTICO_PROBLEMAS_SALVAMENTO_SESSAO_13.md`

---

**Status:** ✅ GUIA COMPLETO  
**Próximo:** Correção do Agente ECON  
**Autor:** Manus AI (Facilitador)  
**Data:** 06/12/2025  
**Versão:** 1.0
