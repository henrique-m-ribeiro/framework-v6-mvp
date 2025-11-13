import DataTable from '../shared/DataTable';

export default function DataTableExample() {
  //todo: remove mock functionality
  const columns = [
    { key: 'year', label: 'Ano', sortable: true },
    { key: 'pib', label: 'PIB (R$ bi)', sortable: true },
    { key: 'population', label: 'População', sortable: true },
    { key: 'idhm', label: 'IDH-M', sortable: true },
  ];

  const data = [
    { year: '2023', pib: '45,2', population: '1.607.363', idhm: '0,743' },
    { year: '2022', pib: '42,9', population: '1.590.248', idhm: '0,735' },
    { year: '2021', pib: '40,1', population: '1.572.866', idhm: '0,728' },
    { year: '2020', pib: '38,5', population: '1.555.229', idhm: '0,720' },
    { year: '2019', pib: '41,2', population: '1.537.591', idhm: '0,715' },
  ];

  const handleExport = () => {
    console.log('Exporting to CSV...');
  };

  return (
    <div className="p-8 bg-background">
      <div className="max-w-4xl">
        <h2 className="text-2xl font-semibold mb-4">Dados Históricos - Tocantins</h2>
        <DataTable columns={columns} data={data} onExport={handleExport} />
      </div>
    </div>
  );
}
