#!/usr/bin/env python3
"""
Script para gerar o Workflow V5 do Agente ECON (Resiliente)
Framework de Inteligência Territorial V6.0 - Sessão #10
"""

import json
import sys
from pathlib import Path

# Caminhos
BASE_DIR = Path(__file__).parent.parent
V4_PATH = BASE_DIR / "n8n/workflows/WF-AGENT-ECON-Especialista-Economico-V4-POSTGRES-LEARNING.json"
V5_PATH = BASE_DIR / "n8n/workflows/WF-AGENT-ECON-Especialista-Economico-V5-RESILIENT.json"

# Códigos dos nós resilientes
CODE_SNIPPETS_DIR = BASE_DIR / "n8n/code-snippets"
NORMALIZAR_ENTRADA = CODE_SNIPPETS_DIR / "normalizar_entrada_v1.js"
PREPARAR_CONTEXTO = CODE_SNIPPETS_DIR / "preparar_contexto_llm_v2_resiliente.js"
PREPARAR_DADOS = CODE_SNIPPETS_DIR / "preparar_dados_salvar_v2_resiliente.js"

def load_json(path):
    """Carrega arquivo JSON"""
    with open(path, 'r', encoding='utf-8') as f:
        return json.load(f)

def load_code(path):
    """Carrega código JavaScript"""
    with open(path, 'r', encoding='utf-8') as f:
        return f.read()

def create_normalizar_entrada_node():
    """Cria o nó Normalizar Entrada"""
    code = load_code(NORMALIZAR_ENTRADA)
    
    return {
        "parameters": {
            "jsCode": code
        },
        "id": "normalizar-entrada-v5",
        "name": "Normalizar Entrada",
        "type": "n8n-nodes-base.code",
        "typeVersion": 2,
        "position": [80, 0],
        "notes": "FUNÇÃO: Validar e normalizar o payload recebido do webhook.\n\nO QUE FAZ:\n1. Valida campos obrigatórios (agent_id, territory_id, analysis_type)\n2. Adiciona valores padrão para campos opcionais\n3. Normaliza o objeto parameters\n4. Registra quais campos foram adicionados\n\nBENEFÍCIOS:\n- Garante que todos os nós seguintes recebam dados consistentes\n- Elimina erros de 'undefined' em nós posteriores\n- Centraliza a lógica de validação\n- Facilita debugging (registra campos adicionados)"
    }

def main():
    print("🚀 Gerando Workflow V5 (Resiliente)...")
    
    # Carregar workflow V4
    print("📖 Lendo workflow V4...")
    v4_workflow = load_json(V4_PATH)
    
    # Criar novo workflow V5
    v5_workflow = v4_workflow.copy()
    v5_workflow["name"] = "WF-AGENT-ECON - Especialista Econômico V5 (Resiliente)"
    
    # Carregar códigos resilientes
    print("📝 Carregando códigos resilientes...")
    code_normalizar = load_code(NORMALIZAR_ENTRADA)
    code_preparar_contexto = load_code(PREPARAR_CONTEXTO)
    code_preparar_dados = load_code(PREPARAR_DADOS)
    
    # Criar nó Normalizar Entrada
    print("➕ Adicionando nó 'Normalizar Entrada'...")
    normalizar_node = create_normalizar_entrada_node()
    
    # Inserir nó Normalizar Entrada após o Webhook
    nodes = v5_workflow["nodes"]
    nodes.insert(1, normalizar_node)
    
    # Atualizar código do nó "Preparar Contexto para LLM"
    print("🔄 Atualizando nó 'Preparar Contexto para LLM'...")
    for node in nodes:
        if node["name"] == "Preparar Contexto para LLM":
            node["parameters"]["jsCode"] = code_preparar_contexto
            node["notes"] = "FUNÇÃO: Preparar contexto estruturado para o LLM (V2 - RESILIENTE).\n\nMUDANÇAS V2:\n- Usa dados normalizados do nó 'Normalizar Entrada'\n- Tratamento seguro de dados ausentes\n- Valores padrão para todos os campos opcionais\n- Mensagem clara quando não há dados no banco"
    
    # Atualizar código do nó "Preparar Dados para Salvar"
    print("🔄 Atualizando nó 'Preparar Dados para Salvar'...")
    for node in nodes:
        if node["name"] == "Preparar Dados para Salvar":
            node["parameters"]["jsCode"] = code_preparar_dados
            node["notes"] = "FUNÇÃO: Preparar dados para salvar no PostgreSQL (V2 - RESILIENTE).\n\nMUDANÇAS V2:\n- Usa dados normalizados do nó 'Normalizar Entrada'\n- Extração segura com operador ??\n- Valores padrão para todos os campos\n- Validação final antes de retornar"
    
    # Atualizar conexões (adicionar Normalizar Entrada no fluxo)
    print("🔗 Atualizando conexões...")
    connections = v5_workflow.get("connections", {})
    
    # Webhook → Normalizar Entrada
    connections["Webhook - Recebe Tarefa"] = {
        "main": [[{"node": "Normalizar Entrada", "type": "main", "index": 0}]]
    }
    
    # Normalizar Entrada → Consultar Dados PostgreSQL
    connections["Normalizar Entrada"] = {
        "main": [[{"node": "Consultar Dados PostgreSQL", "type": "main", "index": 0}]]
    }
    
    v5_workflow["connections"] = connections
    
    # Salvar workflow V5
    print("💾 Salvando workflow V5...")
    with open(V5_PATH, 'w', encoding='utf-8') as f:
        json.dump(v5_workflow, f, indent=2, ensure_ascii=False)
    
    print(f"✅ Workflow V5 gerado com sucesso!")
    print(f"📍 Localização: {V5_PATH}")
    print(f"📊 Total de nós: {len(v5_workflow['nodes'])}")
    print("\n🎯 Mudanças principais:")
    print("  1. ➕ Novo nó: Normalizar Entrada")
    print("  2. 🔄 Atualizado: Preparar Contexto para LLM (V2)")
    print("  3. 🔄 Atualizado: Preparar Dados para Salvar (V2)")
    print("  4. 🔗 Conexões atualizadas")
    
    return 0

if __name__ == "__main__":
    sys.exit(main())
