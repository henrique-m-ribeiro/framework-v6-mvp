import { useEffect, useState } from "react";
import { MapContainer, TileLayer, Marker, Popup, Circle, useMap } from "react-leaflet";
import { Icon, LatLngExpression } from "leaflet";
import "leaflet/dist/leaflet.css";
import { Card } from "@/components/ui/card";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";

delete (Icon.Default.prototype as any)._getIconUrl;
Icon.Default.mergeOptions({
  iconUrl: "https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png",
  iconRetinaUrl: "https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon-2x.png",
  shadowUrl: "https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png",
});

interface Territory {
  id: string;
  name: string;
  type: string;
  latitude: number;
  longitude: number;
}

interface InteractiveMapProps {
  territories: Territory[];
  selectedTerritoryId?: string;
  onTerritorySelect?: (territoryId: string) => void;
  showRadius?: boolean;
  radiusKm?: number;
  nearbyTerritories?: any[];
}

function MapRecenter({ center }: { center: LatLngExpression }) {
  const map = useMap();
  useEffect(() => {
    map.setView(center, map.getZoom());
  }, [center, map]);
  return null;
}

export function InteractiveMap({
  territories,
  selectedTerritoryId,
  onTerritorySelect,
  showRadius = false,
  radiusKm = 100,
  nearbyTerritories = []
}: InteractiveMapProps) {
  const [selectedTerritory, setSelectedTerritory] = useState<Territory | null>(null);

  useEffect(() => {
    if (selectedTerritoryId) {
      const territory = territories.find(t => t.id === selectedTerritoryId);
      if (territory) {
        setSelectedTerritory(territory);
      }
    }
  }, [selectedTerritoryId, territories]);

  const center: LatLngExpression = selectedTerritory 
    ? [selectedTerritory.latitude, selectedTerritory.longitude]
    : [-10.1847, -48.3558];

  const getMarkerColor = (territory: Territory) => {
    if (selectedTerritory?.id === territory.id) return "hsl(var(--primary))";
    if (nearbyTerritories.some(n => n.id === territory.id)) return "hsl(var(--chart-2))";
    return territory.type === "Estado" ? "hsl(var(--chart-1))" : "hsl(var(--chart-3))";
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center gap-4">
        <div className="flex-1">
          <Label htmlFor="territory-select">Selecionar Território</Label>
          <Select
            value={selectedTerritory?.id || ""}
            onValueChange={(id) => {
              const territory = territories.find(t => t.id === id);
              setSelectedTerritory(territory || null);
              onTerritorySelect?.(id);
            }}
          >
            <SelectTrigger id="territory-select" data-testid="select-territory">
              <SelectValue placeholder="Selecione um território" />
            </SelectTrigger>
            <SelectContent>
              {territories.map((territory) => (
                <SelectItem key={territory.id} value={territory.id}>
                  {territory.name} ({territory.type})
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>

        {selectedTerritory && (
          <div className="flex gap-2">
            <Badge variant="outline" data-testid="badge-selected-territory">
              {selectedTerritory.name}
            </Badge>
            <Badge variant="secondary" data-testid="badge-territory-type">
              {selectedTerritory.type}
            </Badge>
          </div>
        )}
      </div>

      <Card className="overflow-hidden" data-testid="card-map">
        <MapContainer
          center={center}
          zoom={selectedTerritory ? 10 : 7}
          scrollWheelZoom={true}
          style={{ height: "600px", width: "100%" }}
          className="z-0"
        >
          <MapRecenter center={center} />
          <TileLayer
            attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          />
          
          {showRadius && selectedTerritory && (
            <Circle
              center={[selectedTerritory.latitude, selectedTerritory.longitude]}
              radius={radiusKm * 1000}
              pathOptions={{ 
                color: "hsl(var(--primary))", 
                fillColor: "hsl(var(--primary))",
                fillOpacity: 0.1 
              }}
            />
          )}

          {territories.map((territory) => (
            <Marker
              key={territory.id}
              position={[territory.latitude, territory.longitude]}
              eventHandlers={{
                click: () => {
                  setSelectedTerritory(territory);
                  onTerritorySelect?.(territory.id);
                }
              }}
            >
              <Popup>
                <div className="p-2">
                  <h3 className="font-semibold text-base">{territory.name}</h3>
                  <p className="text-sm text-muted-foreground">{territory.type}</p>
                  <p className="text-xs text-muted-foreground mt-1">
                    Lat: {territory.latitude.toFixed(4)}, Lon: {territory.longitude.toFixed(4)}
                  </p>
                </div>
              </Popup>
            </Marker>
          ))}
        </MapContainer>
      </Card>

      {selectedTerritory && nearbyTerritories.length > 0 && (
        <Card className="p-4">
          <h3 className="font-semibold mb-3">
            Territórios Próximos a {selectedTerritory.name} (raio de {radiusKm}km)
          </h3>
          <div className="space-y-2 max-h-64 overflow-y-auto">
            {nearbyTerritories.map((nearby: any) => (
              <div 
                key={nearby.id} 
                className="flex justify-between items-center p-2 hover-elevate rounded-md cursor-pointer"
                onClick={() => {
                  const territory = territories.find(t => t.id === nearby.id);
                  if (territory) {
                    setSelectedTerritory(territory);
                    onTerritorySelect?.(nearby.id);
                  }
                }}
                data-testid={`nearby-territory-${nearby.id}`}
              >
                <div>
                  <p className="font-medium text-sm">{nearby.name}</p>
                  <p className="text-xs text-muted-foreground">{nearby.type}</p>
                </div>
                <Badge variant="secondary">
                  {parseFloat(nearby.distance_km).toFixed(1)} km
                </Badge>
              </div>
            ))}
          </div>
        </Card>
      )}
    </div>
  );
}
