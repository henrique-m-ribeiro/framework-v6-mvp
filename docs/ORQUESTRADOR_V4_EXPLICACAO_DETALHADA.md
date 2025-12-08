# Orquestrador V4.0 - Explicação Detalhada

**Data:** 08/12/2025  
**Sessão:** #13  
**Arquivo:** `WF-AGENT-ORCHESTRATOR-V4.0-Multidimensional.json`

---

## 🎯 Visão Geral

O **Orquestrador V4.0** representa a evolução completa do sistema de inteligência territorial. Ele não é mais apenas um roteador simples, mas um **maestro inteligente** capaz de:

1. ✅ Interpretar perguntas complexas do usuário
2. ✅ Identificar automaticamente se a análise deve ser unidimensional ou multidimensional
3. ✅ Identificar automaticamente se a análise envolve um ou múltiplos territórios
4. ✅ Chamar múltiplos agentes em paralelo (via loop)
5. ✅ Agregar e sintetizar as análises de diferentes dimensões
6. ✅ Gerar IDs semânticos para rastreabilidade completa
7. ✅ Salvar metadados estruturados para análises futuras

---

## 📊 Arquitetura do Workflow

### Fase 1: Recebimento e Validação (Nós 1-6)

**Nós envolvidos:**
1. `Webhook - Recebe Requisição`
2. `IF - Validar Payload`
3. `Responder Erro 400`
4. `PostgreSQL - Buscar Território`
5. `IF - Território Encontrado?`
6. `Responder Erro 404`

**O que acontece:**
- Recebe a requisição do usuário (territory_id + question)
- Valida se os campos obrigatórios estão presentes
- Busca o território no banco de dados para validar sua existência
- Retorna erros 400 ou 404 se houver problemas

**Preservado da V3.2:** ✅ Toda a lógica de validação foi mantida intacta.

---

### Fase 2: Interpretação Inteligente (Nó 7)

**Nó:** `OpenAI - Interpretar Requisição`

**O que acontece:**
- Usa GPT-4.1-mini para analisar a pergunta do usuário
- Extrai metadados estruturados em formato JSON:
  - `analysis_scope`: unidimensional ou multidimensional
  - `territory_scope`: uniterritorial ou multiterritorial
  - `dimensions`: array de dimensões (economic, social, terra, ambient)
  - `territories`: array de objetos com id e nome dos territórios

**Exemplo de entrada:**
```
"Compare a economia e a educação de Palmas e Araguaína."
```

**Exemplo de saída:**
```json
{
  "analysis_scope": "multidimensional",
  "territory_scope": "multiterritorial",
  "dimensions": ["economic", "social"],
  "territories": [
    {"id": "1721000", "name": "Palmas"},
    {"id": "1702109", "name": "Araguaína"}
  ]
}
```

**Novo em V4.0:** ✨ Este nó é completamente novo e é o cérebro da interpretação.

---

### Fase 3: Criação do Payload V4 (Nós 8-9)

**Nós:**
1. `Set - Criar Payload V4`
2. `Set - Definir Agentes a Chamar`

**O que acontece:**
- Gera o `request_id` único (formato: `YYYYMMDDHHmmss-req-{territory_id}`)
- Combina a pergunta original com os metadados interpretados
- Cria um **Payload V4 completo** que será enviado para todos os agentes
- Define a lista de agentes que devem ser chamados (baseado nas dimensões)

**Payload V4 gerado:**
```json
{
  "request_id": "20251208153000-req-1721000",
  "question": "Compare a economia e a educação de Palmas e Araguaína.",
  "analysis_scope": "multidimensional",
  "territory_scope": "multiterritorial",
  "dimensions": ["economic", "social"],
  "territories": [
    {"id": "1721000", "name": "Palmas"},
    {"id": "1702109", "name": "Araguaína"}
  ]
}
```

**Novo em V4.0:** ✨ Toda a lógica de criação de IDs semânticos e metadados.

---

### Fase 4: Loop sobre Agentes (Nós 10-18)

**Nós:**
1. `Loop - Iterar sobre Agentes`
2. `Switch - Rotear para Agente`
3. `HTTP Request - Chamar Agente ECON`
4. `HTTP Request - Chamar Agente SOCIAL`
5. `HTTP Request - Chamar Agente TERRA`
6. `HTTP Request - Chamar Agente AMBIENT`
7. `PostgreSQL - Salvar na Knowledge Base`
8. `Loop - Voltar para Próximo Agente`
9. `Responder Erro 500`

**O que acontece:**
- O nó `Loop` itera sobre a lista de dimensões (ex: ["economic", "social"])
- Para cada dimensão, o `Switch` roteia para o agente correto
- O agente é chamado via HTTP Request, recebendo o Payload V4 completo
- O agente retorna a análise com o `analysis_id` gerado
- A análise é salva na `knowledge_base` com todos os metadados
- O loop volta para chamar o próximo agente (se houver)

**Exemplo de fluxo para análise multidimensional:**
```
Iteração 1:
  - dimension = "economic"
  - Chama Agente ECON
  - Agente retorna análise econômica
  - Salva na knowledge_base (id = "20251208153000-req-1721000-economic")
  - Volta para o loop

Iteração 2:
  - dimension = "social"
  - Chama Agente SOCIAL
  - Agente retorna análise social
  - Salva na knowledge_base (id = "20251208153000-req-1721000-social")
  - Fim do loop (não há mais dimensões)
```

**Adaptado da V3.2:** 🔄 O Switch foi adaptado para funcionar dentro do loop.

**Novo em V4.0:** ✨ O loop permite chamar múltiplos agentes sequencialmente.

---

### Fase 5: Síntese Multidimensional (Nó 19)

**Nó:** `OpenAI - Sintetizar Análises Multidimensionais`

**O que acontece:**
- Recebe TODAS as análises geradas pelos agentes
- Usa GPT-4.1-mini para criar uma síntese integrada
- Identifica conexões e interdependências entre dimensões
- Gera insights que emergem da visão holística
- Fornece recomendações práticas

**Entrada:**
```
Pergunta original: "Compare a economia e a educação de Palmas e Araguaína."

Análises recebidas:
- Análise econômica de Palmas e Araguaína (5.000 caracteres)
- Análise social (educação) de Palmas e Araguaína (5.000 caracteres)
```

**Saída:**
```
Uma síntese integrada de 3.000-4.000 caracteres que:
- Resume os principais achados de cada dimensão
- Mostra como a economia afeta a educação em cada município
- Compara Palmas e Araguaína de forma holística
- Fornece recomendações integradas
```

**Novo em V4.0:** ✨ Este é o **GRAN FINALE** do Orquestrador V4.0!

---

### Fase 6: Resposta ao Usuário (Nó 20)

**Nó:** `Respond to Webhook - Sucesso`

**O que acontece:**
- Retorna a síntese final para o usuário

**Para análises unidimensionais:**
- Retorna a análise do único agente chamado

**Para análises multidimensionais:**
- Retorna a síntese integrada gerada pelo nó anterior

**Preservado da V3.2:** ✅ O nó de resposta foi mantido.

---

## 🆕 Principais Inovações da V4.0

| Recurso | V3.2 | V4.0 |
| :--- | :--- | :--- |
| **Interpretação da pergunta** | Manual (roteador simples) | Automática (IA identifica dimensões e territórios) |
| **Análises multidimensionais** | ❌ Não suportado | ✅ Suportado nativamente |
| **Análises multiterritoriais** | ❌ Não suportado | ✅ Suportado nativamente |
| **IDs semânticos** | ❌ Não havia | ✅ request_id e analysis_id |
| **Metadados estruturados** | ❌ Não havia | ✅ 5 novos campos (analysis_scope, territory_scope, dimensions, territories, request_id) |
| **Síntese de análises** | ❌ Não havia | ✅ IA sintetiza análises multidimensionais |
| **Rastreabilidade** | ⚠️ Limitada | ✅ Completa (request_id conecta tudo) |

---

## 📝 Notas de Implementação

### Credenciais Necessárias

O workflow requer duas credenciais do n8n:

1. **PostgreSQL (Neon):**
   - ID: `SVnYhSNx3vXIzoYk`
   - Nome: `Postgres Replit`
   - Já configurado na V3.2 ✅

2. **OpenAI API:**
   - ID: `YOUR_OPENAI_CREDENTIALS_ID` (substituir)
   - Nome: `OpenAI API`
   - Necessário para os 2 novos nós de IA

### Ajustes Necessários Antes de Importar

1. **Substituir o ID das credenciais OpenAI** nos nós:
   - `OpenAI - Interpretar Requisição`
   - `OpenAI - Sintetizar Análises Multidimensionais`

2. **Verificar as URLs dos agentes** nos nós HTTP Request (se mudaram):
   - `https://galactic-ai.app.n8n.cloud/webhook/agent-econ`
   - `https://galactic-ai.app.n8n.cloud/webhook/agent-social`
   - `https://galactic-ai.app.n8n.cloud/webhook/agent-terra`
   - `https://galactic-ai.app.n8n.cloud/webhook/agent-ambient`

### Compatibilidade com Agentes

**IMPORTANTE:** Este Orquestrador V4.0 requer que os agentes também sejam atualizados para a Arquitetura V4.

Os agentes devem:
1. Receber o Payload V4 completo
2. Gerar o `analysis_id` (formato: `{request_id}-{dimension}`)
3. Salvar na memória com os metadados V4
4. Retornar o `analysis_id` e todos os metadados para o Orquestrador

Consulte o `GUIA_ATUALIZACAO_AGENTES_V4.md` para atualizar os agentes.

---

## 🧪 Como Testar

### Teste 1: Análise Unidimensional Uniterritorial (Cenário Simples)

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/orchestrator \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "question": "Qual o PIB de Palmas?"
  }'
```

**Comportamento esperado:**
- Interpreta como `unidimensional` + `uniterritorial`
- Chama apenas o Agente ECON
- Retorna a análise econômica diretamente (sem síntese)

---

### Teste 2: Análise Multidimensional Uniterritorial (Cenário Médio)

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/orchestrator \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "question": "Como estão a economia e a educação de Palmas?"
  }'
```

**Comportamento esperado:**
- Interpreta como `multidimensional` + `uniterritorial`
- Chama Agente ECON e Agente SOCIAL
- Sintetiza as duas análises em uma resposta integrada

---

### Teste 3: Análise Multidimensional Multiterritorial (Cenário Complexo - GRAN FINALE!)

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/orchestrator \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "question": "Compare a economia e a educação de Palmas e Araguaína."
  }'
```

**Comportamento esperado:**
- Interpreta como `multidimensional` + `multiterritorial`
- Identifica 2 dimensões: economic, social
- Identifica 2 territórios: Palmas (1721000), Araguaína (1702109)
- Chama Agente ECON (que analisa ambos os territórios)
- Chama Agente SOCIAL (que analisa ambos os territórios)
- Sintetiza as análises mostrando:
  - Comparação econômica entre Palmas e Araguaína
  - Comparação educacional entre Palmas e Araguaína
  - Conexões entre economia e educação em cada município
  - Insights emergentes da visão holística

---

## 🎉 Conclusão

O **Orquestrador V4.0** é o resultado de uma jornada de evolução arquitetural que começou na Sessão #12 e culminou na Sessão #13. Ele incorpora:

1. ✅ Todas as correções e depurações das sessões anteriores
2. ✅ A nova Arquitetura V4 (IDs Semânticos + Metadados)
3. ✅ Suporte nativo para análises multidimensionais e multiterritoriais
4. ✅ Síntese inteligente de análises usando IA
5. ✅ Rastreabilidade completa de ponta a ponta

Este é um sistema pronto para escalar e evoluir, com uma base sólida para futuras inovações.

**Parabéns pela jornada!** 🚀
