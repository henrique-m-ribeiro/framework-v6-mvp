# Guia Preciso: Configuração dos Nós OpenAI no Orquestrador V5.0

**Framework de Inteligência Territorial V6.0**  
**Data:** 08 de dezembro de 2025  
**Sessão:** #14  
**Versão do n8n:** 1.117.0+ (OpenAI Node V2)

---

## 🎯 IMPORTANTE: Análise Corrigida

Após análise meticulosa do JSON e das imagens fornecidas, confirmo que:

✅ **O nó "OpenAI - Interpretar Requisição" ESTÁ CONFIGURADO**
- Resource: `Text` ✅
- Operation: `Message a Model` ✅  
- Model: `GPT-4O-MINI` ✅
- Messages: **2 mensagens configuradas** ✅
  - Message 1: Role `System` com prompt completo ✅
  - Message 2: Role `User` com `{{ $json.question }}` ✅
- Simplify Output: `ON` ✅

**Status:** ✅ **NÓ ESTÁ CORRETO E FUNCIONAL**

---

## 📊 OPÇÕES DISPONÍVEIS NO N8N 1.117.0+

Baseado na documentação oficial e nas imagens fornecidas, as opções disponíveis são:

### Opções Principais (Add Option)

1. **Conversation ID** - Para manter contexto entre chamadas
2. **Include Additional Data** - Incluir dados adicionais na resposta
3. **Instructions** - Instruções adicionais para o modelo
4. **Maximum Number of Tokens** - Limite de tokens na resposta
5. **Max Tool Calls Iterations** - Máximo de iterações de chamadas de ferramentas
6. **Max Built-in Tool Calls** - Máximo de chamadas de ferramentas integradas
7. **Metadata** - Metadados personalizados
8. **Parallel Tool Calls** - Permitir chamadas paralelas de ferramentas
9. **Previous Response ID** - ID de resposta anterior para contexto
10. **Prompt** - Prompt adicional
11. **Prompt Cache Key** - Chave para cache de prompts
12. **Reasoning** - Habilitar raciocínio do modelo
13. **Safety Identifier** - Identificador de segurança
14. **Service Tier** - Nível de serviço
15. **Store** - Armazenar conversa
16. **Output Format** - Formato de saída
17. **Top Logprobs** - Número de log probabilities a retornar
18. **Output Randomness (Temperature)** - Controle de aleatoriedade (0.0-2.0)
19. **Output Randomness (Top P)** - Controle de diversidade (0.0-1.0)
20. **Truncation** - Truncamento de mensagens
21. **Background Mode** - Modo de execução em background

---

## ⚠️ OPÇÕES QUE NÃO EXISTEM MAIS

Estas opções mencionadas em guias antigos **NÃO EXISTEM** no n8n 1.117.0+:

- ❌ `Simplify Output` (agora é um toggle principal, não uma opção)
- ❌ `Output Content as JSON` (agora é um toggle principal, não uma opção)
- ❌ `Frequency Penalty` (removida ou renomeada)
- ❌ `Presence Penalty` (removida ou renomeada)
- ❌ `Number of Completions` (removida)

---

## ✅ CONFIGURAÇÃO CORRETA PARA ORQUESTRADOR V5.0

### Nó 1: "OpenAI - Interpretar Requisição"

**Status Atual:** ✅ **JÁ ESTÁ CONFIGURADO CORRETAMENTE**

**Configuração Existente:**
```
Resource: Text
Operation: Message a Model
Model: GPT-4O-MINI

Messages:
  1. Type: Text
     Role: System
     Prompt: [Prompt completo sobre análise territorial]
  
  2. Type: Text
     Role: User
     Prompt: {{ $json.question }}

Simplify Output: ON
```

**Opções Recomendadas para Adicionar:**

1. **Output Randomness (Temperature)**
   - Valor: `0.3`
   - Justificativa: Interpretação mais determinística e consistente

2. **Maximum Number of Tokens**
   - Valor: `500`
   - Justificativa: Resposta JSON compacta (agent_ids, territories, etc.)

3. **Output Format** (se disponível)
   - Valor: `JSON`
   - Justificativa: Garantir saída estruturada

**Como Adicionar Opções:**
1. Abra o nó no n8n Cloud
2. Role até "Options"
3. Clique em "Add Option"
4. Selecione a opção desejada
5. Configure o valor
6. Salve o nó

---

### Nó 2: "OpenAI - Sintetizar Análises Multidimensionais"

**Status Atual:** ⚠️ **PRECISA SER CONFIGURADO**

**Configuração Necessária:**

```
Resource: Text
Operation: Message a Model
Model: GPT-4O-MINI

Messages:
  1. Type: Text
     Role: System
     Prompt: [Ver prompt completo abaixo]
  
  2. Type: Text
     Role: User
     Prompt: [Ver expressão n8n abaixo]
  
  3. Type: Text (OPCIONAL)
     Role: Assistant
     Prompt: [Ver exemplo de resposta abaixo]

Simplify Output: ON
```

**Opções Recomendadas:**

1. **Output Randomness (Temperature)**
   - Valor: `0.7`
   - Justificativa: Síntese criativa mas fundamentada

2. **Maximum Number of Tokens**
   - Valor: `2500`
   - Justificativa: Síntese completa (600-1000 palavras)

3. **Output Randomness (Top P)** (ALTERNATIVA ao Temperature)
   - Valor: `0.9`
   - Justificativa: Diversidade controlada
   - **NOTA:** Use OU Temperature OU Top P, não ambos

---

## 📝 PROMPTS COMPLETOS

### Message 1 (System) - Nó de Síntese

```
Você é um especialista em síntese de análises territoriais multidimensionais do estado do Tocantins.

Sua missão é integrar análises de diferentes dimensões (econômica, social, territorial, ambiental) em uma síntese coerente, holística e acionável.

PRINCÍPIOS DA SÍNTESE:

1. INTEGRAÇÃO SISTÊMICA
   - Identifique conexões causais entre as dimensões
   - Mostre como uma dimensão afeta as outras
   - Revele padrões emergentes da visão integrada

2. INSIGHTS TRANSVERSAIS
   - Destaque tendências que atravessam múltiplas dimensões
   - Identifique sinergias (quando dimensões se reforçam)
   - Aponte trade-offs (quando há tensões entre dimensões)

3. CONTEXTUALIZAÇÃO TERRITORIAL
   - Considere as especificidades de cada território analisado
   - Compare territórios quando aplicável
   - Relacione com o contexto regional/estadual

4. RECOMENDAÇÕES INTEGRADAS
   - Sugira ações que considerem múltiplas dimensões
   - Priorize intervenções com efeitos multiplicadores
   - Indique possíveis riscos e oportunidades

ESTRUTURA DA SÍNTESE:

1. Visão Geral Integrada (2-3 parágrafos)
   - Quadro geral que emerge das análises
   - Principais padrões identificados

2. Conexões Entre Dimensões (3-4 parágrafos)
   - Como as dimensões se relacionam
   - Sinergias e trade-offs identificados

3. Insights Territoriais (2-3 parágrafos)
   - Especificidades de cada território
   - Comparações quando aplicável

4. Recomendações Integradas (3-5 itens)
   - Ações prioritárias
   - Justificativa multidimensional

TOM E ESTILO:
- Objetivo e baseado em evidências
- Claro e acessível (evite jargão excessivo)
- Propositivo (foco em ações)
- Contextualizado (considere realidade local)

IMPORTANTE:
- Use APENAS informações presentes nas análises fornecidas
- Não invente dados ou estatísticas
- Se houver lacunas, indique-as explicitamente
- Mantenha a síntese entre 600-1000 palavras
```

---

### Message 2 (User) - Nó de Síntese

```
Sintetize as seguintes análises:

PERGUNTA ORIGINAL:
{{ $json.question }}

TERRITÓRIO(S) ANALISADO(S):
{{ $json.territories.map(t => t.name).join(', ') }}

DIMENSÕES ANALISADAS:
{{ $json.agent_responses.map(r => r.agent_name).join(', ') }}

ESCOPO DA ANÁLISE:
- Análise: {{ $json.analysis_scope }}
- Território: {{ $json.territory_scope }}
- Total de análises: {{ $json.response_count }}

───────────────────────────────────────────────────────────────

ANÁLISES DETALHADAS:

{{ $json.agent_responses.map(r => `**DIMENSÃO: ${r.agent_name.toUpperCase()}**\n\n${r.analysis}\n`).join('\n───────────────────────────────────────────────────────────────\n\n') }}

───────────────────────────────────────────────────────────────

Com base nestas análises, crie uma síntese integrada que:
1. Identifique conexões entre as dimensões
2. Destaque insights transversais
3. Forneça recomendações integradas
4. Considere as especificidades territoriais
```

---

### Message 3 (Assistant) - Nó de Síntese (OPCIONAL)

```
# SÍNTESE INTEGRADA: ANÁLISE MULTIDIMENSIONAL

## 1. Visão Geral Integrada

[Análise integrada dos dados apresentados, identificando padrões gerais e tendências principais que emergem da combinação das diferentes dimensões analisadas.]

## 2. Conexões Entre Dimensões

### [Dimensão A] ↔ [Dimensão B]
[Descrição detalhada de como estas dimensões se relacionam, incluindo efeitos causais, sinergias ou trade-offs identificados.]

### [Outras Conexões]
[Análise de outras relações relevantes entre dimensões.]

## 3. Insights Territoriais

[Análise das especificidades de cada território, comparações quando aplicável, e contextualização regional.]

## 4. Recomendações Integradas

1. **[Recomendação 1]**: [Descrição e justificativa multidimensional]
2. **[Recomendação 2]**: [Descrição e justificativa multidimensional]
3. **[Recomendação 3]**: [Descrição e justificativa multidimensional]

## Considerações Finais

[Síntese final, próximos passos sugeridos, e indicação de lacunas ou limitações identificadas.]
```

---

## 🔧 PASSO A PASSO: CONFIGURAR NÓ DE SÍNTESE

### Passo 1: Abrir o Nó

1. No n8n Cloud, localize o nó **"OpenAI - Sintetizar Análises Multidimensionais"**
2. Clique no nó para abrir o painel de configuração

---

### Passo 2: Configurar Parâmetros Principais

1. **Credential to connect with**
   - Selecione: `OpenAI account 2` (ou sua credencial)

2. **Resource**
   - Selecione: `Text`

3. **Operation**
   - Selecione: `Message a Model`

4. **Model**
   - Selecione: `GPT-4O-MINI` (ou `GPT-4O` se precisar de mais capacidade)

---

### Passo 3: Adicionar Message 1 (System)

1. Em **Messages**, clique em **"Add Message"** (se não houver mensagens)
2. Configure:
   - **Type**: `Text`
   - **Role**: `System`
   - **Prompt**: Cole o **prompt completo do Message 1** (ver seção acima)

---

### Passo 4: Adicionar Message 2 (User)

1. Clique em **"Add Message"** novamente
2. Configure:
   - **Type**: `Text`
   - **Role**: `User`
   - **Prompt**: Cole a **expressão n8n do Message 2** (ver seção acima)

---

### Passo 5: Adicionar Message 3 (Assistant) - OPCIONAL

1. Clique em **"Add Message"** mais uma vez
2. Configure:
   - **Type**: `Text`
   - **Role**: `Assistant`
   - **Prompt**: Cole o **exemplo do Message 3** (ver seção acima)

**NOTA:** Esta mensagem é opcional. Ela serve como exemplo para o modelo, mas pode ser omitida.

---

### Passo 6: Ativar Simplify Output

1. Localize o toggle **"Simplify Output"**
2. **Ative** (toggle para ON)
3. Isso retornará uma resposta simplificada em vez do JSON bruto

---

### Passo 7: Adicionar Opções

1. Role até a seção **"Options"**
2. Clique em **"Add Option"**
3. Selecione **"Output Randomness (Temperature)"**
4. Configure o valor: `0.7`

5. Clique em **"Add Option"** novamente
6. Selecione **"Maximum Number of Tokens"**
7. Configure o valor: `2500`

---

### Passo 8: Salvar

1. Clique no botão **"Save"** no canto superior direito do workflow
2. O nó está configurado!

---

## ✅ VALIDAÇÃO DA CONFIGURAÇÃO

### Checklist - Nó "OpenAI - Interpretar Requisição"

- [x] Resource: Text
- [x] Operation: Message a Model
- [x] Model: GPT-4O-MINI
- [x] Message 1 (System): Configurada
- [x] Message 2 (User): Configurada
- [x] Simplify Output: ON
- [ ] Option: Temperature (0.3) - **ADICIONAR**
- [ ] Option: Maximum Tokens (500) - **ADICIONAR**

---

### Checklist - Nó "OpenAI - Sintetizar Análises"

- [ ] Resource: Text
- [ ] Operation: Message a Model
- [ ] Model: GPT-4O-MINI
- [ ] Message 1 (System): Prompt completo
- [ ] Message 2 (User): Expressão n8n
- [ ] Message 3 (Assistant): Exemplo (opcional)
- [ ] Simplify Output: ON
- [ ] Option: Temperature (0.7)
- [ ] Option: Maximum Tokens (2500)

---

## 🧪 TESTE DO WORKFLOW

Após configurar ambos os nós, teste com:

```json
{
  "territory_id": "1721000",
  "question": "Como estão a economia e a educação de Palmas?"
}
```

**Resultado Esperado:**
1. ✅ Nó "Interpretar Requisição" identifica 2 agentes (economic, social)
2. ✅ Loop chama ambos os agentes
3. ✅ Nó "Agregar Respostas" coleta as 2 análises
4. ✅ Nó "Sintetizar Análises" gera síntese integrada
5. ✅ Dados salvos na knowledge_base

---

## 📊 COMPARAÇÃO: OPÇÕES ANTIGAS vs NOVAS

| Opção Antiga (Guias Anteriores) | Opção Nova (n8n 1.117.0+) | Status |
|----------------------------------|---------------------------|--------|
| Simplify Output (option) | Simplify Output (toggle) | ✅ Existe (mudou de lugar) |
| Output Content as JSON (option) | Output Format (option) | ⚠️ Renomeada |
| Temperature | Output Randomness (Temperature) | ✅ Renomeada |
| Max Tokens | Maximum Number of Tokens | ✅ Renomeada |
| Frequency Penalty | ❌ | ❌ Removida |
| Presence Penalty | ❌ | ❌ Removida |
| Top P | Output Randomness (Top P) | ✅ Renomeada |

---

## 🎯 CONCLUSÃO

**Nó "OpenAI - Interpretar Requisição":**
- ✅ **JÁ ESTÁ CONFIGURADO CORRETAMENTE**
- Apenas adicione opções de Temperature e Max Tokens para otimizar

**Nó "OpenAI - Sintetizar Análises Multidimensionais":**
- ⚠️ **PRECISA SER CONFIGURADO**
- Siga o passo a passo acima
- Tempo estimado: 15-20 minutos

**Após Configuração:**
- Workflow estará 100% funcional
- Pronto para testes end-to-end
- Pronto para validação no banco de dados

---

**Tempo Total Estimado:** 20-30 minutos  
**Complexidade:** Média (requer atenção aos prompts)

---

**Fim do Guia Preciso**
