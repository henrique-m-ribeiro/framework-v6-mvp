import AIAnalysisBox from '../shared/AIAnalysisBox';

export default function AIAnalysisBoxExample() {
  const handleRegenerate = () => {
    console.log('Regenerating analysis...');
  };

  return (
    <div className="p-8 bg-background">
      <div className="max-w-4xl space-y-6">
        <AIAnalysisBox
          title="Análise Econômica por IA"
          content="O estado do Tocantins apresenta crescimento econômico consistente de 5,2% no último ano, impulsionado principalmente pelos setores de agropecuária e serviços. O PIB per capita de R$ 28.134 está acima da média nacional para estados do Norte. Principais oportunidades: expansão do agronegócio sustentável, desenvolvimento de infraestrutura logística e atração de investimentos em energias renováveis. Pontos de atenção: necessidade de diversificação econômica e melhoria nos indicadores de emprego formal."
          onRegenerate={handleRegenerate}
        />
        <AIAnalysisBox
          title="Análise Social por IA"
          content="Com IDH-M de 0,743, o Tocantins está em trajetória de desenvolvimento, mas apresenta desafios em educação e saúde pública. A taxa de alfabetização de 89,2% está acima da média regional. Investimentos em infraestrutura educacional e programas de capacitação profissional são prioritários para acelerar o desenvolvimento humano."
          loading={false}
          onRegenerate={handleRegenerate}
        />
      </div>
    </div>
  );
}
