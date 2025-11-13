import { Card } from "@/components/ui/card";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Info } from "lucide-react";
import { ChartContainer, ChartTooltip, ChartTooltipContent } from "@/components/ui/chart";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, ResponsiveContainer, Legend } from "recharts";
import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from "@/components/ui/tooltip";
import { getMetadata, getChartConfig } from "@/hooks/useIndicatorMetadata";
import { useIndicatorFormatter } from "@/hooks/useIndicatorFormatter";
import type { IndicatorMetadata } from "@shared/schema";

interface IndicatorLineChartProps {
  data: any[];
  selectedIndicator: string;
  onIndicatorChange: (value: string) => void;
  metadata: IndicatorMetadata[];
  title?: string;
}

export function IndicatorLineChart({
  data,
  selectedIndicator,
  onIndicatorChange,
  metadata,
  title = "Evolução Temporal"
}: IndicatorLineChartProps) {
  const { formatValue } = useIndicatorFormatter();
  const meta = getMetadata(metadata, selectedIndicator);

  if (metadata.length === 0) {
    return (
      <Card className="p-6 flex items-center justify-center h-[400px]">
        <p className="text-sm text-muted-foreground">Carregando metadados...</p>
      </Card>
    );
  }

  const chartConfig = getChartConfig(metadata, selectedIndicator, 1);
  
  const CustomTooltip = ({ active, payload }: any) => {
    if (!active || !payload || !payload.length) return null;
    
    return (
      <div className="rounded-lg border bg-background p-3 shadow-sm max-w-md">
        <div className="grid gap-2">
          <div className="flex flex-col">
            <span className="text-xs text-muted-foreground">Ano: {payload[0].payload.year}</span>
            <span className="text-sm font-medium">
              {meta?.indicatorName}: {formatValue(payload[0].value, selectedIndicator, metadata)}
            </span>
            <span className="text-xs text-muted-foreground">Unidade: {meta?.unit}</span>
            <span className="text-xs text-muted-foreground mt-1">
              {meta?.description}
            </span>
            {meta?.interpretationGuide && (
              <span className="text-xs text-muted-foreground mt-1 italic">
                {meta.interpretationGuide}
              </span>
            )}
          </div>
        </div>
      </div>
    );
  };

  return (
    <Card className="p-6 space-y-4">
      <div className="flex items-center justify-between gap-4">
        <div className="flex items-center gap-2">
          <h3 className="text-lg font-semibold">{title}</h3>
          <TooltipProvider>
            <Tooltip>
              <TooltipTrigger>
                <Info className="h-4 w-4 text-muted-foreground" data-testid="icon-info-line-chart" />
              </TooltipTrigger>
              <TooltipContent className="max-w-xs">
                <p>{meta?.description || "Selecione um indicador para ver sua evolução"}</p>
              </TooltipContent>
            </Tooltip>
          </TooltipProvider>
        </div>
        <div className="w-48">
          <Select value={selectedIndicator} onValueChange={onIndicatorChange}>
            <SelectTrigger data-testid="select-line-indicator">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              {metadata.map(m => (
                <SelectItem key={m.indicatorKey} value={m.indicatorKey}>
                  {m.indicatorName}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>
      <p className="text-sm text-muted-foreground">
        <strong>Indicador:</strong> {meta?.indicatorName} ({meta?.unit})
      </p>
      <ChartContainer
        config={chartConfig}
        className="h-64"
      >
        <ResponsiveContainer width="100%" height="100%">
          <LineChart data={data}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis 
              dataKey="year" 
              tickFormatter={(value) => value.toString()}
            />
            <YAxis 
              tickFormatter={(value) => formatValue(value, selectedIndicator)}
            />
            <ChartTooltip content={<CustomTooltip />} />
            <Legend 
              content={() => (
                <div className="flex flex-col gap-1 pt-4 border-t mt-4">
                  <div className="flex items-center gap-2">
                    <div 
                      className="w-3 h-3 rounded-full" 
                      style={{ backgroundColor: `hsl(var(--chart-1))` }}
                    />
                    <span className="text-sm font-medium">{meta?.indicatorName}</span>
                    <span className="text-xs text-muted-foreground">({meta?.unit})</span>
                  </div>
                  <p className="text-xs text-muted-foreground pl-5">{meta?.description}</p>
                </div>
              )}
            />
            <Line 
              type="monotone" 
              dataKey={selectedIndicator}
              stroke="hsl(var(--chart-1))"
              strokeWidth={2}
              dot={{ fill: "hsl(var(--chart-1))" }}
            />
          </LineChart>
        </ResponsiveContainer>
      </ChartContainer>
    </Card>
  );
}
