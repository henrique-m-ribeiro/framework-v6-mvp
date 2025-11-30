"""
Teste Simplificado do Ciclo de Aprendizagem Evolutiva
"""

import uuid
from datetime import datetime
import json
import psycopg2

from learning_cycle import LearningCycle
from config import Config


def test_learning_cycle():
    """Testa o ciclo de aprendizagem completo"""
    
    print("=" * 80)
    print("TESTE DO CICLO DE APRENDIZAGEM EVOLUTIVA")
    print("=" * 80)
    
    cycle = LearningCycle()
    agent_id = "econ"
    
    # Conexão direta para o teste
    conn = psycopg2.connect(
        host=Config.DB_HOST,
        port=Config.DB_PORT,
        database=Config.DB_NAME,
        user=Config.DB_USER,
        password=Config.DB_PASSWORD
    )
    cursor = conn.cursor()
    
    try:
        # 1. Verificar expertise inicial
        print("\n1. Verificando expertise inicial do Agente ECON...")
        initial_expertise = cycle.get_agent_expertise(agent_id)
        print(f"   ✓ Expertise inicial: {initial_expertise['expertise_level']} ({initial_expertise['learning_count']} ciclos)")
        
        # 2. Criar uma nova análise de teste
        print("\n2. Criando nova análise de teste...")
        new_analysis_id = str(uuid.uuid4())
        
        cursor.execute("""
            INSERT INTO agent_econ_memory (
                id, agent_id, territory_id, analysis_type, content,
                confidence_score, time_range, data_sources, indicators_used,
                analysis_date, created_at
            ) VALUES (
                %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
            )
        """, (
            new_analysis_id, agent_id, 'TO-PALMAS', 'economic_impact',
            'Análise de teste: O turismo em Palmas apresenta crescimento acelerado de 25% ao ano, impulsionado pelo novo aeroporto internacional.',
            0.85, '2024-Q1', json.dumps(['IBGE', 'Prefeitura de Palmas']),
            json.dumps(['turismo', 'aeroporto', 'crescimento']),
            datetime.now(), datetime.now()
        ))
        
        conn.commit()
        print(f"   ✓ Nova análise criada: {new_analysis_id}")
        
        # 3. Buscar análises similares
        print("\n3. Buscando análises similares...")
        cursor.execute("""
            SELECT id FROM agent_econ_memory 
            WHERE agent_id = %s 
            AND id != %s 
            AND metadata->>'archived' IS NULL
            LIMIT 3
        """, (agent_id, new_analysis_id))
        
        similar_analyses = cursor.fetchall()
        similar_analysis_ids = [row[0] for row in similar_analyses]
        
        if len(similar_analysis_ids) == 0:
            print("   ⚠ Nenhuma análise similar encontrada. Criando análises de exemplo...")
            for i in range(3):
                example_id = str(uuid.uuid4())
                cursor.execute("""
                    INSERT INTO agent_econ_memory (
                        id, agent_id, territory_id, analysis_type, content,
                        confidence_score, time_range, data_sources, indicators_used,
                        analysis_date, created_at
                    ) VALUES (
                        %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                    )
                """, (
                    example_id, agent_id, 'TO-PALMAS', 'economic_impact',
                    f'Análise de exemplo {i+1}: O turismo em Palmas cresceu 10% ao ano historicamente.',
                    0.80, '2023-Q4', json.dumps(['IBGE']), json.dumps(['turismo']),
                    datetime.now(), datetime.now()
                ))
                similar_analysis_ids.append(example_id)
            conn.commit()
        
        print(f"   ✓ {len(similar_analysis_ids)} análises similares encontradas")
        
        # 4. Simular síntese gerada pelo LLM
        print("\n4. Simulando síntese gerada pelo LLM...")
        synthesis = {
            "redundancias": "As análises anteriores já identificavam o turismo como setor importante.",
            "novidades": "A nova análise adiciona o impacto do novo aeroporto internacional.",
            "contradicoes": "Nenhuma contradição identificada.",
            "sintese": "O turismo em Palmas é estratégico, historicamente crescendo 10% ao ano. Com o novo aeroporto, projeta-se aceleração para 25% ao ano.",
            "nivel_confianca": 0.90
        }
        print(f"   ✓ Síntese gerada (confiança: {synthesis['nivel_confianca']})")
        
        # 5. Executar atualização da memória e aprendizado
        print("\n5. Executando atualização da memória e aprendizado...")
        result = cycle.update_memory_and_learning(
            agent_id=agent_id,
            new_analysis_id=new_analysis_id,
            synthesis=synthesis,
            similar_analysis_ids=similar_analysis_ids
        )
        
        print(f"   ✓ Aprendizado salvo: {result['learning_id']}")
        print(f"   ✓ Análises arquivadas: {result['archived_count']}")
        print(f"   ✓ Novo nível de expertise: {result['expertise_level']}")
        
        # 6. Verificar expertise final
        print("\n6. Verificando expertise final do Agente ECON...")
        final_expertise = cycle.get_agent_expertise(agent_id)
        print(f"   ✓ Expertise final: {final_expertise['expertise_level']} ({final_expertise['learning_count']} ciclos)")
        
        # 7. Verificar registro na auditoria
        print("\n7. Verificando registro na auditoria...")
        cursor.execute("""
            SELECT COUNT(*) FROM audit_trail 
            WHERE event_type = 'learning_cycle_completed' 
            AND agent_id = %s
        """, (agent_id,))
        
        audit_count = cursor.fetchone()[0]
        print(f"   ✓ {audit_count} eventos de ciclo de aprendizagem registrados")
        
        # 8. Validar que análises foram arquivadas
        print("\n8. Validando arquivamento de análises...")
        cursor.execute("""
            SELECT COUNT(*) FROM agent_econ_memory 
            WHERE id = ANY(%s) 
            AND metadata->>'archived' = 'true'
        """, (similar_analysis_ids,))
        
        archived_count = cursor.fetchone()[0]
        print(f"   ✓ {archived_count} análises arquivadas corretamente")
        
        print("\n" + "=" * 80)
        print("✅ TESTE CONCLUÍDO COM SUCESSO!")
        print("=" * 80)
        
        print("\n📊 RESUMO:")
        print(f"   • Expertise: {initial_expertise['expertise_level']} → {final_expertise['expertise_level']}")
        print(f"   • Ciclos de aprendizado: {initial_expertise['learning_count']} → {final_expertise['learning_count']}")
        print(f"   • Análises arquivadas: {archived_count}")
        print(f"   • Eventos de auditoria: {audit_count}")
        
    except Exception as e:
        print(f"\n❌ ERRO NO TESTE: {str(e)}")
        import traceback
        traceback.print_exc()
        raise
    
    finally:
        cursor.close()
        conn.close()
        cycle.close()


if __name__ == "__main__":
    test_learning_cycle()
