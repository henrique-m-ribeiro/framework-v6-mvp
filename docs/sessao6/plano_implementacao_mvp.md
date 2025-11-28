# Plano de Implementação Detalhado: MVP Robusto

**Framework de Inteligência Territorial V6.0**

**Foco:** Implementação do MVP Robusto em 6 semanas
**Agente Piloto:** Agente ECON

---

## 🎯 OBJETIVO DO MVP

Validar a arquitetura RAG evolutiva de 3 camadas em um cenário real, com o Agente ECON, gerando 50 análises de alta qualidade sobre 5 municípios do Tocantins. O MVP deve ser robusto, auditável e demonstrar a capacidade de aprendizado e evolução do agente.

---

## 📅 ROADMAP DE IMPLEMENTAÇÃO (6 SEMANAS)

### 🚀 FASE 1: Infraestrutura e Curadoria (Semanas 1-2)

**Objetivo:** Preparar o ambiente e a base de conhecimento inicial.

| Tarefa | Descrição | Critérios de Conclusão |
|---|---|---|
| **1.1. Configurar Ambiente** | Instalar LangChain, psycopg2-binary, Streamlit. Configurar variáveis de ambiente. | Ambiente de desenvolvimento local funcionando. |
| **1.2. Estruturar Banco de Dados** | Validar e, se necessário, ajustar as tabelas `knowledge_base`, `agent_econ_memory`, `agent_econ_learning`. | Tabelas prontas para receber dados. |
| **1.3. Implementar Auditoria** | Criar a classe `AuditTrail` e a tabela `audit_trail` no PostgreSQL. | Eventos de teste são logados e recuperados com sucesso. |
| **1.4. Curadoria Assistida** | Implementar o script de curadoria assistida. Executar para sugerir 30-40 documentos. | 10-15 documentos selecionados e armazenados em `agent_econ_memory`. |
| **1.5. Relações Espaciais** | Implementar e executar o script para pré-computar relações de vizinhança para o Agente TERRA. | Tabela `agent_terra_memory` populada com dados espaciais. |

**Entregas da Fase 1:**
- ✅ Sistema de auditoria funcionando.
- ✅ `agent_econ_memory` populado com 10-15 documentos.
- ✅ `agent_terra_memory` populado com dados de vizinhança.

---

### ⚙️ FASE 2: Ciclo de Aprendizagem (Semanas 3-4)

**Objetivo:** Implementar o fluxo completo de geração e aprendizado.

| Tarefa | Descrição | Critérios de Conclusão |
|---|---|---|
| **2.1. Busca Vetorial** | Implementar a função de busca adaptativa nas 3 camadas, usando `pgvector`. | A busca retorna resultados relevantes de cada camada. |
| **2.2. Reflection Loop** | Implementar a função de reflection que avalia a suficiência do contexto. | O loop de reflection funciona e, se necessário, refina a busca. |
| **2.3. Geração de Análise** | Implementar a função que gera a análise, passando o contexto recuperado. | Uma análise de teste é gerada com sucesso. |
| **2.4. Validação de Qualidade** | Implementar a validação de qualidade híbrida (LLM + revisão humana). | Análises são avaliadas e aprovadas/rejeitadas corretamente. |
| **2.5. Extração de Padrões** | Implementar a extração de padrões com reflection após a geração da análise. | Padrões são extraídos e armazenados em `agent_econ_learning`. |
| **2.6. Armazenamento Seletivo** | Implementar a lógica para armazenar apenas análises de alta qualidade em `knowledge_base`. | Apenas análises com score > 0.8 são armazenadas. |

**Entregas da Fase 2:**
- ✅ Ciclo completo de Preparação → Geração → Aprendizado funcionando.
- ✅ 10 análises de teste geradas e armazenadas.
- ✅ ~5-10 padrões iniciais em `agent_econ_learning`.

---

### 🏆 FASE 3: Refinamento e Validação (Semanas 5-6)

**Objetivo:** Refinar as funcionalidades, gerar o volume de dados do MVP e validar os resultados.

| Tarefa | Descrição | Critérios de Conclusão |
|---|---|---|
| **3.1. Comunicação Adaptativa** | Implementar a camada de adaptação que gera 3 níveis de análise (iniciante, intermediário, avançado). | A mesma análise profunda é apresentada em 3 formatos diferentes. |
| **3.2. Validação de Rigor** | Implementar a validação de rigor científico e a marcação de hipóteses. | Análises são marcadas com disclaimers quando necessário. |
| **3.3. Poda e Arquivamento** | Implementar os scripts de poda e arquivamento (execução manual no MVP). | Scripts identificam e arquivam análises/padrões obsoletos. |
| **3.4. Geração em Lote** | Gerar 50 análises (10 para cada um dos 5 municípios de teste). | 50 análises de alta qualidade geradas e armazenadas. |
| **3.5. Validar Padrões** | Analisar os padrões emergentes em `agent_econ_learning`. | 20-30 padrões identificados, com pelo menos 10 com `confidence` > 0.8. |
| **3.6. Relatório de Validação** | Preparar um relatório final do MVP com as métricas de sucesso. | Relatório gerado e validado. |

**Entregas da Fase 3:**
- ✅ 50 análises de alta qualidade sobre 5 municípios.
- ✅ 20-30 padrões validados em `agent_econ_learning`.
- ✅ Agente ECON atinge o estágio "Iniciante Avançado".
- ✅ Relatório final do MVP com métricas de sucesso.

---

## 🛠️ STACK TÉCNICO (MVP)

-   **Orchestration:** LangChain
-   **Banco de Dados Vetorial:** PostgreSQL com `pgvector`
-   **LLM:** OpenAI API (GPT-4.1 para geração, `text-embedding-3-large` para embeddings)
-   **Interface de Auditoria:** Streamlit
-   **Linguagem:** Python 3.11

---

## 📊 MÉTRICAS DE SUCESSO (MVP)

| Métrica | Target |
|---|---|
| **Qualidade média das análises** | > 0.80 |
| **Padrões validados (confidence > 0.8)** | 10+ |
| **Tempo de geração por análise** | < 20 segundos |
| **Taxa de aprovação automática (qualidade)** | > 70% |
| **Estágio de expertise (Agente ECON)** | Atingir "Iniciante Avançado" |
| **Satisfação do usuário (feedback simulado)** | > 4.0 / 5.0 |

---

## ⚠️ RISCOS E MITIGAÇÕES

| Risco | Mitigação |
|---|---|
| **Qualidade das análises baixa** | Validação híbrida, ajuste de prompts, curadoria de alta qualidade. |
| **Padrões não emergem** | Aumentar o número de análises de teste, refinar o prompt de extração. |
| **Custos de API** | Monitoramento constante, caching de embeddings, compressão de contexto. |
| **Complexidade do LangChain** | Focar em componentes essenciais, seguir documentação e exemplos. |
