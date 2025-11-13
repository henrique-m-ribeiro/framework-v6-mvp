import TabNavigation from '../layout/TabNavigation';
import { useState } from 'react';

export default function TabNavigationExample() {
  const [activeTab, setActiveTab] = useState('overview');

  return (
    <div className="bg-background">
      <TabNavigation activeTab={activeTab} onTabChange={setActiveTab} />
      <div className="p-8">
        <p className="text-muted-foreground">Aba ativa: <strong>{activeTab}</strong></p>
      </div>
    </div>
  );
}
