// ========================================
// PREPARAR CONTEXTO PARA LLM (V4 - MULTIDIMENSIONAL)
// Versão: 4.0
// Data: 30/11/2025
// Descrição: Integra dados multidimensionais (econômicos, sociais,
//            territoriais, ambientais) + memória RAG para análise profunda
// ========================================

// Pega os dados normalizados do webhook
const normalizedData = $items("Normalizar Entrada")[0].json;

// Pega a memória e aprendizados (Camadas 1, 2, 4 do RAG)
const memoryData = $items("Consultar Memória e Aprendizados")[0].json;

// Pega os dados multidimensionais
const rawData = $items("Consultar Dados PostgreSQL")[0].json;

// ========================================
// FUNÇÕES AUXILIARES
// ========================================

function formatCurrency(value) {
  if (!value) return "N/A";
  return new Intl.NumberFormat('pt-BR', { 
    style: 'currency', 
    currency: 'BRL',
    minimumFractionDigits: 0,
    maximumFractionDigits: 0
  }).format(value * 1000000); // Converte milhões para reais
}

function formatNumber(value, decimals = 0) {
  if (value === null || value === undefined) return "N/A";
  return new Intl.NumberFormat('pt-BR', {
    minimumFractionDigits: decimals,
    maximumFractionDigits: decimals
  }).format(value);
}

function formatPercent(value, decimals = 1) {
  if (value === null || value === undefined) return "N/A";
  return `${formatNumber(value, decimals)}%`;
}

// ========================================
// PROCESSAR MEMÓRIA RAG
// ========================================

let memorySection = "";
let learningsSection = "";
let expertiseSection = "";

if (memoryData && Array.isArray(memoryData)) {
  // Separar análises anteriores, aprendizados e expertise
  const previousAnalyses = memoryData.filter(row => row.analysis_content);
  const learnings = memoryData.filter(row => row.synthesis);
  const expertise = memoryData.filter(row => row.expertise_level);
  
  // Seção de análises anteriores
  if (previousAnalyses.length > 0) {
    memorySection = `\n## 📚 ANÁLISES ANTERIORES DESTE TERRITÓRIO\n\n`;
    memorySection += `Você já analisou **${normalizedData.territory_name}** ${previousAnalyses.length} vez(es) anteriormente:\n\n`;
    
    previousAnalyses.forEach((analysis, index) => {
      const date = new Date(analysis.created_at).toLocaleDateString('pt-BR');
      memorySection += `### Análise ${index + 1} (${date})\n`;
      memorySection += `- **Resumo:** ${analysis.analysis_summary}\n`;
      memorySection += `- **Confiança:** ${formatPercent(analysis.confidence_score * 100, 0)}\n\n`;
    });
    
    memorySection += `**IMPORTANTE:** Use essas análises anteriores para:\n`;
    memorySection += `- Identificar **mudanças e tendências** ao longo do tempo\n`;
    memorySection += `- Evitar **repetir as mesmas conclusões**\n`;
    memorySection += `- **Aprofundar insights** que foram superficiais antes\n`;
    memorySection += `- **Validar ou refutar** hipóteses anteriores\n\n`;
  }
  
  // Seção de aprendizados
  if (learnings.length > 0) {
    learningsSection = `\n## 🧠 APRENDIZADOS ACUMULADOS\n\n`;
    learningsSection += `Você acumulou ${learnings.length} aprendizados ao longo de suas análises econômicas:\n\n`;
    
    learnings.slice(0, 5).forEach((learning, index) => {
      learningsSection += `### Aprendizado ${index + 1}\n`;
      learningsSection += `${learning.synthesis}\n\n`;
    });
  }
  
  // Seção de expertise
  if (expertise.length > 0) {
    const exp = expertise[0];
    expertiseSection = `\n## 🎯 SEU NÍVEL DE EXPERTISE\n\n`;
    expertiseSection += `- **Nível:** ${exp.expertise_level}\n`;
    expertiseSection += `- **Experiência:** ${exp.analysis_count} análises realizadas\n`;
    expertiseSection += `- **Confiança Média:** ${formatPercent(exp.avg_confidence * 100, 0)}\n\n`;
  }
}

// ========================================
// PROCESSAR DADOS MULTIDIMENSIONAIS
// ========================================

let contextText = "";

if (!rawData || (Array.isArray(rawData) && rawData.length === 0)) {
  contextText = `\n## ⚠️ DADOS NÃO DISPONÍVEIS\n\nNão há dados disponíveis para ${normalizedData.territory_name} no período solicitado.\n\n`;
} else {
  const data = Array.isArray(rawData) ? rawData : [rawData];
  const latestYear = data[0]; // Dados mais recentes
  const oldestYear = data[data.length - 1]; // Dados mais antigos
  
  // ========================================
  // 1. VISÃO GERAL DO TERRITÓRIO
  // ========================================
  
  contextText += `\n## 🗺️ VISÃO GERAL DO TERRITÓRIO\n\n`;
  contextText += `**Nome:** ${latestYear.territory_name}\n`;
  contextText += `**Tipo:** ${latestYear.territory_type}\n`;
  contextText += `**Área:** ${formatNumber(latestYear.territory_area_km2, 2)} km²\n`;
  contextText += `**População:** ${formatNumber(latestYear.population)} habitantes\n`;
  contextText += `**Densidade Demográfica:** ${formatNumber(latestYear.population / latestYear.territory_area_km2, 2)} hab/km²\n\n`;
  
  // ========================================
  // 2. DIMENSÃO ECONÔMICA (Principal)
  // ========================================
  
  contextText += `\n## 💰 DIMENSÃO ECONÔMICA (${latestYear.year})\n\n`;
  
  contextText += `### Produto Interno Bruto\n`;
  contextText += `- **PIB Total:** ${formatCurrency(latestYear.gdp_millions)}\n`;
  contextText += `- **PIB per capita:** ${formatCurrency(latestYear.gdp_per_capita / 1000000)}\n`;
  
  if (data.length > 1) {
    const gdpGrowth = ((latestYear.gdp_millions - oldestYear.gdp_millions) / oldestYear.gdp_millions) * 100;
    contextText += `- **Crescimento ${oldestYear.year}-${latestYear.year}:** ${formatPercent(gdpGrowth, 1)}\n`;
  }
  contextText += `\n`;
  
  contextText += `### Estrutura Setorial\n`;
  contextText += `- **Agropecuária:** ${formatPercent(latestYear.agriculture_gdp_pct)}\n`;
  contextText += `- **Indústria:** ${formatPercent(latestYear.industry_gdp_pct)}\n`;
  contextText += `- **Serviços:** ${formatPercent(latestYear.services_gdp_pct)}\n`;
  contextText += `- **Administração Pública:** ${formatPercent(latestYear.public_admin_gdp_pct)}\n\n`;
  
  contextText += `### Mercado de Trabalho\n`;
  contextText += `- **Taxa de Emprego:** ${formatPercent(latestYear.employment_rate)}\n`;
  contextText += `- **Empregos Formais:** ${formatNumber(latestYear.formal_employment_count)}\n`;
  contextText += `- **Informalidade Estimada:** ${formatPercent(latestYear.informal_employment_est_pct)}\n`;
  contextText += `- **Salário Médio:** ${formatCurrency(latestYear.average_salary / 1000000)}\n\n`;
  
  contextText += `### Finanças Públicas\n`;
  contextText += `- **Receita Municipal:** ${formatCurrency(latestYear.municipal_revenue)}\n`;
  contextText += `- **Receita Própria:** ${formatCurrency(latestYear.own_revenue)}\n`;
  contextText += `- **Transferências:** ${formatCurrency(latestYear.transfer_revenue)}\n`;
  contextText += `- **Dependência Fiscal:** ${formatPercent(latestYear.fiscal_dependency_pct)}\n\n`;
  
  if (latestYear.exports_usd || latestYear.imports_usd) {
    contextText += `### Comércio Exterior\n`;
    contextText += `- **Exportações:** US$ ${formatNumber(latestYear.exports_usd)}\n`;
    contextText += `- **Importações:** US$ ${formatNumber(latestYear.imports_usd)}\n`;
    contextText += `- **Saldo Comercial:** US$ ${formatNumber(latestYear.trade_balance_usd)}\n\n`;
  }
  
  if (latestYear.business_count) {
    contextText += `### Estrutura Empresarial\n`;
    contextText += `- **Total de Empresas:** ${formatNumber(latestYear.business_count)}\n`;
    contextText += `- **Microempresas:** ${formatPercent(latestYear.micro_business_pct)}\n`;
    contextText += `- **Pequenas:** ${formatPercent(latestYear.small_business_pct)}\n`;
    contextText += `- **Médias:** ${formatPercent(latestYear.medium_business_pct)}\n`;
    contextText += `- **Grandes:** ${formatPercent(latestYear.large_business_pct)}\n\n`;
  }
  
  // ========================================
  // 3. DIMENSÃO SOCIAL (Contexto para Economia)
  // ========================================
  
  if (latestYear.ideb_initial_years || latestYear.poverty_rate_pct) {
    contextText += `\n## 👥 DIMENSÃO SOCIAL (Impacto na Economia)\n\n`;
    
    if (latestYear.ideb_initial_years) {
      contextText += `### Educação (Qualidade da Força de Trabalho)\n`;
      contextText += `- **IDEB Anos Iniciais:** ${formatNumber(latestYear.ideb_initial_years, 1)}\n`;
      contextText += `- **IDEB Anos Finais:** ${formatNumber(latestYear.ideb_final_years, 1)}\n`;
      contextText += `- **Taxa de Analfabetismo:** ${formatPercent(latestYear.illiteracy_rate_pct)}\n`;
      contextText += `- **Ensino Superior:** ${formatPercent(latestYear.higher_education_pct)}\n`;
      contextText += `\n**Implicação Econômica:** Educação de qualidade aumenta produtividade e atrai investimentos.\n\n`;
    }
    
    if (latestYear.poverty_rate_pct) {
      contextText += `### Pobreza e Desigualdade (Poder de Compra)\n`;
      contextText += `- **Taxa de Pobreza:** ${formatPercent(latestYear.poverty_rate_pct)}\n`;
      contextText += `- **Pobreza Extrema:** ${formatPercent(latestYear.extreme_poverty_rate_pct)}\n`;
      contextText += `- **Índice de Gini:** ${formatNumber(latestYear.gini_index, 3)}\n`;
      contextText += `- **Famílias no Bolsa Família:** ${formatNumber(latestYear.bolsa_familia_families)}\n`;
      contextText += `\n**Implicação Econômica:** Alta pobreza limita mercado consumidor e demanda agregada.\n\n`;
    }
    
    if (latestYear.basic_sanitation_coverage_pct) {
      contextText += `### Saneamento Básico (Saúde e Produtividade)\n`;
      contextText += `- **Cobertura de Saneamento:** ${formatPercent(latestYear.basic_sanitation_coverage_pct)}\n`;
      contextText += `- **Água Tratada:** ${formatPercent(latestYear.treated_water_coverage_pct)}\n`;
      contextText += `- **Esgotamento Sanitário:** ${formatPercent(latestYear.sewage_coverage_pct)}\n`;
      contextText += `- **Coleta de Lixo:** ${formatPercent(latestYear.solid_waste_collection_pct)}\n`;
      contextText += `\n**Implicação Econômica:** Saneamento precário reduz produtividade por doenças.\n\n`;
    }
  }
  
  // ========================================
  // 4. DIMENSÃO TERRITORIAL (Infraestrutura)
  // ========================================
  
  if (latestYear.road_network_km || latestYear.internet_coverage_pct) {
    contextText += `\n## 🛣️ DIMENSÃO TERRITORIAL (Infraestrutura para Economia)\n\n`;
    
    if (latestYear.road_network_km) {
      contextText += `### Infraestrutura Logística\n`;
      contextText += `- **Rede Viária Total:** ${formatNumber(latestYear.road_network_km, 0)} km\n`;
      contextText += `- **Estradas Pavimentadas:** ${formatNumber(latestYear.paved_roads_km, 0)} km (${formatPercent((latestYear.paved_roads_km / latestYear.road_network_km) * 100)})\n`;
      contextText += `- **Distância à Capital:** ${formatNumber(latestYear.distance_to_capital_km, 0)} km\n`;
      contextText += `- **Distância ao Porto Mais Próximo:** ${formatNumber(latestYear.distance_to_nearest_port_km, 0)} km\n`;
      contextText += `- **Aeroporto:** ${latestYear.has_airport ? 'Sim' : 'Não'}\n`;
      contextText += `- **Ferrovia:** ${latestYear.has_railway ? 'Sim' : 'Não'}\n`;
      contextText += `- **Hidrovia:** ${latestYear.has_waterway ? 'Sim' : 'Não'}\n`;
      contextText += `\n**Implicação Econômica:** Infraestrutura logística reduz custos de transporte e aumenta competitividade.\n\n`;
    }
    
    if (latestYear.internet_coverage_pct) {
      contextText += `### Conectividade Digital\n`;
      contextText += `- **Cobertura de Internet:** ${formatPercent(latestYear.internet_coverage_pct)}\n`;
      contextText += `- **Cobertura de Celular:** ${formatPercent(latestYear.mobile_coverage_pct)}\n`;
      contextText += `- **Cobertura de Energia Elétrica:** ${formatPercent(latestYear.electricity_coverage_pct)}\n`;
      contextText += `\n**Implicação Econômica:** Conectividade digital viabiliza e-commerce, serviços remotos e acesso a mercados.\n\n`;
    }
  }
  
  // ========================================
  // 5. DIMENSÃO AMBIENTAL (Agropecuária)
  // ========================================
  
  if (latestYear.agricultural_area_km2 || latestYear.forest_cover_pct) {
    contextText += `\n## 🌳 DIMENSÃO AMBIENTAL (Base Produtiva Agropecuária)\n\n`;
    
    if (latestYear.agricultural_area_km2) {
      contextText += `### Uso do Solo\n`;
      contextText += `- **Área Agrícola Total:** ${formatNumber(latestYear.agricultural_area_km2, 0)} km² (${formatPercent((latestYear.agricultural_area_km2 / latestYear.territory_area_km2) * 100)})\n`;
      contextText += `- **Pastagens:** ${formatNumber(latestYear.pasture_area_km2, 0)} km²\n`;
      contextText += `- **Lavouras Temporárias:** ${formatNumber(latestYear.temporary_crops_area_km2, 0)} km²\n`;
      contextText += `- **Lavouras Permanentes:** ${formatNumber(latestYear.permanent_crops_area_km2, 0)} km²\n`;
      contextText += `\n**Implicação Econômica:** Área agrícola define potencial produtivo agropecuário.\n\n`;
    }
    
    if (latestYear.forest_cover_pct) {
      contextText += `### Cobertura Florestal e Sustentabilidade\n`;
      contextText += `- **Cobertura Florestal:** ${formatNumber(latestYear.forest_cover_km2, 0)} km² (${formatPercent(latestYear.forest_cover_pct)})\n`;
      contextText += `- **Desmatamento Anual:** ${formatNumber(latestYear.deforestation_km2_year, 2)} km²/ano\n`;
      contextText += `- **Taxa de Desmatamento:** ${formatPercent(latestYear.deforestation_rate_pct)}\n`;
      contextText += `- **Áreas Protegidas:** ${formatNumber(latestYear.protected_areas_km2, 0)} km² (${formatPercent(latestYear.protected_areas_pct)})\n`;
      contextText += `\n**Implicação Econômica:** Desmatamento excessivo gera riscos regulatórios e restrições a exportações.\n\n`;
    }
    
    if (latestYear.rainfall_mm_year) {
      contextText += `### Clima e Produtividade Agrícola\n`;
      contextText += `- **Precipitação Anual:** ${formatNumber(latestYear.rainfall_mm_year, 0)} mm\n`;
      contextText += `- **Temperatura Média:** ${formatNumber(latestYear.avg_temperature_celsius, 1)}°C\n`;
      contextText += `- **Índice de Risco de Seca:** ${formatNumber(latestYear.drought_risk_index, 2)}\n`;
      contextText += `- **Focos de Incêndio:** ${formatNumber(latestYear.fire_hotspots_count)}\n`;
      contextText += `\n**Implicação Econômica:** Clima impacta diretamente produtividade agrícola e riscos de safra.\n\n`;
    }
  }
  
  // ========================================
  // 6. SÉRIE TEMPORAL (se disponível)
  // ========================================
  
  if (data.length > 1) {
    contextText += `\n## 📈 EVOLUÇÃO TEMPORAL (${oldestYear.year}-${latestYear.year})\n\n`;
    contextText += `| Indicador | ${oldestYear.year} | ${latestYear.year} | Variação |\n`;
    contextText += `|-----------|------------|------------|----------|\n`;
    
    const indicators = [
      { label: 'PIB (R$ milhões)', old: oldestYear.gdp_millions, new: latestYear.gdp_millions, format: 'currency' },
      { label: 'PIB per capita (R$)', old: oldestYear.gdp_per_capita, new: latestYear.gdp_per_capita, format: 'currency_small' },
      { label: 'Empregos Formais', old: oldestYear.formal_employment_count, new: latestYear.formal_employment_count, format: 'number' },
      { label: 'Salário Médio (R$)', old: oldestYear.average_salary, new: latestYear.average_salary, format: 'currency_small' },
      { label: 'Receita Municipal (R$ milhões)', old: oldestYear.municipal_revenue, new: latestYear.municipal_revenue, format: 'currency' }
    ];
    
    indicators.forEach(ind => {
      if (ind.old && ind.new) {
        const variation = ((ind.new - ind.old) / ind.old) * 100;
        const arrow = variation > 0 ? '↗️' : (variation < 0 ? '↘️' : '➡️');
        
        let oldVal, newVal;
        if (ind.format === 'currency') {
          oldVal = formatCurrency(ind.old);
          newVal = formatCurrency(ind.new);
        } else if (ind.format === 'currency_small') {
          oldVal = formatCurrency(ind.old / 1000000);
          newVal = formatCurrency(ind.new / 1000000);
        } else {
          oldVal = formatNumber(ind.old);
          newVal = formatNumber(ind.new);
        }
        
        contextText += `| ${ind.label} | ${oldVal} | ${newVal} | ${arrow} ${formatPercent(Math.abs(variation), 1)} |\n`;
      }
    });
    contextText += `\n`;
  }
}

// ========================================
// MONTAR PROMPT FINAL PARA O LLM
// ========================================

const finalPrompt = `
# ANÁLISE ECONÔMICA MULTIDIMENSIONAL

Você é o **Agente ECON**, especialista em análise econômica de territórios. Sua missão é gerar uma análise econômica **profunda, contextualizada e acionável** de **${normalizedData.territory_name}**.

${expertiseSection}

${memorySection}

${learningsSection}

${contextText}

---

## 📋 INSTRUÇÕES PARA A ANÁLISE

### Estrutura da Análise

1. **Resumo Executivo** (3-4 parágrafos)
   - Síntese dos principais achados econômicos
   - Destaque para mudanças significativas (se houver análises anteriores)
   - Principais oportunidades e desafios

2. **Análise Econômica Detalhada**
   - Estrutura produtiva e setores dinâmicos
   - Mercado de trabalho e qualidade dos empregos
   - Sustentabilidade fiscal e capacidade de investimento
   - Comércio exterior e inserção em cadeias produtivas (se aplicável)

3. **Análise Multidimensional Integrada** ⭐ NOVO
   - Como educação e capital humano impactam a economia?
   - Como infraestrutura logística afeta competitividade?
   - Como fatores ambientais influenciam agropecuária?
   - Como pobreza e desigualdade limitam mercado consumidor?

4. **Comparação Temporal** (se houver dados de múltiplos anos)
   - Tendências de crescimento ou estagnação
   - Mudanças estruturais na economia
   - Efetividade de políticas públicas implementadas

5. **Recomendações Estratégicas**
   - Políticas de desenvolvimento econômico prioritárias
   - Oportunidades de diversificação produtiva
   - Investimentos em infraestrutura crítica
   - Ações para reduzir dependência fiscal

### Diretrizes de Qualidade

- **Use TODOS os dados disponíveis** (econômicos, sociais, territoriais, ambientais)
- **Identifique interconexões** entre dimensões (ex: saneamento → produtividade)
- **Compare com análises anteriores** (se houver) e destaque mudanças
- **Aplique aprendizados acumulados** em sua análise
- **Seja específico e quantitativo** (cite números, percentuais, valores)
- **Evite jargão técnico excessivo** (análise deve ser acessível a gestores)
- **Foque em insights acionáveis** (não apenas descrever dados)

---

**Gere agora a análise econômica multidimensional completa.**
`;

// Retorna o prompt final
return { json: { prompt: finalPrompt, metadata: normalizedData } };
