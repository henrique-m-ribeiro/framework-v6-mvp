# 📐 Convenções de Nomenclatura e Estilo

**Framework de Inteligência Territorial V6.0**  
**Última Atualização:** 15 de dezembro de 2025

---

## 🎯 Objetivo

Este documento estabelece as convenções de nomenclatura, formatação e organização para todos os artefatos do projeto Framework V6.0. O objetivo é garantir consistência, facilitar a navegação e melhorar a manutenibilidade do código e da documentação.

---

## 📄 Documentação

### Nomenclatura de Arquivos

**Formato Padrão:**
```
CATEGORIA_SUBCATEGORIA_VERSAO.md
```

**Regras:**
- Usar MAIÚSCULAS para todo o nome do arquivo
- Separar palavras com underscore (`_`)
- Incluir versão quando aplicável
- Usar nomes descritivos e concisos

**Exemplos Corretos:**
```
✅ ARCHITECTURE_ORCHESTRATOR_V5.md
✅ GUIDE_SETUP_REPLIT.md
✅ TROUBLESHOOTING_DATABASE.md
✅ CHANGELOG.md
✅ README.md
```

**Exemplos Incorretos:**
```
❌ orquestrador-v5.md (minúsculas e hífen)
❌ guia setup replit.md (espaços)
❌ 🚀CONTINUIDADE_SESSAO_13.md (emoji)
❌ Guia_Setup_Replit.md (CamelCase)
```

### Estrutura de Pastas

**Hierarquia Padrão:**
```
docs/
├── 00-getting-started/    # Ponto de entrada para novos usuários
├── 01-architecture/       # Documentação arquitetural
├── 02-implementation/     # Guias de implementação
├── 03-operations/         # Operações e manutenção
├── 04-development/        # Desenvolvimento e contribuição
├── 05-research/           # Pesquisa e metodologia
└── archive/               # Documentos históricos
```

**Regras:**
- Prefixo numérico (00-05) para ordenação
- Nomes em inglês e minúsculas
- Separar palavras com hífen (`-`)
- Máximo 3 níveis de profundidade

### Formato de Conteúdo

**Cabeçalhos:**
```markdown
# Título Principal (H1) - Apenas um por documento

## Seção Principal (H2)

### Subseção (H3)

#### Detalhe (H4) - Usar com moderação
```

**Ênfases:**
- **Negrito** para conceitos-chave e termos importantes
- *Itálico* para ênfase suave ou termos estrangeiros
- `Código inline` para comandos, variáveis e nomes técnicos
- > Blockquote para citações e definições importantes

**Listas:**
- Preferir parágrafos completos quando possível
- Usar listas apenas para enumerações claras
- Máximo 2 níveis de indentação
- Usar `-` para listas não ordenadas
- Usar `1.` para listas ordenadas

**Tabelas:**
```markdown
| Coluna 1 | Coluna 2 | Coluna 3 |
|----------|----------|----------|
| Valor 1  | Valor 2  | Valor 3  |
```

**Links:**
```markdown
[Texto do Link](caminho/relativo/arquivo.md)
[Link Externo](https://exemplo.com)
```

**Código:**
````markdown
```bash
# Comandos shell
comando --opcao valor
```

```json
{
  "campo": "valor"
}
```

```python
# Código Python
def funcao():
    pass
```
````

---

## 🔧 Workflows n8n

### Nomenclatura de Arquivos

**Formato Padrão:**
```
WF-{CAMADA}-{NOME}-V{VERSAO}[-STATUS].json
```

**Componentes:**
- `WF-` - Prefixo fixo (Workflow)
- `{CAMADA}` - Tipo do workflow (AGENT, UTIL, TEST)
- `{NOME}` - Nome descritivo (MAIÚSCULAS)
- `V{VERSAO}` - Versão semântica (ex: V5.1)
- `[-STATUS]` - Status opcional (DRAFT, STABLE, DEPRECATED)

**Exemplos Corretos:**
```
✅ WF-AGENT-ORCHESTRATOR-V5.1-STABLE.json
✅ WF-AGENT-ECON-V6.1-STABLE.json
✅ WF-AGENT-SOCIAL-V6.1-STABLE.json
✅ WF-UTIL-DATA-COLLECTOR-V1.0-DRAFT.json
✅ WF-TEST-INTEGRATION-V1.0.json
```

**Exemplos Incorretos:**
```
❌ OrquestradorCentralV5.0.json (sem prefixo WF-)
❌ WF-agente-econ-v6.1.json (minúsculas)
❌ workflow-social.json (sem versão)
❌ WF-AGENT-ECON-Especialista-Economico-V2-VALIDATED.json (nome muito longo)
```

### Camadas de Workflow

| Camada | Descrição | Exemplos |
|--------|-----------|----------|
| **AGENT** | Agentes especializados e orquestrador | ORCHESTRATOR, ECON, SOCIAL, TERRA, AMBIENT |
| **UTIL** | Utilitários e ferramentas auxiliares | DATA-COLLECTOR, MONITOR, BACKUP |
| **TEST** | Workflows de teste e validação | INTEGRATION, UNIT, E2E |

### Status de Workflow

| Status | Descrição | Quando Usar |
|--------|-----------|-------------|
| **DRAFT** | Em desenvolvimento | Workflow ainda não testado |
| **STABLE** | Estável e em produção | Workflow testado e validado |
| **DEPRECATED** | Obsoleto | Versão antiga mantida para referência |
| *(sem status)* | Padrão | Workflow funcional mas não em produção |

### Organização de Pastas

```
n8n/workflows/
├── current/           # Versões estáveis atuais (STABLE)
├── archive/           # Versões históricas organizadas por sessão
│   ├── Sessao_12/
│   ├── Sessao_13/
│   └── ...
└── templates/         # Templates reutilizáveis
```

---

## 💾 Scripts e Código

### Scripts SQL

**Formato Padrão:**
```
{numero}_{acao}_{objeto}.sql
```

**Regras:**
- Número sequencial de 3 dígitos (001, 002, ...)
- Ação em minúsculas (migrate, add, update, delete)
- Objeto em minúsculas com underscore
- Sempre incluir comentários explicativos no início

**Exemplos Corretos:**
```
✅ 001_migrate_ids_to_varchar.sql
✅ 002_add_metadata_fields.sql
✅ 003_create_agent_registry.sql
✅ 004_update_knowledge_base_schema.sql
```

**Estrutura Interna:**
```sql
-- ============================================
-- Script: 001_migrate_ids_to_varchar.sql
-- Descrição: Migração de IDs de uuid para varchar
-- Autor: Framework V6.0 Team
-- Data: 2025-12-08
-- Versão: V4.0
-- ============================================

-- Início da transação
BEGIN;

-- Código SQL aqui

-- Commit da transação
COMMIT;
```

### Scripts Python

**Formato Padrão:**
```
{numero}_{acao}_{objeto}.py
```

**Regras:**
- Seguir PEP 8 (Python Enhancement Proposal 8)
- Usar snake_case para funções e variáveis
- Usar PascalCase para classes
- Incluir docstrings em funções e classes

**Exemplos Corretos:**
```
✅ 01_populate_metadata.py
✅ 02_validate_database.py
✅ 03_export_indicators.py
```

**Estrutura Interna:**
```python
"""
Script: 01_populate_metadata.py
Descrição: Popula metadados no banco de dados
Autor: Framework V6.0 Team
Data: 2025-12-08
Versão: V4.0
"""

import os
from typing import Dict, List

def main():
    """Função principal do script."""
    pass

if __name__ == "__main__":
    main()
```

### Scripts Bash

**Formato Padrão:**
```
{numero}_{acao}_{objeto}.sh
```

**Regras:**
- Usar snake_case
- Incluir shebang (`#!/bin/bash`)
- Incluir comentários explicativos
- Usar `set -e` para parar em erros

**Exemplos Corretos:**
```
✅ 01_backup_database.sh
✅ 02_deploy_workflows.sh
✅ 03_validate_environment.sh
```

**Estrutura Interna:**
```bash
#!/bin/bash
# ============================================
# Script: 01_backup_database.sh
# Descrição: Realiza backup do banco de dados
# Autor: Framework V6.0 Team
# Data: 2025-12-08
# ============================================

set -e  # Parar em caso de erro

# Código bash aqui
```

---

## 🏷️ Versionamento

### Versionamento Semântico

O projeto segue [Versionamento Semântico 2.0.0](https://semver.org/lang/pt-BR/):

```
MAJOR.MINOR.PATCH
```

**Componentes:**
- **MAJOR:** Mudanças incompatíveis na API (ex: V5.0 → V6.0)
- **MINOR:** Novas funcionalidades compatíveis (ex: V5.0 → V5.1)
- **PATCH:** Correções de bugs compatíveis (ex: V5.1.0 → V5.1.1)

**Exemplos:**
```
V5.0   - Nova versão major do Orquestrador
V5.1   - Correções de bugs no Orquestrador V5.0
V6.0   - Nova versão major dos Agentes
V6.1   - Melhorias nos Agentes V6.0
```

### Tags Git

**Formato:**
```
v{MAJOR}.{MINOR}.{PATCH}[-{LABEL}]
```

**Exemplos:**
```
✅ v5.1.0
✅ v5.1.0-reorganized
✅ v6.0.0-beta
✅ v6.1.0-stable
```

**Comandos:**
```bash
# Criar tag
git tag -a v5.1.0 -m "Release V5.1.0 - Correções críticas"

# Listar tags
git tag -l

# Push de tags
git push origin v5.1.0
```

---

## 📊 Commits Git

### Formato de Mensagem

**Formato Padrão:**
```
<tipo>(<escopo>): <descrição curta>

<descrição detalhada opcional>

<rodapé opcional>
```

**Tipos de Commit:**

| Tipo | Descrição | Exemplo |
|------|-----------|---------|
| `feat` | Nova funcionalidade | `feat(orchestrator): adicionar suporte multiterritorial` |
| `fix` | Correção de bug | `fix(agent-econ): corrigir formato de resposta` |
| `docs` | Documentação | `docs(readme): atualizar guia de instalação` |
| `style` | Formatação | `style(code): aplicar formatação PEP 8` |
| `refactor` | Refatoração | `refactor(database): reorganizar schema` |
| `test` | Testes | `test(integration): adicionar teste de ponta a ponta` |
| `chore` | Manutenção | `chore(deps): atualizar dependências` |

**Exemplos Completos:**
```bash
feat(orchestrator): adicionar análise multiterritorial

Implementa capacidade do orquestrador de processar múltiplos
territórios em uma única requisição. Inclui:
- Identificação automática de territórios
- Paralelização de chamadas aos agentes
- Agregação de resultados

Closes #42

---

fix(agent-econ): corrigir campo analysis_id ausente

O campo analysis_id não estava sendo incluído na resposta,
causando erro no salvamento no banco de dados.

Fixes #38

---

docs(changelog): adicionar entradas da versão V5.1

Documenta todas as correções e melhorias da sessão #16.
```

---

## 🎨 Estilo de Código

### Python

**Seguir PEP 8:**
- Indentação: 4 espaços
- Linha máxima: 88 caracteres (Black formatter)
- Imports: ordenados alfabeticamente
- Docstrings: formato Google

**Exemplo:**
```python
from typing import Dict, List

import pandas as pd
from sqlalchemy import create_engine


class AgentOrchestrator:
    """Orquestrador central de agentes especializados.
    
    Esta classe coordena a chamada de múltiplos agentes especializados
    para realizar análises territoriais multidimensionais.
    
    Attributes:
        agents: Lista de agentes disponíveis
        database_url: URL de conexão com o banco de dados
    """
    
    def __init__(self, database_url: str):
        """Inicializa o orquestrador.
        
        Args:
            database_url: URL de conexão com PostgreSQL
        """
        self.database_url = database_url
        self.agents: List[Dict] = []
    
    def call_agent(self, agent_id: str, payload: Dict) -> Dict:
        """Chama um agente específico com o payload fornecido.
        
        Args:
            agent_id: Identificador do agente (econ, social, terra, ambient)
            payload: Dados a serem enviados ao agente
            
        Returns:
            Resposta do agente em formato de dicionário
            
        Raises:
            ValueError: Se o agent_id não for válido
            ConnectionError: Se a chamada ao agente falhar
        """
        pass
```

### TypeScript/JavaScript

**Seguir ESLint + Prettier:**
- Indentação: 2 espaços
- Linha máxima: 100 caracteres
- Ponto e vírgula: obrigatório
- Aspas: simples para strings

**Exemplo:**
```typescript
import { useState, useEffect } from 'react';
import type { Territory, Analysis } from '@/types';

interface OrchestratorClientProps {
  apiUrl: string;
  onAnalysisComplete: (analysis: Analysis) => void;
}

/**
 * Cliente para comunicação com o Orquestrador
 */
export class OrchestratorClient {
  private apiUrl: string;
  
  constructor(apiUrl: string) {
    this.apiUrl = apiUrl;
  }
  
  /**
   * Solicita uma análise territorial
   * @param territory - Território a ser analisado
   * @param question - Pergunta do usuário
   * @returns Promise com a análise completa
   */
  async requestAnalysis(
    territory: Territory,
    question: string
  ): Promise<Analysis> {
    const response = await fetch(`${this.apiUrl}/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ territory, question }),
    });
    
    if (!response.ok) {
      throw new Error(`Analysis request failed: ${response.statusText}`);
    }
    
    return response.json();
  }
}
```

---

## 📁 Organização de Arquivos

### Estrutura Geral do Projeto

```
framework-v6-mvp/
├── .git/                      # Controle de versão Git
├── .github/                   # GitHub Actions e templates
├── client/                    # Frontend React
├── server/                    # Backend Node.js
├── database/                  # Scripts e migrações SQL
├── n8n/                       # Workflows n8n
│   ├── workflows/
│   │   ├── current/          # Workflows em produção
│   │   ├── archive/          # Versões históricas
│   │   └── templates/        # Templates reutilizáveis
│   └── docs/                 # Documentação específica n8n
├── docs/                      # Documentação principal
│   ├── 00-getting-started/
│   ├── 01-architecture/
│   ├── 02-implementation/
│   ├── 03-operations/
│   ├── 04-development/
│   ├── 05-research/
│   └── archive/
├── scripts/                   # Scripts de automação
├── tests/                     # Testes automatizados
├── .env.example              # Exemplo de variáveis de ambiente
├── .gitignore                # Arquivos ignorados pelo Git
├── README.md                 # README principal
├── VISION.md                 # Visão do projeto
└── package.json              # Dependências Node.js
```

---

## ✅ Checklist de Qualidade

Antes de fazer commit, verifique:

### Documentação
- [ ] Nome do arquivo segue convenção `CATEGORIA_SUBCATEGORIA.md`
- [ ] Arquivo está na pasta correta
- [ ] Cabeçalhos seguem hierarquia (H1 → H2 → H3)
- [ ] Links relativos funcionam corretamente
- [ ] Código está em blocos de código formatados
- [ ] Tabelas estão bem formatadas

### Workflows n8n
- [ ] Nome segue padrão `WF-{CAMADA}-{NOME}-V{VERSAO}[-STATUS].json`
- [ ] Versão está correta
- [ ] Status está definido (DRAFT/STABLE/DEPRECATED)
- [ ] Arquivo está na pasta correta (current/archive/templates)

### Scripts
- [ ] Nome segue padrão `{numero}_{acao}_{objeto}.{ext}`
- [ ] Inclui comentários explicativos
- [ ] Inclui tratamento de erros
- [ ] Testado antes do commit

### Commits
- [ ] Mensagem segue formato `<tipo>(<escopo>): <descrição>`
- [ ] Descrição é clara e concisa
- [ ] Referencia issue quando aplicável
- [ ] Não inclui arquivos desnecessários (.env, node_modules, etc.)

---

## 🔗 Referências

- [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/)
- [Versionamento Semântico](https://semver.org/lang/pt-BR/)
- [Conventional Commits](https://www.conventionalcommits.org/pt-br/)
- [PEP 8 - Style Guide for Python](https://peps.python.org/pep-0008/)
- [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html)
- [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)

---

**Última Revisão:** 15 de dezembro de 2025  
**Próxima Revisão:** Sessão #18
