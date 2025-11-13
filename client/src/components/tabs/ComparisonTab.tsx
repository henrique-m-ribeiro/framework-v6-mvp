import { useState } from "react";
import { Card } from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { Checkbox } from "@/components/ui/checkbox";
import AIAnalysisBox from "../shared/AIAnalysisBox";
import DataTable from "../shared/DataTable";

export default function ComparisonTab() {
  //todo: remove mock functionality
  const [selectedTerritories, setSelectedTerritories] = useState<string[]>(['tocantins']);

  const territories = [
    { id: 'tocantins', name: 'Tocantins (Estado)' },
    { id: 'palmas', name: 'Palmas' },
    { id: 'araguaina', name: 'Araguaína' },
    { id: 'gurupi', name: 'Gurupi' },
    { id: 'porto-nacional', name: 'Porto Nacional' },
  ];

  const toggleTerritory = (id: string) => {
    if (selectedTerritories.includes(id)) {
      setSelectedTerritories(selectedTerritories.filter(t => t !== id));
    } else if (selectedTerritories.length < 5) {
      setSelectedTerritories([...selectedTerritories, id]);
    }
  };

  const comparisonData = [
    { indicator: 'PIB (R$ bi)', tocantins: '45,2', palmas: '12,8', araguaina: '4,2', gurupi: '2,1', 'porto-nacional': '1,5' },
    { indicator: 'IDH-M', tocantins: '0,743', palmas: '0,788', araguaina: '0,752', gurupi: '0,759', 'porto-nacional': '0,740' },
    { indicator: 'População', tocantins: '1.607.363', palmas: '306.296', araguaina: '180.470', gurupi: '87.545', 'porto-nacional': '53.010' },
    { indicator: 'Taxa Alfabetização', tocantins: '89,2%', palmas: '94,1%', araguaina: '91,3%', gurupi: '90,8%', 'porto-nacional': '88,5%' },
  ];

  const columns = [
    { key: 'indicator', label: 'Indicador', sortable: false },
    ...selectedTerritories.map(id => ({
      key: id,
      label: territories.find(t => t.id === id)?.name || id,
      sortable: false
    }))
  ];

  const filteredData = comparisonData.map(row => {
    const filtered: Record<string, any> = { indicator: row.indicator };
    selectedTerritories.forEach(id => {
      if (id in row) {
        filtered[id] = row[id as keyof typeof row];
      }
    });
    return filtered;
  });

  return (
    <div className="p-6 space-y-6">
      <Card className="p-6">
        <Label className="text-lg font-semibold mb-4 block">Selecionar Territórios para Comparação (até 5)</Label>
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4">
          {territories.map((territory) => (
            <div key={territory.id} className="flex items-center space-x-2">
              <Checkbox
                id={territory.id}
                checked={selectedTerritories.includes(territory.id)}
                onCheckedChange={() => toggleTerritory(territory.id)}
                disabled={!selectedTerritories.includes(territory.id) && selectedTerritories.length >= 5}
                data-testid={`checkbox-territory-${territory.id}`}
              />
              <Label
                htmlFor={territory.id}
                className="text-sm font-normal cursor-pointer"
              >
                {territory.name}
              </Label>
            </div>
          ))}
        </div>
      </Card>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <Card className="p-6">
          <h3 className="text-lg font-semibold mb-4">Comparação de Indicadores</h3>
          <div className="h-64 flex items-center justify-center bg-muted/30 rounded-md">
            <p className="text-sm text-muted-foreground">Gráfico de Barras Agrupadas - Chart.js</p>
          </div>
        </Card>

        <Card className="p-6">
          <h3 className="text-lg font-semibold mb-4">Perfil Multidimensional</h3>
          <div className="h-64 flex items-center justify-center bg-muted/30 rounded-md">
            <p className="text-sm text-muted-foreground">Gráfico Radar/Spider - Chart.js</p>
          </div>
        </Card>
      </div>

      <AIAnalysisBox
        title="Análise Comparativa e Benchmarking por IA"
        content="Análise comparativa dos territórios selecionados revela padrões interessantes de desenvolvimento regional. Palmas, como capital, apresenta o maior IDH-M (0,788) e taxa de alfabetização (94,1%), refletindo melhor infraestrutura urbana e acesso a serviços. Araguaína destaca-se como segundo polo econômico (PIB de R$ 4,2 bi), com forte atividade comercial e agroindustrial. Gurupi apresenta equilibrio entre desenvolvimento econômico e social, com IDH-M de 0,759. Porto Nacional, apesar de menor PIB, mantém bons indicadores sociais. A comparação evidencia concentração econômica na capital (28% do PIB estadual), sugerindo necessidade de descentralização. Recomendações: fortalecer polos regionais, investir em infraestrutura em cidades médias, e promover desenvolvimento equilibrado entre regiões."
      />

      <div>
        <h3 className="text-lg font-semibold mb-4">Tabela Comparativa - Territórios x Indicadores</h3>
        <DataTable columns={columns} data={filteredData} onExport={() => console.log('Export CSV')} />
      </div>
    </div>
  );
}
