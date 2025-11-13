import PeriodSelector from '../controls/PeriodSelector';
import { useState } from 'react';

export default function PeriodSelectorExample() {
  const [period, setPeriod] = useState('5');

  return (
    <div className="p-8 bg-background">
      <div className="max-w-xs">
        <PeriodSelector period={period} onPeriodChange={setPeriod} />
      </div>
    </div>
  );
}
