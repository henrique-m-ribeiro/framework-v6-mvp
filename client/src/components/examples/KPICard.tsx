import KPICard from '../shared/KPICard';
import { DollarSign, Users, Briefcase, TrendingUp } from 'lucide-react';

export default function KPICardExample() {
  return (
    <div className="p-8 bg-background">
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <KPICard
          title="PIB Total"
          value="R$ 45,2 bi"
          subtitle="Produto Interno Bruto"
          trend={{ value: 5.2, direction: "up" }}
          icon={DollarSign}
          status="success"
        />
        <KPICard
          title="População"
          value="1.607.363"
          subtitle="Habitantes (IBGE 2023)"
          trend={{ value: 1.8, direction: "up" }}
          icon={Users}
          status="success"
        />
        <KPICard
          title="Taxa de Emprego"
          value="65,4%"
          subtitle="População economicamente ativa"
          trend={{ value: -2.1, direction: "down" }}
          icon={Briefcase}
          status="warning"
        />
        <KPICard
          title="IDH-M"
          value="0,743"
          subtitle="Índice de Desenvolvimento"
          trend={{ value: 3.5, direction: "up" }}
          icon={TrendingUp}
          status="success"
        />
      </div>
    </div>
  );
}
