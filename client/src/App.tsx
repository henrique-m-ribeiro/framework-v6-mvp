import { useState } from "react";
import { QueryClientProvider } from "@tanstack/react-query";
import { queryClient } from "./lib/queryClient";
import { Toaster } from "@/components/ui/toaster";
import { TooltipProvider } from "@/components/ui/tooltip";
import Header from "@/components/layout/Header";
import TabNavigation from "@/components/layout/TabNavigation";
import ChatSidebar from "@/components/layout/ChatSidebar";
import OverviewTab from "@/components/tabs/OverviewTab";
import EconomicTab from "@/components/tabs/EconomicTab";
import SocialTab from "@/components/tabs/SocialTab";
import TerritorialTab from "@/components/tabs/TerritorialTab";
import EnvironmentalTab from "@/components/tabs/EnvironmentalTab";
import ComparisonTab from "@/components/tabs/ComparisonTab";

function Dashboard() {
  //todo: remove mock functionality
  const [territoryType, setTerritoryType] = useState("estado");
  const [territory, setTerritory] = useState("tocantins");
  const [period, setPeriod] = useState("5");
  const [activeTab, setActiveTab] = useState("overview");

  const getTerritories = () => {
    if (territoryType === "estado") {
      return [{ value: "tocantins", label: "Tocantins" }];
    } else if (territoryType === "municipio") {
      return [
        { value: "palmas", label: "Palmas" },
        { value: "araguaina", label: "Araguaína" },
        { value: "gurupi", label: "Gurupi" },
        { value: "porto-nacional", label: "Porto Nacional" },
      ];
    }
    return [{ value: "tocantins", label: "Tocantins" }];
  };

  const getContextForChat = () => {
    const contexts: Record<string, string> = {
      overview: "Visão Geral",
      economic: "Dimensão Econômica",
      social: "Dimensão Social",
      territorial: "Dimensão Territorial",
      environmental: "Dimensão Ambiental",
      comparison: "Comparação de Territórios"
    };
    return contexts[activeTab] || "Visão Geral";
  };

  const handleReset = () => {
    setTerritoryType("estado");
    setTerritory("tocantins");
    setPeriod("5");
    setActiveTab("overview");
    console.log("Configuration reset");
  };

  const handleExport = () => {
    console.log("Exporting to PDF...");
  };

  const handleShare = () => {
    console.log("Sharing dashboard...");
  };

  const renderTabContent = () => {
    switch (activeTab) {
      case "overview":
        return <OverviewTab />;
      case "economic":
        return <EconomicTab />;
      case "social":
        return <SocialTab />;
      case "territorial":
        return <TerritorialTab />;
      case "environmental":
        return <EnvironmentalTab />;
      case "comparison":
        return <ComparisonTab />;
      default:
        return <OverviewTab />;
    }
  };

  return (
    <div className="flex h-screen bg-background">
      <div className="flex-1 flex flex-col overflow-hidden">
        <Header
          territoryType={territoryType}
          onTerritoryTypeChange={setTerritoryType}
          territory={territory}
          onTerritoryChange={setTerritory}
          territories={getTerritories()}
          period={period}
          onPeriodChange={setPeriod}
          onReset={handleReset}
          onExport={handleExport}
          onShare={handleShare}
        />
        <TabNavigation activeTab={activeTab} onTabChange={setActiveTab} />
        <main className="flex-1 overflow-y-auto">
          {renderTabContent()}
        </main>
      </div>
      <ChatSidebar context={getContextForChat()} />
    </div>
  );
}

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <TooltipProvider>
        <Dashboard />
        <Toaster />
      </TooltipProvider>
    </QueryClientProvider>
  );
}

export default App;
