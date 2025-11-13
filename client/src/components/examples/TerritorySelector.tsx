import TerritorySelector from '../controls/TerritorySelector';
import { useState } from 'react';

export default function TerritorySelectorExample() {
  //todo: remove mock functionality
  const [territoryType, setTerritoryType] = useState('estado');
  const [territory, setTerritory] = useState('tocantins');

  const getTerritories = () => {
    if (territoryType === 'estado') {
      return [{ value: 'tocantins', label: 'Tocantins' }];
    } else if (territoryType === 'municipio') {
      return [
        { value: 'palmas', label: 'Palmas' },
        { value: 'araguaina', label: 'Araguaína' },
        { value: 'gurupi', label: 'Gurupi' },
        { value: 'porto-nacional', label: 'Porto Nacional' },
      ];
    }
    return [{ value: 'tocantins', label: 'Tocantins' }];
  };

  return (
    <div className="p-8 bg-background">
      <div className="max-w-2xl">
        <TerritorySelector
          territoryType={territoryType}
          onTerritoryTypeChange={setTerritoryType}
          territory={territory}
          onTerritoryChange={setTerritory}
          territories={getTerritories()}
        />
      </div>
    </div>
  );
}
