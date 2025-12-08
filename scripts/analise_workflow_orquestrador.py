#!/usr/bin/env python3
"""
Script para analisar o workflow do Orquestrador e identificar problemas de salvamento.
Sessão #13 - Framework de Inteligência Territorial V6.0
"""

import json
import sys

def analisar_workflow_orquestrador(caminho_arquivo):
    """Analisa o workflow do Orquestrador para identificar problemas."""
    
    with open(caminho_arquivo, 'r', encoding='utf-8') as f:
        workflow = json.load(f)
    
    print("=" * 80)
    print("ANÁLISE DO WORKFLOW DO ORQUESTRADOR V3.2")
    print("=" * 80)
    print()
    
    # 1. Identificar todos os nós
    nodes = workflow.get('nodes', [])
    print(f"📊 Total de nós no workflow: {len(nodes)}")
    print()
    
    # 2. Listar todos os nós
    print("📋 LISTA DE NÓS:")
    print("-" * 80)
    for i, node in enumerate(nodes, 1):
        print(f"{i:2d}. {node.get('name')} ({node.get('type')})")
    print()
    
    # 3. Analisar o nó de salvamento na knowledge_base
    print("🔍 ANÁLISE DO NÓ: PostgreSQL - Salvar na Knowledge Base")
    print("-" * 80)
    
    no_kb = None
    for node in nodes:
        if 'PostgreSQL - Salvar na Knowledge Base' in node.get('name', ''):
            no_kb = node
            break
    
    if no_kb:
        query = no_kb.get('parameters', {}).get('query', '')
        print("✅ Nó encontrado!")
        print()
        print("📝 Query SQL:")
        print(query[:500] + "..." if len(query) > 500 else query)
        print()
        
        # Analisar as referências de dados
        print("🔎 REFERÊNCIAS DE DADOS NA QUERY:")
        print("-" * 80)
        
        referencias = [
            ("territory_id", "$('Webhook - Recebe Requisição').first().json.body.territory_id"),
            ("dimension", "$json.dimension"),
            ("analysis_type", "$json.analysis_type"),
            ("content", "$json.analysis_content || $json.content"),
            ("summary", "$json.analysis_summary || $json.summary"),
            ("confidence_score", "$json.confidence_score"),
            ("data_sources", "$json.data_sources || $json.sources")
        ]
        
        for campo, ref in referencias:
            presente = ref in query or campo in query
            status = "✅" if presente else "❌"
            print(f"{status} {campo:20s} -> {ref}")
        
        print()
        
        # Identificar o problema
        print("🚨 PROBLEMA IDENTIFICADO:")
        print("-" * 80)
        print("O nó está tentando acessar $json.analysis_content e $json.dimension,")
        print("mas o $json está referenciando o contexto ERRADO!")
        print()
        print("❌ CONTEXTO ATUAL: $json (contexto do próprio nó)")
        print("✅ CONTEXTO CORRETO: Deve referenciar a resposta do HTTP Request")
        print()
        print("SOLUÇÃO:")
        print("Trocar todas as referências de:")
        print("  $json.campo")
        print("Para:")
        print("  $('HTTP Request - Chamar Agente ECON').first().json.campo")
        print("  (ou o agente correspondente que foi chamado)")
        
    else:
        print("❌ Nó não encontrado!")
    
    print()
    
    # 4. Analisar os nós HTTP Request
    print("🌐 ANÁLISE DOS NÓS HTTP REQUEST:")
    print("-" * 80)
    
    http_nodes = [n for n in nodes if 'HTTP Request' in n.get('name', '')]
    for node in http_nodes:
        name = node.get('name')
        params = node.get('parameters', {})
        response_format = params.get('options', {}).get('response', {}).get('response', {}).get('responseFormat', 'autodetect')
        
        print(f"📡 {name}")
        print(f"   Response Format: {response_format}")
        print()
    
    print()
    
    # 5. Analisar conexões
    print("🔗 ANÁLISE DE CONEXÕES:")
    print("-" * 80)
    
    connections = workflow.get('connections', {})
    
    # Encontrar o que está conectado ao nó de salvamento
    for source_node, targets in connections.items():
        for connection_type, connection_list in targets.items():
            for connection_group in connection_list:
                for connection in connection_group:
                    if 'PostgreSQL - Salvar na Knowledge Base' in connection.get('node', ''):
                        print(f"✅ {source_node} -> PostgreSQL - Salvar na Knowledge Base")
    
    print()
    print("=" * 80)
    print("FIM DA ANÁLISE")
    print("=" * 80)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Uso: python3 analise_workflow_orquestrador.py <caminho_workflow.json>")
        sys.exit(1)
    
    analisar_workflow_orquestrador(sys.argv[1])
