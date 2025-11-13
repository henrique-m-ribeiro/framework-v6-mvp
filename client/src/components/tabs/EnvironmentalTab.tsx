import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import KPICard from "../shared/KPICard";
import AIAnalysisBox from "../shared/AIAnalysisBox";
import DataTable from "../shared/DataTable";
import { Leaf, TreeDeciduous, Droplets, Cloud } from "lucide-react";
import type { EnvironmentalIndicator } from "@shared/schema";
import { formatNumber, formatPercent } from "@/lib/formatters";
import { useIndicatorMetadata } from "@/hooks/useIndicatorMetadata";
import { IndicatorLineChart } from "@/components/charts/IndicatorLineChart";
import { IndicatorComparisonChart } from "@/components/charts/IndicatorComparisonChart";

interface EnvironmentalTabProps {
  territoryId: string;
}

export default function EnvironmentalTab({ territoryId }: EnvironmentalTabProps) {
  const [selectedLineIndicator, setSelectedLineIndicator] = useState("vegetationCoverage");
  const [selectedBarIndicator1, setSelectedBarIndicator1] = useState("waterQuality");
  const [selectedBarIndicator2, setSelectedBarIndicator2] = useState("deforestedArea");

  const { data: environmentalData = [] } = useQuery<EnvironmentalIndicator[]>({
    queryKey: ["/api/territories", territoryId, "indicators", "environmental"],
    enabled: !!territoryId,
  });

  const { data: metadata = [] } = useIndicatorMetadata("environmental");

  if (environmentalData.length === 0) {
    return <div className="p-6">Carregando dados ambientais...</div>;
  }

  const latest = environmentalData[0];
  const previous = environmentalData[1];

  const calculateTrend = (current: number | null | undefined, prev: number | null | undefined) => {
    if (!current || !prev) return { value: 0, direction: "neutral" as const };
    const change = ((current - prev) / prev) * 100;
    return {
      value: Number(change.toFixed(1)),
      direction: change > 0 ? "up" as const : change < 0 ? "down" as const : "neutral" as const,
    };
  };

  const vegetationTrend = previous ? calculateTrend(latest.vegetationCoverage, previous.vegetationCoverage) : { value: 0, direction: "neutral" as const };
  const deforestedTrend = previous ? calculateTrend(latest.deforestedArea, previous.deforestedArea) : { value: 0, direction: "neutral" as const };
  const waterQualityTrend = previous ? calculateTrend(latest.waterQuality, previous.waterQuality) : { value: 0, direction: "neutral" as const };
  const emissionsTrend = previous ? calculateTrend(latest.co2Emissions, previous.co2Emissions) : { value: 0, direction: "neutral" as const };

  const columns = [
    { key: 'year', label: 'Ano', sortable: true },
    { key: 'vegetation', label: 'Cobertura Vegetal (%)', sortable: true },
    { key: 'deforested', label: 'Área Desmatada (km²)', sortable: true },
    { key: 'waterQuality', label: 'IQA Médio', sortable: true },
    { key: 'emissions', label: 'Emissões CO₂ (ton)', sortable: true },
  ];

  const data = environmentalData.map(indicator => ({
    year: indicator.year.toString(),
    vegetation: formatPercent(indicator.vegetationCoverage, 1),
    deforested: formatNumber(indicator.deforestedArea, 0),
    waterQuality: formatNumber(indicator.waterQuality, 0),
    emissions: formatNumber(indicator.co2Emissions, 0),
  }));

  return (
    <div className="p-6 space-y-6">
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <KPICard
          title="Cobertura Vegetal"
          value={formatPercent(latest.vegetationCoverage, 1)}
          subtitle="Do território preservado"
          trend={vegetationTrend}
          icon={Leaf}
          status={vegetationTrend.direction === "down" ? "warning" : "success"}
        />
        <KPICard
          title="Área Desmatada"
          value={`${formatNumber(latest.deforestedArea, 0)} km²`}
          subtitle="Desmatamento acumulado"
          trend={deforestedTrend}
          icon={TreeDeciduous}
          status={deforestedTrend.direction === "up" ? "danger" : "success"}
        />
        <KPICard
          title="Qualidade da Água"
          value={`${formatNumber(latest.waterQuality, 0)} IQA`}
          subtitle="Índice de Qualidade da Água"
          trend={waterQualityTrend}
          icon={Droplets}
          status={waterQualityTrend.direction === "down" ? "warning" : "success"}
        />
        <KPICard
          title="Emissões CO₂"
          value={`${formatNumber(latest.co2Emissions ? latest.co2Emissions / 1000000 : 0, 2)} M ton`}
          subtitle="Emissões anuais de carbono"
          trend={emissionsTrend}
          icon={Cloud}
          status={emissionsTrend.direction === "up" ? "danger" : "success"}
        />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <IndicatorLineChart
          data={environmentalData.slice().reverse()}
          selectedIndicator={selectedLineIndicator}
          onIndicatorChange={setSelectedLineIndicator}
          metadata={metadata}
          title="Evolução Temporal"
        />

        <IndicatorComparisonChart
          data={environmentalData.slice().reverse()}
          selectedIndicator1={selectedBarIndicator1}
          selectedIndicator2={selectedBarIndicator2}
          onIndicator1Change={setSelectedBarIndicator1}
          onIndicator2Change={setSelectedBarIndicator2}
          metadata={metadata}
          title="Comparação de Indicadores"
        />
      </div>

      <AIAnalysisBox
        title="Análise de Riscos Ambientais por IA"
        content="O Tocantins enfrenta crescentes desafios ambientais que requerem atenção imediata. A cobertura vegetal caiu de 91,3% para 87,3% nos últimos 5 anos, com taxa média de desmatamento de 2.200 km²/ano, principalmente devido à expansão agropecuária. Alertas críticos: o desmatamento acelerou 6,7% no último ano, concentrado nas regiões de fronteira agrícola. A qualidade da água deteriorou para IQA 68 (classificação 'Boa', próxima a 'Regular'), afetada por agrotóxicos e efluentes urbanos sem tratamento. As emissões de CO₂ aumentaram 20% em 5 anos, relacionadas a queimadas e mudança no uso do solo. Oportunidades: o estado possui 87,3% de cobertura vegetal preservada, oferecendo potencial para créditos de carbono e agricultura sustentável. Ações prioritárias: implementar monitoramento por satélite em tempo real, fortalecer fiscalização ambiental, incentivar recuperação de áreas degradadas, e promover agricultura de baixo carbono."
      />

      <div>
        <h3 className="text-lg font-semibold mb-4">Histórico de Dados Ambientais</h3>
        <DataTable columns={columns} data={data} onExport={() => console.log('Export CSV')} />
      </div>
    </div>
  );
}
