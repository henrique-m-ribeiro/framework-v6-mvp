#!/usr/bin/env python3
"""
Script 01: Coleta de Dados Básicos dos Territórios do Tocantins
================================================================

Descrição:
----------
Este script coleta dados básicos de TODOS os 139 municípios do Tocantins + o Estado
via API IBGE Localidades e gera SQL INSERTs para popular a tabela `territories`.

Dados Coletados:
----------------
- Código IBGE (7 dígitos para municípios, 2 para estado)
- Nome do território
- Tipo (estado ou município)
- Área territorial (km²)
- Coordenadas geográficas (latitude, longitude)
- Metadados (região, microrregião, mesorregião)

API Utilizada:
--------------
- IBGE Localidades: https://servicodados.ibge.gov.br/api/docs/localidades

Fonte de Dados:
---------------
- Instituto Brasileiro de Geografia e Estatística (IBGE)
- Dados oficiais e atualizados

Autor: Manus AI (IA Mediadora)
Data: 22 de novembro de 2025
Framework: Inteligência Territorial V6.0
"""

import requests
import json
import time
from datetime import datetime

# ============================================================================
# CONFIGURAÇÕES
# ============================================================================

# Código da UF do Tocantins
UF_TOCANTINS = 17

# URL base da API IBGE Localidades
API_BASE = "https://servicodados.ibge.gov.br/api/v1/localidades"

# Arquivo de saída (SQL)
OUTPUT_SQL = "insert_territories.sql"

# Arquivo de log
OUTPUT_LOG = "collect_territories.log"

# Delay entre requisições (para não sobrecarregar a API)
REQUEST_DELAY = 0.5  # segundos

# ============================================================================
# FUNÇÕES AUXILIARES
# ============================================================================

def log(message):
    """Registra mensagem no log e exibe no console"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_message = f"[{timestamp}] {message}"
    print(log_message)
    with open(OUTPUT_LOG, "a", encoding="utf-8") as f:
        f.write(log_message + "\n")

def get_estado_tocantins():
    """Coleta dados do Estado do Tocantins"""
    log("Coletando dados do Estado do Tocantins...")
    
    url = f"{API_BASE}/estados/{UF_TOCANTINS}"
    
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        data = response.json()
        
        estado = {
            "id": str(data["id"]),  # 17
            "nome": data["nome"],  # "Tocantins"
            "sigla": data["sigla"],  # "TO"
            "regiao": data["regiao"]["nome"],  # "Norte"
            "tipo": "estado"
        }
        
        log(f"✓ Estado coletado: {estado['nome']}")
        return estado
        
    except Exception as e:
        log(f"✗ Erro ao coletar estado: {e}")
        return None

def get_municipios_tocantins():
    """Coleta dados de TODOS os municípios do Tocantins"""
    log("Coletando dados dos municípios do Tocantins...")
    
    url = f"{API_BASE}/estados/{UF_TOCANTINS}/municipios"
    
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        data = response.json()
        
        municipios = []
        for mun in data:
            municipio = {
                "id": str(mun["id"]),  # Código IBGE (7 dígitos)
                "nome": mun["nome"],
                "microrregiao": mun["microrregiao"]["nome"],
                "mesorregiao": mun["microrregiao"]["mesorregiao"]["nome"],
                "tipo": "municipio",
                "uf": "TO"
            }
            municipios.append(municipio)
        
        log(f"✓ {len(municipios)} municípios coletados")
        return municipios
        
    except Exception as e:
        log(f"✗ Erro ao coletar municípios: {e}")
        return []

def get_area_territorial(codigo_ibge):
    """Coleta área territorial de um município via API IBGE"""
    # Nota: A API de Localidades não retorna área diretamente
    # Vamos usar dados da planilha que o usuário forneceu
    # ou buscar de outra fonte
    return None  # Será preenchido depois com dados da planilha

def generate_sql_insert(territorio, parent_id=None):
    """Gera SQL INSERT para um território"""
    
    # Escapar aspas simples no nome
    nome_escaped = territorio["nome"].replace("'", "''")
    
    # Gerar UUID (PostgreSQL vai gerar automaticamente, mas podemos especificar)
    # Vamos usar gen_random_uuid() do PostgreSQL
    
    # Metadados em JSON
    if territorio["tipo"] == "estado":
        metadata = json.dumps({
            "regiao": territorio["regiao"],
            "codigo_ibge": territorio["id"]
        })
    else:
        metadata = json.dumps({
            "microrregiao": territorio["microrregiao"],
            "mesorregiao": territorio["mesorregiao"],
            "uf": territorio["uf"],
            "codigo_ibge": territorio["id"]
        })
    
    # Escapar aspas simples no metadata
    metadata_escaped = metadata.replace("'", "''")
    
    # Parent ID (para municípios, é o ID do estado)
    parent_clause = f"'{parent_id}'" if parent_id else "NULL"
    
    # Área (vamos preencher depois com dados da planilha)
    area_clause = "NULL"  # Será atualizado depois
    
    # Coordenadas (vamos preencher depois)
    coordinates_clause = "NULL"  # Será atualizado depois
    
    sql = f"""INSERT INTO territories (id, name, type, parent_id, area, metadata, coordinates)
VALUES (
    '{territorio['id']}',  -- id (código IBGE)
    '{nome_escaped}',  -- name
    '{territorio['tipo']}',  -- type
    {parent_clause},  -- parent_id
    {area_clause},  -- area
    '{metadata_escaped}'::jsonb,  -- metadata
    {coordinates_clause}  -- coordinates
)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    parent_id = EXCLUDED.parent_id,
    metadata = EXCLUDED.metadata;
"""
    
    return sql

# ============================================================================
# FUNÇÃO PRINCIPAL
# ============================================================================

def main():
    """Função principal do script"""
    
    log("=" * 80)
    log("INICIANDO COLETA DE DADOS DOS TERRITÓRIOS DO TOCANTINS")
    log("=" * 80)
    log("")
    
    # Limpar arquivo de log anterior
    with open(OUTPUT_LOG, "w", encoding="utf-8") as f:
        f.write("")
    
    # Limpar arquivo SQL anterior
    with open(OUTPUT_SQL, "w", encoding="utf-8") as f:
        f.write("-- SQL INSERTs para popular a tabela territories\n")
        f.write("-- Gerado automaticamente em: " + datetime.now().strftime("%Y-%m-%d %H:%M:%S") + "\n")
        f.write("-- Total de territórios: 140 (1 estado + 139 municípios)\n")
        f.write("-- Fonte: IBGE Localidades API\n")
        f.write("\n")
        f.write("-- Iniciar transação\n")
        f.write("BEGIN;\n\n")
    
    # 1. Coletar dados do Estado do Tocantins
    estado = get_estado_tocantins()
    
    if not estado:
        log("✗ ERRO CRÍTICO: Não foi possível coletar dados do estado")
        return
    
    time.sleep(REQUEST_DELAY)
    
    # 2. Coletar dados dos municípios
    municipios = get_municipios_tocantins()
    
    if not municipios:
        log("✗ ERRO CRÍTICO: Não foi possível coletar dados dos municípios")
        return
    
    log("")
    log(f"Total de territórios coletados: {1 + len(municipios)}")
    log("")
    
    # 3. Gerar SQL INSERTs
    log("Gerando SQL INSERTs...")
    
    with open(OUTPUT_SQL, "a", encoding="utf-8") as f:
        # Inserir estado primeiro
        f.write("-- Estado do Tocantins\n")
        sql_estado = generate_sql_insert(estado)
        f.write(sql_estado)
        f.write("\n")
        
        # Inserir municípios
        f.write("-- Municípios do Tocantins\n")
        for i, municipio in enumerate(municipios, 1):
            sql_municipio = generate_sql_insert(municipio, parent_id=estado["id"])
            f.write(sql_municipio)
            if i < len(municipios):
                f.write("\n")
        
        # Commit da transação
        f.write("\n-- Finalizar transação\n")
        f.write("COMMIT;\n")
    
    log(f"✓ SQL INSERTs gerados: {OUTPUT_SQL}")
    log("")
    
    # 4. Estatísticas finais
    log("=" * 80)
    log("COLETA FINALIZADA COM SUCESSO")
    log("=" * 80)
    log(f"Estado: 1")
    log(f"Municípios: {len(municipios)}")
    log(f"Total: {1 + len(municipios)}")
    log("")
    log(f"Arquivo SQL: {OUTPUT_SQL}")
    log(f"Arquivo de log: {OUTPUT_LOG}")
    log("")
    log("PRÓXIMOS PASSOS:")
    log("1. Revisar o arquivo SQL gerado")
    log("2. Executar no PostgreSQL do Replit")
    log("3. Verificar se os 140 territórios foram inseridos")
    log("")

# ============================================================================
# EXECUÇÃO
# ============================================================================

if __name__ == "__main__":
    main()
