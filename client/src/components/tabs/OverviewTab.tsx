import KPICard from "../shared/KPICard";
import AIAnalysisBox from "../shared/AIAnalysisBox";
import { DollarSign, Users, MapPin, Leaf } from "lucide-react";

export default function OverviewTab() {
  //todo: remove mock functionality
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
              value="R$ 45,2 bi"
              trend={{ value: 5.2, direction: "up" }}
              icon={DollarSign}
              status="success"
            />
            <KPICard
              title="PIB per Capita"
              value="R$ 28.134"
              trend={{ value: 4.1, direction: "up" }}
              icon={DollarSign}
              status="success"
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
              value="0,743"
              trend={{ value: 3.5, direction: "up" }}
              icon={Users}
              status="success"
            />
            <KPICard
              title="População"
              value="1.607.363"
              trend={{ value: 1.8, direction: "up" }}
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
              title="Área Total"
              value="277.423 km²"
              icon={MapPin}
            />
            <KPICard
              title="Densidade"
              value="5,8 hab/km²"
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
              value="87,3%"
              trend={{ value: -1.2, direction: "down" }}
              icon={Leaf}
              status="warning"
            />
            <KPICard
              title="Área Desmatada"
              value="12,7%"
              trend={{ value: 1.2, direction: "up" }}
              icon={Leaf}
              status="warning"
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
