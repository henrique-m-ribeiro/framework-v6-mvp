#!/usr/bin/env python3
"""
Script de exemplo para análise dos dados exportados
Dashboard de Inteligência Territorial - Tocantins

Dependências necessárias:
    pip install pandas matplotlib seaborn
"""

import pandas as pd
import os

# Configurar caminho base
BASE_PATH = os.path.dirname(__file__)

def carregar_dados():
    """Carrega todos os CSVs exportados"""
    print("📊 Carregando dados...")
    
    dados = {
        'territorios': pd.read_csv(f'{BASE_PATH}/territories.csv'),
        'economico': pd.read_csv(f'{BASE_PATH}/economic_indicators.csv'),
        'social': pd.read_csv(f'{BASE_PATH}/social_indicators.csv'),
        'territorial': pd.read_csv(f'{BASE_PATH}/territorial_indicators.csv'),
        'ambiental': pd.read_csv(f'{BASE_PATH}/environmental_indicators.csv'),
        'metadados': pd.read_csv(f'{BASE_PATH}/indicator_metadata.csv')
    }
    
    print(f"✅ Dados carregados com sucesso!")
    print(f"   - {len(dados['territorios'])} territórios")
    print(f"   - {len(dados['economico'])} registros econômicos")
    print(f"   - {len(dados['social'])} registros sociais")
    print(f"   - {len(dados['territorial'])} registros territoriais")
    print(f"   - {len(dados['ambiental'])} registros ambientais")
    print(f"   - {len(dados['metadados'])} indicadores documentados\n")
    
    return dados

def analise_basica(dados):
    """Análises estatísticas básicas"""
    print("=" * 60)
    print("📈 ANÁLISE BÁSICA DOS DADOS")
    print("=" * 60 + "\n")
    
    # Territórios
    print("🗺️  TERRITÓRIOS:")
    print(f"   Total: {len(dados['territorios'])}")
    print(f"   Estados: {len(dados['territorios'][dados['territorios']['type'] == 'Estado'])}")
    print(f"   Municípios: {len(dados['territorios'][dados['territorios']['type'] == 'Município'])}\n")
    
    # Indicadores Econômicos
    eco = dados['economico']
    print("💰 INDICADORES ECONÔMICOS (últimos dados):")
    ultimo_ano = eco['year'].max()
    eco_recente = eco[eco['year'] == ultimo_ano]
    print(f"   Ano: {ultimo_ano}")
    print(f"   PIB médio: R$ {eco_recente['pib'].mean():.2f} milhões")
    print(f"   PIB per capita médio: R$ {eco_recente['pib_per_capita'].mean():.2f}")
    print(f"   Taxa de emprego média: {eco_recente['taxa_emprego'].mean():.1f}%\n")
    
    # Indicadores Sociais
    soc = dados['social']
    soc_recente = soc[soc['year'] == ultimo_ano]
    print("👥 INDICADORES SOCIAIS (últimos dados):")
    print(f"   IDH médio: {soc_recente['idh'].mean():.3f}")
    print(f"   População total: {soc_recente['populacao'].sum():,.0f} habitantes")
    print(f"   Expectativa de vida média: {soc_recente['expectativa_vida'].mean():.1f} anos\n")
    
    # Indicadores Ambientais
    amb = dados['ambiental']
    amb_recente = amb[amb['year'] == ultimo_ano]
    print("🌳 INDICADORES AMBIENTAIS (últimos dados):")
    print(f"   Cobertura vegetal média: {amb_recente['cobertura_vegetal_pct'].mean():.1f}%")
    print(f"   Qualidade do ar média: {amb_recente['qualidade_ar'].mean():.1f}/100")
    print(f"   Emissões CO2 totais: {amb_recente['emissoes_co2_ton'].sum():,.0f} toneladas\n")

def top_municipios(dados):
    """Ranking dos principais municípios"""
    print("=" * 60)
    print("🏆 TOP 5 MUNICÍPIOS POR INDICADOR")
    print("=" * 60 + "\n")
    
    ultimo_ano = dados['economico']['year'].max()
    
    # Merge dados
    df = dados['territorios'].merge(
        dados['economico'][dados['economico']['year'] == ultimo_ano],
        left_on='id', right_on='territory_id', how='inner'
    )
    
    # Top PIB
    print("💰 Maior PIB:")
    top_pib = df.nlargest(5, 'pib')[['name', 'pib']]
    for idx, row in top_pib.iterrows():
        print(f"   {row['name']}: R$ {row['pib']:.2f} milhões")
    
    print("\n💵 Maior PIB per capita:")
    top_per_capita = df.nlargest(5, 'pib_per_capita')[['name', 'pib_per_capita']]
    for idx, row in top_per_capita.iterrows():
        print(f"   {row['name']}: R$ {row['pib_per_capita']:.2f}")
    
    # Merge indicadores sociais
    df_social = dados['territorios'].merge(
        dados['social'][dados['social']['year'] == ultimo_ano],
        left_on='id', right_on='territory_id', how='inner'
    )
    
    print("\n📚 Maior IDH:")
    top_idh = df_social.nlargest(5, 'idh')[['name', 'idh']]
    for idx, row in top_idh.iterrows():
        print(f"   {row['name']}: {row['idh']:.3f}")
    
    print()

def evolucao_temporal(dados):
    """Análise de evolução temporal"""
    print("=" * 60)
    print("📊 EVOLUÇÃO TEMPORAL (2019-2023)")
    print("=" * 60 + "\n")
    
    # PIB ao longo dos anos
    eco = dados['economico']
    pib_anual = eco.groupby('year')['pib'].sum()
    
    print("💰 Evolução do PIB Total:")
    for ano, valor in pib_anual.items():
        print(f"   {ano}: R$ {valor:,.2f} milhões")
    
    crescimento = ((pib_anual.iloc[-1] / pib_anual.iloc[0]) - 1) * 100
    print(f"\n   📈 Crescimento total: {crescimento:+.1f}%")
    print()

def main():
    """Função principal"""
    print("\n" + "=" * 60)
    print("🎯 ANÁLISE DE DADOS - DASHBOARD TERRITORIAL TOCANTINS")
    print("=" * 60 + "\n")
    
    # Carregar dados
    dados = carregar_dados()
    
    # Executar análises
    analise_basica(dados)
    top_municipios(dados)
    evolucao_temporal(dados)
    
    print("=" * 60)
    print("✅ Análise concluída!")
    print("=" * 60 + "\n")
    
    print("💡 Dicas:")
    print("   - Use pandas para análises mais profundas")
    print("   - Importe matplotlib/seaborn para gráficos")
    print("   - Consulte indicator_metadata.csv para entender cada indicador")
    print()

if __name__ == "__main__":
    main()
