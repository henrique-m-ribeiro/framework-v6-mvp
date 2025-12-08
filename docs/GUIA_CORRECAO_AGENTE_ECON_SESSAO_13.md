# Guia Passo a Passo: Correção do Agente ECON V6.1

**Sessão #13 - Framework de Inteligência Territorial V6.0**  
**Objetivo:** Adicionar salvamento de análises na memória do agente (`agent_econ_memory`)  
**Tempo Estimado:** 15-20 minutos  
**Dificuldade:** ⭐⭐⭐ Intermediária/Avançada

---

## 📋 PRÉ-REQUISITOS

- ✅ Acesso ao n8n Cloud (https://galactic-ai.app.n8n.cloud)
- ✅ Workflow "WF-AGENT-ECON - Especialista Econômico V6.1" ativo
- ✅ Credenciais do banco PostgreSQL configuradas
- ✅ Correção do Orquestrador já aplicada (guia anterior)

---

## 🎯 PROBLEMA A SER CORRIGIDO

O Agente ECON não está salvando as análises geradas na sua memória (`agent_econ_memory`):
- Tabela `agent_econ_memory` está vazia (0 registros)
- Agente não tem memória de análises anteriores
- RAG do agente não funciona
- Expertise evolui, mas sem contexto histórico

**Causa:** O workflow **não tem um nó** para salvar na memória.

---

## 📝 PASSO 1: Acessar o Workflow do Agente ECON

1. Faça login no n8n Cloud: https://galactic-ai.app.n8n.cloud
2. No menu lateral esquerdo, clique em **"Workflows"**
3. Localize e abra o workflow: **"WF-AGENT-ECON - Especialista Econômico V6.1 (Multidimensional)"**
4. O workflow deve abrir no editor visual

---

## 📝 PASSO 2: Entender o Fluxo Atual

Antes de adicionar o novo nó, vamos entender o fluxo atual:

```
1. Webhook - Recebe Tarefa
   ↓
2. Normalizar Entrada
   ↓
3. Consultar Memória e Aprendizados
   ↓
4. Consultar Dados PostgreSQL
   ↓
5. Preparar Contexto para LLM
   ↓
6. Gerar Análise com OpenAI
   ↓
7. Estruturar Resposta
   ↓
8. Preparar Dados para Salvar
   ↓
9. Respond to Webhook  ← PROBLEMA: Não salva na memória antes de responder!
```

**O que está faltando:** Um nó para salvar na `agent_econ_memory` entre "Preparar Dados para Salvar" e "Respond to Webhook".

---

## 📝 PASSO 3: Localizar o Nó "Preparar Dados para Salvar"

1. No canvas do workflow, localize o nó chamado:
   ```
   Preparar Dados para Salvar
   ```

2. Este nó deve estar conectado ao nó:
   ```
   Respond to Webhook
   ```

3. Vamos adicionar um novo nó **entre** esses dois nós

---

## 📝 PASSO 4: Adicionar um Novo Nó PostgreSQL

1. Clique no **conector** (linha) entre "Preparar Dados para Salvar" e "Respond to Webhook"
2. Clique no botão **"+"** que aparece no meio do conector
3. Na janela "Add node", procure por **"PostgreSQL"**
4. Clique em **"Postgres"** para adicionar o nó

---

## 📝 PASSO 5: Configurar o Novo Nó PostgreSQL

### 5.1. Renomear o Nó

1. Com o nó selecionado, no painel à direita, localize o campo **"Name"** (Nome)
2. Altere o nome para:
   ```
   PostgreSQL - Salvar na Memória
   ```

### 5.2. Configurar a Credencial

1. No campo **"Credential to connect with"**, selecione a mesma credencial PostgreSQL usada nos outros nós
   - Geralmente algo como: "PostgreSQL account - Neon Database"

### 5.3. Configurar a Operação

1. No campo **"Operation"**, selecione: **"Execute Query"**

---

## 📝 PASSO 6: Configurar a Query SQL

1. No campo **"Query"**, cole a seguinte query SQL:

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

### Explicação da Query

- **`id`**: UUID único da análise (vem do nó "Preparar Dados para Salvar")
- **`agent_id`**: Sempre 'econ' para este agente
- **`territory_id`**: ID do território analisado (ex: "1721000")
- **`analysis_content`**: Texto completo da análise gerada
- **`analysis_summary`**: Resumo executivo da análise
- **`confidence_score`**: Nível de confiança da análise (0-1)
- **`metadata`**: Metadados adicionais em formato JSON
- **`time_range`**: Período temporal dos dados analisados
- **`data_sources`**: Fontes de dados utilizadas
- **`indicators_used`**: Indicadores consultados
- **`embedding_vector`**: NULL (será gerado de forma assíncrona)
- **`ON CONFLICT`**: Se já existir uma análise com o mesmo ID, atualiza

---

## 📝 PASSO 7: Configurar Opções do Nó

1. Clique na aba **"Options"** (Opções) no painel de configuração

2. Configure as seguintes opções:

   - **Return Output**: ✅ **Habilitado** (ON)
     - Isso permite que o próximo nó receba os dados salvos
   
   - **Continue On Fail**: ❌ **Desabilitado** (OFF)
     - Queremos detectar erros de salvamento

---

## 📝 PASSO 8: Reconectar o Fluxo

Agora precisamos garantir que o fluxo está correto:

### 8.1. Verificar Conexão de Entrada

1. O nó "PostgreSQL - Salvar na Memória" deve estar conectado **a partir de**:
   ```
   Preparar Dados para Salvar
   ```

2. Se não estiver conectado, arraste uma conexão do ponto de saída de "Preparar Dados para Salvar" para o ponto de entrada de "PostgreSQL - Salvar na Memória"

### 8.2. Conectar ao Próximo Nó

1. Arraste uma conexão do ponto de saída de "PostgreSQL - Salvar na Memória" para o ponto de entrada de:
   ```
   Registrar Aprendizado Automático
   ```

2. **IMPORTANTE:** O fluxo agora deve ser:
   ```
   Preparar Dados para Salvar
     ↓
   PostgreSQL - Salvar na Memória  ← NOVO NÓ
     ↓
   Registrar Aprendizado Automático
     ↓
   Atualizar Expertise
     ↓
   Registrar Auditoria do Ciclo
     ↓
   Respond to Webhook
   ```

---

## 📝 PASSO 9: Ajustar Conexões dos Nós Seguintes

Como adicionamos um novo nó no meio do fluxo, precisamos garantir que os nós seguintes estão recebendo os dados corretos.

### 9.1. Verificar Nó "Registrar Aprendizado Automático"

1. Clique no nó **"Registrar Aprendizado Automático"**
2. Verifique se a query SQL está acessando os dados corretamente
3. A query deve usar `$json.id` e `$json.territory_id` (que vêm do nó "Preparar Dados para Salvar")

**Não é necessário alterar nada neste nó**, pois ele já está configurado corretamente.

---

## 📝 PASSO 10: Salvar as Alterações

1. Clique em **"Save"** (Salvar) no canto superior direito do workflow
2. O n8n salvará automaticamente as alterações

---

## 📝 PASSO 11: Ativar o Workflow

1. Verifique se o workflow está **ATIVO** (toggle no canto superior direito deve estar verde)
2. Se estiver inativo, clique no toggle para ativar

---

## 🧪 PASSO 12: Testar a Correção

### 12.1. Executar um Teste

Use o curl ou Postman para enviar uma requisição ao webhook do Orquestrador (que chamará o Agente ECON):

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/orchestrator \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "territory_name": "Palmas",
    "question": "Qual o PIB de Palmas?"
  }'
```

### 12.2. Verificar a Execução no n8n

1. No n8n, clique na aba **"Executions"** (Execuções) no menu lateral
2. Localize a execução mais recente do **Agente ECON**
3. Clique nela para ver os detalhes
4. Verifique se o novo nó **"PostgreSQL - Salvar na Memória"** executou com sucesso (ícone verde ✓)

### 12.3. Validar no Banco de Dados

Execute esta query no banco PostgreSQL para verificar se os dados foram salvos:

```sql
SELECT 
    id,
    agent_id,
    territory_id,
    LENGTH(analysis_content) as content_length,
    LENGTH(analysis_summary) as summary_length,
    confidence_score,
    created_at
FROM agent_econ_memory
WHERE territory_id = '1721000'
ORDER BY created_at DESC
LIMIT 1;
```

**Resultado esperado:**
- `agent_id` = **"econ"**
- `territory_id` = **"1721000"**
- `content_length` > **5000**
- `summary_length` > **100**
- `confidence_score` > **0.75**

---

## ✅ CHECKLIST DE VALIDAÇÃO

Marque cada item após validar:

- [ ] Novo nó PostgreSQL foi adicionado
- [ ] Nó foi renomeado para "PostgreSQL - Salvar na Memória"
- [ ] Query SQL foi configurada corretamente
- [ ] Opção "Return Output" está habilitada
- [ ] Fluxo está conectado corretamente
- [ ] Workflow foi salvo
- [ ] Workflow está ativo
- [ ] Teste foi executado sem erros
- [ ] Execução aparece como "Succeeded" no n8n
- [ ] Novo nó "PostgreSQL - Salvar na Memória" executou com sucesso
- [ ] Banco de dados tem registro na `agent_econ_memory`
- [ ] Registro tem `content_length` > 5000
- [ ] Registro tem `confidence_score` > 0.75

---

## 🚨 TROUBLESHOOTING

### Problema: "Syntax error in SQL query"

**Solução:** Verifique se você copiou a query completa corretamente. Preste atenção especial às aspas simples e duplas.

---

### Problema: "Cannot read property 'id' of undefined"

**Solução:** Isso significa que o nó "Preparar Dados para Salvar" não está retornando o campo `id`. Verifique se este nó está executando corretamente.

**Diagnóstico:**
1. Execute o workflow em modo de teste
2. Clique no nó "Preparar Dados para Salvar"
3. Verifique se o output tem o campo `id`

---

### Problema: "Duplicate key value violates unique constraint"

**Solução:** Isso significa que já existe um registro com o mesmo `id` na tabela. Isso é normal se você estiver testando múltiplas vezes.

**Ação:** A query já tem `ON CONFLICT DO UPDATE`, então ela deve atualizar o registro existente. Se o erro persistir, verifique se a cláusula `ON CONFLICT` está correta.

---

### Problema: Nó executa mas não salva nada no banco

**Solução:** Verifique os logs de erro do PostgreSQL.

**Diagnóstico:**
1. Clique no nó "PostgreSQL - Salvar na Memória" na execução
2. Veja se há alguma mensagem de erro
3. Verifique se a credencial PostgreSQL está configurada corretamente

---

## 📊 COMPARAÇÃO: ANTES vs. DEPOIS

| Métrica | Antes (Errado) | Depois (Correto) |
|---------|----------------|------------------|
| Registros em agent_econ_memory | 0 | 1+ |
| Agente tem memória | ❌ Não | ✅ Sim |
| RAG do agente funciona | ❌ Não | ✅ Sim |
| Expertise evolui com contexto | ❌ Não | ✅ Sim |

---

## 🎓 O QUE VOCÊ APRENDEU

### Conceito: Fluxo de Dados em Workflows

Quando você adiciona um novo nó no meio de um fluxo:

1. **Dados fluem sequencialmente** de nó em nó
2. **Cada nó recebe** os dados do nó anterior via `$json`
3. **Cada nó pode transformar** os dados antes de passar para o próximo
4. **Conexões são críticas** - se um nó não estiver conectado, ele não executará

### Conceito: Memória de Agentes

A memória de um agente é essencial para:

1. **RAG (Retrieval-Augmented Generation)** - Buscar análises anteriores similares
2. **Aprendizado Evolutivo** - Melhorar com base em análises passadas
3. **Contexto Histórico** - Entender tendências e mudanças ao longo do tempo
4. **Consistência** - Manter coerência entre análises do mesmo território

---

## 📚 PRÓXIMOS PASSOS

Após concluir esta correção, você deve aplicar a **mesma correção** nos outros 3 agentes:

1. ✅ **Agente SOCIAL** - Adicionar nó de salvamento na `agent_social_memory`
2. ✅ **Agente TERRA** - Adicionar nó de salvamento na `agent_terra_memory`
3. ✅ **Agente AMBIENT** - Adicionar nó de salvamento na `agent_ambient_memory`

**Próximo guia:** `GUIA_CORRECAO_AGENTES_RESTANTES_SESSAO_13.md`

---

## 🔄 REPLICAÇÃO PARA OUTROS AGENTES

A correção é **idêntica** para os outros agentes, apenas trocando:

| Agente | Tabela | agent_id |
|--------|--------|----------|
| SOCIAL | agent_social_memory | 'social' |
| TERRA | agent_terra_memory | 'terra' |
| AMBIENT | agent_ambient_memory | 'ambient' |

**Exemplo para Agente SOCIAL:**

```sql
INSERT INTO agent_social_memory (
  id,
  agent_id,  -- 'social' em vez de 'econ'
  territory_id,
  analysis_content,
  ...
)
VALUES (
  '{{ $json.id }}',
  'social',  -- ← ÚNICA DIFERENÇA
  '{{ $json.territory_id }}',
  ...
)
```

---

## 📞 SUPORTE

Se você encontrar problemas durante a correção:

1. Verifique se seguiu todos os passos na ordem
2. Consulte a seção de Troubleshooting acima
3. Verifique os logs de execução no n8n (aba "Executions")
4. Consulte a documentação completa: `DIAGNOSTICO_PROBLEMAS_SALVAMENTO_SESSAO_13.md`

---

**Status:** ✅ GUIA COMPLETO  
**Próximo:** Correção dos Agentes SOCIAL, TERRA e AMBIENT  
**Autor:** Manus AI (Facilitador)  
**Data:** 06/12/2025  
**Versão:** 1.0
