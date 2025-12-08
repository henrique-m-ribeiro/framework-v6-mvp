#!/usr/bin/env python3
"""
Script para analisar o workflow do Agente ECON e identificar problemas de salvamento na memória.
Sessão #13 - Framework de Inteligência Territorial V6.0
"""

import json
import sys

def analisar_workflow_econ(caminho_arquivo):
    """Analisa o workflow do Agente ECON para identificar problemas."""
    
    with open(caminho_arquivo, 'r', encoding='utf-8') as f:
        workflow = json.load(f)
    
    print("=" * 80)
    print("ANÁLISE DO WORKFLOW DO AGENTE ECON V6.1")
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
    
    # 3. Procurar nó de salvamento na memória
    print("🔍 PROCURANDO NÓ DE SALVAMENTO NA MEMÓRIA (agent_econ_memory):")
    print("-" * 80)
    
    no_memoria = None
    nos_postgres = []
    
    for node in nodes:
        if node.get('type') == 'n8n-nodes-base.postgres':
            nos_postgres.append(node)
            query = node.get('parameters', {}).get('query', '')
            if 'agent_econ_memory' in query.lower():
                no_memoria = node
    
    if no_memoria:
        print(f"✅ Nó de salvamento na memória ENCONTRADO: {no_memoria.get('name')}")
        print()
        print("📝 Query SQL:")
        query = no_memoria.get('parameters', {}).get('query', '')
        print(query[:800] if len(query) > 800 else query)
        print()
    else:
        print("❌ NÓ DE SALVAMENTO NA MEMÓRIA NÃO ENCONTRADO!")
        print()
        print("🔎 Nós PostgreSQL encontrados no workflow:")
        for i, node in enumerate(nos_postgres, 1):
            name = node.get('name')
            query = node.get('parameters', {}).get('query', '')
            tabela = "???"
            if 'FROM' in query.upper():
                # Tentar extrair nome da tabela
                parts = query.upper().split('FROM')
                if len(parts) > 1:
                    tabela = parts[1].split()[0].strip()
            elif 'INSERT INTO' in query.upper():
                parts = query.upper().split('INSERT INTO')
                if len(parts) > 1:
                    tabela = parts[1].split()[0].strip()
            
            print(f"  {i}. {name}")
            print(f"     Tabela: {tabela}")
            print()
        
        print()
        print("🚨 PROBLEMA IDENTIFICADO:")
        print("-" * 80)
        print("O workflow do Agente ECON NÃO TEM um nó para salvar na memória!")
        print()
        print("SOLUÇÃO:")
        print("1. Adicionar um novo nó 'PostgreSQL' após a geração da análise")
        print("2. Configurar INSERT INTO agent_econ_memory com os campos:")
        print("   - id (UUID)")
        print("   - agent_id ('econ')")
        print("   - territory_id")
        print("   - analysis_content")
        print("   - analysis_summary")
        print("   - confidence_score")
        print("   - metadata")
        print("   - time_range")
        print("   - data_sources")
        print("   - indicators_used")
        print("   - embedding_vector (NULL)")
        print("   - created_at")
        print("   - updated_at")
    
    print()
    
    # 4. Analisar fluxo de dados
    print("🔗 ANÁLISE DO FLUXO DE DADOS:")
    print("-" * 80)
    
    connections = workflow.get('connections', {})
    
    # Identificar o nó que gera a análise
    no_geracao = None
    for node in nodes:
        if 'OpenAI' in node.get('type', '') or 'langchain' in node.get('type', ''):
            if 'Gerar Análise' in node.get('name', ''):
                no_geracao = node
                break
    
    if no_geracao:
        print(f"✅ Nó de geração de análise: {no_geracao.get('name')}")
        print()
        
        # Ver o que está conectado a ele
        nome_no = no_geracao.get('name')
        if nome_no in connections:
            print(f"🔗 Conexões a partir de '{nome_no}':")
            for conn_type, conn_list in connections[nome_no].items():
                for conn_group in conn_list:
                    for conn in conn_group:
                        target = conn.get('node')
                        print(f"   -> {target}")
        else:
            print(f"⚠️ Nenhuma conexão encontrada a partir de '{nome_no}'")
    
    print()
    
    # 5. Verificar nó de resposta
    print("📤 ANÁLISE DO NÓ DE RESPOSTA:")
    print("-" * 80)
    
    no_resposta = None
    for node in nodes:
        if 'Respond' in node.get('name', '') or 'Responder' in node.get('name', ''):
            no_resposta = node
            break
    
    if no_resposta:
        print(f"✅ Nó de resposta encontrado: {no_resposta.get('name')}")
        
        # Ver o que está conectado antes dele
        nome_no = no_resposta.get('name')
        for source_node, targets in connections.items():
            for connection_type, connection_list in targets.items():
                for connection_group in connection_list:
                    for connection in connection_group:
                        if nome_no in connection.get('node', ''):
                            print(f"   <- {source_node}")
    
    print()
    print("=" * 80)
    print("FIM DA ANÁLISE")
    print("=" * 80)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Uso: python3 analise_workflow_econ.py <caminho_workflow.json>")
        sys.exit(1)
    
    analisar_workflow_econ(sys.argv[1])
