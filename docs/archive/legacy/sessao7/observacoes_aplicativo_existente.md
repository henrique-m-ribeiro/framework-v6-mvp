# Observações: Uso de Indicadores no Aplicativo Existente

**Data:** 29/11/2025  
**URL:** https://inteligencia-territorial--hrhenrique7.replit.app  
**Autor:** Manus AI

---

## 1. Indicadores Econômicos Utilizados

Com base na navegação pelo aplicativo, identifiquei os seguintes indicadores econômicos em uso:

### 1.1. Nível Estadual (Tocantins)

| Indicador | Valor Exibido | Campo no DB (Provável) |
| :--- | :--- | :--- |
| **PIB Total** | R$ 50.171,7 bi | `gdp` ou `gdp_current_prices` |
| **PIB per Capita** | R$ 31.033 | `gdp_per_capita` |
| **Variação vs. ano anterior** | -10.2% (PIB), -9% (PIB per capita) | Calculado dinamicamente |

### 1.2. Nível Municipal (Abreulândia - exemplo)

| Indicador | Valor Exibido | Campo no DB (Provável) |
| :--- | :--- | :--- |
| **PIB Total** | R$ 296,1 bi | `gdp` ou `gdp_current_prices` |
| **PIB per Capita** | R$ 28.401 | `gdp_per_capita` |
| **Variação vs. ano anterior** | -1.4% (PIB), -4.2% (PIB per capita) | Calculado dinamicamente |

---

## 2. Funcionalidades Identificadas

### 2.1. Visualização de Indicadores
- **Cards de métricas** exibindo valores absolutos e variações percentuais
- **Comparação temporal** (vs. ano anterior)
- **Seleção de território** (Estado ou Município)
- **Seleção de período** (Últimos 5 anos)

### 2.2. Dimensões Analisadas
- **Econômica:** PIB Total, PIB per Capita
- **Social:** IDH-M, População
- **Territorial:** Densidade, Saneamento
- **Ambiental:** Cobertura Vegetal, Qualidade da Água

### 2.3. Assistente IA
- **Chatbot integrado** para responder perguntas sobre os dados
- **Sugestões de perguntas** (ex: "Qual o principal setor econômico?")

---

## 3. Campos da Tabela `economic_indicators` Utilizados pelo Aplicativo

Com base na análise, os seguintes campos da tabela `economic_indicators` são **atualmente utilizados** pelo aplicativo:

| Campo Atual | Uso no Aplicativo | Criticidade |
| :--- | :--- | :--- |
| `gdp` | Exibido como "PIB Total" | 🔴 **CRÍTICO** |
| `gdp_per_capita` | Exibido como "PIB per Capita" | 🔴 **CRÍTICO** |
| `year` | Usado para cálculo de variação temporal | 🔴 **CRÍTICO** |
| `territory_id` | Filtro para seleção de território | 🔴 **CRÍTICO** |

**Campos NÃO utilizados atualmente:**
- `employment_rate` (não exibido na interface)
- `revenue` (não exibido na interface)
- `sector_distribution` (não exibido na interface, mas pode ser usado pelo chatbot)

---

## 4. Impacto da Proposta de Alteração do Schema

### 4.1. Campos Renomeados (ALTO IMPACTO)

| Campo Antigo | Campo Novo Proposto | Impacto |
| :--- | :--- | :--- |
| `gdp` | `gdp_current_prices` | 🔴 **QUEBRA** o aplicativo se não houver migração de código |
| `gdp_per_capita` | `gdp_per_capita` | ✅ **SEM IMPACTO** (nome mantido) |

### 4.2. Campos Removidos (MÉDIO IMPACTO)

| Campo Antigo | Status na Proposta | Impacto |
| :--- | :--- | :--- |
| `employment_rate` | ❌ Removido | ⚠️ **BAIXO** (não usado no frontend, mas pode estar no backend) |
| `revenue` | ❌ Removido | ⚠️ **BAIXO** (não usado no frontend, mas pode estar no backend) |
| `sector_distribution` | ❌ Removido | ⚠️ **MÉDIO** (pode ser usado pelo chatbot IA) |

### 4.3. Campos Novos (SEM IMPACTO IMEDIATO)

| Campo Novo | Impacto |
| :--- | :--- |
| `total_wage_mass` | ✅ **SEM IMPACTO** (não usado ainda) |
| `active_companies_count` | ✅ **SEM IMPACTO** (não usado ainda) |
| `municipal_tax_revenue` | ✅ **SEM IMPACTO** (não usado ainda) |
| `source` | ✅ **SEM IMPACTO** (não usado ainda) |
| `metadata` | ✅ **SEM IMPACTO** (não usado ainda) |

---

## 5. Recomendações para Migração Segura

### 5.1. Estratégia de Migração em 3 Etapas

**Etapa 1: Adicionar Novos Campos (SEM QUEBRA)**
- Adicionar os novos campos (`gdp_current_prices`, `total_wage_mass`, etc.) à tabela existente
- Manter os campos antigos (`gdp`, `employment_rate`, etc.) temporariamente
- Popular os novos campos com os dados existentes (migração de dados)

**Etapa 2: Atualizar o Código do Aplicativo**
- Modificar o código do aplicativo para usar `gdp_current_prices` em vez de `gdp`
- Testar todas as funcionalidades
- Validar que o aplicativo continua funcionando corretamente

**Etapa 3: Remover Campos Antigos (APÓS VALIDAÇÃO)**
- Após garantir que o aplicativo está usando os novos campos
- Remover os campos antigos (`gdp`, `employment_rate`, etc.)
- Limpar o código legado

### 5.2. Script SQL de Migração Segura

```sql
-- ETAPA 1: Adicionar novos campos SEM remover os antigos
ALTER TABLE economic_indicators
ADD COLUMN gdp_current_prices NUMERIC(20, 2),
ADD COLUMN total_wage_mass NUMERIC(20, 2),
ADD COLUMN active_companies_count INTEGER,
ADD COLUMN municipal_tax_revenue NUMERIC(20, 2),
ADD COLUMN source VARCHAR(255),
ADD COLUMN metadata JSONB;

-- Migrar dados existentes
UPDATE economic_indicators
SET gdp_current_prices = gdp;

-- ETAPA 3 (EXECUTAR APENAS APÓS ATUALIZAR O CÓDIGO DO APLICATIVO):
-- ALTER TABLE economic_indicators
-- DROP COLUMN gdp,
-- DROP COLUMN employment_rate,
-- DROP COLUMN revenue,
-- DROP COLUMN sector_distribution;
```

---

## 6. Próximos Passos

1.  ✅ **Validar com o usuário:** Confirmar se há outras funcionalidades ou relatórios que usam os indicadores econômicos.
2.  ⏳ **Acessar o código-fonte:** Analisar o código do aplicativo (Replit) para identificar todas as dependências.
3.  ⏳ **Implementar migração em 3 etapas:** Garantir zero downtime e compatibilidade.
4.  ⏳ **Expandir funcionalidades:** Após a migração, adicionar visualizações para os novos indicadores (Massa Salarial, Empresas Ativas, Receita Tributária).
