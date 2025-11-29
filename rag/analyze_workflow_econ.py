"""
Análise Detalhada do Workflow do Agente ECON V2
Framework V6.0 - Integração com n8n

Este script analisa o workflow JSON do Agente ECON construído no n8n.
"""

import json
from typing import Dict, List, Any


def load_workflow(file_path: str) -> Dict:
    """Carrega o workflow JSON."""
    with open(file_path, 'r', encoding='utf-8') as f:
        return json.load(f)


def analyze_node(node: Dict) -> Dict[str, Any]:
    """Analisa um nó individual do workflow."""
    
    analysis = {
        'name': node.get('name', 'unnamed'),
        'type': node.get('type', 'unknown'),
        'id': node.get('id', 'no-id'),
        'position': node.get('position', [0, 0]),
        'has_notes': bool(node.get('notes', '')),
        'notes_summary': '',
        'parameters': {},
        'credentials': node.get('credentials', {}),
        'error_handling': node.get('onError', 'stopWorkflow')
    }
    
    # Extrair resumo das notas
    notes = node.get('notes', '')
    if notes:
        lines = notes.split('\n')
        # Pegar primeira linha significativa
        for line in lines:
            if line.strip() and not line.strip().startswith('='):
                analysis['notes_summary'] = line.strip()
                break
    
    # Analisar parâmetros específicos por tipo de nó
    params = node.get('parameters', {})
    
    if 'webhook' in node.get('type', ''):
        analysis['parameters'] = {
            'method': params.get('httpMethod', 'GET'),
            'path': params.get('path', ''),
            'response_mode': params.get('responseMode', 'onReceived')
        }
    
    elif 'postgres' in node.get('type', ''):
        analysis['parameters'] = {
            'operation': params.get('operation', 'unknown'),
            'has_query': bool(params.get('query', '')),
            'query_preview': params.get('query', '')[:200] + '...' if params.get('query') else ''
        }
    
    elif 'code' in node.get('type', ''):
        code = params.get('jsCode', '')
        analysis['parameters'] = {
            'has_code': bool(code),
            'code_lines': len(code.split('\n')) if code else 0,
            'code_preview': code[:200] + '...' if code else ''
        }
    
    elif 'openAi' in node.get('type', ''):
        analysis['parameters'] = {
            'model': params.get('modelId', {}).get('value', 'unknown'),
            'has_messages': bool(params.get('messages', {}))
        }
    
    return analysis


def analyze_workflow_flow(workflow: Dict) -> Dict[str, Any]:
    """Analisa o fluxo de execução do workflow."""
    
    connections = workflow.get('connections', {})
    nodes = {node['id']: node['name'] for node in workflow['nodes']}
    
    flow = {
        'entry_points': [],
        'exit_points': [],
        'flow_map': {}
    }
    
    # Identificar pontos de entrada (webhooks)
    for node in workflow['nodes']:
        if 'webhook' in node.get('type', ''):
            flow['entry_points'].append(node['name'])
    
    # Identificar pontos de saída (respond to webhook)
    for node in workflow['nodes']:
        if 'respondToWebhook' in node.get('type', ''):
            flow['exit_points'].append(node['name'])
    
    # Mapear fluxo
    for node_name, connections_list in connections.items():
        flow['flow_map'][node_name] = {}
        for output_type, targets in connections_list.items():
            if isinstance(targets, list):
                flow['flow_map'][node_name][output_type] = [
                    target.get('node', 'unknown') if isinstance(target, dict) else str(target)
                    for target in targets
                ]
    
    return flow


def analyze_database_interactions(workflow: Dict) -> Dict[str, Any]:
    """Analisa interações com o banco de dados."""
    
    db_interactions = {
        'read_operations': [],
        'write_operations': [],
        'tables_accessed': set()
    }
    
    for node in workflow['nodes']:
        if 'postgres' in node.get('type', ''):
            operation = node.get('parameters', {}).get('operation', '')
            query = node.get('parameters', {}).get('query', '')
            
            # Identificar tabelas acessadas
            tables = []
            if 'FROM' in query.upper():
                # Extrair tabelas após FROM
                parts = query.upper().split('FROM')[1].split('WHERE')[0]
                for word in parts.split():
                    if word.isalpha() and word not in ['LEFT', 'JOIN', 'ON', 'AND', 'OR']:
                        tables.append(word.lower())
            
            if 'INSERT INTO' in query.upper():
                # Extrair tabela após INSERT INTO
                parts = query.upper().split('INSERT INTO')[1].split('(')[0]
                table = parts.strip().lower()
                tables.append(table)
            
            db_interactions['tables_accessed'].update(tables)
            
            interaction = {
                'node_name': node.get('name'),
                'operation': operation,
                'tables': tables,
                'query_preview': query[:200] + '...' if len(query) > 200 else query
            }
            
            if operation == 'executeQuery' and 'SELECT' in query.upper():
                db_interactions['read_operations'].append(interaction)
            elif operation == 'executeQuery' and 'INSERT' in query.upper():
                db_interactions['write_operations'].append(interaction)
    
    db_interactions['tables_accessed'] = list(db_interactions['tables_accessed'])
    
    return db_interactions


def generate_report(workflow: Dict) -> str:
    """Gera relatório completo da análise."""
    
    report = []
    report.append("=" * 80)
    report.append("ANÁLISE DETALHADA DO WORKFLOW: AGENTE ECON V2")
    report.append("=" * 80)
    report.append("")
    
    # Informações básicas
    report.append(f"📋 Nome: {workflow['name']}")
    report.append(f"📊 Total de Nós: {len(workflow['nodes'])}")
    report.append(f"🔗 Total de Conexões: {len(workflow.get('connections', {}))}")
    report.append("")
    
    # Analisar cada nó
    report.append("=" * 80)
    report.append("ANÁLISE DOS NÓS")
    report.append("=" * 80)
    report.append("")
    
    for i, node in enumerate(workflow['nodes'], 1):
        analysis = analyze_node(node)
        report.append(f"{i}. {analysis['name']}")
        report.append(f"   Tipo: {analysis['type']}")
        report.append(f"   Função: {analysis['notes_summary']}")
        
        if analysis['parameters']:
            report.append(f"   Parâmetros:")
            for key, value in analysis['parameters'].items():
                if isinstance(value, str) and len(value) > 100:
                    value = value[:100] + '...'
                report.append(f"      - {key}: {value}")
        
        if analysis['credentials']:
            report.append(f"   Credenciais: {list(analysis['credentials'].keys())}")
        
        report.append(f"   Tratamento de Erro: {analysis['error_handling']}")
        report.append("")
    
    # Analisar fluxo
    report.append("=" * 80)
    report.append("FLUXO DE EXECUÇÃO")
    report.append("=" * 80)
    report.append("")
    
    flow = analyze_workflow_flow(workflow)
    report.append(f"📥 Pontos de Entrada: {', '.join(flow['entry_points'])}")
    report.append(f"📤 Pontos de Saída: {', '.join(flow['exit_points'])}")
    report.append("")
    
    report.append("Mapa de Fluxo:")
    for node_name, outputs in flow['flow_map'].items():
        report.append(f"  {node_name} →")
        for output_type, targets in outputs.items():
            report.append(f"    [{output_type}] → {', '.join(targets)}")
    report.append("")
    
    # Analisar interações com banco
    report.append("=" * 80)
    report.append("INTERAÇÕES COM BANCO DE DADOS")
    report.append("=" * 80)
    report.append("")
    
    db = analyze_database_interactions(workflow)
    report.append(f"📖 Operações de Leitura: {len(db['read_operations'])}")
    for op in db['read_operations']:
        report.append(f"   - {op['node_name']}: {', '.join(op['tables'])}")
    report.append("")
    
    report.append(f"✍️  Operações de Escrita: {len(db['write_operations'])}")
    for op in db['write_operations']:
        report.append(f"   - {op['node_name']}: {', '.join(op['tables'])}")
    report.append("")
    
    report.append(f"🗄️  Tabelas Acessadas: {', '.join(db['tables_accessed'])}")
    report.append("")
    
    return '\n'.join(report)


if __name__ == "__main__":
    """Executa a análise do workflow."""
    
    import sys
    
    if len(sys.argv) < 2:
        print("Uso: python3.11 analyze_workflow_econ.py <caminho_do_workflow.json>")
        sys.exit(1)
    
    workflow_path = sys.argv[1]
    
    try:
        workflow = load_workflow(workflow_path)
        report = generate_report(workflow)
        
        print(report)
        
        # Salvar relatório
        output_path = "/home/ubuntu/framework-v6-mvp/docs/sessao7/workflow_econ_analysis.txt"
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(report)
        
        print(f"\n💾 Relatório salvo em: {output_path}")
        
    except Exception as e:
        print(f"❌ Erro durante análise: {e}")
        raise
