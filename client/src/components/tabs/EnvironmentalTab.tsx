import { useQuery } from "@tanstack/react-query";
import KPICard from "../shared/KPICard";
import AIAnalysisBox from "../shared/AIAnalysisBox";
import DataTable from "../shared/DataTable";
import { Card } from "@/components/ui/card";
import { Leaf, TreeDeciduous, Droplets, Cloud } from "lucide-react";
import type { EnvironmentalIndicator } from "@shared/schema";

interface EnvironmentalTabProps {
  territoryId: string;
}

export default function EnvironmentalTab({ territoryId }: EnvironmentalTabProps) {
  const { data: environmentalData = [] } = useQuery<EnvironmentalIndicator[]>({
    queryKey: ["/api/territories", territoryId, "indicators", "environmental"],
    enabled: !!territoryId,
  });

  if (environmentalData.length === 0) {
    return <div className="p-6">Carregando dados ambientais...</div>;
  }

  const latest = environmentalData[0];
  const columns = [
    { key: 'year', label: 'Ano', sortable: true },
    { key: 'vegetation', label: 'Cobertura Vegetal (%)', sortable: true },
    { key: 'deforested', label: 'Área Desmatada (km²)', sortable: true },
    { key: 'waterQuality', label: 'IQA Médio', sortable: true },
    { key: 'emissions', label: 'Emissões CO₂ (ton)', sortable: true },
  ];

  const data = [
    { year: '2023', vegetation: '87,3', deforested: '35.212', waterQuality: '68', emissions: '12.450.000' },
    { year: '2022', vegetation: '88,1', deforested: '32.987', waterQuality: '71', emissions: '11.890.000' },
    { year: '2021', vegetation: '89,2', deforested: '29.954', waterQuality: '73', emissions: '11.234.000' },
    { year: '2020', vegetation: '90,1', deforested: '27.456', waterQuality: '75', emissions: '10.876.000' },
    { year: '2019', vegetation: '91,3', deforested: '24.102', waterQuality: '76', emissions: '10.345.000' },
  ];

  return (
    <div className="p-6 space-y-6">
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <KPICard
          title="Cobertura Vegetal"
          value="87,3%"
          subtitle="Do território preservado"
          trend={{ value: -1.2, direction: "down" }}
          icon={Leaf}
          status="warning"
        />
        <KPICard
          title="Área Desmatada"
          value="35.212 km²"
          subtitle="Desmatamento acumulado"
          trend={{ value: 6.7, direction: "up" }}
          icon={TreeDeciduous}
          status="danger"
        />
        <KPICard
          title="Qualidade da Água"
          value="68 IQA"
          subtitle="Índice de Qualidade da Água"
          trend={{ value: -4.2, direction: "down" }}
          icon={Droplets}
          status="warning"
        />
        <KPICard
          title="Emissões CO₂"
          value="12,45 M ton"
          subtitle="Emissões anuais de carbono"
          trend={{ value: 4.7, direction: "up" }}
          icon={Cloud}
          status="danger"
        />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <Card className="p-6">
          <h3 className="text-lg font-semibold mb-4">Evolução da Cobertura Vegetal</h3>
          <div className="h-64 flex items-center justify-center bg-muted/30 rounded-md">
            <p className="text-sm text-muted-foreground">Gráfico de Área Empilhada - Chart.js</p>
          </div>
        </Card>

        <Card className="p-6">
          <h3 className="text-lg font-semibold mb-4">Qualidade da Água (IQA)</h3>
          <div className="h-64 flex items-center justify-center bg-muted/30 rounded-md">
            <p className="text-sm text-muted-foreground">Gráfico de Linha com Referência - Chart.js</p>
          </div>
        </Card>
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
