# Wireframes V2 - Com Seleção Regional

**Data:** 10 de Novembro de 2025  
**Versão:** 2.0 - Com Funcionalidade de Análise Regional  
**Atualização:** Inclusão de divisões regionais do IBGE

---

## 🆕 O QUE HÁ DE NOVO NA V2

### Funcionalidade Principal: Seleção de Territórios por Tipo

O dashboard agora permite análises em **6 níveis territoriais diferentes**:

1. **Estado** - Tocantins completo
2. **Região Intermediária** - 3 regiões (Palmas, Araguaína, Gurupi)
3. **Região Imediata** - 11 regiões (Palmas, Porto Nacional, Araguaína, etc.)
4. **Município** - 139 municípios
5. **Mesorregião** (histórico 1989-2017) - 2 regiões (Ocidental, Oriental)
6. **Microrregião** (histórico 1989-2017) - 8 regiões (Bico do Papagaio, etc.)

---

## 📦 ARQUIVOS INCLUÍDOS

### 1. `wireframe_dashboard_v2_regional.png`
**Tipo:** Wireframe visual completo  
**Novidades:**
- **Seletor duplo no header:** Tipo de território + Território específico
- **Cards de dimensões com comparação regional:** Média regional, ranking, participação
- **Badge de contexto no chat:** Indica tipo e território selecionado
- **Histórico com badges regionais:** Identifica análises regionais

### 2. `wireframe_regional_comparison.png`
**Tipo:** Wireframe de caso de uso específico  
**Mostra:**
- Comparação entre duas Regiões Intermediárias (Palmas vs. Araguaína)
- Gráfico de barras comparativo (GDP, Employment, Population)
- Tabela de dados detalhada
- Mapa destacando as regiões comparadas

### 3. `wireframe_dashboard_v2_regional.html`
**Tipo:** Protótipo interativo funcional  
**Funcionalidades:**
- ✅ Seletor de tipo de território (6 opções)
- ✅ Seletor de território específico (dinâmico)
- ✅ Cards de dimensões com comparação regional
- ✅ Badges de ranking (1º lugar, top 3, outros)
- ✅ Ações rápidas contextuais (comparar região, ver ranking)
- ✅ Histórico com badges de análises regionais
- ✅ JavaScript funcional para interação

**Como visualizar:**
```bash
# Opção 1: Abrir diretamente
open wireframe_dashboard_v2_regional.html

# Opção 2: Servir com Python
cd /home/ubuntu/framework-v6-mvp/docs/design
python3 -m http.server 8000
# Acessar: http://localhost:8000/wireframe_dashboard_v2_regional.html
```

### 4. `DIVISOES_REGIONAIS_ANALISE.md`
**Tipo:** Documentação técnica completa  
**Conteúdo:**
- Estrutura das 4 divisões regionais do Tocantins
- Casos de uso detalhados
- Schema do banco de dados
- Endpoints da API
- Queries SQL de exemplo
- Componentes React
- Plano de implementação faseada

---

## 🎯 PRINCIPAIS MUDANÇAS vs. V1

### Header

**V1:**
```
[Logo] ──────────────────────── [Território: Palmas ▼]
```

**V2:**
```
[Logo] ──────── [Tipo: Município ▼] [Território: Palmas ▼]
```

---

### Cards de Dimensões

**V1:**
```
┌─────────────────────┐
│ 📈 Econômica        │
│ PIB: R$ 32,5 bi     │
│ ↓ -0,4%             │
└─────────────────────┘
```

**V2:**
```
┌─────────────────────────────┐
│ 📈 Econômica                │
│ PIB: R$ 32,5 bi             │
│ ↓ -0,4%                     │
│                             │
│ ┌─ Contexto Regional ─────┐ │
│ │ Região: R$ 45,2 bi      │ │
│ │ Participação: 72%       │ │
│ │ Ranking: 1º de 10       │ │
│ └─────────────────────────┘ │
└─────────────────────────────┘
```

---

### Chat - Ações Rápidas

**V1:**
```
[💡 Comparar com outro município]
[📈 Ver tendências]
[📄 Gerar relatório]
```

**V2:**
```
[🗺️ Comparar com região intermediária]  ← NOVO
[📊 Ver ranking regional completo]       ← NOVO
[💡 Comparar com outro município]
[📈 Ver tendências históricas]
```

---

### Histórico

**V1:**
```
Economia de Palmas
Hoje, 15:20 | Econômica
```

**V2:**
```
Palmas vs. Região Imediata
Hoje, 15:20 | Econômica | Regional  ← Badge NOVO
```

---

## 📊 ESTRUTURA DE DADOS

### Tabela: `municipios_regioes`

```sql
CREATE TABLE municipios_regioes (
    codigo_municipio VARCHAR(7) PRIMARY KEY,
    nome_municipio VARCHAR(100),
    
    -- Divisão Atual (2017+)
    regiao_imediata_id INTEGER,
    regiao_imediata_nome VARCHAR(100),
    regiao_intermediaria_id INTEGER,
    regiao_intermediaria_nome VARCHAR(100),
    
    -- Divisão Histórica (1989-2017)
    microrregiao_id INTEGER,
    microrregiao_nome VARCHAR(100),
    mesorregiao_id INTEGER,
    mesorregiao_nome VARCHAR(100),
    
    populacao INTEGER,
    pib_mil_reais NUMERIC(15,2),
    pib_per_capita_reais NUMERIC(10,2)
);
```

### Dados Carregados

A planilha `municipios_tocantins_completo.xlsx` contém:
- ✅ 140 registros (1 estado + 139 municípios)
- ✅ 14 colunas
- ✅ Todas as 4 divisões regionais mapeadas
- ✅ Dados de população e PIB

---

## 🎨 CASOS DE USO IMPLEMENTADOS

### Caso 1: Análise de Município com Contexto Regional

**Fluxo:**
1. Usuário seleciona "Município" → "Palmas"
2. Dashboard mostra dados de Palmas
3. Cards de dimensões mostram:
   - Valor de Palmas
   - Média da Região Imediata de Palmas
   - Ranking de Palmas (1º de 10)
   - Participação de Palmas no total regional (72%)

**Benefício:** Gestor entende posição de Palmas no contexto regional

---

### Caso 2: Análise de Região Completa

**Fluxo:**
1. Usuário seleciona "Região Imediata" → "Palmas"
2. Dashboard mostra dados agregados dos 10 municípios
3. Cards mostram:
   - PIB total da região: R$ 45,2 bi
   - População total: 450 mil
   - IDEB médio: 5,8
4. Chat permite perguntar: "Quais municípios têm melhor IDEB?"

**Benefício:** Visão regional agregada para planejamento

---

### Caso 3: Comparação entre Regiões

**Fluxo:**
1. Usuário seleciona "Região Intermediária" → "Palmas"
2. Usuário pergunta no chat: "Compare com Araguaína"
3. IA responde com:
   - Gráfico comparativo (PIB, emprego, população)
   - Tabela de dados
   - Mapa destacando ambas regiões
   - Análise textual das diferenças

**Benefício:** Benchmark entre regiões para identificar boas práticas

---

### Caso 4: Análise Histórica com Divisões Antigas

**Fluxo:**
1. Usuário seleciona "Microrregião" → "Bico do Papagaio"
2. Usuário pergunta: "Como evoluiu o desmatamento nos últimos 10 anos?"
3. IA usa dados históricos (2014-2024) agregados dos 25 municípios
4. Resposta inclui série temporal e comparação com outras microrregiões

**Benefício:** Análise histórica usando divisões antigas para continuidade de estudos

---

## 🔌 ENDPOINTS DA API NECESSÁRIOS

### GET /api/v1/territorios/tipos
Lista tipos de território disponíveis

### GET /api/v1/territorios/listar?tipo={tipo}
Lista territórios de um tipo específico

### GET /api/v1/territorios/{codigo}/municipios
Lista municípios de uma região

### GET /api/v1/territorios/{codigo}/indicadores?dimensao={dimensao}
Indicadores agregados de uma região

### POST /api/v1/chat/analyze
Análise com IA considerando contexto territorial

---

## 🚀 COMO USAR NO REPLIT AGENT

### Prompt Recomendado

```
Criar dashboard de inteligência territorial com seleção regional baseado neste wireframe [anexar wireframe_dashboard_v2_regional.png].

FUNCIONALIDADE PRINCIPAL: Seleção de Territórios por Tipo

TIPOS DE TERRITÓRIO (6 opções):
1. Estado (Tocantins completo)
2. Região Intermediária (3 regiões: Palmas, Araguaína, Gurupi)
3. Região Imediata (11 regiões)
4. Município (139 municípios)
5. Mesorregião - histórico 1989-2017 (2 regiões)
6. Microrregião - histórico 1989-2017 (8 regiões)

HEADER:
- Logo "Framework V6.0" à esquerda
- Dois dropdowns à direita:
  * Dropdown 1: Tipo de território (6 opções)
  * Dropdown 2: Território específico (dinâmico, muda conforme tipo)
- Badge de contexto mostrando seleção atual

CARDS DE DIMENSÕES (4 cards):
- Valor principal do território selecionado
- Variação temporal
- NOVO: Seção "Contexto Regional" com:
  * Média/total regional
  * Participação do território no regional
  * Ranking do território na região
  * Badge colorido de ranking (ouro 1º, prata top 3, cinza outros)

CHAT COM IA:
- Badge de contexto mostrando território selecionado
- Ações rápidas contextuais:
  * Se município: "Comparar com região", "Ver ranking regional"
  * Se região: "Ver municípios", "Comparar com outra região"
- Respostas da IA consideram contexto territorial

HISTÓRICO:
- Badges indicando tipo de análise:
  * Badge "Regional" para análises regionais
  * Badge "Histórico" para divisões antigas (meso/micro)
  * Badge de dimensão (Econômica, Social, etc.)

DADOS:
- Usar planilha municipios_tocantins_completo.xlsx como base
- 140 entidades (1 estado + 139 municípios)
- 4 divisões regionais mapeadas

TECNOLOGIAS:
- React + Tailwind CSS
- PostgreSQL (dados territoriais)
- Python FastAPI (backend)
- OpenAI API (chat com IA)

COMEÇAR COM:
1. Estrutura HTML/CSS do wireframe
2. Seletores funcionais (tipo + território)
3. Cards de dimensões com dados mockados
4. Depois: integração com banco e IA
```

---

## 📝 CHECKLIST DE IMPLEMENTAÇÃO

### Fase 1: Frontend Básico ✅
- [ ] Header com seletores duplos
- [ ] Cards de dimensões com seção regional
- [ ] Chat com badge de contexto
- [ ] Histórico com badges regionais
- [ ] Responsividade

### Fase 2: Dados Estáticos
- [ ] Carregar planilha no PostgreSQL
- [ ] Criar tabela `municipios_regioes`
- [ ] Popular com 140 registros
- [ ] Criar índices

### Fase 3: Backend API
- [ ] Endpoint `/territorios/tipos`
- [ ] Endpoint `/territorios/listar`
- [ ] Endpoint `/territorios/{id}/municipios`
- [ ] Endpoint `/territorios/{id}/indicadores`

### Fase 4: Integração Frontend-Backend
- [ ] Seletores buscam dados da API
- [ ] Cards mostram dados reais
- [ ] Comparação regional calculada
- [ ] Rankings gerados dinamicamente

### Fase 5: IA Contextual
- [ ] Chat envia contexto territorial
- [ ] IA considera tipo de território na resposta
- [ ] Sugestões contextuais (comparar região, etc.)
- [ ] Gráficos e mapas regionais

---

## 🎓 APRENDIZADOS DO DESIGN V2

### O Que Funcionou Bem

✅ **Seletor Duplo:** Separar tipo e território torna seleção intuitiva  
✅ **Contexto Regional nos Cards:** Informação crucial sem sobrecarregar  
✅ **Badges de Ranking:** Gamificação sutil motiva gestores  
✅ **Ações Rápidas Contextuais:** Sugestões mudam conforme seleção  
✅ **Divisões Históricas:** Permite continuidade de estudos antigos

### Desafios Identificados

⚠️ **Complexidade de Agregação:** Calcular médias regionais requer queries otimizadas  
⚠️ **Performance:** Agregação de 139 municípios pode ser lenta (usar cache)  
⚠️ **UX de Comparação:** Comparar 2+ regiões simultaneamente precisa UI dedicada  
⚠️ **Mapas:** Visualização geográfica é essencial mas complexa (usar Leaflet/Mapbox)

---

## 📞 PRÓXIMOS PASSOS

### Para Esta Sessão
1. ✅ Wireframes V2 criados
2. ✅ Documentação completa
3. ⏳ **PRÓXIMO:** Usar no Replit Agent para criar estrutura

### Para Próximas Sessões
1. Implementar backend com endpoints regionais
2. Popular banco com dados da planilha
3. Integrar frontend com backend
4. Adicionar mapas interativos
5. Treinar IA para análises regionais contextuais

---

## 🔗 ARQUIVOS RELACIONADOS

- `DIVISOES_REGIONAIS_ANALISE.md` - Análise técnica completa
- `municipios_tocantins_completo.xlsx` - Dados fonte (140 registros)
- `wireframe_dashboard_v2_regional.html` - Protótipo interativo
- `wireframe_dashboard_v2_regional.png` - Wireframe visual
- `wireframe_regional_comparison.png` - Caso de uso de comparação

---

**Wireframes V2 criados por:** Manus AI  
**Data:** 10 de Novembro de 2025  
**Projeto:** Framework V6.0 - Sistema de Inteligência Territorial  
**Versão:** 2.0 - Com Seleção Regional
