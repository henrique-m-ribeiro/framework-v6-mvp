# Análise de Opções: Schema para Ciclo de Aprendizagem

**Projeto:** Framework de Superinteligência Territorial V6.0  
**Decisão:** Como estruturar o armazenamento do Ciclo de Aprendizagem Evolutiva  
**Data:** 30/11/2025

---

## Contexto

A tabela `agent_econ_learning` existente no banco de dados possui um schema diferente do que foi documentado no Modelo Conceitual v4.0. Precisamos decidir entre:

1. **Opção A:** Migrar a tabela existente (adicionar campos)
2. **Opção B:** Criar nova tabela específica para o ciclo de aprendizagem

---

## Opção A: Migrar Tabela Existente

### Schema Atual
```sql
- id: uuid
- learning_type: varchar
- title: text
- description: text
- territories_analyzed: integer
- confidence: numeric
- applicable_to: jsonb
- examples: jsonb
- embedding_vector: vector
- created_at: timestamp
- last_applied: timestamp
- times_applied: integer
- is_active: boolean
```

### Campos a Adicionar
```sql
- agent_id: varchar (novo)
- source_analysis_ids: text (novo)
- learning_content: text (novo - pode usar 'description' existente)
- metadata: jsonb (novo - pode usar 'examples' existente)
```

### ✅ Prós

1. **Simplicidade Arquitetural**
   - Mantém a estrutura de 3 camadas conforme o modelo conceitual
   - Não introduz complexidade adicional no schema
   - Facilita queries e joins futuros

2. **Reutilização de Campos**
   - `description` pode ser usado como `learning_content`
   - `examples` pode ser usado como `metadata`
   - `confidence` já existe e é compatível
   - Menos redundância de dados

3. **Compatibilidade com Documentação**
   - Alinha com o Modelo Conceitual v4.0
   - Mantém a nomenclatura esperada (`agent_econ_learning`)
   - Facilita onboarding de novos desenvolvedores

4. **Menor Overhead de Manutenção**
   - Uma única tabela para gerenciar
   - Menos código de migração entre tabelas
   - Queries mais simples

### ❌ Contras

1. **Risco de Quebra**
   - Se o aplicativo Replit já usa a tabela, a migração pode causar downtime
   - Campos existentes podem ter lógica de negócio que desconhecemos
   - Pode haver triggers ou constraints não documentados

2. **Poluição de Schema**
   - Tabela terá campos que podem não ser usados simultaneamente
   - Mistura dois "tipos" de aprendizado na mesma tabela
   - Pode confundir desenvolvedores futuros

3. **Flexibilidade Limitada**
   - Dificulta evolução independente dos dois sistemas
   - Mudanças em um podem afetar o outro

---

## Opção B: Criar Nova Tabela

### Nova Tabela: `agent_econ_learning_evolution`

```sql
- id: uuid
- agent_id: varchar
- learning_type: varchar ('synthesis', 'correction', 'refinement')
- source_analysis_ids: text
- learning_content: text
- confidence_score: numeric
- metadata: jsonb
- embedding_vector: vector
- created_at: timestamp
```

### ✅ Prós

1. **Zero Risco de Quebra**
   - Não afeta o aplicativo existente
   - Permite desenvolvimento paralelo
   - Rollback trivial (apenas dropar a tabela)

2. **Separação de Responsabilidades**
   - Tabela original: aprendizados "manuais" ou "estáticos"
   - Nova tabela: aprendizados "evolutivos" do ciclo
   - Cada uma pode evoluir independentemente

3. **Clareza Conceitual**
   - Nome explícito indica propósito específico
   - Facilita entendimento da arquitetura
   - Reduz ambiguidade no código

4. **Flexibilidade Futura**
   - Permite adicionar campos específicos do ciclo sem poluir a tabela original
   - Facilita experimentação e iteração
   - Pode ser otimizada independentemente

### ❌ Contras

1. **Complexidade Arquitetural**
   - Introduz uma 4ª "sub-camada" na Camada 2
   - Aumenta o número de tabelas no banco
   - Pode confundir sobre qual tabela usar

2. **Redundância Potencial**
   - Dois schemas muito similares
   - Duplicação de lógica de acesso a dados
   - Mais código de manutenção

3. **Divergência da Documentação**
   - Modelo Conceitual v4.0 menciona `agent_econ_learning`
   - Precisaria atualizar toda a documentação
   - Pode causar confusão em futuras sessões

4. **Overhead de Queries**
   - Queries que precisam de ambos os tipos de aprendizado precisarão de UNION ou múltiplas queries
   - Maior complexidade em relatórios e dashboards

---

## Análise de Impacto

### Impacto no Aplicativo Replit

**Opção A:**
- **Risco Alto** se a tabela já está em uso
- **Risco Baixo** se a tabela está vazia ou não é usada
- Requer teste cuidadoso do aplicativo após migração

**Opção B:**
- **Risco Zero** - não afeta o aplicativo existente
- Aplicativo pode continuar usando `agent_econ_learning` normalmente

### Impacto no Modelo Conceitual

**Opção A:**
- ✅ Mantém alinhamento com documentação existente
- ✅ Não requer atualização do Modelo v4.0

**Opção B:**
- ⚠️ Requer atualização do Modelo v4.0
- ⚠️ Introduz nova entidade não prevista

### Impacto no Desenvolvimento Futuro

**Opção A:**
- ✅ Queries mais simples
- ✅ Menos código de infraestrutura
- ⚠️ Pode limitar evolução futura

**Opção B:**
- ✅ Maior flexibilidade
- ✅ Evolução independente
- ⚠️ Mais código de infraestrutura

---

## Recomendação

### 🏆 Opção B: Criar Nova Tabela

**Justificativa:**

1. **Princípio de Segurança:** Não sabemos se o aplicativo Replit usa `agent_econ_learning`. O risco de quebra é inaceitável nesta fase do projeto.

2. **Princípio de Separação de Responsabilidades:** Os dois tipos de aprendizado têm propósitos diferentes:
   - **Tabela original:** Aprendizados genéricos, possivelmente curados manualmente
   - **Nova tabela:** Aprendizados gerados automaticamente pelo ciclo evolutivo

3. **Facilita Experimentação:** Estamos na Fase 2 do MVP. Precisamos de flexibilidade para iterar rapidamente sem medo de quebrar o que já funciona.

4. **Rollback Trivial:** Se o ciclo de aprendizagem não funcionar como esperado, podemos simplesmente dropar a nova tabela sem afetar nada.

### Estratégia de Implementação

1. **Curto Prazo (Agora):**
   - Criar `agent_econ_learning_evolution`
   - Implementar e testar o ciclo de aprendizagem
   - Validar a abordagem

2. **Médio Prazo (Semanas 3-4 do MVP):**
   - Avaliar se a tabela original está sendo usada
   - Se não estiver, considerar consolidação
   - Se estiver, manter separação

3. **Longo Prazo (Pós-MVP):**
   - Refatorar para arquitetura definitiva
   - Possivelmente unificar tabelas se fizer sentido
   - Ou manter separação se os casos de uso forem realmente distintos

---

## Próximos Passos

1. Criar script de migração para `agent_econ_learning_evolution`
2. Atualizar `learning_cycle.py` para usar a nova tabela
3. Atualizar Modelo Conceitual v4.0 documentando a decisão
4. Executar testes de validação
5. Documentar no diário de pesquisa-ação
