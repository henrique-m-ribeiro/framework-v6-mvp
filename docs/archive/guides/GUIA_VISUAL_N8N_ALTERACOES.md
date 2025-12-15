# 🎯 Guia Visual: Alterações nos Workflows n8n - Arquitetura V2.0

**Data:** 02/12/2025  
**Autor:** Manus AI

---

## 📌 PARTE 1: Agente ECON - Alterações Identificadas

### Status Atual do Workflow

O workflow **WF-AGENT-ECON V6.1** possui **14 nós** e **6 nós PostgreSQL**:

| # | Nome do Nó | Tipo | Função | Ação |
| :--- | :--- | :--- | :--- | :--- |
| 1 | Webhook - Recebe Tarefa | Webhook | Recebe requisição do orquestrador | ✅ Manter |
| 2 | Normalizar Entrada | Code | Valida e normaliza payload | ✅ Manter |
| 3 | Consultar Memória e Aprendizados | PostgreSQL | Busca análises anteriores | ✅ Manter |
| 4 | Consultar Dados PostgreSQL | PostgreSQL | Busca indicadores econômicos | ✅ Manter |
| 5 | Preparar Contexto para LLM | Code | Prepara contexto para IA | ✅ Manter |
| 6 | Gerar Análise com OpenAI | OpenAI | Gera análise dimensional | ✅ Manter |
| 7 | Estruturar Resposta | Code | Estrutura resposta | ✅ Manter |
| 8 | Preparar Dados para Salvar | Code | Prepara dados para salvamento | ✅ Manter |
| 9 | **Salvar Análise no PostgreSQL** | **PostgreSQL** | **Salva em `knowledge_base`** | **❌ REMOVER** |
| 10 | Respond to Webhook | Webhook Response | Retorna resposta ao orquestrador | ✏️ Modificar |
| 11 | Responder Erro | Webhook Response | Retorna erro | ✅ Manter |
| 12 | Registrar Aprendizado Automático | PostgreSQL | Salva aprendizado | ✅ Manter |
| 13 | Atualizar Expertise | PostgreSQL | Atualiza nível de expertise | ✅ Manter |
| 14 | Registrar Auditoria do Ciclo | PostgreSQL | Registra auditoria | ✅ Manter |

---

## 🔧 ALTERAÇÃO 1: Remover Nó "Salvar Análise no PostgreSQL"

### Passo a Passo

#### 1. Localizar o Nó

No canvas do n8n, localize o nó chamado **"Salvar Análise no PostgreSQL"**. Ele está posicionado entre:
- **Entrada**: Nó "Preparar Dados para Salvar"
- **Saída**: Nó "Respond to Webhook"

#### 2. Verificar se é o Nó Correto

**⚠️ IMPORTANTE**: Há outros nós PostgreSQL no workflow. Certifique-se de que está removendo o correto.

**Como verificar:**
1. Clique no nó "Salvar Análise no PostgreSQL"
2. Verifique se a query SQL contém: `INSERT INTO knowledge_base`
3. Se sim, este é o nó correto para remover

**Query atual do nó (primeiras linhas):**
```sql
INSERT INTO knowledge_base (
  territory_id,
  dimension,
  content,
  summary,
  confidence_score,
  ...
)
```

#### 3. Remover o Nó

1. Clique no nó "Salvar Análise no PostgreSQL" para selecioná-lo
2. Pressione a tecla **Delete** ou **Backspace**
3. Ou clique com botão direito → **Delete**

#### 4. Reconectar os Nós

Após remover o nó, você precisa reconectar o fluxo:

**Conexão antiga:**
```
Preparar Dados para Salvar → Salvar Análise no PostgreSQL → Respond to Webhook
```

**Nova conexão:**
```
Preparar Dados para Salvar → Respond to Webhook
```

**Como fazer:**
1. Clique e arraste a **saída** do nó "Preparar Dados para Salvar"
2. Conecte diretamente à **entrada** do nó "Respond to Webhook"

---

## ✏️ ALTERAÇÃO 2: Modificar Nó "Respond to Webhook"

### Objetivo

Modificar o nó para retornar a análise completa ao orquestrador em formato JSON estruturado.

### Passo a Passo

#### 1. Abrir Configurações do Nó

1. Dê **duplo clique** no nó "Respond to Webhook"
2. O painel de configuração abrirá à direita

#### 2. Configurar Modo de Resposta

No painel de configuração:

| Campo | Valor Atual | Novo Valor |
| :--- | :--- | :--- |
| **Respond With** | (verificar) | "Using 'Respond to Webhook' Node" |
| **Response Mode** | (verificar) | **Text** |

#### 3. Adicionar Código de Resposta

No campo **"Response Body"** ou **"Response Data"**, substitua o conteúdo atual por:

```javascript
{
  "status": "success",
  "dimension": "economic",
  "territory_id": "{{ $('Normalizar Entrada').first().json.territory_id }}",
  "analysis_id": "{{ $('Preparar Dados para Salvar').first().json.id }}",
  "analysis_content": "{{ $('Preparar Dados para Salvar').first().json.analysis_content }}",
  "summary": "{{ $('Preparar Dados para Salvar').first().json.analysis_summary }}",
  "confidence_score": {{ $('Preparar Dados para Salvar').first().json.confidence_score }},
  "indicators_used": {{ JSON.stringify($('Preparar Dados para Salvar').first().json.indicators_used) }},
  "created_at": "{{ new Date().toISOString() }}",
  "generated_by": "WF-AGENT-ECON"
}
```

**⚠️ NOTA**: Se o n8n não aceitar JSON diretamente, você precisará usar um nó **Code** antes do "Respond to Webhook" para preparar este JSON.

#### 4. Alternativa: Usar Nó Code

Se a abordagem acima não funcionar, siga este método alternativo:

**4.1. Adicionar Nó Code**

1. Clique no **+** entre "Preparar Dados para Salvar" e "Respond to Webhook"
2. Selecione **Code** → **Run JavaScript Code**
3. Renomeie para: **"Preparar Resposta para Orquestrador"**

**4.2. Adicionar Código JavaScript**

```javascript
// ============================================================================
// PREPARAR RESPOSTA PARA ORQUESTRADOR
// Arquitetura V2.0 - Agente ECON
// ============================================================================

// Obter dados preparados para salvamento
const savedData = $('Preparar Dados para Salvar').first().json;

// Preparar resposta estruturada
const response = {
  status: "success",
  
  // Identificação
  dimension: "economic",
  territory_id: savedData.territory_id,
  
  // ID da análise salva em agent_econ_memory
  analysis_id: savedData.id,
  
  // Conteúdo da análise
  analysis_content: savedData.analysis_content,
  summary: savedData.analysis_summary,
  
  // Métricas
  confidence_score: savedData.confidence_score || 0.85,
  
  // Indicadores utilizados
  indicators_used: savedData.indicators_used || [],
  
  // Metadados
  created_at: new Date().toISOString(),
  generated_by: "WF-AGENT-ECON"
};

return {
  json: response
};
```

**4.3. Configurar "Respond to Webhook"**

1. Abra o nó "Respond to Webhook"
2. Configure:
   - **Respond With**: "Using 'Respond to Webhook' Node"
   - **Response Mode**: **JSON**
   - **Response Data**: Deixe vazio (usará o JSON do nó anterior)

#### 5. Salvar Alterações

1. Clique em **"Save"** no nó
2. Clique em **"Save"** no workflow (canto superior direito)

---

## ✅ CHECKLIST DE VALIDAÇÃO - Agente ECON

Após fazer as alterações, verifique:

- [ ] Nó "Salvar Análise no PostgreSQL" (que salvava em `knowledge_base`) foi removido
- [ ] Conexão entre "Preparar Dados para Salvar" e "Respond to Webhook" está correta
- [ ] Nó "Respond to Webhook" foi modificado para retornar JSON estruturado
- [ ] Workflow foi salvo (indicador "Saved" no topo)
- [ ] Não há nós desconectados (linhas vermelhas)

---

## 🧪 TESTE RÁPIDO

### Payload de Teste

Use este payload para testar o workflow modificado:

```json
{
  "agent_id": "economic",
  "territory_id": "1721000",
  "analysis_type": "diagnostic",
  "territory_name": "Palmas",
  "parameters": {
    "time_period": "2019-2023",
    "focus_areas": ["PIB", "emprego", "renda"],
    "detail_level": "comprehensive"
  }
}
```

### Como Testar

1. No n8n, clique em **"Execute workflow"** (canto superior direito)
2. O webhook será ativado
3. Use uma ferramenta como **Postman** ou **curl** para enviar o payload
4. Verifique se a resposta contém:
   - `status: "success"`
   - `analysis_id` (UUID)
   - `analysis_content` (texto da análise)
   - `confidence_score` (número entre 0 e 1)

### Resultado Esperado

```json
{
  "status": "success",
  "dimension": "economic",
  "territory_id": "1721000",
  "analysis_id": "uuid-123-456",
  "analysis_content": "# ANÁLISE ECONÔMICA...",
  "summary": "Resumo da análise...",
  "confidence_score": 0.92,
  "indicators_used": ["PIB_PC_2021", "PIB_TOTAL_2021"],
  "created_at": "2025-12-02T10:00:00Z",
  "generated_by": "WF-AGENT-ECON"
}
```

---

## 🔄 REPLICAR PARA OUTROS AGENTES

Após validar as alterações no Agente ECON, replique para:

- **WF-AGENT-SOCIAL V6.1**
- **WF-AGENT-TERRA V6.1**
- **WF-AGENT-AMBIENT V6.1**

**Alterações são idênticas**, apenas ajuste:
- Nome da dimensão: `"economic"` → `"social"`, `"territorial"`, `"environmental"`
- Nome do workflow: `"WF-AGENT-ECON"` → `"WF-AGENT-SOCIAL"`, etc.

---

## 📞 Próximos Passos

Após concluir as alterações nos 4 agentes dimensionais:

1. ✅ Validar que todos os agentes retornam JSON estruturado
2. ✅ Prosseguir para as alterações no **Orquestrador**
3. ✅ Testar fluxo end-to-end completo

---

**Boa implementação! 🚀**
