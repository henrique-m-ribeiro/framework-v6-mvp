import { formatNumber, formatCurrency, formatPercent } from "@/lib/formatters";
import type { IndicatorMetadata } from "@shared/schema";

export function useIndicatorFormatter() {
  const formatValue = (value: any, indicatorKey: string, metadata?: IndicatorMetadata[]) => {
    if (value === null || value === undefined) return "N/D";
    
    const meta = metadata?.find(m => m.indicatorKey === indicatorKey);
    const unit = meta?.unit || "";

    if (unit.includes("bilhões")) {
      if (unit.startsWith("R$")) {
        return `R$ ${formatNumber(value, 1)}`;
      }
      return formatNumber(value, 1);
    }
    
    if (unit.includes("milhões")) {
      if (unit.startsWith("R$")) {
        return `R$ ${formatNumber(value, 0)}`;
      }
      return formatNumber(value, 0);
    }
    
    if (unit.startsWith("R$")) {
      return formatCurrency(value, 0);
    }
    
    if (unit === "%") {
      return `${formatNumber(value, 1)}%`;
    }

    switch (indicatorKey) {
      case "gdp":
      case "exports":
        return formatNumber(value, 1);
      case "revenue":
      case "municipalRevenue":
        return `R$ ${formatNumber(value, 0)}`;
      case "gdpPerCapita":
      case "incomePerCapita":
        return formatCurrency(value, 0);
      case "employmentRate":
      case "literacyRate":
      case "vegetationCoverage":
      case "povertyRate":
      case "unemploymentRate":
        return `${formatNumber(value, 1)}%`;
      case "inflation":
        return `${formatNumber(value, 2)}%`;
      case "population":
      case "deforestedArea":
      case "waterQuality":
      case "co2Emissions":
        return formatNumber(value, 0);
      case "idhm":
        return formatNumber(value, 3);
      default:
        return formatNumber(value, 2);
    }
  };

  return { formatValue };
}
