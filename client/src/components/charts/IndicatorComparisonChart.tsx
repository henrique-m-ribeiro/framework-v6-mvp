import { Card } from "@/components/ui/card";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Label } from "@/components/ui/label";
import { Info } from "lucide-react";
import { ChartContainer, ChartTooltip, ChartTooltipContent } from "@/components/ui/chart";
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, ResponsiveContainer, Legend } from "recharts";
import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from "@/components/ui/tooltip";
import { getMetadata, getChartConfig } from "@/hooks/useIndicatorMetadata";
import { useIndicatorFormatter } from "@/hooks/useIndicatorFormatter";
import type { IndicatorMetadata } from "@shared/schema";

interface IndicatorComparisonChartProps {
  data: any[];
  selectedIndicator1: string;
  selectedIndicator2: string;
  onIndicator1Change: (value: string) => void;
  onIndicator2Change: (value: string) => void;
  metadata: IndicatorMetadata[];
  title?: string;
}

export function IndicatorComparisonChart({
  data,
  selectedIndicator1,
  selectedIndicator2,
  onIndicator1Change,
  onIndicator2Change,
  metadata,
  title = "Comparação de Indicadores"
}: IndicatorComparisonChartProps) {
  const { formatValue } = useIndicatorFormatter();
  const meta1 = getMetadata(metadata, selectedIndicator1);
  const meta2 = getMetadata(metadata, selectedIndicator2);

  if (metadata.length === 0) {
    return (
      <Card className="p-6 flex items-center justify-center h-[400px]">
        <p className="text-sm text-muted-foreground">Carregando metadados...</p>
      </Card>
    );
  }

  const chartConfig = {
    ...getChartConfig(metadata, selectedIndicator1, 2),
    ...getChartConfig(metadata, selectedIndicator2, 3)
  };

  const CustomTooltip = ({ active, payload }: any) => {
    if (!active || !payload || !payload.length) return null;
    
    return (
      <div className="rounded-lg border bg-background p-3 shadow-sm max-w-md">
        <div className="grid gap-3">
          <span className="text-xs text-muted-foreground">Ano: {payload[0].payload.year}</span>
          {payload.map((entry: any) => {
            const indicatorKey = entry.dataKey;
            const meta = getMetadata(metadata, indicatorKey);
            return (
              <div key={indicatorKey} className="flex flex-col gap-1 border-l-2 pl-2" style={{ borderColor: entry.color }}>
                <span className="text-sm font-medium">
                  {meta?.indicatorName}: {formatValue(entry.value, indicatorKey, metadata)}
                </span>
                <span className="text-xs text-muted-foreground">{meta?.unit}</span>
                <span className="text-xs text-muted-foreground mt-1">{meta?.description}</span>
                {meta?.interpretationGuide && (
                  <span className="text-xs text-muted-foreground italic">
                    {meta.interpretationGuide}
                  </span>
                )}
              </div>
            );
          })}
        </div>
      </div>
    );
  };

  return (
    <Card className="p-6 space-y-4">
      <div className="flex items-center gap-2 mb-2">
        <h3 className="text-lg font-semibold">{title}</h3>
        <TooltipProvider>
          <Tooltip>
            <TooltipTrigger>
              <Info className="h-4 w-4 text-muted-foreground" data-testid="icon-info-bar-chart" />
            </TooltipTrigger>
            <TooltipContent className="max-w-xs">
              <p>Compare dois indicadores lado a lado para identificar correlações</p>
            </TooltipContent>
          </Tooltip>
        </TooltipProvider>
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-2">
          <Label>Indicador 1</Label>
          <Select value={selectedIndicator1} onValueChange={onIndicator1Change}>
            <SelectTrigger data-testid="select-bar-indicator-1">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              {metadata.filter(m => m.indicatorKey !== selectedIndicator2).map(m => (
                <SelectItem key={m.indicatorKey} value={m.indicatorKey}>
                  {m.indicatorName}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
        <div className="space-y-2">
          <Label>Indicador 2</Label>
          <Select value={selectedIndicator2} onValueChange={onIndicator2Change}>
            <SelectTrigger data-testid="select-bar-indicator-2">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              {metadata.filter(m => m.indicatorKey !== selectedIndicator1).map(m => (
                <SelectItem key={m.indicatorKey} value={m.indicatorKey}>
                  {m.indicatorName}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>
      <p className="text-sm text-muted-foreground">
        <strong>{meta1?.indicatorName}</strong> ({meta1?.unit}) vs <strong>{meta2?.indicatorName}</strong> ({meta2?.unit})
      </p>
      <ChartContainer
        config={chartConfig}
        className="h-64"
      >
        <ResponsiveContainer width="100%" height="100%">
          <BarChart data={data}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis 
              dataKey="year"
              tickFormatter={(value) => value.toString()}
            />
            <YAxis yAxisId="left" tickFormatter={(value) => formatValue(value, selectedIndicator1)} />
            <YAxis yAxisId="right" orientation="right" tickFormatter={(value) => formatValue(value, selectedIndicator2)} />
            <ChartTooltip content={<CustomTooltip />} />
            <Legend 
              content={() => (
                <div className="flex flex-col gap-2 pt-4 border-t mt-4">
                  <div className="flex items-start gap-2">
                    <div 
                      className="w-3 h-3 rounded-full mt-1" 
                      style={{ backgroundColor: `hsl(var(--chart-2))` }}
                    />
                    <div className="flex-1">
                      <div className="flex items-center gap-2">
                        <span className="text-sm font-medium">{meta1?.indicatorName}</span>
                        <span className="text-xs text-muted-foreground">({meta1?.unit})</span>
                      </div>
                      <p className="text-xs text-muted-foreground">{meta1?.description}</p>
                    </div>
                  </div>
                  <div className="flex items-start gap-2">
                    <div 
                      className="w-3 h-3 rounded-full mt-1" 
                      style={{ backgroundColor: `hsl(var(--chart-3))` }}
                    />
                    <div className="flex-1">
                      <div className="flex items-center gap-2">
                        <span className="text-sm font-medium">{meta2?.indicatorName}</span>
                        <span className="text-xs text-muted-foreground">({meta2?.unit})</span>
                      </div>
                      <p className="text-xs text-muted-foreground">{meta2?.description}</p>
                    </div>
                  </div>
                </div>
              )}
            />
            <Bar 
              yAxisId="left"
              dataKey={selectedIndicator1}
              fill="hsl(var(--chart-2))"
              radius={[4, 4, 0, 0]}
            />
            <Bar 
              yAxisId="right"
              dataKey={selectedIndicator2}
              fill="hsl(var(--chart-3))"
              radius={[4, 4, 0, 0]}
            />
          </BarChart>
        </ResponsiveContainer>
      </ChartContainer>
    </Card>
  );
}
