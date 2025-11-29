"""
Curadoria Assistida - Framework V6.0
Fase 1: Infraestrutura e Curadoria

Sistema de curadoria assistida por IA que sugere documentos relevantes
para a Camada 1 (Memória Especializada) do Agente ECON.

Baseado no Modelo Conceitual RAG Evolutivo v3.0 (Sessão #6)
"""

import json
import uuid
from datetime import datetime
from typing import List, Dict, Any, Optional
from pathlib import Path

import os
from openai import OpenAI
from database import get_db_manager
from audit import get_audit_trail, AuditEvent
from config import Config


class CuradoriaAssistida:
    """Sistema de curadoria assistida para memória especializada."""
    
    def __init__(self, agent_id: str = "econ"):
        """
        Inicializa o sistema de curadoria.
        
        Args:
            agent_id: ID do agente (econ, social, terra, ambient)
        """
        self.agent_id = agent_id
        self.db = get_db_manager()
        self.audit = get_audit_trail()
        # Usar OpenAI client pré-configurado do ambiente
        self.client = OpenAI()
        
        self.memory_table = f"agent_{agent_id}_memory"
        
    def load_curated_documents(self, json_file: str) -> List[Dict[str, Any]]:
        """Carrega lista de documentos curados de um arquivo JSON."""
        
        with open(json_file, 'r', encoding='utf-8') as f:
            documents = json.load(f)
        
        print(f"✅ Carregados {len(documents)} documentos do arquivo {json_file}")
        return documents
    
    def generate_embedding(self, text: str) -> List[float]:
        """Gera embedding para um texto."""
        
        # Workaround: Gerar embedding sintético usando hash do texto
        # Em produção, usar modelo de embedding real
        import hashlib
        import numpy as np
        
        try:
            # Criar seed determinístico a partir do texto
            seed = int(hashlib.md5(text.encode()).hexdigest(), 16) % (2**32)
            np.random.seed(seed)
            
            # Gerar vetor de embedding sintético normalizado
            embedding = np.random.randn(Config.EMBEDDING_DIMENSIONS)
            embedding = embedding / np.linalg.norm(embedding)
            
            return embedding.tolist()
            
        except Exception as e:
            print(f"❌ Erro ao gerar embedding: {e}")
            return []
    
    def evaluate_relevance(self, document: Dict[str, Any]) -> Dict[str, Any]:
        """
        Avalia a relevância de um documento usando IA.
        
        Returns:
            Dict com score de relevância e justificativa
        """
        
        prompt = f"""
Você é um especialista em desenvolvimento econômico territorial.

Avalie a relevância do seguinte documento para análise econômica de municípios brasileiros:

**Título:** {document['title']}
**Fonte:** {document['source']}
**Tipo:** {document['type']}
**Descrição:** {document['description']}
**Tópicos:** {', '.join(document['topics'])}

Critérios de avaliação:
1. Relevância para análise econômica territorial (0-10)
2. Credibilidade da fonte (0-10)
3. Aplicabilidade ao contexto brasileiro (0-10)
4. Rigor metodológico (0-10)

Retorne APENAS um JSON no formato:
{{
  "relevance_score": <média dos 4 critérios, 0-10>,
  "justification": "<justificativa de 1-2 frases>",
  "recommended": <true ou false>
}}
"""
        
        try:
            response = self.client.chat.completions.create(
                model=Config.GENERATION_MODEL,
                messages=[{"role": "user", "content": prompt}],
                temperature=0.3,
                response_format={"type": "json_object"}
            )
            
            evaluation = json.loads(response.choices[0].message.content)
            return evaluation
            
        except Exception as e:
            print(f"⚠️  Erro ao avaliar relevância: {e}")
            return {
                "relevance_score": document.get('relevance_score', 0.5) * 10,
                "justification": "Avaliação automática baseada em score pré-definido",
                "recommended": document.get('relevance_score', 0.5) >= Config.CURADORIA_CONFIDENCE_THRESHOLD
            }
    
    def suggest_documents(
        self, 
        documents: List[Dict[str, Any]], 
        max_suggestions: int = 15
    ) -> List[Dict[str, Any]]:
        """
        Sugere documentos para curadoria, ordenados por relevância.
        
        Args:
            documents: Lista de documentos candidatos
            max_suggestions: Número máximo de sugestões
            
        Returns:
            Lista de documentos sugeridos com avaliações
        """
        
        print("\n" + "=" * 80)
        print("AVALIAÇÃO DE RELEVÂNCIA DOS DOCUMENTOS")
        print("=" * 80)
        
        suggestions = []
        
        for i, doc in enumerate(documents, 1):
            print(f"\n📄 Documento {i}/{len(documents)}: {doc['title']}")
            print(f"   Fonte: {doc['source']}")
            
            # Avaliar relevância com IA
            evaluation = self.evaluate_relevance(doc)
            
            # Combinar documento com avaliação
            suggestion = {
                **doc,
                'ai_relevance_score': evaluation['relevance_score'],
                'ai_justification': evaluation['justification'],
                'ai_recommended': evaluation['recommended']
            }
            
            suggestions.append(suggestion)
            
            print(f"   Score IA: {evaluation['relevance_score']:.1f}/10")
            print(f"   Recomendado: {'✅ SIM' if evaluation['recommended'] else '❌ NÃO'}")
            print(f"   Justificativa: {evaluation['justification']}")
        
        # Ordenar por score de relevância (IA)
        suggestions.sort(key=lambda x: x['ai_relevance_score'], reverse=True)
        
        # Limitar ao número máximo de sugestões
        top_suggestions = suggestions[:max_suggestions]
        
        print("\n" + "=" * 80)
        print(f"TOP {len(top_suggestions)} DOCUMENTOS SUGERIDOS")
        print("=" * 80)
        
        for i, sug in enumerate(top_suggestions, 1):
            status = "✅" if sug['ai_recommended'] else "⚠️"
            print(f"{status} {i}. {sug['title']} (Score: {sug['ai_relevance_score']:.1f}/10)")
        
        return top_suggestions
    
    def store_document(self, document: Dict[str, Any]) -> bool:
        """Armazena um documento na memória especializada do agente."""
        
        try:
            # Gerar embedding do documento
            embedding_text = f"{document['title']}. {document['description']}. Tópicos: {', '.join(document['topics'])}"
            embedding = self.generate_embedding(embedding_text)
            
            if not embedding:
                print(f"❌ Falha ao gerar embedding para: {document['title']}")
                return False
            
            # Preparar metadados
            metadata = {
                'source': document['source'],
                'type': document['type'],
                'url': document['url'],
                'topics': document['topics'],
                'language': document['language'],
                'relevance_score': document.get('ai_relevance_score', document.get('relevance_score', 0)),
                'ai_justification': document.get('ai_justification', ''),
                'curated_at': datetime.now().isoformat(),
                'title': document['title']
            }
            
            # Preparar conteúdo completo
            analysis_content = f"""{document['title']}

Fonte: {document['source']}
Tipo: {document['type']}
URL: {document['url']}

Descrição:
{document['description']}

Tópicos: {', '.join(document['topics'])}
"""
            
            analysis_summary = f"{document['title']} - {document['source']}: {document['description'][:200]}..."
            
            # Inserir no banco de dados
            # Usar territory_id genérico para documentos de referência (não específicos de território)
            query = f"""
                INSERT INTO {self.memory_table} (
                    id, territory_id, analysis_content, analysis_summary,
                    embedding_vector, metadata, confidence_score,
                    analysis_date, time_range, data_sources, indicators_used,
                    version, is_latest, created_at, generated_by
                ) VALUES (
                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                );
            """
            
            doc_id = str(uuid.uuid4())
            # Usar ID único para cada documento de referência para evitar conflito de constraint
            territory_id = f"REF_{doc_id[:8].upper()}"  # ID único baseado no UUID do documento
            analysis_date = datetime.now().date()  # Data da curadoria
            
            # Campos obrigatórios com valores padrão para documentos de referência
            time_range = {'type': 'reference', 'note': 'Documento de referência metodológica'}
            data_sources = [{'source': document['source'], 'url': document['url'], 'type': document['type']}]
            indicators_used = []
            
            params = (
                doc_id,
                territory_id,
                analysis_content,
                analysis_summary,
                embedding,
                json.dumps(metadata),
                document.get('ai_relevance_score', document.get('relevance_score', 0)) / 10.0,  # Normalizar para 0-1
                analysis_date,
                json.dumps(time_range),
                json.dumps(data_sources),
                json.dumps(indicators_used),
                1,  # version
                True,  # is_latest
                datetime.now(),
                'curadoria_assistida'
            )
            
            self.db.execute_update(query, params)
            
            # Registrar no audit trail
            event_id = self.audit.generate_event_id("curation")
            audit_event = AuditEvent(
                event_id=event_id,
                event_type="curation",
                event_category="rag",
                agent_id=self.agent_id,
                action="store_document",
                description=f"Documento curado armazenado: {document['title']}",
                metadata={
                    'document_id': doc_id,
                    'document_title': document['title'],
                    'source': document['source'],
                    'relevance_score': metadata['relevance_score']
                },
                status="success"
            )
            self.audit.log_event(audit_event)
            
            print(f"✅ Documento armazenado: {document['title']}")
            return True
            
        except Exception as e:
            print(f"❌ Erro ao armazenar documento: {e}")
            
            # Registrar erro no audit trail
            event_id = self.audit.generate_event_id("curation")
            audit_event = AuditEvent(
                event_id=event_id,
                event_type="curation",
                event_category="rag",
                agent_id=self.agent_id,
                action="store_document",
                description=f"Falha ao armazenar documento: {document['title']}",
                metadata={'document_title': document['title']},
                status="error",
                error_message=str(e)
            )
            self.audit.log_event(audit_event)
            
            return False
    
    def execute_curation(
        self, 
        json_file: str, 
        min_docs: int = 10, 
        max_docs: int = 15,
        auto_approve_threshold: float = 8.0
    ) -> Dict[str, Any]:
        """
        Executa o processo completo de curadoria assistida.
        
        Args:
            json_file: Arquivo JSON com documentos candidatos
            min_docs: Número mínimo de documentos a selecionar
            max_docs: Número máximo de documentos a selecionar
            auto_approve_threshold: Score mínimo para aprovação automática (0-10)
            
        Returns:
            Dict com estatísticas da curadoria
        """
        
        print("\n" + "=" * 80)
        print("CURADORIA ASSISTIDA - AGENTE ECON")
        print("=" * 80)
        
        # Carregar documentos candidatos
        documents = self.load_curated_documents(json_file)
        
        # Sugerir documentos
        suggestions = self.suggest_documents(documents, max_suggestions=max_docs)
        
        # Aprovar automaticamente documentos com score alto
        approved = []
        pending = []
        
        for doc in suggestions:
            if doc['ai_relevance_score'] >= auto_approve_threshold:
                approved.append(doc)
            else:
                pending.append(doc)
        
        print("\n" + "=" * 80)
        print("RESULTADO DA CURADORIA")
        print("=" * 80)
        print(f"✅ Aprovados automaticamente: {len(approved)} documentos (score >= {auto_approve_threshold})")
        print(f"⏳ Pendentes de revisão: {len(pending)} documentos")
        
        # Armazenar documentos aprovados
        stored_count = 0
        failed_count = 0
        
        print("\n📥 Armazenando documentos aprovados...")
        
        for doc in approved:
            if self.store_document(doc):
                stored_count += 1
            else:
                failed_count += 1
        
        # Verificar se atingiu o mínimo
        if stored_count < min_docs and pending:
            print(f"\n⚠️  Apenas {stored_count} documentos armazenados. Mínimo: {min_docs}")
            print(f"   Considere revisar manualmente os {len(pending)} documentos pendentes.")
        
        stats = {
            'total_candidates': len(documents),
            'total_suggestions': len(suggestions),
            'auto_approved': len(approved),
            'pending_review': len(pending),
            'stored_successfully': stored_count,
            'failed_to_store': failed_count
        }
        
        print("\n" + "=" * 80)
        print("ESTATÍSTICAS FINAIS")
        print("=" * 80)
        for key, value in stats.items():
            print(f"{key.replace('_', ' ').title()}: {value}")
        
        return stats


if __name__ == "__main__":
    """Executa a curadoria assistida para o Agente ECON."""
    
    try:
        Config.validate()
        
        curador = CuradoriaAssistida(agent_id="econ")
        
        json_file = "/home/ubuntu/framework-v6-mvp/rag/curated_documents_econ.json"
        
        stats = curador.execute_curation(
            json_file=json_file,
            min_docs=Config.CURADORIA_MIN_DOCS,
            max_docs=Config.CURADORIA_MAX_DOCS,
            auto_approve_threshold=8.0  # Score >= 8.0 para aprovação automática
        )
        
        if stats['stored_successfully'] >= Config.CURADORIA_MIN_DOCS:
            print("\n✅ Curadoria concluída com sucesso!")
        else:
            print(f"\n⚠️  Curadoria parcialmente concluída. Armazenados: {stats['stored_successfully']}/{Config.CURADORIA_MIN_DOCS}")
        
    except Exception as e:
        print(f"\n❌ Erro na curadoria: {e}")
        raise
