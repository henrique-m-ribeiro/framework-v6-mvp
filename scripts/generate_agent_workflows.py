#!/usr/bin/env python3
"""
Script para gerar workflows V6.1 dos agentes SOCIAL, TERRA e AMBIENT
baseados no workflow funcional do ECON V6.1.

Framework de Inteligência Territorial V6.0
Data: 30/11/2025
"""

import json
import re
from pathlib import Path

# Mapeamento de adaptações por agente
AGENT_CONFIGS = {
    "social": {
        "name": "WF-AGENT-SOCIAL - Especialista Social V6.1 (Multidimensional)",
        "webhook_path": "agent-social",
        "webhook_id": "agent-social-webhook",
        "dimension": "social",
        "agent_id": "social",
        "memory_table": "agent_social_memory",
        "learning_table": "agent_social_learning_evolution",
        "indicators_table": "social_indicators",
        "indicators_columns": ["idhm", "population", "literacy_rate", "income_per_capita"],
        "focus_areas": ["IDHM", "educação", "saúde"],
        "analysis_description": "desenvolvimento humano e social",
        "prompt_intro": "Você é o **Agente SOCIAL**, especialista em análise de desenvolvimento humano e social de territórios."
    },
    "terra": {
        "name": "WF-AGENT-TERRA - Especialista Territorial V6.1 (Multidimensional)",
        "webhook_path": "agent-terra",
        "webhook_id": "agent-terra-webhook",
        "dimension": "territorial",
        "agent_id": "terra",
        "memory_table": "agent_terra_memory",
        "learning_table": "agent_terra_learning_evolution",
        "indicators_table": "territorial_indicators",
        "indicators_columns": ["urbanized_area", "density", "sanitation_coverage"],
        "focus_areas": ["urbanização", "densidade", "saneamento"],
        "analysis_description": "ordenamento e uso do território",
        "prompt_intro": "Você é o **Agente TERRA**, especialista em análise territorial e uso do solo."
    },
    "ambient": {
        "name": "WF-AGENT-AMBIENT - Especialista Ambiental V6.1 (Multidimensional)",
        "webhook_path": "agent-ambient",
        "webhook_id": "agent-ambient-webhook",
        "dimension": "environmental",
        "agent_id": "ambient",
        "memory_table": "agent_ambient_memory",
        "learning_table": "agent_ambient_learning_evolution",
        "indicators_table": "environmental_indicators",
        "indicators_columns": ["vegetation_coverage", "deforested_area", "water_quality", "co2_emissions"],
        "focus_areas": ["cobertura vegetal", "desmatamento", "qualidade da água"],
        "analysis_description": "meio ambiente e sustentabilidade",
        "prompt_intro": "Você é o **Agente AMBIENT**, especialista em análise ambiental e sustentabilidade."
    }
}

def load_econ_workflow(path):
    """Carrega o workflow do ECON V6.1"""
    with open(path, 'r', encoding='utf-8') as f:
        return json.load(f)

def adapt_workflow(econ_workflow, agent_key):
    """Adapta o workflow do ECON para outro agente"""
    config = AGENT_CONFIGS[agent_key]
    workflow = json.loads(json.dumps(econ_workflow))  # Deep copy
    
    # 1. Atualizar nome do workflow
    workflow["name"] = config["name"]
    
    # 2. Percorrer todos os nós e adaptar
    for node in workflow["nodes"]:
        # Webhook
        if node["type"] == "n8n-nodes-base.webhook":
            node["parameters"]["path"] = config["webhook_path"]
            node["webhookId"] = config["webhook_id"]
            # Atualizar notas
            if "notes" in node:
                node["notes"] = node["notes"].replace("ECON", agent_key.upper())
                node["notes"] = node["notes"].replace("Econômico", config["analysis_description"].title())
                node["notes"] = node["notes"].replace("agent-econ", config["webhook_path"])
                node["notes"] = node["notes"].replace("economic", config["dimension"])
        
        # Nós com queries SQL
        if node["type"] == "n8n-nodes-base.postgres":
            if "query" in node["parameters"]:
                query = node["parameters"]["query"]
                
                # Substituir tabelas
                query = query.replace("agent_econ_memory", config["memory_table"])
                query = query.replace("agent_econ_learning_evolution", config["learning_table"])
                query = query.replace("economic_indicators", config["indicators_table"])
                
                # Substituir agent_id
                query = query.replace("'econ'", f"'{config['agent_id']}'")
                query = query.replace("get_agent_expertise('econ')", f"get_agent_expertise('{config['agent_id']}')")
                
                # Substituir dimension
                query = query.replace("'economic'", f"'{config['dimension']}'")
                
                # Atualizar query
                node["parameters"]["query"] = query
                
                # Atualizar notas
                if "notes" in node:
                    node["notes"] = node["notes"].replace("ECON", agent_key.upper())
                    node["notes"] = node["notes"].replace("agent_econ", f"agent_{config['agent_id']}")
        
        # Nós com código JavaScript
        if node["type"] == "n8n-nodes-base.code":
            if "jsCode" in node["parameters"]:
                code = node["parameters"]["jsCode"]
                
                # Substituir referências
                code = code.replace("ECON", agent_key.upper())
                code = code.replace("Econômico", config["analysis_description"].title())
                code = code.replace("'econ'", f"'{config['agent_id']}'")
                code = code.replace('"econ"', f'"{config["agent_id"]}"')
                code = code.replace("economic", config["dimension"])
                
                # Substituir focus_areas no código de normalização
                if "focus_areas" in code:
                    old_focus = '["PIB", "emprego", "renda"]'
                    new_focus = json.dumps(config["focus_areas"])
                    code = code.replace(old_focus, new_focus)
                
                # Atualizar código
                node["parameters"]["jsCode"] = code
                
                # Atualizar notas
                if "notes" in node:
                    node["notes"] = node["notes"].replace("ECON", agent_key.upper())
                    node["notes"] = node["notes"].replace("Econômico", config["analysis_description"].title())
        
        # Nós do OpenAI (atualizar prompt)
        if "openai" in node["type"].lower() or "llm" in node["type"].lower():
            # Atualizar notas
            if "notes" in node:
                node["notes"] = node["notes"].replace("ECON", agent_key.upper())
                node["notes"] = node["notes"].replace("econômica", config["analysis_description"])
    
    return workflow

def main():
    # Caminhos
    base_dir = Path(__file__).parent.parent
    econ_path = base_dir / "n8n" / "workflows" / "WF-AGENT-ECON-EspecialistaEconômicoV6.1(Multidimensional).json"
    output_dir = base_dir / "n8n" / "workflows"
    
    # Carregar workflow do ECON
    print(f"📖 Carregando workflow do ECON de: {econ_path}")
    econ_workflow = load_econ_workflow(econ_path)
    
    # Gerar workflows para cada agente
    for agent_key in ["social", "terra", "ambient"]:
        config = AGENT_CONFIGS[agent_key]
        print(f"\n🔧 Gerando workflow para agente {agent_key.upper()}...")
        
        # Adaptar workflow
        adapted_workflow = adapt_workflow(econ_workflow, agent_key)
        
        # Salvar
        output_path = output_dir / f"WF-AGENT-{agent_key.upper()}-V6.1-Multidimensional.json"
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(adapted_workflow, f, indent=2, ensure_ascii=False)
        
        print(f"   ✅ Salvo em: {output_path}")
        print(f"   📊 Webhook: /webhook/{config['webhook_path']}")
        print(f"   📋 Dimensão: {config['dimension']}")
        print(f"   🗄️ Tabelas: {config['memory_table']}, {config['learning_table']}")
    
    print("\n🎉 Todos os workflows foram gerados com sucesso!")
    print("\n📝 Próximos passos:")
    print("   1. Importar os workflows no n8n Cloud")
    print("   2. Ativar cada workflow")
    print("   3. Testar cada agente individualmente")

if __name__ == "__main__":
    main()
