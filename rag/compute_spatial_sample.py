"""
Pré-computação de Relações Espaciais (Versão Simplificada)
Framework V6.0 - Fase 1: Infraestrutura e Curadoria

Demonstração do conceito com amostra de municípios.
Para produção: executar compute_spatial_relations.py completo.
"""

import json
import uuid
from datetime import datetime
from typing import List, Dict, Any, Tuple
from database import get_db_manager
from audit import get_audit_trail, AuditEvent
from config import Config


def parse_centroid(centroid_wkt: str) -> Tuple[float, float]:
    """Extrai coordenadas de um centroide em formato WKT."""
    coords_str = centroid_wkt.replace('POINT(', '').replace(')', '')
    lon, lat = map(float, coords_str.split())
    return (lon, lat)


def calculate_haversine_distance(
    coord1: Tuple[float, float], 
    coord2: Tuple[float, float]
) -> float:
    """Calcula distância entre dois pontos usando fórmula de Haversine."""
    import math
    
    lon1, lat1 = coord1
    lon2, lat2 = coord2
    
    R = 6371.0  # Raio da Terra em km
    
    lat1_rad = math.radians(lat1)
    lat2_rad = math.radians(lat2)
    dlon = math.radians(lon2 - lon1)
    dlat = math.radians(lat2 - lat1)
    
    a = math.sin(dlat / 2)**2 + math.cos(lat1_rad) * math.cos(lat2_rad) * math.sin(dlon / 2)**2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    distance = R * c
    
    return round(distance, 2)


def store_relation(
    db,
    territory_a: str,
    territory_b: str,
    relation_type: str,
    distance_km: float,
    metadata: Dict[str, Any]
) -> bool:
    """Armazena uma relação espacial no banco de dados."""
    
    try:
        query = """
            INSERT INTO spatial_relations (
                id, territory_id_a, territory_id_b, relation_type,
                distance_km, metadata, computed_at
            ) VALUES (
                %s, %s, %s, %s, %s, %s, %s
            )
            ON CONFLICT (territory_id_a, territory_id_b, relation_type)
            DO UPDATE SET
                distance_km = EXCLUDED.distance_km,
                metadata = EXCLUDED.metadata,
                updated_at = CURRENT_TIMESTAMP;
        """
        
        relation_id = str(uuid.uuid4())
        
        params = (
            relation_id,
            territory_a,
            territory_b,
            relation_type,
            distance_km,
            json.dumps(metadata),
            datetime.now()
        )
        
        db.execute_update(query, params)
        return True
        
    except Exception as e:
        print(f"❌ Erro ao armazenar relação: {e}")
        return False


def compute_sample_relations(sample_size: int = 20) -> Dict[str, int]:
    """
    Computa relações espaciais para uma amostra de municípios.
    
    Args:
        sample_size: Número de municípios para processar
        
    Returns:
        Dict com estatísticas do processamento
    """
    
    print("\n" + "=" * 80)
    print("PRÉ-COMPUTAÇÃO DE RELAÇÕES ESPACIAIS (AMOSTRA)")
    print("=" * 80)
    
    db = get_db_manager()
    audit = get_audit_trail()
    
    # Registrar início no audit trail
    event_id = audit.generate_event_id("spatial_computation")
    start_event = AuditEvent(
        event_id=event_id,
        event_type="spatial_computation",
        event_category="rag",
        agent_id="terra",
        action="compute_spatial_relations_sample",
        description=f"Início da pré-computação de relações espaciais (amostra de {sample_size} municípios)",
        status="success"
    )
    audit.log_event(start_event)
    
    # Carregar amostra de territórios
    query = f"""
        SELECT 
            id, name, type,
            ST_AsText(ST_Centroid(coordinates::geometry)) as centroid_wkt
        FROM territories
        WHERE type = 'Município'
        ORDER BY name
        LIMIT {sample_size};
    """
    
    territories = db.execute_query(query)
    
    if not territories:
        print("❌ Nenhum território encontrado")
        return {'total_territories': 0, 'relations_computed': 0}
    
    print(f"✅ Carregados {len(territories)} municípios")
    print(f"   Total de pares: {len(territories) * (len(territories) - 1) // 2}")
    
    stats = {
        'total_territories': len(territories),
        'distance_relations': 0,
        'failed_relations': 0
    }
    
    # Computar relações entre todos os pares
    print("\n📊 Computando distâncias...")
    
    for i, terr_a in enumerate(territories):
        for j, terr_b in enumerate(territories[i+1:], start=i+1):
            
            try:
                # Calcular distância entre centroides
                centroid_a = parse_centroid(terr_a['centroid_wkt'])
                centroid_b = parse_centroid(terr_b['centroid_wkt'])
                distance = calculate_haversine_distance(centroid_a, centroid_b)
                
                # Armazenar relação de distância
                if store_relation(
                    db=db,
                    territory_a=terr_a['id'],
                    territory_b=terr_b['id'],
                    relation_type='distance',
                    distance_km=distance,
                    metadata={
                        'name_a': terr_a['name'],
                        'name_b': terr_b['name'],
                        'sample': True
                    }
                ):
                    stats['distance_relations'] += 1
                    
                    if stats['distance_relations'] % 10 == 0:
                        print(f"   Processadas: {stats['distance_relations']} relações")
                else:
                    stats['failed_relations'] += 1
            
            except Exception as e:
                print(f"⚠️  Erro ao processar par ({terr_a['name']}, {terr_b['name']}): {e}")
                stats['failed_relations'] += 1
    
    # Registrar conclusão no audit trail
    end_event_id = audit.generate_event_id("spatial_computation")
    end_event = AuditEvent(
        event_id=end_event_id,
        event_type="spatial_computation",
        event_category="rag",
        agent_id="terra",
        action="compute_spatial_relations_sample_complete",
        description="Conclusão da pré-computação de relações espaciais (amostra)",
        metadata=stats,
        parent_event_id=event_id,
        status="success"
    )
    audit.log_event(end_event)
    
    db.close()
    
    print("\n" + "=" * 80)
    print("ESTATÍSTICAS FINAIS")
    print("=" * 80)
    for key, value in stats.items():
        print(f"{key.replace('_', ' ').title()}: {value}")
    
    return stats


if __name__ == "__main__":
    """Executa a pré-computação de amostra de relações espaciais."""
    
    try:
        Config.validate()
        
        # Processar amostra de 20 municípios (190 relações)
        stats = compute_sample_relations(sample_size=20)
        
        if stats['distance_relations'] > 0:
            print("\n✅ Pré-computação de amostra concluída com sucesso!")
            print("\n📝 NOTA: Para produção, executar compute_spatial_relations.py")
            print("   para processar todos os 139 municípios (9.591 relações).")
        else:
            print("\n⚠️  Nenhuma relação foi armazenada.")
        
    except Exception as e:
        print(f"\n❌ Erro na pré-computação: {e}")
        raise
