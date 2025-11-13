import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Label } from "@/components/ui/label";

interface PeriodSelectorProps {
  period: string;
  onPeriodChange: (value: string) => void;
}

export default function PeriodSelector({ period, onPeriodChange }: PeriodSelectorProps) {
  return (
    <div className="space-y-2">
      <Label htmlFor="period" className="text-sm font-medium">
        Período Temporal
      </Label>
      <Select value={period} onValueChange={onPeriodChange}>
        <SelectTrigger id="period" className="w-full" data-testid="select-period">
          <SelectValue placeholder="Selecione o período" />
        </SelectTrigger>
        <SelectContent>
          <SelectItem value="5">Últimos 5 anos</SelectItem>
          <SelectItem value="10">Últimos 10 anos</SelectItem>
          <SelectItem value="20">Últimos 20 anos</SelectItem>
          <SelectItem value="custom">Customizado</SelectItem>
        </SelectContent>
      </Select>
    </div>
  );
}
