#!/usr/bin/env python3
"""
Script para Adicionar Nó de Ciclo de Aprendizagem ao Workflow do Agente ECON
Framework de Inteligência Territorial V6.0 - Sessão #10

Este script modifica o workflow WF-AGENT-ECON-V2 para adicionar um nó que
aciona o ciclo de aprendizagem automaticamente após cada análise salva.
"""

import json
import uuid
from pathlib import Path

# Caminhos dos arquivos
INPUT_FILE = Path("/home/ubuntu/framework-v6-mvp/n8n/workflows/WF-AGENT-ECON-Especialista-Economico-V2-VALIDATED.json")
OUTPUT_FILE = Path("/home/ubuntu/framework-v6-mvp/n8n/workflows/WF-AGENT-ECON-Especialista-Economico-V3-WITH-LEARNING.json")

# Carregar workflow original
with open(INPUT_FILE, 'r', encoding='utf-8') as f:
    workflow = json.load(f)

# Atualizar nome do workflow
workflow['name'] = "WF-AGENT-ECON - Especialista Econômico V3 (com Aprendizagem)"

# Criar novo nó: Acionar Ciclo de Aprendizagem
learning_cycle_node = {
    "parameters": {
        "jsCode": """// ============================================================================
// NÓ: ACIONAR CICLO DE APRENDIZAGEM EVOLUTIVA
// Framework de Inteligência Territorial V6.0 - Sessão #10
// ============================================================================
// FUNÇÃO: Executar o ciclo de aprendizagem após salvar análise com sucesso
// INPUT: Dados da análise salva (ID, agent_id, territory_id)
// OUTPUT: Resultado do ciclo de aprendizagem
// ============================================================================

// Importar módulos necessários
const { exec } = require('child_process');
const util = require('util');
const execPromise = util.promisify(exec);

// Obter dados da análise salva
const savedAnalysis = $('Salvar Análise no PostgreSQL').first().json;
const preparedData = $('Preparar Dados para Salvar').first().json;

// Extrair informações necessárias
const analysisId = savedAnalysis.id || preparedData.id;
const agentId = 'econ';  // ID do agente (minúsculo, sem prefixo)
const territoryId = preparedData.territory_id;

console.log('🔄 Iniciando ciclo de aprendizagem...');
console.log(`   Agent ID: ${agentId}`);
console.log(`   Analysis ID: ${analysisId}`);
console.log(`   Territory ID: ${territoryId}`);

// Preparar comando para executar o script Python
const pythonScript = '/home/ubuntu/framework-v6-mvp/rag/learning_cycle.py';
const command = `cd /home/ubuntu/framework-v6-mvp && source venv/bin/activate && python ${pythonScript} --agent-id ${agentId} --analysis-id ${analysisId}`;

try {
  // Executar o ciclo de aprendizagem
  const { stdout, stderr } = await execPromise(command, {
    timeout: 60000,  // 60 segundos de timeout
    maxBuffer: 1024 * 1024  // 1MB de buffer
  });
  
  // Log da saída
  if (stdout) {
    console.log('📄 Saída do ciclo de aprendizagem:');
    console.log(stdout);
  }
  
  if (stderr) {
    console.warn('⚠️ Avisos do ciclo de aprendizagem:');
    console.warn(stderr);
  }
  
  // Tentar parsear a saída como JSON (se o script retornar JSON)
  let result = {
    success: true,
    agent_id: agentId,
    analysis_id: analysisId,
    territory_id: territoryId,
    stdout: stdout,
    stderr: stderr,
    executed_at: new Date().toISOString()
  };
  
  // Se a saída contém JSON, extrair
  try {
    const jsonMatch = stdout.match(/\\{[\\s\\S]*\\}/);
    if (jsonMatch) {
      const parsedResult = JSON.parse(jsonMatch[0]);
      result = { ...result, ...parsedResult };
    }
  } catch (parseError) {
    console.log('ℹ️ Saída não é JSON, mantendo como texto');
  }
  
  console.log('✅ Ciclo de aprendizagem executado com sucesso!');
  
  return {
    json: {
      ...preparedData,  // Manter dados originais
      learning_cycle: result  // Adicionar resultado do ciclo
    }
  };
  
} catch (error) {
  // Em caso de erro, logar mas não interromper o workflow
  console.error('❌ Erro ao executar ciclo de aprendizagem:');
  console.error(error.message);
  
  // Retornar dados originais com informação do erro
  return {
    json: {
      ...preparedData,
      learning_cycle: {
        success: false,
        error: error.message,
        agent_id: agentId,
        analysis_id: analysisId,
        executed_at: new Date().toISOString()
      }
    }
  };
}
"""
    },
    "id": str(uuid.uuid4()),
    "name": "Acionar Ciclo de Aprendizagem",
    "type": "n8n-nodes-base.code",
    "typeVersion": 2,
    "position": [1296, 0],
    "notes": """FUNÇÃO: Executar o ciclo de aprendizagem evolutiva após salvar análise.

ATUALIZAÇÃO V3 - INTEGRAÇÃO DO CICLO DE APRENDIZAGEM:
Este nó foi adicionado na Sessão #10 para automatizar o ciclo de aprendizagem.

O QUE FAZ:
1. Extrai o ID da análise recém-salva
2. Prepara os parâmetros (agent_id, analysis_id, territory_id)
3. Executa o script learning_cycle.py via linha de comando
4. Captura a saída (stdout/stderr)
5. Parseia o resultado (se for JSON)
6. Retorna os dados originais + resultado do ciclo

POR QUE EXECUTAR AQUI?
- Garante que o ciclo só roda após análise ser salva com sucesso
- Não bloqueia a resposta ao webhook (execução assíncrona)
- Permite logging e auditoria completos

TRATAMENTO DE ERRO:
- Se o ciclo falhar, o erro é logado mas o workflow continua
- A análise já foi salva, então o usuário não é impactado
- O erro fica registrado no campo learning_cycle.error

TIMEOUT:
- 60 segundos (o ciclo pode demorar para processar)
- Se exceder, o erro é capturado e logado

OBSERVAÇÃO:
Este nó executa o ciclo de forma síncrona (aguarda conclusão).
Em produção, considerar executar de forma assíncrona via queue."""
}

# Adicionar o novo nó à lista de nós
workflow['nodes'].append(learning_cycle_node)

# Atualizar conexões
# Encontrar o nó "Salvar Análise no PostgreSQL"
save_node_id = None
for node in workflow['nodes']:
    if node['name'] == "Salvar Análise no PostgreSQL":
        save_node_id = node['id']
        break

if not save_node_id:
    raise ValueError("Nó 'Salvar Análise no PostgreSQL' não encontrado")

# Atualizar conexão: Salvar → Ciclo de Aprendizagem → Respond to Webhook
# Conexão original: Salvar → Respond to Webhook
# Nova conexão: Salvar → Ciclo → Respond

# Modificar conexão do nó "Salvar Análise"
workflow['connections']["Salvar Análise no PostgreSQL"] = {
    "main": [
        [
            {
                "node": "Acionar Ciclo de Aprendizagem",
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

# Adicionar conexão do novo nó para "Respond to Webhook"
workflow['connections']["Acionar Ciclo de Aprendizagem"] = {
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

# Atualizar metadados
workflow['updatedAt'] = "2025-11-30T00:00:00.000Z"
workflow['versionId'] = "3"

# Adicionar tag de aprendizagem
if 'tags' not in workflow:
    workflow['tags'] = []

workflow['tags'].append({
    "name": "Aprendizagem Evolutiva",
    "id": "learning-evolution"
})

# Salvar workflow modificado
with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
    json.dump(workflow, f, indent=2, ensure_ascii=False)

print("✅ Workflow V3 criado com sucesso!")
print(f"   Input: {INPUT_FILE}")
print(f"   Output: {OUTPUT_FILE}")
print(f"   Novo nó: Acionar Ciclo de Aprendizagem")
print(f"   Posição: [1296, 0]")
print(f"   Total de nós: {len(workflow['nodes'])}")
