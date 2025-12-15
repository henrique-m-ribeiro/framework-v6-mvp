# Análise das Divisões Regionais do Tocantins

**Data:** 10 de Novembro de 2025  
**Objetivo:** Incluir funcionalidade de análise por regiões no dashboard

---

## 📊 ESTRUTURA DAS DIVISÕES REGIONAIS

### 1. Divisão Atual (IBGE 2017+)

#### Regiões Geográficas Intermediárias (3 regiões)
| ID | Nome | Municípios |
|----|------|------------|
| 1701 | Palmas | 42 |
| 1702 | Araguaína | 65 |
| 1703 | Gurupi | 32 |

**Características:**
- Escala intermediária entre UF e municípios
- Articulam as Regiões Imediatas
- Polo de hierarquia superior
- Serviços mais complexos e ocasionais

#### Regiões Geográficas Imediatas (11 regiões)
| ID | Nome | Municípios | Região Intermediária |
|----|------|------------|----------------------|
| 170001 | Palmas | 10 | Palmas |
| 170002 | Porto Nacional | 13 | Palmas |
| 170003 | Paraíso do Tocantins | 14 | Palmas |
| 170004 | Miracema do Tocantins | 5 | Palmas |
| 170005 | Araguaína | 21 | Araguaína |
| 170006 | Guaraí | 14 | Araguaína |
| 170007 | Colinas do Tocantins | 9 | Araguaína |
| 170008 | Tocantinópolis | 8 | Araguaína |
| 170009 | Araguatins | 13 | Araguaína |
| 170010 | Gurupi | 18 | Gurupi |
| 170011 | Dianópolis | 14 | Gurupi |

**Características:**
- Região do dia-a-dia, cotidiana
- Centro urbano local como base
- Rede urbana e fluxos cotidianos
- Serviços básicos e comércio local

---

### 2. Divisão Histórica (IBGE 1989-2017)

#### Mesorregiões (2 regiões)
| ID | Nome | Municípios |
|----|------|------------|
| 1701 | Ocidental do Tocantins | 93 |
| 1702 | Oriental do Tocantins | 46 |

**Características:**
- Divisão baseada em homogeneidade econômica e social
- Vigente de 1989 a 2017
- Substituída pelas Regiões Intermediárias

#### Microrregiões (8 regiões)
| ID | Nome | Municípios | Mesorregião |
|----|------|------------|-------------|
| 17001 | Bico do Papagaio | 25 | Ocidental |
| 17002 | Araguaína | 17 | Ocidental |
| 17003 | Miracema do Tocantins | 24 | Ocidental |
| 17004 | Rio Formoso | 13 | Ocidental |
| 17005 | Gurupi | 14 | Ocidental |
| 17006 | Porto Nacional | 11 | Oriental |
| 17007 | Jalapão | 15 | Oriental |
| 17008 | Dianópolis | 20 | Oriental |

**Características:**
- Divisão baseada em similaridades econômicas e sociais
- Vigente de 1989 a 2017
- Substituída pelas Regiões Imediatas
- Ainda utilizada em alguns estudos históricos

---

## 🎯 CASOS DE USO PARA ANÁLISES REGIONAIS

### Caso de Uso 1: Comparação entre Regiões Intermediárias
**Pergunta do Gestor:** "Como está a economia da região de Araguaína comparada com Palmas?"

**Resposta da IA:**
- Agregação de dados dos 65 municípios de Araguaína vs. 42 de Palmas
- Comparação de PIB total, PIB per capita, emprego formal
- Gráficos comparativos
- Ranking de municípios dentro de cada região

---

### Caso de Uso 2: Análise de Região Imediata
**Pergunta do Gestor:** "Qual a situação da educação na região imediata de Gurupi?"

**Resposta da IA:**
- Agregação de dados dos 18 municípios da região
- IDEB médio da região
- Comparação com média estadual
- Identificação de municípios com melhor/pior desempenho
- Mapa da região com cores indicando IDEB

---

### Caso de Uso 3: Análise Histórica com Microrregiões
**Pergunta do Gestor:** "Como evoluiu o desmatamento no Bico do Papagaio nos últimos 10 anos?"

**Resposta da IA:**
- Série histórica de desmatamento (2014-2024)
- Agregação dos 25 municípios da microrregião
- Comparação com outras microrregiões
- Identificação de municípios críticos
- Correlação com políticas públicas implementadas

---

### Caso de Uso 4: Comparação Município vs. Região
**Pergunta do Gestor:** "Palmas está acima ou abaixo da média da sua região imediata em saúde?"

**Resposta da IA:**
- Indicadores de Palmas
- Média da Região Imediata de Palmas (10 municípios)
- Posição de Palmas no ranking regional
- Identificação de municípios referência na região

---

## 🎨 PROPOSTA DE DESIGN ATUALIZADO

### Mudanças no Header

**Antes:**
```
[Território: Palmas ▼]
```

**Depois:**
```
[Tipo: Município ▼] [Território: Palmas ▼]
```

**Opções de Tipo:**
- Estado (Tocantins completo)
- Região Intermediária (3 opções)
- Região Imediata (11 opções)
- Município (139 opções)
- Mesorregião (2 opções - histórico)
- Microrregião (8 opções - histórico)

---

### Mudanças nos Cards de Dimensões

**Adicionar:**
- Comparação com média regional
- Ranking dentro da região
- Badge indicando tipo de território selecionado

**Exemplo:**
```
┌─────────────────────────────┐
│ 📈 Econômica                │
│                             │
│ PIB Total: R$ 32,5 bi       │
│ ↓ -0,4% vs. ano anterior    │
│                             │
│ Região Imediata (Palmas):   │
│ R$ 45,2 bi (72% do total)   │
│                             │
│ Ranking: 1º de 10 municípios│
└─────────────────────────────┘
```

---

### Mudanças no Chat com IA

**Adicionar sugestões contextuais baseadas no tipo de território:**

**Se Município selecionado:**
- 💡 Comparar com região imediata
- 💡 Comparar com região intermediária
- 💡 Ver ranking regional

**Se Região selecionada:**
- 💡 Ver municípios da região
- 💡 Comparar com outras regiões
- 💡 Identificar outliers

---

### Nova Funcionalidade: Mapa Regional

**Adicionar painel colapsável com mapa:**
- Mapa do Tocantins
- Destacar território selecionado
- Cores indicando valores de indicadores
- Clique em município/região para selecionar

---

## 🗂️ ESTRUTURA DE DADOS NO BANCO

### Tabela: `divisoes_regionais`

```sql
CREATE TABLE divisoes_regionais (
    id SERIAL PRIMARY KEY,
    codigo_ibge VARCHAR(7) NOT NULL,
    nome_territorio VARCHAR(100) NOT NULL,
    tipo_divisao VARCHAR(30) NOT NULL, -- 'estado', 'regiao_intermediaria', 'regiao_imediata', 'municipio', 'mesorregiao', 'microrregiao'
    
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
    
    -- Metadados
    populacao INTEGER,
    area_km2 NUMERIC(12,2),
    geometria GEOMETRY(MULTIPOLYGON, 4326), -- PostGIS
    
    UNIQUE(codigo_ibge, tipo_divisao)
);

-- Índices
CREATE INDEX idx_divisoes_tipo ON divisoes_regionais(tipo_divisao);
CREATE INDEX idx_divisoes_regiao_imediata ON divisoes_regionais(regiao_imediata_id);
CREATE INDEX idx_divisoes_regiao_intermediaria ON divisoes_regionais(regiao_intermediaria_id);
CREATE INDEX idx_divisoes_geometria ON divisoes_regionais USING GIST(geometria);
```

---

### Tabela: `municipios_regioes` (Relacionamento)

```sql
CREATE TABLE municipios_regioes (
    id SERIAL PRIMARY KEY,
    codigo_municipio VARCHAR(7) NOT NULL,
    nome_municipio VARCHAR(100) NOT NULL,
    
    -- Divisão Atual
    regiao_imediata_id INTEGER NOT NULL,
    regiao_imediata_nome VARCHAR(100) NOT NULL,
    regiao_intermediaria_id INTEGER NOT NULL,
    regiao_intermediaria_nome VARCHAR(100) NOT NULL,
    
    -- Divisão Histórica
    microrregiao_id INTEGER NOT NULL,
    microrregiao_nome VARCHAR(100) NOT NULL,
    mesorregiao_id INTEGER NOT NULL,
    mesorregiao_nome VARCHAR(100) NOT NULL,
    
    FOREIGN KEY (codigo_municipio) REFERENCES entidades_territoriais(codigo_ibge)
);
```

---

## 🔌 ENDPOINTS DA API

### GET /api/v1/territorios/tipos
**Descrição:** Lista tipos de território disponíveis

**Resposta:**
```json
{
    "tipos": [
        {"id": "estado", "nome": "Estado", "quantidade": 1},
        {"id": "regiao_intermediaria", "nome": "Região Intermediária", "quantidade": 3},
        {"id": "regiao_imediata", "nome": "Região Imediata", "quantidade": 11},
        {"id": "municipio", "nome": "Município", "quantidade": 139},
        {"id": "mesorregiao", "nome": "Mesorregião (histórico)", "quantidade": 2},
        {"id": "microrregiao", "nome": "Microrregião (histórico)", "quantidade": 8}
    ]
}
```

---

### GET /api/v1/territorios/listar?tipo={tipo}
**Descrição:** Lista territórios de um tipo específico

**Exemplo:** `/api/v1/territorios/listar?tipo=regiao_imediata`

**Resposta:**
```json
{
    "tipo": "regiao_imediata",
    "territorios": [
        {
            "id": 170001,
            "nome": "Palmas",
            "municipios": 10,
            "populacao": 450000,
            "regiao_intermediaria": "Palmas"
        },
        {
            "id": 170002,
            "nome": "Porto Nacional",
            "municipios": 13,
            "populacao": 120000,
            "regiao_intermediaria": "Palmas"
        },
        ...
    ]
}
```

---

### GET /api/v1/territorios/{codigo}/municipios
**Descrição:** Lista municípios de uma região

**Exemplo:** `/api/v1/territorios/170001/municipios` (Região Imediata de Palmas)

**Resposta:**
```json
{
    "territorio": {
        "id": 170001,
        "nome": "Palmas",
        "tipo": "regiao_imediata"
    },
    "municipios": [
        {"codigo": "1721000", "nome": "Palmas", "populacao": 306296},
        {"codigo": "1701101", "nome": "Aparecida do Rio Negro", "populacao": 4856},
        ...
    ],
    "total_municipios": 10,
    "populacao_total": 450000
}
```

---

### GET /api/v1/territorios/{codigo}/indicadores?dimensao={dimensao}
**Descrição:** Indicadores agregados de uma região

**Exemplo:** `/api/v1/territorios/1701/indicadores?dimensao=economica` (Região Intermediária de Palmas)

**Resposta:**
```json
{
    "territorio": {
        "id": 1701,
        "nome": "Palmas",
        "tipo": "regiao_intermediaria",
        "municipios": 42
    },
    "dimensao": "economica",
    "indicadores": {
        "pib_total": 52000000000,
        "pib_per_capita": 35000,
        "emprego_formal": 250000,
        "taxa_crescimento": 2.5
    },
    "comparacao": {
        "media_estadual": 34258.77,
        "ranking": 1,
        "total_regioes": 3
    },
    "municipios_destaque": [
        {"nome": "Palmas", "pib_per_capita": 87800, "posicao": 1},
        {"nome": "Porto Nacional", "pib_per_capita": 42000, "posicao": 2}
    ]
}
```

---

## 🎨 COMPONENTES REACT ATUALIZADOS

### TerritorySelector Component

```jsx
interface TerritorySelectorProps {
    onTerritoryChange: (type: string, id: string) => void;
}

const TerritorySelector: React.FC<TerritorySelectorProps> = ({ onTerritoryChange }) => {
    const [territoryType, setTerritoryType] = useState('municipio');
    const [territories, setTerritories] = useState([]);
    const [selectedTerritory, setSelectedTerritory] = useState('1721000'); // Palmas

    useEffect(() => {
        // Buscar territórios do tipo selecionado
        api.get(`/territorios/listar?tipo=${territoryType}`)
            .then(res => setTerritories(res.data.territorios));
    }, [territoryType]);

    const handleTypeChange = (type: string) => {
        setTerritoryType(type);
        onTerritoryChange(type, null);
    };

    const handleTerritoryChange = (id: string) => {
        setSelectedTerritory(id);
        onTerritoryChange(territoryType, id);
    };

    return (
        <div className="territory-selector">
            <select value={territoryType} onChange={(e) => handleTypeChange(e.target.value)}>
                <option value="estado">Estado</option>
                <option value="regiao_intermediaria">Região Intermediária</option>
                <option value="regiao_imediata">Região Imediata</option>
                <option value="municipio">Município</option>
                <option disabled>──────────────</option>
                <option value="mesorregiao">Mesorregião (histórico)</option>
                <option value="microrregiao">Microrregião (histórico)</option>
            </select>

            <select value={selectedTerritory} onChange={(e) => handleTerritoryChange(e.target.value)}>
                {territories.map(t => (
                    <option key={t.id} value={t.id}>
                        {t.nome} ({t.municipios} municípios)
                    </option>
                ))}
            </select>
        </div>
    );
};
```

---

## 📊 EXEMPLOS DE QUERIES SQL REGIONAIS

### Query: PIB Total de Região Imediata

```sql
SELECT 
    mr.regiao_imediata_id,
    mr.regiao_imediata_nome,
    COUNT(DISTINCT mr.codigo_municipio) AS total_municipios,
    SUM(de.pib_mil_reais) AS pib_total_mil_reais,
    AVG(de.pib_per_capita_reais) AS pib_per_capita_medio,
    SUM(dd.populacao) AS populacao_total
FROM municipios_regioes mr
JOIN dados_economicos de ON mr.codigo_municipio = de.codigo_ibge
JOIN dados_demograficos dd ON mr.codigo_municipio = dd.codigo_ibge
WHERE mr.regiao_imediata_id = $1
  AND de.ano = (SELECT MAX(ano) FROM dados_economicos)
  AND dd.ano = (SELECT MAX(ano) FROM dados_demograficos)
GROUP BY mr.regiao_imediata_id, mr.regiao_imediata_nome;
```

---

### Query: Ranking de Municípios dentro de Região

```sql
SELECT 
    et.nome AS municipio,
    de.pib_per_capita_reais,
    RANK() OVER (ORDER BY de.pib_per_capita_reais DESC) AS ranking_regional
FROM entidades_territoriais et
JOIN municipios_regioes mr ON et.codigo_ibge = mr.codigo_municipio
JOIN dados_economicos de ON et.codigo_ibge = de.codigo_ibge
WHERE mr.regiao_imediata_id = $1
  AND de.ano = (SELECT MAX(ano) FROM dados_economicos)
ORDER BY de.pib_per_capita_reais DESC;
```

---

### Query: Comparação entre Regiões Intermediárias

```sql
SELECT 
    mr.regiao_intermediaria_id,
    mr.regiao_intermediaria_nome,
    COUNT(DISTINCT mr.codigo_municipio) AS municipios,
    SUM(de.pib_mil_reais) AS pib_total,
    AVG(de.pib_per_capita_reais) AS pib_per_capita_medio,
    SUM(dd.populacao) AS populacao
FROM municipios_regioes mr
JOIN dados_economicos de ON mr.codigo_municipio = de.codigo_ibge
JOIN dados_demograficos dd ON mr.codigo_municipio = dd.codigo_ibge
WHERE de.ano = (SELECT MAX(ano) FROM dados_economicos)
  AND dd.ano = (SELECT MAX(ano) FROM dados_demograficos)
GROUP BY mr.regiao_intermediaria_id, mr.regiao_intermediaria_nome
ORDER BY pib_total DESC;
```

---

## 🚀 IMPLEMENTAÇÃO FASEADA

### Fase 1: Estrutura Básica (MVP)
- ✅ Seletor de tipo de território
- ✅ Seletor de território específico
- ✅ Agregação de dados por região
- ✅ Comparação com média regional

### Fase 2: Funcionalidades Avançadas
- ⏳ Mapa interativo com regiões
- ⏳ Ranking de municípios dentro de região
- ⏳ Comparação entre regiões
- ⏳ Análise histórica com divisões antigas

### Fase 3: Inteligência Avançada
- ⏳ IA identifica automaticamente outliers regionais
- ⏳ Sugestões de políticas públicas baseadas em benchmarks regionais
- ⏳ Alertas de mudanças significativas em regiões

---

**Documento criado por:** Manus AI  
**Data:** 10 de Novembro de 2025  
**Projeto:** Framework V6.0 - Sistema de Inteligência Territorial
