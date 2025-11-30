// ============================================================================
// NÓ: PREPARAR CONTEXTO PARA LLM (V2 - RESILIENTE)
// Framework de Inteligência Territorial V6.0 - Workflow V5
// ============================================================================
// FUNÇÃO: Receber dados normalizados e do PostgreSQL, formatar em prompt estruturado
// INPUT: Normalizar Entrada + Consultar Dados PostgreSQL
// OUTPUT: Objeto com user_prompt, indicators_used, metadata
// ============================================================================

// Receber dados normalizados do webhook
const normalizedData = $items("Normalizar Entrada")[0].json;

// Receber dados do PostgreSQL (ARRAY de registros)
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
// PROCESSAMENTO DOS DADOS DO BANCO
// ============================================================================

let indicatorsText = '';
let indicatorsList = [];

if (dbRecords && dbRecords.length > 0) {
  // Transformar array de registros em lista de indicadores
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
  
  // Formatar indicadores para o prompt (um bloco por ano)
  indicatorsText = dbRecords.map(record => {
    const data = record.json;
    const sectors = data.sector_distribution || {};
    
    // Formatação segura de números
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
  indicatorsText = '⚠️ **Nenhum indicador econômico encontrado no banco de dados para este território e período.**\n\nPossíveis razões:\n- Território não cadastrado\n- Dados econômicos não disponíveis para o período solicitado\n- Erro na consulta ao banco de dados';
}

// ============================================================================
// CONSTRUÇÃO DO PROMPT ESTRUTURADO
// ============================================================================

const userPrompt = `
# TAREFA DE ANÁLISE ECONÔMICA

## TERRITÓRIO
- **Nome:** ${territoryName}
- **ID:** ${territoryId}

## PARÂMETROS DA ANÁLISE
- **Áreas de Foco:** ${focusAreas.join(', ')}
- **Período:** ${timePeriod}
- **Nível de Detalhe:** ${detailLevel}

## INDICADORES ECONÔMICOS DISPONÍVEIS

${indicatorsText}

## INSTRUÇÕES

Analise os dados acima e produza uma análise econômica completa de **${territoryName}**.

**Estrutura obrigatória:**

1. **RESUMO EXECUTIVO** (2-3 parágrafos)
   - Contexto geral do município
   - Principais destaques econômicos
   - Tendências identificadas no período

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

9. **CONCLUSÃO**
   - Síntese da situação econômica
   - Perspectivas futuras
   - Mensagem final para gestores

**REGRAS CRÍTICAS:**
- Use APENAS os dados fornecidos acima
- Cite números, anos e fontes explicitamente em cada afirmação
- Se um dado não estiver disponível, mencione explicitamente
- Não invente ou estime dados que não foram fornecidos
- Mantenha tom técnico mas acessível para gestores públicos
- Formate em Markdown com seções claras
- Use negrito para destacar números e conceitos importantes
- Inclua comparações temporais (crescimento, retração, estabilidade)
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
    metadata: {
      prepared_at: new Date().toISOString(),
      indicator_count: indicatorsList.length,
      years_analyzed: indicatorsList.map(i => i.year).join(', '),
      data_available: indicatorsList.length > 0
    }
  }
};
