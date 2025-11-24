#!/usr/bin/env python3
"""
Script 3: Inserir Metadados no Banco
Framework V6.0 - Popular indicator_metadata

Este script insere os metadados gerados na tabela indicator_metadata do PostgreSQL.

Requisitos:
- pip install psycopg2-binary
- export DATABASE_URL="postgresql://..."

Uso: python3 03_insert_metadata.py
"""

import json
import os
import psycopg2
from psycopg2.extras import Json

def main():
    # Verificar DATABASE_URL
    database_url = os.getenv("DATABASE_URL")
    if not database_url:
        print("❌ ERRO: DATABASE_URL não definida")
        print("Execute: export DATABASE_URL='postgresql://...'")
        return
    
    # Carregar metadados
    script_dir = os.path.dirname(os.path.abspath(__file__))
    input_file = os.path.join(script_dir, "indicator_metadata.json")
    
    if not os.path.exists(input_file):
        print(f"❌ ERRO: Arquivo {input_file} não encontrado")
        print("Execute primeiro: python3 02_generate_metadata.py")
        return
    
    with open(input_file, "r", encoding="utf-8") as f:
        metadata_list = json.load(f)
    
    print("=" * 60)
    print("INSERÇÃO DE METADADOS NO BANCO")
    print("=" * 60)
    print(f"\n📊 Total de metadados: {len(metadata_list)}")
    print(f"🗄️  Banco: {database_url[:30]}...")
    print("\n" + "=" * 60)
    
    input("\nPressione ENTER para iniciar a inserção...")
    print()
    
    # Conectar ao banco
    try:
        conn = psycopg2.connect(database_url)
        cur = conn.cursor()
        print("✓ Conexão estabelecida\n")
    except Exception as e:
        print(f"❌ ERRO ao conectar: {e}")
        return
    
    # Verificar se tabela existe
    cur.execute("""
        SELECT EXISTS (
            SELECT FROM information_schema.tables 
            WHERE table_name = 'indicator_metadata'
        );
    """)
    
    if not cur.fetchone()[0]:
        print("⚠️  Tabela indicator_metadata não existe. Criando...")
        
        cur.execute("""
            CREATE TABLE indicator_metadata (
                id SERIAL PRIMARY KEY,
                indicator_code VARCHAR(50) UNIQUE NOT NULL,
                dimension VARCHAR(50) NOT NULL,
                name VARCHAR(200) NOT NULL,
                description TEXT,
                unit VARCHAR(50),
                source VARCHAR(200),
                methodology TEXT,
                interpretation_guide TEXT,
                good_range JSONB,
                alert_range JSONB,
                created_at TIMESTAMP DEFAULT NOW(),
                updated_at TIMESTAMP DEFAULT NOW()
            );
        """)
        conn.commit()
        print("✓ Tabela criada\n")
    
    # Inserir metadados
    success_count = 0
    error_count = 0
    
    for i, metadata in enumerate(metadata_list, 1):
        indicator_code = metadata.get("indicator_code")
        print(f"[{i}/{len(metadata_list)}] {indicator_code}...", end=" ")
        
        try:
            cur.execute("""
                INSERT INTO indicator_metadata (
                    indicator_code, dimension, name, description, unit,
                    source, methodology, interpretation_guide, 
                    good_range, alert_range
                ) VALUES (
                    %(indicator_code)s, %(dimension)s, %(name)s, %(description)s, %(unit)s,
                    %(source)s, %(methodology)s, %(interpretation_guide)s,
                    %(good_range)s, %(alert_range)s
                )
                ON CONFLICT (indicator_code) DO UPDATE SET
                    dimension = EXCLUDED.dimension,
                    name = EXCLUDED.name,
                    description = EXCLUDED.description,
                    unit = EXCLUDED.unit,
                    source = EXCLUDED.source,
                    methodology = EXCLUDED.methodology,
                    interpretation_guide = EXCLUDED.interpretation_guide,
                    good_range = EXCLUDED.good_range,
                    alert_range = EXCLUDED.alert_range,
                    updated_at = NOW();
            """, {
                "indicator_code": metadata.get("indicator_code"),
                "dimension": metadata.get("dimension"),
                "name": metadata.get("name"),
                "description": metadata.get("description"),
                "unit": metadata.get("unit"),
                "source": metadata.get("source"),
                "methodology": metadata.get("methodology"),
                "interpretation_guide": metadata.get("interpretation_guide"),
                "good_range": Json(metadata.get("good_range")),
                "alert_range": Json(metadata.get("alert_range"))
            })
            
            success_count += 1
            print("✓")
            
        except Exception as e:
            error_count += 1
            print(f"✗ Erro: {e}")
    
    # Commit
    conn.commit()
    
    # Verificar resultado
    cur.execute("SELECT COUNT(*) FROM indicator_metadata;")
    total_in_db = cur.fetchone()[0]
    
    # Fechar conexão
    cur.close()
    conn.close()
    
    print("\n" + "=" * 60)
    print("INSERÇÃO CONCLUÍDA")
    print("=" * 60)
    print(f"\n✓ Inseridos com sucesso: {success_count}")
    if error_count > 0:
        print(f"✗ Erros: {error_count}")
    print(f"📊 Total na tabela: {total_in_db}")
    print("\n🎉 Metadados prontos para uso no dashboard!")
    print("=" * 60)

if __name__ == "__main__":
    main()
