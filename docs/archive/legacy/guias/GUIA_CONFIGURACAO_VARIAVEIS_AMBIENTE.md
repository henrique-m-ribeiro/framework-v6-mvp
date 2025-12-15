# Guia Completo de Configuração de Variáveis de Ambiente - Framework V6.0

**Autor:** Henrique Ribeiro & Manus IA  
**Data:** 07 de Novembro de 2025  
**Versão:** 1.0  
**Tempo Estimado:** 30-45 minutos

---

## 1. Introdução

Este guia fornece instruções passo-a-passo detalhadas para configurar todas as variáveis de ambiente necessárias para implementação do Framework V6.0 em ambiente Replit + n8n + OpenAI. A configuração correta dessas variáveis é **crítica** para o funcionamento do sistema.

**Pré-requisitos:**
- Conta Replit (plano Hacker recomendado: $20/mês)
- Conta OpenAI com créditos (mínimo $10)
- Conta n8n (cloud ou self-hosted)
- Acesso ao terminal (Linux, macOS, ou WSL no Windows)

---

## 2. Visão Geral das Variáveis

O Framework V6.0 requer **4 variáveis de ambiente principais** e **3 opcionais**:

### 2.1. Variáveis Obrigatórias

| Variável | Descrição | Onde Usar | Sensível |
|----------|-----------|-----------|----------|
| `OPENAI_API_KEY` | Chave de API da OpenAI | Replit, n8n, scripts Python | ✅ Sim |
| `DATABASE_URL` | URL de conexão PostgreSQL | Replit, n8n, scripts Python | ✅ Sim |
| `N8N_WEBHOOK_URL` | URL base dos webhooks n8n | Scripts Python, frontend | ❌ Não |
| `REPLIT_DB_URL` | URL do Replit Database (auto) | Replit apenas | ✅ Sim |

### 2.2. Variáveis Opcionais

| Variável | Descrição | Valor Padrão | Quando Usar |
|----------|-----------|--------------|-------------|
| `EMBEDDING_MODEL` | Modelo de embedding OpenAI | `text-embedding-3-small` | Para testar outros modelos |
| `LLM_MODEL` | Modelo LLM OpenAI | `gpt-4o` | Para usar GPT-4o-mini (mais barato) |
| `LOG_LEVEL` | Nível de logging | `INFO` | Para debugging (`DEBUG`) |

---

## 3. Passo 1: Obter Chave de API da OpenAI

### 3.1. Criar Conta OpenAI

1. Acesse [https://platform.openai.com/signup](https://platform.openai.com/signup)
2. Clique em "Sign up"
3. Preencha email, senha e informações pessoais
4. Verifique email (clique no link enviado)
5. Complete verificação de telefone (SMS)

**Tempo:** ~5 minutos

### 3.2. Adicionar Créditos

1. Acesse [https://platform.openai.com/account/billing/overview](https://platform.openai.com/account/billing/overview)
2. Clique em "Add payment method"
3. Adicione cartão de crédito
4. Clique em "Add to credit balance"
5. Adicione **$10** (mínimo recomendado para testes)
6. Confirme pagamento

**Custo:** $10 USD (~R$ 50)  
**Tempo:** ~3 minutos

**💡 Dica:** $10 é suficiente para ~1.800 análises completas (embedding + LLM).

### 3.3. Gerar Chave de API

1. Acesse [https://platform.openai.com/api-keys](https://platform.openai.com/api-keys)
2. Clique em "Create new secret key"
3. Dê um nome descritivo: "Framework V6 - Replit"
4. **Copie a chave imediatamente** (ela não será mostrada novamente!)
5. Salve em local seguro (gerenciador de senhas)

**Formato da chave:** `sk-proj-abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOP`

**⚠️ IMPORTANTE:**
- **NUNCA** compartilhe sua chave de API
- **NUNCA** commit a chave em repositórios Git
- **NUNCA** exponha a chave em frontend ou logs públicos
- Revogue imediatamente se suspeitar de vazamento

**Tempo:** ~2 minutos

### 3.4. Configurar Limites de Uso (Opcional mas Recomendado)

1. Acesse [https://platform.openai.com/account/limits](https://platform.openai.com/account/limits)
2. Configure "Hard limit" (limite máximo de gasto mensal): **$50**
3. Configure "Soft limit" (alerta de gasto): **$25**
4. Adicione email para alertas
5. Salve configurações

Isso previne gastos acidentais se houver bug ou uso malicioso.

**Tempo:** ~2 minutos

---

## 4. Passo 2: Configurar PostgreSQL no Replit

### 4.1. Criar Projeto Replit

1. Acesse [https://replit.com](https://replit.com)
2. Faça login ou crie conta
3. Clique em "+ Create Repl"
4. Selecione template: **"Python"**
5. Nomeie o projeto: **"framework-v6-database"**
6. Clique em "Create Repl"

**Tempo:** ~2 minutos

### 4.2. Ativar PostgreSQL

1. No painel esquerdo, clique em "Tools" (ícone de ferramenta)
2. Clique em "PostgreSQL"
3. Clique em "Start PostgreSQL"
4. Aguarde ~30 segundos até status "Running"

**Tempo:** ~1 minuto

### 4.3. Obter DATABASE_URL

1. Com PostgreSQL rodando, clique em "Connection string"
2. Copie a URL completa (começa com `postgresql://`)

**Formato:** `postgresql://usuario:senha@host:porta/database`

**Exemplo:**
```
postgresql://neondb_owner:AbCdEfGh123@ep-cool-forest-12345.us-east-2.aws.neon.tech/neondb?sslmode=require
```

3. Salve em local seguro

**Tempo:** ~1 minuto

### 4.4. Configurar Variável de Ambiente no Replit

1. No painel esquerdo, clique em "Tools" → "Secrets"
2. Clique em "+ New Secret"
3. **Key:** `DATABASE_URL`
4. **Value:** Cole a URL do PostgreSQL
5. Clique em "Add new secret"

**Tempo:** ~1 minuto

### 4.5. Instalar Extensões PostgreSQL

1. No painel esquerdo, clique em "Shell"
2. Execute os seguintes comandos:

```bash
# Conectar ao PostgreSQL
psql $DATABASE_URL

# Instalar extensões
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS vector;

# Verificar instalação
\dx

# Sair
\q
```

**Saída esperada:**
```
                                      List of installed extensions
   Name    | Version |   Schema   |                         Description
-----------+---------+------------+--------------------------------------------------------------
 postgis   | 3.3.3   | public     | PostGIS geometry and geography spatial types and functions
 uuid-ossp | 1.1     | public     | generate universally unique identifiers (UUIDs)
 vector    | 0.5.1   | public     | vector data type and ivfflat and hnsw access methods
```

**Tempo:** ~2 minutos

**⚠️ ATENÇÃO:** Se o comando `CREATE EXTENSION vector` falhar com erro "extension does not exist", você precisará usar Neon PostgreSQL (veja seção 4.6).

### 4.6. Alternativa: Usar Neon PostgreSQL (Se pgvector Não Disponível)

Se o Replit PostgreSQL não suportar pgvector, use Neon (gratuito até 10 GB):

1. Acesse [https://neon.tech](https://neon.tech)
2. Clique em "Sign up" e crie conta (GitHub recomendado)
3. Crie novo projeto: "Framework V6"
4. Região: "US East (Ohio)" (mais próxima do Brasil com pgvector)
5. Aguarde criação (~30 segundos)
6. Copie "Connection string" (formato: `postgresql://...neon.tech/...`)
7. No Replit, atualize secret `DATABASE_URL` com nova URL
8. Teste conexão:

```bash
psql $DATABASE_URL -c "SELECT version();"
```

**Tempo:** ~5 minutos

---

## 5. Passo 3: Configurar Variáveis no Replit

### 5.1. Adicionar OPENAI_API_KEY

1. No Replit, vá em "Tools" → "Secrets"
2. Clique em "+ New Secret"
3. **Key:** `OPENAI_API_KEY`
4. **Value:** Cole a chave da OpenAI (começa com `sk-proj-`)
5. Clique em "Add new secret"

**Tempo:** ~1 minuto

### 5.2. Adicionar Variáveis Opcionais

Repita o processo acima para cada variável opcional que desejar configurar:

| Key | Value Recomendado |
|-----|-------------------|
| `EMBEDDING_MODEL` | `text-embedding-3-small` |
| `LLM_MODEL` | `gpt-4o-mini` (mais barato) ou `gpt-4o` (melhor qualidade) |
| `LOG_LEVEL` | `INFO` (produção) ou `DEBUG` (desenvolvimento) |

**Tempo:** ~2 minutos

### 5.3. Verificar Configuração

1. No Shell do Replit, execute:

```bash
python3 << 'EOF'
import os

# Verificar variáveis
variaveis = {
    "OPENAI_API_KEY": os.getenv("OPENAI_API_KEY"),
    "DATABASE_URL": os.getenv("DATABASE_URL"),
    "EMBEDDING_MODEL": os.getenv("EMBEDDING_MODEL", "text-embedding-3-small"),
    "LLM_MODEL": os.getenv("LLM_MODEL", "gpt-4o"),
    "LOG_LEVEL": os.getenv("LOG_LEVEL", "INFO")
}

print("=== Configuração de Variáveis de Ambiente ===\n")
for key, value in variaveis.items():
    if value:
        # Mascarar valores sensíveis
        if "KEY" in key or "URL" in key:
            masked = value[:10] + "..." + value[-10:] if len(value) > 20 else "***"
            print(f"✅ {key}: {masked}")
        else:
            print(f"✅ {key}: {value}")
    else:
        print(f"❌ {key}: NÃO CONFIGURADO")

print("\n" + "="*50)
EOF
```

**Saída esperada:**
```
=== Configuração de Variáveis de Ambiente ===

✅ OPENAI_API_KEY: sk-proj-ab...KLMNOP
✅ DATABASE_URL: postgresql...equire
✅ EMBEDDING_MODEL: text-embedding-3-small
✅ LLM_MODEL: gpt-4o
✅ LOG_LEVEL: INFO

==================================================
```

**Tempo:** ~1 minuto

---

## 6. Passo 4: Configurar Variáveis no n8n

### 6.1. Acessar n8n

**Opção A: n8n Cloud**
1. Acesse [https://n8n.io](https://n8n.io)
2. Faça login
3. Abra sua instância n8n

**Opção B: n8n Self-Hosted**
1. Acesse sua instância (ex: `https://n8n.seudominio.com`)
2. Faça login

**Tempo:** ~1 minuto

### 6.2. Configurar Credenciais OpenAI

1. No menu lateral, clique em "Credentials"
2. Clique em "+ Add Credential"
3. Busque e selecione "OpenAI"
4. Preencha:
   - **Name:** "OpenAI Framework V6"
   - **API Key:** Cole a chave da OpenAI
5. Clique em "Save"
6. Clique em "Test" para validar

**Tempo:** ~2 minutos

### 6.3. Configurar Credenciais PostgreSQL

1. Em "Credentials", clique em "+ Add Credential"
2. Busque e selecione "Postgres"
3. Preencha (extrair da `DATABASE_URL`):

**Exemplo de DATABASE_URL:**
```
postgresql://usuario:senha@host:porta/database?sslmode=require
```

**Campos:**
- **Name:** "PostgreSQL Framework V6"
- **Host:** `host` (ex: `ep-cool-forest-12345.us-east-2.aws.neon.tech`)
- **Database:** `database` (ex: `neondb`)
- **User:** `usuario` (ex: `neondb_owner`)
- **Password:** `senha` (ex: `AbCdEfGh123`)
- **Port:** `porta` (geralmente `5432`)
- **SSL:** Marque "Use SSL" e selecione "require"

4. Clique em "Save"
5. Clique em "Test" para validar

**Tempo:** ~3 minutos

**💡 Dica:** Para extrair campos da URL automaticamente:

```bash
python3 << 'EOF'
from urllib.parse import urlparse

url = "postgresql://usuario:senha@host:porta/database?sslmode=require"
parsed = urlparse(url)

print(f"Host: {parsed.hostname}")
print(f"Port: {parsed.port or 5432}")
print(f"Database: {parsed.path[1:]}")
print(f"User: {parsed.username}")
print(f"Password: {parsed.password}")
EOF
```

### 6.4. Configurar Variáveis de Ambiente no n8n

**n8n Cloud:**
1. Vá em "Settings" → "Environment Variables"
2. Adicione:
   - `OPENAI_API_KEY`: Chave da OpenAI
   - `DATABASE_URL`: URL do PostgreSQL
3. Salve

**n8n Self-Hosted:**
1. Edite arquivo `.env` no servidor:

```bash
nano /path/to/n8n/.env
```

2. Adicione:

```env
OPENAI_API_KEY=sk-proj-...
DATABASE_URL=postgresql://...
```

3. Salve (Ctrl+O, Enter, Ctrl+X)
4. Reinicie n8n:

```bash
pm2 restart n8n
# ou
docker restart n8n
```

**Tempo:** ~3 minutos

---

## 7. Passo 5: Configurar Variáveis Localmente (Para Desenvolvimento)

### 7.1. Criar Arquivo .env

1. No diretório do projeto local, crie arquivo `.env`:

```bash
cd /caminho/do/projeto
touch .env
```

2. Edite o arquivo:

```bash
nano .env
```

3. Adicione as variáveis:

```env
# OpenAI
OPENAI_API_KEY=sk-proj-abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOP

# PostgreSQL
DATABASE_URL=postgresql://usuario:senha@host:porta/database?sslmode=require

# n8n (opcional, para testes locais)
N8N_WEBHOOK_URL=https://n8n.seudominio.com/webhook

# Configurações opcionais
EMBEDDING_MODEL=text-embedding-3-small
LLM_MODEL=gpt-4o
LOG_LEVEL=DEBUG
```

4. Salve (Ctrl+O, Enter, Ctrl+X)

**Tempo:** ~2 minutos

### 7.2. Adicionar .env ao .gitignore

**⚠️ CRÍTICO:** NUNCA commite `.env` no Git!

1. Edite `.gitignore`:

```bash
nano .gitignore
```

2. Adicione:

```
# Variáveis de ambiente
.env
.env.local
.env.*.local

# Credenciais
*.key
*.pem
credentials.json
```

3. Salve

4. Verifique:

```bash
git status
```

O arquivo `.env` **NÃO** deve aparecer na lista.

**Tempo:** ~1 minuto

### 7.3. Carregar Variáveis em Python

Para usar as variáveis em scripts Python:

```python
import os
from dotenv import load_dotenv

# Carregar variáveis do arquivo .env
load_dotenv()

# Acessar variáveis
openai_key = os.getenv("OPENAI_API_KEY")
database_url = os.getenv("DATABASE_URL")

print(f"OpenAI Key: {openai_key[:10]}...")
print(f"Database URL: {database_url[:20]}...")
```

**Instalar python-dotenv:**

```bash
pip install python-dotenv
```

**Tempo:** ~1 minuto

---

## 8. Passo 6: Testar Configuração

### 8.1. Teste de Conexão OpenAI

```python
import os
from openai import OpenAI

client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

# Teste de embedding
response = client.embeddings.create(
    model="text-embedding-3-small",
    input="Teste de conexão"
)

print(f"✅ OpenAI conectado! Embedding: {len(response.data[0].embedding)} dimensões")
```

**Saída esperada:**
```
✅ OpenAI conectado! Embedding: 1536 dimensões
```

**Tempo:** ~30 segundos

### 8.2. Teste de Conexão PostgreSQL

```python
import os
import psycopg2

conn = psycopg2.connect(os.getenv("DATABASE_URL"))
cur = conn.cursor()

cur.execute("SELECT version();")
version = cur.fetchone()[0]

print(f"✅ PostgreSQL conectado! Versão: {version}")

cur.close()
conn.close()
```

**Saída esperada:**
```
✅ PostgreSQL conectado! Versão: PostgreSQL 15.3 on x86_64-pc-linux-gnu...
```

**Tempo:** ~30 segundos

### 8.3. Teste de Extensões PostgreSQL

```python
import os
import psycopg2

conn = psycopg2.connect(os.getenv("DATABASE_URL"))
cur = conn.cursor()

cur.execute("SELECT extname, extversion FROM pg_extension WHERE extname IN ('uuid-ossp', 'postgis', 'vector');")
extensoes = cur.fetchall()

print("=== Extensões Instaladas ===")
for nome, versao in extensoes:
    print(f"✅ {nome}: v{versao}")

cur.close()
conn.close()
```

**Saída esperada:**
```
=== Extensões Instaladas ===
✅ uuid-ossp: v1.1
✅ postgis: v3.3.3
✅ vector: v0.5.1
```

**Tempo:** ~30 segundos

### 8.4. Teste Completo (rag_manager.py)

```bash
cd /caminho/do/projeto
python3 rag_manager.py teste_insercao
```

**Saída esperada:**
```
=== Teste de Inserção Completa ===

1. Texto da análise: 234 caracteres
2. Gerando embedding...
   - Dimensões: 1536
3. Construindo metadados...
   - Campos: 14
4. Inserindo no PostgreSQL...
   - ID: 550e8400-e29b-41d4-a716-446655440000

✅ Teste concluído com sucesso!
```

**Tempo:** ~1 minuto

---

## 9. Troubleshooting

### 9.1. Erro: "OPENAI_API_KEY not found"

**Causa:** Variável não configurada ou não carregada.

**Solução:**
1. Verifique se variável está em `.env` ou Replit Secrets
2. Se local, certifique-se de chamar `load_dotenv()` antes de acessar
3. Reinicie shell/terminal após adicionar variável

### 9.2. Erro: "Invalid API key"

**Causa:** Chave incorreta ou revogada.

**Solução:**
1. Verifique se copiou chave completa (começa com `sk-proj-`)
2. Gere nova chave em [https://platform.openai.com/api-keys](https://platform.openai.com/api-keys)
3. Atualize variável `OPENAI_API_KEY`

### 9.3. Erro: "connection to server failed"

**Causa:** DATABASE_URL incorreto ou PostgreSQL não rodando.

**Solução:**
1. Verifique se PostgreSQL está rodando no Replit
2. Teste conexão: `psql $DATABASE_URL -c "SELECT 1;"`
3. Verifique se URL tem formato correto: `postgresql://user:pass@host:port/db`
4. Certifique-se de incluir `?sslmode=require` no final

### 9.4. Erro: "extension 'vector' does not exist"

**Causa:** Replit PostgreSQL não suporta pgvector.

**Solução:**
1. Use Neon PostgreSQL (veja seção 4.6)
2. Ou use Supabase (também suporta pgvector)

### 9.5. Erro: "Rate limit exceeded"

**Causa:** Muitas requisições à API OpenAI em curto período.

**Solução:**
1. Implemente rate limiting (veja revisão técnica)
2. Use tier mais alto da OpenAI (aumenta limites)
3. Adicione delays entre requisições

### 9.6. Erro: "Insufficient quota"

**Causa:** Créditos OpenAI esgotados.

**Solução:**
1. Adicione mais créditos em [https://platform.openai.com/account/billing](https://platform.openai.com/account/billing)
2. Configure alertas de uso para evitar surpresas

---

## 10. Segurança e Boas Práticas

### 10.1. Proteção de Credenciais

**✅ FAÇA:**
- Use variáveis de ambiente para credenciais
- Use gerenciador de senhas (1Password, LastPass)
- Revogue chaves antigas ao criar novas
- Configure alertas de uso anormal
- Use roles de banco com permissões mínimas

**❌ NÃO FAÇA:**
- Hardcode credenciais no código
- Commite `.env` no Git
- Compartilhe chaves por email/chat
- Use mesma chave em múltiplos ambientes
- Dê permissões de admin desnecessárias

### 10.2. Rotação de Credenciais

Recomenda-se rotacionar credenciais a cada **90 dias**:

1. Gere nova chave OpenAI
2. Atualize variável em todos os ambientes
3. Teste funcionamento
4. Revogue chave antiga
5. Documente mudança

### 10.3. Monitoramento de Uso

Configure alertas para:
- Gasto > $25/mês (OpenAI)
- Uso de disco > 80% (PostgreSQL)
- Taxa de erro > 5%
- Latência > 5 segundos

---

## 11. Checklist de Configuração

Use este checklist para garantir que tudo está configurado:

### Replit

- [ ] Projeto criado
- [ ] PostgreSQL ativado e rodando
- [ ] Extensões instaladas (uuid-ossp, postgis, vector)
- [ ] Secret `OPENAI_API_KEY` configurado
- [ ] Secret `DATABASE_URL` configurado
- [ ] Teste de conexão PostgreSQL executado com sucesso

### OpenAI

- [ ] Conta criada e verificada
- [ ] Créditos adicionados (mínimo $10)
- [ ] Chave de API gerada
- [ ] Limites de uso configurados ($50 hard, $25 soft)
- [ ] Teste de embedding executado com sucesso

### n8n

- [ ] Credencial OpenAI configurada e testada
- [ ] Credencial PostgreSQL configurada e testada
- [ ] Variáveis de ambiente configuradas (se aplicável)

### Local (Desenvolvimento)

- [ ] Arquivo `.env` criado
- [ ] Variáveis adicionadas ao `.env`
- [ ] `.env` adicionado ao `.gitignore`
- [ ] `python-dotenv` instalado
- [ ] Teste de carregamento de variáveis executado

### Testes

- [ ] Teste de conexão OpenAI passou
- [ ] Teste de conexão PostgreSQL passou
- [ ] Teste de extensões PostgreSQL passou
- [ ] Teste completo (`rag_manager.py teste_insercao`) passou

---

## 12. Próximos Passos

Após configurar todas as variáveis:

1. Execute schema SQL completo (SCHEMA_COMPLETO_40_TABELAS_POSTGRESQL.sql)
2. Popule tabela `entidades_territoriais` com CSV
3. Importe workflows n8n
4. Execute primeiro teste end-to-end
5. Valide custos e performance

---

## 13. Suporte

**Documentação Oficial:**
- OpenAI: [https://platform.openai.com/docs](https://platform.openai.com/docs)
- Replit: [https://docs.replit.com](https://docs.replit.com)
- n8n: [https://docs.n8n.io](https://docs.n8n.io)
- PostgreSQL: [https://www.postgresql.org/docs/](https://www.postgresql.org/docs/)

**Comunidades:**
- OpenAI Community: [https://community.openai.com](https://community.openai.com)
- Replit Community: [https://ask.replit.com](https://ask.replit.com)
- n8n Community: [https://community.n8n.io](https://community.n8n.io)

---

**Configurado por:** Henrique Ribeiro & Manus IA  
**Data:** 07 de Novembro de 2025  
**Status:** ✅ Pronto para Uso
