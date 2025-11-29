import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import KPICard from "../shared/KPICard";
import AIAnalysisBox from "../shared/AIAnalysisBox";
import DataTable from "../shared/DataTable";
import { DollarSign, TrendingUp, Briefcase, Building2, Users, Factory, Landmark } from "lucide-react";
import type { EconomicIndicator } from "@shared/schema";
import { formatNumber, formatCurrency, formatPercent } from "@/lib/formatters";
import { useIndicatorMetadata } from "@/hooks/useIndicatorMetadata";
import { IndicatorLineChart } from "@/components/charts/IndicatorLineChart";
import { IndicatorComparisonChart } from "@/components/charts/IndicatorComparisonChart";

interface EconomicTabProps {
  territoryId: string;
}

export default function EconomicTab({ territoryId }: EconomicTabProps) {
  const [selectedLineIndicator, setSelectedLineIndicator] = useState("gdp");
  const [selectedBarIndicator1, setSelectedBarIndicator1] = useState("gdpPerCapita");
  const [selectedBarIndicator2, setSelectedBarIndicator2] = useState("employmentRate");

  const { data: economicData = [] } = useQuery<EconomicIndicator[]>({
    queryKey: ["/api/territories", territoryId, "indicators", "economic"],
    enabled: !!territoryId,
  });

  const { data: metadata = [] } = useIndicatorMetadata("economic");

  if (economicData.length === 0) {
    return <div className="p-6">Carregando dados econômicos...</div>;
  }

  const latest = economicData[0];
  const previous = economicData[1];

  const calculateTrend = (current: number | null | undefined, prev: number | null | undefined) => {
    if (!current || !prev) return { value: 0, direction: "neutral" as const };
    const change = ((current - prev) / prev) * 100;
    return {
      value: Number(change.toFixed(1)),
      direction: change > 0 ? "up" as const : change < 0 ? "down" as const : "neutral" as const,
    };
  };

  const gdpTrend = previous ? calculateTrend(latest.gdp, previous.gdp) : { value: 0, direction: "neutral" as const };
  const gdpPerCapitaTrend = previous ? calculateTrend(latest.gdpPerCapita, previous.gdpPerCapita) : { value: 0, direction: "neutral" as const };
  const employmentTrend = previous ? calculateTrend(latest.employmentRate, previous.employmentRate) : { value: 0, direction: "neutral" as const };
  const revenueTrend = previous ? calculateTrend(latest.revenue, previous.revenue) : { value: 0, direction: "neutral" as const };
  
  // Novos indicadores (Modelo Conceitual v4.0)
  const totalWageMass = latest.totalWageMass ? parseFloat(latest.totalWageMass as string) : null;
  const activeCompaniesCount = latest.activeCompaniesCount ?? null;
  const municipalTaxRevenue = latest.municipalTaxRevenue ? parseFloat(latest.municipalTaxRevenue as string) : null;
  
  const wageMassTrend = previous && totalWageMass && previous.totalWageMass
    ? calculateTrend(totalWageMass, parseFloat(previous.totalWageMass as string))
    : { value: 0, direction: "neutral" as const };
  
  const companiesTrend = previous && activeCompaniesCount && previous.activeCompaniesCount
    ? calculateTrend(activeCompaniesCount, previous.activeCompaniesCount)
    : { value: 0, direction: "neutral" as const };
  
  const taxRevenueTrend = previous && municipalTaxRevenue && previous.municipalTaxRevenue
    ? calculateTrend(municipalTaxRevenue, parseFloat(previous.municipalTaxRevenue as string))
    : { value: 0, direction: "neutral" as const };
  const columns = [
    { key: 'year', label: 'Ano', sortable: true },
    { key: 'gdp', label: 'PIB (R$ bi)', sortable: true },
    { key: 'gdpPerCapita', label: 'PIB per Capita', sortable: true },
    { key: 'employmentRate', label: 'Taxa de Emprego', sortable: true },
    { key: 'revenue', label: 'Arrecadação (R$ mi)', sortable: true },
  ];

  const data = economicData.map(indicator => ({
    year: indicator.year.toString(),
    gdp: formatNumber(indicator.gdp, 1),
    gdpPerCapita: formatCurrency(indicator.gdpPerCapita, 0),
    employmentRate: formatPercent(indicator.employmentRate, 1),
    revenue: formatNumber(indicator.revenue, 0),
  }));

  return (
    <div className="p-6 space-y-6">
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <KPICard
          title="PIB Total"
          value={`R$ ${formatNumber(latest.gdp, 1)} bi`}
          subtitle={`Produto Interno Bruto ${latest.year}`}
          trend={gdpTrend}
          icon={DollarSign}
          status={gdpTrend.direction === "up" ? "success" : gdpTrend.direction === "down" ? "danger" : undefined}
        />
        <KPICard
          title="PIB per Capita"
          value={formatCurrency(latest.gdpPerCapita, 0)}
          subtitle="Renda média por habitante"
          trend={gdpPerCapitaTrend}
          icon={TrendingUp}
          status={gdpPerCapitaTrend.direction === "up" ? "success" : undefined}
        />
        <KPICard
          title="Taxa de Emprego"
          value={formatPercent(latest.employmentRate, 1)}
          subtitle="População economicamente ativa"
          trend={employmentTrend}
          icon={Briefcase}
          status={employmentTrend.direction === "down" ? "warning" : "success"}
        />
        <KPICard
          title="Arrecadação"
          value={`R$ ${formatNumber(latest.revenue, 0)} mi`}
          subtitle="Receitas consolidadas"
          trend={revenueTrend}
          icon={Building2}
          status={revenueTrend.direction === "up" ? "success" : undefined}
        />
        
        {/* Novos Indicadores (Modelo Conceitual v4.0) */}
        <KPICard
          title="Massa Salarial"
          value={totalWageMass ? `R$ ${formatNumber(totalWageMass / 1000000, 1)} mi` : "Não disponível"}
          subtitle="Remuneração total dos trabalhadores"
          trend={totalWageMass && previous?.totalWageMass ? wageMassTrend : undefined}
          icon={Users}
          status={totalWageMass && wageMassTrend.direction === "up" ? "success" : undefined}
        />
        <KPICard
          title="Empresas Ativas"
          value={activeCompaniesCount !== null ? formatNumber(activeCompaniesCount, 0) : "Não disponível"}
          subtitle="Número de empresas em operação"
          trend={activeCompaniesCount !== null && previous?.activeCompaniesCount ? companiesTrend : undefined}
          icon={Factory}
          status={activeCompaniesCount !== null && companiesTrend.direction === "up" ? "success" : undefined}
        />
        <KPICard
          title="Receita Tributária"
          value={municipalTaxRevenue ? `R$ ${formatNumber(municipalTaxRevenue / 1000000, 1)} mi` : "Não disponível"}
          subtitle="Arrecadação própria do município"
          trend={municipalTaxRevenue && previous?.municipalTaxRevenue ? taxRevenueTrend : undefined}
          icon={Landmark}
          status={municipalTaxRevenue && taxRevenueTrend.direction === "up" ? "success" : undefined}
        />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <IndicatorLineChart
          data={economicData.slice().reverse()}
          selectedIndicator={selectedLineIndicator}
          onIndicatorChange={setSelectedLineIndicator}
          metadata={metadata}
          title="Evolução Temporal"
        />

        <IndicatorComparisonChart
          data={economicData.slice().reverse()}
          selectedIndicator1={selectedBarIndicator1}
          selectedIndicator2={selectedBarIndicator2}
          onIndicator1Change={setSelectedBarIndicator1}
          onIndicator2Change={setSelectedBarIndicator2}
          metadata={metadata}
          title="Comparação de Indicadores"
        />
      </div>

      <AIAnalysisBox
        title="Análise Econômica por IA"
        content="O estado do Tocantins apresenta crescimento econômico robusto de 5,2% no último ano, superando a média nacional de 2,9%. O PIB per capita de R$ 28.134 posiciona o estado acima da média da região Norte (R$ 24.567). A economia é impulsionada principalmente pelos setores de agropecuária (28%), serviços (52%) e indústria (20%). Principais oportunidades: expansão do agronegócio sustentável com foco em soja e pecuária, desenvolvimento de infraestrutura logística (rodovias e ferrovias), e atração de investimentos em energias renováveis, especialmente solar e biomassa. Pontos de atenção: a taxa de emprego formal caiu 2,1%, indicando necessidade de diversificação econômica e programas de qualificação profissional. Recomenda-se investimentos em cadeias produtivas de alto valor agregado e fortalecimento do empreendedorismo local."
      />

      <div>
        <h3 className="text-lg font-semibold mb-4">Dados Históricos Detalhados</h3>
        <DataTable columns={columns} data={data} onExport={() => console.log('Export CSV')} />
      </div>
    </div>
  );
}
