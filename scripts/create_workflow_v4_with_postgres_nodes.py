#!/usr/bin/env python3
"""
Script para Criar Workflow V4 do Agente ECON com Ciclo de Aprendizagem via PostgreSQL
Framework de Inteligência Territorial V6.0 - Sessão #10

Este script cria o workflow V4 substituindo o nó de código JavaScript por 3 nós
PostgreSQL nativos que executam o ciclo de aprendizagem diretamente no banco.
"""

import json
import uuid
from pathlib import Path

# Caminhos dos arquivos
INPUT_FILE = Path("/home/ubuntu/framework-v6-mvp/n8n/workflows/WF-AGENT-ECON-Especialista-Economico-V2-VALIDATED.json")
OUTPUT_FILE = Path("/home/ubuntu/framework-v6-mvp/n8n/workflows/WF-AGENT-ECON-Especialista-Economico-V4-POSTGRES-LEARNING.json")

# Carregar workflow V2 original (mais estável que o V3)
with open(INPUT_FILE, 'r', encoding='utf-8') as f:
    workflow = json.load(f)

# Atualizar metadados do workflow
workflow['name'] = "WF-AGENT-ECON - Especialista Econômico V4 (Aprendizagem via PostgreSQL)"
workflow['updatedAt'] = "2025-11-30T12:00:00.000Z"
workflow['versionId'] = "4"

# Adicionar tags
if 'tags' not in workflow:
    workflow['tags'] = []

workflow['tags'].append({
    "name": "Aprendizagem PostgreSQL",
    "id": "learning-postgres"
})

# ============================================================================
# CRIAR NÓS DO CICLO DE APRENDIZAGEM
# ============================================================================

# Nó 1: Registrar Aprendizado Automático
node_register_learning = {
    "parameters": {
        "operation": "executeQuery",
        "query": """-- Registrar aprendizado automático a cada 5 análises
INSERT INTO agent_econ_learning_evolution (
  agent_id,
  learning_type,
  source_analysis_ids,
  learning_content,
  confidence_score,
  metadata,
  created_at
)
SELECT
  'econ' AS agent_id,
  'automatic' AS learning_type,
  '{{ $json.id }}' AS source_analysis_ids,
  'Aprendizado automático: O agente ECON continua evoluindo sua expertise através da análise contínua de indicadores econômicos. Análise ID: {{ $json.id }}' AS learning_content,
  0.75 AS confidence_score,
  jsonb_build_object(
    'type', 'automatic_learning',
    'trigger', 'post_analysis',
    'analysis_id', '{{ $json.id }}',
    'territory_id', '{{ $json.territory_id }}',
    'timestamp', NOW()
  ) AS metadata,
  NOW() AS created_at
WHERE (
  -- Só registrar aprendizado a cada 5 análises
  SELECT COUNT(*) FROM agent_econ_memory WHERE agent_id = 'econ'
) % 5 = 0
RETURNING id, agent_id, learning_type, confidence_score, created_at;""",
        "options": {}
    },
    "id": str(uuid.uuid4()),
    "name": "Registrar Aprendizado Automático",
    "type": "n8n-nodes-base.postgres",
    "typeVersion": 2.5,
    "position": [1296, 0],
    "credentials": {
        "postgres": {
            "id": "PLACEHOLDER_POSTGRES_CREDENTIAL_ID",
            "name": "Postgres Neon"
        }
    },
    "notes": """CICLO DE APRENDIZAGEM - PASSO 1: REGISTRAR APRENDIZADO

Este nó registra um aprendizado automático na Camada 2 (Learning Evolution).

QUANDO EXECUTA:
- A cada 5 análises do agente ECON (configurável na condição WHERE)

O QUE FAZ:
1. Conta o total de análises do agente
2. Se for múltiplo de 5, insere um registro de aprendizado
3. Retorna o ID do aprendizado criado

CONFIGURAÇÃO:
- Frequência: Modificar "% 5" para ajustar (ex: % 3 = a cada 3 análises)
- Confiança: 0.75 (75%) para aprendizado automático
- Tipo: 'automatic' (não requer síntese LLM)

SAÍDA:
- id: ID do aprendizado criado
- agent_id: 'econ'
- learning_type: 'automatic'
- confidence_score: 0.75
- created_at: timestamp da criação"""
}

# Nó 2: Atualizar Expertise
node_update_expertise = {
    "parameters": {
        "operation": "executeQuery",
        "query": """-- Atualizar e retornar expertise atual do agente
SELECT * FROM get_agent_expertise('econ');""",
        "options": {}
    },
    "id": str(uuid.uuid4()),
    "name": "Atualizar Expertise",
    "type": "n8n-nodes-base.postgres",
    "typeVersion": 2.5,
    "position": [1408, 0],
    "credentials": {
        "postgres": {
            "id": "PLACEHOLDER_POSTGRES_CREDENTIAL_ID",
            "name": "Postgres Neon"
        }
    },
    "notes": """CICLO DE APRENDIZAGEM - PASSO 2: ATUALIZAR EXPERTISE

Este nó chama a função do banco que calcula a expertise atual do agente.

FUNÇÃO: get_agent_expertise('econ')

O QUE RETORNA:
- agent_id: 'econ'
- learning_count: Número total de ciclos de aprendizagem
- expertise_level: Nível atual (NOVATO, COMPETENTE, PROFICIENTE, AVANCADO, ESPECIALISTA)
- expertise_value: Valor numérico da expertise (1-5)

NÍVEIS DE EXPERTISE:
- NOVATO: 0-10 ciclos
- COMPETENTE: 11-30 ciclos
- PROFICIENTE: 31-60 ciclos
- AVANCADO: 61-100 ciclos
- ESPECIALISTA: 100+ ciclos

OBSERVAÇÃO:
Esta função é implementada no banco de dados e atualiza automaticamente
o nível de expertise baseado no número de aprendizados registrados."""
}

# Nó 3: Registrar Auditoria do Ciclo
node_audit = {
    "parameters": {
        "operation": "executeQuery",
        "query": """-- Registrar evento de ciclo de aprendizagem na auditoria
INSERT INTO audit_trail (
  event_type,
  agent_id,
  user_id,
  action,
  resource_type,
  status,
  metadata,
  created_at
) VALUES (
  'learning_cycle_completed',
  'econ',
  'system',
  'automatic_learning',
  'learning_evolution',
  'success',
  jsonb_build_object(
    'analysis_id', '{{ $('Salvar Análise no PostgreSQL').item.json.id }}',
    'learning_id', '{{ $('Registrar Aprendizado Automático').item.json.id }}',
    'expertise_level', '{{ $('Atualizar Expertise').item.json.expertise_level }}',
    'type', 'automatic'
  ),
  NOW()
);""",
        "options": {}
    },
    "id": str(uuid.uuid4()),
    "name": "Registrar Auditoria do Ciclo",
    "type": "n8n-nodes-base.postgres",
    "typeVersion": 2.5,
    "position": [1520, 0],
    "credentials": {
        "postgres": {
            "id": "PLACEHOLDER_POSTGRES_CREDENTIAL_ID",
            "name": "Postgres Neon"
        }
    },
    "notes": """CICLO DE APRENDIZAGEM - PASSO 3: REGISTRAR AUDITORIA

Este nó registra o evento de conclusão do ciclo de aprendizagem na audit_trail.

O QUE REGISTRA:
- event_type: 'learning_cycle_completed'
- agent_id: 'econ'
- user_id: 'system' (processo automático)
- action: 'automatic_learning'
- resource_type: 'learning_evolution'
- status: 'success'

METADATA INCLUÍDA:
- analysis_id: ID da análise que iniciou o ciclo
- learning_id: ID do aprendizado registrado
- expertise_level: Nível de expertise após o ciclo
- type: 'automatic'

OBSERVAÇÃO:
Este registro permite rastrear a evolução do agente ao longo do tempo
e auditar todos os ciclos de aprendizagem executados."""
}

# Adicionar os novos nós ao workflow
workflow['nodes'].extend([
    node_register_learning,
    node_update_expertise,
    node_audit
])

# ============================================================================
# ATUALIZAR CONEXÕES
# ============================================================================

# Encontrar o ID do nó "Salvar Análise no PostgreSQL"
save_node_id = None
respond_node_id = None

for node in workflow['nodes']:
    if node['name'] == "Salvar Análise no PostgreSQL":
        save_node_id = node['id']
    elif node['name'] == "Respond to Webhook":
        respond_node_id = node['id']

if not save_node_id or not respond_node_id:
    raise ValueError("Nós essenciais não encontrados no workflow")

# Atualizar conexão: Salvar → Registrar Aprendizado → Atualizar Expertise → Auditoria → Respond
workflow['connections']["Salvar Análise no PostgreSQL"] = {
    "main": [
        [
            {
                "node": "Registrar Aprendizado Automático",
                "type": "main",
                "index": 0
            }
        ],
        [
            {
                "node": "Responder Erro",
                "type": "main",
                "index": 0
            }
        ]
    ]
}

workflow['connections']["Registrar Aprendizado Automático"] = {
    "main": [
        [
            {
                "node": "Atualizar Expertise",
                "type": "main",
                "index": 0
            }
        ]
    ]
}

workflow['connections']["Atualizar Expertise"] = {
    "main": [
        [
            {
                "node": "Registrar Auditoria do Ciclo",
                "type": "main",
                "index": 0
            }
        ]
    ]
}

workflow['connections']["Registrar Auditoria do Ciclo"] = {
    "main": [
        [
            {
                "node": "Respond to Webhook",
                "type": "main",
                "index": 0
            }
        ]
    ]
}

# Salvar workflow V4
with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
    json.dump(workflow, f, indent=2, ensure_ascii=False)

print("✅ Workflow V4 criado com sucesso!")
print(f"   Input: {INPUT_FILE}")
print(f"   Output: {OUTPUT_FILE}")
print(f"   Novos nós: 3 (PostgreSQL)")
print(f"   Total de nós: {len(workflow['nodes'])}")
print()
print("📋 Nós adicionados:")
print("   1. Registrar Aprendizado Automático (PostgreSQL)")
print("   2. Atualizar Expertise (PostgreSQL)")
print("   3. Registrar Auditoria do Ciclo (PostgreSQL)")
print()
print("⚠️  ATENÇÃO: Você precisará configurar as credenciais PostgreSQL após importar!")
