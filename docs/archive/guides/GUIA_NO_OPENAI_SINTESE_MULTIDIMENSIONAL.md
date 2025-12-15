# Guia: Nó OpenAI - Sintetizar Análises Multidimensionais (V5.0)

**Framework de Inteligência Territorial V6.0**  
**Data:** 08 de dezembro de 2025  
**Sessão:** #14  
**Versão do Nó:** OpenAI V2 (n8n 1.117.0+)

---

## 🎯 OBJETIVO DO NÓ

Este é o **GRAN FINALE** do Orquestrador V5.0!

Quando múltiplos agentes são chamados (análise multidimensional), este nó:
1. Recebe TODAS as análises geradas pelos agentes
2. Usa GPT-4o-mini para criar uma síntese integrada
3. Identifica conexões e interdependências entre dimensões
4. Gera insights que emergem da visão holística
5. Fornece recomendações práticas e integradas

---

## 📍 LOCALIZAÇÃO NO WORKFLOW

**Posição:** Após o nó "Code - Agregar Respostas"

**Fluxo:**
```
Code - Agregar Respostas
  ↓
OpenAI - Sintetizar Análises Multidimensionais  ← ESTE NÓ
  ↓
PostgreSQL - Salvar na Knowledge Base
```

---

## 🔧 CONFIGURAÇÃO PASSO A PASSO

### Passo 1: Deletar Nó Antigo (se existir)

1. Localize o nó **"Message a model1"** (OpenAI V1 antigo)
2. Clique com botão direito → **Delete**
3. Ou selecione e pressione **Delete**

---

### Passo 2: Adicionar Novo Nó OpenAI

1. Clique no **"+"** após o nó "Code - Agregar Respostas"
2. Na busca, digite: `openai`
3. Selecione: **"OpenAI"** (não "OpenAI Chat Model")
4. O nó será adicionado ao canvas

---

### Passo 3: Configurar Parâmetros Principais

#### 3.1 Credential to connect with
- Selecione suas credenciais da **OpenAI API**
- Se não tiver, clique em "Create New Credential"

#### 3.2 Resource
- Selecione: **Text**

#### 3.3 Operation
- Selecione: **Generate a Chat Completion**

#### 3.4 Model
- Selecione: **gpt-4o-mini**
- (Ou `gpt-4.1-mini` se disponível no seu ambiente)

---

### Passo 4: Configurar Messages (CRÍTICO)

Este é o passo mais importante! Você configurará **3 mensagens** com roles diferentes.

#### Message 1: System Role (Contexto e Instruções)

**Clique em "Add Message"**

**Role:** System

**Text:** Cole exatamente este prompt:

```
Você é um especialista em síntese de análises territoriais multidimensionais do estado do Tocantins.

Sua missão é integrar análises de diferentes dimensões (econômica, social, territorial, ambiental) em uma síntese coerente, holística e acionável.

PRINCÍPIOS DA SÍNTESE:

1. INTEGRAÇÃO SISTÊMICA
   - Identifique conexões causais entre as dimensões
   - Mostre como uma dimensão afeta as outras
   - Revele padrões emergentes da visão integrada

2. INSIGHTS TRANSVERSAIS
   - Destaque tendências que atravessam múltiplas dimensões
   - Identifique sinergias (quando dimensões se reforçam)
   - Aponte trade-offs (quando há tensões entre dimensões)

3. CONTEXTUALIZAÇÃO TERRITORIAL
   - Considere as especificidades de cada território analisado
   - Compare territórios quando aplicável
   - Relacione com o contexto regional/estadual

4. RECOMENDAÇÕES INTEGRADAS
   - Sugira ações que considerem múltiplas dimensões
   - Priorize intervenções com efeitos multiplicadores
   - Indique possíveis riscos e oportunidades

ESTRUTURA DA SÍNTESE:

1. Visão Geral Integrada (2-3 parágrafos)
   - Quadro geral que emerge das análises
   - Principais padrões identificados

2. Conexões Entre Dimensões (3-4 parágrafos)
   - Como as dimensões se relacionam
   - Sinergias e trade-offs identificados

3. Insights Territoriais (2-3 parágrafos)
   - Especificidades de cada território
   - Comparações quando aplicável

4. Recomendações Integradas (3-5 itens)
   - Ações prioritárias
   - Justificativa multidimensional

TOM E ESTILO:
- Objetivo e baseado em evidências
- Claro e acessível (evite jargão excessivo)
- Propositivo (foco em ações)
- Contextualizado (considere realidade local)

IMPORTANTE:
- Use APENAS informações presentes nas análises fornecidas
- Não invente dados ou estatísticas
- Se houver lacunas, indique-as explicitamente
- Mantenha a síntese entre 600-1000 palavras
```

---

#### Message 2: User Role (Dados para Sintetizar)

**Clique em "Add Message"**

**Role:** User

**Text:** Cole exatamente esta expressão:

```
Sintetize as seguintes análises sobre {{ $json.territories[0].name }}:

{{ $json.agent_responses.map(r => `**DIMENSÃO: ${r.agent_name.toUpperCase()}**\n${r.analysis}\n`).join('\n---\n\n') }}

METADADOS DA ANÁLISE:
- Território(s): {{ $json.territories.map(t => t.name).join(', ') }}
- Dimensões analisadas: {{ $json.agent_responses.map(r => r.agent_name).join(', ') }}
- Escopo: {{ $json.analysis_scope }} e {{ $json.territory_scope }}
- Total de análises: {{ $json.response_count }}
```

**ATENÇÃO:** Este texto usa **expressões n8n** (com `{{ }}`) que serão substituídas dinamicamente pelos dados reais durante a execução.

---

#### Message 3: Assistant Role (Exemplo de Resposta - OPCIONAL)

**Clique em "Add Message"**

**Role:** Assistant

**Text:** Cole este exemplo (opcional mas recomendado):

```
# SÍNTESE INTEGRADA: ANÁLISE MULTIDIMENSIONAL DE [TERRITÓRIO]

## 1. Visão Geral Integrada

A análise multidimensional de [território] revela um quadro de [caracterização geral]. Os dados econômicos indicam [padrão econômico], enquanto os indicadores sociais mostram [padrão social]. Esta combinação sugere [insight integrado].

## 2. Conexões Entre Dimensões

### Economia ↔ Sociedade
[Descrição da relação entre dimensão econômica e social, com base nos dados]

### [Outras conexões identificadas]
[Análise de outras relações entre dimensões]

## 3. Insights Territoriais

[Território] apresenta características específicas que emergem da análise integrada: [insights específicos baseados nos dados fornecidos].

## 4. Recomendações Integradas

1. **[Recomendação 1]**: [Justificativa multidimensional]
2. **[Recomendação 2]**: [Justificativa multidimensional]
3. **[Recomendação 3]**: [Justificativa multidimensional]

## Considerações Finais

[Síntese final e próximos passos sugeridos]
```

**NOTA:** Esta mensagem Assistant é opcional. Ela serve para mostrar ao modelo o formato esperado da resposta. Se você quiser uma resposta mais livre, pode pular esta mensagem.

---

### Passo 5: Configurar Opções Avançadas

Clique em **"Add Option"** e configure:

#### 5.1 Simplify Output
- **Ative** (toggle ON)
- Retorna texto simplificado em vez de JSON complexo

#### 5.2 Output Content as JSON
- **Desative** (toggle OFF)
- Queremos texto em Markdown, não JSON

#### 5.3 Output Randomness (Temperature)
- **Valor:** 0.7
- Criatividade moderada para síntese
- Não muito determinístico (0.0) nem muito aleatório (1.0)

#### 5.4 Maximum Number of Tokens
- **Valor:** 2500
- Permite síntese completa (600-1000 palavras ≈ 1500-2500 tokens)

#### 5.5 Frequency Penalty
- **Valor:** 0.3
- Reduz repetições de frases similares

#### 5.6 Presence Penalty
- **Valor:** 0.3
- Incentiva discussão de novos tópicos

---

### Passo 6: Renomear o Nó

1. Clique no nome do nó no topo do painel
2. Digite: `OpenAI - Sintetizar Análises Multidimensionais`
3. Pressione Enter

---

### Passo 7: Adicionar Notes

1. Clique no ícone de nota (💬) no nó
2. Cole:

```
═══════════════════════════════════════════════════════════════
SINTETIZAR ANÁLISES MULTIDIMENSIONAIS (ATUALIZADO PARA V5.0)
═══════════════════════════════════════════════════════════════

Este é o GRAN FINALE do Orquestrador V5.0!

Quando múltiplos agentes são chamados (análise multidimensional), este nó:
1. Recebe TODAS as análises geradas
2. Usa GPT-4o-mini para criar uma síntese integrada
3. Identifica conexões e interdependências entre dimensões
4. Gera insights que emergem da visão holística
5. Fornece recomendações práticas

ATUALIZAÇÃO V5.0:
- Usa OpenAI V2 (Generate a Chat Completion)
- Estrutura de mensagens com Roles (System, User, Assistant)
- Prompt otimizado para síntese multidimensional
- Processa qualquer número de agentes (não apenas 4)

EXEMPLO:
Se o usuário perguntou "Compare a economia e a educação de Palmas e Araguaína",
este nó receberá:
- Análise econômica de Palmas e Araguaína
- Análise social (educação) de Palmas e Araguaína

E gerará uma síntese que mostra:
- Como a economia afeta a educação em cada município
- Diferenças e semelhanças entre os dois municípios
- Recomendações integradas que consideram ambas as dimensões
```

---

### Passo 8: Conectar ao Workflow

#### 8.1 Entrada
- Conecte a **saída** do nó **"Code - Agregar Respostas"** à **entrada** deste nó

#### 8.2 Saída
- Conecte a **saída** deste nó à **entrada** do nó **"PostgreSQL - Salvar na Knowledge Base"**

---

### Passo 9: Salvar

1. Clique no botão **"Save"** no canto superior direito
2. O nó está configurado!

---

## 🧪 TESTE DO NÓ

### Teste Manual

1. Execute o workflow completo com uma pergunta multidimensional:
   ```json
   {
     "territory_id": "1721000",
     "question": "Como estão a economia e a educação de Palmas?"
   }
   ```

2. Verifique a saída do nó "OpenAI - Sintetizar Análises Multidimensionais"

3. A resposta deve ser um texto em Markdown com:
   - Visão geral integrada
   - Conexões entre dimensões
   - Insights territoriais
   - Recomendações integradas

---

## 📊 ESTRUTURA DE DADOS

### Entrada Esperada (do nó "Code - Agregar Respostas")

```json
{
  "territory_id": "1721000",
  "question": "Como estão a economia e a educação de Palmas?",
  "territories": [
    {"id": "1721000", "name": "Palmas"}
  ],
  "analysis_scope": "multidimensional",
  "territory_scope": "uniterritorial",
  "agent_responses": [
    {
      "agent_id": "economic",
      "agent_name": "Agente Econômico",
      "agent_version": "6.1.0",
      "analysis": "Análise econômica completa...",
      "timestamp": "2025-12-08T..."
    },
    {
      "agent_id": "social",
      "agent_name": "Agente Social",
      "agent_version": "6.1.0",
      "analysis": "Análise social completa...",
      "timestamp": "2025-12-08T..."
    }
  ],
  "response_count": 2
}
```

### Saída Esperada

```json
{
  "message": "# SÍNTESE INTEGRADA: ANÁLISE MULTIDIMENSIONAL DE PALMAS\n\n## 1. Visão Geral Integrada\n\n..."
}
```

(O campo `message` contém o texto completo da síntese em Markdown)

---

## 🔄 FLUXO CONDICIONAL

**IMPORTANTE:** Este nó só deve ser executado quando `analysis_scope === "multidimensional"`.

### Adicionar Nó IF Antes da Síntese

Se ainda não existir, adicione um nó **IF** após "Code - Agregar Respostas":

**Condição:**
```
{{ $json.analysis_scope }} === "multidimensional"
```

**Fluxo:**
```
Code - Agregar Respostas
  ↓
IF - Análise Multidimensional?
  ↓ TRUE → OpenAI - Sintetizar Análises Multidimensionais
  ↓ FALSE → PostgreSQL - Salvar na Knowledge Base (direto)
```

---

## 🎯 OPÇÕES DE CONFIGURAÇÃO DETALHADAS

| Opção | Valor Recomendado | Justificativa |
|-------|-------------------|---------------|
| **Simplify Output** | ON | Retorna texto limpo |
| **Output Content as JSON** | OFF | Queremos Markdown, não JSON |
| **Temperature** | 0.7 | Criatividade moderada |
| **Max Tokens** | 2500 | Síntese completa (600-1000 palavras) |
| **Frequency Penalty** | 0.3 | Evita repetições |
| **Presence Penalty** | 0.3 | Incentiva novos tópicos |
| **Top P** | 1.0 (padrão) | Não alterar (já usamos Temperature) |
| **Number of Completions** | 1 (padrão) | Uma síntese é suficiente |

---

## 🐛 TROUBLESHOOTING

### Erro: "Messages is required"

**Causa:** Nenhuma mensagem foi adicionada

**Solução:**
1. Clique em "Add Message"
2. Configure as 3 mensagens (System, User, Assistant)

---

### Erro: "Expression error"

**Causa:** Erro nas expressões `{{ }}` no User Role

**Solução:**
1. Verifique se copiou exatamente o texto do User Role
2. Certifique-se de que o nó "Code - Agregar Respostas" está antes
3. Execute o nó "Code - Agregar Respostas" primeiro para validar dados

---

### Síntese muito curta ou genérica

**Causa:** Temperature muito baixa ou prompt insuficiente

**Solução:**
1. Aumente Temperature para 0.8
2. Aumente Max Tokens para 3000
3. Verifique se o System Role foi copiado completamente

---

### Síntese inventa dados

**Causa:** Temperature muito alta ou prompt não enfatiza "usar apenas dados fornecidos"

**Solução:**
1. Reduza Temperature para 0.5-0.6
2. Verifique se o System Role contém "Use APENAS informações presentes nas análises fornecidas"

---

## 📝 EXEMPLO DE SAÍDA ESPERADA

```markdown
# SÍNTESE INTEGRADA: ANÁLISE MULTIDIMENSIONAL DE PALMAS

## 1. Visão Geral Integrada

A análise multidimensional de Palmas revela uma capital em processo de consolidação econômica e social. Os dados econômicos indicam um PIB per capita acima da média estadual (R$ 45.234), impulsionado principalmente pelo setor de serviços (72% do PIB). Paralelamente, os indicadores sociais mostram avanços significativos na educação, com IDEB de 6.2 no ensino fundamental, superando a meta nacional.

Esta combinação sugere um círculo virtuoso entre desenvolvimento econômico e investimento em capital humano, característico de centros urbanos em expansão.

## 2. Conexões Entre Dimensões

### Economia ↔ Educação

A forte presença do setor de serviços em Palmas cria demanda por mão de obra qualificada, o que incentiva investimentos em educação. Por outro lado, a melhoria dos indicadores educacionais contribui para a atração de empresas de maior valor agregado, reforçando o ciclo de desenvolvimento.

Os dados mostram que 68% dos empregos formais exigem ensino médio completo ou superior, correlacionando-se com a taxa de escolarização de 94% entre jovens de 15-17 anos.

### Desafios Integrados

Apesar dos avanços, identifica-se uma tensão entre crescimento econômico e desigualdade educacional. Enquanto o centro expandido apresenta escolas com infraestrutura adequada, as regiões periféricas ainda enfrentam carências, o que pode limitar a inclusão econômica de longo prazo.

## 3. Insights Territoriais

Palmas apresenta características de uma capital jovem (fundada em 1989) que ainda está definindo seu perfil de desenvolvimento. A concentração de atividades econômicas no setor terciário reflete sua função administrativa, mas também indica dependência de recursos públicos.

A análise educacional revela investimento consistente em infraestrutura escolar (89% das escolas com laboratórios de informática), posicionando a cidade como referência regional em educação básica.

## 4. Recomendações Integradas

1. **Diversificação Econômica com Foco em Educação Técnica**: Incentivar setores produtivos que aproveitem a base educacional existente, como tecnologia e serviços especializados, reduzindo dependência do setor público.

2. **Equalização da Infraestrutura Educacional**: Priorizar investimentos em escolas periféricas para garantir que o desenvolvimento econômico seja inclusivo e sustentável.

3. **Parcerias Setor Produtivo-Educação**: Criar programas de formação técnica alinhados às demandas do mercado local, fortalecendo a empregabilidade e a competitividade econômica.

4. **Monitoramento Integrado de Indicadores**: Estabelecer sistema de acompanhamento que relacione indicadores econômicos e educacionais, permitindo ajustes de políticas públicas baseados em evidências.

## Considerações Finais

Palmas encontra-se em momento estratégico para consolidar um modelo de desenvolvimento que integre crescimento econômico e avanço social. O desafio é manter os investimentos em educação enquanto diversifica a base econômica, garantindo que os benefícios do desenvolvimento alcancem toda a população.

A continuidade do monitoramento multidimensional será fundamental para avaliar a efetividade das políticas públicas e ajustar trajetórias conforme necessário.
```

---

## ✅ CHECKLIST DE CONFIGURAÇÃO

- [ ] Nó OpenAI adicionado
- [ ] Resource: Text
- [ ] Operation: Generate a Chat Completion
- [ ] Model: gpt-4o-mini
- [ ] Message 1 (System): Prompt completo copiado
- [ ] Message 2 (User): Expressões n8n copiadas
- [ ] Message 3 (Assistant): Exemplo copiado (opcional)
- [ ] Simplify Output: ON
- [ ] Output Content as JSON: OFF
- [ ] Temperature: 0.7
- [ ] Max Tokens: 2500
- [ ] Frequency Penalty: 0.3
- [ ] Presence Penalty: 0.3
- [ ] Nó renomeado
- [ ] Notes adicionadas
- [ ] Conectado ao workflow
- [ ] Workflow salvo
- [ ] Teste realizado

---

**Tempo Estimado de Configuração:** 15-20 minutos  
**Complexidade:** Média (requer atenção aos detalhes das mensagens)

---

**Fim do Guia**
