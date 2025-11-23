import { useState, useEffect } from "react";
import { QueryClientProvider, useQuery } from "@tanstack/react-query";
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
import type { Territory } from "@shared/schema";

function Dashboard() {
  const [territoryType, setTerritoryType] = useState("Estado");
  const [territoryId, setTerritoryId] = useState("");
  const [period, setPeriod] = useState("5");
  const [activeTab, setActiveTab] = useState("overview");

  const { data: territories = [] } = useQuery<Territory[]>({
    queryKey: ["/api/territories"],
  });

  useEffect(() => {
    if (territories.length > 0 && !territoryId) {
      const stateTerritories = territories.filter((t: Territory) => 
        t.type.toLowerCase() === "estado"
      );
      if (stateTerritories.length > 0) {
        setTerritoryId(stateTerritories[0].id);
      }
    }
  }, [territories, territoryId]);

  // Atualizar territoryId quando territoryType muda
  useEffect(() => {
    if (territories.length > 0) {
      const filtered = territories.filter((t: Territory) => 
        t.type.toLowerCase() === territoryType.toLowerCase()
      );
      
      if (filtered.length === 0) return;
      
      // Se territoryId está vazio OU não pertence ao tipo atual, selecionar primeiro do tipo
      const currentTerritory = territoryId ? territories.find(t => t.id === territoryId) : null;
      const isCurrentTypeMismatch = currentTerritory && 
        currentTerritory.type.toLowerCase() !== territoryType.toLowerCase();
      
      if (!territoryId || isCurrentTypeMismatch) {
        setTerritoryId(filtered[0].id);
      }
    }
  }, [territoryType, territories, territoryId]);

  const getTerritories = () => {
    const filtered = territories.filter((t: Territory) => 
      t.type.toLowerCase() === territoryType.toLowerCase()
    );
    return filtered.map((t: Territory) => ({
      value: t.id,
      label: t.name,
    }));
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
    setTerritoryType("Estado");
    const stateTerritories = territories.filter((t: Territory) => 
      t.type.toLowerCase() === "estado"
    );
    if (stateTerritories.length > 0) {
      setTerritoryId(stateTerritories[0].id);
    }
    setPeriod("5");
    setActiveTab("overview");
  };

  const handleExport = () => {
    window.print();
  };

  const handleShare = () => {
    if (navigator.share) {
      navigator.share({
        title: "Dashboard de Inteligência Territorial - Tocantins",
        text: "Análise territorial do estado do Tocantins",
        url: window.location.href,
      });
    } else {
      navigator.clipboard.writeText(window.location.href);
      alert("Link copiado para a área de transferência!");
    }
  };

  const renderTabContent = () => {
    if (!territoryId) return <div className="p-6">Carregando...</div>;

    switch (activeTab) {
      case "overview":
        return <OverviewTab territoryId={territoryId} />;
      case "economic":
        return <EconomicTab territoryId={territoryId} />;
      case "social":
        return <SocialTab territoryId={territoryId} />;
      case "territorial":
        return <TerritorialTab territoryId={territoryId} />;
      case "environmental":
        return <EnvironmentalTab territoryId={territoryId} />;
      case "comparison":
        return <ComparisonTab />;
      default:
        return <OverviewTab territoryId={territoryId} />;
    }
  };

  return (
    <div className="flex h-screen bg-background">
      <div className="flex-1 flex flex-col overflow-hidden">
        <Header
          territoryType={territoryType}
          onTerritoryTypeChange={setTerritoryType}
          territory={territoryId}
          onTerritoryChange={setTerritoryId}
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
