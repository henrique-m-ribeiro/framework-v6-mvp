# Guia de Teste de Integração Completa - Sessão #13

**Framework de Inteligência Territorial V6.0**  
**Objetivo:** Validar que todas as correções funcionam end-to-end  
**Tempo Estimado:** 30-40 minutos  
**Dificuldade:** ⭐⭐ Intermediária

---

## 📋 PRÉ-REQUISITOS

- ✅ Correção do Orquestrador aplicada
- ✅ Correção do Agente ECON aplicada
- ✅ Correção do Agente SOCIAL aplicada
- ✅ Correção do Agente TERRA aplicada
- ✅ Correção do Agente AMBIENT aplicada
- ✅ Todos os workflows ativos no n8n Cloud
- ✅ Acesso ao banco PostgreSQL (Neon)

---

## 🎯 OBJETIVO DO TESTE

Validar que:

1. **Orquestrador** roteia corretamente para cada agente
2. **Cada agente** gera análise completa
3. **knowledge_base** recebe dados completos
4. **Memórias dos agentes** recebem dados completos
5. **Ciclo de aprendizagem** funciona para todos os agentes
6. **Expertise** evolui corretamente

---

## 🧪 TESTE 1: Agente ECON (Dimensão Econômica)

### 1.1. Executar Requisição

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2 \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "territory_name": "Palmas",
    "question": "Qual o PIB de Palmas?"
  }'
```

### 1.2. Validar Resposta

A resposta deve conter:
- ✅ `analysis_content` (texto longo, 5.000+ caracteres)
- ✅ `analysis_summary` (resumo executivo)
- ✅ `confidence_score` (> 0.80)
- ✅ `dimension` = "economic"

### 1.3. Validar knowledge_base

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
  AND dimension = 'economic'
ORDER BY created_at DESC
LIMIT 1;
```

**Esperado:**
- `dimension` = **"economic"** ✅
- `content_length` > **5000** ✅
- `summary_length` > **100** ✅
- `confidence_score` > **0.80** ✅

### 1.4. Validar agent_econ_memory

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

**Esperado:**
- `agent_id` = **"econ"** ✅
- `content_length` > **5000** ✅
- `summary_length` > **100** ✅
- `confidence_score` > **0.75** ✅

### 1.5. Validar Aprendizagem

```sql
SELECT * FROM get_agent_expertise('econ');
```

**Esperado:**
- `learning_count` aumentou
- `expertise_level` pode ter evoluído (NOVATO → COMPETENTE → EXPERIENTE → ESPECIALISTA)

---

## 🧪 TESTE 2: Agente SOCIAL (Dimensão Social)

### 2.1. Executar Requisição

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2 \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "territory_name": "Palmas",
    "question": "Como está a educação em Palmas?"
  }'
```

### 2.2. Validar knowledge_base

```sql
SELECT 
    dimension,
    LENGTH(content) as content_length,
    confidence_score
FROM knowledge_base
WHERE territory_id = '1721000'
  AND dimension = 'social'
ORDER BY created_at DESC
LIMIT 1;
```

**Esperado:**
- `dimension` = **"social"** ✅
- `content_length` > **5000** ✅

### 2.3. Validar agent_social_memory

```sql
SELECT 
    agent_id,
    LENGTH(analysis_content) as content_length
FROM agent_social_memory
WHERE territory_id = '1721000'
ORDER BY created_at DESC
LIMIT 1;
```

**Esperado:**
- `agent_id` = **"social"** ✅
- `content_length` > **5000** ✅

### 2.4. Validar Aprendizagem

```sql
SELECT * FROM get_agent_expertise('social');
```

---

## 🧪 TESTE 3: Agente TERRA (Dimensão Territorial)

### 3.1. Executar Requisição

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2 \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "territory_name": "Palmas",
    "question": "Como está a urbanização de Palmas?"
  }'
```

### 3.2. Validar knowledge_base

```sql
SELECT 
    dimension,
    LENGTH(content) as content_length,
    confidence_score
FROM knowledge_base
WHERE territory_id = '1721000'
  AND dimension = 'territorial'
ORDER BY created_at DESC
LIMIT 1;
```

**Esperado:**
- `dimension` = **"territorial"** ✅
- `content_length` > **5000** ✅

### 3.3. Validar agent_terra_memory

```sql
SELECT 
    agent_id,
    LENGTH(analysis_content) as content_length
FROM agent_terra_memory
WHERE territory_id = '1721000'
ORDER BY created_at DESC
LIMIT 1;
```

**Esperado:**
- `agent_id` = **"terra"** ✅
- `content_length` > **5000** ✅

### 3.4. Validar Aprendizagem

```sql
SELECT * FROM get_agent_expertise('terra');
```

---

## 🧪 TESTE 4: Agente AMBIENT (Dimensão Ambiental)

### 4.1. Executar Requisição

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2 \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "territory_name": "Palmas",
    "question": "Como está o meio ambiente em Palmas?"
  }'
```

### 4.2. Validar knowledge_base

```sql
SELECT 
    dimension,
    LENGTH(content) as content_length,
    confidence_score
FROM knowledge_base
WHERE territory_id = '1721000'
  AND dimension = 'environmental'
ORDER BY created_at DESC
LIMIT 1;
```

**Esperado:**
- `dimension` = **"environmental"** ✅
- `content_length` > **5000** ✅

### 4.3. Validar agent_ambient_memory

```sql
SELECT 
    agent_id,
    LENGTH(analysis_content) as content_length
FROM agent_ambient_memory
WHERE territory_id = '1721000'
ORDER BY created_at DESC
LIMIT 1;
```

**Esperado:**
- `agent_id` = **"ambient"** ✅
- `content_length` > **5000** ✅

### 4.4. Validar Aprendizagem

```sql
SELECT * FROM get_agent_expertise('ambient');
```

---

## 📊 VALIDAÇÃO CONSOLIDADA

Execute esta query para ver o panorama completo:

```sql
-- Visão consolidada de todas as análises
SELECT 
  'knowledge_base' as tabela,
  dimension as dimensao,
  COUNT(*) as total,
  AVG(LENGTH(content)) as media_tamanho,
  AVG(confidence_score) as media_confianca
FROM knowledge_base
WHERE territory_id = '1721000'
GROUP BY dimension

UNION ALL

SELECT 
  'agent_econ_memory' as tabela,
  'economic' as dimensao,
  COUNT(*) as total,
  AVG(LENGTH(analysis_content)) as media_tamanho,
  AVG(confidence_score) as media_confianca
FROM agent_econ_memory
WHERE territory_id = '1721000'

UNION ALL

SELECT 
  'agent_social_memory' as tabela,
  'social' as dimensao,
  COUNT(*) as total,
  AVG(LENGTH(analysis_content)) as media_tamanho,
  AVG(confidence_score) as media_confianca
FROM agent_social_memory
WHERE territory_id = '1721000'

UNION ALL

SELECT 
  'agent_terra_memory' as tabela,
  'territorial' as dimensao,
  COUNT(*) as total,
  AVG(LENGTH(analysis_content)) as media_tamanho,
  AVG(confidence_score) as media_confianca
FROM agent_terra_memory
WHERE territory_id = '1721000'

UNION ALL

SELECT 
  'agent_ambient_memory' as tabela,
  'environmental' as dimensao,
  COUNT(*) as total,
  AVG(LENGTH(analysis_content)) as media_tamanho,
  AVG(confidence_score) as media_confianca
FROM agent_ambient_memory
WHERE territory_id = '1721000';
```

**Resultado esperado:**

| tabela | dimensao | total | media_tamanho | media_confianca |
|--------|----------|-------|---------------|-----------------|
| knowledge_base | economic | 1+ | 5000+ | 0.85+ |
| knowledge_base | social | 1+ | 5000+ | 0.85+ |
| knowledge_base | territorial | 1+ | 5000+ | 0.85+ |
| knowledge_base | environmental | 1+ | 5000+ | 0.85+ |
| agent_econ_memory | economic | 1+ | 5000+ | 0.80+ |
| agent_social_memory | social | 1+ | 5000+ | 0.80+ |
| agent_terra_memory | territorial | 1+ | 5000+ | 0.80+ |
| agent_ambient_memory | environmental | 1+ | 5000+ | 0.80+ |

---

## ✅ CHECKLIST DE VALIDAÇÃO COMPLETA

### Teste 1: Agente ECON
- [ ] Requisição executada sem erros
- [ ] Resposta contém análise completa
- [ ] knowledge_base tem registro correto
- [ ] agent_econ_memory tem registro correto
- [ ] Expertise do agente evoluiu

### Teste 2: Agente SOCIAL
- [ ] Requisição executada sem erros
- [ ] knowledge_base tem registro correto
- [ ] agent_social_memory tem registro correto
- [ ] Expertise do agente evoluiu

### Teste 3: Agente TERRA
- [ ] Requisição executada sem erros
- [ ] knowledge_base tem registro correto
- [ ] agent_terra_memory tem registro correto
- [ ] Expertise do agente evoluiu

### Teste 4: Agente AMBIENT
- [ ] Requisição executada sem erros
- [ ] knowledge_base tem registro correto
- [ ] agent_ambient_memory tem registro correto
- [ ] Expertise do agente evoluiu

### Validação Consolidada
- [ ] Query consolidada executada
- [ ] Todas as 8 linhas presentes
- [ ] Todas as médias de tamanho > 5000
- [ ] Todas as médias de confiança > 0.80

---

## 📈 MÉTRICAS DE SUCESSO

| Métrica | Meta | Como Medir |
|---------|------|------------|
| Taxa de Sucesso | 100% | 4/4 testes bem-sucedidos |
| Salvamento na KB | 100% | 4/4 registros na knowledge_base |
| Salvamento na Memória | 100% | 4/4 registros nas memórias dos agentes |
| Tamanho Médio de Análise | > 5000 chars | Query consolidada |
| Confiança Média | > 0.80 | Query consolidada |
| Tempo Médio de Resposta | < 60s | Monitorar execuções no n8n |

---

## 🚨 TROUBLESHOOTING

### Problema: Um dos testes falhou

**Diagnóstico:**
1. Verifique os logs de execução no n8n
2. Identifique qual nó falhou
3. Verifique se a correção foi aplicada corretamente

**Ação:**
- Revise o guia de correção correspondente
- Verifique se o workflow está ativo
- Teste novamente

---

### Problema: knowledge_base tem dados mas memória do agente está vazia

**Diagnóstico:**
- O Orquestrador foi corrigido, mas o agente não

**Ação:**
- Revise o guia de correção do agente específico
- Verifique se o nó "PostgreSQL - Salvar na Memória" foi adicionado
- Verifique se o nó está conectado ao fluxo

---

### Problema: Análise muito curta (< 1000 caracteres)

**Diagnóstico:**
- O agente pode não estar consultando dados suficientes
- O prompt do LLM pode estar incompleto

**Ação:**
- Verifique se o banco tem dados para o território
- Verifique se o nó "Consultar Dados PostgreSQL" está retornando dados
- Verifique o prompt no nó "Gerar Análise com OpenAI"

---

## 🎉 RESULTADO ESPERADO

Ao concluir todos os testes com sucesso, você terá:

✅ **Sistema de Orquestração Completo**
- Roteamento inteligente funcionando
- 4 agentes especializados operacionais

✅ **Memória Organizacional Funcional**
- knowledge_base com análises completas
- Busca semântica pronta para implementação

✅ **Memória Individual dos Agentes**
- Cada agente com histórico de análises
- RAG individual funcionando

✅ **Aprendizagem Evolutiva**
- Expertise dos agentes evoluindo
- Ciclo de aprendizagem automático

✅ **Base Sólida para Análise Multidimensional**
- Todos os componentes necessários funcionando
- Pronto para implementar colaboração entre agentes

---

## 📚 PRÓXIMOS PASSOS

Após validar todos os testes:

1. ✅ **Documentar Resultados** - Registrar métricas e aprendizados
2. ✅ **Atualizar Estado do Projeto** - Marcar correções como concluídas
3. ✅ **Projetar Análise Multidimensional** - Definir lógica de colaboração
4. ✅ **Implementar Análise Multidimensional** - Modificar Orquestrador
5. ✅ **Testar Análise Multidimensional** - Validar colaboração entre agentes

**Próximo:** Projeto de Análise Multidimensional

---

## 📊 TEMPLATE DE RELATÓRIO DE TESTE

Use este template para documentar seus resultados:

```markdown
# Relatório de Teste de Integração - Sessão #13

**Data:** [DATA]
**Executor:** [SEU NOME]

## Resultados

### Teste 1: Agente ECON
- Status: [ ] Sucesso [ ] Falha
- Tempo de execução: [X]s
- Tamanho da análise: [X] caracteres
- Confidence score: [X]

### Teste 2: Agente SOCIAL
- Status: [ ] Sucesso [ ] Falha
- Tempo de execução: [X]s
- Tamanho da análise: [X] caracteres
- Confidence score: [X]

### Teste 3: Agente TERRA
- Status: [ ] Sucesso [ ] Falha
- Tempo de execução: [X]s
- Tamanho da análise: [X] caracteres
- Confidence score: [X]

### Teste 4: Agente AMBIENT
- Status: [ ] Sucesso [ ] Falha
- Tempo de execução: [X]s
- Tamanho da análise: [X] caracteres
- Confidence score: [X]

## Métricas Consolidadas

- Taxa de sucesso: [X]%
- Tempo médio: [X]s
- Tamanho médio: [X] caracteres
- Confiança média: [X]

## Problemas Encontrados

[Listar problemas, se houver]

## Conclusão

[ ] Todos os testes passaram - Sistema pronto para análise multidimensional
[ ] Alguns testes falharam - Revisar correções necessárias
```

---

**Status:** ✅ GUIA COMPLETO  
**Próximo:** Projeto de Análise Multidimensional  
**Autor:** Manus AI (Facilitador)  
**Data:** 06/12/2025  
**Versão:** 1.0
