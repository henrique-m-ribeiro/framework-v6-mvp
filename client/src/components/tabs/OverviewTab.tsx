import { useQuery } from "@tanstack/react-query";
import KPICard from "../shared/KPICard";
import AIAnalysisBox from "../shared/AIAnalysisBox";
import { DollarSign, Users, MapPin, Leaf } from "lucide-react";
import type { EconomicIndicator, SocialIndicator, TerritorialIndicator, EnvironmentalIndicator } from "@shared/schema";

interface OverviewTabProps {
  territoryId: string;
}

export default function OverviewTab({ territoryId }: OverviewTabProps) {
  const { data: economicData = [] } = useQuery<EconomicIndicator[]>({
    queryKey: ["/api/territories", territoryId, "indicators", "economic"],
    enabled: !!territoryId,
  });

  const { data: socialData = [] } = useQuery<SocialIndicator[]>({
    queryKey: ["/api/territories", territoryId, "indicators", "social"],
    enabled: !!territoryId,
  });

  const { data: territorialData = [] } = useQuery<TerritorialIndicator[]>({
    queryKey: ["/api/territories", territoryId, "indicators", "territorial"],
    enabled: !!territoryId,
  });

  const { data: environmentalData = [] } = useQuery<EnvironmentalIndicator[]>({
    queryKey: ["/api/territories", territoryId, "indicators", "environmental"],
    enabled: !!territoryId,
  });

  const latestEconomic = economicData[0];
  const latestSocial = socialData[0];
  const latestTerritorial = territorialData[0];
  const latestEnvironmental = environmentalData[0];

  const calculateTrend = (current: number, previous: number) => {
    if (!previous) return { value: 0, direction: "neutral" as const };
    const change = ((current - previous) / previous) * 100;
    return {
      value: Number(change.toFixed(1)),
      direction: change > 0 ? "up" as const : change < 0 ? "down" as const : "neutral" as const,
    };
  };

  if (!latestEconomic || !latestSocial || !latestTerritorial || !latestEnvironmental) {
    return <div className="p-6">Carregando dados...</div>;
  }

  const economicTrend = economicData.length > 1 
    ? calculateTrend(latestEconomic.gdp || 0, economicData[1].gdp || 0)
    : { value: 0, direction: "neutral" as const };

  const gdpPerCapitaTrend = economicData.length > 1
    ? calculateTrend(latestEconomic.gdpPerCapita || 0, economicData[1].gdpPerCapita || 0)
    : { value: 0, direction: "neutral" as const };

  const socialTrend = socialData.length > 1
    ? calculateTrend(latestSocial.idhm || 0, socialData[1].idhm || 0)
    : { value: 0, direction: "neutral" as const };

  const populationTrend = socialData.length > 1
    ? calculateTrend(latestSocial.population || 0, socialData[1].population || 0)
    : { value: 0, direction: "neutral" as const };

  const environmentalTrend = environmentalData.length > 1
    ? calculateTrend(latestEnvironmental.vegetationCoverage || 0, environmentalData[1].vegetationCoverage || 0)
    : { value: 0, direction: "neutral" as const };

  return (
    <div className="p-6 space-y-6">
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div className="space-y-4">
          <h2 className="text-2xl font-semibold text-secondary flex items-center gap-2">
            <DollarSign className="w-6 h-6" />
            Dimensão Econômica
          </h2>
          <div className="grid grid-cols-2 gap-4">
            <KPICard
              title="PIB Total"
              value={`R$ ${latestEconomic.gdp?.toFixed(1)} bi`}
              trend={economicTrend}
              icon={DollarSign}
              status="success"
            />
            <KPICard
              title="PIB per Capita"
              value={`R$ ${latestEconomic.gdpPerCapita?.toLocaleString('pt-BR')}`}
              trend={gdpPerCapitaTrend}
              icon={DollarSign}
              status={gdpPerCapitaTrend.direction === "up" ? "success" : undefined}
            />
          </div>
        </div>

        <div className="space-y-4">
          <h2 className="text-2xl font-semibold text-secondary flex items-center gap-2">
            <Users className="w-6 h-6" />
            Dimensão Social
          </h2>
          <div className="grid grid-cols-2 gap-4">
            <KPICard
              title="IDH-M"
              value={latestSocial.idhm?.toFixed(3) || "0"}
              trend={socialTrend}
              icon={Users}
              status="success"
            />
            <KPICard
              title="População"
              value={latestSocial.population?.toLocaleString('pt-BR') || "0"}
              trend={populationTrend}
              icon={Users}
            />
          </div>
        </div>

        <div className="space-y-4">
          <h2 className="text-2xl font-semibold text-secondary flex items-center gap-2">
            <MapPin className="w-6 h-6" />
            Dimensão Territorial
          </h2>
          <div className="grid grid-cols-2 gap-4">
            <KPICard
              title="Densidade"
              value={`${latestTerritorial.density?.toFixed(1)} hab/km²`}
              icon={MapPin}
            />
            <KPICard
              title="Saneamento"
              value={`${latestTerritorial.sanitationCoverage?.toFixed(1)}%`}
              icon={MapPin}
            />
          </div>
        </div>

        <div className="space-y-4">
          <h2 className="text-2xl font-semibold text-secondary flex items-center gap-2">
            <Leaf className="w-6 h-6" />
            Dimensão Ambiental
          </h2>
          <div className="grid grid-cols-2 gap-4">
            <KPICard
              title="Cobertura Vegetal"
              value={`${latestEnvironmental.vegetationCoverage?.toFixed(1)}%`}
              trend={environmentalTrend}
              icon={Leaf}
              status={latestEnvironmental.vegetationCoverage && latestEnvironmental.vegetationCoverage > 85 ? "success" : "warning"}
            />
            <KPICard
              title="Qualidade Água"
              value={`${latestEnvironmental.waterQuality?.toFixed(0)} IQA`}
              icon={Leaf}
              status={latestEnvironmental.waterQuality && latestEnvironmental.waterQuality > 70 ? "success" : "warning"}
            />
          </div>
        </div>
      </div>

      <AIAnalysisBox
        title="Síntese das Quatro Dimensões por IA"
        content="O estado do Tocantins apresenta um cenário de desenvolvimento equilibrado nas quatro dimensões analisadas. Na dimensão econômica, destaca-se o crescimento do PIB de 5,2%, impulsionado pelo agronegócio e serviços. Socialmente, o IDH-M de 0,743 indica progresso, mas ainda há desafios em educação e saúde. A dimensão territorial mostra baixa densidade demográfica, com oportunidades para expansão urbana planejada. Ambientalmente, a cobertura vegetal de 87,3% é positiva, mas requer monitoramento contínuo do desmatamento. Recomenda-se investimentos em infraestrutura, educação e programas de desenvolvimento sustentável para acelerar o crescimento regional."
      />
    </div>
  );
}
