# Guia de Implementação do Ciclo de Aprendizagem no n8n Cloud

**Framework de Inteligência Territorial V6.0 - Sessão #10**

---

## 🎯 Objetivo

Integrar o ciclo de aprendizagem evolutiva ao workflow do Agente ECON no n8n Cloud, de forma simples e funcional.

---

## 📋 Estratégia Simplificada (MVP)

Em vez de tentar executar scripts Python externos (que não funcionam no n8n Cloud), vamos usar **nós nativos do n8n** para executar as queries SQL diretamente no banco PostgreSQL (Neon).

### Fluxo Proposto

```
Salvar Análise no PostgreSQL
    ↓
[NOVO] Registrar Aprendizado Automático (PostgreSQL)
    ↓
[NOVO] Atualizar Expertise (PostgreSQL)
    ↓
Respond to Webhook
```

---

## 🔧 Implementação Passo a Passo

### Passo 1: Remover o Nó Atual "Acionar Ciclo de Aprendizagem"

1. Abra o workflow V3 no n8n
2. Clique no nó "Acionar Ciclo de Aprendizagem"
3. Delete o nó (tecla Delete ou botão de lixeira)

### Passo 2: Adicionar Nó "Registrar Aprendizado Automático"

1. **Adicionar nó PostgreSQL** entre "Salvar Análise" e "Respond to Webhook"
2. **Nome do nó:** `Registrar Aprendizado Automático`
3. **Tipo:** PostgreSQL
4. **Operação:** Execute Query
5. **Query:**

```sql
-- Registrar aprendizado automático a cada análise
INSERT INTO agent_econ_learning_evolution (
  agent_id,
  learning_type,
  source_analysis_ids,
  learning_content,
  confidence_score,
  metadata,
  created_at
)
SELECT
  'econ' AS agent_id,
  'automatic' AS learning_type,
  '{{ $json.id }}' AS source_analysis_ids,
  'Aprendizado automático: O agente ECON continua evoluindo sua expertise através da análise contínua de indicadores econômicos. Análise ID: {{ $json.id }}' AS learning_content,
  0.75 AS confidence_score,
  jsonb_build_object(
    'type', 'automatic_learning',
    'trigger', 'post_analysis',
    'analysis_id', '{{ $json.id }}',
    'territory_id', '{{ $json.territory_id }}',
    'timestamp', NOW()
  ) AS metadata,
  NOW() AS created_at
WHERE (
  -- Só registrar aprendizado a cada 5 análises
  SELECT COUNT(*) FROM agent_econ_memory WHERE agent_id = 'econ'
) % 5 = 0
RETURNING id, agent_id, learning_type, confidence_score, created_at;
```

6. **Credenciais:** Selecione "Postgres Replit" (ou a credencial do Neon)
7. **Tratamento de erro:** Continue on Error Output

### Passo 3: Adicionar Nó "Atualizar Expertise"

1. **Adicionar nó PostgreSQL** após "Registrar Aprendizado Automático"
2. **Nome do nó:** `Atualizar Expertise`
3. **Tipo:** PostgreSQL
4. **Operação:** Execute Query
5. **Query:**

```sql
-- Atualizar e retornar expertise atual do agente
SELECT * FROM get_agent_expertise('econ');
```

6. **Credenciais:** Selecione "Postgres Replit" (ou a credencial do Neon)

### Passo 4: Adicionar Nó "Registrar Auditoria do Ciclo"

1. **Adicionar nó PostgreSQL** após "Atualizar Expertise"
2. **Nome do nó:** `Registrar Auditoria do Ciclo`
3. **Tipo:** PostgreSQL
4. **Operação:** Execute Query
5. **Query:**

```sql
-- Registrar evento de ciclo de aprendizagem na auditoria
INSERT INTO audit_trail (
  event_type,
  agent_id,
  user_id,
  action,
  resource_type,
  status,
  metadata,
  created_at
) VALUES (
  'learning_cycle_completed',
  'econ',
  'system',
  'automatic_learning',
  'learning_evolution',
  'success',
  jsonb_build_object(
    'analysis_id', '{{ $('Salvar Análise no PostgreSQL').item.json.id }}',
    'learning_id', '{{ $('Registrar Aprendizado Automático').item.json.id }}',
    'expertise_level', '{{ $('Atualizar Expertise').item.json.expertise_level }}',
    'type', 'automatic'
  ),
  NOW()
);
```

6. **Credenciais:** Selecione "Postgres Replit" (ou a credencial do Neon)

### Passo 5: Conectar os Nós

Conecte os nós na seguinte ordem:

```
Salvar Análise no PostgreSQL
    ↓ (success output)
Registrar Aprendizado Automático
    ↓ (main output)
Atualizar Expertise
    ↓ (main output)
Registrar Auditoria do Ciclo
    ↓ (main output)
Respond to Webhook
```

### Passo 6: Salvar e Ativar

1. Clique em **Save** no canto superior direito
2. Ative o workflow (botão **Active**)

---

## ✅ Vantagens Desta Abordagem

1. **100% Nativo do n8n** - Usa apenas nós PostgreSQL padrão
2. **Sem Dependências Externas** - Não precisa de scripts Python ou APIs externas
3. **Fácil de Debugar** - Cada nó pode ser testado individualmente
4. **Resiliente** - Se um nó falhar, o workflow continua
5. **Auditável** - Todos os passos são registrados no banco

---

## 🎚️ Configurações Opcionais

### Ajustar Frequência de Aprendizado

Para mudar a frequência de registro de aprendizado, modifique a condição no nó "Registrar Aprendizado Automático":

```sql
-- A cada 5 análises (padrão)
) % 5 = 0

-- A cada 3 análises
) % 3 = 0

-- A cada 10 análises
) % 10 = 0

-- Sempre (a cada análise)
) >= 0  -- Remove a condição
```

### Adicionar Notificações

Adicione um nó de notificação (Email, Slack, etc.) após "Atualizar Expertise" para ser notificado quando o agente evoluir de nível.

---

## 🧪 Testando o Workflow

### Teste 1: Enviar Requisição de Análise

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/agent-econ \
  -H "Content-Type: application/json" \
  -d '{
    "task_id": "test-001",
    "territory_id": "1721000",
    "territory_name": "Palmas",
    "agent_name": "ECON",
    "analysis_type": "economic",
    "parameters": {
      "focus_areas": ["PIB", "emprego"],
      "time_period": "2019-2023"
    }
  }'
```

### Teste 2: Verificar Aprendizado no Banco

```sql
-- Ver aprendizados registrados
SELECT * FROM agent_econ_learning_evolution
ORDER BY created_at DESC
LIMIT 5;

-- Ver expertise atual
SELECT * FROM get_agent_expertise('econ');

-- Ver eventos de auditoria
SELECT * FROM audit_trail
WHERE event_type = 'learning_cycle_completed'
ORDER BY created_at DESC
LIMIT 5;
```

---

## 🚀 Evolução Futura

Esta implementação é o **MVP funcional**. Futuras melhorias podem incluir:

1. **Síntese Inteligente com LLM**
   - Adicionar nó OpenAI para gerar sínteses comparando análises
   - Substituir aprendizado "automático" por aprendizado "sintético"

2. **Busca de Análises Similares**
   - Adicionar nó para buscar análises similares usando embeddings
   - Arquivar análises antigas após síntese

3. **Notificações de Evolução**
   - Enviar email/Slack quando o agente subir de nível
   - Dashboard de evolução da expertise

4. **Aprendizado Multi-Agente**
   - Replicar o fluxo para outros agentes (SOCIAL, TERRA, AMBIENT)
   - Criar template reutilizável

---

## 📊 Métricas de Sucesso

- ✅ Aprendizado registrado a cada 5 análises
- ✅ Expertise atualizada automaticamente
- ✅ Eventos de auditoria registrados
- ✅ Workflow não quebra se ciclo falhar
- ✅ Tempo de resposta < 3 segundos (incluindo ciclo)

---

## 🆘 Troubleshooting

### Erro: "Column 'id' not found"

**Causa:** O nó "Salvar Análise" não está retornando o ID da análise salva.

**Solução:** Adicione `RETURNING id, *` à query de inserção no nó "Salvar Análise".

### Erro: "Function get_agent_expertise does not exist"

**Causa:** A função não foi criada no banco de dados.

**Solução:** Execute o script de migração que cria a função:
```bash
psql -h <host> -U <user> -d <database> -f database/migrations/add_get_agent_expertise_function.sql
```

### Aprendizado Não Está Sendo Registrado

**Causa:** A condição `% 5 = 0` não está sendo satisfeita.

**Solução:** Temporariamente, remova a condição `WHERE` da query para registrar sempre, ou ajuste a frequência.

---

## 📚 Referências

- [Documentação do Modelo Conceitual RAG Evolutivo v4.0](../sessao7/modelo_conceitual_RAG_evolutivo_v4.md)
- [Arquitetura Atual do Banco de Dados](../07-database/ARQUITETURA_ATUAL.md)
- [Script Python learning_cycle.py](../../rag/learning_cycle.py) (referência de lógica)

---

**Última atualização:** 2025-11-30 | **Sessão #10** | **Autor:** Framework V6.0 Team
