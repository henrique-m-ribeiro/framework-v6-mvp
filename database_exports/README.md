# Exportação da Base de Dados - Dashboard Territorial Tocantins

**Data da Exportação:** 22 de Novembro de 2025  
**Banco de Dados:** PostgreSQL 16.9 com extensões PostGIS 3.3.3 e pgvector 0.8.0

---

## 📁 Arquivos Exportados

### **Arquivos SQL (Backup Completo)**

| Arquivo | Tamanho | Descrição |
|---------|---------|-----------|
| `full_backup.sql` | 297 KB | **Backup completo** - Schema + Dados (use este para restaurar tudo) |
| `schema.sql` | 7.1 KB | **Apenas estrutura** - Tabelas, índices, extensões (sem dados) |
| `data.sql` | 291 KB | **Apenas dados** - INSERTs de todas as tabelas (sem estrutura) |

### **Arquivos CSV (Para Análise em Excel/BI)**

| Arquivo | Registros | Descrição |
|---------|-----------|-----------|
| `territories.csv` | 21 | Territórios (Tocantins + 20 municípios) |
| `economic_indicators.csv` | 105 | Indicadores econômicos (PIB, renda, emprego) |
| `social_indicators.csv` | 105 | Indicadores sociais (IDH, educação, saúde) |
| `territorial_indicators.csv` | 105 | Indicadores territoriais (área, densidade, saneamento) |
| `environmental_indicators.csv` | 105 | Indicadores ambientais (vegetação, água, emissões) |
| `indicator_metadata.csv` | 12 | Dicionário de dados (descrição de cada indicador) |

---

## 🗂️ Estrutura do Banco de Dados

### **Tabelas Principais**

1. **territories** - Entidades territoriais
   - 21 registros (1 estado + 20 municípios)
   - Colunas: id, name, type, parent_id, coordinates (geography), metadata (jsonb)
   - Índice espacial GIST para consultas geográficas

2. **economic_indicators** - Dimensão Econômica
   - 105 registros (21 territórios × 5 anos)
   - Indicadores: PIB, PIB per capita, renda média, taxa de emprego, inflação

3. **social_indicators** - Dimensão Social
   - 105 registros (21 territórios × 5 anos)
   - Indicadores: IDH, expectativa de vida, escolaridade, mortalidade infantil, pobreza

4. **territorial_indicators** - Dimensão Territorial
   - 105 registros (21 territórios × 5 anos)
   - Indicadores: área, densidade, cobertura de saneamento, água tratada, coleta de lixo

5. **environmental_indicators** - Dimensão Ambiental
   - 105 registros (21 territórios × 5 anos)
   - Indicadores: cobertura vegetal, desmatamento, qualidade do ar, emissões CO2

6. **indicator_metadata** - Dicionário de Dados
   - 12 registros (definições dos indicadores)
   - Colunas: indicator_key, name, description, unit, dimension, interpretation_guide

7. **knowledge_base** - Base de Conhecimento para IA
   - 4 registros (contextos por dimensão)
   - Colunas: territory_id, dimension, content, embedding (jsonb), embedding_vector (vector(1536))
   - Índice IVFFlat para busca semântica otimizada

---

## 🔧 Extensões PostgreSQL Instaladas

- **PostGIS 3.3.3** - Análise geoespacial (coordenadas, distâncias, proximidade)
- **pgvector 0.8.0** - Busca vetorial para embeddings de IA (sistema RAG)

---

## 📊 Como Usar os Exports

### **1. Restaurar o Banco Completo (PostgreSQL)**

```bash
# Criar novo banco (se necessário)
createdb meu_banco

# Restaurar backup completo
psql meu_banco < full_backup.sql

# Ou apenas estrutura
psql meu_banco < schema.sql

# Ou apenas dados
psql meu_banco < data.sql
```

### **2. Analisar em Excel/Power BI**

1. Abra qualquer arquivo `.csv` no Excel
2. Os cabeçalhos já estão incluídos
3. Use `indicator_metadata.csv` como referência para entender cada coluna

### **3. Importar em Python/Pandas**

```python
import pandas as pd

# Ler territórios
territories = pd.read_csv('territories.csv')

# Ler indicadores econômicos
economic = pd.read_csv('economic_indicators.csv')

# Fazer análises
print(territories.head())
print(economic.describe())
```

### **4. Conectar com n8n ou Outras Ferramentas**

Use as credenciais do PostgreSQL:
- **Host:** Veja no Replit Secrets (`PGHOST`)
- **Database:** Veja no Replit Secrets (`PGDATABASE`)
- **User:** Veja no Replit Secrets (`PGUSER`)
- **Password:** Veja no Replit Secrets (`PGPASSWORD`)
- **Port:** 5432
- **SSL:** Enabled

---

## 📈 Estatísticas dos Dados

- **Período coberto:** 2019-2023 (5 anos)
- **Total de territórios:** 21 (1 estado + 20 municípios)
- **Total de indicadores:** 420 registros (105 por dimensão)
- **Municípios com coordenadas:** 19 (geocodificados para mapas)
- **Dimensões de análise:** 4 (Econômica, Social, Territorial, Ambiental)

---

## 🔐 Segurança

⚠️ **IMPORTANTE:**
- Estes exports contêm dados do ambiente de **desenvolvimento**
- Não compartilhe credenciais do banco de dados
- Use apenas para análise e backup pessoal

---

## 📞 Suporte

Se precisar de mais informações sobre a estrutura dos dados ou ajuda com importação, consulte o arquivo `replit.md` no projeto original.

---

**Gerado automaticamente pelo Dashboard de Inteligência Territorial - Tocantins**
