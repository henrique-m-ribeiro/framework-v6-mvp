import { useQuery } from "@tanstack/react-query";
import KPICard from "../shared/KPICard";
import AIAnalysisBox from "../shared/AIAnalysisBox";
import DataTable from "../shared/DataTable";
import { Card } from "@/components/ui/card";
import { Users, GraduationCap, Heart, DollarSign } from "lucide-react";
import type { SocialIndicator } from "@shared/schema";
import { formatNumber, formatCurrency, formatPercent } from "@/lib/formatters";

interface SocialTabProps {
  territoryId: string;
}

export default function SocialTab({ territoryId }: SocialTabProps) {
  const { data: socialData = [] } = useQuery<SocialIndicator[]>({
    queryKey: ["/api/territories", territoryId, "indicators", "social"],
    enabled: !!territoryId,
  });

  if (socialData.length === 0) {
    return <div className="p-6">Carregando dados sociais...</div>;
  }

  const latest = socialData[0];
  const previous = socialData[1];

  const calculateTrend = (current: number | null | undefined, prev: number | null | undefined) => {
    if (!current || !prev) return { value: 0, direction: "neutral" as const };
    const change = ((current - prev) / prev) * 100;
    return {
      value: Number(change.toFixed(1)),
      direction: change > 0 ? "up" as const : change < 0 ? "down" as const : "neutral" as const,
    };
  };

  const idhmTrend = previous ? calculateTrend(latest.idhm, previous.idhm) : { value: 0, direction: "neutral" as const };
  const populationTrend = previous ? calculateTrend(latest.population, previous.population) : { value: 0, direction: "neutral" as const };
  const literacyTrend = previous ? calculateTrend(latest.literacyRate, previous.literacyRate) : { value: 0, direction: "neutral" as const };
  const incomeTrend = previous ? calculateTrend(latest.incomePerCapita, previous.incomePerCapita) : { value: 0, direction: "neutral" as const };

  const columns = [
    { key: 'year', label: 'Ano', sortable: true },
    { key: 'idhm', label: 'IDH-M', sortable: true },
    { key: 'population', label: 'População', sortable: true },
    { key: 'literacy', label: 'Alfabetização', sortable: true },
    { key: 'income', label: 'Renda per Capita', sortable: true },
  ];

  const data = socialData.map(indicator => ({
    year: indicator.year.toString(),
    idhm: formatNumber(indicator.idhm, 3),
    population: formatNumber(indicator.population, 0),
    literacy: formatPercent(indicator.literacyRate, 1),
    income: formatCurrency(indicator.incomePerCapita, 0),
  }));

  return (
    <div className="p-6 space-y-6">
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <KPICard
          title="IDH-M"
          value={formatNumber(latest.idhm, 3)}
          subtitle="Índice de Desenvolvimento Humano"
          trend={idhmTrend}
          icon={Heart}
          status={idhmTrend.direction === "up" ? "success" : undefined}
        />
        <KPICard
          title="População Total"
          value={formatNumber(latest.population, 0)}
          subtitle={`Habitantes (${latest.year})`}
          trend={populationTrend}
          icon={Users}
        />
        <KPICard
          title="Taxa de Alfabetização"
          value={formatPercent(latest.literacyRate, 1)}
          subtitle="População alfabetizada"
          trend={literacyTrend}
          icon={GraduationCap}
          status={literacyTrend.direction === "up" ? "success" : undefined}
        />
        <KPICard
          title="Renda per Capita"
          value={formatCurrency(latest.incomePerCapita, 0)}
          subtitle="Renda média mensal"
          trend={incomeTrend}
          icon={DollarSign}
          status={incomeTrend.direction === "up" ? "success" : undefined}
        />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <Card className="p-6">
          <h3 className="text-lg font-semibold mb-4">Componentes do IDH-M</h3>
          <div className="h-64 flex items-center justify-center bg-muted/30 rounded-md">
            <p className="text-sm text-muted-foreground">Gráfico Radar - Chart.js</p>
          </div>
        </Card>

        <Card className="p-6">
          <h3 className="text-lg font-semibold mb-4">Indicadores Educacionais</h3>
          <div className="h-64 flex items-center justify-center bg-muted/30 rounded-md">
            <p className="text-sm text-muted-foreground">Gráfico de Barras Horizontais - Chart.js</p>
          </div>
        </Card>
      </div>

      <AIAnalysisBox
        title="Análise de Desenvolvimento Humano por IA"
        content="O Tocantins apresenta IDH-M de 0,743, classificado como alto desenvolvimento humano e posicionando-se acima da média da região Norte (0,667). A evolução positiva de 3,5% demonstra avanços consistentes nas três dimensões: longevidade (0,798), educação (0,712) e renda (0,719). A taxa de alfabetização de 89,2% supera a média regional, mas ainda há desafios significativos. Principais conquistas: expansão da rede de ensino médio (+12% de matrículas em 5 anos), melhoria nos indicadores de saúde materno-infantil, e programas de transferência de renda que beneficiam 28% da população. Pontos críticos: disparidades educacionais entre zona urbana e rural, necessidade de melhorar a qualidade do ensino (IDEB médio de 4,8), e desigualdade de renda (Gini de 0,52). Recomendações: investir em infraestrutura educacional, programas de capacitação profissional, e fortalecimento da atenção básica de saúde."
      />

      <div>
        <h3 className="text-lg font-semibold mb-4">Dados Demográficos e Sociais</h3>
        <DataTable columns={columns} data={data} onExport={() => console.log('Export CSV')} />
      </div>
    </div>
  );
}
