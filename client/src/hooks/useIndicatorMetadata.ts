import { useQuery } from "@tanstack/react-query";
import type { IndicatorMetadata } from "@shared/schema";

export function useIndicatorMetadata(dimension: string) {
  return useQuery<IndicatorMetadata[]>({
    queryKey: ["/api/indicators/metadata", { dimension }],
    queryFn: async () => {
      const response = await fetch(`/api/indicators/metadata?dimension=${dimension}`);
      return response.json();
    },
  });
}

export function getMetadata(metadata: IndicatorMetadata[], indicatorKey: string) {
  return metadata.find(m => m.indicatorKey === indicatorKey);
}

const CHART_COLORS = ["1", "2", "3", "4", "5"];

function getColorIndex(metadata: IndicatorMetadata[], indicatorKey: string): string {
  const index = metadata.findIndex(m => m.indicatorKey === indicatorKey);
  return index >= 0 && index < CHART_COLORS.length 
    ? CHART_COLORS[index] 
    : CHART_COLORS[0];
}

export function getChartConfig(metadata: IndicatorMetadata[], indicatorKey: string, forcedColorIndex?: number) {
  const meta = getMetadata(metadata, indicatorKey);
  const colorIndex = forcedColorIndex !== undefined 
    ? forcedColorIndex.toString() 
    : getColorIndex(metadata, indicatorKey);
    
  return {
    [indicatorKey]: {
      label: meta?.indicatorName || indicatorKey,
      color: `hsl(var(--chart-${colorIndex}))`,
    }
  };
}
