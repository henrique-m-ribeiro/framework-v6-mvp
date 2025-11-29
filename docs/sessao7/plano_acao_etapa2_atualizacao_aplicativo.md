# Plano de Ação: Etapa 2 - Atualizar Código do Aplicativo Replit

**Data:** 29/11/2025  
**Autor:** Manus AI  
**Status:** 📋 PLANEJAMENTO

---

## 1. Objetivo

Este documento detalha o plano de ação para a **Etapa 2** da migração do schema da tabela `economic_indicators`. O objetivo é atualizar o código do aplicativo no Replit para utilizar os novos campos adicionados na Etapa 1, garantindo uma transição suave e sem interrupção do serviço.

---

## 2. Escopo da Etapa 2

A Etapa 2 envolve modificações no código-fonte do aplicativo para:

1.  **Migrar consultas SQL:** Substituir referências ao campo `gdp` pelo novo campo `gdp_current_prices`.
2.  **Manter compatibilidade temporária:** Garantir que o aplicativo funcione durante a transição.
3.  **Adicionar novos indicadores:** Integrar visualizações para os novos campos (`total_wage_mass`, `active_companies_count`, `municipal_tax_revenue`).
4.  **Atualizar lógica do chatbot:** Adaptar o assistente de IA para utilizar os novos campos e metadados.

---

## 3. Estratégia de Implementação

A implementação seguirá uma abordagem **incremental e testável**, dividida em 3 sub-etapas:

### Sub-Etapa 2.1: Migrar Consultas SQL Existentes (PRIORITÁRIO)

**Objetivo:** Fazer com que o aplicativo leia os dados do novo campo `gdp_current_prices` em vez do campo legado `gdp`.

**Ações:**

1.  **Identificar arquivos de consulta:** Localizar todos os arquivos Python que fazem consultas à tabela `economic_indicators`.
    *   Arquivos típicos: `app.py`, `database.py`, `queries.py`, `utils.py`
    *   Buscar por: `SELECT`, `FROM economic_indicators`, `gdp`

2.  **Atualizar queries SQL:**
    *   **Antes:**
        ```sql
        SELECT territory_id, year, gdp, gdp_per_capita
        FROM economic_indicators
        WHERE territory_id = %s AND year = %s;
        ```
    *   **Depois:**
        ```sql
        SELECT territory_id, year, gdp_current_prices AS gdp, gdp_per_capita
        FROM economic_indicators
        WHERE territory_id = %s AND year = %s;
        ```
    *   **Nota:** Usar `AS gdp` mantém a compatibilidade com o código que espera uma coluna chamada `gdp`.

3.  **Testar localmente:** Executar o aplicativo localmente (ou em ambiente de staging) para validar que as consultas funcionam corretamente.

4.  **Deploy incremental:** Fazer deploy da mudança e monitorar por 24-48h para garantir estabilidade.

**Critério de Sucesso:** O dashboard exibe os mesmos valores de PIB que antes, mas agora lendo do campo `gdp_current_prices`.

---

### Sub-Etapa 2.2: Adicionar Visualizações para Novos Indicadores (MÉDIO PRAZO)

**Objetivo:** Expandir o dashboard para exibir os novos indicadores econômicos.

**Ações:**

1.  **Criar novos cards de métricas:**
    *   **Massa Salarial Total** (`total_wage_mass`)
    *   **Número de Empresas Ativas** (`active_companies_count`)
    *   **Receita Tributária Própria** (`municipal_tax_revenue`)

2.  **Adicionar queries para os novos campos:**
    ```sql
    SELECT 
        territory_id,
        year,
        gdp_current_prices,
        total_wage_mass,
        active_companies_count,
        municipal_tax_revenue
    FROM economic_indicators
    WHERE territory_id = %s AND year = %s;
    ```

3.  **Implementar lógica de fallback:**
    *   Se os novos campos estiverem `NULL` (ainda não populados), exibir mensagem: "Dados não disponíveis para este período".

4.  **Atualizar layout do dashboard:**
    *   Adicionar novos cards na seção "Dimensão Econômica".
    *   Manter o layout responsivo e intuitivo.

**Critério de Sucesso:** O dashboard exibe os novos indicadores quando disponíveis, sem quebrar a experiência do usuário quando os dados ainda não foram coletados.

---

### Sub-Etapa 2.3: Atualizar Lógica do Chatbot (LONGO PRAZO)

**Objetivo:** Adaptar o assistente de IA para utilizar os novos campos e responder perguntas mais ricas.

**Ações:**

1.  **Atualizar prompt do chatbot:**
    *   Incluir informações sobre os novos indicadores no contexto do chatbot.
    *   Exemplo: "Você tem acesso aos seguintes indicadores econômicos: PIB, PIB per capita, Massa Salarial, Número de Empresas Ativas, Receita Tributária Própria."

2.  **Adaptar queries do chatbot:**
    *   Modificar as queries que o chatbot usa para buscar dados, incluindo os novos campos.

3.  **Testar perguntas do usuário:**
    *   "Qual é a massa salarial de Palmas?"
    *   "Quantas empresas ativas existem em Araguaína?"
    *   "Como está a receita tributária do município?"

**Critério de Sucesso:** O chatbot responde corretamente a perguntas sobre os novos indicadores.

---

## 4. Checklist de Implementação

### 📋 Sub-Etapa 2.1: Migrar Consultas SQL

- [ ] Identificar todos os arquivos que fazem consultas à tabela `economic_indicators`
- [ ] Atualizar queries para usar `gdp_current_prices AS gdp`
- [ ] Testar aplicativo localmente
- [ ] Fazer deploy em ambiente de staging (se disponível)
- [ ] Fazer deploy em produção
- [ ] Monitorar logs e métricas por 24-48h

### 📋 Sub-Etapa 2.2: Adicionar Visualizações

- [ ] Criar cards para Massa Salarial
- [ ] Criar cards para Número de Empresas Ativas
- [ ] Criar cards para Receita Tributária Própria
- [ ] Implementar lógica de fallback para dados `NULL`
- [ ] Atualizar layout do dashboard
- [ ] Testar responsividade em diferentes dispositivos
- [ ] Fazer deploy em produção

### 📋 Sub-Etapa 2.3: Atualizar Chatbot

- [ ] Atualizar prompt do chatbot com novos indicadores
- [ ] Adaptar queries do chatbot
- [ ] Testar perguntas sobre novos indicadores
- [ ] Validar respostas do chatbot
- [ ] Fazer deploy em produção

---

## 5. Pontos de Atenção

### 5.1. Compatibilidade Durante a Transição

Durante a Sub-Etapa 2.1, é crucial usar `AS gdp` nas queries para manter a compatibilidade com o código existente que espera uma coluna chamada `gdp`. Isso evita a necessidade de modificar múltiplos pontos do código simultaneamente.

### 5.2. Dados Ainda Não Populados

Os novos campos (`total_wage_mass`, `active_companies_count`, `municipal_tax_revenue`) ainda estão vazios (`NULL`) no banco de dados. A interface deve lidar graciosamente com essa situação, exibindo mensagens claras ao usuário.

### 5.3. Testes Incrementais

Cada sub-etapa deve ser testada e validada antes de prosseguir para a próxima. Isso minimiza o risco de introduzir bugs e facilita a identificação de problemas.

---

## 6. Exemplo de Código: Migração de Query

### Antes (Código Atual)

```python
def get_economic_indicators(territory_id, year):
    query = """
        SELECT territory_id, year, gdp, gdp_per_capita
        FROM economic_indicators
        WHERE territory_id = %s AND year = %s;
    """
    cursor.execute(query, (territory_id, year))
    return cursor.fetchone()
```

### Depois (Código Atualizado - Sub-Etapa 2.1)

```python
def get_economic_indicators(territory_id, year):
    query = """
        SELECT 
            territory_id, 
            year, 
            gdp_current_prices AS gdp,  -- Usar novo campo, mas manter nome antigo
            gdp_per_capita
        FROM economic_indicators
        WHERE territory_id = %s AND year = %s;
    """
    cursor.execute(query, (territory_id, year))
    return cursor.fetchone()
```

### Depois (Código Atualizado - Sub-Etapa 2.2)

```python
def get_economic_indicators(territory_id, year):
    query = """
        SELECT 
            territory_id, 
            year, 
            gdp_current_prices AS gdp,
            gdp_per_capita,
            total_wage_mass,
            active_companies_count,
            municipal_tax_revenue
        FROM economic_indicators
        WHERE territory_id = %s AND year = %s;
    """
    cursor.execute(query, (territory_id, year))
    result = cursor.fetchone()
    
    # Converter None para mensagem amigável
    if result:
        result = {
            'territory_id': result[0],
            'year': result[1],
            'gdp': result[2],
            'gdp_per_capita': result[3],
            'total_wage_mass': result[4] or 'Não disponível',
            'active_companies_count': result[5] or 'Não disponível',
            'municipal_tax_revenue': result[6] or 'Não disponível'
        }
    
    return result
```

---

## 7. Cronograma Estimado

| Sub-Etapa | Duração Estimada | Prioridade |
| :--- | :--- | :--- |
| 2.1: Migrar Consultas SQL | 2-4 horas | 🔴 Alta |
| 2.2: Adicionar Visualizações | 4-6 horas | 🟡 Média |
| 2.3: Atualizar Chatbot | 2-3 horas | 🟢 Baixa |
| **Total** | **8-13 horas** | |

---

## 8. Próximos Passos

1.  **Acesso ao Código-Fonte:** Obter acesso ao repositório ou arquivos do aplicativo no Replit.
2.  **Análise Detalhada:** Mapear todos os pontos de modificação no código.
3.  **Implementação da Sub-Etapa 2.1:** Iniciar a migração das consultas SQL.
4.  **Testes e Validação:** Garantir que o aplicativo funciona corretamente após cada modificação.

Este plano será refinado assim que o código-fonte do aplicativo estiver disponível para análise.
