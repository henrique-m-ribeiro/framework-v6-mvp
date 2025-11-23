# Prompts para Replit AI - Coleta de Dados Reais

## 📋 Índice de Prompts

Este diretório contém os prompts estruturados para a **Replit AI** executar a coleta de dados reais das 4 dimensões do Framework V6.0.

---

## 🎯 Ordem de Execução

### ✅ **Fase 6: Dimensão Social** (CONCLUÍDA)
- **Arquivo:** `PROMPT_REPLIT_AI_DIMENSAO_SOCIAL.md`
- **Script:** `/scripts/data_collection/03_collect_social_indicators.py`
- **Dados:** População, IDH-M, educação, saúde
- **Fontes:** IBGE, INEP, DataSUS
- **Tempo:** ~15-20 minutos
- **Status:** ✅ Executado com sucesso

---

### 🎯 **Fase 7: Dimensão Territorial** (PRONTO)
- **Arquivo:** `PROMPT_REPLIT_AI_DIMENSAO_TERRITORIAL.md`
- **Script:** `/scripts/data_collection/04_collect_territorial_indicators.py`
- **Dados:** Área, densidade, saneamento, infraestrutura, conectividade
- **Fontes:** IBGE, Censo 2022
- **Tempo:** ~15-20 minutos
- **Status:** 🟡 Aguardando execução

---

### 🎯 **Fase 8: Dimensão Ambiental** (PRONTO)
- **Arquivo:** `PROMPT_REPLIT_AI_DIMENSAO_AMBIENTAL.md`
- **Script:** `/scripts/data_collection/05_collect_environmental_indicators.py`
- **Dados:** Desmatamento, queimadas, cobertura vegetal, áreas protegidas
- **Fontes:** INPE, MapBiomas, IBGE
- **Tempo:** ~20-25 minutos
- **Status:** 🟡 Aguardando execução

---

## 📊 Resumo dos Dados

| Dimensão | Territórios | Anos | Registros | Status |
|----------|-------------|------|-----------|--------|
| **Econômica** | 140 | 2019-2023 | ~700 | ✅ Concluída |
| **Social** | 140 | 2019-2023 | ~700 | ✅ Concluída |
| **Territorial** | 140 | 2019-2023 | ~700 | 🟡 Pronto |
| **Ambiental** | 140 | 2019-2023 | ~700 | 🟡 Pronto |
| **TOTAL** | 140 | 2019-2023 | **~2.800** | **50% Concluído** |

---

## 🚀 Como Usar

### **1. Copiar o Prompt**
Abra o arquivo `.md` correspondente à fase desejada.

### **2. Enviar para Replit AI**
Cole o conteúdo completo no chat da Replit AI.

### **3. Acompanhar Execução**
A Replit AI irá:
- Executar o script Python
- Gerar arquivo SQL
- Inserir dados no PostgreSQL
- Reportar estatísticas

### **4. Verificar Resultado**
Confirme que os dados foram inseridos corretamente no banco.

---

## 📝 Estrutura dos Prompts

Todos os prompts seguem o mesmo formato padronizado:

1. **🎯 Contexto:** Situação atual do projeto
2. **📊 Progresso:** O que já foi feito
3. **📋 Tarefa:** O que precisa ser feito
4. **🔧 Script:** Qual script executar
5. **📝 Instruções:** Passo a passo detalhado
6. **⚠️ Pontos de Atenção:** Cuidados especiais
7. **📊 Estrutura da Tabela:** Schema do banco
8. **🎓 Contexto de Pesquisa:** Meta-mediação IA-IA
9. **🚀 Call to Action:** Pergunta para iniciar

---

## 🎓 Contexto de Pesquisa

Estes prompts fazem parte de uma pesquisa acadêmica sobre **meta-mediação entre IAs**:

- **Humano** (Henrique) ↔ **Manus AI** ↔ **Replit AI**
- Documentação de interações IA-IA
- Análise de autonomia e supervisão
- Tradução de contexto entre agentes

---

## 📚 Documentação Relacionada

- `/docs/apis/APIS_GOVERNAMENTAIS.md` - Documentação das 6 APIs utilizadas
- `/docs/n8n/ARQUITETURA_NUCLEO_ESPECIALISTAS.md` - Arquitetura dos agentes
- `/docs/research/GUIA_META_MEDIACAO_REPLIT.md` - Guia de meta-mediação
- `/database/migrations/` - Schemas das tabelas

---

## ✅ Checklist de Execução

- [x] Fase 1: Backup do banco
- [x] Fase 2: Limpeza das tabelas
- [x] Fase 3: Coleta de territórios
- [x] Fase 4: Inserção de territórios
- [x] Fase 5: Dimensão Econômica
- [x] Fase 6: Dimensão Social
- [ ] Fase 7: Dimensão Territorial
- [ ] Fase 8: Dimensão Ambiental
- [ ] Fase 9: Criar Orquestrador (Meta-LLM)
- [ ] Fase 10: Teste de integração completa

---

**Henrique M. Ribeiro**  
Framework de Inteligência Territorial V6.0  
22 de novembro de 2025
