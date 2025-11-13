# Roadmap Detalhado: Fases 5-10 até Publicação

## 📋 Visão Geral

Este documento detalha todas as funcionalidades que serão implementadas desde a configuração inicial do Replit (Fase 5) até a validação final do MVP (Fase 10), antes de chegarmos ao ponto de "Publicar Agora".

**Duração Total Estimada:** 15-18 sessões (20-27 horas de trabalho)  
**Período:** 6-9 semanas (considerando sessões curtas de 1-1.5h)

---

## 🎯 Fase 5: Configuração do Ambiente Replit (1-1.5h)

### Objetivo
Configurar completamente o ambiente de desenvolvimento no Replit com PostgreSQL, extensões geoespaciais e variáveis de ambiente.

### Funcionalidades Implementadas

#### 5.1 Configuração do PostgreSQL
**O que será feito:**
- Ativar PostgreSQL no Replit (via painel Tools → PostgreSQL)
- Obter connection string (DATABASE_URL)
- Testar conexão com psql
- Verificar versão do PostgreSQL (deve ser 14+)

**Entregas:**
- PostgreSQL rodando no Replit
- Connection string salva
- Teste de conexão bem-sucedido

**Critérios de Sucesso:**
- [ ] PostgreSQL ativo e acessível
- [ ] Connection string funcional
- [ ] Comando `psql $DATABASE_URL` conecta com sucesso

---

#### 5.2 Instalação de Extensões
**O que será feito:**
- Instalar extensão **PostGIS** (dados geoespaciais)
  - Permite armazenar coordenadas, polígonos, calcular distâncias
  - Essencial para aba Territorial (mapas)
- Tentar instalar extensão **pgvector** (embeddings vetoriais)
  - Para sistema RAG (busca semântica)
  - Se não disponível, usar busca por texto (fallback)

**Comandos SQL:**
```sql
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS pgvector; -- pode falhar, ok
```

**Entregas:**
- PostGIS instalado e funcional
- pgvector instalado (ou fallback documentado)

**Critérios de Sucesso:**
- [ ] PostGIS ativo (`SELECT PostGIS_version();` retorna versão)
- [ ] pgvector ativo OU fallback documentado

---

#### 5.3 Configuração de Variáveis de Ambiente
**O que será feito:**
- Criar arquivo `.env` no Replit
- Adicionar variáveis essenciais:
  - `DATABASE_URL` (connection string PostgreSQL)
  - `OPENAI_API_KEY` (sua chave OpenAI)
  - `OPENAI_MODEL` (gpt-4o-mini)
  - `OPENAI_TEMPERATURE` (0.3)
  - `PORT` (3000)
  - `NODE_ENV` (development)

**Entregas:**
- Arquivo `.env` criado
- Todas variáveis configuradas
- `.env.example` criado (sem valores sensíveis)

**Critérios de Sucesso:**
- [ ] Variáveis acessíveis no código
- [ ] `.env` no `.gitignore`
- [ ] `.env.example` commitado no GitHub

---

#### 5.4 Conectar Replit ao GitHub
**O que será feito:**
- Conectar Repl ao repositório `framework-v6-mvp`
- Configurar sincronização automática
- Fazer primeiro commit do código gerado pelo Agent

**Entregas:**
- Replit conectado ao GitHub
- Código inicial commitado
- Sincronização funcionando

**Critérios de Sucesso:**
- [ ] Commits do Replit aparecem no GitHub
- [ ] Pull/push funcionando
- [ ] Histórico de versões preservado

---

### Checkpoint Fase 5
**Ao final desta fase, você terá:**
- ✅ PostgreSQL configurado e rodando
- ✅ Extensões PostGIS (e pgvector se possível) instaladas
- ✅ Variáveis de ambiente configuradas
- ✅ Replit conectado ao GitHub
- ✅ Ambiente pronto para desenvolvimento

**Tempo:** 1-1.5 horas  
**Sessões:** 1 sessão

---

## 🗄️ Fase 6: Implementação do Schema do Banco de Dados (1-2h)

### Objetivo
Criar todas as 40 tabelas do banco de dados com relacionamentos, índices e constraints.

### Funcionalidades Implementadas

#### 6.1 Tabelas de Dimensão (Entidades Territoriais)
**O que será feito:**
- Criar tabela `dim_territorios` (entidade central)
  - Colunas: id, nome, tipo (estado/região/município), código_ibge, geometria (PostGIS), população, área_km2
  - 140 registros (1 estado + 139 municípios + regiões)
- Criar tabela `dim_divisoes_regionais`
  - Regiões intermediárias (3)
  - Regiões imediatas (11)
  - Mesorregiões históricas (2)
  - Microrregiões históricas (8)
- Criar tabela `dim_tempo`
  - Anos (2005-2025)
  - Trimestres, meses
  - Para séries temporais

**Entregas:**
- 3 tabelas de dimensão criadas
- Relacionamentos definidos
- Índices em chaves primárias e estrangeiras

**Critérios de Sucesso:**
- [ ] Tabelas criadas sem erros
- [ ] Relacionamentos funcionando (foreign keys)
- [ ] Queries de teste retornam dados esperados

---

#### 6.2 Tabelas Fato (Indicadores por Dimensão)
**O que será feito:**

**Dimensão Econômica (5 tabelas):**
- `fato_pib` (PIB total, per capita, setorial)
- `fato_emprego` (taxa de emprego, desemprego, formalização)
- `fato_arrecadacao` (receitas municipais, estaduais)
- `fato_empresas` (número de empresas, MEIs, por setor)
- `fato_renda` (renda per capita, salário médio, Gini)

**Dimensão Social (5 tabelas):**
- `fato_demografia` (população, densidade, crescimento)
- `fato_idh` (IDH-M, componentes: longevidade, educação, renda)
- `fato_educacao` (matrículas, IDEB, taxa alfabetização)
- `fato_saude` (leitos, médicos per capita, mortalidade)
- `fato_assistencia_social` (Bolsa Família, CRAS, beneficiários)

**Dimensão Territorial (5 tabelas):**
- `fato_uso_solo` (área urbana, rural, preservação)
- `fato_infraestrutura` (saneamento, energia, internet)
- `fato_mobilidade` (frota veículos, vias pavimentadas)
- `fato_habitacao` (domicílios, déficit habitacional)
- `fato_equipamentos_publicos` (escolas, postos saúde, delegacias)

**Dimensão Ambiental (5 tabelas):**
- `fato_cobertura_vegetal` (área floresta, desmatamento)
- `fato_recursos_hidricos` (qualidade água, disponibilidade)
- `fato_emissoes` (CO₂, poluentes)
- `fato_residuos` (coleta lixo, reciclagem)
- `fato_areas_protegidas` (UCs, APPs, reservas)

**Entregas:**
- 20 tabelas fato criadas
- Chaves estrangeiras para dim_territorios e dim_tempo
- Índices em colunas de busca frequente

**Critérios de Sucesso:**
- [ ] Todas 20 tabelas criadas
- [ ] Relacionamentos com dimensões funcionando
- [ ] Schema validado (sem erros de integridade)

---

#### 6.3 Tabelas de Sistema RAG
**O que será feito:**
- Criar tabela `rag_documentos`
  - Armazena textos de análises, relatórios, leis
  - Colunas: id, titulo, conteudo, fonte, data, territorio_id
- Criar tabela `rag_embeddings` (se pgvector disponível)
  - Armazena vetores de embeddings para busca semântica
  - Colunas: id, documento_id, embedding (vector(1536)), chunk_text
- Criar tabela `rag_cache`
  - Cache de respostas da IA para economizar custos
  - Colunas: id, query_hash, resposta, territorio_id, dimensao, created_at

**Entregas:**
- 3 tabelas RAG criadas
- Índices para busca rápida
- Triggers para atualização automática

**Critérios de Sucesso:**
- [ ] Tabelas RAG criadas
- [ ] Índices vetoriais (se pgvector) ou full-text search configurados
- [ ] Cache funcionando (teste de insert/select)

---

#### 6.4 Tabelas de Auditoria e Logs
**O que será feito:**
- Criar tabela `log_acessos`
  - Rastreia acessos ao dashboard
  - Colunas: id, usuario_ip, territorio_id, aba, timestamp
- Criar tabela `log_analises_ia`
  - Rastreia análises geradas pela IA
  - Colunas: id, territorio_id, dimensao, prompt, resposta, tokens_usados, custo, timestamp
- Criar tabela `log_exportacoes`
  - Rastreia exportações PDF/CSV
  - Colunas: id, usuario_ip, tipo (pdf/csv), aba, territorio_id, timestamp

**Entregas:**
- 3 tabelas de log criadas
- Triggers para logging automático
- Queries de análise de uso

**Critérios de Sucesso:**
- [ ] Logs sendo gravados automaticamente
- [ ] Queries de relatório funcionando
- [ ] Retenção de dados configurada (ex: 90 dias)

---

#### 6.5 Views e Funções SQL
**O que será feito:**
- Criar view `vw_dashboard_visao_geral`
  - Agrega KPIs das 4 dimensões por território
  - Facilita consultas do dashboard
- Criar view `vw_comparacao_territorios`
  - Dados lado-a-lado para aba Comparação
- Criar função `fn_calcular_ranking`
  - Calcula ranking de territórios por indicador
- Criar função `fn_media_regional`
  - Calcula médias por região intermediária/imediata

**Entregas:**
- 2 views criadas e testadas
- 2 funções SQL criadas e testadas
- Documentação de uso

**Critérios de Sucesso:**
- [ ] Views retornam dados corretos
- [ ] Funções executam sem erros
- [ ] Performance adequada (queries < 500ms)

---

### Checkpoint Fase 6
**Ao final desta fase, você terá:**
- ✅ 40 tabelas criadas (20 fato + 3 dimensão + 3 RAG + 3 log + 11 auxiliares)
- ✅ Relacionamentos e constraints definidos
- ✅ Índices otimizados
- ✅ Views e funções SQL funcionais
- ✅ Schema completo e validado

**Tempo:** 1-2 horas  
**Sessões:** 1-2 sessões

---

## 📊 Fase 7: População Inicial de Dados Territoriais (2-4h)

### Objetivo
Popular o banco de dados com dados reais dos 139 municípios do Tocantins, estado e divisões regionais.

### Funcionalidades Implementadas

#### 7.1 Dados Estruturais (Dimensões)
**O que será feito:**
- Popular `dim_territorios` com 140 entidades:
  - 1 registro: Estado do Tocantins
  - 139 registros: Municípios (nome, código IBGE, geometria)
  - Geometrias (polígonos) obtidas do IBGE
- Popular `dim_divisoes_regionais`:
  - 3 regiões intermediárias
  - 11 regiões imediatas
  - 2 mesorregiões históricas
  - 8 microrregiões históricas
  - Relacionamentos município ↔ região
- Popular `dim_tempo`:
  - Anos 2005-2025
  - Trimestres e meses

**Fonte de Dados:**
- IBGE: Malhas territoriais, códigos, nomes
- Planilha `municipios_tocantins_completo.xlsx` (já fornecida)

**Entregas:**
- 140 territórios cadastrados
- 24 divisões regionais cadastradas
- 21 anos de dimensão tempo

**Critérios de Sucesso:**
- [ ] 140 registros em dim_territorios
- [ ] Geometrias válidas (PostGIS)
- [ ] Relacionamentos corretos

---

#### 7.2 Dados Econômicos (5 anos iniciais)
**O que será feito:**
- Extrair dados do IBGE (API Sidra)
- Popular tabelas fato_pib, fato_emprego, fato_arrecadacao
- Período: 2019-2023 (5 anos)
- 140 territórios × 5 anos = 700 registros por tabela

**APIs Utilizadas:**
- IBGE Sidra: PIB Municipal (tabela 5938)
- IBGE Sidra: Emprego (CAGED)
- Tesouro Nacional: Receitas municipais

**Script Python:**
```python
# scripts/popular_dados_economicos.py
import requests
import psycopg2

def extrair_pib_ibge(ano):
    # Conectar API IBGE Sidra
    # Extrair PIB de todos municípios TO
    # Retornar DataFrame
    
def popular_banco(df, tabela):
    # Conectar PostgreSQL
    # Inserir dados em lote (bulk insert)
    # Commit
```

**Entregas:**
- Script de extração funcionando
- 3.500+ registros inseridos (700 × 5 tabelas)
- Dados validados (sem nulos críticos)

**Critérios de Sucesso:**
- [ ] Script executa sem erros
- [ ] Dados consistentes (valores razoáveis)
- [ ] Queries de teste retornam dados esperados

---

#### 7.3 Dados Sociais (5 anos iniciais)
**O que será feito:**
- Extrair dados do IBGE, INEP, DataSUS
- Popular tabelas fato_demografia, fato_idh, fato_educacao, fato_saude
- Período: 2019-2023

**APIs Utilizadas:**
- IBGE: População (Estimativas)
- Atlas Brasil: IDH-M (2010, projeções)
- INEP: Matrículas, IDEB
- DataSUS: Indicadores de saúde

**Entregas:**
- Script de extração funcionando
- 2.800+ registros inseridos (700 × 4 tabelas)

**Critérios de Sucesso:**
- [ ] Dados demográficos completos
- [ ] IDH-M disponível (mesmo que 2010)
- [ ] Indicadores educacionais atualizados

---

#### 7.4 Dados Territoriais (5 anos iniciais)
**O que será feito:**
- Extrair dados do IBGE, SNIS, ANATEL
- Popular tabelas fato_uso_solo, fato_infraestrutura, fato_mobilidade

**APIs Utilizadas:**
- IBGE: Área urbanizada
- SNIS: Saneamento básico
- ANATEL: Cobertura internet
- DENATRAN: Frota de veículos

**Entregas:**
- Script de extração funcionando
- 2.100+ registros inseridos (700 × 3 tabelas)

**Critérios de Sucesso:**
- [ ] Dados de infraestrutura completos
- [ ] Geometrias de uso do solo (se disponíveis)

---

#### 7.5 Dados Ambientais (5 anos iniciais)
**O que será feito:**
- Extrair dados do INPE, ANA, IBAMA
- Popular tabelas fato_cobertura_vegetal, fato_recursos_hidricos

**APIs Utilizadas:**
- INPE: Desmatamento (PRODES)
- ANA: Qualidade da água
- MapBiomas: Cobertura vegetal

**Entregas:**
- Script de extração funcionando
- 1.400+ registros inseridos (700 × 2 tabelas)

**Critérios de Sucesso:**
- [ ] Dados de desmatamento disponíveis
- [ ] Qualidade da água (IQA) quando disponível

---

#### 7.6 Documentos para RAG
**O que será feito:**
- Coletar documentos relevantes:
  - Planos Diretores municipais (PDFs)
  - Leis orçamentárias (LOAs)
  - Relatórios de gestão
  - Estudos técnicos
- Processar documentos:
  - Extrair texto (PyPDF2, pdfplumber)
  - Dividir em chunks (1000 tokens)
  - Gerar embeddings (OpenAI text-embedding-3-small)
- Popular tabelas rag_documentos e rag_embeddings

**Entregas:**
- 50-100 documentos processados
- 500-1000 chunks com embeddings
- Sistema de busca semântica funcionando

**Critérios de Sucesso:**
- [ ] Documentos indexados
- [ ] Busca semântica retorna resultados relevantes
- [ ] Tempo de busca < 1s

---

### Checkpoint Fase 7
**Ao final desta fase, você terá:**
- ✅ 140 territórios cadastrados
- ✅ 10.000+ registros de indicadores (5 anos × 4 dimensões)
- ✅ 50-100 documentos indexados para RAG
- ✅ Banco de dados populado e funcional
- ✅ Scripts de extração documentados e versionados

**Tempo:** 2-4 horas  
**Sessões:** 2-3 sessões

---

## 🔗 Fase 8: Configuração do n8n Cloud e Implementação do Data Collector (4-6h)

### Objetivo
Configurar n8n Cloud, criar conta, implementar o agente Data Collector para automação de coleta de dados.

### Funcionalidades Implementadas

#### 8.1 Configuração do n8n Cloud
**O que será feito:**
- Criar conta no n8n Cloud (https://n8n.io)
- Escolher plano (Starter: $20/mês)
- Configurar workspace
- Conectar credenciais:
  - PostgreSQL (Replit DATABASE_URL)
  - OpenAI API Key
  - IBGE API (sem autenticação)
  - Outras APIs governamentais

**Entregas:**
- Conta n8n ativa
- Workspace configurado
- Credenciais salvas

**Critérios de Sucesso:**
- [ ] n8n acessível
- [ ] Credenciais testadas e funcionando
- [ ] Primeiro workflow de teste executado

---

#### 8.2 Workflow: Data Collector - Econômico
**O que será feito:**
- Criar workflow no n8n para coletar dados econômicos
- Componentes:
  1. **Trigger:** Schedule (diário, semanal ou mensal)
  2. **HTTP Request:** Chamar API IBGE Sidra (PIB)
  3. **Code:** Processar JSON, transformar dados
  4. **PostgreSQL:** Inserir em fato_pib
  5. **IF:** Verificar se dados novos ou atualização
  6. **Notification:** Enviar email/Slack se erro

**Fluxo:**
```
[Schedule Trigger]
    ↓
[HTTP Request: IBGE PIB]
    ↓
[Code: Transform Data]
    ↓
[PostgreSQL: Upsert fato_pib]
    ↓
[IF: Success?]
    ├─ Yes → [Log Success]
    └─ No → [Send Alert]
```

**Entregas:**
- Workflow funcionando
- Dados sendo coletados automaticamente
- Logs de execução

**Critérios de Sucesso:**
- [ ] Workflow executa sem erros
- [ ] Dados inseridos corretamente no banco
- [ ] Alertas funcionando em caso de erro

---

#### 8.3 Workflow: Data Collector - Social
**O que será feito:**
- Workflow para coletar dados sociais (IBGE, INEP, DataSUS)
- Similar ao econômico, mas com múltiplas APIs
- Merge de dados de diferentes fontes

**Entregas:**
- Workflow funcionando
- Dados de 3+ fontes integrados

**Critérios de Sucesso:**
- [ ] Dados demográficos atualizados
- [ ] Indicadores educacionais coletados
- [ ] Merge sem duplicatas

---

#### 8.4 Workflow: Data Collector - Territorial
**O que será feito:**
- Workflow para coletar dados territoriais (IBGE, SNIS, ANATEL)
- Incluir processamento de dados geoespaciais (se necessário)

**Entregas:**
- Workflow funcionando
- Dados de infraestrutura atualizados

**Critérios de Sucesso:**
- [ ] Dados de saneamento coletados
- [ ] Cobertura de internet atualizada

---

#### 8.5 Workflow: Data Collector - Ambiental
**O que será feito:**
- Workflow para coletar dados ambientais (INPE, ANA, MapBiomas)
- Processar dados de desmatamento e qualidade da água

**Entregas:**
- Workflow funcionando
- Dados ambientais atualizados

**Critérios de Sucesso:**
- [ ] Dados de desmatamento (PRODES) coletados
- [ ] Qualidade da água (quando disponível)

---

#### 8.6 Workflow: Orquestrador (Meta-Workflow)
**O que será feito:**
- Criar workflow "mestre" que coordena os 4 Data Collectors
- Executa em sequência ou paralelo
- Gera relatório de execução
- Envia notificação de conclusão

**Fluxo:**
```
[Schedule: Weekly]
    ↓
[Execute: Data Collector Econômico]
    ↓
[Execute: Data Collector Social]
    ↓
[Execute: Data Collector Territorial]
    ↓
[Execute: Data Collector Ambiental]
    ↓
[Generate Report]
    ↓
[Send Email: Summary]
```

**Entregas:**
- Orquestrador funcionando
- Relatórios automáticos
- Notificações configuradas

**Critérios de Sucesso:**
- [ ] Todos workflows executam corretamente
- [ ] Relatório gerado com estatísticas
- [ ] Email recebido após execução

---

### Checkpoint Fase 8
**Ao final desta fase, você terá:**
- ✅ n8n Cloud configurado
- ✅ 4 workflows Data Collector funcionando (1 por dimensão)
- ✅ 1 workflow orquestrador
- ✅ Coleta automática de dados (semanal/mensal)
- ✅ Alertas e notificações configurados
- ✅ Banco de dados sempre atualizado

**Tempo:** 4-6 horas  
**Sessões:** 3-4 sessões

---

## 🤖 Fase 9: Implementação do Sistema RAG (4-6h)

### Objetivo
Implementar sistema RAG (Retrieval-Augmented Generation) para geração de análises contextualizadas pela IA.

### Funcionalidades Implementadas

#### 9.1 Backend Python: Serviço RAG
**O que será feito:**
- Criar módulo `services/rag_service.py`
- Implementar funções:
  - `gerar_embedding(texto)`: Gera embedding de texto
  - `buscar_documentos_relevantes(query, territorio_id, top_k=5)`: Busca semântica
  - `gerar_analise(territorio_id, dimensao, contexto)`: Gera análise com RAG

**Código Exemplo:**
```python
from openai import OpenAI
import psycopg2

client = OpenAI()

def gerar_embedding(texto):
    response = client.embeddings.create(
        model="text-embedding-3-small",
        input=texto
    )
    return response.data[0].embedding

def buscar_documentos_relevantes(query, territorio_id, top_k=5):
    query_embedding = gerar_embedding(query)
    
    # Busca vetorial (se pgvector disponível)
    sql = """
    SELECT chunk_text, 1 - (embedding <=> %s::vector) AS similarity
    FROM rag_embeddings
    WHERE territorio_id = %s
    ORDER BY similarity DESC
    LIMIT %s
    """
    # Executar query, retornar resultados
    
def gerar_analise(territorio_id, dimensao, contexto):
    # 1. Buscar documentos relevantes
    docs = buscar_documentos_relevantes(
        f"Análise {dimensao} de {territorio_id}", 
        territorio_id
    )
    
    # 2. Buscar dados quantitativos do banco
    dados = obter_dados_dimensao(territorio_id, dimensao)
    
    # 3. Construir prompt contextual
    prompt = f"""
    Você é um analista de inteligência territorial.
    
    Território: {territorio_id}
    Dimensão: {dimensao}
    
    Dados Quantitativos:
    {dados}
    
    Documentos Relevantes:
    {docs}
    
    Gere uma análise de 150-250 palavras sobre a dimensão {dimensao} 
    do território, incluindo:
    - Contexto atual
    - Principais insights
    - Alertas ou oportunidades
    
    Use linguagem acessível para gestores públicos.
    """
    
    # 4. Chamar OpenAI
    response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[{"role": "user", "content": prompt}],
        temperature=0.3,
        max_tokens=500
    )
    
    return response.choices[0].message.content
```

**Entregas:**
- Módulo `rag_service.py` funcionando
- Funções testadas e validadas
- Documentação de uso

**Critérios de Sucesso:**
- [ ] Embeddings gerados corretamente
- [ ] Busca semântica retorna documentos relevantes
- [ ] Análises geradas são coerentes e úteis

---

#### 9.2 API REST: Endpoint de Análise
**O que será feito:**
- Criar endpoint FastAPI: `POST /api/analise`
- Recebe: `territorio_id`, `dimensao`
- Retorna: Análise gerada pela IA

**Código Exemplo:**
```python
from fastapi import FastAPI, HTTPException
from services.rag_service import gerar_analise

app = FastAPI()

@app.post("/api/analise")
async def criar_analise(territorio_id: int, dimensao: str):
    try:
        analise = gerar_analise(territorio_id, dimensao, contexto={})
        
        # Salvar em log_analises_ia
        salvar_log(territorio_id, dimensao, analise)
        
        return {"analise": analise, "territorio_id": territorio_id, "dimensao": dimensao}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
```

**Entregas:**
- Endpoint funcionando
- Testes de API (Postman/curl)
- Documentação OpenAPI/Swagger

**Critérios de Sucesso:**
- [ ] Endpoint responde em < 5s
- [ ] Análises geradas são relevantes
- [ ] Erros tratados adequadamente

---

#### 9.3 Integração Frontend: Caixa de Análise IA
**O que será feito:**
- Conectar componente `AIAnalysisBox` ao endpoint `/api/analise`
- Implementar loading state (skeleton screen)
- Exibir análise gerada
- Adicionar botão "Regenerar"

**Código React:**
```typescript
const AIAnalysisBox = ({ territorioId, dimensao }) => {
  const [analise, setAnalise] = useState('');
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    const fetchAnalise = async () => {
      setLoading(true);
      const response = await fetch('/api/analise', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ territorio_id: territorioId, dimensao })
      });
      const data = await response.json();
      setAnalise(data.analise);
      setLoading(false);
    };
    
    fetchAnalise();
  }, [territorioId, dimensao]);
  
  if (loading) return <SkeletonLoader />;
  
  return (
    <div className="ai-analysis-box">
      <h3>Análise {dimensao} por IA</h3>
      <p>{analise}</p>
      <button onClick={() => fetchAnalise()}>Regenerar</button>
    </div>
  );
};
```

**Entregas:**
- Componente integrado
- Loading states funcionando
- Regeneração de análise

**Critérios de Sucesso:**
- [ ] Análise carrega automaticamente ao trocar aba/território
- [ ] Loading state exibido durante geração
- [ ] Botão "Regenerar" funciona

---

#### 9.4 Chat IA: Integração Contextual
**O que será feito:**
- Conectar componente `ChatSidebar` ao endpoint de chat
- Criar endpoint `POST /api/chat`
- Implementar contexto automático (aba, território, indicadores visíveis)
- Sugestões de perguntas contextuais

**Endpoint de Chat:**
```python
@app.post("/api/chat")
async def chat(mensagem: str, territorio_id: int, dimensao: str, contexto: dict):
    # 1. Buscar documentos relevantes
    docs = buscar_documentos_relevantes(mensagem, territorio_id)
    
    # 2. Buscar dados quantitativos
    dados = obter_dados_dimensao(territorio_id, dimensao)
    
    # 3. Construir prompt com contexto
    prompt = f"""
    Você é um assistente de inteligência territorial.
    
    Contexto:
    - Território: {territorio_id}
    - Dimensão ativa: {dimensao}
    - Indicadores visíveis: {contexto.get('indicadores')}
    
    Dados:
    {dados}
    
    Documentos:
    {docs}
    
    Pergunta do usuário:
    {mensagem}
    
    Responda de forma objetiva (150-250 palavras), com dados quantitativos.
    """
    
    response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[{"role": "user", "content": prompt}],
        temperature=0.3
    )
    
    return {"resposta": response.choices[0].message.content}
```

**Entregas:**
- Chat funcional
- Contexto automático funcionando
- Sugestões de perguntas

**Critérios de Sucesso:**
- [ ] Chat responde perguntas corretamente
- [ ] Respostas são contextualizadas
- [ ] Sugestões mudam conforme aba/território

---

#### 9.5 Cache de Análises (Otimização de Custos)
**O que será feito:**
- Implementar cache em `rag_cache`
- Antes de chamar OpenAI, verificar se análise já existe
- Hash da query: `md5(territorio_id + dimensao + data)`
- TTL: 7 dias (análises expiram após 1 semana)

**Lógica:**
```python
def gerar_analise_com_cache(territorio_id, dimensao):
    # 1. Calcular hash
    query_hash = hashlib.md5(f"{territorio_id}{dimensao}{date.today()}".encode()).hexdigest()
    
    # 2. Buscar no cache
    cached = buscar_cache(query_hash)
    if cached and (datetime.now() - cached.created_at).days < 7:
        return cached.resposta
    
    # 3. Gerar nova análise
    analise = gerar_analise(territorio_id, dimensao, contexto={})
    
    # 4. Salvar no cache
    salvar_cache(query_hash, analise, territorio_id, dimensao)
    
    return analise
```

**Entregas:**
- Cache implementado
- Redução de 70% nas chamadas OpenAI
- Economia de custos

**Critérios de Sucesso:**
- [ ] Cache funcionando
- [ ] Análises repetidas não chamam OpenAI
- [ ] Custo mensal reduzido para $5-7

---

### Checkpoint Fase 9
**Ao final desta fase, você terá:**
- ✅ Sistema RAG completo e funcional
- ✅ Análises IA geradas automaticamente em cada aba
- ✅ Chat IA contextual funcionando
- ✅ Cache implementado (70% economia)
- ✅ APIs REST documentadas
- ✅ Integração frontend-backend completa

**Tempo:** 4-6 horas  
**Sessões:** 3-4 sessões

---

## ✅ Fase 10: Testes Integrados e Validação do MVP (2-3h)

### Objetivo
Realizar testes completos do sistema, validar funcionalidades, corrigir bugs e preparar para publicação.

### Funcionalidades Implementadas

#### 10.1 Testes Funcionais (Todas as Abas)
**O que será feito:**
- Testar cada aba individualmente:
  - **Visão Geral:** KPIs carregam, análise IA gerada, badges corretos
  - **Econômica:** Gráficos renderizam, dados corretos, tabela exportável
  - **Social:** Gráfico radar funciona, dados demográficos corretos
  - **Territorial:** Mapa interativo carrega, uso do solo correto
  - **Ambiental:** Gráficos ambientais, dados INPE/ANA corretos
  - **Comparação:** Seletor multi-território funciona, gráficos comparativos corretos

**Checklist:**
- [ ] Todas as 6 abas navegáveis
- [ ] KPIs exibem valores corretos
- [ ] Gráficos renderizam sem erros
- [ ] Análises IA são geradas
- [ ] Tabelas exibem dados corretos
- [ ] Exportação PDF/CSV funciona

---

#### 10.2 Testes de Seletores e Filtros
**O que será feito:**
- Testar painel de controle:
  - Seletor de tipo de território (6 opções)
  - Seletor de território específico (140 opções, busca)
  - Seletor de período (5/10/20 anos)
  - Seletor de indicadores (multi-select)
- Verificar atualização de dados ao mudar seletores

**Checklist:**
- [ ] Seletores funcionam corretamente
- [ ] Busca de território funciona
- [ ] Dados atualizam ao mudar seleção
- [ ] Filtros persistem ao trocar abas

---

#### 10.3 Testes do Chat IA
**O que será feito:**
- Testar chat em diferentes contextos:
  - Perguntas sobre dimensão econômica
  - Perguntas sobre comparação entre municípios
  - Perguntas sobre dados históricos
- Verificar sugestões contextuais
- Testar exportação de conversa

**Checklist:**
- [ ] Chat responde perguntas corretamente
- [ ] Respostas são contextualizadas
- [ ] Sugestões mudam conforme contexto
- [ ] Exportação de conversa funciona
- [ ] Typing indicator aparece

---

#### 10.4 Testes de Responsividade
**O que será feito:**
- Testar em 3 tamanhos:
  - Desktop (1920x1080, 1280x720)
  - Tablet (768x1024)
  - Mobile (375x667, 414x896)
- Verificar adaptações:
  - Chat em drawer (tablet)
  - Chat fullscreen (mobile)
  - Abas em accordion (mobile)
  - KPIs em grid 2x2 (mobile)

**Checklist:**
- [ ] Layout responsivo em todos tamanhos
- [ ] Chat se adapta corretamente
- [ ] Botões touch-friendly (min 44x44px)
- [ ] Gráficos redimensionam
- [ ] Tabelas com scroll horizontal

---

#### 10.5 Testes de Performance
**O que será feito:**
- Medir tempos de carregamento:
  - Carregamento inicial: < 3s
  - Troca de aba: < 500ms
  - Geração de análise IA: < 5s
  - Busca de território: < 200ms
- Otimizar queries lentas
- Implementar lazy loading

**Checklist:**
- [ ] Carregamento inicial < 3s
- [ ] Navegação fluida (< 500ms)
- [ ] Análises IA < 5s
- [ ] Queries otimizadas

---

#### 10.6 Testes de Exportação
**O que será feito:**
- Testar exportação PDF:
  - Aba individual
  - Dashboard completo
  - Com/sem histórico de chat
- Testar exportação CSV:
  - Dados da tabela atual
  - Metadados incluídos
- Verificar formatação

**Checklist:**
- [ ] PDF gerado corretamente
- [ ] CSV exporta dados corretos
- [ ] Formatação adequada
- [ ] Metadados incluídos

---

#### 10.7 Testes de Integração n8n
**O que será feito:**
- Verificar workflows n8n:
  - Data Collectors executam sem erros
  - Dados inseridos no banco corretamente
  - Alertas funcionando
- Testar execução manual e agendada

**Checklist:**
- [ ] Workflows executam sem erros
- [ ] Dados atualizados no banco
- [ ] Alertas recebidos
- [ ] Logs de execução disponíveis

---

#### 10.8 Correção de Bugs
**O que será feito:**
- Listar todos bugs encontrados
- Priorizar por severidade (crítico, alto, médio, baixo)
- Corrigir bugs críticos e altos
- Documentar bugs médios/baixos para versões futuras

**Entregas:**
- Lista de bugs documentada
- Bugs críticos corrigidos
- Plano para bugs restantes

**Critérios de Sucesso:**
- [ ] Zero bugs críticos
- [ ] < 3 bugs altos não corrigidos
- [ ] Bugs documentados no GitHub Issues

---

#### 10.9 Validação com Usuário (Opcional)
**O que será feito:**
- Convidar 1-2 gestores públicos para testar
- Observar uso real do dashboard
- Coletar feedback
- Ajustar UX conforme necessário

**Entregas:**
- Sessão de teste com usuários
- Feedback documentado
- Ajustes implementados

**Critérios de Sucesso:**
- [ ] Usuários conseguem navegar sem ajuda
- [ ] Feedback positivo sobre usabilidade
- [ ] Principais dores de UX resolvidas

---

#### 10.10 Documentação Final
**O que será feito:**
- Atualizar README.md com instruções de uso
- Criar MANUAL_USUARIO.md (para gestores públicos)
- Documentar APIs (Swagger/OpenAPI)
- Criar vídeo tutorial (5-10 min)

**Entregas:**
- README.md atualizado
- Manual do usuário completo
- Documentação de APIs
- Vídeo tutorial (opcional)

**Critérios de Sucesso:**
- [ ] Documentação clara e completa
- [ ] Manual acessível para não-técnicos
- [ ] APIs documentadas (Swagger)

---

### Checkpoint Fase 10
**Ao final desta fase, você terá:**
- ✅ MVP completamente testado
- ✅ Bugs críticos corrigidos
- ✅ Performance otimizada
- ✅ Responsividade validada
- ✅ Documentação completa
- ✅ Sistema pronto para publicação

**Tempo:** 2-3 horas  
**Sessões:** 2 sessões

---

## 🚀 Após Fase 10: Publicação

### Quando Publicar?
**Somente quando TODOS os critérios forem atendidos:**

✅ Todas as 6 abas funcionando perfeitamente  
✅ Chat IA respondendo corretamente  
✅ Banco de dados populado (140 entidades, 10.000+ registros)  
✅ n8n workflows funcionando (coleta automática)  
✅ Sistema RAG gerando análises relevantes  
✅ Exportação PDF/CSV funcionando  
✅ Responsividade validada (desktop, tablet, mobile)  
✅ Performance adequada (< 3s carregamento)  
✅ Zero bugs críticos  
✅ Documentação completa  
✅ Testes com usuários realizados (opcional)  

### Como Publicar?
1. Voltar às configurações de "Production database settings"
2. Verificar configurações (Opção 1 marcada)
3. Clicar em **"Publish now"**
4. Replit cria banco de produção
5. Deploy automático
6. URL pública gerada
7. Compartilhar com gestores públicos

---

## 📊 Resumo Geral

| Fase | Objetivo | Tempo | Sessões | Status |
|------|----------|-------|---------|--------|
| 5 | Configuração Replit | 1-1.5h | 1 | ⏳ Próxima |
| 6 | Schema do Banco | 1-2h | 1-2 | 🔜 Aguardando |
| 7 | População de Dados | 2-4h | 2-3 | 🔜 Aguardando |
| 8 | n8n + Data Collector | 4-6h | 3-4 | 🔜 Aguardando |
| 9 | Sistema RAG | 4-6h | 3-4 | 🔜 Aguardando |
| 10 | Testes e Validação | 2-3h | 2 | 🔜 Aguardando |
| **Total** | **MVP Completo** | **15-22h** | **12-16** | **30% Concluído** |

---

## 🎯 Próximo Passo Imediato

**Você está agora na Fase 5!**

Após o Replit Agent terminar de gerar o código (Fase 3-4), você vai:
1. Configurar PostgreSQL no Replit
2. Instalar extensões (PostGIS, pgvector)
3. Configurar variáveis de ambiente
4. Conectar ao GitHub
5. Fazer primeiro commit

**Tempo estimado:** 1-1.5 horas  
**Quando:** Após Replit Agent concluir geração do código

---

Tem alguma dúvida sobre alguma fase específica? Posso detalhar mais qualquer etapa! 🚀
