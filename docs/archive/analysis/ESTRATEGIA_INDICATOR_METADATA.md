# Estratégia para Popular a Tabela `indicator_metadata`

## 🎯 Objetivo

Popular a tabela `indicator_metadata` com informações completas e precisas para todos os indicadores do sistema, garantindo que o dashboard seja didático e informativo.

---

## 📊 Situação Atual

- **Tabela:** `indicator_metadata`
- **Registros:** 0
- **Impacto:** Alto (UX do dashboard prejudicada)

---

## 📋 Estratégia Proposta: Geração Semi-Automática com Revisão Humana

### **Visão Geral:**

1. **Extrair** lista de indicadores do schema
2. **Gerar** metadados com IA (GPT-4)
3. **Revisar** e ajustar manualmente
4. **Inserir** no banco de dados

### **Vantagens:**
- ✅ **Velocidade:** Mais rápido que manual (1-2 horas vs 4-6 horas)
- ✅ **Qualidade:** IA gera base sólida, revisão humana garante precisão
- ✅ **Cobertura:** Garante que todos os indicadores sejam documentados
- ✅ **Padronização:** Formato consistente para todos os metadados

---

## 🚀 Passo-a-Passo da Implementação

### **Passo 1: Extrair Lista de Indicadores**

**Objetivo:** Criar uma lista completa de todos os indicadores das 4 dimensões.

**Script:** `extract_indicators.py`

```python
import json

# Lista de indicadores (código, nome, dimensão)
indicators = [
    # Econômicos
    {"code": "gdp", "name": "PIB", "dimension": "economic"},
    {"code": "gdp_per_capita", "name": "PIB per capita", "dimension": "economic"},
    {"code": "employment_rate", "name": "Taxa de emprego", "dimension": "economic"},
    {"code": "revenue", "name": "Receita total", "dimension": "economic"},
    
    # Sociais
    {"code": "idhm", "name": "IDH-M", "dimension": "social"},
    {"code": "population", "name": "População", "dimension": "social"},
    {"code": "literacy_rate", "name": "Taxa de alfabetização", "dimension": "social"},
    {"code": "income_per_capita", "name": "Renda per capita", "dimension": "social"},
    {"code": "ideb_anos_finais", "name": "IDEB (Anos Finais)", "dimension": "social"},
    {"code": "ideb_anos_iniciais", "name": "IDEB (Anos Iniciais)", "dimension": "social"},
    {"code": "taxa_conclusao_medio", "name": "Taxa de Conclusão (Ensino Médio)", "dimension": "social"},
    {"code": "taxa_conclusao_fundamental", "name": "Taxa de Conclusão (Ensino Fundamental)", "dimension": "social"},
    {"code": "expectativa_vida", "name": "Expectativa de Vida", "dimension": "social"},
    {"code": "cobertura_vacinal", "name": "Cobertura Vacinal", "dimension": "social"},
    {"code": "mortalidade_infantil", "name": "Mortalidade Infantil", "dimension": "social"},
    {"code": "leitos_por_mil_habitantes", "name": "Leitos por Mil Habitantes", "dimension": "social"},
    
    # Territoriais
    {"code": "area_km2", "name": "Área Territorial", "dimension": "territorial"},
    {"code": "density_per_km2", "name": "Densidade Demográfica", "dimension": "territorial"},
    {"code": "water_supply_pct", "name": "Abastecimento de Água (%)", "dimension": "territorial"},
    {"code": "sewage_pct", "name": "Esgotamento Sanitário (%)", "dimension": "territorial"},
    {"code": "garbage_collection_pct", "name": "Coleta de Lixo (%)", "dimension": "territorial"},
    
    # Ambientais
    {"code": "deforestation_km2", "name": "Desmatamento (km²)", "dimension": "environmental"},
    {"code": "fire_spots", "name": "Focos de Calor", "dimension": "environmental"},
    {"code": "native_vegetation_pct", "name": "Vegetação Nativa (%)", "dimension": "environmental"},
    {"code": "pasture_pct", "name": "Pastagem (%)", "dimension": "environmental"},
    {"code": "agriculture_pct", "name": "Agricultura (%)", "dimension": "environmental"}
]

# Salvar
with open("indicators_list.json", "w") as f:
    json.dump(indicators, f, indent=2, ensure_ascii=False)

print(f"✓ {len(indicators)} indicadores extraídos")
```

---

### **Passo 2: Gerar Metadados com IA**

**Objetivo:** Usar GPT-4 para criar uma base de metadados para cada indicador.

**Script:** `generate_metadata.py`

```python
import json
import os
from openai import OpenAI

client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

with open("indicators_list.json") as f:
    indicators = json.load(f)

metadata_list = []

for indicator in indicators:
    prompt = f"""
    Crie metadados completos para este indicador brasileiro:
    
    Código: {indicator["code"]}
    Nome: {indicator["name"]}
    Dimensão: {indicator["dimension"]}
    
    Retorne APENAS um JSON válido com:
    {{
      "indicator_code": "{indicator["code"]}",
      "dimension": "{indicator["dimension"]}",
      "name": "nome completo em português",
      "description": "descrição clara em 2-3 frases",
      "unit": "unidade de medida",
      "source": "fonte oficial (IBGE, SICONFI, DataSUS, INEP, INPE)",
      "methodology": "como é calculado",
      "interpretation_guide": "como interpretar valores",
      "good_range": {{"min": X, "max": Y}},
      "alert_range": {{"min": X, "max": Y}}
    }}
    """
    
    response = client.chat.completions.create(
        model="gpt-4",
        messages=[{"role": "user", "content": prompt}],
        temperature=0.3
    )
    
    metadata = json.loads(response.choices[0].message.content)
    metadata_list.append(metadata)
    
    print(f"✓ {indicator["code"]}")

# Salvar
with open("indicator_metadata.json", "w") as f:
    json.dump(metadata_list, f, indent=2, ensure_ascii=False)

print(f"\n✓ {len(metadata_list)} metadados gerados")
```

---

### **Passo 3: Revisão e Ajuste Manual**

**Objetivo:** Garantir a precisão e qualidade dos metadados gerados.

**Processo:**
1. Abrir `indicator_metadata.json`
2. Revisar cada registro, focando em:
   - **Precisão técnica:** Fontes, metodologias, unidades
   - **Clareza:** Descrições e guias de interpretação
   - **Consistência:** Padronização de termos
3. Fazer ajustes diretamente no JSON

**Ferramentas:**
- VS Code (ou editor de texto)
- Planilha (para revisão em equipe)

---

### **Passo 4: Inserir no Banco de Dados**

**Objetivo:** Popular a tabela `indicator_metadata` com os dados revisados.

**Script:** `insert_metadata.py`

```python
import json
import psycopg2
import os

# Conectar
conn = psycopg2.connect(os.getenv("DATABASE_URL"))
cur = conn.cursor()

# Ler metadados
with open("indicator_metadata.json") as f:
    metadata_list = json.load(f)

# Inserir
for metadata in metadata_list:
    cur.execute("""
        INSERT INTO indicator_metadata (
            indicator_code, dimension, name, description, unit,
            source, methodology, interpretation_guide, 
            good_range, alert_range
        ) VALUES (
            %(indicator_code)s, %(dimension)s, %(name)s, %(description)s, %(unit)s,
            %(source)s, %(methodology)s, %(interpretation_guide)s,
            %(good_range)s, %(alert_range)s
        )
        ON CONFLICT (indicator_code) DO UPDATE SET
            name = EXCLUDED.name,
            description = EXCLUDED.description,
            unit = EXCLUDED.unit,
            source = EXCLUDED.source,
            methodology = EXCLUDED.methodology,
            interpretation_guide = EXCLUDED.interpretation_guide,
            good_range = EXCLUDED.good_range,
            alert_range = EXCLUDED.alert_range
    """, metadata)
    
    print(f"✓ {metadata["indicator_code"]}")

conn.commit()
print(f"\n✓ {len(metadata_list)} metadados inseridos")
```

---

## ⏰ Cronograma e Recursos

| Fase | Duração | Custo | Responsável |
|------|---------|-------|-------------|
| 1. Extrair Indicadores | 30 min | $0 | Manus AI |
| 2. Gerar Metadados | 1 hora | ~$0.10 | Manus AI (GPT-4) |
| 3. Revisão Manual | 2-3 horas | $0 | Humano (Você) |
| 4. Inserir no Banco | 15 min | $0 | Manus AI |
| **TOTAL** | **~4 horas** | **~$0.10** | **Equipe** |

---

## 🎯 Resultado Esperado

- Tabela `indicator_metadata` populada com ~50-80 registros
- Dashboard com tooltips explicativos
- Usuários com contexto para interpretar dados
- Base sólida para documentação futura

---

## 🚀 Próximos Passos

1. **Executar `extract_indicators.py`** para criar a lista
2. **Executar `generate_metadata.py`** para gerar a base
3. **Revisar `indicator_metadata.json`** manualmente
4. **Executar `insert_metadata.py`** para popular o banco

---

**Framework de Inteligência Territorial V6.0**  
Henrique M. Ribeiro  
23 de novembro de 2025
