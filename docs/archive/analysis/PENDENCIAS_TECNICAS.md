# Pendências Técnicas - Framework V6.0

**Última atualização:** 2025-12-06 (Sessão #12)  
**Status:** 🟡 Pendências Ativas

---

## 🎯 Visão Geral

Este documento registra pendências técnicas identificadas durante o desenvolvimento do Framework de Inteligência Territorial V6.0. Cada pendência está categorizada por prioridade, impacto e esforço estimado.

---

## 🔴 PRIORIDADE ALTA

### 1. Implementação de Geração de Embeddings Vetoriais

**Status:** 🟡 PENDENTE  
**Sessão de Identificação:** #12  
**Data:** 2025-12-06

#### Contexto

Para viabilizar o MVP, os campos `embedding` e `embedding_vector` foram tornados **NULLABLE** nas seguintes tabelas:

- `knowledge_base.embedding` (TEXT)
- `agent_econ_memory.embedding_vector` (VECTOR(1536))
- `agent_social_memory.embedding_vector` (VECTOR(1536))
- `agent_terra_memory.embedding_vector` (VECTOR(1536))
- `agent_ambient_memory.embedding_vector` (VECTOR(1536))

**SQL Executado:**
```sql
ALTER TABLE knowledge_base ALTER COLUMN embedding DROP NOT NULL;
ALTER TABLE agent_econ_memory ALTER COLUMN embedding_vector DROP NOT NULL;
ALTER TABLE agent_social_memory ALTER COLUMN embedding_vector DROP NOT NULL;
ALTER TABLE agent_terra_memory ALTER COLUMN embedding_vector DROP NOT NULL;
ALTER TABLE agent_ambient_memory ALTER COLUMN embedding_vector DROP NOT NULL;
```

#### Problema

Atualmente, análises são salvas **sem embeddings vetoriais**, o que impede:

1. **Busca semântica** - Não é possível encontrar análises por similaridade de significado
2. **RAG (Retrieval-Augmented Generation)** - Agentes não conseguem consultar memória por contexto semântico
3. **Recomendações inteligentes** - Sistema não pode sugerir análises relacionadas
4. **Clustering de análises** - Impossível agrupar análises similares automaticamente

#### Solução Proposta

**Abordagem:** Processo batch assíncrono para geração de embeddings

**Vantagens:**
- ✅ Não bloqueia resposta ao usuário
- ✅ Resiliente a falhas da API OpenAI
- ✅ Escalável para milhares de análises
- ✅ Permite otimizações (rate limiting, batching)

**Implementação:**

##### Fase 1: Script de Geração de Embeddings

```python
# scripts/generate_embeddings_batch.py
import psycopg2
from openai import OpenAI
import os
from datetime import datetime

# Configuração
DATABASE_URL = os.getenv("DATABASE_URL")
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
BATCH_SIZE = 100
EMBEDDING_MODEL = "text-embedding-3-small"

client = OpenAI(api_key=OPENAI_API_KEY)

def generate_embeddings_knowledge_base():
    """Gera embeddings para knowledge_base"""
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    
    # Buscar análises sem embedding (últimas 24h)
    cur.execute("""
        SELECT id, content 
        FROM knowledge_base 
        WHERE embedding IS NULL 
        AND created_at > NOW() - INTERVAL '24 hours'
        LIMIT %s
    """, (BATCH_SIZE,))
    
    count = 0
    for row in cur.fetchall():
        analysis_id, content = row
        
        try:
            # Gerar embedding
            response = client.embeddings.create(
                model=EMBEDDING_MODEL,
                input=content[:8000]  # Limite de tokens
            )
            embedding_vector = response.data[0].embedding
            
            # Atualizar registro
            cur.execute("""
                UPDATE knowledge_base 
                SET 
                    embedding = %s,
                    embedding_vector = %s,
                    updated_at = NOW()
                WHERE id = %s
            """, (str(embedding_vector), embedding_vector, analysis_id))
            
            count += 1
            print(f"✅ Embedding gerado para análise {analysis_id}")
            
        except Exception as e:
            print(f"❌ Erro ao gerar embedding para {analysis_id}: {e}")
            continue
    
    conn.commit()
    cur.close()
    conn.close()
    
    print(f"🎉 {count} embeddings gerados na knowledge_base!")
    return count

def generate_embeddings_agent_memory(agent_name):
    """Gera embeddings para memória de um agente específico"""
    table_name = f"agent_{agent_name}_memory"
    
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    
    # Buscar análises sem embedding
    cur.execute(f"""
        SELECT id, analysis_content 
        FROM {table_name}
        WHERE embedding_vector IS NULL 
        AND created_at > NOW() - INTERVAL '24 hours'
        LIMIT %s
    """, (BATCH_SIZE,))
    
    count = 0
    for row in cur.fetchall():
        analysis_id, content = row
        
        try:
            # Gerar embedding
            response = client.embeddings.create(
                model=EMBEDDING_MODEL,
                input=content[:8000]
            )
            embedding_vector = response.data[0].embedding
            
            # Atualizar registro
            cur.execute(f"""
                UPDATE {table_name}
                SET 
                    embedding_vector = %s,
                    updated_at = NOW()
                WHERE id = %s
            """, (embedding_vector, analysis_id))
            
            count += 1
            print(f"✅ Embedding gerado para {agent_name} - {analysis_id}")
            
        except Exception as e:
            print(f"❌ Erro ao gerar embedding para {analysis_id}: {e}")
            continue
    
    conn.commit()
    cur.close()
    conn.close()
    
    print(f"🎉 {count} embeddings gerados para {agent_name}!")
    return count

if __name__ == "__main__":
    print(f"🚀 Iniciando geração de embeddings - {datetime.now()}")
    
    # Gerar embeddings para knowledge_base
    kb_count = generate_embeddings_knowledge_base()
    
    # Gerar embeddings para cada agente
    agents = ["econ", "social", "terra", "ambient"]
    for agent in agents:
        agent_count = generate_embeddings_agent_memory(agent)
    
    print(f"✅ Processo concluído - {datetime.now()}")
```

##### Fase 2: Cron Job

```bash
# Adicionar ao crontab
# Executar a cada hora
0 * * * * cd /app && python scripts/generate_embeddings_batch.py >> /var/log/embeddings.log 2>&1
```

##### Fase 3: Monitoramento

```sql
-- Query para monitorar análises sem embeddings
SELECT 
    'knowledge_base' as table_name,
    COUNT(*) as total,
    COUNT(embedding) as with_embedding,
    COUNT(*) - COUNT(embedding) as missing_embedding,
    ROUND(100.0 * COUNT(embedding) / COUNT(*), 2) as percentage_complete
FROM knowledge_base
UNION ALL
SELECT 
    'agent_econ_memory',
    COUNT(*),
    COUNT(embedding_vector),
    COUNT(*) - COUNT(embedding_vector),
    ROUND(100.0 * COUNT(embedding_vector) / COUNT(*), 2)
FROM agent_econ_memory
UNION ALL
SELECT 
    'agent_social_memory',
    COUNT(*),
    COUNT(embedding_vector),
    COUNT(*) - COUNT(embedding_vector),
    ROUND(100.0 * COUNT(embedding_vector) / COUNT(*), 2)
FROM agent_social_memory
UNION ALL
SELECT 
    'agent_terra_memory',
    COUNT(*),
    COUNT(embedding_vector),
    COUNT(*) - COUNT(embedding_vector),
    ROUND(100.0 * COUNT(embedding_vector) / COUNT(*), 2)
FROM agent_terra_memory
UNION ALL
SELECT 
    'agent_ambient_memory',
    COUNT(*),
    COUNT(embedding_vector),
    COUNT(*) - COUNT(embedding_vector),
    ROUND(100.0 * COUNT(embedding_vector) / COUNT(*), 2)
FROM agent_ambient_memory;
```

#### Estimativa de Custo

**Modelo:** `text-embedding-3-small`  
**Custo:** $0.02 por 1 milhão de tokens  
**Tamanho médio de análise:** 2000 tokens  
**Custo por análise:** ~$0.00004

| Volume/Dia | Análises/Mês | Custo Embeddings/Mês |
|------------|--------------|----------------------|
| 10 | 300 | $0.012 |
| 100 | 3.000 | $0.12 |
| 1.000 | 30.000 | $1.20 |
| 10.000 | 300.000 | $12.00 |

**Conclusão:** Custo insignificante comparado ao custo de geração de análises (~$0.02 por análise).

#### Impacto

**Sem embeddings:**
- ❌ Busca apenas por filtros (território, dimensão, data)
- ❌ Agentes não aprendem com análises similares
- ❌ Sem recomendações contextuais

**Com embeddings:**
- ✅ Busca semântica ("Como está a economia?" encontra análises sobre PIB, emprego, renda)
- ✅ RAG funcional (agentes consultam memória por contexto)
- ✅ Recomendações inteligentes
- ✅ Clustering e análise de tendências

#### Esforço Estimado

- **Script Python:** 4 horas
- **Testes:** 2 horas
- **Configuração cron job:** 1 hora
- **Documentação:** 1 hora
- **Total:** 8 horas (1 dia de desenvolvimento)

#### Critérios de Aceitação

- [ ] Script Python gera embeddings para `knowledge_base`
- [ ] Script Python gera embeddings para memórias dos 4 agentes
- [ ] Cron job configurado para executar a cada hora
- [ ] Query de monitoramento retorna percentual de completude
- [ ] Documentação atualizada com instruções de uso
- [ ] Testes validam que busca semântica funciona

#### Referências

- [OpenAI Embeddings Guide](https://platform.openai.com/docs/guides/embeddings)
- [pgvector Documentation](https://github.com/pgvector/pgvector)
- [IMPLICACOES_EMBEDDINGS_KNOWLEDGE_BASE.md](../IMPLICACOES_EMBEDDINGS_KNOWLEDGE_BASE.md)

---

## 🟡 PRIORIDADE MÉDIA

### 2. Validação de Territory ID nos Workflows

**Status:** 🟡 PENDENTE  
**Sessão de Identificação:** #12  
**Data:** 2025-12-06

#### Contexto

Durante a Sessão #12, foram identificados **12 registros com territory_id sintético** na tabela `agent_econ_memory` (ex: `REF_0A618F1F`, `TO-PALMAS`, `REF_GENERAL`).

Todos foram deletados, mas isso indica falta de validação nos workflows.

#### Problema

Workflows podem aceitar `territory_id` inválidos, causando:

1. Dados órfãos (sem referência na tabela `territories`)
2. Análises impossíveis de localizar geograficamente
3. Inconsistência nos dashboards
4. Falhas em queries que fazem JOIN com `territories`

#### Solução Proposta

**Fase 1: Adicionar validação no nó "Normalizar Entrada"**

```javascript
// Validar territory_id (código IBGE de 7 dígitos)
const territoryId = $json.territory_id;

if (!territoryId || !/^[0-9]{7}$/.test(territoryId)) {
  throw new Error(`Territory ID inválido: ${territoryId}. Deve ser código IBGE de 7 dígitos.`);
}

// Verificar se existe na tabela territories (opcional)
// Requer nó PostgreSQL adicional
```

**Fase 2: Adicionar Foreign Key Constraint**

```sql
-- Adicionar constraint em agent_econ_memory
ALTER TABLE agent_econ_memory
ADD CONSTRAINT fk_agent_econ_memory_territory
FOREIGN KEY (territory_id) REFERENCES territories(id);

-- Repetir para outras tabelas
ALTER TABLE agent_social_memory
ADD CONSTRAINT fk_agent_social_memory_territory
FOREIGN KEY (territory_id) REFERENCES territories(id);

ALTER TABLE agent_terra_memory
ADD CONSTRAINT fk_agent_terra_memory_territory
FOREIGN KEY (territory_id) REFERENCES territories(id);

ALTER TABLE agent_ambient_memory
ADD CONSTRAINT fk_agent_ambient_memory_territory
FOREIGN KEY (territory_id) REFERENCES territories(id);
```

#### Esforço Estimado

- **Validação em workflows:** 2 horas
- **Foreign key constraints:** 1 hora
- **Testes:** 2 horas
- **Total:** 5 horas

---

## 🟢 PRIORIDADE BAIXA

### 3. Otimização de Índices Vetoriais

**Status:** 🟢 FUTURO  
**Sessão de Identificação:** #12

#### Contexto

Índices vetoriais IVFFlat estão configurados com `lists=100` (padrão).

Para grandes volumes (>100k análises), pode ser necessário ajustar.

#### Solução Proposta

```sql
-- Recriar índice com mais listas para melhor performance
DROP INDEX idx_econ_memory_embedding;
CREATE INDEX idx_econ_memory_embedding 
ON agent_econ_memory 
USING ivfflat (embedding_vector vector_cosine_ops) 
WITH (lists = 1000);
```

**Regra geral:** `lists = sqrt(total_rows)`

#### Esforço Estimado

- **Análise de performance:** 2 horas
- **Ajuste de índices:** 1 hora
- **Testes:** 2 horas
- **Total:** 5 horas

---

## 📋 Template para Novas Pendências

```markdown
### X. Título da Pendência

**Status:** 🔴 CRÍTICO / 🟡 PENDENTE / 🟢 FUTURO / ✅ RESOLVIDO  
**Sessão de Identificação:** #XX  
**Data:** YYYY-MM-DD

#### Contexto
[Descrever o contexto que levou à identificação da pendência]

#### Problema
[Descrever o problema técnico]

#### Solução Proposta
[Descrever a solução técnica com código/SQL quando aplicável]

#### Esforço Estimado
- **Desenvolvimento:** X horas
- **Testes:** X horas
- **Total:** X horas

#### Critérios de Aceitação
- [ ] Critério 1
- [ ] Critério 2
```

---

## 📊 Resumo de Pendências

| ID | Título | Prioridade | Esforço | Status |
|----|--------|------------|---------|--------|
| 1 | Implementação de Geração de Embeddings | 🔴 ALTA | 8h | 🟡 PENDENTE |
| 2 | Validação de Territory ID | 🟡 MÉDIA | 5h | 🟡 PENDENTE |
| 3 | Otimização de Índices Vetoriais | 🟢 BAIXA | 5h | 🟢 FUTURO |

**Total de esforço estimado:** 18 horas (~2-3 dias de desenvolvimento)

---

**Última atualização:** 2025-12-06 (Sessão #12)  
**Responsável:** Equipe de Desenvolvimento Framework V6.0
