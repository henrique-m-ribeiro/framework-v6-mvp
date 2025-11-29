import type { EconomicIndicator } from "../../shared/schema";

/**
 * Normaliza um indicador econômico, garantindo compatibilidade entre
 * os campos legados e os novos campos do Modelo Conceitual v4.0.
 * 
 * Durante a transição, usa o novo campo quando disponível,
 * mas faz fallback para o campo legado se necessário.
 */
export function normalizeEconomicIndicator(indicator: EconomicIndicator) {
  return {
    ...indicator,
    // Usa gdpCurrentPrices se disponível, senão usa gdp legado
    gdpValue: indicator.gdpCurrentPrices 
      ? parseFloat(indicator.gdpCurrentPrices as string)
      : indicator.gdp,
    
    // Novos indicadores (podem ser null durante a transição)
    totalWageMass: indicator.totalWageMass 
      ? parseFloat(indicator.totalWageMass as string)
      : null,
    activeCompaniesCount: indicator.activeCompaniesCount ?? null,
    municipalTaxRevenue: indicator.municipalTaxRevenue 
      ? parseFloat(indicator.municipalTaxRevenue as string)
      : null,
    
    // Metadados
    source: indicator.source ?? null,
    metadata: indicator.metadata ?? null,
  };
}

/**
 * Normaliza uma lista de indicadores econômicos.
 */
export function normalizeEconomicIndicators(indicators: EconomicIndicator[]) {
  return indicators.map(normalizeEconomicIndicator);
}
