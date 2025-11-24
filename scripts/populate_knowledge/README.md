# Script para Popular `knowledge_base`

## 📋 Visão Geral

Este script automatiza a geração em lote de análises de IA para múltiplos territórios, populando a tabela `knowledge_base`.

---

## 🚀 Uso Rápido

```bash
# Instalar dependências
pip install requests psycopg2-binary

# Configurar variáveis de ambiente
export DATABASE_URL="postgresql://..."

# Gerar análises para os 20 maiores municípios (RECOMENDADO)
python3 batch_generate_analyses.py --top 20

# OU gerar para todos os 139 municípios
python3 batch_generate_analyses.py --all
```

---

## 📁 Script

### **batch_generate_analyses.py**

**Função:** Gera análises de IA para múltiplos territórios usando os 4 agentes especialistas.

**Requisitos:**
- `pip install requests psycopg2-binary`
- `export DATABASE_URL="postgresql://..."`
- Agentes especialistas ativos no n8n

**Opções:**
- `--top N`: Gera análises para os N maiores municípios (por população)
- `--all`: Gera análises para todos os 139 municípios

**Tempo:**
- Top 20: ~30 minutos
- Todos (139): ~3-4 horas

**Custo:**
- Top 20: ~$0.08 (80 análises × $0.001)
- Todos: ~$0.56 (560 análises × $0.001)

---

## 🔧 Configuração

### **1. URLs dos Webhooks**

Edite o arquivo `batch_generate_analyses.py` e configure as URLs dos seus agentes:

```python
AGENTS = {
    'economic': 'https://sua-instancia.app.n8n.cloud/webhook/agent-econ',
    'social': 'https://sua-instancia.app.n8n.cloud/webhook/agent-social',
    'territorial': 'https://sua-instancia.app.n8n.cloud/webhook/agent-terra',
    'environmental': 'https://sua-instancia.app.n8n.cloud/webhook/agent-ambient'
}
```

### **2. Verificar Agentes**

Certifique-se de que os 4 agentes especialistas estão ativos no n8n:

```bash
# Testar agente econômico
curl -X POST https://sua-instancia.app.n8n.cloud/webhook/agent-econ \
  -H "Content-Type: application/json" \
  -d '{"territory_id": "1721000", "territory_name": "Palmas"}'
```

---

## 📊 Exemplo de Execução

```bash
$ python3 batch_generate_analyses.py --top 20

======================================================================
GERAÇÃO EM LOTE DE ANÁLISES
======================================================================

📊 Territórios: 20
🤖 Dimensões: 4 (economic, social, territorial, environmental)
📝 Total de análises: 80
⏱️  Tempo estimado: 10.7 minutos
💰 Custo estimado: ~$0.08

======================================================================

Pressione ENTER para iniciar...

[1/20] Palmas (pop: 306,296)
  • economic... ✓
  • social... ✓
  • territorial... ✓
  • environmental... ✓

[2/20] Araguaína (pop: 183,381)
  • economic... ✓
  • social... ✓
  • territorial... ✓
  • environmental... ✓

...

======================================================================
GERAÇÃO CONCLUÍDA
======================================================================

⏱️  Tempo total: 11.2 minutos

📊 Estatísticas:
  • Total processadas: 80
  • Sucesso: 78 (97.5%)
  • Erros: 2

📈 Por dimensão:
  • economic: 20
  • environmental: 19
  • social: 20
  • territorial: 19

🗄️  Total na knowledge_base: 78

🎉 Análises prontas para uso no dashboard!
======================================================================
```

---

## 🎯 Resultado Esperado

Após executar o script:

- ✅ Tabela `knowledge_base` populada com análises
- ✅ Dashboard com respostas instantâneas para territórios processados
- ✅ Base de conhecimento pronta para RAG (após gerar embeddings)

---

## 🔄 Estratégia Híbrida (Recomendada)

1. **Executar `--top 20`** para os municípios mais importantes
2. **Implementar cache sob demanda** no backend do dashboard
3. **Executar `--all`** posteriormente para completar a base

Isso garante performance imediata nos casos de uso mais comuns enquanto mantém cobertura completa.

---

## 📝 Notas

- **Rate Limiting:** O script aguarda 2 segundos entre cada chamada para evitar sobrecarga
- **Idempotência:** Usa `ON CONFLICT DO UPDATE`, então pode ser reexecutado sem duplicar dados
- **Erros:** Se um agente falhar, o script continua e registra o erro
- **Tabela:** Se a tabela `knowledge_base` não existir, o script a cria automaticamente

---

## 🚀 Próximos Passos

Após popular a `knowledge_base`:

1. **Gerar embeddings** para habilitar RAG
2. **Implementar busca semântica** no dashboard
3. **Criar sistema de atualização periódica** (mensal)

---

**Framework de Inteligência Territorial V6.0**  
Henrique M. Ribeiro
