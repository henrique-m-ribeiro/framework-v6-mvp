import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { TrendingUp, TrendingDown, Minus, LucideIcon } from "lucide-react";

interface KPICardProps {
  title: string;
  value: string | number;
  subtitle?: string;
  trend?: {
    value: number;
    direction: "up" | "down" | "neutral";
  };
  icon: LucideIcon;
  status?: "success" | "warning" | "danger";
}

export default function KPICard({ title, value, subtitle, trend, icon: Icon, status }: KPICardProps) {
  const getTrendColor = () => {
    if (!trend) return "";
    if (trend.direction === "up") return "text-chart-4";
    if (trend.direction === "down") return "text-destructive";
    return "text-muted-foreground";
  };

  const TrendIcon = trend?.direction === "up" ? TrendingUp : trend?.direction === "down" ? TrendingDown : Minus;

  const getStatusBadge = () => {
    if (!status) return null;
    const variants = {
      success: "bg-chart-4/10 text-chart-4 border-chart-4/20",
      warning: "bg-chart-5/10 text-chart-5 border-chart-5/20",
      danger: "bg-destructive/10 text-destructive border-destructive/20"
    };
    return (
      <Badge className={`${variants[status]} uppercase text-[10px] font-semibold`} data-testid={`badge-status-${status}`}>
        {status === "success" ? "Ótimo" : status === "warning" ? "Atenção" : "Crítico"}
      </Badge>
    );
  };

  return (
    <Card className="p-6 hover-elevate" data-testid={`card-kpi-${title.toLowerCase().replace(/\s+/g, '-')}`}>
      <div className="flex items-start justify-between mb-4">
        <div className="w-10 h-10 rounded-md bg-secondary/10 flex items-center justify-center">
          <Icon className="w-5 h-5 text-secondary" />
        </div>
        {getStatusBadge()}
      </div>
      
      <div className="space-y-1">
        <p className="text-sm text-muted-foreground font-medium" data-testid="text-kpi-title">{title}</p>
        <p className="text-[32px] font-bold leading-none text-foreground" data-testid="text-kpi-value">{value}</p>
        {subtitle && (
          <p className="text-xs text-muted-foreground" data-testid="text-kpi-subtitle">{subtitle}</p>
        )}
      </div>

      {trend && (
        <div className={`flex items-center gap-1 mt-3 ${getTrendColor()}`}>
          <TrendIcon className="w-4 h-4" />
          <span className="text-sm font-semibold" data-testid="text-kpi-trend">
            {trend.value > 0 ? "+" : ""}{trend.value}%
          </span>
          <span className="text-xs text-muted-foreground ml-1">vs. ano anterior</span>
        </div>
      )}
    </Card>
  );
}
