// ============================================================================
// NÓ: PREPARAR CONTEXTO PARA LLM (V3 - COM MEMÓRIA)
// Framework de Inteligência Territorial V6.0 - Workflow V6
// ============================================================================
// FUNÇÃO: Preparar contexto estruturado incluindo memória e aprendizados
// INPUT: Normalizar Entrada + Consultar Memória + Consultar Dados PostgreSQL
// OUTPUT: Objeto com user_prompt enriquecido com contexto histórico
// ============================================================================

// Receber dados normalizados do webhook
const normalizedData = $items("Normalizar Entrada")[0].json;

// Receber dados da memória e aprendizados
const memoryRecords = $items("Consultar Memória e Aprendizados");

// Receber dados brutos do PostgreSQL
const dbRecords = $items("Consultar Dados PostgreSQL");

// ============================================================================
// EXTRAÇÃO SEGURA DE DADOS NORMALIZADOS
// ============================================================================

const agentId = normalizedData.agent_id || "econ";
const agentName = agentId.toUpperCase();
const territoryId = normalizedData.territory_id;
const territoryName = normalizedData.territory_name || "Território Desconhecido";
const analysisType = normalizedData.analysis_type || "economic_overview";
const userId = normalizedData.user_id || "system";

// Parâmetros normalizados
const parameters = normalizedData.parameters || {};
const timePeriod = parameters.time_period || "2019-2023";
const focusAreas = parameters.focus_areas || ["PIB", "emprego", "renda"];
const detailLevel = parameters.detail_level || "comprehensive";

// ============================================================================
// PROCESSAMENTO DA MEMÓRIA E APRENDIZADOS (CAMADAS 1, 2, 4)
// ============================================================================

let previousAnalyses = [];
let learnings = [];
let expertiseInfo = null;

if (memoryRecords && memoryRecords.length > 0) {
  memoryRecords.forEach(record => {
    const data = record.json;
    
    if (data.source_layer === 'memory') {
      previousAnalyses.push({
        id: data.memory_id,
        summary: data.analysis_summary,
        confidence: data.confidence_score,
        date: data.created_at,
        indicators: data.indicators_used
      });
    } else if (data.source_layer === 'learning') {
      learnings.push({
        id: data.learning_id,
        synthesis: data.analysis_content,
        confidence: data.confidence_score,
        date: data.created_at
      });
    } else if (data.source_layer === 'expertise') {
      expertiseInfo = {
        level: data.analysis_content,
        analysis_count: data.analysis_summary,
        avg_confidence: data.confidence_score
      };
    }
  });
}

// Formatar análises anteriores para o prompt
let previousAnalysesText = '';
if (previousAnalyses.length > 0) {
  previousAnalysesText = `
## 📚 ANÁLISES ANTERIORES DESTE TERRITÓRIO

Você já analisou **${territoryName}** ${previousAnalyses.length} vez(es) anteriormente. Considere os seguintes insights:

${previousAnalyses.map((analysis, index) => `
### Análise ${index + 1} (${new Date(analysis.date).toLocaleDateString('pt-BR')})
- **Resumo:** ${analysis.summary}
- **Confiança:** ${(analysis.confidence * 100).toFixed(0)}%
`).join('\n')}

**IMPORTANTE:** Use essas análises anteriores para:
- Identificar mudanças e tendências ao longo do tempo
- Evitar repetir as mesmas conclusões
- Aprofundar insights que foram superficiais antes
- Validar ou refutar hipóteses anteriores
`;
} else {
  previousAnalysesText = `
## 🆕 PRIMEIRA ANÁLISE DESTE TERRITÓRIO

Esta é a **primeira vez** que você analisa **${territoryName}**. Seja especialmente cuidadoso e detalhado.
`;
}

// Formatar aprendizados acumulados
let learningsText = '';
if (learnings.length > 0) {
  learningsText = `
## 🧠 APRENDIZADOS ACUMULADOS (Camada 2)

Você acumulou **${learnings.length} aprendizados** ao longo de suas análises econômicas. Aplique esses padrões:

${learnings.slice(0, 3).map((learning, index) => `
### Aprendizado ${index + 1}
${learning.synthesis}
`).join('\n')}
`;
}

// Formatar expertise atual
let expertiseText = '';
if (expertiseInfo) {
  expertiseText = `
## 🎯 SEU NÍVEL DE EXPERTISE

- **Nível:** ${expertiseInfo.level}
- **Experiência:** ${expertiseInfo.analysis_count}
- **Confiança Média:** ${(expertiseInfo.avg_confidence * 100).toFixed(0)}%

Ajuste o nível de profundidade da análise de acordo com sua expertise.
`;
}

// ============================================================================
// PROCESSAMENTO DOS DADOS BRUTOS DO BANCO
// ============================================================================

let indicatorsText = '';
let indicatorsList = [];

if (dbRecords && dbRecords.length > 0) {
  indicatorsList = dbRecords.map(record => {
    const data = record.json;
    return {
      year: data.year || "N/A",
      gdp_millions: data.gdp_millions || 0,
      gdp_per_capita: data.gdp_per_capita || 0,
      employment_rate: data.employment_rate || 0,
      municipal_revenue: data.municipal_revenue || 0,
      sector_distribution: data.sector_distribution || {},
      data_sources: data.data_sources || "N/A"
    };
  });
  
  indicatorsText = dbRecords.map(record => {
    const data = record.json;
    const sectors = data.sector_distribution || {};
    
    const gdpMillions = data.gdp_millions ? parseFloat(data.gdp_millions).toFixed(2) : "N/A";
    const gdpPerCapita = data.gdp_per_capita ? parseFloat(data.gdp_per_capita).toFixed(2) : "N/A";
    const employmentRate = data.employment_rate ? parseFloat(data.employment_rate).toFixed(1) : "N/A";
    const revenue = data.municipal_revenue ? (parseFloat(data.municipal_revenue) / 1000000).toFixed(2) : "N/A";
    
    return `
### Ano ${data.year || "N/A"}
- **PIB Municipal:** R$ ${gdpMillions} milhões
- **PIB per capita:** R$ ${gdpPerCapita}
- **Taxa de Emprego Formal:** ${employmentRate}%
- **Receita Municipal:** R$ ${revenue} milhões
- **Distribuição Setorial:**
  - Serviços: ${sectors.servicos || "N/A"}%
  - Indústria: ${sectors.industria || "N/A"}%
  - Agricultura: ${sectors.agricultura || "N/A"}%
- **Fonte:** ${data.data_sources || "N/A"}
`;
  }).join('\n');
} else {
  indicatorsText = '⚠️ **Nenhum indicador econômico encontrado no banco de dados para este território e período.**';
}

// ============================================================================
// CONSTRUÇÃO DO PROMPT ESTRUTURADO COM MEMÓRIA
// ============================================================================

const userPrompt = `
# TAREFA DE ANÁLISE ECONÔMICA EVOLUTIVA

## TERRITÓRIO
- **Nome:** ${territoryName}
- **ID:** ${territoryId}

## PARÂMETROS DA ANÁLISE
- **Áreas de Foco:** ${focusAreas.join(', ')}
- **Período:** ${timePeriod}
- **Nível de Detalhe:** ${detailLevel}

${expertiseText}

${previousAnalysesText}

${learningsText}

## INDICADORES ECONÔMICOS DISPONÍVEIS (Dados Brutos)

${indicatorsText}

## INSTRUÇÕES

Analise os dados acima e produza uma análise econômica **EVOLUTIVA** de **${territoryName}**.

**DIFERENCIAIS DESTA ANÁLISE:**
- Se houver análises anteriores, **compare** com elas e identifique mudanças
- Aplique os **aprendizados acumulados** para enriquecer sua análise
- Ajuste a profundidade de acordo com seu **nível de expertise**
- **NÃO repita** conclusões que já foram feitas antes
- **APROFUNDE** insights que foram superficiais em análises anteriores

**Estrutura obrigatória:**

1. **RESUMO EXECUTIVO** (2-3 parágrafos)
   - Contexto geral do município
   - Principais destaques econômicos
   - **NOVO:** Mudanças em relação a análises anteriores (se houver)

2. **ANÁLISE DO PIB E CRESCIMENTO ECONÔMICO**
   - Evolução do PIB total (${timePeriod})
   - Análise do PIB per capita
   - Comparação com médias regionais/nacionais
   - Fatores que explicam o crescimento ou retração

3. **MERCADO DE TRABALHO E EMPREGO**
   - Evolução da taxa de emprego formal
   - Análise da qualidade dos empregos
   - Setores que mais empregam
   - Desafios do mercado de trabalho local

4. **RENDA E DISTRIBUIÇÃO**
   - Análise da renda per capita
   - Distribuição de renda (se disponível)
   - Comparação com indicadores regionais

5. **ANÁLISE SETORIAL**
   - Participação de cada setor no PIB
   - Evolução da distribuição setorial
   - Setores em crescimento e em retração
   - Diversificação econômica

6. **FINANÇAS PÚBLICAS**
   - Evolução da receita municipal
   - Capacidade de investimento
   - Dependência de transferências (se disponível)

7. **PRINCIPAIS DESAFIOS IDENTIFICADOS**
   - Desafios econômicos estruturais
   - Vulnerabilidades identificadas
   - Áreas que necessitam atenção

8. **OPORTUNIDADES E RECOMENDAÇÕES**
   - Oportunidades de desenvolvimento econômico
   - Setores com potencial de crescimento
   - Recomendações para gestores públicos

9. **CONCLUSÃO E EVOLUÇÃO**
   - Síntese da situação econômica
   - **NOVO:** Como esta análise avança em relação às anteriores
   - Perspectivas futuras
   - Mensagem final para gestores

**REGRAS CRÍTICAS:**
- Use APENAS os dados fornecidos acima
- Cite números, anos e fontes explicitamente
- Se um dado não estiver disponível, mencione explicitamente
- Não invente ou estime dados que não foram fornecidos
- Mantenha tom técnico mas acessível
- Formate em Markdown com seções claras
- Use negrito para destacar números e conceitos importantes
- **COMPARE** com análises anteriores quando disponíveis
`;

// ============================================================================
// RETORNO DO OBJETO ESTRUTURADO
// ============================================================================

return {
  json: {
    agent_id: agentId,
    agent_name: agentName,
    territory_id: territoryId,
    territory_name: territoryName,
    analysis_type: analysisType,
    user_id: userId,
    user_prompt: userPrompt,
    indicators_used: indicatorsList,
    parameters: parameters,
    memory_context: {
      previous_analyses_count: previousAnalyses.length,
      learnings_count: learnings.length,
      expertise_level: expertiseInfo?.level || "NOVATO",
      has_memory: previousAnalyses.length > 0
    },
    metadata: {
      prepared_at: new Date().toISOString(),
      indicator_count: indicatorsList.length,
      years_analyzed: indicatorsList.map(i => i.year).join(', '),
      data_available: indicatorsList.length > 0,
      memory_layers_used: ['Camada 1: Memória', 'Camada 2: Aprendizado', 'Camada 4: Expertise']
    }
  }
};
