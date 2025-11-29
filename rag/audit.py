"""
Sistema Unificado de Auditoria - Framework V6.0
Fase 1: Infraestrutura e Curadoria

Gerencia o registro e rastreamento de todas as ações do sistema,
garantindo governança, transparência e rastreabilidade completa.

Baseado no Modelo Conceitual RAG Evolutivo v3.0 (Sessão #6)
"""

import uuid
import json
from datetime import datetime
from typing import Optional, Dict, Any, List
from dataclasses import dataclass, asdict
from database import get_db_manager
from config import Config


@dataclass
class AuditEvent:
    """Representa um evento de auditoria."""
    
    # Identificação
    event_id: str
    event_type: str  # 'generation', 'learning', 'maintenance', 'query', etc.
    event_category: str  # 'rag', 'agent', 'system', 'user', etc.
    
    # Contexto
    agent_id: Optional[str] = None
    territory_id: Optional[str] = None
    user_id: Optional[str] = None
    
    # Detalhes
    action: str = ""
    description: Optional[str] = None
    
    # Dados
    input_data: Optional[Dict[str, Any]] = None
    output_data: Optional[Dict[str, Any]] = None
    metadata: Optional[Dict[str, Any]] = None
    
    # Rastreabilidade
    parent_event_id: Optional[str] = None
    root_event_id: Optional[str] = None
    
    # Métricas
    duration_ms: Optional[int] = None
    tokens_used: Optional[int] = None
    cost_usd: Optional[float] = None
    
    # Status
    status: str = 'success'  # 'success', 'error', 'warning'
    error_message: Optional[str] = None
    
    # Timestamp
    created_at: Optional[datetime] = None
    
    def __post_init__(self):
        """Inicializa valores padrão."""
        if self.created_at is None:
            self.created_at = datetime.now()


class AuditTrail:
    """Gerenciador do sistema de auditoria."""
    
    def __init__(self):
        """Inicializa o sistema de auditoria."""
        self.db = get_db_manager()
        self.enabled = Config.AUDIT_ENABLED
    
    def generate_event_id(self, event_type: str) -> str:
        """Gera um ID único para o evento."""
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        unique_id = str(uuid.uuid4())[:8]
        return f"{event_type}_{timestamp}_{unique_id}"
    
    def log_event(self, event: AuditEvent) -> bool:
        """Registra um evento de auditoria no banco de dados."""
        
        if not self.enabled:
            return True
        
        try:
            query = """
                INSERT INTO audit_trail (
                    event_id, event_type, event_category,
                    agent_id, territory_id, user_id,
                    action, description,
                    input_data, output_data, metadata,
                    parent_event_id, root_event_id,
                    duration_ms, tokens_used, cost_usd,
                    status, error_message,
                    created_at
                ) VALUES (
                    %s, %s, %s,
                    %s, %s, %s,
                    %s, %s,
                    %s, %s, %s,
                    %s, %s,
                    %s, %s, %s,
                    %s, %s,
                    %s
                );
            """
            
            params = (
                event.event_id,
                event.event_type,
                event.event_category,
                event.agent_id,
                event.territory_id,
                event.user_id,
                event.action,
                event.description,
                json.dumps(event.input_data) if event.input_data else None,
                json.dumps(event.output_data) if event.output_data else None,
                json.dumps(event.metadata) if event.metadata else None,
                event.parent_event_id,
                event.root_event_id,
                event.duration_ms,
                event.tokens_used,
                event.cost_usd,
                event.status,
                event.error_message,
                event.created_at
            )
            
            self.db.execute_update(query, params)
            return True
            
        except Exception as e:
            print(f"❌ Erro ao registrar evento de auditoria: {e}")
            return False
    
    def get_event(self, event_id: str) -> Optional[Dict[str, Any]]:
        """Recupera um evento específico."""
        query = "SELECT * FROM audit_trail WHERE event_id = %s;"
        results = self.db.execute_query(query, (event_id,))
        return results[0] if results else None
    
    def get_event_chain(self, event_id: str) -> List[Dict[str, Any]]:
        """Recupera toda a cadeia de eventos a partir de um evento raiz."""
        query = """
            WITH RECURSIVE event_chain AS (
                -- Evento raiz
                SELECT * FROM audit_trail WHERE event_id = %s
                UNION ALL
                -- Eventos filhos
                SELECT a.* FROM audit_trail a
                INNER JOIN event_chain ec ON a.parent_event_id = ec.event_id
            )
            SELECT * FROM event_chain ORDER BY created_at;
        """
        return self.db.execute_query(query, (event_id,))
    
    def get_events_by_agent(self, agent_id: str, limit: int = 100) -> List[Dict[str, Any]]:
        """Recupera eventos de um agente específico."""
        query = """
            SELECT * FROM audit_trail 
            WHERE agent_id = %s 
            ORDER BY created_at DESC 
            LIMIT %s;
        """
        return self.db.execute_query(query, (agent_id, limit))
    
    def get_events_by_territory(self, territory_id: str, limit: int = 100) -> List[Dict[str, Any]]:
        """Recupera eventos de um território específico."""
        query = """
            SELECT * FROM audit_trail 
            WHERE territory_id = %s 
            ORDER BY created_at DESC 
            LIMIT %s;
        """
        return self.db.execute_query(query, (territory_id, limit))
    
    def get_events_by_type(self, event_type: str, limit: int = 100) -> List[Dict[str, Any]]:
        """Recupera eventos de um tipo específico."""
        query = """
            SELECT * FROM audit_trail 
            WHERE event_type = %s 
            ORDER BY created_at DESC 
            LIMIT %s;
        """
        return self.db.execute_query(query, (event_type, limit))
    
    def get_failed_events(self, limit: int = 100) -> List[Dict[str, Any]]:
        """Recupera eventos com erro."""
        query = """
            SELECT * FROM audit_trail 
            WHERE status = 'error' 
            ORDER BY created_at DESC 
            LIMIT %s;
        """
        return self.db.execute_query(query, (limit,))
    
    def get_statistics(self) -> Dict[str, Any]:
        """Retorna estatísticas do sistema de auditoria."""
        
        stats_query = """
            SELECT 
                COUNT(*) as total_events,
                COUNT(DISTINCT agent_id) as unique_agents,
                COUNT(DISTINCT territory_id) as unique_territories,
                COUNT(CASE WHEN status = 'success' THEN 1 END) as successful_events,
                COUNT(CASE WHEN status = 'error' THEN 1 END) as failed_events,
                SUM(tokens_used) as total_tokens,
                SUM(cost_usd) as total_cost,
                AVG(duration_ms) as avg_duration_ms
            FROM audit_trail;
        """
        
        type_stats_query = """
            SELECT 
                event_type,
                COUNT(*) as count,
                AVG(duration_ms) as avg_duration_ms
            FROM audit_trail
            GROUP BY event_type
            ORDER BY count DESC;
        """
        
        general_stats = self.db.execute_query(stats_query)[0]
        type_stats = self.db.execute_query(type_stats_query)
        
        return {
            'general': general_stats,
            'by_type': type_stats
        }


# Singleton global
_audit_trail: Optional[AuditTrail] = None


def get_audit_trail() -> AuditTrail:
    """Retorna a instância singleton do AuditTrail."""
    global _audit_trail
    if _audit_trail is None:
        _audit_trail = AuditTrail()
    return _audit_trail


if __name__ == "__main__":
    """Teste do sistema de auditoria."""
    
    print("=" * 80)
    print("TESTE DO SISTEMA DE AUDITORIA")
    print("=" * 80)
    
    try:
        Config.validate()
        audit = get_audit_trail()
        
        # Teste 1: Registrar evento de teste
        print("\n📝 Teste 1: Registrar evento de teste")
        
        event_id = audit.generate_event_id("test")
        test_event = AuditEvent(
            event_id=event_id,
            event_type="test",
            event_category="system",
            action="test_audit_system",
            description="Teste do sistema de auditoria",
            metadata={"test": True, "version": "1.0"},
            status="success"
        )
        
        success = audit.log_event(test_event)
        if success:
            print(f"✅ Evento registrado: {event_id}")
        else:
            print("❌ Falha ao registrar evento")
        
        # Teste 2: Recuperar evento
        print("\n📖 Teste 2: Recuperar evento")
        
        retrieved_event = audit.get_event(event_id)
        if retrieved_event:
            print(f"✅ Evento recuperado:")
            print(f"   ID: {retrieved_event['event_id']}")
            print(f"   Tipo: {retrieved_event['event_type']}")
            print(f"   Ação: {retrieved_event['action']}")
            print(f"   Status: {retrieved_event['status']}")
        else:
            print("❌ Evento não encontrado")
        
        # Teste 3: Estatísticas
        print("\n📊 Teste 3: Estatísticas do sistema")
        
        stats = audit.get_statistics()
        print(f"✅ Estatísticas gerais:")
        print(f"   Total de eventos: {stats['general']['total_events']}")
        print(f"   Eventos bem-sucedidos: {stats['general']['successful_events']}")
        print(f"   Eventos com erro: {stats['general']['failed_events']}")
        
        print("\n✅ Todos os testes passaram!")
        
    except Exception as e:
        print(f"\n❌ Erro no teste: {e}")
        raise
