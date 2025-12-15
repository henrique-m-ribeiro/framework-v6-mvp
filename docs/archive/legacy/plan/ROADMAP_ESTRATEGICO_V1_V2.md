# Roadmap Estratégico: MVP 1.0.0 → v2.0 (Sistema Multi-Agentes)
**Framework de Inteligência Territorial V6.0**  
**Data:** 10 de novembro de 2025  
**Visão:** Dashboard Web Funcional (v1.0) + Time de Especialistas IA (v2.0)

---

## 🎯 VISÃO ESTRATÉGICA

### Arquitetura em Duas Camadas

```
┌─────────────────────────────────────────────────────────────┐
│                    CAMADA 1: FRONTEND                        │
│              Dashboard Web (MVP 1.0.0 - Replit)              │
│                                                               │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  • Interface intuitiva para gestores públicos        │   │
│  │  • IA embarcada para navegação e exploração          │   │
│  │  • Consulta rápida de análises já realizadas         │   │
│  │  • Exportação de relatórios (PDF/CSV)                │   │
│  │  • Visualizações interativas (gráficos, mapas)       │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            ↕
                   (APIs REST + WebHooks)
                            ↕
┌─────────────────────────────────────────────────────────────┐
│                    CAMADA 2: BACKEND                         │
│           Sistema Multi-Agentes (v2.0 - n8n Cloud)           │
│                                                               │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  🤖 TIME DE ESPECIALISTAS IA                         │   │
│  │                                                        │   │
│  │  ┌────────────────────────────────────────────────┐  │   │
│  │  │  ORQUESTRADOR (Maestro)                        │  │   │
│  │  │  • Recebe demandas do frontend                 │  │   │
│  │  │  • Distribui tarefas para agentes              │  │   │
│  │  │  │  • Consolida resultados                       │  │   │
│  │  └────────────────────────────────────────────────┘  │   │
│  │                      ↓                                 │   │
│  │  ┌────────────────────────────────────────────────┐  │   │
│  │  │  AGENTE ECONÔMICO (ECON)                       │  │   │
│  │  │  • Coleta dados IBGE, Receita Federal, BCB     │  │   │
│  │  │  • Analisa PIB, emprego, renda, impostos       │  │   │
│  │  │  • Gera insights econômicos                    │  │   │
│  │  └────────────────────────────────────────────────┘  │   │
│  │                                                        │   │
│  │  ┌────────────────────────────────────────────────┐  │   │
│  │  │  AGENTE SOCIAL (SOCIAL)                        │  │   │
│  │  │  • Coleta dados IBGE, MEC, MS, INEP            │  │   │
│  │  │  • Analisa IDH, educação, saúde, segurança     │  │   │
│  │  │  • Gera insights sociais                       │  │   │
│  │  └────────────────────────────────────────────────┘  │   │
│  │                                                        │   │
│  │  ┌────────────────────────────────────────────────┐  │   │
│  │  │  AGENTE TERRITORIAL (TERRA)                    │  │   │
│  │  │  • Coleta dados IBGE, INCRA, Funai             │  │   │
│  │  │  • Analisa uso do solo, urbanização, infraest. │  │   │
│  │  │  • Gera insights territoriais                  │  │   │
│  │  └────────────────────────────────────────────────┘  │   │
│  │                                                        │   │
│  │  ┌────────────────────────────────────────────────┐  │   │
│  │  │  AGENTE AMBIENTAL (AMBIENT)                    │  │   │
│  │  │  • Coleta dados INPE, ANA, IBAMA, ICMBio       │  │   │
│  │  │  • Analisa desmatamento, água, emissões CO₂    │  │   │
│  │  │  • Gera insights ambientais                    │  │   │
│  │  └────────────────────────────────────────────────┘  │   │
│  │                                                        │   │
│  │  ┌────────────────────────────────────────────────┐  │   │
│  │  │  AGENTE DE PESQUISA E INTELIGÊNCIA (RESEARCH)  │  │   │
│  │  │  • Monitora redes sociais (Twitter, Facebook)  │  │   │
│  │  │  • Monitora academia (Google Scholar, arXiv)   │  │   │
│  │  │  • Monitora documentos oficiais (DOU, portais) │  │   │
│  │  │  • Identifica tendências e oportunidades       │  │   │
│  │  │  • Gera alertas proativos                      │  │   │
│  │  └────────────────────────────────────────────────┘  │   │
│  │                                                        │   │
│  │  ┌────────────────────────────────────────────────┐  │   │
│  │  │  AGENTE DE ESTRUTURAÇÃO (DATA_COLLECTOR)       │  │   │
│  │  │  • Estrutura dados coletados                   │  │   │
│  │  │  • Envia para banco central (PostgreSQL)       │  │   │
│  │  │  • Cria embeddings vetoriais (RAG)             │  │   │
│  │  │  • Mantém base de conhecimento atualizada      │  │   │
│  │  └────────────────────────────────────────────────┘  │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            ↕
                   (Banco de Dados Central)
                            ↕
┌─────────────────────────────────────────────────────────────┐
│              CAMADA 3: DADOS E CONHECIMENTO                  │
│                PostgreSQL + pgvector (Replit)                │
│                                                               │
│  • Dados estruturados (140 territórios, 5 anos)              │
│  • Análises já realizadas (cache inteligente)                │
│  • Base de conhecimento (RAG)                                │
│  • Embeddings vetoriais (busca semântica)                    │
└─────────────────────────────────────────────────────────────┘
```

---

## 🚀 ROADMAP DIVIDIDO EM 2 VERSÕES

### **MVP 1.0.0: Dashboard Web Funcional** (Prioridade IMEDIATA)
**Objetivo:** Entregar interface funcional para gestores públicos  
**Tempo:** 3-5 horas (2-3 sessões)  
**Tecnologias:** Replit + PostgreSQL + OpenAI  

### **v2.0: Sistema Multi-Agentes** (Diferencial Inovador)
**Objetivo:** Time de especialistas IA para geração de conhecimento e monitoramento contínuo  
**Tempo:** 8-12 horas (6-8 sessões)  
**Tecnologias:** n8n Cloud + APIs oficiais + Monitoramento  

---

## 📋 FASE 1: MVP 1.0.0 - DASHBOARD WEB FUNCIONAL

### Objetivo
Entregar dashboard totalmente funcional com:
- ✅ Chat IA para navegação e exploração
- ✅ Consulta rápida de análises já realizadas
- ✅ Visualizações interativas (gráficos, mapas)
- ✅ Exportação de relatórios (PDF/CSV)
- ✅ 21 territórios populados (Tocantins + 20 municípios)

### Subfases

#### 1.1 Correção: Chat IA (1-2h)
**O que fazer:**
1. Verificar conexão OpenAI (OPENAI_API_KEY)
2. Implementar endpoint `/api/chat` contextualizado
3. Conectar frontend ao backend
4. Testar perguntas e respostas

**Código:**
```python
# backend/api/chat.py
from fastapi import APIRouter, HTTPException
from openai import OpenAI
import os

router = APIRouter()
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

@router.post("/api/chat")
async def chat(message: str, territory: str, dimension: str):
    """
    Chat contextualizado por território e dimensão
    """
    # Buscar dados do banco
    context = await get_territory_context(territory, dimension)
    
    # Prompt contextualizado
    system_prompt = f"""
    Você é um assistente de inteligência territorial especializado no Tocantins.
    
    Contexto:
    - Território: {territory}
    - Dimensão: {dimension}
    - Dados disponíveis: {context}
    
    Responda de forma clara, objetiva e baseada nos dados.
    Use linguagem acessível para gestores públicos.
    Cite números e tendências quando relevante.
    """
    
    response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": message}
        ],
        temperature=0.7,
        max_tokens=500
    )
    
    return {"response": response.choices[0].message.content}

async def get_territory_context(territory: str, dimension: str):
    """
    Busca dados do território e dimensão para contexto
    """
    # Buscar indicadores
    indicators = await db.fetch("""
        SELECT indicator, value, year
        FROM {dimension}_indicators
        WHERE territory_id = (SELECT id FROM territories WHERE name = $1)
        ORDER BY year DESC
        LIMIT 5
    """, territory)
    
    # Buscar análises já realizadas (cache)
    cached_analysis = await db.fetchone("""
        SELECT analysis
        FROM knowledge_base
        WHERE territory = $1 AND dimension = $2
        ORDER BY created_at DESC
        LIMIT 1
    """, territory, dimension)
    
    return {
        "indicators": indicators,
        "cached_analysis": cached_analysis
    }
```

**Entregas:**
- [ ] Chat IA responde perguntas em <5s
- [ ] Respostas contextualizadas por território
- [ ] Consulta análises já realizadas (cache)

---

#### 1.2 Correção: Mapa Leaflet (1h)
**O que fazer:**
1. Verificar PostGIS ativo
2. Popular geometrias (coordenadas centrais)
3. Criar endpoint `/api/map/territories`
4. Renderizar mapa no frontend

**Código:**
```python
# backend/api/map.py
@router.get("/api/map/territories")
async def get_territories_geojson():
    """
    Retorna GeoJSON de territórios para Leaflet
    """
    query = """
        SELECT 
            id,
            name,
            type,
            ST_AsGeoJSON(geometry) as geometry
        FROM territories
        WHERE geometry IS NOT NULL
    """
    
    results = await db.fetch(query)
    
    features = []
    for row in results:
        features.append({
            "type": "Feature",
            "properties": {
                "id": row['id'],
                "name": row['name'],
                "type": row['type']
            },
            "geometry": json.loads(row['geometry'])
        })
    
    return {
        "type": "FeatureCollection",
        "features": features
    }
```

**Entregas:**
- [ ] Mapa renderizado com 21 territórios
- [ ] Zoom e pan funcionais
- [ ] Popups com informações

---

#### 1.3 Correção: Exportação PDF (1h)
**O que fazer:**
1. Implementar endpoint `/api/export/pdf`
2. Gerar PDF com análise + dados
3. Conectar botão no frontend

**Código:**
```python
# backend/api/export.py
from reportlab.lib.pagesizes import A4
from reportlab.platypus import SimpleDocTemplate, Paragraph, Table
from io import BytesIO

@router.get("/api/export/pdf/{dimension}/{territory}")
async def export_pdf(dimension: str, territory: str):
    """
    Gera PDF com análise completa
    """
    # Buscar dados
    data = await get_dimension_data(dimension, territory)
    
    # Gerar análise IA
    analysis = await generate_analysis(dimension, territory)
    
    # Criar PDF
    buffer = BytesIO()
    doc = SimpleDocTemplate(buffer, pagesize=A4)
    story = []
    
    # Adicionar conteúdo
    story.append(Paragraph(f"Análise {dimension} - {territory}", styles['Title']))
    story.append(Paragraph(analysis, styles['BodyText']))
    
    # Tabela de dados
    table_data = [['Ano', 'Indicador 1', 'Indicador 2']]
    for row in data:
        table_data.append([row.year, row.ind1, row.ind2])
    story.append(Table(table_data))
    
    doc.build(story)
    buffer.seek(0)
    
    return StreamingResponse(
        buffer,
        media_type="application/pdf",
        headers={"Content-Disposition": f"attachment; filename={dimension}_{territory}.pdf"}
    )
```

**Entregas:**
- [ ] PDF gerado com análise + dados
- [ ] Download funcional
- [ ] Formatação profissional

---

#### 1.4 Testes Finais (30 min)
**Checklist:**
- [ ] Todas as 6 abas navegáveis
- [ ] Chat IA responde perguntas
- [ ] Mapa Leaflet renderizado
- [ ] Exportação CSV funcional
- [ ] Exportação PDF funcional
- [ ] Seletores de território funcionais
- [ ] Gráficos interativos
- [ ] Sem bugs críticos

---

### Cronograma MVP 1.0.0

| Subfase | Atividade | Tempo | Prioridade |
|---------|-----------|-------|------------|
| 1.1 | Chat IA | 1-2h | CRÍTICA 🔥 |
| 1.2 | Mapa Leaflet | 1h | CRÍTICA 🔥 |
| 1.3 | Exportação PDF | 1h | ALTA |
| 1.4 | Testes Finais | 30min | ALTA |
| **TOTAL** | **MVP 1.0.0** | **3,5-4,5h** | - |

**Resultado:** Dashboard web totalmente funcional pronto para uso!

---

## 🤖 FASE 2: v2.0 - SISTEMA MULTI-AGENTES N8N

### Objetivo
Criar time de especialistas IA que:
- ✅ Coleta dados de APIs oficiais automaticamente
- ✅ Gera análises inéditas sob demanda
- ✅ Monitora redes sociais, academia e documentos oficiais
- ✅ Identifica tendências e oportunidades proativamente
- ✅ Alimenta banco de dados central (PostgreSQL)
- ✅ Cria base de conhecimento para IA do frontend

### Arquitetura Multi-Agentes

```
┌─────────────────────────────────────────────────────────────┐
│                     ORQUESTRADOR                             │
│  • Recebe demanda do frontend (via webhook)                  │
│  • Identifica dimensões necessárias                          │
│  • Distribui tarefas para agentes especializados             │
│  • Consolida resultados                                      │
│  • Envia resposta ao frontend                                │
└─────────────────────────────────────────────────────────────┘
                            ↓
        ┌───────────────────┼───────────────────┐
        ↓                   ↓                   ↓
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│  AGENTE ECON  │   │ AGENTE SOCIAL │   │ AGENTE TERRA  │
│               │   │               │   │               │
│ • IBGE        │   │ • IBGE        │   │ • IBGE        │
│ • BCB         │   │ • MEC         │   │ • INCRA       │
│ • Receita     │   │ • MS          │   │ • Funai       │
│               │   │ • INEP        │   │               │
│ → Análise     │   │ → Análise     │   │ → Análise     │
│   Econômica   │   │   Social      │   │   Territorial │
└───────────────┘   └───────────────┘   └───────────────┘
        ↓                   ↓                   ↓
        └───────────────────┼───────────────────┘
                            ↓
        ┌───────────────────┼───────────────────┐
        ↓                   ↓                   ↓
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│ AGENTE AMBIENT│   │ AGENTE RESEARCH│   │DATA_COLLECTOR │
│               │   │               │   │               │
│ • INPE        │   │ • Twitter     │   │ • Estrutura   │
│ • ANA         │   │ • Scholar     │   │ • Embeddings  │
│ • IBAMA       │   │ • DOU         │   │ • PostgreSQL  │
│ • ICMBio      │   │ • Portais     │   │ • RAG         │
│               │   │               │   │               │
│ → Análise     │   │ → Alertas     │   │ → Base de     │
│   Ambiental   │   │   Proativos   │   │   Conhecimento│
└───────────────┘   └───────────────┘   └───────────────┘
```

---

### Subfases

#### 2.1 Configuração n8n Cloud (1h)
**O que fazer:**
1. Criar conta n8n Cloud (plano Starter $20/mês)
2. Configurar credenciais (OpenAI, PostgreSQL)
3. Criar workspace "Framework V6.0"
4. Testar conexão com Replit (webhook)

**Entregas:**
- [ ] n8n Cloud ativo
- [ ] Credenciais configuradas
- [ ] Webhook testado

---

#### 2.2 Agente Orquestrador (1-2h)
**O que faz:**
- Recebe demanda do frontend (webhook)
- Identifica dimensões necessárias
- Distribui tarefas para agentes
- Consolida resultados
- Envia resposta ao frontend

**Workflow n8n:**
```json
{
  "name": "Orquestrador - Maestro",
  "nodes": [
    {
      "name": "Webhook Trigger",
      "type": "n8n-nodes-base.webhook",
      "parameters": {
        "path": "analyze",
        "method": "POST"
      },
      "notes": "Recebe demanda do frontend com: territory, dimension, question"
    },
    {
      "name": "Parse Request",
      "type": "n8n-nodes-base.function",
      "parameters": {
        "functionCode": "// Extrair parâmetros\nconst territory = $json.territory;\nconst dimension = $json.dimension;\nconst question = $json.question;\n\n// Identificar agentes necessários\nlet agents = [];\nif (dimension === 'economic') agents.push('ECON');\nif (dimension === 'social') agents.push('SOCIAL');\nif (dimension === 'territorial') agents.push('TERRA');\nif (dimension === 'environmental') agents.push('AMBIENT');\nif (dimension === 'all') agents = ['ECON', 'SOCIAL', 'TERRA', 'AMBIENT'];\n\nreturn {\n  territory,\n  dimension,\n  question,\n  agents\n};"
      },
      "notes": "Identifica quais agentes acionar"
    },
    {
      "name": "Check Cache",
      "type": "n8n-nodes-base.postgres",
      "parameters": {
        "operation": "executeQuery",
        "query": "SELECT analysis FROM knowledge_base WHERE territory = '{{$json.territory}}' AND dimension = '{{$json.dimension}}' AND question_hash = MD5('{{$json.question}}') AND created_at > NOW() - INTERVAL '7 days'"
      },
      "notes": "Verifica se análise já foi feita recentemente"
    },
    {
      "name": "If Cached",
      "type": "n8n-nodes-base.if",
      "parameters": {
        "conditions": {
          "boolean": [
            {
              "value1": "={{$json.analysis}}",
              "operation": "isNotEmpty"
            }
          ]
        }
      },
      "notes": "Se análise existe no cache, retorna direto"
    },
    {
      "name": "Return Cached",
      "type": "n8n-nodes-base.respondToWebhook",
      "parameters": {
        "response": "={{$json.analysis}}"
      },
      "notes": "Retorna análise do cache (rápido!)"
    },
    {
      "name": "Trigger Agents",
      "type": "n8n-nodes-base.splitInBatches",
      "parameters": {
        "batchSize": 1
      },
      "notes": "Aciona agentes especializados em paralelo"
    },
    {
      "name": "Call Agent ECON",
      "type": "n8n-nodes-base.executeWorkflow",
      "parameters": {
        "workflowId": "agente-economico",
        "data": "={{$json}}"
      },
      "notes": "Chama agente econômico"
    },
    {
      "name": "Consolidate Results",
      "type": "n8n-nodes-base.function",
      "parameters": {
        "functionCode": "// Consolidar resultados de todos os agentes\nconst results = $items.map(item => item.json);\n\n// Gerar análise consolidada com OpenAI\nreturn {\n  consolidated: results\n};"
      },
      "notes": "Consolida resultados de todos os agentes"
    },
    {
      "name": "Generate Final Analysis",
      "type": "n8n-nodes-base.openAi",
      "parameters": {
        "operation": "message",
        "model": "gpt-4o-mini",
        "messages": [
          {
            "role": "system",
            "content": "Você é um analista territorial. Consolide as análises dos agentes especializados em uma síntese coerente e acionável para gestores públicos."
          },
          {
            "role": "user",
            "content": "Consolide estas análises: {{$json.consolidated}}"
          }
        ]
      },
      "notes": "GPT-4o-mini gera análise final consolidada"
    },
    {
      "name": "Save to Knowledge Base",
      "type": "n8n-nodes-base.postgres",
      "parameters": {
        "operation": "insert",
        "table": "knowledge_base",
        "columns": "territory, dimension, question_hash, analysis, created_at",
        "values": "'{{$json.territory}}', '{{$json.dimension}}', MD5('{{$json.question}}'), '{{$json.analysis}}', NOW()"
      },
      "notes": "Salva análise no banco para cache futuro"
    },
    {
      "name": "Return Analysis",
      "type": "n8n-nodes-base.respondToWebhook",
      "parameters": {
        "response": "={{$json.analysis}}"
      },
      "notes": "Retorna análise ao frontend"
    }
  ]
}
```

**Entregas:**
- [ ] Orquestrador funcional
- [ ] Cache inteligente (7 dias)
- [ ] Consolidação de resultados

---

#### 2.3 Agente Econômico (ECON) (1-2h)
**O que faz:**
- Coleta dados IBGE, BCB, Receita Federal
- Analisa PIB, emprego, renda, impostos
- Gera insights econômicos

**APIs utilizadas:**
- IBGE: https://servicodados.ibge.gov.br/api/docs
- BCB: https://olinda.bcb.gov.br/olinda/servico/
- Receita Federal: (dados públicos)

**Workflow n8n:**
```json
{
  "name": "Agente Econômico (ECON)",
  "nodes": [
    {
      "name": "Trigger",
      "type": "n8n-nodes-base.executeWorkflowTrigger",
      "notes": "Acionado pelo Orquestrador"
    },
    {
      "name": "Fetch IBGE PIB",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "url": "https://servicodados.ibge.gov.br/api/v3/agregados/5938/periodos/2023/variaveis/37?localidades=N6[{{$json.code_ibge}}]",
        "method": "GET"
      },
      "notes": "Busca PIB do município no IBGE"
    },
    {
      "name": "Fetch IBGE Emprego",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "url": "https://servicodados.ibge.gov.br/api/v3/agregados/6468/periodos/2023/variaveis/9810?localidades=N6[{{$json.code_ibge}}]",
        "method": "GET"
      },
      "notes": "Busca dados de emprego no IBGE"
    },
    {
      "name": "Fetch BCB Taxa Juros",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "url": "https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/CotacaoDolarDia(dataCotacao=@dataCotacao)?@dataCotacao='{{$now.format('MM-DD-YYYY')}}'",
        "method": "GET"
      },
      "notes": "Busca taxa de câmbio (contexto econômico)"
    },
    {
      "name": "Consolidate Data",
      "type": "n8n-nodes-base.function",
      "parameters": {
        "functionCode": "// Consolidar dados de todas as APIs\nconst pib = $items[0].json;\nconst emprego = $items[1].json;\nconst cambio = $items[2].json;\n\nreturn {\n  pib: pib.valor,\n  emprego: emprego.valor,\n  cambio: cambio.cotacaoCompra,\n  fonte: 'IBGE + BCB'\n};"
      },
      "notes": "Consolida dados de todas as fontes"
    },
    {
      "name": "Generate Analysis",
      "type": "n8n-nodes-base.openAi",
      "parameters": {
        "operation": "message",
        "model": "gpt-4o-mini",
        "messages": [
          {
            "role": "system",
            "content": "Você é um economista especializado em análise territorial. Analise os dados econômicos fornecidos e gere insights acionáveis para gestores públicos."
          },
          {
            "role": "user",
            "content": "Analise estes dados econômicos de {{$json.territory}}: PIB: {{$json.pib}}, Emprego: {{$json.emprego}}, Câmbio: {{$json.cambio}}"
          }
        ]
      },
      "notes": "GPT-4o-mini gera análise econômica"
    },
    {
      "name": "Return Analysis",
      "type": "n8n-nodes-base.function",
      "parameters": {
        "functionCode": "return {\n  agent: 'ECON',\n  dimension: 'economic',\n  analysis: $json.analysis,\n  data: $json.data\n};"
      },
      "notes": "Retorna análise ao Orquestrador"
    }
  ]
}
```

**Entregas:**
- [ ] Coleta dados IBGE + BCB
- [ ] Análise econômica gerada
- [ ] Insights acionáveis

---

#### 2.4 Agente Social (SOCIAL) (1h)
**O que faz:**
- Coleta dados IBGE, MEC, MS, INEP
- Analisa IDH, educação, saúde, segurança
- Gera insights sociais

**APIs utilizadas:**
- IBGE: https://servicodados.ibge.gov.br/api/docs
- INEP: http://portal.inep.gov.br/web/guest/dados
- DataSUS: http://datasus.saude.gov.br/

**Workflow:** Similar ao ECON, adaptado para dados sociais

**Entregas:**
- [ ] Coleta dados IBGE + MEC + MS
- [ ] Análise social gerada
- [ ] Insights acionáveis

---

#### 2.5 Agente Territorial (TERRA) (1h)
**O que faz:**
- Coleta dados IBGE, INCRA, Funai
- Analisa uso do solo, urbanização, infraestrutura
- Gera insights territoriais

**APIs utilizadas:**
- IBGE: https://servicodados.ibge.gov.br/api/docs
- INCRA: (dados públicos)
- Funai: (dados públicos)

**Workflow:** Similar ao ECON, adaptado para dados territoriais

**Entregas:**
- [ ] Coleta dados IBGE + INCRA
- [ ] Análise territorial gerada
- [ ] Insights acionáveis

---

#### 2.6 Agente Ambiental (AMBIENT) (1h)
**O que faz:**
- Coleta dados INPE, ANA, IBAMA, ICMBio
- Analisa desmatamento, qualidade da água, emissões CO₂
- Gera insights ambientais

**APIs utilizadas:**
- INPE TerraBrasilis: http://terrabrasilis.dpi.inpe.br/
- ANA HidroWeb: http://www.snirh.gov.br/hidroweb/
- IBAMA: (dados públicos)

**Workflow:** Similar ao ECON, adaptado para dados ambientais

**Entregas:**
- [ ] Coleta dados INPE + ANA
- [ ] Análise ambiental gerada
- [ ] Insights acionáveis

---

#### 2.7 Agente de Pesquisa e Inteligência (RESEARCH) (2-3h) 🏆 DIFERENCIAL
**O que faz:**
- Monitora redes sociais (Twitter, Facebook)
- Monitora academia (Google Scholar, arXiv)
- Monitora documentos oficiais (DOU, portais governamentais)
- Identifica tendências e oportunidades
- Gera alertas proativos

**APIs utilizadas:**
- Twitter API: https://developer.twitter.com/en/docs
- Google Scholar: (scraping ou API não-oficial)
- DOU: https://www.in.gov.br/
- Portais de transparência estaduais/municipais

**Workflow n8n:**
```json
{
  "name": "Agente de Pesquisa e Inteligência (RESEARCH)",
  "nodes": [
    {
      "name": "Schedule Trigger",
      "type": "n8n-nodes-base.scheduleTrigger",
      "parameters": {
        "rule": {
          "interval": [{"field": "hours", "value": 6}]
        }
      },
      "notes": "Executa a cada 6 horas automaticamente"
    },
    {
      "name": "Monitor Twitter",
      "type": "n8n-nodes-base.twitter",
      "parameters": {
        "operation": "search",
        "searchText": "Tocantins OR Palmas OR Araguaína (política OR economia OR desenvolvimento)",
        "maxResults": 100
      },
      "notes": "Busca tweets sobre Tocantins e seus municípios"
    },
    {
      "name": "Analyze Sentiment",
      "type": "n8n-nodes-base.openAi",
      "parameters": {
        "operation": "message",
        "model": "gpt-4o-mini",
        "messages": [
          {
            "role": "system",
            "content": "Analise o sentimento e identifique tendências nos tweets fornecidos. Classifique como: positivo, negativo, neutro. Identifique temas principais."
          },
          {
            "role": "user",
            "content": "Analise estes tweets: {{$json.tweets}}"
          }
        ]
      },
      "notes": "GPT-4o-mini analisa sentimento e tendências"
    },
    {
      "name": "Monitor Google Scholar",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "url": "https://scholar.google.com/scholar?q=Tocantins+desenvolvimento+territorial&hl=pt-BR&as_sdt=0,5",
        "method": "GET"
      },
      "notes": "Busca publicações acadêmicas sobre Tocantins"
    },
    {
      "name": "Parse Scholar Results",
      "type": "n8n-nodes-base.function",
      "parameters": {
        "functionCode": "// Parse HTML do Google Scholar\n// Extrair títulos, autores, resumos\n// (Simplificado - usar biblioteca de scraping na prática)"
      },
      "notes": "Extrai informações de publicações"
    },
    {
      "name": "Monitor DOU",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "url": "https://www.in.gov.br/consulta/-/buscar/dou?q=Tocantins&s=todos",
        "method": "GET"
      },
      "notes": "Busca publicações no Diário Oficial da União"
    },
    {
      "name": "Parse DOU",
      "type": "n8n-nodes-base.function",
      "parameters": {
        "functionCode": "// Parse HTML do DOU\n// Extrair decretos, portarias, editais\n// Identificar oportunidades (financiamento, programas)"
      },
      "notes": "Extrai documentos oficiais relevantes"
    },
    {
      "name": "Identify Opportunities",
      "type": "n8n-nodes-base.openAi",
      "parameters": {
        "operation": "message",
        "model": "gpt-4o-mini",
        "messages": [
          {
            "role": "system",
            "content": "Você é um analista de políticas públicas. Identifique oportunidades de financiamento, programas governamentais, e tendências relevantes para o Tocantins nos documentos fornecidos."
          },
          {
            "role": "user",
            "content": "Analise estes documentos: {{$json.documents}}"
          }
        ]
      },
      "notes": "GPT-4o-mini identifica oportunidades"
    },
    {
      "name": "Generate Alert",
      "type": "n8n-nodes-base.function",
      "parameters": {
        "functionCode": "// Gerar alerta se oportunidade relevante\nif ($json.opportunity_score > 0.7) {\n  return {\n    alert: true,\n    title: $json.opportunity_title,\n    description: $json.opportunity_description,\n    urgency: 'high'\n  };\n}"
      },
      "notes": "Gera alerta se oportunidade relevante"
    },
    {
      "name": "Save to Knowledge Base",
      "type": "n8n-nodes-base.postgres",
      "parameters": {
        "operation": "insert",
        "table": "research_insights",
        "columns": "source, content, sentiment, opportunities, created_at",
        "values": "'{{$json.source}}', '{{$json.content}}', '{{$json.sentiment}}', '{{$json.opportunities}}', NOW()"
      },
      "notes": "Salva insights no banco"
    },
    {
      "name": "Send Alert Email",
      "type": "n8n-nodes-base.emailSend",
      "parameters": {
        "toEmail": "gestor@tocantins.gov.br",
        "subject": "🚨 Nova Oportunidade Identificada: {{$json.title}}",
        "text": "{{$json.description}}"
      },
      "notes": "Envia email para gestores se alerta crítico"
    }
  ]
}
```

**Entregas:**
- [ ] Monitoramento de redes sociais
- [ ] Monitoramento de academia
- [ ] Monitoramento de documentos oficiais
- [ ] Alertas proativos gerados
- [ ] Oportunidades identificadas

---

#### 2.8 Agente de Estruturação (DATA_COLLECTOR) (1h)
**O que faz:**
- Estrutura dados coletados pelos agentes
- Cria embeddings vetoriais (RAG)
- Envia para banco central (PostgreSQL)
- Mantém base de conhecimento atualizada

**Workflow n8n:**
```json
{
  "name": "Agente de Estruturação (DATA_COLLECTOR)",
  "nodes": [
    {
      "name": "Trigger",
      "type": "n8n-nodes-base.executeWorkflowTrigger",
      "notes": "Acionado após análises dos agentes"
    },
    {
      "name": "Structure Data",
      "type": "n8n-nodes-base.function",
      "parameters": {
        "functionCode": "// Estruturar dados em formato padronizado\nreturn {\n  territory: $json.territory,\n  dimension: $json.dimension,\n  indicators: $json.indicators,\n  analysis: $json.analysis,\n  timestamp: new Date().toISOString()\n};"
      },
      "notes": "Padroniza estrutura de dados"
    },
    {
      "name": "Create Embeddings",
      "type": "n8n-nodes-base.openAi",
      "parameters": {
        "operation": "embedding",
        "model": "text-embedding-3-small",
        "input": "={{$json.analysis}}"
      },
      "notes": "Cria embeddings vetoriais para RAG"
    },
    {
      "name": "Save to PostgreSQL",
      "type": "n8n-nodes-base.postgres",
      "parameters": {
        "operation": "insert",
        "table": "knowledge_base",
        "columns": "territory, dimension, analysis, embedding, created_at",
        "values": "'{{$json.territory}}', '{{$json.dimension}}', '{{$json.analysis}}', '{{$json.embedding}}', NOW()"
      },
      "notes": "Salva análise + embedding no banco"
    },
    {
      "name": "Update Indicators",
      "type": "n8n-nodes-base.postgres",
      "parameters": {
        "operation": "insert",
        "table": "{{$json.dimension}}_indicators",
        "columns": "territory_id, indicator, value, year, source",
        "values": "{{$json.territory_id}}, '{{$json.indicator}}', {{$json.value}}, {{$json.year}}, '{{$json.source}}'"
      },
      "notes": "Atualiza indicadores no banco"
    }
  ]
}
```

**Entregas:**
- [ ] Dados estruturados e salvos
- [ ] Embeddings criados
- [ ] Base de conhecimento atualizada

---

### Cronograma v2.0 (Sistema Multi-Agentes)

| Subfase | Agente | Tempo | Prioridade |
|---------|--------|-------|------------|
| 2.1 | Configuração n8n | 1h | ALTA |
| 2.2 | Orquestrador | 1-2h | CRÍTICA 🔥 |
| 2.3 | ECON | 1-2h | ALTA |
| 2.4 | SOCIAL | 1h | ALTA |
| 2.5 | TERRA | 1h | ALTA |
| 2.6 | AMBIENT | 1h | ALTA |
| 2.7 | RESEARCH | 2-3h | MÉDIA (diferencial) |
| 2.8 | DATA_COLLECTOR | 1h | ALTA |
| **TOTAL** | **v2.0** | **9-12h** | - |

**Resultado:** Sistema multi-agentes completo com monitoramento contínuo!

---

## 📈 CRONOGRAMA GERAL

### Visão Completa

| Versão | Fases | Tempo | Sessões | Resultado |
|--------|-------|-------|---------|-----------|
| **MVP 1.0.0** | 1.1-1.4 | 3,5-4,5h | 2-3 | Dashboard funcional |
| **v2.0** | 2.1-2.8 | 9-12h | 6-8 | Sistema multi-agentes |
| **TOTAL** | - | **12,5-16,5h** | **8-11** | Produto completo |

### Cronograma Sugerido (Sessões de 1,5h)

**Semana 1: MVP 1.0.0**
- Sessão 1: Chat IA (1,5h)
- Sessão 2: Mapa + PDF + Testes (1,5h)
- **Resultado:** MVP 1.0.0 publicado! 🚀

**Semana 2: Fundação v2.0**
- Sessão 3: n8n + Orquestrador (1,5h)
- Sessão 4: Agente ECON (1,5h)
- Sessão 5: Agente SOCIAL (1,5h)

**Semana 3: Agentes Especializados**
- Sessão 6: Agente TERRA (1,5h)
- Sessão 7: Agente AMBIENT (1,5h)
- Sessão 8: DATA_COLLECTOR (1,5h)

**Semana 4: Diferencial Inovador**
- Sessão 9: Agente RESEARCH - Parte 1 (1,5h)
- Sessão 10: Agente RESEARCH - Parte 2 (1,5h)
- Sessão 11: Testes finais + Documentação (1,5h)
- **Resultado:** v2.0 completo! 🏆

---

## 💰 CUSTOS ESTIMADOS

### Desenvolvimento (Tempo)
- **MVP 1.0.0:** 3,5-4,5 horas (2-3 sessões)
- **v2.0:** 9-12 horas (6-8 sessões)
- **Total:** 12,5-16,5 horas (8-11 sessões)

### Infraestrutura (Mensal)
- **n8n Cloud:** $20/mês (plano Starter)
- **OpenAI API:** $10-15/mês (com cache 70%)
- **Replit:** $0 (tier gratuito) ou $20/mês (Hacker)
- **Total:** $30-55/mês

### APIs Externas
- **IBGE, INPE, ANA, etc.:** Gratuitas ✅
- **Twitter API:** $100/mês (Basic tier)
- **Total:** $100/mês (opcional, só para RESEARCH)

**Custo Total Mensal:** $30-55/mês (sem RESEARCH) ou $130-155/mês (com RESEARCH)

---

## 🎯 CRITÉRIOS DE SUCESSO

### MVP 1.0.0
- [ ] Chat IA responde em <5s
- [ ] Mapa Leaflet renderizado
- [ ] Exportação PDF funcional
- [ ] Todas as 6 abas navegáveis
- [ ] Sem bugs críticos
- [ ] Pronto para uso por gestores públicos

### v2.0
- [ ] 6 agentes especializados ativos
- [ ] Orquestrador funcional
- [ ] Cache inteligente (economia 70% OpenAI)
- [ ] Coleta automática de dados (APIs oficiais)
- [ ] Monitoramento contínuo (RESEARCH)
- [ ] Alertas proativos gerados
- [ ] Base de conhecimento sempre atualizada

---

## 🚀 PRÓXIMA AÇÃO

**Começar MVP 1.0.0 - Subfase 1.1 (Chat IA) agora!**

**Você quer:**
- **Opção A:** Começar Subfase 1.1 (Chat IA) agora (1-2h)
- **Opção B:** Encerrar sessão e retomar depois
- **Opção C:** Fazer diário desta sessão primeiro

Qual opção você prefere?
