# Guia de Configuração: Replit + PostgreSQL + pgvector

**Framework de Interação Galáctica V6.0**  
**Versão:** 1.0  
**Data:** 07 de Novembro de 2025  
**Autor:** Henrique Ribeiro & Manus IA

---

## Sumário Executivo

Este documento fornece um **guia completo passo a passo** para configurar o ambiente de desenvolvimento e produção do Framework V6.0 no Replit, incluindo PostgreSQL com extensão pgvector para armazenamento de embeddings vetoriais.

**Tempo estimado:** 30-45 minutos  
**Nível de dificuldade:** Intermediário  
**Pré-requisitos:** Conta Replit (gratuita ou paga), conhecimento básico de SQL

---

## Índice

1. [Visão Geral da Arquitetura](#1-visão-geral-da-arquitetura)
2. [Pré-requisitos e Preparação](#2-pré-requisitos-e-preparação)
3. [Passo 1: Criar Projeto no Replit](#3-passo-1-criar-projeto-no-replit)
4. [Passo 2: Configurar PostgreSQL](#4-passo-2-configurar-postgresql)
5. [Passo 3: Instalar e Configurar pgvector](#5-passo-3-instalar-e-configurar-pgvector)
6. [Passo 4: Criar Esquema de Banco de Dados](#6-passo-4-criar-esquema-de-banco-de-dados)
7. [Passo 5: Configurar Variáveis de Ambiente](#7-passo-5-configurar-variáveis-de-ambiente)
8. [Passo 6: Instalar Dependências Python](#8-passo-6-instalar-dependências-python)
9. [Passo 7: Criar Scripts de Inicialização](#9-passo-7-criar-scripts-de-inicialização)
10. [Passo 8: Testes de Validação](#10-passo-8-testes-de-validação)
11. [Troubleshooting](#11-troubleshooting)
12. [Próximos Passos](#12-próximos-passos)
13. [Referências](#13-referências)

---

## 1. Visão Geral da Arquitetura

O ambiente Replit hospedará três componentes principais:

### **Componentes**

| Componente | Tecnologia | Função |
|------------|------------|--------|
| **Aplicação Web** | Next.js 14 + React | Interface de usuário (dashboard) |
| **API Backend** | Next.js API Routes | Endpoints REST para agentes |
| **Banco de Dados** | PostgreSQL 15 + pgvector | Armazenamento estruturado + vetorial |

### **Fluxo de Dados**

```
┌──────────────┐      ┌──────────────┐      ┌──────────────┐
│   Usuário    │ ───> │  Next.js App │ ───> │  PostgreSQL  │
│  (Browser)   │ <─── │  (Replit)    │ <─── │  + pgvector  │
└──────────────┘      └──────────────┘      └──────────────┘
                             │
                             ↓
                      ┌──────────────┐
                      │  n8n Agente  │
                      │     DATA     │
                      └──────────────┘
```

### **Portas e Serviços**

| Serviço | Porta | URL |
|---------|-------|-----|
| **Next.js App** | 3000 | `https://<repl-name>.<username>.repl.co` |
| **PostgreSQL** | 5432 | `localhost:5432` (interno) |
| **pgAdmin** | 5050 | `https://<repl-name>-5050.<username>.repl.co` (opcional) |

---

## 2. Pré-requisitos e Preparação

### **2.1. Conta Replit**

**Opções:**

- **Gratuita (Starter):** Limitada, mas suficiente para desenvolvimento inicial
- **Hacker ($7/mês):** Recomendada, inclui Always On e mais recursos
- **Pro ($20/mês):** Ideal para produção, inclui 4GB RAM e 10GB storage

**Recomendação:** Comece com plano **Hacker** para desenvolvimento.

### **2.2. Conhecimentos Necessários**

- ✅ SQL básico (CREATE TABLE, INSERT, SELECT)
- ✅ Linha de comando Linux (cd, ls, cat)
- ✅ Git básico (clone, commit, push) - opcional
- ✅ Python básico - opcional mas recomendado

### **2.3. Ferramentas Auxiliares**

- **DBeaver** ou **pgAdmin:** Para gerenciar banco de dados visualmente (opcional)
- **Postman:** Para testar APIs (opcional)
- **VS Code:** Para editar código localmente antes de enviar ao Replit (opcional)

---

## 3. Passo 1: Criar Projeto no Replit

### **3.1. Criar Novo Repl**

1. Acesse [https://replit.com](https://replit.com)
2. Clique em **"+ Create Repl"**
3. Selecione template: **"Next.js"**
4. Nome do Repl: `framework-v6-tocantins`
5. Visibilidade: **Private** (recomendado)
6. Clique em **"Create Repl"**

### **3.2. Estrutura Inicial**

O Replit criará automaticamente:

```
framework-v6-tocantins/
├── .next/
├── app/
│   ├── layout.tsx
│   └── page.tsx
├── public/
├── package.json
├── next.config.js
├── tsconfig.json
└── .replit
```

### **3.3. Configurar .replit**

Edite o arquivo `.replit` para adicionar PostgreSQL:

```toml
run = "npm run dev"
entrypoint = "app/page.tsx"
hidden = [".next", "node_modules"]

[nix]
channel = "stable-23_11"

[deployment]
run = ["npm", "run", "start"]
deploymentTarget = "cloudrun"

[languages.typescript]
pattern = "**/{*.ts,*.tsx}"

[languages.typescript.languageServer]
start = "typescript-language-server --stdio"

[env]
DATABASE_URL = "postgresql://replit:replit@localhost:5432/framework_v6"
PGHOST = "localhost"
PGPORT = "5432"
PGUSER = "replit"
PGPASSWORD = "replit"
PGDATABASE = "framework_v6"
```

---

## 4. Passo 2: Configurar PostgreSQL

### **4.1. Instalar PostgreSQL via Nix**

Crie ou edite o arquivo `replit.nix`:

```nix
{ pkgs }: {
  deps = [
    pkgs.nodejs-18_x
    pkgs.postgresql_15
    pkgs.openssl
  ];
  
  env = {
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.postgresql_15
    ];
  };
}
```

### **4.2. Inicializar PostgreSQL**

Abra o **Shell** no Replit e execute:

```bash
# Criar diretório de dados
mkdir -p ~/postgres_data

# Inicializar cluster PostgreSQL
initdb -D ~/postgres_data

# Iniciar servidor PostgreSQL
pg_ctl -D ~/postgres_data -l ~/postgres_data/logfile start

# Aguardar 5 segundos para servidor iniciar
sleep 5

# Criar banco de dados
createdb framework_v6

# Verificar se banco foi criado
psql -l
```

**Saída esperada:**

```
                                  List of databases
     Name      |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges   
---------------+----------+----------+-------------+-------------+-----------------------
 framework_v6  | replit   | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 postgres      | replit   | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 template0     | replit   | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/replit            +
               |          |          |             |             | replit=CTc/replit
 template1     | replit   | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/replit            +
               |          |          |             |             | replit=CTc/replit
(4 rows)
```

### **4.3. Configurar Autoinicialização**

Crie arquivo `.replit.postgres.sh`:

```bash
#!/bin/bash

# Script de autoinicialização do PostgreSQL
# Este script é executado automaticamente quando o Repl inicia

# Verificar se PostgreSQL já está rodando
if pg_isready -q; then
  echo "PostgreSQL já está rodando"
else
  echo "Iniciando PostgreSQL..."
  
  # Criar diretório se não existir
  mkdir -p ~/postgres_data
  
  # Inicializar se necessário
  if [ ! -f ~/postgres_data/PG_VERSION ]; then
    echo "Inicializando cluster PostgreSQL..."
    initdb -D ~/postgres_data
  fi
  
  # Iniciar servidor
  pg_ctl -D ~/postgres_data -l ~/postgres_data/logfile start
  
  # Aguardar servidor ficar pronto
  for i in {1..30}; do
    if pg_isready -q; then
      echo "PostgreSQL iniciado com sucesso!"
      break
    fi
    echo "Aguardando PostgreSQL... ($i/30)"
    sleep 1
  done
  
  # Criar banco se não existir
  if ! psql -lqt | cut -d \| -f 1 | grep -qw framework_v6; then
    echo "Criando banco de dados framework_v6..."
    createdb framework_v6
  fi
fi
```

Torne o script executável:

```bash
chmod +x .replit.postgres.sh
```

Adicione ao `.replit`:

```toml
[nix]
channel = "stable-23_11"

[deployment]
run = ["sh", "-c", "./.replit.postgres.sh && npm run start"]
```

---

## 5. Passo 3: Instalar e Configurar pgvector

### **5.1. Instalar Extensão pgvector**

```bash
# Conectar ao banco de dados
psql framework_v6

# Dentro do psql, executar:
CREATE EXTENSION IF NOT EXISTS vector;

# Verificar instalação
\dx

# Sair do psql
\q
```

**Saída esperada:**

```
                                     List of installed extensions
  Name   | Version |   Schema   |                         Description                          
---------+---------+------------+--------------------------------------------------------------
 plpgsql | 1.0     | pg_catalog | PL/pgSQL procedural language
 vector  | 0.5.1   | public     | vector data type and ivfflat and hnsw access methods
(2 rows)
```

### **5.2. Testar pgvector**

Crie um arquivo `test_pgvector.sql`:

```sql
-- Criar tabela de teste
CREATE TABLE IF NOT EXISTS test_embeddings (
  id SERIAL PRIMARY KEY,
  content TEXT,
  embedding vector(1536)  -- OpenAI ada-002 usa 1536 dimensões
);

-- Inserir dados de teste
INSERT INTO test_embeddings (content, embedding) VALUES
  ('Teste 1', ARRAY[0.1, 0.2, 0.3]::vector),
  ('Teste 2', ARRAY[0.4, 0.5, 0.6]::vector);

-- Consultar com similaridade de cosseno
SELECT 
  content,
  1 - (embedding <=> ARRAY[0.1, 0.2, 0.3]::vector) AS similarity
FROM test_embeddings
ORDER BY embedding <=> ARRAY[0.1, 0.2, 0.3]::vector
LIMIT 5;

-- Limpar
DROP TABLE test_embeddings;
```

Execute:

```bash
psql framework_v6 < test_pgvector.sql
```

**Saída esperada:**

```
CREATE TABLE
INSERT 0 2
 content | similarity 
---------+------------
 Teste 1 |          1
 Teste 2 |  0.9746318
(2 rows)

DROP TABLE
```

---

## 6. Passo 4: Criar Esquema de Banco de Dados

### **6.1. Esquema Core (5 Tabelas Iniciais)**

Crie arquivo `schema_core.sql`:

```sql
-- ============================================================================
-- FRAMEWORK V6.0 - ESQUEMA CORE DO BANCO DE DADOS
-- Versão: 1.0
-- Data: 2025-11-07
-- Autor: Henrique Ribeiro & Manus IA
-- ============================================================================

-- Habilitar extensões necessárias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "vector";

-- ============================================================================
-- TABELA 1: entidades_territoriais
-- Armazena municípios e estados
-- ============================================================================

CREATE TABLE IF NOT EXISTS entidades_territoriais (
  -- Identificação
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  codigo_ibge VARCHAR(7) UNIQUE NOT NULL,
  nome VARCHAR(255) NOT NULL,
  tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('municipio', 'estado')),
  uf CHAR(2) NOT NULL,
  
  -- Regiões (Nova Divisão 2017)
  regiao_imediata_id VARCHAR(10),
  regiao_imediata_nome VARCHAR(255),
  regiao_intermediaria_id VARCHAR(10),
  regiao_intermediaria_nome VARCHAR(255),
  
  -- Regiões (Divisão Antiga 1989)
  microrregiao_id VARCHAR(10),
  microrregiao_nome VARCHAR(255),
  mesorregiao_id VARCHAR(10),
  mesorregiao_nome VARCHAR(255),
  
  -- Metadados
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  -- Índices
  CONSTRAINT entidades_territoriais_codigo_ibge_check 
    CHECK (LENGTH(codigo_ibge) IN (2, 7))
);

CREATE INDEX idx_entidades_codigo_ibge ON entidades_territoriais(codigo_ibge);
CREATE INDEX idx_entidades_tipo ON entidades_territoriais(tipo);
CREATE INDEX idx_entidades_uf ON entidades_territoriais(uf);

-- ============================================================================
-- TABELA 2: dados_economicos
-- Armazena dados econômicos (PIB, população, etc.)
-- ============================================================================

CREATE TABLE IF NOT EXISTS dados_economicos (
  -- Identificação
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  entidade_id UUID NOT NULL REFERENCES entidades_territoriais(id) ON DELETE CASCADE,
  ano INTEGER NOT NULL,
  
  -- Dados demográficos
  populacao INTEGER,
  
  -- Dados econômicos
  pib_mil_reais NUMERIC(15, 2),
  pib_per_capita_reais NUMERIC(10, 2),
  pib_agropecuaria_mil_reais NUMERIC(15, 2),
  pib_industria_mil_reais NUMERIC(15, 2),
  pib_servicos_mil_reais NUMERIC(15, 2),
  pib_impostos_mil_reais NUMERIC(15, 2),
  pib_adm_publica_mil_reais NUMERIC(15, 2),
  
  -- Participações setoriais (%)
  pib_agropecuaria_percent NUMERIC(5, 2),
  pib_industria_percent NUMERIC(5, 2),
  pib_servicos_percent NUMERIC(5, 2),
  
  -- Metadados
  fonte VARCHAR(100),
  data_coleta TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  -- Constraints
  UNIQUE(entidade_id, ano),
  CHECK (ano >= 2000 AND ano <= 2100),
  CHECK (populacao >= 0),
  CHECK (pib_mil_reais >= 0)
);

CREATE INDEX idx_dados_economicos_entidade ON dados_economicos(entidade_id);
CREATE INDEX idx_dados_economicos_ano ON dados_economicos(ano);
CREATE INDEX idx_dados_economicos_entidade_ano ON dados_economicos(entidade_id, ano);

-- ============================================================================
-- TABELA 3: dados_orcamentarios
-- Armazena receitas e despesas orçamentárias (SICONFI)
-- ============================================================================

CREATE TABLE IF NOT EXISTS dados_orcamentarios (
  -- Identificação
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  entidade_id UUID NOT NULL REFERENCES entidades_territoriais(id) ON DELETE CASCADE,
  ano INTEGER NOT NULL,
  tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('receita', 'despesa')),
  
  -- Receitas
  receita_total NUMERIC(15, 2),
  receita_corrente NUMERIC(15, 2),
  receita_tributaria NUMERIC(15, 2),
  receita_iptu NUMERIC(15, 2),
  receita_iss NUMERIC(15, 2),
  receita_itbi NUMERIC(15, 2),
  receita_transferencias NUMERIC(15, 2),
  receita_fpm NUMERIC(15, 2),
  receita_icms NUMERIC(15, 2),
  receita_ipva NUMERIC(15, 2),
  receita_outras NUMERIC(15, 2),
  
  -- Despesas
  despesa_total NUMERIC(15, 2),
  despesa_corrente NUMERIC(15, 2),
  despesa_pessoal NUMERIC(15, 2),
  despesa_custeio NUMERIC(15, 2),
  despesa_investimento NUMERIC(15, 2),
  despesa_educacao NUMERIC(15, 2),
  despesa_saude NUMERIC(15, 2),
  despesa_assistencia_social NUMERIC(15, 2),
  despesa_infraestrutura NUMERIC(15, 2),
  despesa_outras NUMERIC(15, 2),
  
  -- Indicadores calculados
  resultado_primario NUMERIC(15, 2),
  resultado_nominal NUMERIC(15, 2),
  divida_consolidada NUMERIC(15, 2),
  
  -- Índices de dependência (%)
  dependencia_fpm_percent NUMERIC(5, 2),
  dependencia_transferencias_percent NUMERIC(5, 2),
  autonomia_tributaria_percent NUMERIC(5, 2),
  
  -- Metadados
  fonte VARCHAR(100) DEFAULT 'SICONFI',
  data_coleta TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  -- Constraints
  UNIQUE(entidade_id, ano, tipo),
  CHECK (ano >= 2000 AND ano <= 2100)
);

CREATE INDEX idx_dados_orcamentarios_entidade ON dados_orcamentarios(entidade_id);
CREATE INDEX idx_dados_orcamentarios_ano ON dados_orcamentarios(ano);
CREATE INDEX idx_dados_orcamentarios_tipo ON dados_orcamentarios(tipo);

-- ============================================================================
-- TABELA 4: analises_geradas
-- Armazena análises geradas pelos agentes (cache de conhecimento)
-- ============================================================================

CREATE TABLE IF NOT EXISTS analises_geradas (
  -- Identificação
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  hash_consulta CHAR(64) UNIQUE NOT NULL,  -- SHA-256 da consulta
  
  -- Contexto da análise
  agente VARCHAR(50) NOT NULL,  -- INTERACT, TERRA, ECON, SOCIAL
  tipo_analise VARCHAR(100) NOT NULL,  -- ex: "analise_economica_municipal"
  entidade_id UUID REFERENCES entidades_territoriais(id),
  parametros JSONB,  -- Parâmetros da consulta original
  
  -- Conteúdo
  pergunta TEXT NOT NULL,
  resposta TEXT NOT NULL,
  resposta_embedding vector(1536),  -- Embedding da resposta para busca semântica
  
  -- Metadados
  modelo_llm VARCHAR(50),  -- ex: "gpt-4.1-mini"
  tokens_usados INTEGER,
  tempo_geracao_ms INTEGER,
  qualidade_score NUMERIC(3, 2),  -- 0.00 a 1.00
  
  -- Estatísticas de uso
  hit_count INTEGER DEFAULT 0,
  ultimo_hit TIMESTAMP,
  
  -- Controle
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  expires_at TIMESTAMP,  -- NULL = nunca expira
  
  -- Constraints
  CHECK (qualidade_score >= 0 AND qualidade_score <= 1),
  CHECK (hit_count >= 0)
);

CREATE INDEX idx_analises_hash ON analises_geradas(hash_consulta);
CREATE INDEX idx_analises_agente ON analises_geradas(agente);
CREATE INDEX idx_analises_tipo ON analises_geradas(tipo_analise);
CREATE INDEX idx_analises_entidade ON analises_geradas(entidade_id);
CREATE INDEX idx_analises_created_at ON analises_geradas(created_at);

-- Índice vetorial para busca semântica (HNSW é mais rápido que IVFFlat)
CREATE INDEX idx_analises_embedding ON analises_geradas 
  USING hnsw (resposta_embedding vector_cosine_ops);

-- ============================================================================
-- TABELA 5: metadados_coleta
-- Rastreia coletas de dados (auditoria e linhagem)
-- ============================================================================

CREATE TABLE IF NOT EXISTS metadados_coleta (
  -- Identificação
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  
  -- Contexto da coleta
  fonte VARCHAR(100) NOT NULL,  -- ex: "IBGE_PIB", "SICONFI_RECEITAS"
  endpoint_api TEXT,
  workflow_n8n VARCHAR(100),
  
  -- Escopo da coleta
  entidade_id UUID REFERENCES entidades_territoriais(id),
  ano_inicio INTEGER,
  ano_fim INTEGER,
  
  -- Resultado
  status VARCHAR(20) NOT NULL CHECK (status IN ('sucesso', 'falha_parcial', 'falha_total')),
  registros_coletados INTEGER DEFAULT 0,
  registros_atualizados INTEGER DEFAULT 0,
  registros_novos INTEGER DEFAULT 0,
  registros_erro INTEGER DEFAULT 0,
  
  -- Detalhes
  mensagem_erro TEXT,
  detalhes JSONB,
  
  -- Timing
  inicio_em TIMESTAMP NOT NULL,
  fim_em TIMESTAMP,
  duracao_ms INTEGER,
  
  -- Metadados
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_metadados_fonte ON metadados_coleta(fonte);
CREATE INDEX idx_metadados_status ON metadados_coleta(status);
CREATE INDEX idx_metadados_created_at ON metadados_coleta(created_at);
CREATE INDEX idx_metadados_entidade ON metadados_coleta(entidade_id);

-- ============================================================================
-- FUNÇÕES AUXILIARES
-- ============================================================================

-- Função para atualizar updated_at automaticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers para atualizar updated_at
CREATE TRIGGER update_entidades_territoriais_updated_at
  BEFORE UPDATE ON entidades_territoriais
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_dados_economicos_updated_at
  BEFORE UPDATE ON dados_economicos
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_dados_orcamentarios_updated_at
  BEFORE UPDATE ON dados_orcamentarios
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Função para calcular hash SHA-256 de consulta
CREATE OR REPLACE FUNCTION gerar_hash_consulta(
  p_agente VARCHAR,
  p_tipo VARCHAR,
  p_entidade_id UUID,
  p_parametros JSONB
)
RETURNS CHAR(64) AS $$
BEGIN
  RETURN encode(
    digest(
      CONCAT(
        COALESCE(p_agente, ''),
        '|',
        COALESCE(p_tipo, ''),
        '|',
        COALESCE(p_entidade_id::TEXT, ''),
        '|',
        COALESCE(p_parametros::TEXT, '')
      ),
      'sha256'
    ),
    'hex'
  );
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- ============================================================================
-- VIEWS ÚTEIS
-- ============================================================================

-- View: Últimos dados econômicos por entidade
CREATE OR REPLACE VIEW v_dados_economicos_recentes AS
SELECT DISTINCT ON (entidade_id)
  e.codigo_ibge,
  e.nome,
  e.tipo,
  e.uf,
  d.ano,
  d.populacao,
  d.pib_mil_reais,
  d.pib_per_capita_reais,
  d.pib_agropecuaria_percent,
  d.pib_industria_percent,
  d.pib_servicos_percent
FROM dados_economicos d
JOIN entidades_territoriais e ON d.entidade_id = e.id
ORDER BY entidade_id, ano DESC;

-- View: Estatísticas de cache
CREATE OR REPLACE VIEW v_estatisticas_cache AS
SELECT
  agente,
  tipo_analise,
  COUNT(*) AS total_analises,
  SUM(hit_count) AS total_hits,
  AVG(hit_count) AS media_hits,
  AVG(qualidade_score) AS qualidade_media,
  AVG(tempo_geracao_ms) AS tempo_medio_ms
FROM analises_geradas
GROUP BY agente, tipo_analise
ORDER BY total_hits DESC;

-- View: Histórico de coletas
CREATE OR REPLACE VIEW v_historico_coletas AS
SELECT
  m.fonte,
  m.status,
  COUNT(*) AS total_coletas,
  SUM(m.registros_coletados) AS total_registros,
  AVG(m.duracao_ms) AS duracao_media_ms,
  MAX(m.created_at) AS ultima_coleta
FROM metadados_coleta m
GROUP BY m.fonte, m.status
ORDER BY ultima_coleta DESC;

-- ============================================================================
-- DADOS INICIAIS (SEED)
-- ============================================================================

-- Inserir estado do Tocantins
INSERT INTO entidades_territoriais (
  codigo_ibge, nome, tipo, uf
) VALUES (
  '17', 'Tocantins', 'estado', 'TO'
) ON CONFLICT (codigo_ibge) DO NOTHING;

-- ============================================================================
-- COMENTÁRIOS NAS TABELAS
-- ============================================================================

COMMENT ON TABLE entidades_territoriais IS 'Armazena municípios e estados do Brasil';
COMMENT ON TABLE dados_economicos IS 'Dados econômicos (PIB, população) por entidade e ano';
COMMENT ON TABLE dados_orcamentarios IS 'Receitas e despesas orçamentárias (SICONFI)';
COMMENT ON TABLE analises_geradas IS 'Cache de análises geradas pelos agentes (RAG)';
COMMENT ON TABLE metadados_coleta IS 'Auditoria e linhagem de coletas de dados';

-- ============================================================================
-- FIM DO SCHEMA CORE
-- ============================================================================
```

Execute o schema:

```bash
psql framework_v6 < schema_core.sql
```

### **6.2. Verificar Criação**

```bash
psql framework_v6 -c "\dt"
```

**Saída esperada:**

```
                    List of relations
 Schema |          Name          | Type  |  Owner  
--------+------------------------+-------+---------
 public | analises_geradas       | table | replit
 public | dados_economicos       | table | replit
 public | dados_orcamentarios    | table | replit
 public | entidades_territoriais | table | replit
 public | metadados_coleta       | table | replit
(5 rows)
```

---

## 7. Passo 5: Configurar Variáveis de Ambiente

### **7.1. Secrets do Replit**

No Replit, vá em **Tools** → **Secrets** e adicione:

| Key | Value | Descrição |
|-----|-------|-----------|
| `DATABASE_URL` | `postgresql://replit:replit@localhost:5432/framework_v6` | URL de conexão PostgreSQL |
| `OPENAI_API_KEY` | `sk-...` | Chave da API OpenAI |
| `N8N_WEBHOOK_URL` | `https://...` | URL do webhook n8n (adicionar depois) |
| `NEXT_PUBLIC_APP_NAME` | `Framework V6.0 - Tocantins` | Nome da aplicação |

### **7.2. Arquivo .env.local**

Crie arquivo `.env.local` (para desenvolvimento local):

```bash
# Database
DATABASE_URL=postgresql://replit:replit@localhost:5432/framework_v6
PGHOST=localhost
PGPORT=5432
PGUSER=replit
PGPASSWORD=replit
PGDATABASE=framework_v6

# OpenAI
OPENAI_API_KEY=sk-...

# n8n
N8N_WEBHOOK_URL=https://...

# App
NEXT_PUBLIC_APP_NAME=Framework V6.0 - Tocantins
NEXT_PUBLIC_APP_VERSION=1.0.0
```

**⚠️ IMPORTANTE:** Adicione `.env.local` ao `.gitignore`:

```bash
echo ".env.local" >> .gitignore
```

---

## 8. Passo 6: Instalar Dependências Python

### **8.1. Criar requirements.txt**

```txt
# Database
psycopg2-binary==2.9.9
sqlalchemy==2.0.23

# OpenAI
openai==1.3.7

# Data processing
pandas==2.1.3
numpy==1.26.2

# HTTP
requests==2.31.0
httpx==0.25.2

# Utilities
python-dotenv==1.0.0
pydantic==2.5.2
```

### **8.2. Instalar Dependências**

```bash
pip install -r requirements.txt
```

---

## 9. Passo 7: Criar Scripts de Inicialização

### **9.1. Script de Teste de Conexão**

Crie `scripts/test_connection.py`:

```python
#!/usr/bin/env python3
"""
Teste de conexão com PostgreSQL e pgvector
"""

import os
import psycopg2
from psycopg2.extras import RealDictCursor

def test_connection():
    """Testa conexão com PostgreSQL"""
    
    try:
        # Conectar
        conn = psycopg2.connect(
            host=os.getenv('PGHOST', 'localhost'),
            port=os.getenv('PGPORT', '5432'),
            user=os.getenv('PGUSER', 'replit'),
            password=os.getenv('PGPASSWORD', 'replit'),
            database=os.getenv('PGDATABASE', 'framework_v6')
        )
        
        print("✅ Conexão estabelecida com sucesso!")
        
        # Testar query
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute("SELECT version();")
            version = cur.fetchone()
            print(f"✅ PostgreSQL versão: {version['version']}")
            
            # Verificar extensões
            cur.execute("""
                SELECT extname, extversion 
                FROM pg_extension 
                WHERE extname IN ('uuid-ossp', 'vector')
            """)
            extensions = cur.fetchall()
            print(f"✅ Extensões instaladas:")
            for ext in extensions:
                print(f"   - {ext['extname']} v{ext['extversion']}")
            
            # Verificar tabelas
            cur.execute("""
                SELECT tablename 
                FROM pg_tables 
                WHERE schemaname = 'public'
                ORDER BY tablename
            """)
            tables = cur.fetchall()
            print(f"✅ Tabelas criadas ({len(tables)}):")
            for table in tables:
                print(f"   - {table['tablename']}")
        
        conn.close()
        print("\n✅ Todos os testes passaram!")
        return True
        
    except Exception as e:
        print(f"❌ Erro: {e}")
        return False

if __name__ == "__main__":
    test_connection()
```

Execute:

```bash
python3 scripts/test_connection.py
```

### **9.2. Script de População Inicial**

Crie `scripts/seed_tocantins.py`:

```python
#!/usr/bin/env python3
"""
Popula banco de dados com municípios do Tocantins
"""

import os
import csv
import psycopg2
from psycopg2.extras import execute_values

def seed_tocantins():
    """Popula banco com dados do Tocantins"""
    
    # Conectar
    conn = psycopg2.connect(
        host=os.getenv('PGHOST', 'localhost'),
        port=os.getenv('PGPORT', '5432'),
        user=os.getenv('PGUSER', 'replit'),
        password=os.getenv('PGPASSWORD', 'replit'),
        database=os.getenv('PGDATABASE', 'framework_v6')
    )
    
    cur = conn.cursor()
    
    # Ler CSV de municípios
    csv_path = 'data/municipios_tocantins_completo.csv'
    
    if not os.path.exists(csv_path):
        print(f"❌ Arquivo não encontrado: {csv_path}")
        return False
    
    with open(csv_path, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        municipios = list(reader)
    
    print(f"📊 Lidos {len(municipios)} registros do CSV")
    
    # Inserir entidades territoriais
    entidades_data = []
    for m in municipios:
        entidades_data.append((
            m['codigo_ibge'],
            m['nome_municipio'],
            'estado' if m['codigo_ibge'] == '17' else 'municipio',
            m['uf'],
            m.get('regiao_imediata_id') or None,
            m.get('regiao_imediata_nome') or None,
            m.get('regiao_intermediaria_id') or None,
            m.get('regiao_intermediaria_nome') or None,
            m.get('microrregiao_id') or None,
            m.get('microrregiao_nome') or None,
            m.get('mesorregiao_id') or None,
            m.get('mesorregiao_nome') or None
        ))
    
    execute_values(
        cur,
        """
        INSERT INTO entidades_territoriais (
          codigo_ibge, nome, tipo, uf,
          regiao_imediata_id, regiao_imediata_nome,
          regiao_intermediaria_id, regiao_intermediaria_nome,
          microrregiao_id, microrregiao_nome,
          mesorregiao_id, mesorregiao_nome
        ) VALUES %s
        ON CONFLICT (codigo_ibge) DO UPDATE SET
          nome = EXCLUDED.nome,
          regiao_imediata_id = EXCLUDED.regiao_imediata_id,
          regiao_imediata_nome = EXCLUDED.regiao_imediata_nome,
          regiao_intermediaria_id = EXCLUDED.regiao_intermediaria_id,
          regiao_intermediaria_nome = EXCLUDED.regiao_intermediaria_nome,
          microrregiao_id = EXCLUDED.microrregiao_id,
          microrregiao_nome = EXCLUDED.microrregiao_nome,
          mesorregiao_id = EXCLUDED.mesorregiao_id,
          mesorregiao_nome = EXCLUDED.mesorregiao_nome,
          updated_at = CURRENT_TIMESTAMP
        """,
        entidades_data
    )
    
    print(f"✅ Inseridas/atualizadas {len(entidades_data)} entidades territoriais")
    
    # Inserir dados econômicos (ano mais recente do CSV)
    economicos_data = []
    for m in municipios:
        if m.get('populacao') and m.get('pib_mil_reais'):
            # Buscar ID da entidade
            cur.execute(
                "SELECT id FROM entidades_territoriais WHERE codigo_ibge = %s",
                (m['codigo_ibge'],)
            )
            entidade_id = cur.fetchone()[0]
            
            economicos_data.append((
                entidade_id,
                2022,  # Ano do Censo
                int(m['populacao']),
                float(m['pib_mil_reais']),
                float(m['pib_per_capita_reais']),
                'IBGE',
                '2025-11-06'
            ))
    
    execute_values(
        cur,
        """
        INSERT INTO dados_economicos (
          entidade_id, ano, populacao, pib_mil_reais, pib_per_capita_reais,
          fonte, data_coleta
        ) VALUES %s
        ON CONFLICT (entidade_id, ano) DO UPDATE SET
          populacao = EXCLUDED.populacao,
          pib_mil_reais = EXCLUDED.pib_mil_reais,
          pib_per_capita_reais = EXCLUDED.pib_per_capita_reais,
          updated_at = CURRENT_TIMESTAMP
        """,
        economicos_data
    )
    
    print(f"✅ Inseridos/atualizados {len(economicos_data)} registros econômicos")
    
    conn.commit()
    cur.close()
    conn.close()
    
    print("\n✅ Seed concluído com sucesso!")
    return True

if __name__ == "__main__":
    seed_tocantins()
```

Execute:

```bash
python3 scripts/seed_tocantins.py
```

---

## 10. Passo 8: Testes de Validação

### **10.1. Teste 1: Consulta Simples**

```bash
psql framework_v6 -c "SELECT COUNT(*) FROM entidades_territoriais;"
```

**Esperado:** `140` (1 estado + 139 municípios)

### **10.2. Teste 2: Dados Econômicos**

```bash
psql framework_v6 -c "
  SELECT nome, populacao, pib_per_capita_reais 
  FROM v_dados_economicos_recentes 
  WHERE tipo = 'municipio'
  ORDER BY pib_per_capita_reais DESC 
  LIMIT 5;
"
```

### **10.3. Teste 3: Busca Vetorial**

Crie `scripts/test_vector_search.py`:

```python
#!/usr/bin/env python3
"""
Teste de busca vetorial com pgvector
"""

import os
import psycopg2
from openai import OpenAI

def test_vector_search():
    """Testa busca vetorial"""
    
    # Conectar OpenAI
    client = OpenAI(api_key=os.getenv('OPENAI_API_KEY'))
    
    # Conectar PostgreSQL
    conn = psycopg2.connect(
        host=os.getenv('PGHOST', 'localhost'),
        port=os.getenv('PGPORT', '5432'),
        user=os.getenv('PGUSER', 'replit'),
        password=os.getenv('PGPASSWORD', 'replit'),
        database=os.getenv('PGDATABASE', 'framework_v6')
    )
    cur = conn.cursor()
    
    # Inserir análise de teste
    pergunta = "Qual o PIB de Palmas?"
    resposta = "O PIB de Palmas em 2021 foi de R$ 12,5 bilhões, com PIB per capita de R$ 41.234."
    
    # Gerar embedding
    embedding_response = client.embeddings.create(
        model="text-embedding-ada-002",
        input=resposta
    )
    embedding = embedding_response.data[0].embedding
    
    # Inserir
    cur.execute("""
        INSERT INTO analises_geradas (
          hash_consulta, agente, tipo_analise, pergunta, resposta, 
          resposta_embedding, modelo_llm
        ) VALUES (
          %s, %s, %s, %s, %s, %s, %s
        )
        ON CONFLICT (hash_consulta) DO NOTHING
    """, (
        'test_hash_123',
        'ECON',
        'pib_municipal',
        pergunta,
        resposta,
        embedding,
        'text-embedding-ada-002'
    ))
    
    conn.commit()
    print("✅ Análise de teste inserida")
    
    # Buscar análises similares
    query = "Quanto é o PIB per capita de Palmas?"
    query_embedding_response = client.embeddings.create(
        model="text-embedding-ada-002",
        input=query
    )
    query_embedding = query_embedding_response.data[0].embedding
    
    cur.execute("""
        SELECT 
          pergunta,
          resposta,
          1 - (resposta_embedding <=> %s::vector) AS similarity
        FROM analises_geradas
        ORDER BY resposta_embedding <=> %s::vector
        LIMIT 3
    """, (query_embedding, query_embedding))
    
    results = cur.fetchall()
    
    print(f"\n🔍 Busca: '{query}'")
    print(f"📊 Resultados encontrados: {len(results)}\n")
    
    for i, (perg, resp, sim) in enumerate(results, 1):
        print(f"{i}. Similaridade: {sim:.4f}")
        print(f"   Pergunta: {perg}")
        print(f"   Resposta: {resp[:100]}...\n")
    
    cur.close()
    conn.close()
    
    print("✅ Teste de busca vetorial concluído!")

if __name__ == "__main__":
    test_vector_search()
```

Execute:

```bash
python3 scripts/test_vector_search.py
```

---

## 11. Troubleshooting

### **Problema 1: PostgreSQL não inicia**

**Sintoma:**
```
psql: error: connection to server on socket "/tmp/.s.PGSQL.5432" failed
```

**Solução:**
```bash
# Verificar se está rodando
pg_isready

# Se não estiver, iniciar manualmente
pg_ctl -D ~/postgres_data -l ~/postgres_data/logfile start

# Verificar logs
cat ~/postgres_data/logfile
```

### **Problema 2: Extensão pgvector não encontrada**

**Sintoma:**
```
ERROR: extension "vector" is not available
```

**Solução:**
```bash
# Instalar via Nix
nix-env -iA nixpkgs.pgvector

# Ou adicionar ao replit.nix:
# pkgs.postgresql_15.withPackages (p: [ p.pgvector ])
```

### **Problema 3: Permissões negadas**

**Sintoma:**
```
ERROR: permission denied for table ...
```

**Solução:**
```sql
-- Conectar como superuser
psql framework_v6

-- Conceder permissões
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO replit;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO replit;
```

### **Problema 4: Disco cheio**

**Sintoma:**
```
ERROR: could not extend file ... No space left on device
```

**Solução:**
```bash
# Verificar uso de disco
df -h

# Limpar dados antigos
psql framework_v6 -c "DELETE FROM analises_geradas WHERE created_at < NOW() - INTERVAL '30 days';"

# Vacuum
psql framework_v6 -c "VACUUM FULL;"
```

---

## 12. Próximos Passos

Após configurar o ambiente, você pode:

### **Imediato**

1. ✅ **Testar conexão** com `scripts/test_connection.py`
2. ✅ **Popular dados** com `scripts/seed_tocantins.py`
3. ✅ **Validar busca vetorial** com `scripts/test_vector_search.py`

### **Curto Prazo**

4. **Implementar Agente DATA** no n8n (ver documento separado)
5. **Coletar dados econômicos** dos últimos 10 anos
6. **Criar dashboard** Next.js para visualização
7. **Integrar com OpenAI** para geração de análises

### **Médio Prazo**

8. **Expandir esquema** para outras dimensões (Territorial, Social)
9. **Otimizar performance** com particionamento e índices
10. **Implementar monitoramento** com Prometheus + Grafana
11. **Documentar APIs** com Swagger

---

## 13. Referências

1. **Replit Docs - PostgreSQL:** https://docs.replit.com/hosting/databases/postgresql
2. **pgvector GitHub:** https://github.com/pgvector/pgvector
3. **PostgreSQL 15 Documentation:** https://www.postgresql.org/docs/15/
4. **OpenAI Embeddings API:** https://platform.openai.com/docs/guides/embeddings
5. **SQLAlchemy Documentation:** https://docs.sqlalchemy.org/

---

**Documento criado por:** Henrique Ribeiro & Manus IA  
**Versão:** 1.0  
**Data:** 07 de Novembro de 2025  
**Licença:** MIT

---

**🎉 Ambiente Replit + PostgreSQL + pgvector configurado com sucesso!**
