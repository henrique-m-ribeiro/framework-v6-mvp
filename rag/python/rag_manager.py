#!/usr/bin/env python3
"""
RAG Manager - Framework V6.0
Gerenciamento completo de embeddings e inserção na base RAG.

Autor: Henrique Ribeiro & Manus IA
Data: 07 de Novembro de 2025
Versão: 1.0
"""

import os
import json
import hashlib
import time
from datetime import datetime, timezone
from typing import List, Dict, Optional, Tuple
import psycopg2
from psycopg2.extras import Json, RealDictCursor
from openai import OpenAI

# Inicializar cliente OpenAI
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

# Configurações
DATABASE_URL = os.getenv("DATABASE_URL")
EMBEDDING_MODEL = "text-embedding-3-small"
EMBEDDING_DIMENSIONS = 1536


class RAGManager:
    """Gerenciador de operações RAG (embeddings + PostgreSQL)."""
    
    def __init__(self, database_url: str = None):
        """
        Inicializa o gerenciador RAG.
        
        Args:
            database_url: URL de conexão PostgreSQL (padrão: env DATABASE_URL)
        """
        self.database_url = database_url or DATABASE_URL
        if not self.database_url:
            raise ValueError("DATABASE_URL não configurado")
    
    def _get_connection(self):
        """Cria conexão com PostgreSQL."""
        return psycopg2.connect(self.database_url)
    
    # ========== GERAÇÃO DE EMBEDDINGS ==========
    
    def gerar_embedding(self, texto: str) -> List[float]:
        """
        Gera embedding de 1536 dimensões para um texto.
        
        Args:
            texto: Texto para gerar embedding (máximo 8191 tokens)
            
        Returns:
            Lista de 1536 floats representando o embedding
            
        Raises:
            Exception: Se API OpenAI falhar
        """
        try:
            response = client.embeddings.create(
                model=EMBEDDING_MODEL,
                input=texto,
                encoding_format="float"
            )
            return response.data[0].embedding
        except Exception as e:
            raise Exception(f"Erro ao gerar embedding: {e}")
    
    def gerar_embeddings_batch(self, textos: List[str]) -> List[List[float]]:
        """
        Gera embeddings para múltiplos textos em lote.
        
        Args:
            textos: Lista de textos (máximo 2048)
            
        Returns:
            Lista de embeddings na mesma ordem dos textos
        """
        if len(textos) > 2048:
            raise ValueError("Máximo de 2048 textos por batch")
        
        try:
            response = client.embeddings.create(
                model=EMBEDDING_MODEL,
                input=textos,
                encoding_format="float"
            )
            return [data.embedding for data in response.data]
        except Exception as e:
            raise Exception(f"Erro ao gerar embeddings em batch: {e}")
    
    def calcular_custo_embedding(self, num_tokens: int) -> float:
        """
        Calcula custo de geração de embedding.
        
        Args:
            num_tokens: Número de tokens
            
        Returns:
            Custo em USD
        """
        # text-embedding-3-small: $0.02 / 1M tokens
        return num_tokens * 0.00000002
    
    # ========== ANÁLISE E LLM ==========
    
    def gerar_analise(
        self,
        prompt_usuario: str,
        prompt_sistema: str,
        modelo: str = "gpt-4o",
        temperature: float = 0.3,
        max_tokens: int = 2000
    ) -> Dict:
        """
        Gera análise usando LLM.
        
        Args:
            prompt_usuario: Pergunta/prompt do usuário
            prompt_sistema: System prompt
            modelo: Modelo LLM (padrão: gpt-4o)
            temperature: Temperatura (0-1)
            max_tokens: Máximo de tokens na resposta
            
        Returns:
            Dict com 'analise', 'tokens_prompt', 'tokens_completion', 'custo_usd'
        """
        try:
            response = client.chat.completions.create(
                model=modelo,
                messages=[
                    {"role": "system", "content": prompt_sistema},
                    {"role": "user", "content": prompt_usuario}
                ],
                temperature=temperature,
                max_tokens=max_tokens
            )
            
            analise = response.choices[0].message.content
            tokens_prompt = response.usage.prompt_tokens
            tokens_completion = response.usage.completion_tokens
            tokens_total = response.usage.total_tokens
            
            # Calcular custo (GPT-4o: $2.50/1M input, $10.00/1M output)
            custo_llm = (tokens_prompt * 0.0000025) + (tokens_completion * 0.00001)
            
            return {
                "analise": analise,
                "tokens_prompt": tokens_prompt,
                "tokens_completion": tokens_completion,
                "tokens_total": tokens_total,
                "custo_usd": custo_llm
            }
        except Exception as e:
            raise Exception(f"Erro ao gerar análise: {e}")
    
    # ========== INSERÇÃO NO RAG ==========
    
    def inserir_analise(
        self,
        codigo_ibge: str,
        tipo_analise: str,
        titulo: str,
        conteudo: str,
        embedding: List[float],
        metadados: Dict
    ) -> str:
        """
        Insere análise na tabela analises_geradas.
        
        Args:
            codigo_ibge: Código IBGE do município
            tipo_analise: 'territorial', 'economica', 'social', 'ambiental', 'integrada'
            titulo: Título da análise
            conteudo: Texto completo da análise
            embedding: Vetor de 1536 dimensões
            metadados: Dicionário com metadados JSONB
            
        Returns:
            UUID da análise inserida
        """
        conn = self._get_connection()
        cur = conn.cursor()
        
        try:
            # Converter embedding para string formatada para pgvector
            embedding_str = "[" + ",".join(map(str, embedding)) + "]"
            
            query = """
            INSERT INTO analises_geradas (
                codigo_ibge,
                tipo_analise,
                titulo,
                conteudo,
                embedding,
                metadados
            ) VALUES (
                %s, %s, %s, %s, %s::vector(1536), %s
            )
            RETURNING id;
            """
            
            cur.execute(query, (
                codigo_ibge,
                tipo_analise,
                titulo,
                conteudo,
                embedding_str,
                Json(metadados)
            ))
            
            analise_id = cur.fetchone()[0]
            
            conn.commit()
            return str(analise_id)
        
        except Exception as e:
            conn.rollback()
            raise Exception(f"Erro ao inserir análise: {e}")
        
        finally:
            cur.close()
            conn.close()
    
    def construir_metadados(
        self,
        agente: str,
        prompt_usuario: str,
        modelo_llm: str,
        tokens_prompt: int,
        tokens_completion: int,
        custo_llm_usd: float,
        custo_embedding_usd: float,
        fontes_dados: List[str],
        codigos_ibge: List[str],
        tags: List[str],
        **kwargs
    ) -> Dict:
        """
        Constrói objeto de metadados JSONB.
        
        Args:
            agente: Nome do agente (INTERACT, TERRA, ECON, SOCIAL, AMBIENTAL)
            prompt_usuario: Pergunta original do usuário
            modelo_llm: Modelo LLM usado
            tokens_prompt: Tokens do prompt
            tokens_completion: Tokens da resposta
            custo_llm_usd: Custo do LLM em USD
            custo_embedding_usd: Custo do embedding em USD
            fontes_dados: Lista de tabelas consultadas
            codigos_ibge: Lista de códigos IBGE analisados
            tags: Lista de tags para categorização
            **kwargs: Campos adicionais opcionais
            
        Returns:
            Dicionário com metadados estruturados
        """
        metadados = {
            "agente": agente,
            "prompt_usuario": prompt_usuario,
            "modelo_llm": modelo_llm,
            "modelo_embedding": EMBEDDING_MODEL,
            "tokens_prompt": tokens_prompt,
            "tokens_completion": tokens_completion,
            "tokens_total": tokens_prompt + tokens_completion,
            "custo_llm_usd": custo_llm_usd,
            "custo_embedding_usd": custo_embedding_usd,
            "custo_total_usd": custo_llm_usd + custo_embedding_usd,
            "fontes_dados": fontes_dados,
            "codigos_ibge": codigos_ibge,
            "tags": tags,
            "data_geracao": datetime.now(timezone.utc).isoformat()
        }
        
        # Adicionar campos opcionais
        metadados.update(kwargs)
        
        return metadados
    
    # ========== BUSCA SEMÂNTICA ==========
    
    def buscar_analises_similares(
        self,
        query: str,
        limite: int = 5,
        tipo_filtro: Optional[str] = None,
        codigo_ibge_filtro: Optional[str] = None,
        threshold_similarity: float = 0.7
    ) -> List[Dict]:
        """
        Busca análises similares usando busca vetorial.
        
        Args:
            query: Pergunta/texto para buscar
            limite: Número de resultados (padrão: 5)
            tipo_filtro: Filtrar por tipo de análise (opcional)
            codigo_ibge_filtro: Filtrar por município (opcional)
            threshold_similarity: Similaridade mínima (0-1, padrão: 0.7)
            
        Returns:
            Lista de dicionários com análises similares
        """
        # Gerar embedding da query
        embedding_query = self.gerar_embedding(query)
        embedding_str = "[" + ",".join(map(str, embedding_query)) + "]"
        
        conn = self._get_connection()
        cur = conn.cursor(cursor_factory=RealDictCursor)
        
        try:
            query_sql = """
            SELECT * FROM buscar_analises_similares(
                %s::vector(1536),
                %s,
                %s,
                %s
            )
            WHERE similarity >= %s;
            """
            
            cur.execute(query_sql, (
                embedding_str,
                limite,
                tipo_filtro,
                codigo_ibge_filtro,
                threshold_similarity
            ))
            
            resultados = cur.fetchall()
            
            # Converter para lista de dicts
            return [dict(row) for row in resultados]
        
        except Exception as e:
            raise Exception(f"Erro ao buscar análises similares: {e}")
        
        finally:
            cur.close()
            conn.close()
    
    def buscar_conteudo_analise(self, analise_id: str) -> Optional[str]:
        """
        Busca conteúdo completo de uma análise por ID.
        
        Args:
            analise_id: UUID da análise
            
        Returns:
            Conteúdo da análise ou None se não encontrada
        """
        conn = self._get_connection()
        cur = conn.cursor()
        
        try:
            query = "SELECT conteudo FROM analises_geradas WHERE id = %s;"
            cur.execute(query, (analise_id,))
            resultado = cur.fetchone()
            
            return resultado[0] if resultado else None
        
        finally:
            cur.close()
            conn.close()
    
    # ========== FLUXO COMPLETO ==========
    
    def processar_pergunta_completa(
        self,
        pergunta: str,
        codigo_ibge: str,
        agente: str,
        tipo_analise: str,
        prompt_sistema: str,
        fontes_dados: List[str],
        tags: List[str],
        usar_contexto_rag: bool = True
    ) -> Dict:
        """
        Fluxo completo: pergunta → análise → embedding → RAG → resposta.
        
        Args:
            pergunta: Pergunta do usuário
            codigo_ibge: Código IBGE do município
            agente: Nome do agente
            tipo_analise: Tipo de análise
            prompt_sistema: System prompt
            fontes_dados: Lista de tabelas consultadas
            tags: Lista de tags
            usar_contexto_rag: Usar contexto de análises similares (padrão: True)
            
        Returns:
            Dict com 'analise_id', 'analise', 'metadados', 'tempo_total_segundos'
        """
        inicio = time.time()
        
        # 1. Buscar contexto RAG (opcional)
        contexto_rag = ""
        analises_similares_ids = []
        if usar_contexto_rag:
            analises_similares = self.buscar_analises_similares(
                query=pergunta,
                limite=3,
                tipo_filtro=tipo_analise,
                codigo_ibge_filtro=codigo_ibge
            )
            
            if analises_similares:
                contexto_rag = "\n\nAnálises similares anteriores:\n\n"
                for i, analise in enumerate(analises_similares, 1):
                    contexto_rag += f"{i}. {analise['titulo']} (similaridade: {analise['similarity']:.2f})\n"
                    analises_similares_ids.append(str(analise['id']))
        
        # 2. Construir prompt completo
        prompt_completo = f"{pergunta}{contexto_rag}"
        
        # 3. Gerar análise
        resultado_analise = self.gerar_analise(
            prompt_usuario=prompt_completo,
            prompt_sistema=prompt_sistema
        )
        
        analise_texto = resultado_analise["analise"]
        
        # 4. Gerar embedding
        embedding = self.gerar_embedding(analise_texto)
        
        # Calcular custo embedding (estimativa: ~1200 tokens)
        custo_embedding = self.calcular_custo_embedding(1200)
        
        # 5. Construir metadados
        metadados = self.construir_metadados(
            agente=agente,
            prompt_usuario=pergunta,
            modelo_llm="gpt-4o",
            tokens_prompt=resultado_analise["tokens_prompt"],
            tokens_completion=resultado_analise["tokens_completion"],
            custo_llm_usd=resultado_analise["custo_usd"],
            custo_embedding_usd=custo_embedding,
            fontes_dados=fontes_dados,
            codigos_ibge=[codigo_ibge],
            tags=tags,
            tempo_geracao_segundos=time.time() - inicio,
            contexto={
                "analises_similares_usadas": analises_similares_ids
            }
        )
        
        # 6. Inserir em RAG
        analise_id = self.inserir_analise(
            codigo_ibge=codigo_ibge,
            tipo_analise=tipo_analise,
            titulo=f"{agente}: {pergunta[:50]}...",
            conteudo=analise_texto,
            embedding=embedding,
            metadados=metadados
        )
        
        tempo_total = time.time() - inicio
        
        # 7. Retornar resposta
        return {
            "analise_id": analise_id,
            "analise": analise_texto,
            "metadados": metadados,
            "tempo_total_segundos": tempo_total
        }
    
    # ========== MONITORAMENTO ==========
    
    def gerar_relatorio_custos(self, dias: int = 30) -> Dict:
        """
        Gera relatório de custos dos últimos N dias.
        
        Args:
            dias: Número de dias (padrão: 30)
            
        Returns:
            Dict com estatísticas de custo
        """
        conn = self._get_connection()
        cur = conn.cursor(cursor_factory=RealDictCursor)
        
        try:
            query = """
            SELECT 
                COUNT(*) AS total_analises,
                SUM((metadados->>'custo_total_usd')::FLOAT) AS custo_total,
                AVG((metadados->>'custo_total_usd')::FLOAT) AS custo_medio,
                SUM((metadados->>'tokens_total')::INTEGER) AS tokens_total,
                AVG((metadados->>'tempo_geracao_segundos')::FLOAT) AS tempo_medio
            FROM analises_geradas
            WHERE data_criacao >= NOW() - INTERVAL '%s days';
            """
            
            cur.execute(query, (dias,))
            resultado = cur.fetchone()
            
            return dict(resultado) if resultado else {}
        
        finally:
            cur.close()
            conn.close()
    
    def gerar_relatorio_por_agente(self, dias: int = 30) -> List[Dict]:
        """
        Gera relatório de custos por agente.
        
        Args:
            dias: Número de dias (padrão: 30)
            
        Returns:
            Lista de dicts com estatísticas por agente
        """
        conn = self._get_connection()
        cur = conn.cursor(cursor_factory=RealDictCursor)
        
        try:
            query = """
            SELECT 
                metadados->>'agente' AS agente,
                COUNT(*) AS total_analises,
                SUM((metadados->>'custo_total_usd')::FLOAT) AS custo_total_usd,
                AVG((metadados->>'custo_total_usd')::FLOAT) AS custo_medio_usd,
                SUM((metadados->>'tokens_total')::INTEGER) AS tokens_total
            FROM analises_geradas
            WHERE data_criacao >= NOW() - INTERVAL '%s days'
            GROUP BY metadados->>'agente'
            ORDER BY custo_total_usd DESC;
            """
            
            cur.execute(query, (dias,))
            resultados = cur.fetchall()
            
            return [dict(row) for row in resultados]
        
        finally:
            cur.close()
            conn.close()


# ========== FUNÇÕES DE TESTE ==========

def teste_insercao_completa():
    """Testa fluxo completo de inserção."""
    print("=== Teste de Inserção Completa ===\n")
    
    manager = RAGManager()
    
    # 1. Gerar análise de teste
    analise_texto = """
    Análise econômica de Palmas-TO (2018-2022):
    
    O PIB de Palmas cresceu 15% no período, passando de R$ 10,5 bilhões 
    para R$ 12,1 bilhões. O setor de serviços foi o principal motor do 
    crescimento, representando 75% do PIB em 2022.
    """
    
    print(f"1. Texto da análise: {len(analise_texto)} caracteres")
    
    # 2. Gerar embedding
    print("2. Gerando embedding...")
    embedding = manager.gerar_embedding(analise_texto)
    print(f"   - Dimensões: {len(embedding)}")
    
    # 3. Construir metadados
    print("3. Construindo metadados...")
    metadados = manager.construir_metadados(
        agente="ECON",
        prompt_usuario="Analise o PIB de Palmas",
        modelo_llm="gpt-4o",
        tokens_prompt=50,
        tokens_completion=100,
        custo_llm_usd=0.00125,
        custo_embedding_usd=0.000024,
        fontes_dados=["dados_economicos"],
        codigos_ibge=["1721000"],
        tags=["pib", "crescimento", "palmas"]
    )
    print(f"   - Campos: {len(metadados)}")
    
    # 4. Inserir no PostgreSQL
    print("4. Inserindo no PostgreSQL...")
    analise_id = manager.inserir_analise(
        codigo_ibge="1721000",
        tipo_analise="economica",
        titulo="Análise econômica de Palmas (2018-2022)",
        conteudo=analise_texto,
        embedding=embedding,
        metadados=metadados
    )
    print(f"   - ID: {analise_id}")
    
    print("\n✅ Teste concluído com sucesso!")
    return analise_id


def teste_busca_semantica():
    """Testa busca semântica."""
    print("\n=== Teste de Busca Semântica ===\n")
    
    manager = RAGManager()
    
    # 1. Query
    query = "Como está a economia de Palmas?"
    print(f"1. Query: {query}")
    
    # 2. Buscar análises similares
    print("2. Buscando análises similares...")
    analises = manager.buscar_analises_similares(query, limite=3)
    
    # 3. Exibir resultados
    print(f"\n3. Resultados ({len(analises)} análises):\n")
    for i, analise in enumerate(analises, 1):
        print(f"   {i}. {analise['titulo']}")
        print(f"      - Similaridade: {analise['similarity']:.4f}")
        print(f"      - Tipo: {analise['tipo_analise']}")
        print(f"      - Município: {analise['codigo_ibge']}")
        print()
    
    print("✅ Teste concluído com sucesso!")


def teste_relatorio_custos():
    """Testa geração de relatório de custos."""
    print("\n=== Teste de Relatório de Custos ===\n")
    
    manager = RAGManager()
    
    # Relatório geral
    print("1. Relatório geral (últimos 30 dias):")
    relatorio = manager.gerar_relatorio_custos(30)
    for key, value in relatorio.items():
        print(f"   - {key}: {value}")
    
    # Relatório por agente
    print("\n2. Relatório por agente:")
    relatorio_agentes = manager.gerar_relatorio_por_agente(30)
    for agente_stats in relatorio_agentes:
        print(f"\n   Agente: {agente_stats['agente']}")
        print(f"   - Análises: {agente_stats['total_analises']}")
        print(f"   - Custo total: ${agente_stats['custo_total_usd']:.4f}")
        print(f"   - Custo médio: ${agente_stats['custo_medio_usd']:.6f}")
    
    print("\n✅ Teste concluído com sucesso!")


if __name__ == "__main__":
    import sys
    
    if len(sys.argv) < 2:
        print("Uso: python rag_manager.py [teste_insercao|teste_busca|teste_relatorio]")
        sys.exit(1)
    
    comando = sys.argv[1]
    
    if comando == "teste_insercao":
        teste_insercao_completa()
    elif comando == "teste_busca":
        teste_busca_semantica()
    elif comando == "teste_relatorio":
        teste_relatorio_custos()
    else:
        print(f"Comando desconhecido: {comando}")
        sys.exit(1)
