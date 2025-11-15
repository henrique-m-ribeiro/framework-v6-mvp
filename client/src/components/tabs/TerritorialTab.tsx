import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import KPICard from "../shared/KPICard";
import AIAnalysisBox from "../shared/AIAnalysisBox";
import DataTable from "../shared/DataTable";
import { InteractiveMap } from "../map/InteractiveMap";
import { Card } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { MapPin, Home, Users2, Droplet, Search } from "lucide-react";
import type { TerritorialIndicator, Territory } from "@shared/schema";

interface TerritorialTabProps {
  territoryId: string;
}

export default function TerritorialTab({ territoryId }: TerritorialTabProps) {
  const [selectedMapTerritory, setSelectedMapTerritory] = useState<string>("");
  const [searchRadius, setSearchRadius] = useState<number>(100);

  const { data: territorialData = [] } = useQuery<TerritorialIndicator[]>({
    queryKey: ["/api/territories", territoryId, "indicators", "territorial"],
    enabled: !!territoryId,
  });

  const { data: territory } = useQuery<Territory>({
    queryKey: ["/api/territories", territoryId],
    enabled: !!territoryId,
  });

  const { data: mapTerritories = [] } = useQuery<any[]>({
    queryKey: ["/api/territories/map/coordinates"],
  });

  const { data: nearbyTerritories = [] } = useQuery<any[]>({
    queryKey: ["/api/territories", selectedMapTerritory, "nearby", searchRadius],
    enabled: !!selectedMapTerritory,
    queryFn: async () => {
      const response = await fetch(`/api/territories/${selectedMapTerritory}/nearby?radius=${searchRadius}`);
      if (!response.ok) return [];
      return response.json();
    }
  });

  if (territorialData.length === 0) {
    return <div className="p-6">Carregando dados territoriais...</div>;
  }

  const latest = territorialData[0];
  const columns = [
    { key: 'municipality', label: 'Município', sortable: true },
    { key: 'area', label: 'Área (km²)', sortable: true },
    { key: 'population', label: 'População', sortable: true },
    { key: 'density', label: 'Densidade (hab/km²)', sortable: true },
  ];

  const data = [
    { municipality: 'Palmas', area: '2.218', population: '306.296', density: '138,1' },
    { municipality: 'Araguaína', area: '4.000', population: '180.470', density: '45,1' },
    { municipality: 'Gurupi', area: '1.836', population: '87.545', density: '47,7' },
    { municipality: 'Porto Nacional', area: '4.449', population: '53.010', density: '11,9' },
    { municipality: 'Paraíso do Tocantins', area: '1.268', population: '51.281', density: '40,4' },
  ];

  return (
    <div className="p-6 space-y-6">
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <KPICard
          title="Área Total"
          value="277.423 km²"
          subtitle="13º maior estado do Brasil"
          icon={MapPin}
        />
        <KPICard
          title="Área Urbanizada"
          value="1.847 km²"
          subtitle="0,67% do território"
          icon={Home}
        />
        <KPICard
          title="Densidade Demográfica"
          value="5,8 hab/km²"
          subtitle="Baixa densidade populacional"
          icon={Users2}
        />
        <KPICard
          title="Cobertura Saneamento"
          value="62,4%"
          subtitle="Domicílios atendidos"
          trend={{ value: 4.2, direction: "up" }}
          icon={Droplet}
          status="warning"
        />
      </div>

      <div className="space-y-6">
        <Card className="p-6">
          <div className="flex items-center justify-between mb-4">
            <h3 className="text-lg font-semibold">Mapa Interativo do Tocantins</h3>
            <div className="flex items-center gap-4">
              <div className="flex items-center gap-2">
                <Label htmlFor="radius-input" className="text-sm whitespace-nowrap">Raio de busca:</Label>
                <Input
                  id="radius-input"
                  type="number"
                  value={searchRadius}
                  onChange={(e) => setSearchRadius(parseInt(e.target.value) || 100)}
                  className="w-24"
                  min="10"
                  max="500"
                  step="10"
                  data-testid="input-search-radius"
                />
                <span className="text-sm text-muted-foreground">km</span>
              </div>
            </div>
          </div>
          
          <InteractiveMap
            territories={mapTerritories}
            selectedTerritoryId={selectedMapTerritory}
            onTerritorySelect={setSelectedMapTerritory}
            showRadius={!!selectedMapTerritory}
            radiusKm={searchRadius}
            nearbyTerritories={nearbyTerritories}
          />
        </Card>
      </div>

      <AIAnalysisBox
        title="Análise de Padrões de Ocupação Territorial por IA"
        content="O Tocantins possui 277.423 km², sendo o 13º maior estado brasileiro, com baixa densidade demográfica de 5,8 hab/km². A ocupação territorial é concentrada na região central, com Palmas (capital) apresentando densidade de 138,1 hab/km². Principais características: 87,3% do território mantém cobertura vegetal nativa, com uso predominante para agropecuária extensiva. A área urbanizada representa apenas 0,67%, indicando grande potencial para expansão planejada. Desafios críticos: apenas 62,4% dos domicílios têm cobertura de saneamento básico, com disparidades significativas entre zonas urbanas (85%) e rurais (28%). Recomendações: implementar planos diretores regionais, fortalecer a infraestrutura de saneamento em áreas rurais, criar corredores ecológicos para preservação ambiental, e desenvolver polos de crescimento sustentável fora da capital."
      />

      <div>
        <h3 className="text-lg font-semibold mb-4">Principais Municípios - Dados Geoespaciais</h3>
        <DataTable columns={columns} data={data} onExport={() => console.log('Export CSV')} />
      </div>
    </div>
  );
}
