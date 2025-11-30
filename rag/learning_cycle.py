"""
Módulo de Ciclo de Aprendizagem Evolutiva

Este módulo implementa a lógica de atualização da memória e aprendizado dos agentes,
incluindo versionamento de análises e cálculo de expertise.
"""

import psycopg2
from datetime import datetime
from typing import Dict, List, Optional
from enum import Enum
import json

from config import Config
from audit import AuditTrail


class ExpertiseLevel(Enum):
    """Níveis de expertise do agente baseados no número de ciclos de aprendizado"""
    NOVATO = 1          # 0-10 ciclos
    COMPETENTE = 2      # 11-30 ciclos
    PROFICIENTE = 3     # 31-60 ciclos
    AVANCADO = 4        # 61-100 ciclos
    ESPECIALISTA = 5    # 100+ ciclos


class LearningCycle:
    """Gerencia o ciclo de aprendizagem evolutiva dos agentes"""
    
    def __init__(self):
        self.audit = AuditTrail()
        self.conn = psycopg2.connect(
            host=Config.DB_HOST,
            port=Config.DB_PORT,
            database=Config.DB_NAME,
            user=Config.DB_USER,
            password=Config.DB_PASSWORD
        )
    
    def update_memory_and_learning(
        self,
        agent_id: str,
        new_analysis_id: str,
        synthesis: Dict,
        similar_analysis_ids: List[str]
    ) -> Dict:
        """
        Atualiza a memória especializada e registra o aprendizado
        
        Args:
            agent_id: ID do agente (ex: 'econ', 'social')
            new_analysis_id: ID da nova análise que iniciou o ciclo
            synthesis: Dicionário com a síntese gerada pelo LLM
            similar_analysis_ids: IDs das análises similares comparadas
        
        Returns:
            Dicionário com o resultado da atualização
        """
        cursor = self.conn.cursor()
        
        try:
            # 1. Arquivar análises antigas (soft delete)
            self._archive_old_analyses(cursor, agent_id, similar_analysis_ids)
            
            # 2. Salvar aprendizado na Camada 2
            learning_id = self._save_learning(
                cursor,
                agent_id,
                synthesis,
                new_analysis_id,
                similar_analysis_ids
            )
            
            # 3. Atualizar contador de expertise
            expertise_level = self._update_expertise(cursor, agent_id)
            
            # 4. Registrar na auditoria
            self.audit.log_event(
                event_type="learning_cycle_completed",
                event_category="system",
                agent_id=agent_id,
                action="update_memory_and_learning",
                description=f"Ciclo de aprendizagem concluído. Nível de expertise: {expertise_level.name}",
                metadata={
                    "learning_id": learning_id,
                    "new_analysis_id": new_analysis_id,
                    "archived_analyses": similar_analysis_ids,
                    "expertise_level": expertise_level.name
                },
                success=True
            )
            
            self.conn.commit()
            
            return {
                "success": True,
                "learning_id": learning_id,
                "expertise_level": expertise_level.name,
                "archived_count": len(similar_analysis_ids)
            }
            
        except Exception as e:
            self.conn.rollback()
            self.audit.log_event(
                event_type="learning_cycle_failed",
                event_category="system",
                agent_id=agent_id,
                action="update_memory_and_learning",
                description=f"Falha no ciclo de aprendizagem: {str(e)}",
                success=False
            )
            raise
        
        finally:
            cursor.close()
    
    def _archive_old_analyses(
        self,
        cursor,
        agent_id: str,
        analysis_ids: List[str]
    ):
        """Marca análises antigas como arquivadas (soft delete)"""
        table_name = f"agent_{agent_id}_memory"
        
        for analysis_id in analysis_ids:
            cursor.execute(f"""
                UPDATE {table_name}
                SET 
                    metadata = COALESCE(metadata, '{{}}'::jsonb) || '{{"archived": true, "archived_at": "{datetime.now().isoformat()}"}}'::jsonb
                WHERE id = %s
            """, (analysis_id,))
    
    def _save_learning(
        self,
        cursor,
        agent_id: str,
        synthesis: Dict,
        new_analysis_id: str,
        similar_analysis_ids: List[str]
    ) -> str:
        """Salva o aprendizado na Camada 2 (Memória de Aprendizado Evolutiva)"""
        table_name = f"agent_{agent_id}_learning_evolution"
        
        cursor.execute(f"""
            INSERT INTO {table_name} (
                agent_id,
                learning_type,
                source_analysis_ids,
                learning_content,
                confidence_score,
                metadata,
                created_at
            ) VALUES (
                %s, %s, %s, %s, %s, %s, %s
            )
            RETURNING id
        """, (
            agent_id,
            'synthesis',
            ','.join([new_analysis_id] + similar_analysis_ids),
            synthesis.get('sintese', ''),
            synthesis.get('nivel_confianca', 0.0),
            json.dumps({
                'redundancias': synthesis.get('redundancias', ''),
                'novidades': synthesis.get('novidades', ''),
                'contradicoes': synthesis.get('contradicoes', '')
            }),
            datetime.now()
        ))
        
        learning_id = cursor.fetchone()[0]
        return str(learning_id)
    
    def _update_expertise(self, cursor, agent_id: str) -> ExpertiseLevel:
        """Atualiza o contador de expertise do agente e retorna o novo nível"""
        
        # Usar a função do banco de dados
        cursor.execute("SELECT * FROM get_agent_expertise(%s)", (agent_id,))
        result = cursor.fetchone()
        
        # result = (agent_id, learning_count, expertise_level, expertise_value)
        level_name = result[2]
        
        # Converter string para enum
        return ExpertiseLevel[level_name]
    
    def get_agent_expertise(self, agent_id: str) -> Dict:
        """Retorna informações sobre a expertise do agente"""
        cursor = self.conn.cursor()
        
        try:
            cursor.execute("SELECT * FROM get_agent_expertise(%s)", (agent_id,))
            result = cursor.fetchone()
            
            return {
                "agent_id": result[0],
                "learning_count": result[1],
                "expertise_level": result[2],
                "expertise_value": result[3]
            }
            
        finally:
            cursor.close()
    
    def close(self):
        """Fecha a conexão com o banco de dados"""
        if self.conn:
            self.conn.close()


if __name__ == "__main__":
    # Teste do módulo
    cycle = LearningCycle()
    
    # Exemplo de uso
    expertise = cycle.get_agent_expertise("econ")
    print(f"Expertise do Agente ECON: {expertise}")
    
    cycle.close()
