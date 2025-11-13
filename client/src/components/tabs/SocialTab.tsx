import KPICard from "../shared/KPICard";
import AIAnalysisBox from "../shared/AIAnalysisBox";
import DataTable from "../shared/DataTable";
import { Card } from "@/components/ui/card";
import { Users, GraduationCap, Heart, DollarSign } from "lucide-react";

export default function SocialTab() {
  //todo: remove mock functionality
  const columns = [
    { key: 'year', label: 'Ano', sortable: true },
    { key: 'idhm', label: 'IDH-M', sortable: true },
    { key: 'population', label: 'População', sortable: true },
    { key: 'literacy', label: 'Alfabetização', sortable: true },
    { key: 'income', label: 'Renda per Capita', sortable: true },
  ];

  const data = [
    { year: '2023', idhm: '0,743', population: '1.607.363', literacy: '89,2%', income: 'R$ 1.245' },
    { year: '2022', idhm: '0,735', population: '1.590.248', literacy: '88,5%', income: 'R$ 1.198' },
    { year: '2021', idhm: '0,728', population: '1.572.866', literacy: '87,8%', income: 'R$ 1.156' },
    { year: '2020', idhm: '0,720', population: '1.555.229', literacy: '87,1%', income: 'R$ 1.112' },
    { year: '2019', idhm: '0,715', population: '1.537.591', literacy: '86,4%', income: 'R$ 1.089' },
  ];

  return (
    <div className="p-6 space-y-6">
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <KPICard
          title="IDH-M"
          value="0,743"
          subtitle="Índice de Desenvolvimento Humano"
          trend={{ value: 3.5, direction: "up" }}
          icon={Heart}
          status="success"
        />
        <KPICard
          title="População Total"
          value="1.607.363"
          subtitle="Habitantes (IBGE 2023)"
          trend={{ value: 1.8, direction: "up" }}
          icon={Users}
        />
        <KPICard
          title="Taxa de Alfabetização"
          value="89,2%"
          subtitle="População alfabetizada"
          trend={{ value: 0.8, direction: "up" }}
          icon={GraduationCap}
          status="success"
        />
        <KPICard
          title="Renda per Capita"
          value="R$ 1.245"
          subtitle="Renda média mensal"
          trend={{ value: 3.9, direction: "up" }}
          icon={DollarSign}
          status="success"
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
