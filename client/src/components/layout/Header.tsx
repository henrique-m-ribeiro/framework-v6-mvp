import { Button } from "@/components/ui/button";
import { Download, Share2, RotateCcw, Map } from "lucide-react";
import TerritorySelector from "../controls/TerritorySelector";
import PeriodSelector from "../controls/PeriodSelector";

interface HeaderProps {
  territoryType: string;
  onTerritoryTypeChange: (value: string) => void;
  territory: string;
  onTerritoryChange: (value: string) => void;
  territories: { value: string; label: string }[];
  period: string;
  onPeriodChange: (value: string) => void;
  onReset: () => void;
  onExport: () => void;
  onShare: () => void;
}

export default function Header({
  territoryType,
  onTerritoryTypeChange,
  territory,
  onTerritoryChange,
  territories,
  period,
  onPeriodChange,
  onReset,
  onExport,
  onShare
}: HeaderProps) {
  return (
    <header className="bg-primary border-b border-primary-border sticky top-0 z-50">
      <div className="px-6 py-4">
        <div className="flex items-center justify-between mb-4">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-md bg-secondary flex items-center justify-center">
              <Map className="w-6 h-6 text-white" />
            </div>
            <div>
              <h1 className="text-xl font-bold text-primary-foreground" data-testid="text-app-title">
                Dashboard de Inteligência Territorial
              </h1>
              <p className="text-sm text-primary-foreground/70">Estado do Tocantins</p>
            </div>
          </div>

          <div className="flex items-center gap-2">
            <Button 
              variant="outline" 
              size="sm"
              onClick={onReset}
              className="bg-primary-foreground/10 border-primary-foreground/20 text-primary-foreground hover:bg-primary-foreground/20"
              data-testid="button-reset"
            >
              <RotateCcw className="w-4 h-4 mr-2" />
              Resetar
            </Button>
            <Button 
              variant="outline" 
              size="sm"
              onClick={onShare}
              className="bg-primary-foreground/10 border-primary-foreground/20 text-primary-foreground hover:bg-primary-foreground/20"
              data-testid="button-share"
            >
              <Share2 className="w-4 h-4 mr-2" />
              Compartilhar
            </Button>
            <Button 
              variant="default"
              size="sm"
              onClick={onExport}
              className="bg-accent hover:bg-accent/90"
              data-testid="button-export-pdf"
            >
              <Download className="w-4 h-4 mr-2" />
              Exportar PDF
            </Button>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="md:col-span-2">
            <TerritorySelector
              territoryType={territoryType}
              onTerritoryTypeChange={onTerritoryTypeChange}
              territory={territory}
              onTerritoryChange={onTerritoryChange}
              territories={territories}
            />
          </div>
          <PeriodSelector period={period} onPeriodChange={onPeriodChange} />
        </div>
      </div>
    </header>
  );
}
