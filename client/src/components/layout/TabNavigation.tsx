import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { LayoutDashboard, DollarSign, Users, MapPin, Leaf, ArrowLeftRight } from "lucide-react";

interface TabNavigationProps {
  activeTab: string;
  onTabChange: (value: string) => void;
}

export default function TabNavigation({ activeTab, onTabChange }: TabNavigationProps) {
  const tabs = [
    { value: "overview", label: "Visão Geral", icon: LayoutDashboard },
    { value: "economic", label: "Econômica", icon: DollarSign },
    { value: "social", label: "Social", icon: Users },
    { value: "territorial", label: "Territorial", icon: MapPin },
    { value: "environmental", label: "Ambiental", icon: Leaf },
    { value: "comparison", label: "Comparação", icon: ArrowLeftRight },
  ];

  return (
    <div className="border-b bg-card sticky top-[144px] z-40">
      <div className="px-6">
        <Tabs value={activeTab} onValueChange={onTabChange} className="w-full">
          <TabsList className="w-full justify-start h-auto p-0 bg-transparent border-0 rounded-none">
            {tabs.map((tab) => (
              <TabsTrigger
                key={tab.value}
                value={tab.value}
                className="flex items-center gap-2 px-4 py-3 rounded-none border-b-2 border-transparent data-[state=active]:border-secondary data-[state=active]:text-secondary data-[state=active]:bg-secondary/5"
                data-testid={`tab-${tab.value}`}
              >
                <tab.icon className="w-4 h-4" />
                <span className="font-medium">{tab.label}</span>
              </TabsTrigger>
            ))}
          </TabsList>
        </Tabs>
      </div>
    </div>
  );
}
