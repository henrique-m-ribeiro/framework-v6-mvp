# Prompt para a IA do Replit: Executar Scripts de Coleta de Dados

## 🎯 Contexto do Projeto

Estou desenvolvendo o **Framework de Inteligência Territorial V6.0**, um sistema multi-agentes para análise de políticas públicas no estado do Tocantins, Brasil. Constante no seguinte projeto no Github: [https://github.com/henrique-m-ribeiro/framework-v6-mvp](https://github.com/henrique-m-ribeiro/framework-v6-mvp)    
O projeto integra:

- **Sistema multi-agentes** (n8n Cloud) com 4 agentes dimensionais (ECON, SOCIAL, TERRA, AMBIENT)  
- **Base de dados PostgreSQL** (Replit) com dados territoriais e indicadores  
- **Dashboard Web** (Replit) para visualização e interação

Este projeto faz parte de uma **pesquisa acadêmica** sobre co-criação IA-humano-IA (artigo em desenvolvimento para ACM TOCHI).

---

## 📋 Objetivo Imediato

Preciso executar **scripts Python** que coletam dados reais de APIs governamentais brasileiras (IBGE, SICONFI) e populam o banco de dados PostgreSQL com informações de **140 territórios** (139 municípios \+ 1 estado) para o período de **2019-2023**.

---

## 📁 Documentos de Referência

Por favor, leia os seguintes documentos para compreender o contexto completo:

1. **`/scripts/data_collection/README.md`** \- Guia de execução dos scripts (ESSENCIAL)  
2. **`/docs/estado_atual.md`** \- Estado atual do projeto e progresso  
3. **`/docs/diarios/SESSAO_2025-11-22_DATA_COLLECTOR_SCRIPTS.md`** \- Resumo da última sessão  
4. **`/docs/data/API_SICONFI_DOCUMENTACAO.md`** \- Documentação da API SICONFI  
5. **`/scripts/data_collection/01_collect_territories.py`** \- Script de coleta de territórios  
6. **`/scripts/data_collection/02_collect_economic_indicators.py`** \- Script de coleta econômica

---

## 🎯 Tarefa Específica

Preciso que você me ajude a:

### **Fase 1: Preparação**

1. Verificar se o repositório GitHub foi sincronizado (`git pull origin main`)  
2. Confirmar que os scripts estão no diretório `/scripts/data_collection/`  
3. Verificar se as bibliotecas Python necessárias estão instaladas (`requests`)

### **Fase 2: Executar Script de Territórios**

1. Executar `python3 scripts/data_collection/01_collect_territories.py`  
2. Verificar se o arquivo `insert_territories.sql` foi gerado  
3. Aplicar o SQL no banco de dados PostgreSQL (`psql $DATABASE_URL -f scripts/data_collection/insert_territories.sql`)  
4. Verificar se os 140 territórios foram inseridos (`SELECT COUNT(*) FROM territories;`)

### **Fase 3: Executar Script Econômico**

1. Executar `python3 scripts/data_collection/02_collect_economic_indicators.py`  
2. **ATENÇÃO:** Este script leva \~20-30 minutos (faz 1.400 requisições à API SICONFI)  
3. Verificar se o arquivo `insert_economic_indicators.sql` foi gerado  
4. Aplicar o SQL no banco de dados  
5. Verificar se os indicadores econômicos foram inseridos (`SELECT COUNT(*) FROM economic_indicators;`)

---

## ⚠️ Pontos de Atenção

1. **Tempo de Execução:** O script econômico é lento (\~20-30 min). Isso é normal.  
2. **Erros de API:** Algumas requisições podem falhar (timeout, dados indisponíveis). Os scripts têm tratamento de erros e continuam executando.  
3. **Logs:** Os scripts geram arquivos `.log` com detalhes de execução. Consulte-os se houver problemas.  
4. **Ordem:** É crucial executar os scripts na ordem correta (territórios primeiro, depois indicadores).

---

## 🎓 Contexto de Pesquisa (Meta-Mediação)

Esta interação faz parte de uma pesquisa sobre **meta-mediação IA-humano-IA**:

- **Humano (Henrique)** → define objetivos e valida resultados  
- **IA Mediadora (Manus AI)** → cria scripts, documenta e prepara prompts  
- **IA Especialista (Replit AI)** → executa tarefas no ambiente Replit

Estou documentando este processo para análise acadêmica sobre como IAs podem colaborar através de mediação humana.

---

## ❓ Perguntas para Você (IA do Replit)

1. Você consegue acessar e ler os documentos listados acima?  
2. Você consegue executar comandos no Shell do Replit?  
3. Você consegue executar queries SQL no banco de dados PostgreSQL?  
4. Qual é a melhor forma de você me auxiliar nesta tarefa?

---

## 📊 Resultado Esperado

Ao final, o banco de dados deve ter:

- **140 territórios** na tabela `territories`  
- **\~700 registros** na tabela `economic_indicators` (140 territórios × 5 anos)

---

## 🙏 Agradecimento

Obrigado por sua colaboração\! Esta é uma oportunidade única de explorar a interação entre diferentes sistemas de IA mediados por um humano, contribuindo para o avanço do conhecimento científico sobre co-criação IA-humano-IA.

---

**Henrique M. Ribeiro**  
Pesquisador \- Framework de Inteligência Territorial V6.0  
22 de novembro de 2025  
