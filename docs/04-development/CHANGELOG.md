# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/).

---

## [V5.1] - 2025-12-14 (Sessão #16)

### 🐛 Corrigido (Fixed)

**Bugs críticos no Orquestrador V5.0:**

1. **Bug #1: OpenAI - Interpretar Requisição sem "role: user"**
   - **Sintoma:** Erro 400 Bad Request na chamada OpenAI
   - **Causa:** Segunda mensagem no array não tinha o campo `"role": "user"`
   - **Solução:** Adicionado `"role": "user"` na segunda mensagem do nó OpenAI

2. **Bug #2: OpenAI - Sintetizar Análises sem "role: user"**
   - **Sintoma:** Erro 400 Bad Request na síntese final
   - **Causa:** Mensagem de síntese sem role definido
   - **Solução:** Corrigido formato de mensagem para OpenAI

3. **Bug #3: Incompatibilidade selected_agents vs agent_ids**
   - **Sintoma:** Agentes não eram chamados corretamente
   - **Causa:** Campo `selected_agents` usado em vez de `agent_ids`
   - **Solução:** Padronizado uso de `agent_ids` em todo o workflow

4. **Bug #4: Campo analysis_type não enviado**
   - **Sintoma:** Agentes não recebiam tipo de análise
   - **Causa:** Campo faltando no payload
   - **Solução:** Adicionado `analysis_type` ao payload dos agentes

5. **Bug #5: Referência incorreta no Code - Buscar URL**
   - **Sintoma:** URL do webhook não era encontrada
   - **Causa:** Referência errada ao campo `webhook_url`
   - **Solução:** Corrigida referência para `$json.webhook_url`

6. **Bug #6: HTTP Request referencia campos inexistentes**
   - **Sintoma:** Requisições HTTP falhavam
   - **Causa:** Campos do payload não existiam no contexto
   - **Solução:** Ajustadas referências para campos corretos

7. **Bug #7: Code - Agregar Respostas assume estrutura diferente**
   - **Sintoma:** Agregação de respostas falhava
   - **Causa:** Estrutura de dados diferente da esperada
   - **Solução:** Ajustada lógica de agregação

### 📝 Documentado (Documented)

- Criado guia de correção do nó OpenAI (`docs/guides/correcao_openai_node.md`)
- Atualizado README.md com próximos objetivos
- Documentada arquitetura multiterritorial (`docs/roadmap/ANALISE_MULTITERRITORIAL.md`)

---

## [V5.0] - 2025-12-12 (Sessão #14-15)

### ✨ Adicionado (Added)

**Orquestrador V5.0 - Análise Multidimensional:**

- **Agent Registry no PostgreSQL:** Registro centralizado de agentes com metadados
- **Análise Multidimensional:** Capacidade de chamar múltiplos agentes em uma única requisição
- **Suporte a Múltiplos Territórios:** Preparação para análises comparativas
- **Workflow Dinâmico:** Orquestrador busca informações dos agentes no banco de dados

**Agentes V6.1:**

- Atualizado nó "Estruturar Resposta" em todos os 4 agentes
- Corrigido formato de resposta para compatibilidade com Orquestrador V5.0

### 🔧 Modificado (Changed)

- Refatorado fluxo de chamada de agentes no Orquestrador
- Melhorado tratamento de erros e logging
- Otimizado payload enviado aos agentes

### 📝 Documentado (Documented)

- Criado Diário de Pesquisa-Ação da Sessão #15
- Documentados guias de atualização dos agentes (SOCIAL, TERRA, AMBIENT)
- Criado guia de melhorias do Orquestrador

---

## [V4.0] - 2025-12-08 (Sessão #13)

### ✨ Adicionado (Added)

**Arquitetura V4.0 - Multidimensional e Multiterritorial:**

- **IDs Semânticos:** Implementação de `request_id` e `analysis_id` legíveis por humanos
  - Formato: `YYYYMMDDHHMMSS-req-IBGE` e `YYYYMMDDHHMMSS-ana-IBGE-AGENTE`
- **5 Novos Campos de Metadados:**
  1. `request_id` (varchar)
  2. `analysis_id` (varchar)
  3. `territory_id` (varchar)
  4. `territory_name` (varchar)
  5. `analysis_timestamp` (timestamp)
- **Orquestrador V4.0:** Nova versão com suporte a análises multidimensionais

### 🗄️ Banco de Dados (Database)

**Migrações Executadas:**

1. **001_migrate_id_to_varchar_v2.sql**
   - Migração de IDs de `uuid` para `varchar(255)`
   - Aplicado em todas as tabelas de memória dos agentes

2. **002_add_metadata_fields.sql**
   - Adição de 5 campos de metadados estruturados
   - Aplicado em `knowledge_base` e tabelas de memória

### 🔧 Modificado (Changed)

- Atualizado schema do banco de dados para suportar nova arquitetura
- Refatorado sistema de IDs em todo o sistema
- Melhorado rastreamento de análises

### 📝 Documentado (Documented)

- Criado `ARQUITETURA_V4_IDs_E_METADADOS.md`
- Criado `ORQUESTRADOR_V4_EXPLICACAO_DETALHADA.md`
- Criado guias de atualização para Orquestrador e Agentes
- Criado Diário de Pesquisa-Ação da Sessão #13

---

## [V3.2] - 2025-12-06 (Sessão #12)

### ✨ Adicionado (Added)

**Primeiro Teste Bem-Sucedido do Orquestrador:**

- Implementado Orquestrador V3.2 funcional
- Teste bem-sucedido de chamada ao Agente ECON
- Salvamento correto na `knowledge_base`

### 🐛 Corrigido (Fixed)

- Corrigido formato de resposta do webhook
- Ajustado payload de chamada aos agentes
- Corrigido salvamento no banco de dados

### 📝 Documentado (Documented)

- Criado `TESTE_ORQUESTRADOR_SUCESSO_SESSAO_12.md`
- Documentado fluxo completo de ponta a ponta
- Criado Diário de Pesquisa-Ação da Sessão #12

---

## [V3.0] - 2025-11-XX (Sessões #8-11)

### ✨ Adicionado (Added)

**Agentes Especializados V6.0:**

- Implementado Agente Econômico (ECON)
- Implementado Agente Social (SOCIAL)
- Implementado Agente Territorial (TERRA)
- Implementado Agente Ambiental (AMBIENT)

**Funcionalidades:**

- Sistema RAG (Retrieval-Augmented Generation) de 4 camadas
- Memória distribuída por agente
- Integração com OpenAI GPT-4
- Consulta ao banco de dados PostgreSQL (Neon)

### 🗄️ Banco de Dados (Database)

- Criado schema completo com 22 tabelas
- Populado banco com 4.089 indicadores do Tocantins
- Implementadas 4 camadas RAG:
  1. Dados Estruturados (indicadores quantitativos)
  2. Documentos e Políticas (PDFs e documentos oficiais)
  3. Base de Conhecimento (análises geradas)
  4. Memória dos Agentes (histórico de interações)

### 📝 Documentado (Documented)

- Criada documentação inicial do projeto
- Documentada arquitetura de duas camadas
- Criados primeiros diários de pesquisa-ação

---

## [V2.0] - 2025-10-XX

### ✨ Adicionado (Added)

**Dashboard Web (Replit):**

- Implementado frontend em React + TypeScript
- Interface de chat com IA
- Visualização de indicadores territoriais
- Deploy no Replit

---

## [V1.0] - 2025-09-XX

### ✨ Adicionado (Added)

**Conceito Inicial:**

- Definição da visão do Framework V6.0
- Planejamento da arquitetura de 19 agentes
- Definição do MVP (4 agentes + Orquestrador)

---

## 🔮 Próximas Versões (Roadmap)

### [V6.0] - Planejado

**Análise Multiterritorial:**

- [ ] Fase 1: Orquestrador identifica múltiplos territórios
- [ ] Fase 2: Agentes processam múltiplos territórios
- [ ] Fase 3: Suporte a regiões informais e microrregiões

**Expansão de Agentes:**

- [ ] Implementação dos 15 agentes restantes (total de 19)
- [ ] Meta-Orquestrador para coordenação avançada
- [ ] Data Collector para monitoramento contínuo

**Funcionalidades Avançadas:**

- [ ] Análise temporal (comparação entre períodos)
- [ ] Análise preditiva (projeções futuras)
- [ ] Integração com fontes externas em tempo real
- [ ] Sistema de alertas e notificações

---

## 📊 Estatísticas do Projeto

| Métrica | Valor Atual |
|---------|-------------|
| **Versão Atual** | V5.1 |
| **Agentes Implementados** | 4/19 (21%) |
| **Workflows n8n** | 6 (1 Orquestrador + 4 Agentes + 1 Teste) |
| **Tabelas no BD** | 22 |
| **Indicadores Cadastrados** | 4.089 |
| **Sessões de Desenvolvimento** | 16 |
| **Linhas de Documentação** | ~82.804 |
| **Documentos .md** | 209 |

---

## 🤝 Como Contribuir

Para contribuir com o projeto, consulte:
- [CONTRIBUTING.md](CONTRIBUTING.md) - Guia de contribuição
- [CONVENTIONS.md](CONVENTIONS.md) - Convenções de código e nomenclatura

---

## 📝 Notas

- Este changelog segue o formato [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/)
- As versões seguem [Versionamento Semântico](https://semver.org/lang/pt-BR/)
- Para detalhes técnicos de cada sessão, consulte os [Diários de Pesquisa-Ação](../05-research/diaries/)
