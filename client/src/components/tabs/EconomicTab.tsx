import { useQuery } from "@tanstack/react-query";
import KPICard from "../shared/KPICard";
import AIAnalysisBox from "../shared/AIAnalysisBox";
import DataTable from "../shared/DataTable";
import { Card } from "@/components/ui/card";
import { DollarSign, TrendingUp, Briefcase, Building2 } from "lucide-react";
import type { EconomicIndicator } from "@shared/schema";

interface EconomicTabProps {
  territoryId: string;
}

export default function EconomicTab({ territoryId }: EconomicTabProps) {
  const { data: economicData = [] } = useQuery<EconomicIndicator[]>({
    queryKey: ["/api/territories", territoryId, "indicators", "economic"],
    enabled: !!territoryId,
  });

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
  const columns = [
    { key: 'year', label: 'Ano', sortable: true },
    { key: 'gdp', label: 'PIB (R$ bi)', sortable: true },
    { key: 'gdpPerCapita', label: 'PIB per Capita', sortable: true },
    { key: 'employmentRate', label: 'Taxa de Emprego', sortable: true },
    { key: 'revenue', label: 'Arrecadação (R$ mi)', sortable: true },
  ];

  const data = economicData.map(indicator => ({
    year: indicator.year.toString(),
    gdp: indicator.gdp?.toFixed(1) || '-',
    gdpPerCapita: `R$ ${indicator.gdpPerCapita?.toLocaleString('pt-BR')}` || '-',
    employmentRate: `${indicator.employmentRate?.toFixed(1)}%` || '-',
    revenue: indicator.revenue?.toFixed(0) || '-',
  }));

  return (
    <div className="p-6 space-y-6">
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <KPICard
          title="PIB Total"
          value={`R$ ${latest.gdp?.toFixed(1)} bi`}
          subtitle={`Produto Interno Bruto ${latest.year}`}
          trend={gdpTrend}
          icon={DollarSign}
          status={gdpTrend.direction === "up" ? "success" : gdpTrend.direction === "down" ? "danger" : undefined}
        />
        <KPICard
          title="PIB per Capita"
          value={`R$ ${latest.gdpPerCapita?.toLocaleString('pt-BR')}`}
          subtitle="Renda média por habitante"
          trend={gdpPerCapitaTrend}
          icon={TrendingUp}
          status={gdpPerCapitaTrend.direction === "up" ? "success" : undefined}
        />
        <KPICard
          title="Taxa de Emprego"
          value={`${latest.employmentRate?.toFixed(1)}%`}
          subtitle="População economicamente ativa"
          trend={employmentTrend}
          icon={Briefcase}
          status={employmentTrend.direction === "down" ? "warning" : "success"}
        />
        <KPICard
          title="Arrecadação"
          value={`R$ ${latest.revenue?.toFixed(0)} mi`}
          subtitle="Receitas consolidadas"
          trend={revenueTrend}
          icon={Building2}
          status={revenueTrend.direction === "up" ? "success" : undefined}
        />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <Card className="p-6">
          <h3 className="text-lg font-semibold mb-4">Evolução do PIB (Últimos 5 Anos)</h3>
          <div className="h-64 flex items-center justify-center bg-muted/30 rounded-md">
            <p className="text-sm text-muted-foreground">Gráfico de Linha - Chart.js</p>
          </div>
        </Card>

        <Card className="p-6">
          <h3 className="text-lg font-semibold mb-4">Composição Setorial do PIB</h3>
          <div className="h-64 flex items-center justify-center bg-muted/30 rounded-md">
            <p className="text-sm text-muted-foreground">Gráfico de Barras - Chart.js</p>
          </div>
        </Card>
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
