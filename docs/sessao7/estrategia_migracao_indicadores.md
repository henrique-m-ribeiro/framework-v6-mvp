# Estratégia de Migração Compatível para Indicadores Econômicos

**Data:** 29/11/2025  
**Autor:** Manus AI

---

## 1. Objetivo

Definir uma estratégia de migração para o schema da tabela `economic_indicators` que minimize o impacto no aplicativo existente, garantindo a continuidade das funcionalidades e permitindo a evolução futura do sistema.

---

## 2. Análise de Impacto

Com base na exploração do aplicativo, confirmo que os campos `gdp` e `gdp_per_capita` são **críticos** para a funcionalidade atual. A renomeação direta de `gdp` para `gdp_current_prices` **causaria a quebra do aplicativo**.

O campo `sector_distribution` é utilizado pelo assistente de IA para responder a perguntas como "Qual o principal setor econômico?". Sua remoção **degradaria a funcionalidade do chatbot**.

---

## 3. Estratégia de Migração em 3 Etapas (Revisada)

Proponho uma abordagem de migração em fases, que garante zero downtime e permite uma transição suave.

### Etapa 1: Adicionar Novos Campos e Manter os Antigos (Compatibilidade)

**Ação:** Executar um script SQL que adiciona os novos campos à tabela `economic_indicators`, mas **mantém os campos antigos** (`gdp`, `gdp_per_capita`, `sector_distribution`) por enquanto.

**Script SQL (Etapa 1):**

```sql
-- ETAPA 1: Adicionar novos campos SEM remover os antigos
ALTER TABLE economic_indicators
ADD COLUMN IF NOT EXISTS gdp_current_prices NUMERIC(20, 2),
ADD COLUMN IF NOT EXISTS total_wage_mass NUMERIC(20, 2),
ADD COLUMN IF NOT EXISTS active_companies_count INTEGER,
ADD COLUMN IF NOT EXISTS municipal_tax_revenue NUMERIC(20, 2),
ADD COLUMN IF NOT EXISTS source VARCHAR(255),
ADD COLUMN IF NOT EXISTS metadata JSONB;

-- Migrar dados existentes para o novo campo de PIB
UPDATE economic_indicators
SET gdp_current_prices = gdp
WHERE gdp_current_prices IS NULL;
```

**Resultado:** O aplicativo continua funcionando sem alterações, pois os campos antigos ainda existem. A base de dados está pronta para a nova estrutura.

### Etapa 2: Atualizar o Código do Aplicativo (Transição)

**Ação:** Modificar o código-fonte do aplicativo no Replit para:

1.  **Leitura:** Fazer com que o aplicativo leia os dados do novo campo `gdp_current_prices` em vez de `gdp`.
2.  **Chatbot:** Atualizar a lógica do chatbot para utilizar uma nova estrutura de dados setoriais (seja uma nova tabela ou um campo JSONB mais detalhado), em vez do antigo `sector_distribution`.
3.  **Novas Visualizações:** Adicionar gradualmente novas visualizações no dashboard para os novos indicadores (Massa Salarial, Empresas Ativas, Receita Tributária).

**Benefício:** Esta etapa pode ser feita de forma incremental, sem pressa, pois a Etapa 1 garante a compatibilidade retroativa.

### Etapa 3: Remover Campos Antigos (Limpeza)

**Ação:** Somente **após a conclusão e validação da Etapa 2**, executar um segundo script SQL para remover os campos legados.

**Script SQL (Etapa 3):**

```sql
-- ETAPA 3 (EXECUTAR APENAS APÓS ATUALIZAR O CÓDIGO DO APLICATIVO):
ALTER TABLE economic_indicators
DROP COLUMN IF EXISTS gdp,
DROP COLUMN IF EXISTS employment_rate,
DROP COLUMN IF EXISTS revenue,
DROP COLUMN IF EXISTS sector_distribution;
```

**Resultado:** O schema do banco de dados fica limpo, alinhado com a v4.0, e o aplicativo já está totalmente adaptado.

---

## 4. Próximos Passos Imediatos

1.  **Aprovação:** Solicito sua aprovação para esta estratégia de migração em 3 etapas.
2.  **Execução da Etapa 1:** Com sua aprovação, executarei o script SQL da Etapa 1 para preparar o banco de dados.
3.  **Planejamento da Etapa 2:** Após a Etapa 1, podemos planejar juntos a atualização do código do aplicativo no Replit.

Esta abordagem garante que possamos evoluir a base de dados sem interromper o serviço valioso que o aplicativo já fornece.
