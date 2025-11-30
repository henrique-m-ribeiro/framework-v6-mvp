# Contrato de API: Webhook do Agente ECON (V1)

**Framework de Inteligência Territorial V6.0 - Sessão #10**  
**Data:** 30 de novembro de 2025

---

## 🎯 Objetivo

Este documento define o contrato de API para o webhook do **Agente ECON**, garantindo que todas as requisições sejam padronizadas e que o workflow do n8n seja resiliente a diferentes payloads de entrada.

---

## 📍 Endpoint

- **URL:** `https://galactic-ai.app.n8n.cloud/webhook/agent-econ`
- **Método:** `POST`
- **Content-Type:** `application/json`

---

## 📦 Estrutura do Payload (Corpo da Requisição)

### Campos Obrigatórios

| Campo | Tipo | Descrição | Exemplo |
|---|---|---|---|
| `agent_id` | `string` | ID do agente a ser acionado. | `"econ"` |
| `territory_id` | `string` | ID do território a ser analisado. | `"1721000"` |
| `analysis_type` | `string` | Tipo de análise a ser realizada. | `"economic_overview"` |

### Campos Opcionais

| Campo | Tipo | Descrição | Exemplo |
|---|---|---|---|
| `territory_name` | `string` | Nome do território (para logging). | `"Palmas"` |
| `user_id` | `string` | ID do usuário que solicitou a análise. | `"user-123"` |
| `parameters` | `object` | Parâmetros adicionais para a análise. | `{"time_period": "2019-2023"}` |

#### Objeto `parameters` (Opcional)

| Campo | Tipo | Descrição | Padrão |
|---|---|---|---|
| `time_period` | `string` | Período da análise (formato `YYYY-YYYY`). | `"2019-2023"` |
| `focus_areas` | `array` | Áreas de foco da análise. | `["PIB", "emprego", "renda"]` |
| `detail_level` | `string` | Nível de detalhe da análise. | `"comprehensive"` |

---

## ✅ Exemplo de Payload Completo

```json
{
  "agent_id": "econ",
  "territory_id": "1721000",
  "analysis_type": "economic_overview",
  "territory_name": "Palmas",
  "user_id": "test_user",
  "parameters": {
    "time_period": "2020-2024",
    "focus_areas": ["PIB per capita", "emprego formal"],
    "detail_level": "summary"
  }
}
```

## ✅ Exemplo de Payload Mínimo

```json
{
  "agent_id": "econ",
  "territory_id": "1721000",
  "analysis_type": "economic_overview"
}
```

---

## 🔄 Lógica de Normalização (Workflow V5)

Para garantir a resiliência, um novo nó **"Normalizar Entrada"** será adicionado logo após o webhook. Este nó irá:

1. **Validar Campos Obrigatórios:**
   - Se `agent_id`, `territory_id` ou `analysis_type` estiverem ausentes, o workflow retornará um erro 400 (Bad Request).

2. **Adicionar Valores Padrão:**
   - Se `territory_name` estiver ausente, será preenchido com `"Território Desconhecido"`.
   - Se `user_id` estiver ausente, será preenchido com `"system"`.
   - Se `parameters` estiver ausente, será criado um objeto vazio `{}`.
   - Se `parameters.time_period` estiver ausente, será preenchido com `"2019-2023"`.
   - Se `parameters.focus_areas` estiver ausente, será preenchido com `["PIB", "emprego", "renda"]`.
   - Se `parameters.detail_level` estiver ausente, será preenchido com `"comprehensive"`.

---

## 🛡️ Benefícios

- **Resiliência:** O workflow funcionará mesmo com payloads mínimos.
- **Clareza:** O contrato de API é claro e bem definido.
- **Manutenibilidade:** A lógica de normalização está centralizada em um único nó.
- **Escalabilidade:** Novos parâmetros podem ser adicionados facilmente.

---

## 🚀 Próximos Passos

1. Criar o código do nó **"Normalizar Entrada"**.
2. Revisar todos os nós do workflow para usar os dados normalizados.
3. Gerar o **Workflow V5** com todas as correções.
4. Testar o V5 com payloads completos e mínimos.
