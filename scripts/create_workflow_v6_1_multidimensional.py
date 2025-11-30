#!/usr/bin/env python3
"""
Script para gerar Workflow V6.1 do Agente ECON
Adiciona consulta multidimensional expandida ao V6
"""

import json
import sys

# Carregar workflow V6 base
with open('n8n/workflows/WF-AGENT-ECON-Especialista-Economico-V6-WITH-MEMORY.json', 'r', encoding='utf-8') as f:
    workflow = json.load(f)

# Atualizar metadados do workflow
workflow['name'] = 'WF-AGENT-ECON - Especialista Econômico V6.1 (Multidimensional)'
workflow['meta']['instanceId'] = 'v6.1-multidimensional-' + workflow['meta'].get('instanceId', 'unknown')

# Carregar query SQL multidimensional
with open('n8n/code-snippets/consultar_dados_multidimensional_v1.sql', 'r', encoding='utf-8') as f:
    multidimensional_query = f.read()

# Carregar código JavaScript do contexto V4
with open('n8n/code-snippets/preparar_contexto_llm_v4_multidimensional.js', 'r', encoding='utf-8') as f:
    context_code_v4 = f.read()

# Atualizar nó "Consultar Dados PostgreSQL" com query multidimensional
for node in workflow['nodes']:
    if node['name'] == 'Consultar Dados PostgreSQL':
        node['parameters']['query'] = multidimensional_query
        node['notes'] = '''Consulta MULTIDIMENSIONAL expandida que traz:
- Dados econômicos (PIB, emprego, finanças)
- Dados sociais (educação, pobreza, saneamento)
- Dados territoriais (infraestrutura, conectividade)
- Dados ambientais (uso do solo, clima, desmatamento)

Esta abordagem permite análise econômica contextualizada e profunda.'''
        print(f"✅ Nó '{node['name']}' atualizado com query multidimensional")
    
    elif node['name'] == 'Preparar Contexto para LLM':
        node['name'] = 'Preparar Contexto para LLM (V4 Multidimensional)'
        node['parameters']['jsCode'] = context_code_v4
        node['notes'] = '''Versão 4.0 - MULTIDIMENSIONAL

Processa dados de 4 dimensões:
1. Econômica (principal)
2. Social (contexto)
3. Territorial (infraestrutura)
4. Ambiental (agropecuária)

Integra memória RAG (Camadas 1, 2, 4) para análise evolutiva.

Gera prompt estruturado que instrui o LLM a:
- Usar TODOS os dados disponíveis
- Identificar interconexões entre dimensões
- Comparar com análises anteriores
- Aplicar aprendizados acumulados
- Focar em insights acionáveis'''
        print(f"✅ Nó '{node['name']}' atualizado para V4 Multidimensional")

# Salvar workflow V6.1
output_path = 'n8n/workflows/WF-AGENT-ECON-Especialista-Economico-V6.1-MULTIDIMENSIONAL.json'
with open(output_path, 'w', encoding='utf-8') as f:
    json.dump(workflow, f, indent=2, ensure_ascii=False)

print(f"\n✅ Workflow V6.1 gerado com sucesso!")
print(f"📁 Arquivo: {output_path}")
print(f"\n🎯 Mudanças aplicadas:")
print(f"  1. Query SQL expandida para consulta multidimensional")
print(f"  2. Código JavaScript V4 para processar dados multidimensionais")
print(f"  3. Prompt enriquecido com instruções de análise integrada")
print(f"\n🚀 O Agente ECON agora realiza análises econômicas contextualizadas!")

