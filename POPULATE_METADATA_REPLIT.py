#!/usr/bin/env python3
"""
Script para Popular indicator_metadata no Replit
Framework V6.0 - Metadados dos Indicadores

Execute no Replit: python3 POPULATE_METADATA_REPLIT.py
"""

import json
import os

# Metadados completos (inline para facilitar)
METADATA = [
    {
        "indicator_code": "gdp",
        "dimension": "economic",
        "name": "Produto Interno Bruto (PIB) Municipal",
        "description": "Soma de todos os bens e serviços finais produzidos por um município, a preços de mercado, em um determinado período. É um dos principais indicadores da atividade econômica local.",
        "unit": "R$ (milhões)",
        "source": "IBGE - Contas Regionais",
        "methodology": "Calculado pelo IBGE a partir da ótica da produção, somando os valores adicionados brutos dos setores de Agropecuária, Indústria e Serviços, mais os impostos.",
        "interpretation_guide": "Valores mais altos indicam maior atividade econômica. O crescimento do PIB é um sinal de desenvolvimento econômico.",
        "good_range": {"min": 1000, "max": 1000000},
        "alert_range": {"min": 0, "max": 100}
    },
    {
        "indicator_code": "gdp_per_capita",
        "dimension": "economic",
        "name": "PIB per capita",
        "description": "PIB do município dividido pela sua população total. Mede a riqueza média por habitante, indicando o nível de desenvolvimento econômico.",
        "unit": "R$",
        "source": "IBGE - Contas Regionais",
        "methodology": "PIB a preços correntes dividido pela população residente estimada para o mesmo ano.",
        "interpretation_guide": "Valores mais altos sugerem maior riqueza por habitante. Comparar com a média estadual e nacional ajuda a entender a posição do município.",
        "good_range": {"min": 30000, "max": 500000},
        "alert_range": {"min": 0, "max": 15000}
    },
    {
        "indicator_code": "employment_rate",
        "dimension": "economic",
        "name": "Taxa de Ocupação Formal",
        "description": "Percentual da população em idade ativa (18-65 anos) que possui um emprego com carteira assinada. Mede a formalidade do mercado de trabalho.",
        "unit": "%",
        "source": "MTE - RAIS (Relação Anual de Informações Sociais)",
        "methodology": "Número de vínculos empregatícios formais ativos em 31/12, dividido pela população em idade ativa, multiplicado por 100.",
        "interpretation_guide": "Taxas mais altas indicam um mercado de trabalho mais formal e estável. Taxas baixas podem indicar alta informalidade ou desemprego.",
        "good_range": {"min": 40, "max": 100},
        "alert_range": {"min": 0, "max": 20}
    },
    {
        "indicator_code": "revenue",
        "dimension": "economic",
        "name": "Receita Total do Município",
        "description": "Soma de todas as receitas arrecadadas pelo município, incluindo tributos, transferências e outras fontes. Indica a capacidade financeira da gestão municipal.",
        "unit": "R$",
        "source": "SICONFI - Tesouro Nacional",
        "methodology": "Soma das receitas correntes e de capital declaradas pelo município no Relatório Resumido da Execução Orçamentária (RREO).",
        "interpretation_guide": "Receitas maiores permitem mais investimentos em serviços públicos. A dependência de transferências é um fator importante a ser analisado.",
        "good_range": {"min": 50000000, "max": 10000000000},
        "alert_range": {"min": 0, "max": 10000000}
    },
    {
        "indicator_code": "idhm",
        "dimension": "social",
        "name": "Índice de Desenvolvimento Humano Municipal (IDH-M)",
        "description": "Medida composta que avalia o desenvolvimento humano em três dimensões: longevidade (saúde), educação e renda.",
        "unit": "índice (0-1)",
        "source": "PNUD / IPEA / FJP",
        "methodology": "Média geométrica dos índices de Longevidade (IDH-L), Educação (IDH-E) e Renda (IDH-R), normalizados entre 0 e 1.",
        "interpretation_guide": "0-0.499: Muito Baixo | 0.500-0.599: Baixo | 0.600-0.699: Médio | 0.700-0.799: Alto | 0.800-1.000: Muito Alto. Quanto mais perto de 1, melhor.",
        "good_range": {"min": 0.7, "max": 1},
        "alert_range": {"min": 0, "max": 0.599}
    },
    {
        "indicator_code": "population",
        "dimension": "social",
        "name": "População Residente",
        "description": "Número total de habitantes residentes no município.",
        "unit": "habitantes",
        "source": "IBGE - Censo Demográfico e Estimativas Populacionais",
        "methodology": "Contagem direta da população durante o Censo Demográfico e projeções anuais baseadas em taxas de natalidade, mortalidade e migração.",
        "interpretation_guide": "O crescimento ou declínio da população impacta a demanda por serviços públicos e a dinâmica econômica.",
        "good_range": {"min": 50000, "max": 10000000},
        "alert_range": {"min": 0, "max": 5000}
    },
    {
        "indicator_code": "literacy_rate",
        "dimension": "social",
        "name": "Taxa de Alfabetização",
        "description": "Percentual de pessoas de 15 anos ou mais de idade que sabem ler e escrever pelo menos um bilhete simples.",
        "unit": "%",
        "source": "IBGE - Censo Demográfico",
        "methodology": "(Número de pessoas de 15+ anos alfabetizadas / População total de 15+ anos) * 100.",
        "interpretation_guide": "Taxas mais altas indicam melhor acesso e qualidade da educação básica. O ideal é se aproximar de 100%.",
        "good_range": {"min": 95, "max": 100},
        "alert_range": {"min": 0, "max": 80}
    },
    {
        "indicator_code": "income_per_capita",
        "dimension": "social",
        "name": "Renda per capita",
        "description": "Soma da renda de todos os indivíduos de um domicílio, dividida pelo número de seus moradores. Mede o nível médio de renda da população.",
        "unit": "R$",
        "source": "IBGE - Censo Demográfico",
        "methodology": "Baseado na declaração de renda dos domicílios durante o Censo.",
        "interpretation_guide": "Valores mais altos indicam melhor condição de vida. É um componente importante do IDH-M.",
        "good_range": {"min": 1500, "max": 10000},
        "alert_range": {"min": 0, "max": 700}
    },
    {
        "indicator_code": "area_km2",
        "dimension": "territorial",
        "name": "Área Territorial",
        "description": "Extensão territorial total do município.",
        "unit": "km²",
        "source": "IBGE - Geociências",
        "methodology": "Medição realizada pelo IBGE com base em cartografia digital e geoprocessamento.",
        "interpretation_guide": "A área impacta a densidade demográfica e a gestão do território (rural vs. urbano).",
        "good_range": {"min": 100, "max": 100000},
        "alert_range": {"min": 0, "max": 50}
    },
    {
        "indicator_code": "density_per_km2",
        "dimension": "territorial",
        "name": "Densidade Demográfica",
        "description": "População total do município dividida pela sua área territorial. Mede a concentração de pessoas no território.",
        "unit": "hab/km²",
        "source": "IBGE - Censo Demográfico e Geociências",
        "methodology": "População residente / Área territorial em km².",
        "interpretation_guide": "Altas densidades são típicas de áreas urbanas e podem indicar pressão sobre infraestrutura. Baixas densidades são comuns em áreas rurais.",
        "good_range": {"min": 100, "max": 10000},
        "alert_range": {"min": 0, "max": 10}
    },
    {
        "indicator_code": "deforestation_km2",
        "dimension": "environmental",
        "name": "Desmatamento Anual",
        "description": "Área de vegetação nativa suprimida no município durante o ano. Mede a pressão sobre os ecossistemas locais.",
        "unit": "km²",
        "source": "INPE - PRODES",
        "methodology": "Análise de imagens de satélite (Landsat) para identificar áreas de corte raso ou degradação progressiva da floresta.",
        "interpretation_guide": "O ideal é que este valor seja zero. Valores altos indicam forte pressão ambiental e risco de perda de biodiversidade.",
        "good_range": {"min": 0, "max": 1},
        "alert_range": {"min": 10, "max": 10000}
    },
    {
        "indicator_code": "fire_spots",
        "dimension": "environmental",
        "name": "Focos de Calor",
        "description": "Número de focos de calor detectados por satélites no município. Indica a ocorrência de queimadas.",
        "unit": "quantidade",
        "source": "INPE - BDQueimadas",
        "methodology": "Detecção de anomalias térmicas na superfície por sensores de satélites como AQUA, TERRA, e GOES.",
        "interpretation_guide": "Valores altos, especialmente na estação seca, indicam queimadas descontroladas, que afetam a qualidade do ar e a biodiversidade.",
        "good_range": {"min": 0, "max": 50},
        "alert_range": {"min": 500, "max": 100000}
    }
]

def main():
    print("=" * 70)
    print("POPULAR TABELA indicator_metadata")
    print("=" * 70)
    print(f"\n📊 Total de metadados: {len(METADATA)}")
    
    # Verificar DATABASE_URL
    database_url = os.getenv("DATABASE_URL")
    if not database_url:
        print("\n❌ ERRO: DATABASE_URL não encontrada no ambiente")
        print("Certifique-se de estar executando no Replit")
        return
    
    print(f"🗄️  Banco: {database_url.split('@')[1].split('/')[0] if '@' in database_url else 'configurado'}")
    
    # Importar psycopg2
    try:
        import psycopg2
        from psycopg2.extras import Json
    except ImportError:
        print("\n❌ ERRO: psycopg2 não instalado")
        print("Execute: pip install psycopg2-binary")
        return
    
    # Conectar
    try:
        conn = psycopg2.connect(database_url)
        cur = conn.cursor()
        print("✓ Conexão estabelecida\n")
    except Exception as e:
        print(f"\n❌ ERRO ao conectar: {e}")
        return
    
    # Verificar/criar tabela
    cur.execute("""
        SELECT EXISTS (
            SELECT FROM information_schema.tables 
            WHERE table_name = 'indicator_metadata'
        );
    """)
    
    if not cur.fetchone()[0]:
        print("⚠️  Tabela não existe. Criando...")
        cur.execute("""
            CREATE TABLE indicator_metadata (
                id SERIAL PRIMARY KEY,
                indicator_code VARCHAR(50) UNIQUE NOT NULL,
                dimension VARCHAR(50) NOT NULL,
                name VARCHAR(200) NOT NULL,
                description TEXT,
                unit VARCHAR(50),
                source VARCHAR(200),
                methodology TEXT,
                interpretation_guide TEXT,
                good_range JSONB,
                alert_range JSONB,
                created_at TIMESTAMP DEFAULT NOW(),
                updated_at TIMESTAMP DEFAULT NOW()
            );
        """)
        conn.commit()
        print("✓ Tabela criada\n")
    
    # Inserir metadados
    print("Inserindo metadados...\n")
    success_count = 0
    
    for metadata in METADATA:
        try:
            cur.execute("""
                INSERT INTO indicator_metadata (
                    indicator_code, dimension, name, description, unit,
                    source, methodology, interpretation_guide, 
                    good_range, alert_range
                ) VALUES (
                    %(indicator_code)s, %(dimension)s, %(name)s, %(description)s, %(unit)s,
                    %(source)s, %(methodology)s, %(interpretation_guide)s,
                    %(good_range)s, %(alert_range)s
                )
                ON CONFLICT (indicator_code) DO UPDATE SET
                    dimension = EXCLUDED.dimension,
                    name = EXCLUDED.name,
                    description = EXCLUDED.description,
                    unit = EXCLUDED.unit,
                    source = EXCLUDED.source,
                    methodology = EXCLUDED.methodology,
                    interpretation_guide = EXCLUDED.interpretation_guide,
                    good_range = EXCLUDED.good_range,
                    alert_range = EXCLUDED.alert_range,
                    updated_at = NOW();
            """, {
                "indicator_code": metadata["indicator_code"],
                "dimension": metadata["dimension"],
                "name": metadata["name"],
                "description": metadata["description"],
                "unit": metadata["unit"],
                "source": metadata["source"],
                "methodology": metadata["methodology"],
                "interpretation_guide": metadata["interpretation_guide"],
                "good_range": Json(metadata["good_range"]),
                "alert_range": Json(metadata["alert_range"])
            })
            success_count += 1
            print(f"  ✓ {metadata['indicator_code']}")
        except Exception as e:
            print(f"  ✗ {metadata['indicator_code']}: {e}")
    
    conn.commit()
    
    # Verificar resultado
    cur.execute("SELECT COUNT(*) FROM indicator_metadata;")
    total = cur.fetchone()[0]
    
    cur.close()
    conn.close()
    
    print("\n" + "=" * 70)
    print("CONCLUÍDO!")
    print("=" * 70)
    print(f"\n✓ Inseridos com sucesso: {success_count}/{len(METADATA)}")
    print(f"✓ Total na tabela: {total}")
    print("\n🎉 Metadados prontos para uso no dashboard!")
    print("=" * 70)

if __name__ == "__main__":
    main()
