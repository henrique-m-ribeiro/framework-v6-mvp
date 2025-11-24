#!/usr/bin/env python3
"""
Script 2: Gerar Metadados com IA
Framework V6.0 - Popular indicator_metadata

Este script usa GPT-4 para gerar metadados completos para cada indicador.

Requisitos:
- pip install openai
- export OPENAI_API_KEY="sua-chave"

Uso: python3 02_generate_metadata.py
"""

import json
import os
from openai import OpenAI

def generate_metadata_for_indicator(client, indicator):
    """Gera metadados para um único indicador usando GPT-4"""
    
    prompt = f"""
Crie metadados completos para este indicador brasileiro usado em análise territorial:

Código: {indicator["code"]}
Nome: {indicator["name"]}
Dimensão: {indicator["dimension"]}
Unidade: {indicator["unit"]}

Retorne APENAS um JSON válido (sem markdown, sem explicações) com esta estrutura:
{{
  "indicator_code": "{indicator["code"]}",
  "dimension": "{indicator["dimension"]}",
  "name": "nome completo e descritivo em português",
  "description": "descrição clara e objetiva em 2-3 frases, explicando o que o indicador mede e sua importância",
  "unit": "{indicator["unit"]}",
  "source": "fonte oficial dos dados (IBGE, SICONFI, DataSUS, INEP, INPE, MapBiomas, etc.)",
  "methodology": "explicação de como o indicador é calculado ou coletado",
  "interpretation_guide": "guia de como interpretar os valores (ex: faixas de referência, o que é considerado bom/ruim)",
  "good_range": {{"min": X, "max": Y}},
  "alert_range": {{"min": X, "max": Y}}
}}

Observações importantes:
- Use dados e metodologias reais do Brasil
- Para good_range e alert_range, use valores numéricos realistas baseados em padrões brasileiros
- Se o indicador for "quanto menor, melhor" (ex: mortalidade infantil), ajuste os ranges adequadamente
- Seja preciso e técnico, mas mantenha a linguagem acessível
"""
    
    try:
        response = client.chat.completions.create(
            model="gpt-4",
            messages=[{"role": "user", "content": prompt}],
            temperature=0.3,
            max_tokens=800
        )
        
        content = response.choices[0].message.content.strip()
        
        # Remover markdown se houver
        if content.startswith("```"):
            content = content.split("```")[1]
            if content.startswith("json"):
                content = content[4:]
            content = content.strip()
        
        metadata = json.loads(content)
        return metadata
        
    except json.JSONDecodeError as e:
        print(f"    ✗ Erro ao parsear JSON: {e}")
        print(f"    Resposta: {content[:200]}...")
        return None
    except Exception as e:
        print(f"    ✗ Erro: {e}")
        return None

def main():
    # Verificar API key
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        print("❌ ERRO: OPENAI_API_KEY não definida")
        print("Execute: export OPENAI_API_KEY='sua-chave'")
        return
    
    # Inicializar cliente OpenAI
    client = OpenAI(api_key=api_key)
    
    # Carregar lista de indicadores
    script_dir = os.path.dirname(os.path.abspath(__file__))
    input_file = os.path.join(script_dir, "indicators_list.json")
    output_file = os.path.join(script_dir, "indicator_metadata.json")
    
    if not os.path.exists(input_file):
        print(f"❌ ERRO: Arquivo {input_file} não encontrado")
        print("Execute primeiro: python3 01_extract_indicators.py")
        return
    
    with open(input_file, "r", encoding="utf-8") as f:
        indicators = json.load(f)
    
    print("=" * 60)
    print("GERAÇÃO DE METADADOS COM IA")
    print("=" * 60)
    print(f"\n📊 Total de indicadores: {len(indicators)}")
    print(f"🤖 Modelo: GPT-4")
    print(f"💰 Custo estimado: ~${len(indicators) * 0.002:.2f}")
    print("\n" + "=" * 60)
    
    input("\nPressione ENTER para iniciar a geração...")
    print()
    
    # Gerar metadados
    metadata_list = []
    success_count = 0
    
    for i, indicator in enumerate(indicators, 1):
        print(f"[{i}/{len(indicators)}] {indicator['code']} ({indicator['dimension']})...", end=" ")
        
        metadata = generate_metadata_for_indicator(client, indicator)
        
        if metadata:
            metadata_list.append(metadata)
            success_count += 1
            print("✓")
        else:
            print("✗ (pulado)")
    
    # Salvar resultados
    if metadata_list:
        with open(output_file, "w", encoding="utf-8") as f:
            json.dump(metadata_list, f, indent=2, ensure_ascii=False)
        
        print("\n" + "=" * 60)
        print("GERAÇÃO CONCLUÍDA")
        print("=" * 60)
        print(f"\n✓ Metadados gerados: {success_count}/{len(indicators)}")
        print(f"💾 Arquivo salvo: {output_file}")
        print("\n🔍 PRÓXIMO PASSO:")
        print("   1. Revise o arquivo indicator_metadata.json")
        print("   2. Ajuste manualmente se necessário")
        print("   3. Execute: python3 03_insert_metadata.py")
        print("=" * 60)
    else:
        print("\n❌ Nenhum metadado foi gerado com sucesso")

if __name__ == "__main__":
    main()
