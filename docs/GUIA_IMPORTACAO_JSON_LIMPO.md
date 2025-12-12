# Guia de Importação - JSON Limpo do Orquestrador V4.0

**Framework de Inteligência Territorial V6.0**  
**Data:** 08 de dezembro de 2025  
**Sessão:** #14  
**Arquivo:** `WF-AGENT-ORCHESTRATOR-V4.0-CLEAN.json`

---

## 🔍 PROBLEMA IDENTIFICADO

O arquivo JSON original do Orquestrador V4.0 continha metadados específicos da instância n8n que o gerou, causando erro de importação:

- ❌ `id`: ID único do workflow na instância original
- ❌ `versionId`: Versão específica do workflow
- ❌ `meta`: Metadados da instância
- ❌ `tags`: Tags específicas
- ❌ IDs de credenciais hard-coded

---

## ✅ SOLUÇÃO APLICADA

Criei uma **versão limpa** do JSON que:

- ✅ Remove campos que causam conflito
- ✅ Remove IDs de credenciais (você configurará as suas)
- ✅ Define `active: false` (você ativa após configurar)
- ✅ Mantém toda a lógica e estrutura do workflow
- ✅ Mantém todos os 20 nós e 16 conexões

---

## 📂 LOCALIZAÇÃO DO ARQUIVO

**Arquivo Limpo:**
```
/home/ubuntu/framework-v6-mvp/n8n/workflows/Sessao_14/WF-AGENT-ORCHESTRATOR-V4.0-CLEAN.json
```

**Estatísticas:**
- **Nós:** 20
- **Conexões:** 16
- **Tamanho:** ~800 linhas
- **Encoding:** UTF-8
- **Validação:** ✅ Passou

---

## 🚀 COMO IMPORTAR NO N8N CLOUD

### Passo 1: Download do Arquivo

**Opção A: Via Interface Manus**
1. O arquivo está anexado à resposta
2. Faça download para seu computador

**Opção B: Via GitHub (se já commitou)**
1. Acesse o repositório
2. Navegue até `/n8n/workflows/Sessao_14/`
3. Baixe `WF-AGENT-ORCHESTRATOR-V4.0-CLEAN.json`

---

### Passo 2: Importar no n8n Cloud

1. Abra o **n8n Cloud** (https://galactic-ai.app.n8n.cloud)
2. Clique em **"Workflows"** no menu lateral
3. Clique no botão **"Import from File"** (ou ícone de upload)
4. Selecione o arquivo `WF-AGENT-ORCHESTRATOR-V4.0-CLEAN.json`
5. Aguarde o upload
6. O workflow será importado com o nome: **"WF-AGENT-ORCHESTRATOR - Orquestrador Central V4.0 (Multidimensional)"**

---

### Passo 3: Configurar Credenciais

Após a importação, você verá **avisos de credenciais ausentes**. Isso é normal!

**Nós que precisam de credenciais:**

1. **PostgreSQL - Buscar Território**
   - Tipo: PostgreSQL
   - Ação: Selecione suas credenciais do Neon PostgreSQL

2. **OpenAI - Interpretar Requisição**
   - Tipo: OpenAI API
   - Ação: Selecione suas credenciais da OpenAI

3. **OpenAI - Sintetizar Análises** (se existir)
   - Tipo: OpenAI API
   - Ação: Selecione suas credenciais da OpenAI

4. **PostgreSQL - Salvar na Knowledge Base**
   - Tipo: PostgreSQL
   - Ação: Selecione suas credenciais do Neon PostgreSQL

**Como Configurar:**

1. Clique em cada nó com aviso de credencial
2. No painel lateral, clique em **"Select Credential"**
3. Escolha suas credenciais existentes ou crie novas
4. Salve o nó

---

### Passo 4: Validar Conexões

1. Verifique se todos os nós estão conectados corretamente
2. Não deve haver nós "soltos" ou desconectados
3. O fluxo deve ser linear: Webhook → Validação → Interpretação → Roteamento → Agregação → Resposta

---

### Passo 5: Testar o Workflow

1. **Ative** o workflow (toggle no canto superior direito)
2. Copie a **URL do webhook** (clique no nó "Webhook - Recebe Requisição")
3. Execute um teste:

```bash
curl -X POST [SUA_URL_WEBHOOK] \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "question": "Qual o PIB de Palmas?"
  }'
```

**Resultado Esperado:**
- ✅ Workflow executa sem erros
- ✅ Retorna análise econômica
- ✅ Dados salvos na `knowledge_base`

---

## 🐛 TROUBLESHOOTING

### Erro: "Could not import file"

**Causa:** Arquivo corrompido durante download

**Solução:**
1. Baixe o arquivo novamente
2. Verifique se o arquivo tem ~800 linhas
3. Abra em um editor de texto e verifique se começa com `{` e termina com `}`

---

### Erro: "Invalid JSON"

**Causa:** Encoding incorreto

**Solução:**
1. Abra o arquivo em um editor que suporte UTF-8
2. Salve novamente com encoding UTF-8
3. Tente importar novamente

---

### Erro: "Credential not found"

**Causa:** Credenciais não configuradas

**Solução:**
1. Vá em **Settings → Credentials**
2. Crie credenciais para:
   - PostgreSQL (Neon)
   - OpenAI API
3. Volte ao workflow e selecione as credenciais

---

### Erro: "Node type not found"

**Causa:** n8n Cloud desatualizado ou nó customizado

**Solução:**
1. Verifique se seu n8n Cloud está atualizado
2. Se o erro persistir, reconstrua o nó manualmente seguindo o guia híbrido

---

## 📊 ESTRUTURA DO WORKFLOW IMPORTADO

### Nós Principais (20 total)

1. **Webhook - Recebe Requisição** (Entrada)
2. **IF - Validar Payload** (Validação)
3. **Responder Erro 400** (Erro)
4. **PostgreSQL - Buscar Território** (Consulta)
5. **IF - Território Encontrado?** (Validação)
6. **Responder Erro 404** (Erro)
7. **OpenAI - Interpretar Requisição** (IA)
8. **Set - Criar Payload V4** (Preparação)
9. **IF - Rotear para Economic** (Roteamento)
10. **IF - Rotear para Social** (Roteamento)
11. **IF - Rotear para Terra** (Roteamento)
12. **IF - Rotear para Ambient** (Roteamento)
13. **HTTP Request - Chamar Agente ECON** (Chamada)
14. **HTTP Request - Chamar Agente SOCIAL** (Chamada)
15. **HTTP Request - Chamar Agente TERRA** (Chamada)
16. **HTTP Request - Chamar Agente AMBIENT** (Chamada)
17. **Code - Agregar Respostas** (Processamento)
18. **IF - Análise Multidimensional?** (Decisão)
19. **OpenAI - Sintetizar Análises** (IA)
20. **PostgreSQL - Salvar na Knowledge Base** (Salvamento)
21. **Responder ao Usuário** (Saída)

---

## 🎯 PRÓXIMOS PASSOS

Após importar e validar o V4.0:

1. **Duplicar o workflow** para criar a base da V5.0
2. **Seguir o Guia Híbrido** para fazer as modificações V5.0
3. **Testar a V5.0** com os 3 testes propostos

---

## 📝 NOTAS IMPORTANTES

- ✅ O workflow importado está **inativo** por padrão
- ✅ Você deve **configurar credenciais** antes de ativar
- ✅ As URLs dos agentes estão **hard-coded** (V4.0)
- ✅ Para V5.0, você fará as modificações seguindo o guia híbrido

---

**Tempo Estimado de Importação:** 10-15 minutos  
**Tempo Estimado de Configuração:** 15-20 minutos  
**Total:** ~30 minutos

---

**Fim do Guia**
