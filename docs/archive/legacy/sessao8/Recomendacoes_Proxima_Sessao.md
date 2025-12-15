# Recomendações para a Próxima Sessão

**Projeto:** Framework de Superinteligência Territorial V6.0  
**Data:** 30/11/2025

---

## 🎯 Objetivo Principal

**Concluir a Fase 2 do MVP: Implementação do Ciclo de Aprendizagem Evolutiva.**

---

## 🚀 Plano de Ação Recomendado

### 1. Alinhar Schemas (Prioridade Máxima)

- **Tarefa:** Criar e executar uma migração para adicionar o campo `agent_id` (tipo `VARCHAR(255)`) às tabelas `agent_econ_memory`, `agent_social_memory`, `agent_terra_memory` e `agent_ambient_memory`.
- **Justificativa:** Este é um **bloqueador crítico**. Sem este campo, o ciclo de aprendizagem não pode ser testado ou implementado.

### 2. Popular Campo `agent_id`

- **Tarefa:** Após a migração, executar um script para popular o novo campo `agent_id` com o ID do agente correspondente para todos os registros existentes.
- **Justificativa:** Garante a integridade dos dados e a associação correta das análises aos agentes.

### 3. Finalizar Testes do Ciclo de Aprendizagem

- **Tarefa:** Executar o script `test_learning_cycle_simple.py` e validar que o ciclo completo funciona sem erros.
- **Justificativa:** Garante que a lógica de arquivamento, aprendizado e cálculo de expertise está correta.

### 4. Integrar com n8n

- **Tarefa:** Importar o workflow `WF-AGENTE-APRENDIZAGEM-GATILHO-V1.json` no n8n, configurar as credenciais e ativar o webhook.
- **Justificativa:** Ativa o gatilho do ciclo de aprendizagem no ambiente de produção.

### 5. Atualizar Documentação

- **Tarefa:** Atualizar o Modelo Conceitual v4.0 e a documentação de arquitetura para refletir o schema real e as decisões tomadas.
- **Justificativa:** Mantém a documentação alinhada com a implementação e evita futuros gaps de contexto.

---

## 📊 Cronograma Estimado

| Tarefa | Estimativa |
|:---|:---:|
| **Alinhar Schemas** | 1-2 horas |
| **Popular `agent_id`** | 0.5-1 hora |
| **Finalizar Testes** | 1-2 horas |
| **Integrar com n8n** | 0.5-1 hora |
| **Atualizar Documentação** | 1-2 horas |
| **Total** | **4-8 horas** |

---

Com a execução deste plano, a Fase 2 do MVP será concluída e o Framework de Superinteligência Territorial V6.0 terá sua capacidade de aprendizado evolutivo totalmente ativada.
