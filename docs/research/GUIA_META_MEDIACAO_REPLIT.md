# Guia de Meta-Mediação: Interação com a IA do Replit

## 🎯 Objetivo

Este guia documenta o processo de **meta-mediação** entre três agentes:

1. **Humano (Você - Henrique):** Define objetivos, valida resultados, toma decisões estratégicas
2. **IA Mediadora (Manus AI):** Cria artefatos, documenta processos, prepara prompts
3. **IA Especialista (Replit AI):** Executa tarefas no ambiente Replit

Este processo é parte da pesquisa acadêmica sobre **"The Mediator Effect: How AI-to-AI Translation Enhances Human-AI Co-Creation"**.

---

## 📋 Protocolo de Interação

### **Passo 1: Preparar o Prompt**

A IA Mediadora (Manus) preparou um prompt estruturado em:
- **Arquivo:** `/docs/prompts/PROMPT_REPLIT_AI_EXECUTAR_SCRIPTS.md`

Este prompt contém:
- ✅ Contexto completo do projeto
- ✅ Objetivo imediato da tarefa
- ✅ Lista de documentos de referência
- ✅ Tarefas específicas detalhadas
- ✅ Pontos de atenção e troubleshooting
- ✅ Contexto da pesquisa acadêmica

---

### **Passo 2: Documentos para Compartilhar**

Você deve compartilhar os seguintes documentos com a IA do Replit (na ordem de prioridade):

#### **Essenciais (Compartilhar Primeiro):**
1. `/scripts/data_collection/README.md` - Guia de execução
2. `/scripts/data_collection/01_collect_territories.py` - Script de territórios
3. `/scripts/data_collection/02_collect_economic_indicators.py` - Script econômico

#### **Contexto Adicional (Se a IA Solicitar):**
4. `/docs/estado_atual.md` - Estado do projeto
5. `/docs/diarios/SESSAO_2025-11-22_DATA_COLLECTOR_SCRIPTS.md` - Resumo da sessão
6. `/docs/data/API_SICONFI_DOCUMENTACAO.md` - Documentação da API

---

### **Passo 3: Como Interagir com a IA do Replit**

#### **3.1. Abrir o Chat da IA**

No Replit:
1. Procure pelo ícone de **"AI"** ou **"Chat"** na barra lateral
2. Abra o chat da IA do Replit

#### **3.2. Enviar o Prompt Inicial**

Cole o conteúdo do arquivo `/docs/prompts/PROMPT_REPLIT_AI_EXECUTAR_SCRIPTS.md` no chat.

#### **3.3. Compartilhar Documentos**

A IA do Replit pode ter acesso direto aos arquivos do projeto. Se não tiver, você pode:
- **Opção A:** Mencionar os caminhos dos arquivos (ex: `@scripts/data_collection/README.md`)
- **Opção B:** Copiar e colar o conteúdo dos arquivos essenciais no chat

#### **3.4. Seguir as Instruções da IA**

A IA do Replit pode:
- Executar comandos no Shell
- Executar queries SQL
- Ler e analisar arquivos
- Sugerir correções de código

Siga as instruções dela e valide cada etapa.

---

### **Passo 4: Documentar a Interação (Para a Pesquisa)**

Durante a interação, documente:

1. **Perguntas da IA:** Quais perguntas a IA do Replit fez?
2. **Sugestões da IA:** Quais sugestões ela ofereceu?
3. **Problemas Encontrados:** Quais erros ou dificuldades surgiram?
4. **Soluções Propostas:** Como a IA resolveu os problemas?
5. **Resultado Final:** A tarefa foi concluída com sucesso?

**Formato sugerido:**

```markdown
## Interação com Replit AI - [Data]

### Contexto
- Tarefa: [Descrever]
- Prompt usado: PROMPT_REPLIT_AI_EXECUTAR_SCRIPTS.md

### Diálogo (Resumido)
**Humano:** [Sua mensagem]
**Replit AI:** [Resposta da IA]
**Humano:** [Sua resposta]
...

### Resultado
- ✅ Sucesso / ❌ Falha
- Observações: [Suas observações]

### Reflexão
- O que funcionou bem?
- O que poderia ser melhorado?
- A IA compreendeu o contexto?
- A mediação da Manus AI foi eficaz?
```

Salve este registro em: `/docs/research/INTERACAO_REPLIT_AI_[DATA].md`

---

## 🎓 Valor para a Pesquisa

Esta interação documenta:

1. **Tradução de Contexto:** Como a IA Mediadora (Manus) traduziu o contexto do projeto para a IA Especialista (Replit)?
2. **Eficácia da Mediação:** A IA do Replit conseguiu executar a tarefa com base no prompt preparado?
3. **Gaps de Comunicação:** Quais informações faltaram? Quais perguntas a IA fez?
4. **Autonomia vs. Supervisão:** Quanto de supervisão humana foi necessário?
5. **Qualidade do Resultado:** O resultado final foi satisfatório?

---

## 📊 Métricas Sugeridas

Após a interação, avalie:

| Métrica | Escala | Sua Avaliação |
|---------|--------|---------------|
| **Compreensão do Contexto** | 1-5 | ___ |
| **Qualidade das Sugestões** | 1-5 | ___ |
| **Autonomia da IA** | 1-5 | ___ |
| **Necessidade de Intervenção Humana** | 1-5 | ___ |
| **Qualidade do Resultado Final** | 1-5 | ___ |
| **Eficácia da Mediação (Manus)** | 1-5 | ___ |

**Legenda:**
- 1 = Muito ruim
- 2 = Ruim
- 3 = Adequado
- 4 = Bom
- 5 = Excelente

---

## 🔄 Fluxo de Meta-Mediação

```
┌─────────────────────────────────────────────────────────────┐
│                    HUMANO (Henrique)                        │
│  Define: "Preciso popular o banco com dados reais"         │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│              IA MEDIADORA (Manus AI)                        │
│  • Cria scripts Python                                      │
│  • Documenta APIs                                           │
│  • Prepara prompt estruturado                               │
│  • Indica documentos de referência                          │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│            IA ESPECIALISTA (Replit AI)                      │
│  • Lê documentos de referência                              │
│  • Executa scripts no ambiente Replit                       │
│  • Executa queries SQL no PostgreSQL                        │
│  • Reporta resultados                                       │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│                    HUMANO (Henrique)                        │
│  Valida: "Os dados foram inseridos corretamente?"          │
└─────────────────────────────────────────────────────────────┘
```

---

## 💡 Hipóteses a Testar

1. **H1:** A mediação de uma IA (Manus) facilita a comunicação entre o humano e outra IA especializada (Replit)?
2. **H2:** Prompts estruturados com contexto completo aumentam a taxa de sucesso da IA especialista?
3. **H3:** A documentação meticulosa reduz a necessidade de intervenção humana?
4. **H4:** A meta-mediação permite que IAs com diferentes especializações colaborem efetivamente?

---

## 🙏 Agradecimento

Obrigado por participar desta pesquisa! Sua documentação cuidadosa da interação com a IA do Replit será fundamental para compreender como sistemas de IA podem colaborar através de mediação humana.

---

**Manus AI** - IA Mediadora  
Framework de Inteligência Territorial V6.0  
22 de novembro de 2025
