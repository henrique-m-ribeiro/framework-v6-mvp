# Guia Rápido: Configuração do Workflow V4 no n8n

**Framework de Inteligência Territorial V6.0 - Sessão #10**  
**Workflow:** WF-AGENT-ECON - Especialista Econômico V4 (Aprendizagem via PostgreSQL)  
**Data:** 30 de novembro de 2025

---

## 📋 Pré-requisitos

✅ Workflow V4 já importado no n8n Cloud  
✅ Credencial PostgreSQL "Postgres Neon" já configurada  
✅ Acesso ao workflow: https://galactic-ai.app.n8n.cloud/workflow/csmBVXbc1jBuJoa5

---

## 🔧 Passos de Configuração

### Passo 1: Parar Execução (se necessário)

Se o workflow estiver em modo "Waiting for trigger event":
1. Clique no botão **"Stop"** ou pressione **ESC**
2. Aguarde o workflow voltar ao modo de edição

### Passo 2: Configurar o Nó "Registrar Aprendizado Automático"

1. **Clique uma vez** no nó "Registrar Aprendizado Automático" (ícone PostgreSQL azul)
2. O painel lateral direito abrirá automaticamente
3. Procure o campo **"Credential to connect with"**
4. Clique no dropdown e selecione **"Postgres Neon"**
5. **NÃO** clique em "Test" ou "Execute" ainda
6. Clique fora do nó ou pressione ESC para fechar o painel

### Passo 3: Configurar o Nó "Atualizar Expertise"

1. **Clique uma vez** no nó "Atualizar Expertise" (ícone PostgreSQL azul)
2. No painel lateral, procure **"Credential to connect with"**
3. Selecione **"Postgres Neon"**
4. Clique fora do nó ou pressione ESC

### Passo 4: Configurar o Nó "Registrar Auditoria do Ciclo"

1. **Clique uma vez** no nó "Registrar Auditoria do Ciclo" (ícone PostgreSQL azul)
2. No painel lateral, procure **"Credential to connect with"**
3. Selecione **"Postgres Neon"**
4. Clique fora do nó ou pressione ESC

### Passo 5: Salvar o Workflow

1. Clique no botão **"Save"** no canto superior direito
2. Aguarde a mensagem de confirmação "Workflow saved"

### Passo 6: Ativar o Workflow

1. Clique no botão **"Inactive"** no canto superior direito
2. O botão mudará para **"Active"** (verde)
3. O webhook estará disponível em: `https://galactic-ai.app.n8n.cloud/webhook/agent-econ`

---

## ✅ Verificação Rápida

Após configurar, verifique se:

- [ ] Os 3 nós PostgreSQL não têm ícones de erro (triângulo vermelho)
- [ ] O workflow está salvo (botão "Saved" visível)
- [ ] O workflow está ativo (botão "Active" verde)
- [ ] O webhook está disponível (URL visível no nó "Webhook - Recebe Tarefa")

---

## 🎯 Estrutura Final do Workflow

```
Webhook → Consultar Dados → Preparar Contexto → Gerar Análise (OpenAI)
→ Estruturar Resposta → Preparar Dados → Salvar Análise
→ Registrar Aprendizado Automático (PostgreSQL) ✅
→ Atualizar Expertise (PostgreSQL) ✅
→ Registrar Auditoria do Ciclo (PostgreSQL) ✅
→ Respond to Webhook
```

---

## 🧪 Teste Rápido (Opcional)

Para testar se o ciclo de aprendizagem está funcionando:

1. Envie uma requisição POST para o webhook do Agente ECON
2. Aguarde a análise ser gerada
3. Verifique no banco de dados Neon:

```sql
-- Ver último aprendizado registrado
SELECT * FROM agent_econ_learning_evolution 
ORDER BY created_at DESC LIMIT 1;

-- Ver expertise atual
SELECT * FROM get_agent_expertise('econ');

-- Ver último evento de auditoria
SELECT * FROM audit_trail 
WHERE event_type = 'learning_cycle_completed' 
ORDER BY created_at DESC LIMIT 1;
```

---

## ⚠️ Troubleshooting

### Erro: "Credential not found"

**Solução:** A credencial "Postgres Neon" não está configurada.

1. Vá em **Settings** → **Credentials**
2. Clique em **"Add Credential"**
3. Selecione **"Postgres"**
4. Preencha os dados:
   - **Name:** Postgres Neon
   - **Host:** `ep-noisy-math-aeyq5dvn.c-2.us-east-2.aws.neon.tech`
   - **Database:** `neondb`
   - **User:** `neondb_owner`
   - **Password:** `npg_HPRVKaYAT4E5`
   - **Port:** `5432`
   - **SSL:** Enabled
5. Clique em **"Save"**
6. Volte ao workflow e selecione a credencial nos 3 nós

### Erro: "Connection timeout"

**Solução:** Verifique se o IP do n8n Cloud está na whitelist do Neon.

1. Acesse o painel do Neon
2. Vá em **Settings** → **IP Allow**
3. Adicione o IP do n8n Cloud (ou libere todos: `0.0.0.0/0`)

### Erro: "Syntax error in SQL"

**Solução:** As queries SQL estão corretas. Verifique se:
- A credencial está apontando para o banco correto (`neondb`)
- O usuário tem permissões de INSERT/SELECT
- As tabelas existem (execute o script de validação)

---

## 📚 Próximos Passos

Após configurar o workflow V4:

1. ✅ Testar com uma análise real
2. ✅ Monitorar os logs de execução
3. ✅ Verificar se o aprendizado está sendo registrado a cada 5 análises
4. ✅ Observar a evolução da expertise ao longo do tempo
5. ✅ Documentar os resultados no diário de pesquisa-ação

---

## 📞 Suporte

Se encontrar problemas:
- Verifique os logs de execução no n8n (aba "Executions")
- Consulte o **Guia de Implementação Completo**: `docs/sessao10/Guia_Implementacao_Ciclo_N8N.md`
- Revise a documentação da arquitetura: `docs/07-database/ARQUITETURA_ATUAL.md`

---

**Boa configuração! 🚀**
