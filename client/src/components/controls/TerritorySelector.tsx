import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Label } from "@/components/ui/label";

interface TerritorySelectorProps {
  territoryType: string;
  onTerritoryTypeChange: (value: string) => void;
  territory: string;
  onTerritoryChange: (value: string) => void;
  territories: { value: string; label: string }[];
}

export default function TerritorySelector({
  territoryType,
  onTerritoryTypeChange,
  territory,
  onTerritoryChange,
  territories
}: TerritorySelectorProps) {
  return (
    <div className="flex flex-col md:flex-row gap-4">
      <div className="flex-1 space-y-2">
        <Label htmlFor="territory-type" className="text-sm font-medium">
          Tipo de Território
        </Label>
        <Select value={territoryType} onValueChange={onTerritoryTypeChange}>
          <SelectTrigger id="territory-type" className="w-full" data-testid="select-territory-type">
            <SelectValue placeholder="Selecione o tipo" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="estado">Estado</SelectItem>
            <SelectItem value="regiao-intermediaria">Região Intermediária</SelectItem>
            <SelectItem value="regiao-imediata">Região Imediata</SelectItem>
            <SelectItem value="municipio">Município</SelectItem>
            <SelectItem value="mesorregiao">Mesorregião</SelectItem>
            <SelectItem value="microrregiao">Microrregião</SelectItem>
          </SelectContent>
        </Select>
      </div>

      <div className="flex-1 space-y-2">
        <Label htmlFor="territory" className="text-sm font-medium">
          Território Específico
        </Label>
        <Select value={territory} onValueChange={onTerritoryChange}>
          <SelectTrigger id="territory" className="w-full" data-testid="select-territory">
            <SelectValue placeholder="Selecione o território" />
          </SelectTrigger>
          <SelectContent>
            {territories.map((t) => (
              <SelectItem key={t.value} value={t.value}>
                {t.label}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>
      </div>
    </div>
  );
}
