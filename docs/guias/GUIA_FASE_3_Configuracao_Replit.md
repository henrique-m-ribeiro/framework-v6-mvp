# Guia Passo-a-Passo: Fase 3 - Configuração do Ambiente Replit

**Projeto:** Framework V6.0 - Sistema de Inteligência Territorial  
**Fase:** 3 de 10  
**Objetivo:** Configurar ambiente Replit completo com PostgreSQL e extensões  
**Duração Estimada:** 1-1.5 horas  
**Pré-requisitos:** Conta Replit criada, Chave OpenAI obtida

---

## 📋 VISÃO GERAL DA FASE 3

### O Que Vamos Fazer

Nesta fase, você irá:

1. ✅ Criar projeto no Replit
2. ✅ Conectar Replit ao GitHub
3. ✅ Ativar PostgreSQL no Replit
4. ✅ Instalar extensões PostGIS e pgvector
5. ✅ Configurar variáveis de ambiente
6. ✅ Testar conexão com banco de dados
7. ✅ Fazer primeiro commit da sessão

### Por Que Isso é Importante

O ambiente Replit será a **base de toda a infraestrutura** do Framework V6.0:
- **PostgreSQL:** Armazenará todos os dados (econômicos, sociais, territoriais, ambientais)
- **PostGIS:** Permitirá análises geoespaciais (mapas, distâncias, áreas)
- **pgvector:** Permitirá busca vetorial para o sistema RAG
- **Integração GitHub:** Manterá código versionado e sincronizado

### Resultado Esperado

Ao final desta fase, você terá:
- Projeto Replit funcionando
- PostgreSQL rodando com extensões instaladas
- Variáveis de ambiente configuradas
- Ambiente pronto para receber o schema (Fase 4)

---

## 🚀 PASSO 1: CRIAR PROJETO NO REPLIT

### 1.1. Acessar Replit

1. Abra seu navegador
2. Acesse: https://replit.com
3. Faça login com sua conta

### 1.2. Criar Novo Repl

1. No painel principal, clique no botão **"+ Create Repl"** (canto superior direito)

2. Na tela de criação:
   - **Template:** Selecione **"Python"**
   - **Title:** Digite `framework-v6-mvp`
   - **Visibility:** Selecione **"Private"** (🔒)
   
3. Clique em **"Create Repl"**

4. Aguarde ~30 segundos enquanto o ambiente é criado

### 1.3. Familiarizar-se com a Interface

Você verá três painéis principais:

```
┌─────────────┬──────────────────┬─────────────┐
│   Files     │      Editor      │   Console   │
│  (esquerda) │     (centro)     │  (direita)  │
│             │                  │             │
│ 📁 Arquivos │ 📝 Código        │ 💻 Terminal │
│             │                  │             │
└─────────────┴──────────────────┴─────────────┘
```

**Painel Files (Esquerda):**
- Mostra estrutura de arquivos do projeto
- Você verá `main.py` (arquivo padrão)

**Painel Editor (Centro):**
- Onde você editará código
- `main.py` estará aberto

**Painel Console (Direita):**
- Terminal para executar comandos
- Você verá prompt: `$`

### 1.4. Verificar Criação

✅ **Checkpoint:** Você deve ver:
- URL do projeto: `https://replit.com/@SEU_USUARIO/framework-v6-mvp`
- Arquivo `main.py` aberto no editor
- Terminal pronto para comandos

---

## 🔗 PASSO 2: CONECTAR REPLIT AO GITHUB

### 2.1. Acessar Configurações de Versionamento

1. No painel **Files** (esquerda), procure o ícone de **três pontos** (⋮) ou **"Tools"**
2. Clique em **"Version Control"** ou **"Git"**

**Alternativa:** Alguns Repls mostram ícone de Git (🔀) na barra lateral esquerda.

### 2.2. Conectar ao Repositório GitHub

1. Você verá opção **"Connect to GitHub"** ou **"Import from GitHub"**

2. Clique em **"Connect to GitHub"**

3. Será solicitado autorização:
   - Clique em **"Authorize Replit"**
   - Faça login no GitHub se necessário
   - Autorize acesso do Replit ao GitHub

4. Após autorização, você verá lista de seus repositórios

5. Procure e selecione: **`framework-v6-mvp`**

6. Clique em **"Import"** ou **"Connect"**

### 2.3. Resolver Conflito (Se Houver)

O Repl já tem `main.py`, mas repositório GitHub tem estrutura diferente. Pode aparecer mensagem de conflito.

**Solução:**
1. Escolha **"Pull from GitHub"** (puxar do GitHub)
2. Isso substituirá arquivos locais pelos do GitHub
3. Confirme a ação

### 2.4. Verificar Sincronização

Após importação, você verá:

**No painel Files:**
```
framework-v6-mvp/
├── docs/
├── database/
├── rag/
├── README.md
├── LICENSE
├── .gitignore
└── .env.example
```

✅ **Checkpoint:** Estrutura do GitHub agora está no Replit!

### 2.5. Configurar Sincronização Automática (Opcional)

1. No painel de Version Control, procure opção **"Auto-sync"** ou **"Auto-commit"**
2. Se disponível, **ative** para commits automáticos
3. Se não disponível, faremos commits manuais (não é problema)

---

## 🗄️ PASSO 3: ATIVAR POSTGRESQL NO REPLIT

### 3.1. Acessar Ferramentas

1. No painel lateral esquerdo, procure ícone de **"Tools"** (🔧) ou **"Add-ons"**
2. Clique em **"Tools"**

### 3.2. Adicionar PostgreSQL

1. Na lista de ferramentas disponíveis, procure **"PostgreSQL"**
2. Clique em **"PostgreSQL"**
3. Clique no botão **"Add"** ou **"Enable"**

### 3.3. Aguardar Instalação

1. Replit começará a instalar PostgreSQL
2. Você verá barra de progresso ou mensagem "Setting up PostgreSQL..."
3. Aguarde ~30-60 segundos

### 3.4. Verificar Status

Após instalação, você verá:

```
PostgreSQL
Status: ● Running
Port: 5432
```

✅ **Checkpoint:** PostgreSQL está rodando!

### 3.5. Obter Connection String

1. No painel do PostgreSQL, procure **"Connection String"** ou **"Database URL"**
2. Clique para revelar a string
3. Você verá algo como:

```
postgresql://username:password@hostname:5432/database
```

**IMPORTANTE:** 
- **COPIE** esta string completa
- **SALVE** em local seguro (bloco de notas, gerenciador de senhas)
- Você usará ela no Passo 5

**Exemplo de formato:**
```
postgresql://replit:senha_gerada_automaticamente@db.replit.com:5432/framework_v6_mvp
```

---

## 🔌 PASSO 4: INSTALAR EXTENSÕES POSTGRESQL

Agora vamos instalar as extensões **PostGIS** (geoespacial) e **pgvector** (busca vetorial).

### 4.1. Abrir Terminal do Replit

1. No painel **Console** (direita), você verá o terminal
2. Se não estiver visível, clique em **"Shell"** ou **"Console"** na parte inferior

### 4.2. Conectar ao PostgreSQL via psql

No terminal, digite o seguinte comando:

```bash
psql $DATABASE_URL
```

**O que este comando faz:**
- `psql`: Cliente de linha de comando do PostgreSQL
- `$DATABASE_URL`: Variável de ambiente que Replit cria automaticamente com a connection string

Pressione **Enter**.

Você verá algo como:

```
psql (15.3)
Type "help" for help.

framework_v6_mvp=>
```

✅ **Checkpoint:** Você está conectado ao PostgreSQL!

### 4.3. Verificar Versão do PostgreSQL

No prompt `framework_v6_mvp=>`, digite:

```sql
SELECT version();
```

Pressione **Enter**.

Você verá a versão do PostgreSQL (deve ser 15+).

### 4.4. Instalar Extensão PostGIS

No prompt `framework_v6_mvp=>`, digite:

```sql
CREATE EXTENSION IF NOT EXISTS postgis;
```

Pressione **Enter**.

Você verá:

```
CREATE EXTENSION
```

✅ **Checkpoint:** PostGIS instalado!

### 4.5. Verificar Instalação do PostGIS

Digite:

```sql
SELECT PostGIS_version();
```

Pressione **Enter**.

Você verá a versão do PostGIS (ex: "3.3.2").

### 4.6. Instalar Extensão pgvector

**ATENÇÃO:** pgvector pode não estar disponível no Replit por padrão. Vamos tentar:

No prompt `framework_v6_mvp=>`, digite:

```sql
CREATE EXTENSION IF NOT EXISTS vector;
```

Pressione **Enter**.

**Cenário A: Sucesso**
```
CREATE EXTENSION
```
✅ pgvector instalado!

**Cenário B: Erro**
```
ERROR: could not open extension control file ".../vector.control": No such file or directory
```
⚠️ pgvector não está disponível.

### 4.7. Solução se pgvector Não Estiver Disponível

Se você recebeu erro no Passo 4.6, **não se preocupe**. Temos duas opções:

**Opção 1: Continuar sem pgvector por enquanto**
- Implementaremos o sistema RAG sem busca vetorial inicialmente
- Usaremos busca por similaridade de texto (menos eficiente, mas funcional)
- Migraremos para Neon (que tem pgvector) na Fase 5 ou 6

**Opção 2: Migrar para Neon agora**
- Neon é PostgreSQL serverless gratuito com pgvector
- Faremos isso se você preferir ter pgvector desde o início

**Qual opção você prefere?**
- [ ] Opção 1: Continuar sem pgvector (mais rápido)
- [ ] Opção 2: Migrar para Neon agora (mais completo)

**Recomendação:** Opção 1 (continuar sem pgvector). Podemos migrar depois se necessário.

### 4.8. Sair do psql

Digite:

```sql
\q
```

Pressione **Enter**.

Você voltará ao terminal normal do Replit (`$`).

---

## ⚙️ PASSO 5: CONFIGURAR VARIÁVEIS DE AMBIENTE

Variáveis de ambiente armazenam credenciais de forma segura (não versionadas no Git).

### 5.1. Criar Arquivo .env

1. No painel **Files** (esquerda), clique com botão direito na raiz do projeto
2. Selecione **"New File"** ou **"Create File"**
3. Digite o nome: `.env`
4. Pressione **Enter**

### 5.2. Copiar Template

1. No painel Files, abra o arquivo **`.env.example`**
2. **Copie** todo o conteúdo (Ctrl+A, Ctrl+C)
3. Abra o arquivo **`.env`** que você criou
4. **Cole** o conteúdo (Ctrl+V)

### 5.3. Preencher Variáveis

Agora vamos preencher as variáveis com valores reais.

**No arquivo `.env`, localize e edite as seguintes linhas:**

#### 5.3.1. OpenAI API Key

Localize:
```
OPENAI_API_KEY=sk-proj-SEU_TOKEN_AQUI
```

Substitua `SEU_TOKEN_AQUI` pela sua chave OpenAI (que você obteve antes).

Exemplo:
```
OPENAI_API_KEY=sk-proj-abc123def456ghi789...
```

#### 5.3.2. Database URL

Localize:
```
DATABASE_URL=postgresql://usuario:senha@host:5432/framework_v6
```

Substitua pela connection string que você copiou no Passo 3.5.

Exemplo:
```
DATABASE_URL=postgresql://replit:senha_gerada@db.replit.com:5432/framework_v6_mvp
```

#### 5.3.3. Modelos de IA

Localize:
```
LLM_MODEL=gpt-4o-mini
LLM_MODEL_PREMIUM=gpt-4o
EMBEDDING_MODEL=text-embedding-3-small
```

**Deixe como está** (esses são os valores corretos baseados na sua configuração personalizada).

#### 5.3.4. Configurações RAG

Localize:
```
CACHE_TTL=2592000
MAX_SEARCH_RESULTS=5
CACHE_SIMILARITY_THRESHOLD=0.85
MAX_CONTEXT_TOKENS=4000
```

**Deixe como está** (valores padrão recomendados).

#### 5.3.5. Logging

Localize:
```
LOG_LEVEL=INFO
ENVIRONMENT=development
DEBUG=true
```

**Deixe como está** (apropriado para fase de desenvolvimento).

### 5.4. Salvar Arquivo

1. Pressione **Ctrl+S** (ou Cmd+S no Mac)
2. Arquivo `.env` está salvo

✅ **Checkpoint:** Variáveis de ambiente configuradas!

### 5.5. Verificar que .env Não Será Versionado

1. Abra o arquivo **`.gitignore`**
2. Verifique que há linha: `.env`
3. Isso garante que suas credenciais **não** serão enviadas ao GitHub

---

## 🧪 PASSO 6: TESTAR CONEXÃO COM BANCO DE DADOS

Vamos criar script Python simples para testar se tudo está funcionando.

### 6.1. Criar Arquivo de Teste

1. No painel Files, clique com botão direito em **`scripts/`**
2. Selecione **"New File"**
3. Digite o nome: `test_connection.py`
4. Pressione **Enter**

### 6.2. Escrever Script de Teste

No arquivo `test_connection.py`, cole o seguinte código:

```python
#!/usr/bin/env python3
"""
Script de teste de conexão com PostgreSQL
Framework V6.0 - Fase 3
"""

import os
import sys
from dotenv import load_dotenv
import psycopg2
from psycopg2 import sql

# Carregar variáveis de ambiente
load_dotenv()

def test_connection():
    """Testa conexão com PostgreSQL e verifica extensões"""
    
    print("=" * 60)
    print("TESTE DE CONEXÃO - Framework V6.0")
    print("=" * 60)
    print()
    
    # Obter DATABASE_URL
    database_url = os.getenv('DATABASE_URL')
    
    if not database_url:
        print("❌ ERRO: DATABASE_URL não encontrada no .env")
        return False
    
    print("✅ DATABASE_URL encontrada")
    print(f"   URL: {database_url[:30]}...{database_url[-20:]}")
    print()
    
    try:
        # Conectar ao banco
        print("🔌 Conectando ao PostgreSQL...")
        conn = psycopg2.connect(database_url)
        cursor = conn.cursor()
        print("✅ Conexão estabelecida!")
        print()
        
        # Verificar versão do PostgreSQL
        print("📊 Verificando versão do PostgreSQL...")
        cursor.execute("SELECT version();")
        version = cursor.fetchone()[0]
        print(f"✅ {version.split(',')[0]}")
        print()
        
        # Verificar extensões instaladas
        print("🔍 Verificando extensões instaladas...")
        cursor.execute("""
            SELECT extname, extversion 
            FROM pg_extension 
            WHERE extname IN ('postgis', 'vector')
            ORDER BY extname;
        """)
        extensions = cursor.fetchall()
        
        if extensions:
            for ext_name, ext_version in extensions:
                print(f"✅ {ext_name} v{ext_version}")
        else:
            print("⚠️  Nenhuma extensão (PostGIS/pgvector) encontrada")
        print()
        
        # Verificar se PostGIS está funcionando
        if any(ext[0] == 'postgis' for ext in extensions):
            print("🗺️  Testando PostGIS...")
            cursor.execute("SELECT PostGIS_version();")
            postgis_version = cursor.fetchone()[0]
            print(f"✅ PostGIS funcionando: v{postgis_version}")
            print()
        
        # Verificar se pgvector está funcionando
        if any(ext[0] == 'vector' for ext in extensions):
            print("🔢 Testando pgvector...")
            cursor.execute("SELECT '[1,2,3]'::vector;")
            print("✅ pgvector funcionando")
            print()
        else:
            print("⚠️  pgvector não instalado (usaremos alternativa)")
            print()
        
        # Verificar OpenAI API Key
        print("🤖 Verificando OpenAI API Key...")
        openai_key = os.getenv('OPENAI_API_KEY')
        if openai_key and openai_key.startswith('sk-'):
            print(f"✅ OpenAI API Key encontrada: {openai_key[:10]}...{openai_key[-10:]}")
        else:
            print("❌ OpenAI API Key não encontrada ou inválida")
        print()
        
        # Fechar conexão
        cursor.close()
        conn.close()
        
        print("=" * 60)
        print("✅ TESTE CONCLUÍDO COM SUCESSO!")
        print("=" * 60)
        print()
        print("Próximo passo: Fase 4 - Implementação do Schema")
        
        return True
        
    except Exception as e:
        print(f"❌ ERRO: {e}")
        print()
        print("Verifique:")
        print("  1. DATABASE_URL está correta no .env")
        print("  2. PostgreSQL está rodando no Replit")
        print("  3. Extensões foram instaladas corretamente")
        return False

if __name__ == "__main__":
    success = test_connection()
    sys.exit(0 if success else 1)
```

### 6.3. Salvar Arquivo

Pressione **Ctrl+S** para salvar.

### 6.4. Instalar Dependências

No terminal do Replit, digite:

```bash
pip install psycopg2-binary python-dotenv
```

Pressione **Enter**.

Aguarde instalação (~30 segundos).

### 6.5. Executar Teste

No terminal, digite:

```bash
python scripts/test_connection.py
```

Pressione **Enter**.

### 6.6. Interpretar Resultado

Você verá saída similar a:

```
============================================================
TESTE DE CONEXÃO - Framework V6.0
============================================================

✅ DATABASE_URL encontrada
   URL: postgresql://replit:...

🔌 Conectando ao PostgreSQL...
✅ Conexão estabelecida!

📊 Verificando versão do PostgreSQL...
✅ PostgreSQL 15.3

🔍 Verificando extensões instaladas...
✅ postgis v3.3.2
⚠️  pgvector não instalado (usaremos alternativa)

🗺️  Testando PostGIS...
✅ PostGIS funcionando: v3.3.2

🤖 Verificando OpenAI API Key...
✅ OpenAI API Key encontrada: sk-proj-ab...xyz123

============================================================
✅ TESTE CONCLUÍDO COM SUCESSO!
============================================================

Próximo passo: Fase 4 - Implementação do Schema
```

✅ **Checkpoint:** Tudo funcionando!

**Se houver erros:**
- Leia mensagem de erro cuidadosamente
- Verifique se DATABASE_URL está correta no `.env`
- Verifique se PostgreSQL está rodando (Tools → PostgreSQL → Status: Running)
- Me avise o erro e te ajudarei a resolver

---

## 📝 PASSO 7: FAZER PRIMEIRO COMMIT DA SESSÃO

Agora vamos versionar o progresso no GitHub.

### 7.1. Verificar Mudanças

No terminal, digite:

```bash
git status
```

Você verá lista de arquivos modificados/criados:
- `.env` (NÃO será commitado, está no .gitignore)
- `scripts/test_connection.py` (novo)
- Possivelmente outros arquivos do Replit

### 7.2. Adicionar Arquivos ao Commit

Digite:

```bash
git add scripts/test_connection.py
```

**Nota:** `.env` não será adicionado (protegido pelo .gitignore).

### 7.3. Fazer Commit

Digite:

```bash
git commit -m "feat(fase-3): Configura ambiente Replit com PostgreSQL e PostGIS

- Cria projeto Replit e conecta ao GitHub
- Ativa PostgreSQL no Replit
- Instala extensão PostGIS v3.3.2
- Configura variáveis de ambiente (.env)
- Adiciona script de teste de conexão
- Valida conexão com banco e extensões

Status: Fase 3 concluída ✅
Próximo: Fase 4 - Implementação do Schema"
```

Pressione **Enter**.

### 7.4. Enviar para GitHub

Digite:

```bash
git push origin main
```

Pressione **Enter**.

Aguarde upload (~10 segundos).

### 7.5. Verificar no GitHub

1. Abra navegador
2. Acesse: https://github.com/henrique-m-ribeiro/framework-v6-mvp
3. Você verá novo commit com mensagem "feat(fase-3): Configura ambiente Replit..."
4. Clique no commit para ver mudanças

✅ **Checkpoint:** Commit realizado e enviado ao GitHub!

---

## 🎉 FASE 3 CONCLUÍDA!

### Resumo do Que Você Fez

✅ Criou projeto Replit  
✅ Conectou Replit ao GitHub  
✅ Ativou PostgreSQL no Replit  
✅ Instalou extensão PostGIS  
✅ Configurou variáveis de ambiente  
✅ Testou conexão com banco de dados  
✅ Fez primeiro commit da sessão  

### O Que Você Aprendeu

- Como criar e configurar projeto no Replit
- Como conectar Replit ao GitHub para versionamento
- Como ativar e configurar PostgreSQL
- Como instalar extensões PostgreSQL (PostGIS)
- Como configurar variáveis de ambiente de forma segura
- Como testar conexão com banco usando Python
- Como fazer commits seguindo convenção Conventional Commits

### Ambiente Atual

Você agora tem:
- **Replit:** Projeto funcionando, conectado ao GitHub
- **PostgreSQL:** Rodando, versão 15+
- **PostGIS:** Instalado e funcionando
- **pgvector:** Não instalado (usaremos alternativa ou migraremos para Neon)
- **Variáveis:** Configuradas e seguras
- **Teste:** Script validando que tudo funciona

### Próxima Fase

**Fase 4: Implementação do Schema do Banco de Dados**

Na próxima sessão, você irá:
- Executar script SQL que cria as 40 tabelas
- Popular tabelas de referência (dimensões, tipos)
- Validar estrutura do banco
- Preparar para carga de dados reais (Fase 5)

**Duração estimada:** 1-1.5 horas

---

## 📚 RECURSOS ADICIONAIS

### Documentação Consultada

- [Replit Docs - PostgreSQL](https://docs.replit.com/hosting/databases/postgresql)
- [PostGIS Documentation](https://postgis.net/documentation/)
- [psycopg2 Documentation](https://www.psycopg.org/docs/)

### Comandos Úteis

**PostgreSQL:**
```bash
# Conectar ao banco
psql $DATABASE_URL

# Listar extensões
\dx

# Listar tabelas
\dt

# Sair do psql
\q
```

**Git:**
```bash
# Ver status
git status

# Adicionar arquivo
git add arquivo.py

# Fazer commit
git commit -m "mensagem"

# Enviar para GitHub
git push origin main

# Ver histórico
git log --oneline
```

**Python:**
```bash
# Instalar pacote
pip install nome-do-pacote

# Executar script
python scripts/nome_script.py

# Ver pacotes instalados
pip list
```

---

## ❓ TROUBLESHOOTING

### Problema: PostgreSQL não inicia

**Sintomas:** Status: Stopped ou Error

**Solução:**
1. Clique em "Stop" e depois "Start" novamente
2. Se não funcionar, remova e adicione PostgreSQL novamente (Tools → PostgreSQL → Remove → Add)
3. Se persistir, use Neon (PostgreSQL externo)

### Problema: Extensão não instala

**Sintomas:** `ERROR: could not open extension control file`

**Solução:**
- PostGIS: Deveria estar disponível. Se não estiver, use Neon.
- pgvector: Não está disponível no Replit. Opções:
  - Continuar sem pgvector (busca por texto)
  - Migrar para Neon (tem pgvector)

### Problema: Erro ao conectar (psycopg2)

**Sintomas:** `psycopg2.OperationalError: could not connect`

**Solução:**
1. Verifique DATABASE_URL no .env (copie novamente do Replit)
2. Verifique que PostgreSQL está rodando (Status: Running)
3. Verifique que instalou psycopg2-binary: `pip install psycopg2-binary`

### Problema: Git push falha

**Sintomas:** `error: failed to push some refs`

**Solução:**
1. Primeiro faça pull: `git pull origin main`
2. Resolva conflitos se houver
3. Tente push novamente: `git push origin main`

---

## 📞 SUPORTE

Se encontrar problemas não listados aqui:

1. **Leia a mensagem de erro** cuidadosamente
2. **Anote** a mensagem exata
3. **Tire screenshot** se possível
4. **Me avise** na próxima interação com:
   - O que você estava fazendo
   - Mensagem de erro completa
   - Screenshot (se tiver)

---

**Guia criado por:** Manus AI  
**Data:** 10 de Novembro de 2025  
**Versão:** 1.0  
**Fase:** 3 de 10
