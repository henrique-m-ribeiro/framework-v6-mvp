"""
Módulo de Configuração - Framework V6.0
Fase 1: Infraestrutura e Curadoria

Gerencia as configurações do sistema, incluindo conexão com banco de dados,
APIs e parâmetros do RAG evolutivo.
"""

import os
from pathlib import Path
from typing import Optional
from dotenv import load_dotenv

# Carregar variáveis de ambiente
env_path = Path(__file__).parent.parent / '.env'
load_dotenv(dotenv_path=env_path)


class Config:
    """Classe de configuração centralizada do sistema."""
    
    # PostgreSQL (Neon)
    DB_HOST: str = os.getenv('DB_HOST', 'ep-noisy-math-aeyq5dvn.c-2.us-east-2.aws.neon.tech')
    DB_PORT: int = int(os.getenv('DB_PORT', '5432'))
    DB_NAME: str = os.getenv('DB_NAME', 'neondb')
    DB_USER: str = os.getenv('DB_USER', 'neondb_owner')
    DB_PASSWORD: str = os.getenv('DB_PASSWORD', 'npg_HPRVKaYAT4E5')
    
    @classmethod
    def get_db_connection_string(cls) -> str:
        """Retorna a string de conexão PostgreSQL."""
        return f"postgresql://{cls.DB_USER}:{cls.DB_PASSWORD}@{cls.DB_HOST}:{cls.DB_PORT}/{cls.DB_NAME}"
    
    # OpenAI API
    OPENAI_API_KEY: str = os.getenv('OPENAI_API_KEY', '')
    EMBEDDING_MODEL: str = os.getenv('EMBEDDING_MODEL', 'gpt-4.1-mini')  # Usar modelo de geração para embeddings via proxy
    GENERATION_MODEL: str = os.getenv('GENERATION_MODEL', 'gpt-4.1-mini')
    EMBEDDING_DIMENSIONS: int = int(os.getenv('EMBEDDING_DIMENSIONS', '1536'))
    
    # Configurações de Auditoria
    AUDIT_ENABLED: bool = os.getenv('AUDIT_ENABLED', 'true').lower() == 'true'
    AUDIT_TABLE: str = os.getenv('AUDIT_TABLE', 'audit_trail')
    
    # Configurações de Curadoria
    CURADORIA_MIN_DOCS: int = int(os.getenv('CURADORIA_MIN_DOCS', '10'))
    CURADORIA_MAX_DOCS: int = int(os.getenv('CURADORIA_MAX_DOCS', '15'))
    CURADORIA_CONFIDENCE_THRESHOLD: float = float(os.getenv('CURADORIA_CONFIDENCE_THRESHOLD', '0.7'))
    
    @classmethod
    def validate(cls) -> bool:
        """Valida se todas as configurações essenciais estão presentes."""
        required_vars = [
            ('DB_HOST', cls.DB_HOST),
            ('DB_NAME', cls.DB_NAME),
            ('DB_USER', cls.DB_USER),
            ('DB_PASSWORD', cls.DB_PASSWORD),
            ('OPENAI_API_KEY', cls.OPENAI_API_KEY),
        ]
        
        missing = []
        for var_name, var_value in required_vars:
            if not var_value:
                missing.append(var_name)
        
        if missing:
            raise ValueError(f"Variáveis de ambiente obrigatórias não configuradas: {', '.join(missing)}")
        
        return True
    
    @classmethod
    def print_config(cls) -> None:
        """Imprime as configurações (sem expor senhas)."""
        print("=" * 60)
        print("CONFIGURAÇÃO DO SISTEMA - FRAMEWORK V6.0")
        print("=" * 60)
        print(f"Database Host: {cls.DB_HOST}")
        print(f"Database Name: {cls.DB_NAME}")
        print(f"Database User: {cls.DB_USER}")
        print(f"Database Password: {'*' * len(cls.DB_PASSWORD)}")
        print(f"OpenAI API Key: {'*' * 20 if cls.OPENAI_API_KEY else 'NÃO CONFIGURADA'}")
        print(f"Embedding Model: {cls.EMBEDDING_MODEL}")
        print(f"Generation Model: {cls.GENERATION_MODEL}")
        print(f"Embedding Dimensions: {cls.EMBEDDING_DIMENSIONS}")
        print(f"Auditoria Habilitada: {cls.AUDIT_ENABLED}")
        print(f"Curadoria Min/Max Docs: {cls.CURADORIA_MIN_DOCS}/{cls.CURADORIA_MAX_DOCS}")
        print("=" * 60)


if __name__ == "__main__":
    # Teste de configuração
    try:
        Config.validate()
        Config.print_config()
        print("\n✅ Configuração validada com sucesso!")
    except ValueError as e:
        print(f"\n❌ Erro na configuração: {e}")
