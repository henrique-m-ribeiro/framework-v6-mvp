import KPICard from "../shared/KPICard";
import AIAnalysisBox from "../shared/AIAnalysisBox";
import DataTable from "../shared/DataTable";
import { Card } from "@/components/ui/card";
import { DollarSign, TrendingUp, Briefcase, Building2 } from "lucide-react";

export default function EconomicTab() {
  //todo: remove mock functionality
  const columns = [
    { key: 'year', label: 'Ano', sortable: true },
    { key: 'pib', label: 'PIB (R$ bi)', sortable: true },
    { key: 'pibPerCapita', label: 'PIB per Capita', sortable: true },
    { key: 'employment', label: 'Taxa de Emprego', sortable: true },
    { key: 'revenue', label: 'Arrecadação (R$ mi)', sortable: true },
  ];

  const data = [
    { year: '2023', pib: '45,2', pibPerCapita: 'R$ 28.134', employment: '65,4%', revenue: '3.245' },
    { year: '2022', pib: '42,9', pibPerCapita: 'R$ 26.978', employment: '66,8%', revenue: '3.102' },
    { year: '2021', pib: '40,1', pibPerCapita: 'R$ 25.489', employment: '64,2%', revenue: '2.897' },
    { year: '2020', pib: '38,5', pibPerCapita: 'R$ 24.756', employment: '62,1%', revenue: '2.756' },
    { year: '2019', pib: '41,2', pibPerCapita: 'R$ 26.789', employment: '67,5%', revenue: '2.934' },
  ];

  return (
    <div className="p-6 space-y-6">
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <KPICard
          title="PIB Total"
          value="R$ 45,2 bi"
          subtitle="Produto Interno Bruto 2023"
          trend={{ value: 5.2, direction: "up" }}
          icon={DollarSign}
          status="success"
        />
        <KPICard
          title="PIB per Capita"
          value="R$ 28.134"
          subtitle="Renda média por habitante"
          trend={{ value: 4.1, direction: "up" }}
          icon={TrendingUp}
          status="success"
        />
        <KPICard
          title="Taxa de Emprego"
          value="65,4%"
          subtitle="População economicamente ativa"
          trend={{ value: -2.1, direction: "down" }}
          icon={Briefcase}
          status="warning"
        />
        <KPICard
          title="Arrecadação Municipal"
          value="R$ 3,2 bi"
          subtitle="Receitas municipais consolidadas"
          trend={{ value: 4.6, direction: "up" }}
          icon={Building2}
          status="success"
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
