# ⚡ Quick Start - Framework V6.0

**Guia rápido para desenvolvedores**

---

## 🎯 Objetivo

Este guia permite que você configure e execute o Framework de Inteligência Territorial V6.0 em seu ambiente local em aproximadamente 30 minutos.

---

## 📋 Pré-requisitos

### Obrigatórios

- **Node.js** 18+ e npm/pnpm
- **Python** 3.11+
- **PostgreSQL** 14+ (ou acesso ao Neon)
- **Conta n8n Cloud** (ou n8n self-hosted)
- **Chave API OpenAI** (GPT-4)

### Recomendados

- **Git** para controle de versão
- **VS Code** ou editor similar
- **Postman** ou curl para testes de API

---

## 🚀 Instalação Rápida

### 1. Clonar o Repositório

```bash
git clone https://github.com/henrique-m-ribeiro/framework-v6-mvp.git
cd framework-v6-mvp
```

### 2. Configurar Variáveis de Ambiente

```bash
cp .env.example .env
```

Edite o arquivo `.env` com suas credenciais:

```env
# Database (Neon PostgreSQL)
DATABASE_URL="postgresql://user:password@host/database"

# OpenAI
OPENAI_API_KEY="sk-..."

# n8n Cloud
N8N_WEBHOOK_URL="https://galactic-ai.app.n8n.cloud/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2"
```

### 3. Instalar Dependências

```bash
# Instalar dependências Node.js
npm install
# ou
pnpm install

# Instalar dependências Python
pip install -r requirements.txt
```

### 4. Configurar Banco de Dados

```bash
# Executar migrações
npm run db:migrate

# Popular dados iniciais (opcional)
python3 scripts/populate_metadata.py
```

### 5. Iniciar Aplicação

```bash
# Modo desenvolvimento
npm run dev

# Modo produção
npm run build
npm start
```

A aplicação estará disponível em `http://localhost:5000`

---

## 🔧 Configuração do n8n

### 1. Importar Workflows

Acesse seu n8n Cloud e importe os workflows:

```
n8n/workflows/current/
├── WF-AGENT-ORCHESTRATOR-V5.1-STABLE.json
├── WF-AGENT-ECON-V6.1-STABLE.json
├── WF-AGENT-SOCIAL-V6.1-STABLE.json
├── WF-AGENT-TERRA-V6.1-STABLE.json
└── WF-AGENT-AMBIENT-V6.1-STABLE.json
```

### 2. Configurar Credenciais

Em cada workflow, configure:

- **OpenAI:** Adicione sua API key
- **PostgreSQL:** Configure conexão com banco
- **Webhooks:** Ative e copie URLs

### 3. Ativar Workflows

Ative todos os 5 workflows no n8n Cloud.

---

## 🧪 Testar a Instalação

### Teste 1: Dashboard Web

Acesse `http://localhost:5000` e verifique se a interface carrega corretamente.

### Teste 2: Consulta Simples

No dashboard, faça uma pergunta simples:

```
Qual o PIB de Palmas?
```

Deve retornar dados do banco sem chamar o Orquestrador.

### Teste 3: Análise Profunda

Faça uma pergunta complexa:

```
Como está a situação socioeconômica de Palmas?
```

Deve acionar o Orquestrador e retornar análise multidimensional.

### Teste 4: API do Orquestrador

Teste direto via curl:

```bash
curl -X POST https://galactic-ai.app.n8n.cloud/webhook/0268b424-b3a3-41ea-9448-c99a1340a0c2 \
  -H "Content-Type: application/json" \
  -d '{
    "territory_id": "1721000",
    "territory_name": "Palmas",
    "question": "Como está a economia de Palmas?",
    "analysis_type": "diagnostic",
    "agent_ids": ["econ"]
  }'
```

---

## 📊 Estrutura do Projeto

```
framework-v6-mvp/
├── client/              # Frontend React
├── server/              # Backend Node.js
├── database/            # Migrações e scripts SQL
├── n8n/workflows/       # Workflows n8n
├── docs/                # Documentação
├── scripts/             # Scripts de automação
└── tests/               # Testes
```

---

## 🐛 Troubleshooting

### Erro: "Database connection failed"

**Solução:** Verifique `DATABASE_URL` no `.env`

```bash
# Testar conexão
psql $DATABASE_URL -c "SELECT 1"
```

### Erro: "OpenAI API key invalid"

**Solução:** Verifique `OPENAI_API_KEY` no `.env`

```bash
# Testar API key
curl https://api.openai.com/v1/models \
  -H "Authorization: Bearer $OPENAI_API_KEY"
```

### Erro: "Workflow not found"

**Solução:** Verifique se workflows estão ativos no n8n

1. Acesse n8n Cloud
2. Verifique status dos workflows
3. Ative workflows inativos

### Erro: "Port 5000 already in use"

**Solução:** Mude a porta no `.env`

```env
PORT=3000
```

---

## 📚 Próximos Passos

### Para Desenvolvedores

1. Leia a [Arquitetura](../01-architecture/OVERVIEW.md)
2. Consulte [Convenções](../04-development/CONVENTIONS.md)
3. Veja [Como Contribuir](../04-development/CONTRIBUTING.md)

### Para Implementadores

1. Siga [Setup Replit](../02-implementation/SETUP_REPLIT.md)
2. Configure [n8n detalhado](../02-implementation/SETUP_N8N.md)
3. Leia [Guia de Workflows](../02-implementation/WORKFLOWS_GUIDE.md)

### Para Pesquisadores

1. Entenda a [Metodologia](../05-research/METHODOLOGY.md)
2. Leia [Diários de Sessões](../05-research/diaries/)
3. Consulte [Changelog](../04-development/CHANGELOG.md)

---

## 🆘 Suporte

- **Documentação:** [docs/INDEX.md](../INDEX.md)
- **Issues:** [GitHub Issues](https://github.com/henrique-m-ribeiro/framework-v6-mvp/issues)
- **Troubleshooting:** [docs/03-operations/TROUBLESHOOTING.md](../03-operations/TROUBLESHOOTING.md)

---

## ✅ Checklist de Instalação

- [ ] Repositório clonado
- [ ] Variáveis de ambiente configuradas
- [ ] Dependências instaladas (Node + Python)
- [ ] Banco de dados configurado
- [ ] Workflows importados no n8n
- [ ] Credenciais configuradas no n8n
- [ ] Workflows ativados
- [ ] Aplicação iniciada
- [ ] Teste 1: Dashboard carrega
- [ ] Teste 2: Consulta simples funciona
- [ ] Teste 3: Análise profunda funciona
- [ ] Teste 4: API do Orquestrador responde

---

**Instalação concluída!** 🎉

Agora você está pronto para explorar o Framework V6.0.

**Última Atualização:** 15 de dezembro de 2025
