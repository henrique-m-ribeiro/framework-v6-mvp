#!/usr/bin/env python3
"""
Script para gerar o Workflow V6 do Agente ECON (Com Memória RAG Evolutiva)
Framework de Inteligência Territorial V6.0 - Sessão #10
"""

import json
import sys
from pathlib import Path

# Caminhos
BASE_DIR = Path(__file__).parent.parent
V5_PATH = BASE_DIR / "n8n/workflows/WF-AGENT-ECON-Especialista-Economico-V5-RESILIENT.json"
V6_PATH = BASE_DIR / "n8n/workflows/WF-AGENT-ECON-Especialista-Economico-V6-WITH-MEMORY.json"

# Códigos
CODE_SNIPPETS_DIR = BASE_DIR / "n8n/code-snippets"
CONSULTAR_MEMORIA_SQL = CODE_SNIPPETS_DIR / "consultar_memoria_aprendizados_v1.sql"
PREPARAR_CONTEXTO_V3 = CODE_SNIPPETS_DIR / "preparar_contexto_llm_v3_com_memoria.js"

def load_json(path):
    """Carrega arquivo JSON"""
    with open(path, 'r', encoding='utf-8') as f:
        return json.load(f)

def load_code(path):
    """Carrega código"""
    with open(path, 'r', encoding='utf-8') as f:
        return f.read()

def create_consultar_memoria_node(sql_query):
    """Cria o nó Consultar Memória e Aprendizados"""
    return {
        "parameters": {
            "operation": "executeQuery",
            "query": sql_query,
            "options": {}
        },
        "id": "consultar-memoria-v6",
        "name": "Consultar Memória e Aprendizados",
        "type": "n8n-nodes-base.postgres",
        "typeVersion": 2.4,
        "position": [300, -100],
        "credentials": {
            "postgres": {
                "id": "postgres-neon",
                "name": "Postgres Neon"
            }
        },
        "notes": "FUNÇÃO: Consultar as 4 Camadas do RAG Evolutivo.\n\nCAMADAS CONSULTADAS:\n- Camada 1: Memória Especializada (últimas 5 análises do território)\n- Camada 2: Aprendizado Evolutivo (últimos 10 aprendizados do agente)\n- Camada 4: Expertise Dinâmica (nível atual de expertise)\n\nIMPORTÂNCIA:\n- Permite que o agente APRENDA de suas análises anteriores\n- Evita repetir conclusões já feitas\n- Aprofunda insights superficiais\n- Identifica mudanças ao longo do tempo\n\nSEM ESTE NÓ, O AGENTE NÃO EVOLUI!"
    }

def main():
    print("🚀 Gerando Workflow V6 (Com Memória RAG Evolutiva)...")
    
    # Carregar workflow V5
    print("📖 Lendo workflow V5...")
    v5_workflow = load_json(V5_PATH)
    
    # Criar novo workflow V6
    v6_workflow = v5_workflow.copy()
    v6_workflow["name"] = "WF-AGENT-ECON - Especialista Econômico V6 (Com Memória RAG)"
    
    # Carregar códigos
    print("📝 Carregando códigos...")
    sql_consultar_memoria = load_code(CONSULTAR_MEMORIA_SQL)
    code_preparar_contexto_v3 = load_code(PREPARAR_CONTEXTO_V3)
    
    # Criar nó Consultar Memória
    print("➕ Adicionando nó 'Consultar Memória e Aprendizados'...")
    consultar_memoria_node = create_consultar_memoria_node(sql_consultar_memoria)
    
    # Inserir nó após Normalizar Entrada
    nodes = v6_workflow["nodes"]
    
    # Encontrar posição do nó "Consultar Dados PostgreSQL"
    consultar_dados_index = None
    for i, node in enumerate(nodes):
        if node["name"] == "Consultar Dados PostgreSQL":
            consultar_dados_index = i
            break
    
    if consultar_dados_index is not None:
        # Inserir antes de "Consultar Dados PostgreSQL"
        nodes.insert(consultar_dados_index, consultar_memoria_node)
    else:
        # Fallback: inserir após "Normalizar Entrada"
        nodes.insert(2, consultar_memoria_node)
    
    # Atualizar código do nó "Preparar Contexto para LLM"
    print("🔄 Atualizando nó 'Preparar Contexto para LLM' (V3 - Com Memória)...")
    for node in nodes:
        if node["name"] == "Preparar Contexto para LLM":
            node["parameters"]["jsCode"] = code_preparar_contexto_v3
            node["notes"] = "FUNÇÃO: Preparar contexto estruturado para o LLM (V3 - COM MEMÓRIA).\n\nMUDANÇAS V3:\n- Integra dados das 4 Camadas do RAG Evolutivo\n- Inclui análises anteriores do território\n- Inclui aprendizados acumulados do agente\n- Inclui nível de expertise atual\n- Prompt adaptado para análise evolutiva\n\nRESULTADO:\n- Análises que EVOLUEM ao longo do tempo\n- Não repete conclusões anteriores\n- Aprofunda insights superficiais\n- Identifica mudanças e tendências"
    
    # Atualizar conexões
    print("🔗 Atualizando conexões...")
    connections = v6_workflow.get("connections", {})
    
    # Normalizar Entrada → Consultar Memória E Consultar Dados (paralelo)
    connections["Normalizar Entrada"] = {
        "main": [
            [
                {"node": "Consultar Memória e Aprendizados", "type": "main", "index": 0},
                {"node": "Consultar Dados PostgreSQL", "type": "main", "index": 0}
            ]
        ]
    }
    
    # Consultar Memória → Preparar Contexto
    connections["Consultar Memória e Aprendizados"] = {
        "main": [[{"node": "Preparar Contexto para LLM", "type": "main", "index": 0}]]
    }
    
    # Consultar Dados → Preparar Contexto (já existe, manter)
    # O nó "Preparar Contexto" agora recebe de DOIS nós
    
    v6_workflow["connections"] = connections
    
    # Salvar workflow V6
    print("💾 Salvando workflow V6...")
    with open(V6_PATH, 'w', encoding='utf-8') as f:
        json.dump(v6_workflow, f, indent=2, ensure_ascii=False)
    
    print(f"✅ Workflow V6 gerado com sucesso!")
    print(f"📍 Localização: {V6_PATH}")
    print(f"📊 Total de nós: {len(v6_workflow['nodes'])}")
    print("\n🎯 Mudanças principais:")
    print("  1. ➕ Novo nó: Consultar Memória e Aprendizados (PostgreSQL)")
    print("  2. 🔄 Atualizado: Preparar Contexto para LLM (V3 - Com Memória)")
    print("  3. 🔗 Conexões paralelas: Memória + Dados → Contexto")
    print("\n🧠 Camadas RAG Evolutivo Implementadas:")
    print("  ✅ Camada 1: Memória Especializada")
    print("  ✅ Camada 2: Aprendizado Evolutivo")
    print("  ✅ Camada 4: Expertise Dinâmica")
    print("  ⏳ Camada 3: Memória Organizacional (próxima fase)")
    
    return 0

if __name__ == "__main__":
    sys.exit(main())
