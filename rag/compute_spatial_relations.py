"""
Pré-computação de Relações Espaciais - Framework V6.0
Fase 1: Infraestrutura e Curadoria

Calcula e armazena relações espaciais entre municípios do Tocantins
para otimizar consultas do Agente TERRA.

Baseado no Modelo Conceitual RAG Evolutivo v3.0 (Sessão #6)
"""

import json
import uuid
from datetime import datetime
from typing import List, Dict, Any, Tuple
from database import get_db_manager
from audit import get_audit_trail, AuditEvent
from config import Config


class SpatialRelationsComputer:
    """Computador de relações espaciais entre territórios."""
    
    def __init__(self):
        """Inicializa o computador de relações espaciais."""
        self.db = get_db_manager()
        self.audit = get_audit_trail()
    
    def get_territories(self) -> List[Dict[str, Any]]:
        """Recupera todos os territórios do banco de dados."""
        
        query = """
            SELECT 
                id,
                name,
                type,
                ST_AsText(ST_Centroid(coordinates::geometry)) as centroid_wkt,
                ST_AsGeoJSON(coordinates::geometry) as geometry_json
            FROM territories
            WHERE type = 'Município'
            ORDER BY name;
        """
        
        territories = self.db.execute_query(query)
        print(f"✅ Carregados {len(territories)} territórios")
        return territories
    
    def parse_centroid(self, centroid_wkt: str) -> Tuple[float, float]:
        """
        Extrai coordenadas de um centroide em formato WKT.
        
        Args:
            centroid_wkt: String WKT do centroide (ex: 'POINT(-48.123 -10.456)')
            
        Returns:
            Tupla (longitude, latitude)
        """
        # Formato: POINT(lon lat)
        coords_str = centroid_wkt.replace('POINT(', '').replace(')', '')
        lon, lat = map(float, coords_str.split())
        return (lon, lat)
    
    def calculate_haversine_distance(
        self, 
        coord1: Tuple[float, float], 
        coord2: Tuple[float, float]
    ) -> float:
        """
        Calcula distância entre dois pontos usando fórmula de Haversine.
        
        Args:
            coord1: Tupla (longitude, latitude) do ponto 1
            coord2: Tupla (longitude, latitude) do ponto 2
            
        Returns:
            Distância em quilômetros
        """
        import math
        
        lon1, lat1 = coord1
        lon2, lat2 = coord2
        
        # Raio da Terra em km
        R = 6371.0
        
        # Converter para radianos
        lat1_rad = math.radians(lat1)
        lat2_rad = math.radians(lat2)
        dlon = math.radians(lon2 - lon1)
        dlat = math.radians(lat2 - lat1)
        
        # Fórmula de Haversine
        a = math.sin(dlat / 2)**2 + math.cos(lat1_rad) * math.cos(lat2_rad) * math.sin(dlon / 2)**2
        c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
        distance = R * c
        
        return round(distance, 2)
    
    def check_if_neighbors(
        self, 
        geom1_json: str, 
        geom2_json: str
    ) -> Tuple[bool, float]:
        """
        Verifica se dois territórios são vizinhos (compartilham fronteira).
        
        Args:
            geom1_json: Geometria do território 1 em GeoJSON
            geom2_json: Geometria do território 2 em GeoJSON
            
        Returns:
            Tupla (são_vizinhos, comprimento_fronteira_km)
        """
        # Por simplicidade, usar query PostGIS para verificar interseção
        query = """
            SELECT 
                ST_Touches(
                    ST_GeomFromGeoJSON(%s)::geometry,
                    ST_GeomFromGeoJSON(%s)::geometry
                ) as are_neighbors,
                COALESCE(
                    ST_Length(
                        ST_Intersection(
                            ST_GeomFromGeoJSON(%s)::geometry,
                            ST_GeomFromGeoJSON(%s)::geometry
                        )::geography
                    ) / 1000.0,
                    0
                ) as border_length_km;
        """
        
        try:
            result = self.db.execute_query(
                query, 
                (geom1_json, geom2_json, geom1_json, geom2_json)
            )
            
            if result:
                are_neighbors = result[0]['are_neighbors']
                border_length = round(result[0]['border_length_km'], 2)
                return (are_neighbors, border_length)
            else:
                return (False, 0.0)
                
        except Exception as e:
            print(f"⚠️  Erro ao verificar vizinhança: {e}")
            return (False, 0.0)
    
    def store_relation(
        self,
        territory_a: str,
        territory_b: str,
        relation_type: str,
        distance_km: float = None,
        border_length_km: float = None,
        metadata: Dict[str, Any] = None
    ) -> bool:
        """Armazena uma relação espacial no banco de dados."""
        
        try:
            query = """
                INSERT INTO spatial_relations (
                    id, territory_id_a, territory_id_b, relation_type,
                    distance_km, shared_border_length_km, metadata,
                    computed_at
                ) VALUES (
                    %s, %s, %s, %s, %s, %s, %s, %s
                )
                ON CONFLICT (territory_id_a, territory_id_b, relation_type)
                DO UPDATE SET
                    distance_km = EXCLUDED.distance_km,
                    shared_border_length_km = EXCLUDED.shared_border_length_km,
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
                border_length_km,
                json.dumps(metadata) if metadata else None,
                datetime.now()
            )
            
            self.db.execute_update(query, params)
            return True
            
        except Exception as e:
            print(f"❌ Erro ao armazenar relação: {e}")
            return False
    
    def compute_all_relations(self) -> Dict[str, int]:
        """
        Computa todas as relações espaciais entre territórios.
        
        Returns:
            Dict com estatísticas do processamento
        """
        
        print("\n" + "=" * 80)
        print("PRÉ-COMPUTAÇÃO DE RELAÇÕES ESPACIAIS")
        print("=" * 80)
        
        # Registrar início no audit trail
        event_id = self.audit.generate_event_id("spatial_computation")
        start_event = AuditEvent(
            event_id=event_id,
            event_type="spatial_computation",
            event_category="rag",
            agent_id="terra",
            action="compute_spatial_relations",
            description="Início da pré-computação de relações espaciais",
            status="success"
        )
        self.audit.log_event(start_event)
        
        # Carregar territórios
        territories = self.get_territories()
        
        if not territories:
            print("❌ Nenhum território encontrado no banco de dados")
            return {'total_territories': 0, 'relations_computed': 0}
        
        stats = {
            'total_territories': len(territories),
            'distance_relations': 0,
            'neighbor_relations': 0,
            'failed_relations': 0
        }
        
        print(f"\n📊 Computando relações para {len(territories)} territórios...")
        print(f"   Total de pares: {len(territories) * (len(territories) - 1) // 2}")
        
        # Computar relações entre todos os pares
        for i, terr_a in enumerate(territories):
            for j, terr_b in enumerate(territories[i+1:], start=i+1):
                
                # Progresso
                if (i * len(territories) + j) % 100 == 0:
                    print(f"   Processando: {i}/{len(territories)} territórios...")
                
                try:
                    # Calcular distância entre centroides
                    centroid_a = self.parse_centroid(terr_a['centroid_wkt'])
                    centroid_b = self.parse_centroid(terr_b['centroid_wkt'])
                    distance = self.calculate_haversine_distance(centroid_a, centroid_b)
                    
                    # Armazenar relação de distância
                    if self.store_relation(
                        territory_a=terr_a['id'],
                        territory_b=terr_b['id'],
                        relation_type='distance',
                        distance_km=distance,
                        metadata={
                            'name_a': terr_a['name'],
                            'name_b': terr_b['name']
                        }
                    ):
                        stats['distance_relations'] += 1
                    else:
                        stats['failed_relations'] += 1
                    
                    # Verificar se são vizinhos (apenas para territórios próximos)
                    if distance < 200:  # Limitar verificação de vizinhança a territórios próximos
                        are_neighbors, border_length = self.check_if_neighbors(
                            terr_a['geometry_json'],
                            terr_b['geometry_json']
                        )
                        
                        if are_neighbors:
                            if self.store_relation(
                                territory_a=terr_a['id'],
                                territory_b=terr_b['id'],
                                relation_type='neighbor',
                                distance_km=distance,
                                border_length_km=border_length,
                                metadata={
                                    'name_a': terr_a['name'],
                                    'name_b': terr_b['name']
                                }
                            ):
                                stats['neighbor_relations'] += 1
                            else:
                                stats['failed_relations'] += 1
                
                except Exception as e:
                    print(f"⚠️  Erro ao processar par ({terr_a['name']}, {terr_b['name']}): {e}")
                    stats['failed_relations'] += 1
        
        # Registrar conclusão no audit trail
        end_event_id = self.audit.generate_event_id("spatial_computation")
        end_event = AuditEvent(
            event_id=end_event_id,
            event_type="spatial_computation",
            event_category="rag",
            agent_id="terra",
            action="compute_spatial_relations_complete",
            description="Conclusão da pré-computação de relações espaciais",
            metadata=stats,
            parent_event_id=event_id,
            status="success"
        )
        self.audit.log_event(end_event)
        
        print("\n" + "=" * 80)
        print("ESTATÍSTICAS FINAIS")
        print("=" * 80)
        for key, value in stats.items():
            print(f"{key.replace('_', ' ').title()}: {value}")
        
        return stats


if __name__ == "__main__":
    """Executa a pré-computação de relações espaciais."""
    
    try:
        Config.validate()
        
        computer = SpatialRelationsComputer()
        stats = computer.compute_all_relations()
        
        if stats['distance_relations'] > 0:
            print("\n✅ Pré-computação concluída com sucesso!")
        else:
            print("\n⚠️  Pré-computação concluída, mas nenhuma relação foi armazenada.")
        
    except Exception as e:
        print(f"\n❌ Erro na pré-computação: {e}")
        raise
