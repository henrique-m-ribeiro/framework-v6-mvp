# Análise Completa das Bases de Dados do Replit

## 📊 Visão Geral

Análise detalhada das 10 tabelas exportadas do PostgreSQL do Replit, com foco especial em **knowledge_base** e **indicator_metadata**.

---

## 📋 Inventário das Tabelas

| Tabela | Tamanho | Registros | Status | Observações |
|--------|---------|-----------|--------|-------------|
| `territories` | 38 KB | **140** | ✅ Completa | Todos os territórios com coordenadas |
| `economic_indicators` | 164 KB | **700** | ✅ Completa | 4 dimensões × 140 × 5 anos |
| `social_indicators` | 458 KB | **1.114** | ⚠️ Extra | +414 registros (59% a mais) |
| `territorial_indicators` | 163 KB | **700** | ✅ Completa | Dados territoriais OK |
| `environmental_indicators` | 244 KB | **1.400** | ⚠️ Extra | +700 registros (100% a mais) |
| **`knowledge_base`** | **2 bytes** | **0** | ❌ **VAZIA** | **Crítico para IA** |
| **`indicator_metadata`** | **2 bytes** | **0** | ❌ **VAZIA** | **Crítico para UX** |
| `geometry_columns` | 2 bytes | 0 | ✅ OK | Sistema PostGIS |
| `geography_columns` | 167 bytes | 1 | ✅ OK | Sistema PostGIS |
| `spatial_ref_sys` | 7.3 MB | ~5.000 | ✅ OK | Sistema PostGIS |

---

## 🔍 Análise Detalhada

### **1. Tabelas de Dados (✅ Funcionando)**

#### **territories (140 registros)**

**Estrutura:**
```json
{
  "id": "17",
  "name": "Tocantins",
  "type": "Estado",
  "parent_id": null,
  "area": null,
  "metadata": {
    "regiao": "Norte",
    "codigo_ibge": "17"
  },
  "coordinates": "0101000020E6100000..." // PostGIS POINT
}
```

**Status:** ✅ **Completa e funcional**
- 139 municípios + 1 estado
- Coordenadas geográficas presentes
- Metadados básicos OK

---

#### **economic_indicators (700 registros)**

**Estrutura:**
```json
{
  "id": "uuid",
  "territory_id": "1720309",
  "year": 2021,
  "gdp": 606.98,
  "gdp_per_capita": 20390.45,
  "employment_rate": 59.9,
  "revenue": 80931064,
  "sector_distribution": {
    "servicos": 51.5,
    "industria": 27.8,
    "agricultura": 20.7
  }
}
```

**Status:** ✅ **Completa**
- 140 territórios × 5 anos = 700 registros
- Dados econômicos presentes
- Schema diferente do GitHub (mas funcional)

**Diferenças do Schema GitHub:**
| GitHub | Replit | Status |
|--------|--------|--------|
| `total_revenue` | `revenue` | ⚠️ Nome diferente |
| `total_expenditure` | (ausente) | ❌ Faltando |
| `fiscal_balance` | (ausente) | ❌ Faltando |

---

#### **social_indicators (1.114 registros)**

**Estrutura:**
```json
{
  "id": "uuid",
  "territory_id": "1700251",
  "year": 2019,
  "idhm": 0.614,
  "population": 32277,
  "literacy_rate": 75.1,
  "income_per_capita": 694.92,
  "education_metrics": {
    "ideb_anos_finais": 4.1,
    "ideb_anos_iniciais": 5.2,
    "taxa_conclusao_medio": 66.8,
    "taxa_conclusao_fundamental": 80.3
  },
  "health_metrics": {
    "expectativa_vida": 75.8,
    "cobertura_vacinal": 92.7,
    "mortalidade_infantil": 16.5,
    "leitos_por_mil_habitantes": 3.44
  }
}
```

**Status:** ⚠️ **Funcional mas com dados extras**
- Esperado: 700 registros
- Obtido: 1.114 registros (+414, +59%)
- Possível duplicação ou dados sintéticos misturados

**Diferenças do Schema GitHub:**
| GitHub | Replit | Status |
|--------|--------|--------|
| `hdi_m` | `idhm` | ⚠️ Nome diferente |
| Colunas separadas | `education_metrics` (JSON) | ⚠️ Estrutura diferente |
| Colunas separadas | `health_metrics` (JSON) | ⚠️ Estrutura diferente |

---

#### **territorial_indicators (700 registros)**

**Status:** ✅ **Completa**
- 140 territórios × 5 anos = 700 registros
- Dados territoriais presentes

---

#### **environmental_indicators (1.400 registros)**

**Status:** ⚠️ **Funcional mas com dados extras**
- Esperado: 700 registros
- Obtido: 1.400 registros (+700, +100%)
- Possível duplicação ou múltiplas versões

---

### **2. Tabelas Críticas Vazias (❌ PROBLEMA)**

#### **knowledge_base (0 registros) ❌ CRÍTICO**

**Propósito:**
- Armazenar **análises de IA** para cada território e dimensão
- Permitir **RAG** (Retrieval-Augmented Generation)
- Criar **memória do sistema** para aprendizado contínuo
- Alimentar **dashboard** com insights prontos

**Schema Esperado (do GitHub):**
```sql
CREATE TABLE knowledge_base (
    id SERIAL PRIMARY KEY,
    territory_id VARCHAR(10) REFERENCES territories(id),
    dimension VARCHAR(50), -- 'economic', 'social', 'territorial', 'environmental'
    analysis_type VARCHAR(50), -- 'diagnostic', 'trend', 'comparison', 'recommendation'
    content TEXT, -- Análise em texto
    metadata JSONB, -- Metadados da análise
    embedding VECTOR(1536), -- Vetor para RAG (pgvector)
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

**Impacto da Falta:**
- ❌ Dashboard não tem análises prontas
- ❌ Usuário precisa esperar IA gerar análise toda vez
- ❌ Sem RAG (busca semântica)
- ❌ Sem cache de análises
- ❌ Sem aprendizado contínuo

**Quantidade Necessária:**
```
140 territórios × 4 dimensões × 4 tipos de análise = 2.240 análises
```

---

#### **indicator_metadata (0 registros) ❌ CRÍTICO**

**Propósito:**
- Explicar **significado** de cada indicador
- Mostrar **tooltips** no dashboard
- Fornecer **contexto** para interpretação
- Indicar **fontes** e **metodologia**

**Schema Esperado:**
```sql
CREATE TABLE indicator_metadata (
    id SERIAL PRIMARY KEY,
    indicator_code VARCHAR(50) UNIQUE, -- 'gdp', 'idhm', 'area_km2', etc.
    dimension VARCHAR(50), -- 'economic', 'social', etc.
    name VARCHAR(200), -- Nome completo
    description TEXT, -- Descrição detalhada
    unit VARCHAR(50), -- Unidade de medida
    source VARCHAR(200), -- Fonte dos dados
    methodology TEXT, -- Como é calculado
    interpretation_guide TEXT, -- Como interpretar
    good_range JSONB, -- Faixa considerada boa
    alert_range JSONB, -- Faixa de alerta
    created_at TIMESTAMP DEFAULT NOW()
);
```

**Impacto da Falta:**
- ❌ Usuário não entende o que cada indicador significa
- ❌ Sem tooltips explicativos no dashboard
- ❌ Sem contexto para interpretação
- ❌ Dashboard fica "cru" e pouco didático

**Quantidade Necessária:**
```
~50-80 indicadores únicos (todos os campos das 4 dimensões)
```

---

## 🎯 Estratégias de Solução

### **ESTRATÉGIA 1: Popular indicator_metadata**

#### **Opção A: Criação Manual Estruturada (RECOMENDADA)**

**Vantagens:**
- ✅ Controle total sobre qualidade
- ✅ Precisão técnica garantida
- ✅ Pode ser revisado por especialistas

**Processo:**
1. Listar todos os indicadores das 4 dimensões
2. Para cada indicador, criar registro com:
   - Nome completo
   - Descrição clara
   - Unidade de medida
   - Fonte (IBGE, SICONFI, etc.)
   - Metodologia de cálculo
   - Guia de interpretação
   - Faixas de referência

**Tempo estimado:** 4-6 horas (50-80 indicadores)

**Exemplo:**
```json
{
  "indicator_code": "idhm",
  "dimension": "social",
  "name": "Índice de Desenvolvimento Humano Municipal",
  "description": "Medida composta que avalia o desenvolvimento humano em três dimensões: longevidade, educação e renda.",
  "unit": "índice (0-1)",
  "source": "IBGE - Censo Demográfico",
  "methodology": "Média geométrica dos índices de longevidade, educação e renda, normalizados entre 0 e 1.",
  "interpretation_guide": "0-0.499: Muito Baixo | 0.500-0.599: Baixo | 0.600-0.699: Médio | 0.700-0.799: Alto | 0.800-1.000: Muito Alto",
  "good_range": {"min": 0.700, "max": 1.000},
  "alert_range": {"min": 0.000, "max": 0.599}
}
```

---

#### **Opção B: Geração Semi-Automática com IA**

**Vantagens:**
- ✅ Mais rápido (1-2 horas)
- ✅ Cobertura completa garantida
- ⚠️ Precisa revisão humana

**Processo:**
1. Extrair lista de indicadores do schema
2. Usar GPT-4 para gerar metadados
3. Revisar e ajustar manualmente
4. Inserir no banco

**Script:**
```python
import openai

indicators = [
    {"code": "idhm", "dimension": "social"},
    {"code": "gdp", "dimension": "economic"},
    # ... todos os indicadores
]

for indicator in indicators:
    prompt = f"""
    Crie metadados completos para o indicador brasileiro:
    Código: {indicator['code']}
    Dimensão: {indicator['dimension']}
    
    Retorne JSON com:
    - name: nome completo em português
    - description: descrição clara (2-3 frases)
    - unit: unidade de medida
    - source: fonte oficial (IBGE, SICONFI, etc.)
    - methodology: como é calculado
    - interpretation_guide: como interpretar valores
    - good_range: faixa considerada boa
    - alert_range: faixa de alerta
    """
    
    response = openai.chat.completions.create(
        model="gpt-4",
        messages=[{"role": "user", "content": prompt}]
    )
    
    metadata = json.loads(response.choices[0].message.content)
    # Inserir no banco
```

---

### **ESTRATÉGIA 2: Popular knowledge_base**

#### **Opção A: Geração em Lote via n8n (RECOMENDADA)**

**Vantagens:**
- ✅ Usa agentes especialistas já criados
- ✅ Análises consistentes e padronizadas
- ✅ Pode ser reexecutado facilmente
- ✅ Integrado com workflow existente

**Processo:**
1. Criar workflow n8n "Batch Analysis Generator"
2. Para cada território (140):
   - Chamar agente ECON
   - Chamar agente SOCIAL
   - Chamar agente TERRA
   - Chamar agente AMBIENT
3. Salvar análises na knowledge_base
4. Gerar embeddings para RAG

**Tempo estimado:** 
- Execução: 2-3 horas (automático)
- Setup: 1 hora

**Custo estimado:**
```
140 territórios × 4 dimensões × $0.001 = $0.56
```

**Workflow n8n:**
```
[Schedule Trigger]
    ↓
[PostgreSQL: Get Territories]
    ↓
[Loop: For Each Territory]
    ↓
    ├─→ [HTTP: Call ECON Agent] → [Save to KB]
    ├─→ [HTTP: Call SOCIAL Agent] → [Save to KB]
    ├─→ [HTTP: Call TERRA Agent] → [Save to KB]
    └─→ [HTTP: Call AMBIENT Agent] → [Save to KB]
```

---

#### **Opção B: Geração Sob Demanda (Atual)**

**Vantagens:**
- ✅ Análises sempre atualizadas
- ✅ Sem custo inicial
- ⚠️ Usuário espera 6-8 segundos

**Desvantagens:**
- ❌ Experiência de usuário pior
- ❌ Sem cache
- ❌ Sem RAG

**Recomendação:** Usar como fallback se análise não existir no cache.

---

#### **Opção C: Geração Híbrida (MELHOR)**

**Combinar:**
1. **Pré-gerar** análises para os 20 municípios mais importantes
2. **Gerar sob demanda** para os demais
3. **Cachear** todas as análises geradas
4. **Atualizar** periodicamente (mensal)

**Vantagens:**
- ✅ Melhor custo-benefício
- ✅ Boa experiência para casos comuns
- ✅ Cobertura completa eventual

---

## 📊 Priorização

### **Prioridade ALTA (Fazer Agora)**

1. **Popular indicator_metadata** (Opção A: Manual)
   - Tempo: 4-6 horas
   - Impacto: Alto (UX do dashboard)
   - Complexidade: Baixa

2. **Pré-gerar análises para top 20 municípios** (Opção C)
   - Tempo: 30 minutos
   - Custo: $0.08
   - Impacto: Médio (demonstração)

---

### **Prioridade MÉDIA (Esta Semana)**

3. **Criar workflow de geração em lote** (Opção A)
   - Tempo: 1 hora setup + 3 horas execução
   - Custo: $0.56
   - Impacto: Alto (experiência completa)

4. **Implementar sistema de cache**
   - Tempo: 2 horas
   - Impacto: Alto (performance)

---

### **Prioridade BAIXA (Próxima Semana)**

5. **Implementar RAG com embeddings**
   - Tempo: 4-6 horas
   - Impacto: Médio (busca semântica)

6. **Sistema de atualização periódica**
   - Tempo: 2 horas
   - Impacto: Baixo (manutenção)

---

## 🔧 Scripts Prontos para Usar

### **Script 1: Extrair Lista de Indicadores**

```python
# extract_indicators.py
import json

# Ler schemas das tabelas
indicators = []

# Econômicos
economic = {
    "gdp": {"name": "PIB", "unit": "milhões R$"},
    "gdp_per_capita": {"name": "PIB per capita", "unit": "R$"},
    "employment_rate": {"name": "Taxa de emprego", "unit": "%"},
    "revenue": {"name": "Receita total", "unit": "R$"}
}

# Sociais
social = {
    "idhm": {"name": "IDH-M", "unit": "índice"},
    "population": {"name": "População", "unit": "habitantes"},
    "literacy_rate": {"name": "Taxa de alfabetização", "unit": "%"},
    "income_per_capita": {"name": "Renda per capita", "unit": "R$"}
}

# ... territorial e ambiental

# Salvar
with open('indicators_list.json', 'w') as f:
    json.dump(indicators, f, indent=2, ensure_ascii=False)
```

---

### **Script 2: Gerar Metadados com IA**

```python
# generate_metadata.py
import json
import os
from openai import OpenAI

client = OpenAI(api_key=os.getenv('OPENAI_API_KEY'))

with open('indicators_list.json') as f:
    indicators = json.load(f)

metadata_list = []

for indicator in indicators:
    prompt = f"""
    Crie metadados completos para este indicador brasileiro:
    
    Código: {indicator['code']}
    Nome: {indicator['name']}
    Dimensão: {indicator['dimension']}
    
    Retorne APENAS um JSON válido com:
    {{
      "indicator_code": "{indicator['code']}",
      "dimension": "{indicator['dimension']}",
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
    
    print(f"✓ {indicator['code']}")

# Salvar
with open('indicator_metadata.json', 'w') as f:
    json.dump(metadata_list, f, indent=2, ensure_ascii=False)

print(f"\n✓ {len(metadata_list)} metadados gerados")
```

---

### **Script 3: Inserir Metadados no Banco**

```python
# insert_metadata.py
import json
import psycopg2
import os

# Conectar
conn = psycopg2.connect(os.getenv('DATABASE_URL'))
cur = conn.cursor()

# Ler metadados
with open('indicator_metadata.json') as f:
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
    
    print(f"✓ {metadata['indicator_code']}")

conn.commit()
print(f"\n✓ {len(metadata_list)} metadados inseridos")
```

---

### **Script 4: Gerar Análises em Lote**

```python
# batch_generate_analyses.py
import requests
import psycopg2
import os
import time

# Conectar
conn = psycopg2.connect(os.getenv('DATABASE_URL'))
cur = conn.cursor()

# Buscar territórios
cur.execute("SELECT id, name FROM territories WHERE type = 'Município' LIMIT 20")
territories = cur.fetchall()

# Agentes
agents = {
    'economic': 'https://galactic-ai.app.n8n.cloud/webhook/agent-econ',
    'social': 'https://galactic-ai.app.n8n.cloud/webhook/agent-social',
    'territorial': 'https://galactic-ai.app.n8n.cloud/webhook/agent-terra',
    'environmental': 'https://galactic-ai.app.n8n.cloud/webhook/agent-ambient'
}

for territory_id, territory_name in territories:
    print(f"\n=== {territory_name} ===")
    
    for dimension, webhook_url in agents.items():
        print(f"  {dimension}...", end=" ")
        
        # Chamar agente
        response = requests.post(webhook_url, json={
            'territory_id': territory_id,
            'analysis_type': 'diagnostic'
        })
        
        if response.status_code == 200:
            analysis = response.json()
            
            # Salvar na knowledge_base
            cur.execute("""
                INSERT INTO knowledge_base (
                    territory_id, dimension, analysis_type, content, metadata
                ) VALUES (%s, %s, %s, %s, %s)
            """, (
                territory_id,
                dimension,
                'diagnostic',
                analysis['analysis'],
                json.dumps(analysis.get('metadata', {}))
            ))
            
            conn.commit()
            print("✓")
        else:
            print("✗")
        
        time.sleep(2)  # Rate limit

print(f"\n✓ Análises geradas para {len(territories)} territórios")
```

---

## 📝 Resumo Executivo

### **Situação Atual:**
- ✅ Dados de indicadores: **OK** (3.914 registros)
- ❌ Knowledge base: **VAZIA** (0 análises)
- ❌ Metadados: **VAZIOS** (0 indicadores)

### **Impacto:**
- ⚠️ Dashboard funciona mas sem contexto
- ⚠️ Usuário não entende indicadores
- ⚠️ Sem análises prontas (espera 6-8s)

### **Solução Recomendada:**
1. **Hoje:** Popular indicator_metadata (manual, 4-6h)
2. **Hoje:** Gerar análises top 20 municípios (automático, 30min)
3. **Esta semana:** Workflow de geração em lote (1h setup + 3h exec)

### **Custo Total:**
- Tempo: ~10 horas
- Dinheiro: ~$0.60 (OpenAI)

### **Resultado:**
- ✅ Dashboard completo e didático
- ✅ Análises prontas para demonstração
- ✅ Sistema escalável e sustentável

---

**Framework de Inteligência Territorial V6.0**  
Henrique M. Ribeiro  
23 de novembro de 2025
