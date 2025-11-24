#!/usr/bin/env python3
"""
Script: Geração em Lote de Análises para Knowledge Base
Framework V6.0 - Popular knowledge_base

Este script gera análises de IA para múltiplos territórios usando os agentes especialistas.

Requisitos:
- pip install requests psycopg2-binary
- export DATABASE_URL="postgresql://..."
- Agentes especialistas devem estar ativos no n8n

Uso: 
  python3 batch_generate_analyses.py --top 20  # Top 20 municípios
  python3 batch_generate_analyses.py --all     # Todos os territórios
"""

import requests
import psycopg2
import os
import time
import json
import argparse
from datetime import datetime

# URLs dos webhooks dos agentes (CONFIGURAR AQUI)
AGENTS = {
    'economic': 'https://galactic-ai.app.n8n.cloud/webhook/agent-econ',
    'social': 'https://galactic-ai.app.n8n.cloud/webhook/agent-social',
    'territorial': 'https://galactic-ai.app.n8n.cloud/webhook/agent-terra',
    'environmental': 'https://galactic-ai.app.n8n.cloud/webhook/agent-ambient'
}

def get_territories(conn, limit=None):
    """Busca territórios do banco, ordenados por população"""
    cur = conn.cursor()
    
    query = """
        SELECT DISTINCT t.id, t.name, MAX(si.population) as pop
        FROM territories t
        JOIN social_indicators si ON t.id = si.territory_id
        WHERE t.type = 'Município'
        GROUP BY t.id, t.name
        ORDER BY pop DESC
    """
    
    if limit:
        query += f" LIMIT {limit}"
    
    cur.execute(query)
    territories = cur.fetchall()
    cur.close()
    
    return territories

def call_agent(webhook_url, territory_id, territory_name):
    """Chama um agente especialista via webhook"""
    try:
        response = requests.post(
            webhook_url,
            json={
                'territory_id': territory_id,
                'territory_name': territory_name,
                'analysis_type': 'diagnostic'
            },
            timeout=30
        )
        
        if response.status_code == 200:
            return response.json()
        else:
            return None
            
    except requests.exceptions.RequestException as e:
        return None

def save_analysis(conn, territory_id, dimension, analysis_data):
    """Salva análise na knowledge_base"""
    cur = conn.cursor()
    
    try:
        cur.execute("""
            INSERT INTO knowledge_base (
                territory_id, 
                dimension, 
                analysis_type, 
                content, 
                metadata,
                created_at,
                updated_at
            ) VALUES (
                %s, %s, %s, %s, %s, NOW(), NOW()
            )
            ON CONFLICT (territory_id, dimension, analysis_type) 
            DO UPDATE SET
                content = EXCLUDED.content,
                metadata = EXCLUDED.metadata,
                updated_at = NOW();
        """, (
            territory_id,
            dimension,
            'diagnostic',
            analysis_data.get('analysis', ''),
            json.dumps(analysis_data.get('metadata', {}))
        ))
        
        conn.commit()
        return True
        
    except Exception as e:
        print(f"\n      Erro ao salvar: {e}")
        conn.rollback()
        return False
    finally:
        cur.close()

def main():
    parser = argparse.ArgumentParser(description='Gerar análises em lote para knowledge base')
    parser.add_argument('--top', type=int, help='Gerar para os N maiores municípios')
    parser.add_argument('--all', action='store_true', help='Gerar para todos os municípios')
    args = parser.parse_args()
    
    if not args.top and not args.all:
        print("❌ Especifique --top N ou --all")
        return
    
    # Verificar DATABASE_URL
    database_url = os.getenv("DATABASE_URL")
    if not database_url:
        print("❌ ERRO: DATABASE_URL não definida")
        return
    
    # Conectar ao banco
    try:
        conn = psycopg2.connect(database_url)
        print("✓ Conexão estabelecida")
    except Exception as e:
        print(f"❌ ERRO ao conectar: {e}")
        return
    
    # Verificar se tabela existe
    cur = conn.cursor()
    cur.execute("""
        SELECT EXISTS (
            SELECT FROM information_schema.tables 
            WHERE table_name = 'knowledge_base'
        );
    """)
    
    if not cur.fetchone()[0]:
        print("⚠️  Tabela knowledge_base não existe. Criando...")
        
        cur.execute("""
            CREATE TABLE knowledge_base (
                id SERIAL PRIMARY KEY,
                territory_id VARCHAR(10) REFERENCES territories(id),
                dimension VARCHAR(50) NOT NULL,
                analysis_type VARCHAR(50) NOT NULL,
                content TEXT NOT NULL,
                metadata JSONB,
                embedding VECTOR(1536),
                created_at TIMESTAMP DEFAULT NOW(),
                updated_at TIMESTAMP DEFAULT NOW(),
                UNIQUE(territory_id, dimension, analysis_type)
            );
        """)
        conn.commit()
        print("✓ Tabela criada")
    cur.close()
    
    # Buscar territórios
    limit = args.top if args.top else None
    territories = get_territories(conn, limit)
    
    print("\n" + "=" * 70)
    print("GERAÇÃO EM LOTE DE ANÁLISES")
    print("=" * 70)
    print(f"\n📊 Territórios: {len(territories)}")
    print(f"🤖 Dimensões: 4 (economic, social, territorial, environmental)")
    print(f"📝 Total de análises: {len(territories) * 4}")
    print(f"⏱️  Tempo estimado: {len(territories) * 4 * 8 / 60:.1f} minutos")
    print(f"💰 Custo estimado: ~${len(territories) * 4 * 0.001:.2f}")
    print("\n" + "=" * 70)
    
    input("\nPressione ENTER para iniciar...")
    print()
    
    start_time = datetime.now()
    stats = {
        'total': 0,
        'success': 0,
        'error': 0,
        'by_dimension': {}
    }
    
    # Processar cada território
    for i, (territory_id, territory_name, population) in enumerate(territories, 1):
        print(f"\n[{i}/{len(territories)}] {territory_name} (pop: {int(population):,})")
        
        for dimension, webhook_url in AGENTS.items():
            stats['total'] += 1
            print(f"  • {dimension}...", end=" ", flush=True)
            
            # Chamar agente
            analysis_data = call_agent(webhook_url, territory_id, territory_name)
            
            if analysis_data:
                # Salvar no banco
                if save_analysis(conn, territory_id, dimension, analysis_data):
                    stats['success'] += 1
                    stats['by_dimension'][dimension] = stats['by_dimension'].get(dimension, 0) + 1
                    print("✓")
                else:
                    stats['error'] += 1
                    print("✗ (erro ao salvar)")
            else:
                stats['error'] += 1
                print("✗ (erro na chamada)")
            
            # Rate limiting
            time.sleep(2)
    
    # Estatísticas finais
    end_time = datetime.now()
    duration = (end_time - start_time).total_seconds()
    
    # Verificar total no banco
    cur = conn.cursor()
    cur.execute("SELECT COUNT(*) FROM knowledge_base;")
    total_in_db = cur.fetchone()[0]
    cur.close()
    
    conn.close()
    
    print("\n" + "=" * 70)
    print("GERAÇÃO CONCLUÍDA")
    print("=" * 70)
    print(f"\n⏱️  Tempo total: {duration/60:.1f} minutos")
    print(f"\n📊 Estatísticas:")
    print(f"  • Total processadas: {stats['total']}")
    print(f"  • Sucesso: {stats['success']} ({stats['success']/stats['total']*100:.1f}%)")
    print(f"  • Erros: {stats['error']}")
    print(f"\n📈 Por dimensão:")
    for dimension, count in sorted(stats['by_dimension'].items()):
        print(f"  • {dimension}: {count}")
    print(f"\n🗄️  Total na knowledge_base: {total_in_db}")
    print("\n🎉 Análises prontas para uso no dashboard!")
    print("=" * 70)

if __name__ == "__main__":
    main()
