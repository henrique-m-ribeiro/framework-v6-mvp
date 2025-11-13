import Header from '../layout/Header';
import { useState } from 'react';

export default function HeaderExample() {
  //todo: remove mock functionality
  const [territoryType, setTerritoryType] = useState('estado');
  const [territory, setTerritory] = useState('tocantins');
  const [period, setPeriod] = useState('5');

  const territories = [{ value: 'tocantins', label: 'Tocantins' }];

  const handleReset = () => console.log('Reset clicked');
  const handleExport = () => console.log('Export PDF clicked');
  const handleShare = () => console.log('Share clicked');

  return (
    <Header
      territoryType={territoryType}
      onTerritoryTypeChange={setTerritoryType}
      territory={territory}
      onTerritoryChange={setTerritory}
      territories={territories}
      period={period}
      onPeriodChange={setPeriod}
      onReset={handleReset}
      onExport={handleExport}
      onShare={handleShare}
    />
  );
}
