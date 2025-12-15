# Documentação do Schema Completo das 40 Tabelas PostgreSQL

**Framework de Interação Galáctica V6.0**  
**Versão:** 1.0  
**Data:** 07 de Novembro de 2025  
**Autores:** Henrique Ribeiro & Manus IA

---

## 1. Visão Geral

Este documento detalha o schema SQL completo das **40 tabelas** do Framework V6.0, implementando a **Camada 1 (Armazenamento)** da arquitetura RAG integrada.

### **Características Principais**

| Característica | Detalhes |
|----------------|----------|
| **SGBD** | PostgreSQL 14+ |
| **Extensões** | PostGIS 3.3+ (geoespacial), pgvector 0.5+ (embeddings) |
| **Tabelas** | 40 (1 core + 16 econômicas + 8 sociais + 7 territoriais + 8 ambientais + 1 RAG) |
| **Campos** | ~600 campos totais |
| **Índices** | ~120 índices (B-tree, GiST, GIN, IVFFlat) |
| **Views** | 4 views úteis |
| **Funções** | 3 funções auxiliares |
| **Triggers** | 2 triggers automáticos |
| **Volume Estimado** | ~3,5 GB (10 anos de dados, 140 entidades) |

---

## 2. Estrutura Geral

### **2.1. Tabela Core**

**entidades_territoriais** - Tabela de referência com municípios do Tocantins e estado (140 registros).

Todos os dados das 4 dimensões referenciam esta tabela via `codigo_ibge` (chave estrangeira).

### **2.2. Dimensões**

| Dimensão | Tabelas | Campos | Volume (10 anos) | Principais Fontes |
|----------|---------|--------|------------------|-------------------|
| **Econômica** | 16 | ~250 | ~500 MB | IBGE, SICONFI, MTE, BCB |
| **Social** | 8 | ~150 | ~300 MB | INEP, DataSUS, MDS, SSP |
| **Territorial** | 7 | ~100 | ~2 GB | DNIT, ANATEL, ANA, MapBiomas |
| **Ambiental** | 8 | ~120 | ~750 MB | INPE, ANA, INMET, SEEG |
| **RAG** | 1 | ~15 | ~10 MB | Análises geradas |
| **TOTAL** | **40** | **~635** | **~3,5 GB** | **40 fontes** |

---

## 3. Detalhamento das Tabelas

### **3.1. Dimensão Econômica (16 tabelas)**

#### **1. dados_economicos**

**Descrição:** PIB municipal e estadual com composição setorial (série histórica 10 anos).

**Campos principais:**
- `pib_mil_reais` - PIB em milhares de reais correntes
- `pib_per_capita_reais` - PIB per capita
- `va_agropecuaria_mil_reais`, `va_industria_mil_reais`, `va_servicos_mil_reais` - Valor adicionado por setor
- `participacao_agropecuaria`, `participacao_industria`, `participacao_servicos` - % de cada setor no PIB

**Volume:** 140 entidades × 10 anos = 1.400 registros  
**Fonte:** IBGE - PIB dos Municípios  
**Atualização:** Anual (dezembro do ano seguinte)

**Índices:**
- `idx_economicos_codigo_ano` - Busca por município e ano
- `idx_economicos_pib` - Ordenação por PIB

#### **2. dados_orcamentarios**

**Descrição:** Receitas e despesas orçamentárias detalhadas (mensal e anual).

**Campos principais:**
- **Receitas:** `receitas_correntes_reais`, `receita_tributaria_reais`, `transferencias_correntes_reais`
- **Despesas por função:** `despesa_educacao_reais`, `despesa_saude_reais`, `despesa_assistencia_social_reais`
- **Despesas por categoria:** `despesas_pessoal_reais`, `despesas_investimentos_reais`
- **Resultado:** `resultado_primario_reais`, `resultado_nominal_reais`

**Volume:** 140 entidades × 10 anos × 12 meses = 16.800 registros  
**Fonte:** SICONFI (Tesouro Nacional)  
**Atualização:** Mensal

**Índices:**
- `idx_orcamentarios_codigo_ano` - Busca por município, ano e mês
- `idx_orcamentarios_receitas`, `idx_orcamentarios_despesas` - Ordenação por valores

#### **3-16. Outras Tabelas Econômicas**

| Tabela | Descrição | Volume | Fonte |
|--------|-----------|--------|-------|
| **empresas_ativas** | Empresas por setor CNAE e porte | 140.000 | IBGE-CEMPRE |
| **emprego_formal** | Vínculos RAIS/CAGED por setor | 28.000 | MTE |
| **producao_agricola** | PAM (soja, milho, arroz, etc.) | 28.000 | IBGE-PAM |
| **producao_pecuaria** | PPM (bovinos, suínos, leite, etc.) | 14.000 | IBGE-PPM |
| **extracao_mineral** | Produção mineral por substância | 1.400 | ANM |
| **transferencias_intergovernamentais** | FPM, ICMS, IPVA, etc. | 16.800 | SICONFI |
| **indicadores_fiscais** | Dependência FPM, autonomia, endividamento | 1.400 | SICONFI |
| **balanca_comercial** | Exportações e importações | 1.400 | MDIC |
| **credito_rural** | Contratos SICOR | 14.000 | BCB |
| **investimentos_publicos** | Obras e projetos | 2.800 | SICONFI |
| **precificacao_produtos** | Preços de commodities | 28.000 | CONAB |
| **indices_economicos** | IPCA, Selic, câmbio | 3.650 | BCB |
| **metadados_coleta_economica** | Logs de coleta | 1.000 | - |

---

### **3.2. Dimensão Social (8 tabelas)**

#### **16. dados_educacao**

**Descrição:** Indicadores educacionais (matrículas, IDEB, infraestrutura).

**Campos principais:**
- **Matrículas:** `matriculas_creche`, `matriculas_fundamental_anos_iniciais`, `matriculas_ensino_medio`
- **IDEB:** `ideb_anos_iniciais`, `ideb_anos_finais`, `ideb_ensino_medio`
- **Infraestrutura:** `escolas_com_internet`, `escolas_com_biblioteca`
- **Docentes:** `docentes_total`, `docentes_com_superior`

**Volume:** 140 entidades × 10 anos = 1.400 registros  
**Fonte:** INEP  
**Atualização:** Anual

#### **17. dados_saude**

**Descrição:** Indicadores de saúde (infraestrutura, profissionais, cobertura).

**Campos principais:**
- **Infraestrutura:** `leitos_sus`, `leitos_por_1000_hab`
- **Profissionais:** `medicos`, `medicos_por_1000_hab`
- **Cobertura:** `cobertura_esf`, `cobertura_saude_bucal`
- **Mortalidade:** `taxa_mortalidade_infantil`, `taxa_mortalidade_materna`

**Volume:** 140 entidades × 10 anos = 1.400 registros  
**Fonte:** DataSUS  
**Atualização:** Anual

#### **18-23. Outras Tabelas Sociais**

| Tabela | Descrição | Volume | Fonte |
|--------|-----------|--------|-------|
| **dados_assistencia_social** | Bolsa Família, CadÚnico, CRAS/CREAS | 16.800 | MDS |
| **dados_seguranca** | Criminalidade, efetivo policial | 16.800 | SSP-TO |
| **dados_habitacao** | Déficit habitacional, saneamento | 1.400 | IBGE-PNAD |
| **dados_trabalho_renda** | Desemprego, informalidade, renda | 1.400 | IBGE-PNAD |
| **indicadores_desenvolvimento_humano** | IDH, Gini, pobreza | 1.400 | PNUD |
| **dados_demograficos** | Pirâmide etária, migração | 1.400 | IBGE |

---

### **3.3. Dimensão Territorial (7 tabelas)**

#### **24. infraestrutura_transporte**

**Descrição:** Infraestrutura de transporte (rodovias, ferrovias, etc.) com geometrias.

**Campos principais:**
- `tipo` - 'Rodovia', 'Ferrovia', 'Hidrovia', 'Aeroporto', 'Porto'
- `extensao_km` - Extensão em quilômetros
- `condicao` - 'Pavimentada', 'Não Pavimentada', 'Em Obras'
- `geom` - Geometria LINESTRING (PostGIS)

**Volume:** ~5.000 registros (vias)  
**Fonte:** DNIT  
**Atualização:** Anual

**Índices espaciais:**
- `idx_infra_transporte_geom` - Índice GiST para consultas espaciais

#### **25-30. Outras Tabelas Territoriais**

| Tabela | Descrição | Volume | Fonte | Geometria |
|--------|-----------|--------|-------|-----------|
| **conectividade_digital** | Cobertura 4G, fibra, velocidade | 1.400 | ANATEL | Não |
| **energia** | Consumo por setor, acesso | 1.400 | EPE | Não |
| **recursos_hidricos** | Bacias, disponibilidade hídrica | ~50 | ANA | MULTIPOLYGON |
| **uso_cobertura_solo** | MapBiomas (classes de uso) | 151.200 | MapBiomas | Não |
| **areas_protegidas** | UCs, TIs, APPs | ~500 | MMA | MULTIPOLYGON |
| **riscos_vulnerabilidades** | Queimadas, inundações, secas | ~1.000 | Diversos | MULTIPOLYGON |

---

### **3.4. Dimensão Ambiental (8 tabelas)**

#### **31. focos_calor**

**Descrição:** Focos de calor detectados por satélite (INPE).

**Campos principais:**
- `data_hora` - Data e hora da detecção
- `latitude`, `longitude` - Coordenadas geográficas
- `satelite` - Satélite que detectou (AQUA, TERRA, NPP, NOAA-20)
- `frp` - Fire Radiative Power (MW)
- `risco_fogo` - 'Mínimo', 'Baixo', 'Médio', 'Alto', 'Crítico'
- `geom` - Geometria POINT (PostGIS)

**Volume:** ~75.000 registros (10 anos, ~7.500 focos/ano no Tocantins)  
**Fonte:** INPE - BDQueimadas  
**Atualização:** 3 horas

**Índices:**
- `idx_focos_calor_data` - Busca por data
- `idx_focos_calor_geom` - Consultas espaciais

#### **32-39. Outras Tabelas Ambientais**

| Tabela | Descrição | Volume | Fonte | Geometria |
|--------|-----------|--------|-------|-----------|
| **dados_meteorologicos** | Temperatura, precipitação, umidade | 54.750 | INMET | Não |
| **dados_hidrologicos** | Vazão, cota, precipitação | 182.500 | ANA | Não |
| **qualidade_agua** | pH, OD, DBO, coliformes, IQA | 400 | ANA-RNQA | Não |
| **uso_solo_anual** | MapBiomas (estatísticas anuais) | 151.200 | MapBiomas | Não |
| **desmatamento_prodes** | Polígonos de desmatamento | 30.000 | INPE-PRODES | MULTIPOLYGON |
| **alertas_deter** | Alertas em tempo real | 75.000 | INPE-DETER | MULTIPOLYGON |
| **dados_saneamento** | Água, esgoto, resíduos | 1.400 | SNIS | Não |
| **emissoes_gee** | Emissões por setor | 7.000 | SEEG | Não |

---

### **3.5. Tabela RAG (1 tabela)**

#### **40. analises_geradas**

**Descrição:** Análises geradas pelos agentes (base de conhecimento RAG).

**Campos principais:**
- `tipo_analise` - 'territorial', 'economica', 'social', 'ambiental', 'integrada'
- `titulo` - Título da análise
- `conteudo` - Texto completo da análise
- `embedding` - Vetor de 1536 dimensões (OpenAI text-embedding-3-small)
- `metadados` - JSONB com informações sobre geração (agente, modelo, custo, fontes, tags)
- `versao` - Versionamento de análises
- `validada` - Flag de validação

**Volume:** ~10.000 registros (estimativa)  
**Fonte:** Agentes INTERACT, TERRA, ECON, SOCIAL, AMBIENTAL  
**Atualização:** Contínua

**Índices:**
- `idx_analises_embedding` - Índice IVFFlat para busca vetorial (pgvector)
- `idx_analises_metadados` - Índice GIN para busca em JSONB
- `idx_analises_fulltext` - Índice GIN para busca full-text em português

**Estrutura de metadados (JSONB):**

```json
{
  "agente": "ECON",
  "prompt": "Analise a evolução do PIB de Palmas entre 2018-2022",
  "modelo": "gpt-4o",
  "tokens": 1500,
  "custo_usd": 0.015,
  "fontes_dados": ["dados_economicos", "dados_orcamentarios"],
  "periodo_analise": "2018-2022",
  "tags": ["pib", "crescimento", "agropecuaria", "palmas"]
}
```

---

## 4. Índices e Otimização

### **4.1. Tipos de Índices**

| Tipo | Uso | Tabelas | Quantidade |
|------|-----|---------|------------|
| **B-tree** | Busca por igualdade e range (padrão) | Todas | ~80 |
| **GiST** | Consultas espaciais (PostGIS) | Territoriais, Ambientais | ~15 |
| **GIN** | Busca em JSONB e full-text | analises_geradas | ~2 |
| **IVFFlat** | Busca vetorial (pgvector) | analises_geradas | ~1 |
| **BRIN** | Dados ordenados temporalmente (opcional) | - | ~0 |

### **4.2. Estratégias de Otimização**

**Para consultas temporais:**
- Índices compostos `(codigo_ibge, ano DESC)` ou `(codigo_ibge, ano DESC, mes DESC)`
- Particionamento por ano (opcional para tabelas > 1M registros)

**Para consultas espaciais:**
- Índices GiST em colunas `geom`
- Uso de `ST_DWithin`, `ST_Intersects`, `ST_Contains` otimizados

**Para busca vetorial:**
- Índice IVFFlat com `lists = 100` (ajustar baseado no volume)
- Busca por similaridade coseno (`<=>` operator)

**Para busca em metadados:**
- Índice GIN em coluna `metadados` (JSONB)
- Uso de operadores `@>`, `?`, `?&`, `?|`

---

## 5. Views Úteis

### **5.1. vw_resumo_economico**

Resumo econômico por município (último ano disponível).

**Campos:** código, nome, população, ano, PIB, PIB per capita, composição setorial, dependência FPM, autonomia fiscal.

**Uso:** Dashboards, relatórios executivos.

### **5.2. vw_resumo_social**

Resumo social por município (último ano disponível).

**Campos:** código, nome, população, IDEB, leitos/1000 hab, cobertura ESF, IDH, Gini, taxa de pobreza.

**Uso:** Análises de desenvolvimento social.

### **5.3. vw_resumo_ambiental**

Resumo ambiental por município (último ano disponível).

**Campos:** código, nome, área, focos de calor (último ano), desmatamento, cobertura de esgoto, emissões GEE.

**Uso:** Monitoramento ambiental.

### **5.4. vw_dashboard_integrado**

Dashboard integrado com todas as 4 dimensões.

**Campos:** Combinação de vw_resumo_economico, vw_resumo_social, vw_resumo_ambiental.

**Uso:** Visão holística de cada município.

---

## 6. Funções Auxiliares

### **6.1. buscar_analises_similares()**

**Descrição:** Busca análises similares usando distância coseno de embeddings.

**Parâmetros:**
- `query_embedding` - Vetor de 1536 dimensões
- `limite` - Número de resultados (padrão: 5)
- `tipo_filtro` - Filtrar por tipo de análise (opcional)

**Retorno:** Tabela com id, título, tipo, código IBGE, similarity.

**Exemplo de uso:**

```sql
-- Buscar 5 análises econômicas similares
SELECT * FROM buscar_analises_similares(
    '[0.1, 0.2, ..., 0.9]'::VECTOR(1536),
    5,
    'economica'
);
```

### **6.2. calcular_crescimento_pib()**

**Descrição:** Calcula taxa de crescimento percentual do PIB entre dois anos.

**Parâmetros:**
- `p_codigo_ibge` - Código IBGE do município
- `p_ano_inicial` - Ano inicial
- `p_ano_final` - Ano final

**Retorno:** Taxa de crescimento percentual (NUMERIC).

**Exemplo de uso:**

```sql
-- Crescimento do PIB de Palmas entre 2018 e 2022
SELECT calcular_crescimento_pib('1721000', 2018, 2022);
```

### **6.3. atualizar_timestamp()**

**Descrição:** Trigger function para atualizar automaticamente `data_atualizacao`.

**Uso:** Aplicado automaticamente em `entidades_territoriais` e `analises_geradas`.

---

## 7. Triggers Automáticos

### **7.1. trigger_atualizar_entidades**

**Tabela:** entidades_territoriais  
**Evento:** BEFORE UPDATE  
**Ação:** Atualiza `data_atualizacao` para CURRENT_TIMESTAMP

### **7.2. trigger_atualizar_analises**

**Tabela:** analises_geradas  
**Evento:** BEFORE UPDATE  
**Ação:** Atualiza `data_atualizacao` para CURRENT_TIMESTAMP

---

## 8. Estimativa de Volume

### **8.1. Por Dimensão**

| Dimensão | Registros | Tamanho Médio/Registro | Volume Total |
|----------|-----------|------------------------|--------------|
| Econômica | ~500.000 | ~1 KB | ~500 MB |
| Social | ~50.000 | ~2 KB | ~100 MB |
| Territorial | ~160.000 | ~5 KB | ~800 MB |
| Ambiental | ~400.000 | ~2 KB | ~800 MB |
| RAG | ~10.000 | ~10 KB | ~100 MB |
| **TOTAL** | **~1.120.000** | **-** | **~2,3 GB** |

**Nota:** Estimativa conservadora. Volume real pode variar baseado em:
- Geometrias (PostGIS): Polígonos complexos podem ocupar 10-100 KB cada
- Embeddings (pgvector): 1536 dimensões × 4 bytes = 6 KB por análise
- Índices: Adicionam ~30-50% ao volume total

### **8.2. Crescimento Anual**

| Dimensão | Crescimento/Ano | Observação |
|----------|-----------------|------------|
| Econômica | ~50 MB | Dados anuais e mensais |
| Social | ~10 MB | Dados anuais |
| Territorial | ~80 MB | Dados geoespaciais anuais |
| Ambiental | ~80 MB | Dados diários (focos, alertas) |
| RAG | ~50 MB | Análises geradas continuamente |
| **TOTAL** | **~270 MB/ano** | - |

**Projeção 5 anos:** ~2,3 GB (inicial) + 5 × 270 MB = **~3,6 GB**

---

## 9. Requisitos Técnicos

### **9.1. Servidor PostgreSQL**

| Requisito | Mínimo | Recomendado |
|-----------|--------|-------------|
| **PostgreSQL** | 14.0 | 15.0+ |
| **PostGIS** | 3.2 | 3.3+ |
| **pgvector** | 0.4.0 | 0.5.0+ |
| **RAM** | 4 GB | 8 GB+ |
| **Armazenamento** | 10 GB | 20 GB+ (SSD) |
| **CPU** | 2 cores | 4 cores+ |

### **9.2. Extensões Necessárias**

```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";      -- Geração de UUIDs
CREATE EXTENSION IF NOT EXISTS "postgis";        -- Dados geoespaciais
CREATE EXTENSION IF NOT EXISTS "vector";         -- Embeddings vetoriais
```

### **9.3. Configurações Recomendadas (postgresql.conf)**

```ini
# Memória
shared_buffers = 2GB                  # 25% da RAM
effective_cache_size = 6GB            # 75% da RAM
work_mem = 64MB                       # Para ordenações e joins
maintenance_work_mem = 512MB          # Para VACUUM, CREATE INDEX

# Otimizações para PostGIS
random_page_cost = 1.1                # Para SSD (padrão: 4.0)
effective_io_concurrency = 200        # Para SSD (padrão: 1)

# Otimizações para pgvector
max_parallel_workers_per_gather = 4   # Paralelização de queries
```

---

## 10. Guia de Implementação

### **10.1. Passo a Passo**

**1. Criar banco de dados:**

```bash
createdb -U postgres framework_v6
```

**2. Executar schema SQL:**

```bash
psql -U postgres -d framework_v6 -f SCHEMA_COMPLETO_40_TABELAS_POSTGRESQL.sql
```

**3. Verificar instalação:**

```sql
-- Verificar extensões
SELECT * FROM pg_extension WHERE extname IN ('uuid-ossp', 'postgis', 'vector');

-- Contar tabelas
SELECT COUNT(*) FROM information_schema.tables 
WHERE table_schema = 'public' AND table_type = 'BASE TABLE';
-- Esperado: 40 tabelas

-- Listar índices
SELECT COUNT(*) FROM pg_indexes WHERE schemaname = 'public';
-- Esperado: ~120 índices
```

**4. Popular tabela core:**

```sql
-- Importar CSV de municípios
COPY entidades_territoriais(codigo_ibge, nome, uf, tipo, populacao, area_km2)
FROM '/path/to/municipios_tocantins_completo.csv'
DELIMITER ',' CSV HEADER;
```

**5. Testar busca vetorial:**

```sql
-- Inserir análise de teste
INSERT INTO analises_geradas (codigo_ibge, tipo_analise, titulo, conteudo, embedding)
VALUES (
    '1721000',
    'economica',
    'Análise de Teste',
    'Conteúdo de teste para validação',
    '[0.1, 0.2, 0.3, ...]'::VECTOR(1536)  -- Embedding de teste
);

-- Buscar análises similares
SELECT * FROM buscar_analises_similares(
    '[0.1, 0.2, 0.3, ...]'::VECTOR(1536),
    5
);
```

### **10.2. Troubleshooting**

**Problema:** Extensão pgvector não encontrada

**Solução:**
```bash
# Ubuntu/Debian
sudo apt install postgresql-15-pgvector

# Ou compilar do source
git clone https://github.com/pgvector/pgvector.git
cd pgvector
make
sudo make install
```

**Problema:** Índice IVFFlat lento

**Solução:** Ajustar parâmetro `lists` baseado no volume:
- < 10.000 registros: `lists = 10`
- 10.000 - 100.000: `lists = 100`
- 100.000 - 1.000.000: `lists = 1000`
- > 1.000.000: `lists = 10000`

**Problema:** Consultas espaciais lentas

**Solução:**
```sql
-- Verificar se índices GiST existem
SELECT tablename, indexname FROM pg_indexes 
WHERE indexdef LIKE '%GIST%';

-- Recriar índice se necessário
REINDEX INDEX idx_focos_calor_geom;

-- Analisar tabela
ANALYZE focos_calor;
```

---

## 11. Manutenção

### **11.1. Rotinas Recomendadas**

**Diária:**
- Backup incremental
- Monitoramento de espaço em disco

**Semanal:**
- `VACUUM ANALYZE` em tabelas grandes
- Verificação de índices corrompidos

**Mensal:**
- `VACUUM FULL` (em janela de manutenção)
- Atualização de estatísticas (`ANALYZE`)
- Revisão de queries lentas (pg_stat_statements)

**Anual:**
- Particionamento de tabelas grandes (> 10M registros)
- Arquivamento de dados antigos (> 10 anos)

### **11.2. Scripts de Manutenção**

**Vacuum automático:**

```sql
-- Verificar configuração de autovacuum
SHOW autovacuum;

-- Ajustar se necessário
ALTER TABLE focos_calor SET (autovacuum_vacuum_scale_factor = 0.1);
```

**Monitoramento de tamanho:**

```sql
-- Tamanho de cada tabela
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
```

**Queries lentas:**

```sql
-- Habilitar pg_stat_statements
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- Top 10 queries mais lentas
SELECT 
    query,
    calls,
    total_exec_time,
    mean_exec_time,
    max_exec_time
FROM pg_stat_statements
ORDER BY mean_exec_time DESC
LIMIT 10;
```

---

## 12. Segurança

### **12.1. Roles e Permissões**

```sql
-- Criar role para aplicação
CREATE ROLE framework_v6_app WITH LOGIN PASSWORD 'senha_segura_aqui';

-- Conceder permissões de leitura e escrita
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO framework_v6_app;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO framework_v6_app;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO framework_v6_app;

-- Criar role de leitura (para dashboards)
CREATE ROLE framework_v6_readonly WITH LOGIN PASSWORD 'senha_readonly';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO framework_v6_readonly;
GRANT EXECUTE ON FUNCTION buscar_analises_similares TO framework_v6_readonly;
```

### **12.2. Backup e Recuperação**

**Backup completo:**

```bash
pg_dump -U postgres -d framework_v6 -F c -f framework_v6_backup.dump
```

**Backup apenas schema:**

```bash
pg_dump -U postgres -d framework_v6 --schema-only -f schema_only.sql
```

**Restauração:**

```bash
pg_restore -U postgres -d framework_v6_novo framework_v6_backup.dump
```

---

## 13. Conclusão

O schema SQL completo das 40 tabelas do Framework V6.0 está pronto para implementação. Ele fornece:

✅ **Estrutura robusta** para armazenar 420+ indicadores de 4 dimensões  
✅ **Otimização avançada** com 120+ índices (B-tree, GiST, GIN, IVFFlat)  
✅ **Suporte geoespacial** completo via PostGIS  
✅ **Busca semântica** via pgvector  
✅ **Views e funções** úteis para análises  
✅ **Triggers automáticos** para manutenção  
✅ **Documentação completa** para implementação e manutenção

Com este schema, a **Camada 1 (Armazenamento)** da arquitetura RAG está completamente especificada e pronta para receber dados reais do Tocantins.

---

**Versão:** 1.0  
**Data:** 07 de Novembro de 2025  
**Autores:** Henrique Ribeiro & Manus IA  
**Status:** ✅ Completo e pronto para implementação
