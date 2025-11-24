#!/usr/bin/env python3
"""
Script para atualizar workflows dos agentes SOCIAL, TERRA e AMBIENT
Aplica as mesmas atualizações feitas no agente ECON
"""

import json
import sys
from pathlib import Path

def update_workflow(input_file, output_file, agent_name, agent_dimension):
    """Atualiza um workflow com as novas versões de nós"""
    
    print(f"\n{'='*60}")
    print(f"Atualizando {agent_name}...")
    print(f"{'='*60}")
    
    # Ler workflow original
    with open(input_file, 'r', encoding='utf-8') as f:
        workflow = json.load(f)
    
    # Atualizar nome do workflow
    workflow['name'] = workflow['name'].replace(agent_name, f"{agent_name} V2")
    workflow['versionId'] = "2"
    workflow['updatedAt'] = "2025-11-24T20:00:00.000Z"
    
    # Atualizar cada nó
    for node in workflow['nodes']:
        node_type = node['type']
        
        # 1. WEBHOOK NODE
        if node_type == 'n8n-nodes-base.webhook':
            node['typeVersion'] = 2
            if 'options' not in node['parameters']:
                node['parameters']['options'] = {}
            node['parameters']['options']['ignoreBots'] = True
            print(f"✓ Webhook: v1 → v2 (+ ignoreBots)")
        
        # 2. POSTGRES NODE
        elif node_type == 'n8n-nodes-base.postgres':
            node['typeVersion'] = 2.5
            
            # Atualizar query para usar prepared statements
            if 'query' in node['parameters']:
                query = node['parameters']['query']
                # Substituir {{ $json.body.territory_id }} por $1
                query = query.replace('{{ $json.body.territory_id }}', '$1')
                node['parameters']['query'] = query
                
                # Adicionar options
                if 'options' not in node['parameters']:
                    node['parameters']['options'] = {}
                
                # Se é consulta (SELECT)
                if 'SELECT' in query and 'INSERT' not in query:
                    node['parameters']['options']['queryParameters'] = "={{ $json.body.territory_id }}"
                    node['parameters']['options']['queryBatching'] = "transaction"
                    node['parameters']['options']['outputLargeNumbersAs'] = "text"
                # Se é insert/update
                else:
                    # Contar quantos parâmetros tem na query
                    param_count = query.count('$')
                    if param_count > 0:
                        # Criar lista de parâmetros baseado no número
                        params = []
                        params.append("={{ $json.analysis.territory.id }}")
                        if param_count >= 2:
                            params.append("={{ $json.analysis.text }}")
                        if param_count >= 3:
                            params.append("={{ $json.analysis.summary }}")
                        if param_count >= 4:
                            params.append("={{ JSON.stringify($json.analysis.statistics) }}")
                        if param_count >= 5:
                            params.append("={{ JSON.stringify($json.metadata) }}")
                        
                        node['parameters']['options']['queryParameters'] = ",".join(params)
                        node['parameters']['options']['queryBatching'] = "transaction"
            
            print(f"✓ Postgres: v1 → v2.5 (+ prepared statements)")
        
        # 3. CODE NODE
        elif node_type == 'n8n-nodes-base.code':
            node['typeVersion'] = 2
            
            # Renomear functionCode para jsCode (novo padrão)
            if 'functionCode' in node['parameters']:
                node['parameters']['jsCode'] = node['parameters'].pop('functionCode')
                
                # Adicionar parseNumber() se necessário
                code = node['parameters']['jsCode']
                if 'parseNumber' not in code and 'Preparar Contexto' in node['name']:
                    # Adicionar função parseNumber no início
                    parse_func = "\n// Converter strings para números (devido a outputLargeNumbersAs: 'text')\nconst parseNumber = (value) => parseFloat(value) || 0;\n"
                    code = code.replace('const dataByYear = items.map(item => item.json);', 
                                      'const dataByYear = items.map(item => item.json);' + parse_func)
                    node['parameters']['jsCode'] = code
            
            print(f"✓ Code: v1 → v2 (+ jsCode)")
        
        # 4. OPENAI NODE (CRÍTICO)
        elif node_type == 'n8n-nodes-base.openAi':
            # Mudar para novo tipo
            node['type'] = '@n8n/n8n-nodes-langchain.openAi'
            node['typeVersion'] = 1.7
            
            # Reestruturar parâmetros
            old_params = node['parameters']
            node['parameters'] = {
                'resource': 'text',
                'operation': 'message',
                'model': old_params.get('model', 'gpt-4o-mini'),
                'messages': {
                    'values': [
                        {
                            'role': 'user',
                            'content': '={{ $json.prompt }}'
                        }
                    ]
                },
                'options': {
                    'temperature': old_params.get('options', {}).get('temperature', 0.7),
                    'maxTokens': old_params.get('options', {}).get('maxTokens', 1500)
                }
            }
            
            print(f"✓ OpenAI: v1 → v1.7 (NOVA ESTRUTURA)")
        
        # 5. RESPOND TO WEBHOOK NODE
        elif node_type == 'n8n-nodes-base.respondToWebhook':
            node['typeVersion'] = 2
            print(f"✓ Respond to Webhook: v1 → v2")
    
    # Salvar workflow atualizado
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(workflow, f, indent=2, ensure_ascii=False)
    
    print(f"\n✅ {agent_name} atualizado com sucesso!")
    print(f"   Arquivo salvo: {output_file}")
    
    return True

def main():
    base_path = Path('/home/ubuntu/framework-v6-mvp/n8n/workflows')
    
    agents = [
        {
            'name': 'SOCIAL',
            'dimension': 'social',
            'input': base_path / 'WF-AGENT-SOCIAL-Especialista-Social.json',
            'output': base_path / 'WF-AGENT-SOCIAL-Especialista-Social-V2.json'
        },
        {
            'name': 'TERRA',
            'dimension': 'territorial',
            'input': base_path / 'WF-AGENT-TERRA-Especialista-Territorial.json',
            'output': base_path / 'WF-AGENT-TERRA-Especialista-Territorial-V2.json'
        },
        {
            'name': 'AMBIENT',
            'dimension': 'environmental',
            'input': base_path / 'WF-AGENT-AMBIENT-Especialista-Ambiental.json',
            'output': base_path / 'WF-AGENT-AMBIENT-Especialista-Ambiental-V2.json'
        }
    ]
    
    print("\n" + "="*60)
    print("ATUALIZAÇÃO AUTOMÁTICA DE WORKFLOWS N8N")
    print("Framework de Inteligência Territorial V6.0")
    print("="*60)
    
    success_count = 0
    
    for agent in agents:
        try:
            if update_workflow(agent['input'], agent['output'], agent['name'], agent['dimension']):
                success_count += 1
        except Exception as e:
            print(f"\n❌ Erro ao atualizar {agent['name']}: {e}")
            continue
    
    print("\n" + "="*60)
    print(f"RESUMO: {success_count}/{len(agents)} workflows atualizados com sucesso")
    print("="*60)
    
    return 0 if success_count == len(agents) else 1

if __name__ == '__main__':
    sys.exit(main())
