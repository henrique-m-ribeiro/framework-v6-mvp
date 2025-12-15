# Proposta de Indicadores Econômicos Essenciais (Camada 0)

**Data:** 29/11/2025  
**Autor:** Manus AI

---

## 1. Análise do Schema Atual

A tabela `economic_indicators` atualmente possui uma estrutura flexível, mas que pode ser otimizada para maior clareza, consistência e capacidade analítica. 

**Schema Atual:**

| Coluna | Tipo de Dado | Nullable | Descrição |
| :--- | :--- | :--- | :--- |
| `id` | `character varying` | NO | UUID gerado aleatoriamente. |
| `territory_id` | `character varying` | NO | ID do território. |
| `year` | `integer` | NO | Ano da medição. |
| `gdp` | `real` | YES | Produto Interno Bruto. |
| `gdp_per_capita` | `real` | YES | PIB per capita. |
| `employment_rate` | `real` | YES | Taxa de emprego. |
| `revenue` | `real` | YES | Receita municipal. |
| `sector_distribution` | `json` | YES | Distribuição setorial. |

**Pontos de Melhoria:**
- **Tipos de Dados:** Usar `NUMERIC` em vez de `real` para valores monetários garante precisão decimal. `id` e `territory_id` devem ser `INTEGER` ou `UUID` de forma consistente.
- **Nomenclatura:** Os nomes são genéricos (ex: `revenue`). Podem ser mais específicos (ex: `municipal_tax_revenue`).
- **Estrutura:** A tabela mistura diferentes tipos de indicadores (produção, mercado de trabalho, finanças públicas). Uma estrutura mais granular pode ser mais robusta.

---

## 2. Proposta de 5 Indicadores Econômicos Essenciais

Com base nas melhores práticas de análise econômica territorial e nas fontes de dados mais confiáveis do Brasil (IBGE, RAIS/CAGED, SICONFI), proponho um conjunto inicial de 5 indicadores essenciais para fornecer uma visão 360º da economia de um município.

### Indicadores Propostos

| # | Indicador | Dimensão Analítica | Fonte Primária | Justificativa |
| :- | :--- | :--- | :--- | :--- |
| 1 | **PIB a preços correntes** | Produção e Riqueza | IBGE - Contas Regionais | Mede o tamanho e a evolução da atividade econômica total do município. É o principal indicador de crescimento. |
| 2 | **PIB per capita** | Padrão de Vida | IBGE / Censo | Indica a riqueza média por habitante, permitindo comparações de padrão de vida e produtividade entre territórios. |
| 3 | **Massa Salarial** | Mercado de Trabalho | RAIS / CAGED | Representa o montante total de salários pagos. Seu crescimento indica aquecimento do mercado de trabalho e aumento da renda. |
| 4 | **Número de Empresas Ativas** | Dinamismo Empresarial | RAIS / CNPJ | Mede a vitalidade do tecido empresarial. O crescimento no número de empresas indica um ambiente de negócios favorável. |
| 5 | **Receita Tributária Própria** | Capacidade Fiscal | SICONFI / FINBRA | Mede a capacidade do município de gerar receita a partir de suas próprias fontes (IPTU, ISS, ITBI), indicando autonomia fiscal. |

---

## 3. Proposta de Novo Schema para `economic_indicators`

Para acomodar esses indicadores de forma robusta e escalável, proponho a seguinte atualização no schema da tabela `economic_indicators`.

**Novo Schema Proposto:**

| Coluna | Tipo de Dado | Chave | Descrição |
| :--- | :--- | :--- | :--- |
| `id` | `SERIAL` | PK | Identificador sequencial único. |
| `territory_id` | `INTEGER` | FK (`territories.id`) | Chave estrangeira para o território. |
| `year` | `INTEGER` | | Ano da medição do indicador. |
| `gdp_current_prices` | `NUMERIC(20, 2)` | | **[Novo]** PIB a preços correntes (em R$ mil). |
| `gdp_per_capita` | `NUMERIC(15, 2)` | | PIB per capita (em R$). |
| `total_wage_mass` | `NUMERIC(20, 2)` | | **[Novo]** Massa salarial total (em R$ mil). |
| `active_companies_count` | `INTEGER` | | **[Novo]** Número de empresas e outras organizações ativas. |
| `municipal_tax_revenue` | `NUMERIC(20, 2)` | | **[Novo]** Receita tributária própria do município (em R$ mil). |
| `source` | `VARCHAR(255)` | | Fonte principal dos dados do registro (ex: "IBGE, RAIS"). |
| `metadata` | `JSONB` | | Metadados adicionais (ex: notas metodológicas). |

**Remoções Propostas:**
- `gdp`, `employment_rate`, `revenue`, `sector_distribution`: Serão substituídos pelos novos campos mais específicos e robustos. A distribuição setorial pode ser uma tabela à parte ou calculada a partir de dados mais granulares de emprego/salários por setor.

---

## 4. Próximos Passos

1.  **Validar a proposta:** Discutir e aprovar o novo conjunto de indicadores e o schema da tabela.
2.  **Criar script de migração:** Desenvolver um script SQL (`ALTER TABLE`) para aplicar as mudanças no banco de dados.
3.  **Atualizar Agente de Extração:** Modificar o Agente de Extração de Dados para coletar e inserir os novos indicadores.
4.  **Atualizar Agente ECON:** Ajustar o workflow do Agente ECON para consumir e analisar os novos indicadores.
