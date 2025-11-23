#!/usr/bin/env python3
"""
Script de Coleta de Territórios com Coordenadas Geográficas
Framework V6.0 - Coleta dados reais de 140 territórios do Tocantins

APIs utilizadas:
- IBGE Localidades: Dados básicos dos municípios
- Nominatim (OpenStreetMap): Coordenadas geográficas

Autor: Manus AI
Data: 2025-11-22
"""

import requests
import json
import time
from datetime import datetime

# Configurações
API_IBGE_BASE = "https://servicodados.ibge.gov.br/api/v1/localidades"
API_NOMINATIM_BASE = "https://nominatim.openstreetmap.org"
UF_TOCANTINS = "17"
OUTPUT_FILE = "insert_territories_with_coordinates.sql"
LOG_FILE = "collect_territories.log"

# User-Agent para Nominatim (obrigatório)
HEADERS_NOMINATIM = {
    "User-Agent": "Framework-V6-Tocantins/1.0 (pesquisa.academica@tocantins.gov.br)"
}

def log(message):
    """Registra mensagem no log e no console"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_message = f"[{timestamp}] {message}"
    print(log_message)
    with open(LOG_FILE, "a", encoding="utf-8") as f:
        f.write(log_message + "\n")

def get_coordinates_nominatim(nome_municipio, uf="TO"):
    """Obtém coordenadas geográficas via Nominatim (OpenStreetMap)"""
    try:
        # Construir query
        query = f"{nome_municipio}, {uf}, Brasil"
        
        params = {
            "q": query,
            "format": "json",
            "limit": 1,
            "addressdetails": 1
        }
        
        response = requests.get(
            f"{API_NOMINATIM_BASE}/search",
            params=params,
            headers=HEADERS_NOMINATIM,
            timeout=10
        )
        response.raise_for_status()
        data = response.json()
        
        if data and len(data) > 0:
            lat = float(data[0]["lat"])
            lon = float(data[0]["lon"])
            log(f"  ✓ Coordenadas obtidas: ({lat}, {lon})")
            return (lat, lon)
        else:
            log(f"  ⚠ Coordenadas não encontradas para {nome_municipio}")
            return None
            
    except Exception as e:
        log(f"  ✗ Erro ao obter coordenadas de {nome_municipio}: {e}")
        return None

def get_estado_tocantins():
    """Coleta dados do estado do Tocantins"""
    log("Coletando dados do estado do Tocantins...")
    
    url = f"{API_IBGE_BASE}/estados/{UF_TOCANTINS}"
    
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        data = response.json()
        
        estado = {
            "id": str(data["id"]),  # 17
            "nome": data["nome"],  # "Tocantins"
            "sigla": data["sigla"],  # "TO"
            "regiao": data["regiao"]["nome"],  # "Norte"
<<<<<<< HEAD
            "tipo": "Estado"
=======
            "tipo": "estado"
>>>>>>> 1a5c493f251a13cd1457ec398665cc6721dc37f8
        }
        
        log(f"✓ Estado coletado: {estado['nome']}")
        
        # Obter coordenadas do estado (capital Palmas)
        log("  Obtendo coordenadas do estado (Palmas)...")
        time.sleep(1)  # Respeitar rate limit do Nominatim
        coords = get_coordinates_nominatim("Palmas", "TO")
        estado["coordinates"] = coords
        
        return estado
        
    except Exception as e:
        log(f"✗ Erro ao coletar estado: {e}")
        return None

def get_municipios_tocantins():
    """Coleta dados de TODOS os municípios do Tocantins com coordenadas"""
    log("Coletando dados dos municípios do Tocantins...")
    
    url = f"{API_IBGE_BASE}/estados/{UF_TOCANTINS}/municipios"
    
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        data = response.json()
        
        municipios = []
        total = len(data)
        
        for idx, mun in enumerate(data, 1):
            municipio = {
                "id": str(mun["id"]),  # Código IBGE (7 dígitos)
                "nome": mun["nome"],
                "microrregiao": mun["microrregiao"]["nome"],
                "mesorregiao": mun["microrregiao"]["mesorregiao"]["nome"],
<<<<<<< HEAD
                "tipo": "Município",
=======
                "tipo": "municipio",
>>>>>>> 1a5c493f251a13cd1457ec398665cc6721dc37f8
                "uf": "TO"
            }
            
            log(f"[{idx}/{total}] {municipio['nome']}")
            
            # Obter coordenadas
            time.sleep(1)  # Respeitar rate limit do Nominatim (1 req/sec)
            coords = get_coordinates_nominatim(municipio["nome"], "TO")
            municipio["coordinates"] = coords
            
            municipios.append(municipio)
        
        log(f"✓ {len(municipios)} municípios coletados")
        return municipios
        
    except Exception as e:
        log(f"✗ Erro ao coletar municípios: {e}")
        return []

def generate_sql_insert(territorio, parent_id=None):
    """Gera SQL INSERT para um território"""
    
    # Escapar aspas simples no nome
    nome_escaped = territorio["nome"].replace("'", "''")
    
    # Metadados em JSON
<<<<<<< HEAD
    if territorio["tipo"] == "Estado":
=======
    if territorio["tipo"] == "estado":
>>>>>>> 1a5c493f251a13cd1457ec398665cc6721dc37f8
        metadata = json.dumps({
            "regiao": territorio["regiao"],
            "codigo_ibge": territorio["id"]
        }, ensure_ascii=False)
    else:
        metadata = json.dumps({
            "microrregiao": territorio["microrregiao"],
            "mesorregiao": territorio["mesorregiao"],
            "uf": territorio["uf"],
            "codigo_ibge": territorio["id"]
        }, ensure_ascii=False)
    
    # Escapar aspas simples no metadata
    metadata_escaped = metadata.replace("'", "''")
    
    # Parent ID (para municípios, é o ID do estado)
    parent_clause = f"'{parent_id}'" if parent_id else "NULL"
    
    # Coordenadas (formato PostGIS: POINT(longitude latitude))
    if territorio.get("coordinates"):
        lat, lon = territorio["coordinates"]
        coordinates_clause = f"ST_SetSRID(ST_MakePoint({lon}, {lat}), 4326)"
    else:
        coordinates_clause = "NULL"
    
    sql = f"""INSERT INTO territories (id, name, type, parent_id, metadata, coordinates)
VALUES (
    '{territorio['id']}',
    '{nome_escaped}',
    '{territorio['tipo']}',
    {parent_clause},
    '{metadata_escaped}'::jsonb,
    {coordinates_clause}
);
"""
    
    return sql

def main():
    """Função principal"""
    log("=" * 60)
    log("COLETA DE TERRITÓRIOS COM COORDENADAS GEOGRÁFICAS")
    log("=" * 60)
    log("")
    
    # Coletar estado
    estado = get_estado_tocantins()
    if not estado:
        log("✗ Falha ao coletar estado. Abortando.")
        return
    
    log("")
    
    # Coletar municípios
    municipios = get_municipios_tocantins()
    if not municipios:
        log("✗ Falha ao coletar municípios. Abortando.")
        return
    
    log("")
    log("=" * 60)
    log("GERANDO SQL")
    log("=" * 60)
    log("")
    
    # Gerar SQL
    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.write("-- Script de Inserção de Territórios com Coordenadas Geográficas\n")
        f.write(f"-- Gerado em: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"-- Total de territórios: {1 + len(municipios)}\n")
        f.write("--\n")
        f.write("-- APIs utilizadas:\n")
        f.write("-- - IBGE Localidades: Dados básicos\n")
        f.write("-- - Nominatim (OpenStreetMap): Coordenadas geográficas\n")
        f.write("--\n\n")
        
        f.write("BEGIN;\n\n")
        
        # Inserir estado
        f.write("-- Estado do Tocantins\n")
        f.write(generate_sql_insert(estado))
        f.write("\n")
        
        # Inserir municípios
        f.write("-- Municípios do Tocantins\n")
        for municipio in municipios:
            f.write(generate_sql_insert(municipio, parent_id=estado["id"]))
        
        f.write("\nCOMMIT;\n\n")
        
        # Estatísticas
        f.write("-- Verificar inserção\n")
        f.write("SELECT type, COUNT(*) as total FROM territories GROUP BY type;\n")
        f.write("SELECT COUNT(*) as total_com_coordenadas FROM territories WHERE coordinates IS NOT NULL;\n")
    
    log(f"✓ SQL gerado: {OUTPUT_FILE}")
    log("")
    log("=" * 60)
    log("COLETA FINALIZADA COM SUCESSO")
    log("=" * 60)
    log("")
    log(f"📊 Total de territórios: {1 + len(municipios)}")
    
    # Contar coordenadas obtidas
    coords_obtidas = 1 if estado.get("coordinates") else 0
    coords_obtidas += sum(1 for m in municipios if m.get("coordinates"))
    
    log(f"📍 Coordenadas obtidas: {coords_obtidas}/{1 + len(municipios)}")
    log(f"📄 Arquivo SQL: {OUTPUT_FILE}")
    log(f"📋 Log: {LOG_FILE}")
    log("")
    log("Para executar no PostgreSQL:")
    log(f"  psql $DATABASE_URL -f {OUTPUT_FILE}")
    log("")

if __name__ == "__main__":
    main()
