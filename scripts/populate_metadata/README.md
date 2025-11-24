# Scripts para Popular `indicator_metadata`

## 📋 Visão Geral

Estes scripts automatizam o processo de criação e inserção de metadados para todos os indicadores do sistema.

---

## 🚀 Uso Rápido

```bash
# 1. Extrair lista de indicadores
python3 01_extract_indicators.py

# 2. Gerar metadados com IA (requer OPENAI_API_KEY)
export OPENAI_API_KEY="sua-chave"
python3 02_generate_metadata.py

# 3. Revisar indicator_metadata.json manualmente (opcional mas recomendado)

# 4. Inserir no banco (requer DATABASE_URL)
export DATABASE_URL="postgresql://..."
python3 03_insert_metadata.py
```

---

## 📁 Scripts

### **01_extract_indicators.py**

**Função:** Extrai a lista completa de indicadores das 4 dimensões.

**Saída:** `indicators_list.json`

**Tempo:** < 1 segundo

**Exemplo de saída:**
```json
[
  {
    "code": "idhm",
    "name": "IDH-M",
    "dimension": "social",
    "unit": "índice (0-1)"
  },
  ...
]
```

---

### **02_generate_metadata.py**

**Função:** Usa GPT-4 para gerar metadados completos para cada indicador.

**Entrada:** `indicators_list.json`

**Saída:** `indicator_metadata.json`

**Requisitos:**
- `pip install openai`
- `export OPENAI_API_KEY="..."`

**Tempo:** ~5-10 minutos (depende da quantidade de indicadores)

**Custo:** ~$0.10 (GPT-4)

**Exemplo de saída:**
```json
[
  {
    "indicator_code": "idhm",
    "dimension": "social",
    "name": "Índice de Desenvolvimento Humano Municipal",
    "description": "Medida composta que avalia...",
    "unit": "índice (0-1)",
    "source": "IBGE - Censo Demográfico",
    "methodology": "Média geométrica dos índices...",
    "interpretation_guide": "0-0.499: Muito Baixo | 0.500-0.599: Baixo...",
    "good_range": {"min": 0.700, "max": 1.000},
    "alert_range": {"min": 0.000, "max": 0.599}
  },
  ...
]
```

---

### **03_insert_metadata.py**

**Função:** Insere os metadados gerados na tabela `indicator_metadata` do PostgreSQL.

**Entrada:** `indicator_metadata.json`

**Requisitos:**
- `pip install psycopg2-binary`
- `export DATABASE_URL="postgresql://..."`

**Tempo:** < 1 minuto

**Comportamento:**
- Cria a tabela se não existir
- Usa `ON CONFLICT` para atualizar registros existentes
- Não duplica dados

---

## 🔧 Instalação de Dependências

```bash
pip install openai psycopg2-binary
```

---

## 🎯 Resultado Esperado

Após executar os 3 scripts:

- ✅ Tabela `indicator_metadata` populada com ~35-40 registros
- ✅ Dashboard com tooltips explicativos
- ✅ Usuários com contexto para interpretar dados

---

## 📝 Notas

- **Revisão Manual:** Recomenda-se revisar `indicator_metadata.json` antes de inserir no banco para garantir precisão técnica.
- **Custo:** O custo total é mínimo (~$0.10) e pode ser reduzido usando modelos mais baratos.
- **Atualização:** Para atualizar metadados, basta executar novamente os scripts. O script 03 usa `ON CONFLICT DO UPDATE`.

---

**Framework de Inteligência Territorial V6.0**  
Henrique M. Ribeiro
