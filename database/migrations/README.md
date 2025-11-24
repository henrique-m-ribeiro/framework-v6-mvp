# Migrations do Banco de Dados

Esta pasta contém os scripts SQL para criar e atualizar a estrutura do banco de dados do Framework de Inteligência Territorial V6.0.

## Como Executar

No Shell do Replit, execute os scripts em ordem:

```bash
# 1. Criar tabelas iniciais (territories, indicators, etc.)
psql $DATABASE_URL -f 001_initial_schema.sql

# 2. Criar tabela de metadados
psql $DATABASE_URL -f 002_create_metadata_table.sql

# 3. Criar tabela knowledge_base (com suporte a vetores)
psql $DATABASE_URL -f 003_create_knowledge_base.sql
```

## Importante: Extensão `pgvector`

O script `003_create_knowledge_base.sql` requer a extensão `pgvector` para funcionar. No Replit, você pode habilitá-la da seguinte forma:

1.  Vá para a seção **"PostgreSQL"** no menu lateral.
2.  Clique no ícone de três pontos (…).
3.  Selecione **"Extensions"**.
4.  Procure por `vector` e habilite-a.

Se a extensão não estiver habilitada, a criação da tabela `knowledge_base` falhará.
