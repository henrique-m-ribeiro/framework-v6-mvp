#!/usr/bin/env python3
"""
Script COMPLETO para Popular indicator_metadata no Replit
Framework V6.0 - Todos os 35 Indicadores

Execute no Replit: python3 POPULATE_METADATA_COMPLETE.py
"""

import os

# Metadados completos - TODOS OS 35 INDICADORES
METADATA = [
    # ========== JÁ INSERIDOS (21) ==========
    {
        "indicator_key": "gdp",
        "dimension": "economic",
        "indicator_name": "Produto Interno Bruto (PIB) Municipal",
        "description": "Soma de todos os bens e serviços finais produzidos por um município, a preços de mercado, em um determinado período. É um dos principais indicadores da atividade econômica local. Fonte: IBGE - Contas Regionais.",
        "unit": "R$ (milhões)",
        "interpretation_guide": "Valores mais altos indicam maior atividade econômica. O crescimento do PIB é um sinal de desenvolvimento econômico. Calculado pelo IBGE a partir da ótica da produção, somando os valores adicionados brutos dos setores."
    },
    {
        "indicator_key": "gdp_per_capita",
        "dimension": "economic",
        "indicator_name": "PIB per capita",
        "description": "PIB do município dividido pela sua população total. Mede a riqueza média por habitante, indicando o nível de desenvolvimento econômico. Fonte: IBGE - Contas Regionais.",
        "unit": "R$",
        "interpretation_guide": "Valores mais altos sugerem maior riqueza por habitante. Comparar com a média estadual (R$ 25.000) e nacional (R$ 40.000) ajuda a entender a posição do município. Acima de R$ 30.000 é considerado bom."
    },
    {
        "indicator_key": "employment_rate",
        "dimension": "economic",
        "indicator_name": "Taxa de Ocupação Formal",
        "description": "Percentual da população em idade ativa (18-65 anos) que possui um emprego com carteira assinada. Mede a formalidade do mercado de trabalho. Fonte: MTE - RAIS.",
        "unit": "%",
        "interpretation_guide": "Taxas acima de 40% indicam um mercado de trabalho formal e estável. Taxas abaixo de 20% podem indicar alta informalidade ou desemprego. Calculado como: (vínculos formais / população 18-65) × 100."
    },
    {
        "indicator_key": "revenue",
        "dimension": "economic",
        "indicator_name": "Receita Total do Município",
        "description": "Soma de todas as receitas arrecadadas pelo município, incluindo tributos, transferências e outras fontes. Indica a capacidade financeira da gestão municipal. Fonte: SICONFI - Tesouro Nacional.",
        "unit": "R$",
        "interpretation_guide": "Receitas maiores permitem mais investimentos em serviços públicos. A dependência de transferências é um fator importante a ser analisado. Municípios com receita acima de R$ 50 milhões têm maior capacidade de investimento."
    },
    {
        "indicator_key": "sector_servicos",
        "dimension": "economic",
        "indicator_name": "Participação do Setor de Serviços no PIB",
        "description": "Percentual do PIB municipal proveniente do setor de serviços (comércio, educação, saúde, administração pública, etc.). Indica o grau de desenvolvimento econômico. Fonte: IBGE.",
        "unit": "%",
        "interpretation_guide": "Economias mais desenvolvidas tendem a ter maior participação de serviços (acima de 60%). Valores entre 40-60% indicam economia em transição. Abaixo de 40% sugere economia mais agrícola."
    },
    {
        "indicator_key": "sector_industria",
        "dimension": "economic",
        "indicator_name": "Participação do Setor Industrial no PIB",
        "description": "Percentual do PIB municipal proveniente da indústria (transformação, construção, energia). Indica o nível de industrialização. Fonte: IBGE.",
        "unit": "%",
        "interpretation_guide": "Valores acima de 30% indicam forte presença industrial. Entre 15-30% é moderado. Abaixo de 15% sugere baixa industrialização. A indústria gera empregos de maior qualificação."
    },
    {
        "indicator_key": "sector_agricultura",
        "dimension": "economic",
        "indicator_name": "Participação do Setor Agrícola no PIB",
        "description": "Percentual do PIB municipal proveniente da agropecuária (agricultura, pecuária, silvicultura, pesca). Indica a importância do setor primário. Fonte: IBGE.",
        "unit": "%",
        "interpretation_guide": "Valores acima de 30% indicam economia fortemente agrícola. Entre 10-30% é moderado. Abaixo de 10% sugere economia mais urbana. O setor agrícola é sensível a clima e preços."
    },
    {
        "indicator_key": "idhm",
        "dimension": "social",
        "indicator_name": "Índice de Desenvolvimento Humano Municipal (IDH-M)",
        "description": "Medida composta que avalia o desenvolvimento humano em três dimensões: longevidade (saúde), educação e renda. Fonte: PNUD / IPEA / FJP.",
        "unit": "índice (0-1)",
        "interpretation_guide": "0-0.499: Muito Baixo | 0.500-0.599: Baixo | 0.600-0.699: Médio | 0.700-0.799: Alto | 0.800-1.000: Muito Alto. Quanto mais perto de 1, melhor. Calculado como média geométrica dos três subíndices."
    },
    {
        "indicator_key": "population",
        "dimension": "social",
        "indicator_name": "População Residente",
        "description": "Número total de habitantes residentes no município. Fonte: IBGE - Censo Demográfico e Estimativas Populacionais.",
        "unit": "habitantes",
        "interpretation_guide": "O crescimento ou declínio da população impacta a demanda por serviços públicos e a dinâmica econômica. Municípios com mais de 100 mil habitantes são considerados de médio porte."
    },
    {
        "indicator_key": "literacy_rate",
        "dimension": "social",
        "indicator_name": "Taxa de Alfabetização",
        "description": "Percentual de pessoas de 15 anos ou mais de idade que sabem ler e escrever pelo menos um bilhete simples. Fonte: IBGE - Censo Demográfico.",
        "unit": "%",
        "interpretation_guide": "Taxas acima de 95% indicam boa cobertura educacional. Entre 85-95% é moderado. Abaixo de 85% indica desafios educacionais. O ideal é se aproximar de 100%."
    },
    {
        "indicator_key": "income_per_capita",
        "dimension": "social",
        "indicator_name": "Renda per capita",
        "description": "Soma da renda de todos os indivíduos de um domicílio, dividida pelo número de seus moradores. Mede o nível médio de renda da população. Fonte: IBGE - Censo Demográfico.",
        "unit": "R$",
        "interpretation_guide": "Valores acima de R$ 1.500 indicam boa condição de vida. Entre R$ 700-1.500 é moderado. Abaixo de R$ 700 indica vulnerabilidade social. É um componente importante do IDH-M."
    },
    {
        "indicator_key": "ideb_anos_iniciais",
        "dimension": "social",
        "indicator_name": "IDEB - Anos Iniciais do Ensino Fundamental",
        "description": "Índice de Desenvolvimento da Educação Básica para os anos iniciais (1º ao 5º ano). Combina aprovação escolar e desempenho em português e matemática. Fonte: INEP/MEC.",
        "unit": "nota (0-10)",
        "interpretation_guide": "Acima de 6.0: Bom | 5.0-6.0: Adequado | 4.0-5.0: Alerta | Abaixo de 4.0: Crítico. A meta nacional para 2021 era 6.0. Quanto maior, melhor a qualidade do ensino."
    },
    {
        "indicator_key": "ideb_anos_finais",
        "dimension": "social",
        "indicator_name": "IDEB - Anos Finais do Ensino Fundamental",
        "description": "Índice de Desenvolvimento da Educação Básica para os anos finais (6º ao 9º ano). Combina aprovação escolar e desempenho em português e matemática. Fonte: INEP/MEC.",
        "unit": "nota (0-10)",
        "interpretation_guide": "Acima de 5.5: Bom | 4.5-5.5: Adequado | 3.5-4.5: Alerta | Abaixo de 3.5: Crítico. A meta nacional para 2021 era 5.5. Geralmente é menor que anos iniciais."
    },
    {
        "indicator_key": "expectativa_vida",
        "dimension": "social",
        "indicator_name": "Expectativa de Vida ao Nascer",
        "description": "Número médio de anos que uma pessoa nascida no município pode esperar viver, considerando as taxas de mortalidade atuais. Fonte: IBGE / DataSUS.",
        "unit": "anos",
        "interpretation_guide": "Acima de 75 anos: Muito Bom | 70-75: Bom | 65-70: Moderado | Abaixo de 65: Preocupante. A média brasileira é cerca de 76 anos. Reflete qualidade de vida e saúde."
    },
    {
        "indicator_key": "cobertura_vacinal",
        "dimension": "social",
        "indicator_name": "Cobertura Vacinal",
        "description": "Percentual da população-alvo que recebeu as vacinas do calendário básico de imunização. Mede a efetividade dos programas de saúde preventiva. Fonte: DataSUS / SI-PNI.",
        "unit": "%",
        "interpretation_guide": "Acima de 95%: Ótimo (imunidade de rebanho) | 80-95%: Adequado | 70-80%: Alerta | Abaixo de 70%: Crítico (risco de surtos). A meta do Ministério da Saúde é 95%."
    },
    {
        "indicator_key": "mortalidade_infantil",
        "dimension": "social",
        "indicator_name": "Taxa de Mortalidade Infantil",
        "description": "Número de óbitos de crianças menores de 1 ano de idade a cada 1.000 nascidos vivos. Indica a qualidade dos serviços de saúde materno-infantil. Fonte: DataSUS / SIM.",
        "unit": "por 1.000 nascidos vivos",
        "interpretation_guide": "Abaixo de 10: Muito Bom | 10-15: Bom | 15-20: Moderado | Acima de 20: Preocupante. A média brasileira é cerca de 12. Quanto menor, melhor. ODS 3 meta: abaixo de 12."
    },
    {
        "indicator_key": "leitos_por_mil_habitantes",
        "dimension": "social",
        "indicator_name": "Leitos Hospitalares por Mil Habitantes",
        "description": "Número de leitos hospitalares (públicos e privados) disponíveis para cada 1.000 habitantes. Mede a capacidade de atendimento hospitalar. Fonte: DataSUS / CNES.",
        "unit": "leitos/1.000 hab",
        "interpretation_guide": "Acima de 3.0: Ótimo | 2.0-3.0: Adequado | 1.5-2.0: Moderado | Abaixo de 1.5: Insuficiente. A OMS recomenda mínimo de 2.5. Inclui leitos SUS e privados."
    },
    {
        "indicator_key": "density",
        "dimension": "territorial",
        "indicator_name": "Densidade Demográfica",
        "description": "População total do município dividida pela sua área territorial. Mede a concentração de pessoas no território. Fonte: IBGE.",
        "unit": "hab/km²",
        "interpretation_guide": "Acima de 500: Alta densidade (urbano) | 100-500: Moderada | 50-100: Baixa | Abaixo de 50: Muito baixa (rural). Altas densidades indicam pressão sobre infraestrutura."
    },
    {
        "indicator_key": "sanitation_coverage",
        "dimension": "territorial",
        "indicator_name": "Cobertura de Saneamento Básico",
        "description": "Percentual da população com acesso a água tratada, esgotamento sanitário adequado e coleta de lixo. Indicador composto de infraestrutura básica. Fonte: IBGE / SNIS.",
        "unit": "%",
        "interpretation_guide": "Acima de 90%: Ótimo | 75-90%: Bom | 50-75%: Moderado | Abaixo de 50%: Crítico. O Novo Marco do Saneamento estabelece meta de 90% até 2033."
    },
    {
        "indicator_key": "deforested_area",
        "dimension": "environmental",
        "indicator_name": "Área Desmatada Acumulada",
        "description": "Total de área de vegetação nativa suprimida no município desde o início do monitoramento. Mede a pressão histórica sobre os ecossistemas. Fonte: INPE - PRODES.",
        "unit": "km²",
        "interpretation_guide": "O ideal é que este valor seja zero ou próximo. Valores altos indicam forte pressão ambiental histórica e perda de biodiversidade. Comparar com área total do município."
    },
    {
        "indicator_key": "vegetation_coverage",
        "dimension": "environmental",
        "indicator_name": "Cobertura Vegetal Nativa",
        "description": "Percentual da área do município coberta por vegetação nativa (floresta, cerrado, etc.). Indica o grau de preservação ambiental. Fonte: MapBiomas.",
        "unit": "%",
        "interpretation_guide": "Acima de 80%: Muito Preservado | 60-80%: Preservado | 40-60%: Moderado | 20-40%: Degradado | Abaixo de 20%: Muito Degradado. O Código Florestal exige mínimo de 20-80% dependendo do bioma."
    },
    
    # ========== NOVOS (14) ==========
    {
        "indicator_key": "taxa_conclusao_fundamental",
        "dimension": "social",
        "indicator_name": "Taxa de Conclusão do Ensino Fundamental",
        "description": "Percentual de alunos que concluem o ensino fundamental (9º ano) na idade esperada (até 16 anos). Mede a eficiência do fluxo escolar e a capacidade do sistema de reter os estudantes. Fonte: INEP - Censo Escolar.",
        "unit": "%",
        "interpretation_guide": "Acima de 80%: Bom | 60-80%: Moderado | 40-60%: Alerta | Abaixo de 40%: Crítico. Taxas baixas indicam evasão, reprovação ou distorção idade-série."
    },
    {
        "indicator_key": "taxa_conclusao_medio",
        "dimension": "social",
        "indicator_name": "Taxa de Conclusão do Ensino Médio",
        "description": "Percentual de jovens que concluem o ensino médio (3ª série) na idade esperada (até 19 anos). Indica o sucesso na retenção escolar e na transição para o ensino superior ou mercado de trabalho. Fonte: INEP - Censo Escolar.",
        "unit": "%",
        "interpretation_guide": "Acima de 70%: Bom | 50-70%: Moderado | 30-50%: Alerta | Abaixo de 30%: Crítico. O ensino médio tem historicamente as maiores taxas de evasão no Brasil."
    },
    {
        "indicator_key": "urbanized_area",
        "dimension": "territorial",
        "indicator_name": "Área Urbanizada",
        "description": "Percentual da área total do município que é considerada área urbana consolidada, incluindo infraestrutura viária, edificações e equipamentos públicos. Fonte: IBGE / MapBiomas.",
        "unit": "%",
        "interpretation_guide": "Varia muito conforme o perfil do município. Em cidades metropolitanas pode ser >80%. Em municípios rurais, <10%. Não há um valor ideal universal."
    },
    {
        "indicator_key": "land_use_agricultura",
        "dimension": "territorial",
        "indicator_name": "Uso do Solo: Agricultura",
        "description": "Percentual da área do município destinada à agricultura (lavouras temporárias e permanentes). Indica a vocação agrícola e a pressão sobre o meio ambiente. Fonte: MapBiomas.",
        "unit": "%",
        "interpretation_guide": "Importante para entender a economia local e o impacto ambiental. Altos valores podem indicar conversão de áreas naturais. Comparar com uso florestal e de pastagem."
    },
    {
        "indicator_key": "land_use_pecuaria",
        "dimension": "territorial",
        "indicator_name": "Uso do Solo: Pecuária",
        "description": "Percentual da área do município destinada à pastagem para pecuária (bovina, ovina, etc.). Fonte: MapBiomas.",
        "unit": "%",
        "interpretation_guide": "Grandes áreas de pastagem podem indicar desmatamento histórico, especialmente em regiões de floresta. No Cerrado e Pampa, é mais comum. Comparar com cobertura vegetal nativa."
    },
    {
        "indicator_key": "land_use_florestal",
        "dimension": "territorial",
        "indicator_name": "Uso do Solo: Florestal",
        "description": "Percentual da área do município com cobertura florestal, incluindo vegetação nativa (floresta primária e secundária) e plantações florestais (eucalipto, pinus). Fonte: MapBiomas.",
        "unit": "%",
        "interpretation_guide": "Essencial para análise ambiental e cumprimento do Código Florestal. Valores altos indicam preservação ou vocação para silvicultura. Distinguir entre floresta nativa e plantada é importante."
    },
    {
        "indicator_key": "land_use_urbano",
        "dimension": "territorial",
        "indicator_name": "Uso do Solo: Urbano",
        "description": "Percentual da área do município com mancha urbana (áreas construídas, vias, praças, etc.). Fonte: MapBiomas.",
        "unit": "%",
        "interpretation_guide": "Similar a `urbanized_area`, mas com metodologia de sensoriamento remoto. Geralmente é um valor pequeno (<5%) mesmo em cidades médias, pois a área urbana é concentrada."
    },
    {
        "indicator_key": "water_quality",
        "dimension": "environmental",
        "indicator_name": "Índice de Qualidade da Água (IQA)",
        "description": "Indicador que avalia a qualidade dos corpos d'água do município, baseado em parâmetros físico-químicos (pH, oxigênio dissolvido, turbidez, etc.) e biológicos (coliformes). Fonte: Agência Nacional de Águas (ANA) / Agências Estaduais.",
        "unit": "índice (0-100)",
        "interpretation_guide": "80-100: Ótima | 52-79: Boa | 37-51: Razoável | 20-36: Ruim | 0-19: Péssima. Valores baixos indicam poluição por esgoto, agrotóxicos ou resíduos industriais."
    },
    {
        "indicator_key": "co2_emissions",
        "dimension": "environmental",
        "indicator_name": "Emissões de CO2 (Dióxido de Carbono)",
        "description": "Total de emissões de gases de efeito estufa (GEE) em toneladas de CO2 equivalente. Inclui energia, indústria, agropecuária, mudança de uso da terra e desmatamento. Fonte: SEEG (Sistema de Estimativas de Emissões e Remoções de Gases de Efeito Estufa).",
        "unit": "tCO2e",
        "interpretation_guide": "Valores altos indicam grande contribuição para o aquecimento global. Comparar emissões per capita (tCO2e/habitante) é mais justo. A média brasileira é ~7 tCO2e/hab. Desmatamento é a principal fonte em municípios amazônicos."
    },
    {
        "indicator_key": "paved_roads_pct",
        "dimension": "territorial",
        "indicator_name": "Percentual de Vias Pavimentadas",
        "description": "Percentual de vias públicas na área urbana que possuem pavimentação (asfalto, concreto, paralelepípedo). Indica a qualidade da infraestrutura viária urbana. Fonte: IBGE - Pesquisa de Informações Básicas Municipais (MUNIC).",
        "unit": "%",
        "interpretation_guide": "Acima de 90%: Ótimo | 70-90%: Bom | 50-70%: Moderado | Abaixo de 50%: Déficit de infraestrutura. Vias pavimentadas melhoram mobilidade e reduzem poeira."
    },
    {
        "indicator_key": "street_lighting_pct",
        "dimension": "territorial",
        "indicator_name": "Percentual de Domicílios com Iluminação Pública",
        "description": "Percentual de domicílios urbanos localizados em ruas com iluminação pública. Fonte: IBGE - Censo Demográfico.",
        "unit": "%",
        "interpretation_guide": "Ideal é 100%. Acima de 95%: Bom | 85-95%: Moderado | Abaixo de 85%: Falhas na infraestrutura. Iluminação pública melhora segurança e qualidade de vida."
    },
    {
        "indicator_key": "internet_access_pct",
        "dimension": "territorial",
        "indicator_name": "Percentual de Domicílios com Acesso à Internet",
        "description": "Percentual de domicílios particulares permanentes com acesso à internet (banda larga fixa, móvel 3G/4G/5G ou via satélite). Fonte: IBGE - Censo Demográfico / PNAD Contínua.",
        "unit": "%",
        "interpretation_guide": "Acima de 80%: Bom | 60-80%: Moderado | 40-60%: Baixo | Abaixo de 40%: Exclusão digital. Acesso à internet é essencial para educação, trabalho e serviços digitais."
    },
    {
        "indicator_key": "mobile_coverage_pct",
        "dimension": "territorial",
        "indicator_name": "Cobertura de Telefonia Móvel",
        "description": "Percentual da área do município com cobertura de pelo menos uma operadora de telefonia móvel (2G, 3G, 4G ou 5G). Fonte: ANATEL.",
        "unit": "%",
        "interpretation_guide": "Acima de 95%: Ótimo | 80-95%: Bom | 60-80%: Moderado | Abaixo de 60%: Áreas de sombra e exclusão. Cobertura móvel é essencial para comunicação e acesso a serviços."
    },
    {
        "indicator_key": "protected_areas_pct",
        "dimension": "environmental",
        "indicator_name": "Percentual de Áreas Protegidas",
        "description": "Percentual da área do município que está dentro de Unidades de Conservação (UCs) federais, estaduais ou municipais, ou Terras Indígenas (TIs). Fonte: Ministério do Meio Ambiente (MMA) / FUNAI / ICMBio.",
        "unit": "%",
        "interpretation_guide": "Importante para conservação da biodiversidade e serviços ecossistêmicos. Não há um valor 'bom' ou 'ruim' universal, depende da localização e do bioma. Valores altos podem restringir atividades econômicas, mas garantem preservação."
    }
]

def main():
    print("=" * 70)
    print("POPULAR TABELA indicator_metadata - VERSÃO COMPLETA")
    print("=" * 70)
    print(f"\n📊 Total de metadados: {len(METADATA)}")
    print("🎯 Cobertura: 100% dos indicadores")
    
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
    
    # Garantir constraint única
    try:
        cur.execute("ALTER TABLE indicator_metadata DROP CONSTRAINT IF EXISTS indicator_metadata_indicator_key_key;")
        cur.execute("ALTER TABLE indicator_metadata ADD CONSTRAINT indicator_metadata_indicator_key_key UNIQUE (indicator_key);")
        conn.commit()
    except:
        conn.rollback()
    
    # Inserir metadados
    print("Inserindo metadados...\n")
    success_count = 0
    update_count = 0
    error_count = 0
    
    for metadata in METADATA:
        try:
            cur.execute("""
                INSERT INTO indicator_metadata (
                    indicator_key, dimension, indicator_name, description, unit, interpretation_guide
                ) VALUES (
                    %(indicator_key)s, %(dimension)s, %(indicator_name)s, %(description)s, %(unit)s, %(interpretation_guide)s
                )
                ON CONFLICT (indicator_key) DO UPDATE SET
                    dimension = EXCLUDED.dimension,
                    indicator_name = EXCLUDED.indicator_name,
                    description = EXCLUDED.description,
                    unit = EXCLUDED.unit,
                    interpretation_guide = EXCLUDED.interpretation_guide;
            """, metadata)
            
            # Verificar se foi insert ou update
            if cur.rowcount == 1:
                success_count += 1
                print(f"  ✓ {metadata['indicator_key']}")
            else:
                update_count += 1
                print(f"  ↻ {metadata['indicator_key']} (atualizado)")
                
        except Exception as e:
            error_count += 1
            print(f"  ✗ {metadata['indicator_key']}: {e}")
            conn.rollback()
    
    conn.commit()
    
    # Verificar resultado
    cur.execute("SELECT COUNT(*) FROM indicator_metadata;")
    total = cur.fetchone()[0]
    
    # Estatísticas por dimensão
    cur.execute("""
        SELECT dimension, COUNT(*) as count 
        FROM indicator_metadata 
        GROUP BY dimension 
        ORDER BY dimension;
    """)
    by_dimension = cur.fetchall()
    
    cur.close()
    conn.close()
    
    print("\n" + "=" * 70)
    print("CONCLUÍDO!")
    print("=" * 70)
    print(f"\n✓ Novos inseridos: {success_count}")
    print(f"↻ Atualizados: {update_count}")
    if error_count > 0:
        print(f"✗ Erros: {error_count}")
    print(f"\n📊 Total na tabela: {total}")
    print(f"\n📈 Por dimensão:")
    for dimension, count in by_dimension:
        print(f"  • {dimension}: {count}")
    print("\n🎉 100% dos metadados prontos para uso no dashboard!")
    print("=" * 70)

if __name__ == "__main__":
    main()
