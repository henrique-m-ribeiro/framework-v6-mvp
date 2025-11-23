# Prompts para Replit Agent - Fase 5: Configuração do Ambiente

## 📋 Visão Geral

Este documento contém prompts específicos para usar com o Replit Agent durante a Fase 5 (Configuração do Ambiente PostgreSQL).

**Importante:** O Replit Agent pode não ter acesso direto ao painel administrativo do Replit. Alguns passos podem precisar ser feitos manualmente por você. Os prompts abaixo indicam claramente o que é automático vs. manual.

---

## 🗄️ Passo 5.1: Configuração do PostgreSQL

### ⚠️ Nota Importante

**A ativação inicial do PostgreSQL é MANUAL (você faz), mas o Agent pode ajudar com testes e configuração.**

---

### 📝 Instruções Manuais (Você Faz Primeiro)

#### 1. Ativar PostgreSQL no Replit

**Passos:**
1. No seu Repl, procure o painel lateral esquerdo
2. Clique em **"Tools"** (ícone de ferramentas)
3. Procure por **"PostgreSQL"**
4. Clique em **"Start"** ou **"Enable"**
5. Aguarde ~30 segundos até PostgreSQL iniciar

**Indicador de sucesso:**
- Status muda para "Running" (verde)
- Connection string aparece

---

#### 2. Copiar Connection String

**Passos:**
1. Após PostgreSQL iniciar, você verá uma **connection string**
2. Formato: `postgresql://username:password@host:port/database`
3. **Copie essa string** (você vai usar no próximo passo)

**Exemplo:**
```
postgresql://replit:senha123@db.replit.com:5432/repl_db_framework_v6_mvp
```

---

### 🤖 Prompt para Replit Agent: Configurar Variáveis de Ambiente

**Depois de ativar PostgreSQL e copiar a connection string, use este prompt:**

```
Configurar variáveis de ambiente para o projeto:

1. Criar arquivo `.env` na raiz do projeto (se não existir)

2. Adicionar as seguintes variáveis:

DATABASE_URL=<COLE_SUA_CONNECTION_STRING_AQUI>
OPENAI_API_KEY=<SUA_CHAVE_OPENAI>
OPENAI_MODEL=gpt-4o-mini
OPENAI_TEMPERATURE=0.3
PORT=3000
NODE_ENV=development

3. Criar arquivo `.env.example` (template público, sem valores sensíveis):

DATABASE_URL=postgresql://user:password@host:port/database
OPENAI_API_KEY=sk-...
OPENAI_MODEL=gpt-4o-mini
OPENAI_TEMPERATURE=0.3
PORT=3000
NODE_ENV=development

4. Garantir que `.env` está no `.gitignore` (para não commitar senhas)

5. Criar script Python `scripts/test_database_connection.py` para testar conexão:

```python
import os
import psycopg2
from dotenv import load_dotenv

load_dotenv()

def test_connection():
    try:
        conn = psycopg2.connect(os.getenv('DATABASE_URL'))
        cursor = conn.cursor()
        
        # Testar conexão
        cursor.execute("SELECT version();")
        version = cursor.fetchone()[0]
        print(f"✅ Conexão bem-sucedida!")
        print(f"📊 Versão PostgreSQL: {version}")
        
        cursor.close()
        conn.close()
        return True
    except Exception as e:
        print(f"❌ Erro na conexão: {e}")
        return False

if __name__ == "__main__":
    test_connection()
```

6. Instalar dependências necessárias (adicionar ao `requirements.txt` ou `pyproject.toml`):
   - psycopg2-binary
   - python-dotenv

7. Executar o script de teste para validar conexão.

IMPORTANTE: 
- Não commitar arquivo `.env` (deve estar no .gitignore)
- Commitar `.env.example` (template público)
- Verificar se PostgreSQL versão é 14+
```

---

### ✅ Checklist Pós-Execução (Você Valida)

Após o Agent executar, verifique:

- [ ] Arquivo `.env` criado com DATABASE_URL correto
- [ ] Arquivo `.env.example` criado (sem valores sensíveis)
- [ ] `.env` está no `.gitignore`
- [ ] Script `test_database_connection.py` criado
- [ ] Dependências `psycopg2-binary` e `python-dotenv` adicionadas
- [ ] Script de teste executa sem erros
- [ ] Versão PostgreSQL é 14+ (exibida no output)

---

### 🔧 Troubleshooting

**Problema: "ModuleNotFoundError: No module named 'psycopg2'"**

**Solução:** Instalar dependência manualmente
```bash
pip install psycopg2-binary python-dotenv
```

**Problema: "connection to server failed"**

**Solução:** Verificar se PostgreSQL está rodando (Tools → PostgreSQL → Status: Running)

**Problema: "password authentication failed"**

**Solução:** Copiar novamente a connection string do painel PostgreSQL (pode ter mudado)

---

## 🗺️ Passo 5.2: Instalação de Extensões PostgreSQL

### 🤖 Prompt para Replit Agent: Instalar Extensões

**Depois de confirmar que PostgreSQL está funcionando (Passo 5.1), use este prompt:**

```
Instalar extensões PostgreSQL necessárias para o projeto:

1. Criar script Python `scripts/install_postgres_extensions.py`:

```python
import os
import psycopg2
from dotenv import load_dotenv

load_dotenv()

def install_extensions():
    try:
        conn = psycopg2.connect(os.getenv('DATABASE_URL'))
        cursor = conn.cursor()
        
        print("🔧 Instalando extensões PostgreSQL...")
        
        # 1. Instalar PostGIS (essencial para dados geoespaciais)
        print("\n📍 Instalando PostGIS...")
        try:
            cursor.execute("CREATE EXTENSION IF NOT EXISTS postgis;")
            conn.commit()
            
            # Verificar instalação
            cursor.execute("SELECT PostGIS_version();")
            postgis_version = cursor.fetchone()[0]
            print(f"✅ PostGIS instalado com sucesso!")
            print(f"   Versão: {postgis_version}")
        except Exception as e:
            print(f"❌ Erro ao instalar PostGIS: {e}")
            print("   PostGIS pode não estar disponível no Replit.")
            conn.rollback()
        
        # 2. Tentar instalar pgvector (para embeddings vetoriais)
        print("\n🔍 Tentando instalar pgvector...")
        try:
            cursor.execute("CREATE EXTENSION IF NOT EXISTS vector;")
            conn.commit()
            
            # Verificar instalação
            cursor.execute("SELECT extversion FROM pg_extension WHERE extname = 'vector';")
            result = cursor.fetchone()
            if result:
                print(f"✅ pgvector instalado com sucesso!")
                print(f"   Versão: {result[0]}")
            else:
                raise Exception("Extensão não encontrada após instalação")
        except Exception as e:
            print(f"⚠️  pgvector não disponível: {e}")
            print("   Isso é esperado no Replit. Usaremos busca por texto como fallback.")
            conn.rollback()
        
        # 3. Listar todas extensões instaladas
        print("\n📋 Extensões PostgreSQL instaladas:")
        cursor.execute("""
            SELECT extname, extversion 
            FROM pg_extension 
            WHERE extname NOT IN ('plpgsql')
            ORDER BY extname;
        """)
        extensions = cursor.fetchall()
        for ext_name, ext_version in extensions:
            print(f"   - {ext_name} (v{ext_version})")
        
        cursor.close()
        conn.close()
        
        print("\n✅ Processo de instalação concluído!")
        return True
        
    except Exception as e:
        print(f"\n❌ Erro geral: {e}")
        return False

if __name__ == "__main__":
    install_extensions()
```

2. Criar arquivo de documentação `docs/database/EXTENSOES_POSTGRES.md`:

```markdown
# Extensões PostgreSQL do Framework V6.0

## Extensões Instaladas

### 1. PostGIS (Essencial)
**Status:** ✅ Instalado  
**Versão:** [será preenchido após instalação]  
**Propósito:** Suporte a dados geoespaciais

**Funcionalidades:**
- Armazenar geometrias (pontos, linhas, polígonos)
- Calcular distâncias entre coordenadas
- Realizar consultas espaciais (dentro de raio, intersecção)
- Essencial para aba Territorial (mapas interativos)

**Uso no Projeto:**
- Tabela `dim_territorios`: coluna `geometria` (MULTIPOLYGON)
- Cálculo de áreas, perímetros, centroides
- Visualização de mapas no dashboard

---

### 2. pgvector (Opcional)
**Status:** ⚠️ Não disponível no Replit (esperado)  
**Fallback:** Busca por texto usando `tsvector` e `tsquery`

**Propósito Original:** Busca vetorial para sistema RAG

**Alternativa Implementada:**
- PostgreSQL Full-Text Search (FTS)
- Índices GIN em colunas de texto
- Função `to_tsvector()` para indexação
- Função `ts_rank()` para relevância

**Impacto:** Mínimo. Busca por texto é suficiente para MVP.

---

## Verificação de Instalação

Execute o script:
```bash
python scripts/install_postgres_extensions.py
```

Saída esperada:
```
✅ PostGIS instalado com sucesso!
⚠️  pgvector não disponível (esperado)
✅ Processo de instalação concluído!
```

---

## Troubleshooting

### PostGIS não instala
**Causa:** Replit pode não ter PostGIS pré-instalado  
**Solução:** 
1. Considerar migrar para Neon.tech (PostgreSQL gerenciado com PostGIS)
2. Ou simplificar aba Territorial (sem mapas interativos no MVP)

### pgvector não disponível
**Causa:** Extensão não está no Replit  
**Solução:** Usar Full-Text Search (já implementado como fallback)
```

3. Executar o script de instalação e documentar resultados.

4. Atualizar `.env` com flag de extensões:
```
POSTGIS_AVAILABLE=true
PGVECTOR_AVAILABLE=false
```

5. Commitar arquivos no GitHub:
   - `scripts/install_postgres_extensions.py`
   - `docs/database/EXTENSOES_POSTGRES.md`
   - `.env.example` (atualizado)
```

---

### ✅ Checklist Pós-Execução (Você Valida)

Após o Agent executar, verifique:

- [ ] Script `install_postgres_extensions.py` criado
- [ ] Script executado sem erros críticos
- [ ] PostGIS instalado ✅ OU documentado como indisponível ⚠️
- [ ] pgvector instalado ✅ OU fallback documentado ⚠️
- [ ] Arquivo `EXTENSOES_POSTGRES.md` criado
- [ ] Variáveis `POSTGIS_AVAILABLE` e `PGVECTOR_AVAILABLE` adicionadas ao `.env`
- [ ] Commit feito no GitHub

---

### 🔧 Troubleshooting

**Problema: "ERROR: could not open extension control file"**

**Causa:** Extensão não está disponível no servidor PostgreSQL do Replit

**Soluções:**

**Para PostGIS:**
1. **Opção A (Recomendada):** Migrar para Neon.tech
   - Neon oferece PostgreSQL com PostGIS pré-instalado
   - Gratuito até 10GB
   - Melhor performance que Replit
   - Instruções: https://neon.tech/docs/extensions/postgis

2. **Opção B:** Simplificar aba Territorial
   - Remover mapas interativos do MVP
   - Usar apenas gráficos e tabelas
   - Adicionar mapas em versão futura

**Para pgvector:**
- Não é crítico para MVP
- Usar Full-Text Search como fallback (já planejado)
- Funcionalidade de busca semântica funciona sem pgvector

---

**Problema: "permission denied to create extension"**

**Causa:** Usuário do banco não tem privilégios de superusuário

**Solução:**
- No Replit, você deve ter privilégios suficientes
- Se não tiver, contactar suporte do Replit
- Ou migrar para Neon.tech (você tem controle total)

---

## 📊 Cenários Possíveis

### Cenário 1: Tudo Funciona ✅
- PostGIS instalado ✅
- pgvector instalado ✅
- **Ação:** Continuar para Fase 6 (Schema do Banco)

### Cenário 2: Só PostGIS ✅ (Mais Provável)
- PostGIS instalado ✅
- pgvector não disponível ⚠️
- **Ação:** Usar Full-Text Search, continuar para Fase 6

### Cenário 3: Nenhuma Extensão ❌
- PostGIS não disponível ❌
- pgvector não disponível ❌
- **Ação:** Migrar para Neon.tech OU simplificar MVP

---

## 🚀 Próximo Passo

Após completar Passo 5.1 e 5.2, você estará pronto para:

**Fase 6: Implementação do Schema do Banco de Dados**
- Criar 40 tabelas
- Definir relacionamentos
- Criar views e funções SQL

**Tempo estimado:** 1-2 horas

---

## 📝 Resumo dos Prompts

### Prompt 1: Configurar Variáveis de Ambiente (Passo 5.1)
**Quando usar:** Após ativar PostgreSQL manualmente no painel Replit

**O que faz:**
- Cria arquivo `.env` com DATABASE_URL e outras variáveis
- Cria `.env.example` (template público)
- Cria script de teste de conexão
- Instala dependências Python

**Duração:** 5-10 minutos

---

### Prompt 2: Instalar Extensões PostgreSQL (Passo 5.2)
**Quando usar:** Após confirmar que PostgreSQL está funcionando

**O que faz:**
- Cria script para instalar PostGIS e pgvector
- Tenta instalar extensões (pode falhar, ok)
- Documenta status das extensões
- Cria fallback para pgvector (Full-Text Search)

**Duração:** 10-15 minutos

---

## ⏱️ Tempo Total Estimado: Fase 5

**Passo 5.1:** 20-30 minutos  
**Passo 5.2:** 15-20 minutos  
**Total:** 35-50 minutos

---

## ✅ Critérios de Sucesso da Fase 5

Ao final da Fase 5, você deve ter:

- [ ] PostgreSQL ativo e rodando no Replit
- [ ] Connection string salva em `.env`
- [ ] Teste de conexão bem-sucedido
- [ ] Versão PostgreSQL verificada (14+)
- [ ] PostGIS instalado OU fallback documentado
- [ ] pgvector instalado OU fallback documentado
- [ ] Scripts de teste e instalação criados
- [ ] Documentação de extensões criada
- [ ] Tudo commitado no GitHub

**Se todos critérios forem atendidos: ✅ Pronto para Fase 6!**

---

Boa sorte! 🚀
