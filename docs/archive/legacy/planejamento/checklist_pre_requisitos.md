# Checklist de Pré-Requisitos - Framework V6.0 MVP

**Data:** 10 de Novembro de 2025  
**Versão:** 1.0  
**Objetivo:** Verificação de prontidão para início da implementação

---

## 1. CONTAS E ACESSOS

### 1.1. OpenAI
- [ ] Conta criada em https://platform.openai.com
- [ ] Chave de API gerada (formato: `sk-proj-...`)
- [ ] Chave salva em local seguro (gerenciador de senhas)
- [ ] Créditos adicionados (mínimo $10 USD)
- [ ] Limites de uso configurados (Hard limit: $50/mês, Soft limit: $25/mês)
- [ ] Teste de API realizado com sucesso

**Como testar:**
```bash
curl https://api.openai.com/v1/models \
  -H "Authorization: Bearer SUA_CHAVE_AQUI"
```

**Resultado esperado:** Lista de modelos disponíveis em JSON

---

### 1.2. Replit
- [x] Conta criada em https://replit.com
- [ ] Email verificado
- [ ] Projeto criado para o Framework V6.0
- [ ] PostgreSQL ativado no projeto
- [ ] Connection string copiada e salva

**Informações a coletar:**
- URL do projeto Replit: `___________________________`
- Connection string PostgreSQL: `___________________________`

---

### 1.3. n8n Cloud
- [x] Conta criada em https://n8n.io
- [ ] Email verificado
- [ ] Plano escolhido (Starter recomendado: $20/mês)
- [ ] Workspace criado
- [ ] URL do workspace anotada

**Informações a coletar:**
- URL do workspace n8n: `___________________________`
- Plano contratado: `___________________________`

---

## 2. FERRAMENTAS LOCAIS

### 2.1. Python
- [ ] Python 3.9+ instalado
- [ ] pip instalado e atualizado
- [ ] Virtualenv instalado (opcional mas recomendado)

**Como verificar:**
```bash
python3 --version  # Deve retornar 3.9.x ou superior
pip3 --version     # Deve retornar versão recente
```

---

### 2.2. Git (Opcional)
- [ ] Git instalado
- [ ] Configuração básica realizada (user.name, user.email)

**Como verificar:**
```bash
git --version
git config --list
```

---

### 2.3. Editor de Código
- [ ] Editor instalado (VS Code recomendado)
- [ ] Extensões úteis instaladas (opcional):
  - [ ] Python
  - [ ] PostgreSQL
  - [ ] JSON
  - [ ] Markdown

---

### 2.4. Cliente PostgreSQL (Opcional)
- [ ] psql instalado OU
- [ ] DBeaver/pgAdmin instalado

**Como verificar psql:**
```bash
psql --version
```

---

## 3. CONHECIMENTOS PRÉVIOS

### 3.1. Conceitos Essenciais
- [ ] Entendo o que é uma API REST
- [ ] Sei o que é JSON e como manipulá-lo
- [ ] Conheço SQL básico (SELECT, INSERT, UPDATE)
- [ ] Entendo o conceito de banco de dados relacional

### 3.2. Conceitos Desejáveis (Aprenderemos Juntos)
- [ ] Tenho noção de embeddings e busca vetorial
- [ ] Conheço o conceito de RAG (Retrieval-Augmented Generation)
- [ ] Já usei ferramentas no-code/low-code
- [ ] Tenho experiência com automação de workflows

---

## 4. DOCUMENTAÇÃO DO PROJETO

### 4.1. Arquivos Disponíveis
- [x] Framework_V6.0_Implementacao_Completo_v1.1.0.tar.gz extraído
- [x] README.md revisado (pelo menos leitura rápida)
- [x] QUICKSTART.md disponível para consulta
- [x] Plano de Implementação do MVP revisado

### 4.2. Compreensão do Escopo
- [x] Entendo o objetivo do Framework V6.0
- [x] Sei quais são as 4 dimensões (Econômica, Social, Territorial, Ambiental)
- [x] Entendo a cobertura territorial (Tocantins + 139 municípios)
- [x] Sei que começaremos com o agente Data Collector

---

## 5. AMBIENTE DE TRABALHO

### 5.1. Organização
- [ ] Pasta local criada para o projeto (ex: `~/projetos/framework-v6-mvp/`)
- [ ] Arquivos do projeto copiados para a pasta local
- [ ] Arquivo `.env` preparado (template abaixo)

**Template .env:**
```bash
# OpenAI API
OPENAI_API_KEY=sk-proj-SUA_CHAVE_AQUI

# PostgreSQL (Replit)
DATABASE_URL=postgresql://usuario:senha@host:porta/database

# Configurações RAG
EMBEDDING_MODEL=text-embedding-3-small
LLM_MODEL=gpt-4o-mini
CACHE_TTL=3600
LOG_LEVEL=INFO
```

### 5.2. Conectividade
- [ ] Conexão estável com a internet
- [ ] Firewall não bloqueia conexões com Replit, n8n, OpenAI
- [ ] Navegador atualizado (Chrome, Firefox, Edge)

---

## 6. TEMPO E DISPONIBILIDADE

### 6.1. Planejamento
- [ ] Tenho 1-2 horas disponíveis para a próxima sessão (Fase 3)
- [ ] Posso dedicar 2-3 sessões por semana ao projeto
- [ ] Estou preparado para um projeto de 10-12 sessões (6-8 semanas)

### 6.2. Expectativas
- [ ] Entendo que o foco é aprendizado, não velocidade
- [ ] Estou preparado para experimentar e cometer erros
- [ ] Vou documentar meu progresso e aprendizados
- [ ] Farei perguntas quando tiver dúvidas

---

## 7. RECURSOS FINANCEIROS

### 7.1. Custos Iniciais
- [ ] Tenho $10 USD disponíveis para créditos OpenAI
- [ ] Posso pagar $20/mês pelo n8n Cloud (ou usarei self-hosted gratuito)
- [ ] Entendo os custos operacionais (~$23-25/mês)

### 7.2. Plano de Contingência
- [ ] Sei que posso usar tier gratuito do Replit
- [ ] Posso migrar para Neon (PostgreSQL gratuito) se necessário
- [ ] Posso usar GPT-4o-mini para reduzir custos OpenAI

---

## 8. COMUNICAÇÃO E SUPORTE

### 8.1. Canais
- [ ] Sei como acessar a documentação do projeto
- [ ] Tenho acesso ao assistente (Manus AI) para dúvidas
- [ ] Conheço comunidades de suporte (n8n, PostgreSQL)

### 8.2. Documentação de Progresso
- [ ] Vou manter anotações de cada sessão
- [ ] Vou registrar problemas e soluções encontradas
- [ ] Vou criar diário de pesquisa-ação ao final (Fase 10)

---

## 9. VERIFICAÇÃO FINAL

### 9.1. Checklist Mínimo para Começar Fase 3

**Absolutamente Essencial:**
- [ ] Conta Replit criada e verificada
- [ ] Chave OpenAI obtida e testada
- [ ] Python 3.9+ instalado localmente
- [ ] Plano de Implementação revisado
- [ ] 1-2 horas disponíveis para próxima sessão

**Altamente Recomendado:**
- [ ] Conta n8n Cloud criada
- [ ] Editor de código instalado
- [ ] Pasta local do projeto organizada
- [ ] Arquivo .env preparado (com placeholders)

**Opcional (Pode ser feito depois):**
- [ ] Git instalado e configurado
- [ ] Cliente PostgreSQL instalado
- [ ] QUICKSTART.md lido completamente

---

## 10. PERGUNTAS ADICIONAIS

Antes de começarmos a Fase 3, gostaria de esclarecer:

### 10.1. Sobre OpenAI
1. Você já tem experiência com APIs da OpenAI ou será a primeira vez?
2. Prefere começar com GPT-4o-mini (mais barato) ou GPT-4o (melhor qualidade)?
3. Tem alguma restrição de custo que devo considerar?

### 10.2. Sobre Replit
1. Prefere usar o editor web do Replit ou trabalhar localmente com VS Code?
2. Já explorou a interface do Replit ou será primeira experiência?
3. Tem preferência por trabalhar via terminal ou interface gráfica?

### 10.3. Sobre n8n
1. Já teve contato com ferramentas de automação (Zapier, Make, etc.)?
2. Prefere interface visual (drag-and-drop) ou código (JSON)?
3. Planeja usar n8n Cloud ou prefere self-hosted (requer servidor)?

### 10.4. Sobre Metodologia
1. Prefere sessões mais curtas (1-1.5h) e frequentes ou mais longas (2-3h) e espaçadas?
2. Quer fazer anotações durante o processo ou prefere focar na execução?
3. Gostaria de gravar tela das sessões para referência futura?

### 10.5. Sobre Dados
1. Tem preferência por começar com qual dimensão no Data Collector (Econômica, Social, Territorial ou Ambiental)?
2. Quer coletar dados históricos (últimos 5 anos) ou apenas dados recentes?
3. Prefere começar com poucos municípios (ex: 10) para testes ou já todos os 139?

---

## 11. PRÓXIMOS PASSOS

### 11.1. Ações Imediatas (Antes da Próxima Sessão)

**Prioridade Alta:**
1. [ ] Obter chave OpenAI e adicionar créditos
2. [ ] Criar projeto no Replit e ativar PostgreSQL
3. [ ] Responder perguntas adicionais (Seção 10)

**Prioridade Média:**
1. [ ] Ler QUICKSTART.md (30 minutos)
2. [ ] Instalar VS Code (se preferir editor local)
3. [ ] Criar pasta local do projeto

**Prioridade Baixa (Opcional):**
1. [ ] Explorar interface do n8n Cloud
2. [ ] Ler documentação do PostgreSQL/PostGIS
3. [ ] Familiarizar-se com APIs do IBGE

### 11.2. Preparação para Fase 3

Na próxima sessão, vamos:
1. Configurar PostgreSQL no Replit
2. Instalar extensões PostGIS e pgvector
3. Configurar variáveis de ambiente
4. Executar primeiro script de teste
5. Validar que tudo está funcionando

**Tempo estimado:** 1-2 horas  
**Dificuldade:** Baixa (seguiremos passo-a-passo)  
**Resultado:** Ambiente pronto para receber o schema do banco

---

## 12. CONTATO E SUPORTE

### 12.1. Durante as Sessões
- Faça perguntas a qualquer momento
- Peça esclarecimentos se algo não estiver claro
- Sugira ajustes no ritmo se necessário
- Compartilhe erros e dificuldades encontradas

### 12.2. Entre Sessões
- Anote dúvidas que surgirem
- Documente problemas encontrados
- Explore documentação complementar
- Prepare perguntas para próxima sessão

---

**Status Atual do Checklist:**
- ✅ Itens concluídos: 6/100+
- 🔄 Itens em andamento: 2
- ⏳ Itens pendentes: 90+

**Pronto para começar?** Assim que completar os itens de Prioridade Alta (Seção 11.1), estaremos prontos para iniciar a Fase 3!

---

**Documento preparado por:** Manus AI  
**Data:** 10 de Novembro de 2025  
**Próxima Revisão:** Antes do início da Fase 3
