# Como Executar o Carregamento de Dados no Replit

## 🎯 Visão Geral

Este guia mostra **exatamente** como executar o script de carregamento de dados dentro do ambiente Replit do seu projeto.

---

## 📋 Pré-requisitos

- ✅ Conta no Replit
- ✅ Projeto Framework V6.0 já criado no Replit
- ✅ PostgreSQL configurado (via Replit Database)
- ✅ Código sincronizado com GitHub

---

## 🚀 Passo-a-Passo Completo

### **Passo 1: Abrir o Replit**

1. Acesse: https://replit.com
2. Faça login na sua conta
3. Abra o projeto **Framework V6.0** (ou o nome que você deu)

---

### **Passo 2: Sincronizar com GitHub**

O código já está no GitHub, então você precisa puxar as últimas atualizações:

**Opção A: Usando a Interface do Replit**
1. Clique no ícone de **Git** (lateral esquerda)
2. Clique em **Pull** para baixar as últimas alterações
3. Aguarde a sincronização

**Opção B: Usando o Shell do Replit**
1. Abra o **Shell** (aba inferior ou lateral)
2. Execute:
```bash
git pull origin main
```

---

### **Passo 3: Verificar a Estrutura de Arquivos**

No explorador de arquivos do Replit, você deve ver:

```
framework-v6-mvp/
├── scripts/
│   └── data_collection/
│       ├── RUN_ALL_DIMENSIONS.sh ← Script principal
│       ├── 00_verify_environment.sh
│       ├── 01_collect_territories_with_coordinates.py
│       ├── 02_collect_economic_indicators.py
│       ├── 03_collect_social_indicators.py
│       ├── 04_collect_territorial_indicators.py
│       └── 05_collect_environmental_indicators.py
├── docs/
└── database/
```

---

### **Passo 4: Abrir o Shell do Replit**

1. Procure pela aba **Shell** (geralmente na parte inferior)
2. Se não estiver visível, clique em **Tools** → **Shell**
3. Você verá um terminal com prompt: `$`

---

### **Passo 5: Navegar para o Diretório Correto**

No Shell, execute:

```bash
cd scripts/data_collection
```

Confirme que está no lugar certo:

```bash
pwd
```

**Saída esperada:** `/home/runner/[nome-do-projeto]/scripts/data_collection`

---

### **Passo 6: Verificar o Ambiente (Opcional mas Recomendado)**

Execute o script de verificação:

```bash
bash 00_verify_environment.sh
```

**O que vai acontecer:**
- ✓ Verifica Python
- ✓ Verifica biblioteca requests
- ✓ Verifica PostgreSQL
- ✓ Testa conexão com banco
- ✓ Mostra status atual das tabelas

**Se tudo estiver OK**, você verá mensagens com ✓ (check verde).

**Se houver erro:**
- `DATABASE_URL não definida` → Veja Passo 7
- `requests não instalado` → O script instala automaticamente
- `psql não encontrado` → Veja seção de Solução de Problemas

---

### **Passo 7: Configurar DATABASE_URL (se necessário)**

O Replit geralmente configura automaticamente, mas se não estiver definida:

1. No Replit, vá em **Tools** → **Database**
2. Copie a **Connection String** (URL de conexão)
3. No Shell, execute:

```bash
export DATABASE_URL="postgresql://..."
```

(Cole a URL que você copiou)

**Para tornar permanente:**
1. Vá em **Secrets** (ícone de cadeado na lateral)
2. Adicione uma nova secret:
   - **Key:** `DATABASE_URL`
   - **Value:** (cole a connection string)

---

### **Passo 8: Executar o Script Automatizado**

Agora é a hora! Execute:

```bash
bash RUN_ALL_DIMENSIONS.sh
```

**O que vai acontecer:**

```
==========================================
FRAMEWORK V6.0 - CARREGAMENTO AUTOMÁTICO DE DADOS
==========================================

Início: 2025-11-22 15:30:00
Log: logs/run_all_20251122_153000.log

------------------------------------------

==========================================
FASE 0: VERIFICAÇÃO DO AMBIENTE
==========================================

[INFO] Verificando Python...
[✓] Python 3.11.0
[INFO] Verificando biblioteca requests...
[✓] requests instalado
...
```

O script vai executar **automaticamente** todas as fases:
1. ✅ Backup do banco
2. 📊 Coleta de territórios (~5 min)
3. 💰 Dimensão econômica (~25 min)
4. 👥 Dimensão social (~20 min)
5. 🏘️ Dimensão territorial (~20 min)
6. 🌳 Dimensão ambiental (~25 min)
7. ✅ Verificação final

**Tempo total:** 60-90 minutos

---

### **Passo 9: Acompanhar o Progresso**

O script mostra progresso em tempo real no console:

```
[1/700] Território 1700301, Ano 2019
[2/700] Território 1700301, Ano 2020
[3/700] Território 1700301, Ano 2021
...
```

**Você pode:**
- ✅ Deixar rodando e fazer outras coisas
- ✅ Acompanhar pelo console
- ✅ Verificar o arquivo de log: `logs/run_all_*.log`

**NÃO:**
- ❌ Fechar a aba do Replit (pode interromper)
- ❌ Desligar o computador
- ❌ Apertar Ctrl+C (cancela a execução)

---

### **Passo 10: Verificar o Resultado**

Ao final, você verá:

```
==========================================
CARREGAMENTO CONCLUÍDO COM SUCESSO!
==========================================

📊 ESTATÍSTICAS FINAIS:
  • Territórios: 140
  • Indicadores Econômicos: 700
  • Indicadores Sociais: 700
  • Indicadores Territoriais: 700
  • Indicadores Ambientais: 700

  📈 TOTAL DE INDICADORES: 2800

💾 ARQUIVOS GERADOS:
  • Backup: backup_before_load_20251122_153000.sql
  • Log completo: logs/run_all_20251122_153000.log
  • SQLs: insert_*.sql

[✓] Todos os dados foram carregados com sucesso! 🎉
```

---

### **Passo 11: Verificar no Banco de Dados**

Para confirmar que os dados estão no banco:

```bash
psql $DATABASE_URL -c "SELECT COUNT(*) FROM territories;"
psql $DATABASE_URL -c "SELECT COUNT(*) FROM economic_indicators;"
psql $DATABASE_URL -c "SELECT COUNT(*) FROM social_indicators;"
psql $DATABASE_URL -c "SELECT COUNT(*) FROM territorial_indicators;"
psql $DATABASE_URL -c "SELECT COUNT(*) FROM environmental_indicators;"
```

**Resultado esperado:**
```
 count 
-------
   140

 count 
-------
   700

 count 
-------
   700

 count 
-------
   700

 count 
-------
   700
```

---

## 🎨 Interface Visual do Replit

### **Como Encontrar o Shell:**

```
┌─────────────────────────────────────────────────┐
│ Replit - Framework V6.0                         │
├─────────────────────────────────────────────────┤
│ [Arquivos] [Código] [Console] [Shell] [Tools]  │
│                                                  │
│ ┌─────────────┐  ┌──────────────────────────┐  │
│ │ Explorador  │  │ Editor de Código         │  │
│ │ de Arquivos │  │                          │  │
│ │             │  │ (seu código aqui)        │  │
│ │ scripts/    │  │                          │  │
│ │   data_...  │  │                          │  │
│ │             │  │                          │  │
│ └─────────────┘  └──────────────────────────┘  │
│                                                  │
│ ┌──────────────────────────────────────────────┐│
│ │ Shell (Terminal)                             ││
│ │ $ cd scripts/data_collection                 ││
│ │ $ bash RUN_ALL_DIMENSIONS.sh                 ││
│ │ [INFO] Verificando Python...                 ││
│ │ [✓] Python 3.11.0                            ││
│ └──────────────────────────────────────────────┘│
└─────────────────────────────────────────────────┘
```

---

## ⚠️ Solução de Problemas

### **Problema 1: "psql: command not found"**

**Solução:**
```bash
# Instalar PostgreSQL client
sudo apt-get update
sudo apt-get install -y postgresql-client
```

---

### **Problema 2: "DATABASE_URL not set"**

**Solução:**
1. Vá em **Tools** → **Database** no Replit
2. Copie a **Connection String**
3. Adicione em **Secrets** (ícone de cadeado):
   - Key: `DATABASE_URL`
   - Value: (cole a string)
4. Reinicie o Shell

---

### **Problema 3: "Permission denied"**

**Solução:**
```bash
chmod +x RUN_ALL_DIMENSIONS.sh
bash RUN_ALL_DIMENSIONS.sh
```

---

### **Problema 4: Script travou ou está muito lento**

**Verificar se está rodando:**
```bash
ps aux | grep python3
```

**Ver log em tempo real:**
```bash
tail -f logs/run_all_*.log
```

**Cancelar se necessário:**
- Pressione `Ctrl + C`
- Execute novamente quando estiver pronto

---

### **Problema 5: Erro de conexão com banco**

**Testar conexão:**
```bash
psql $DATABASE_URL -c "SELECT 1;"
```

**Se falhar:**
1. Verifique se o banco está ativo no Replit
2. Verifique a DATABASE_URL
3. Reinicie o banco de dados (Tools → Database → Restart)

---

## 🔄 Reexecutar o Script

Se precisar executar novamente:

### **Opção 1: Reexecutar Tudo**
```bash
rm -f insert_*.sql
bash RUN_ALL_DIMENSIONS.sh
```

### **Opção 2: Executar Apenas Algumas Dimensões**
O script detecta arquivos existentes e pergunta se deseja reexecutar cada fase.

### **Opção 3: Restaurar Backup**
```bash
psql $DATABASE_URL < backup_before_load_*.sql
```

---

## 📱 Executar via Replit AI (Alternativa)

Se preferir não usar o Shell diretamente, você pode usar a **Replit AI**:

1. Abra o chat da Replit AI (ícone de robô)
2. Cole o conteúdo de: `/docs/prompts/PROMPT_REPLIT_AI_DIMENSAO_TERRITORIAL.md`
3. Aguarde a execução
4. Repita para: `/docs/prompts/PROMPT_REPLIT_AI_DIMENSAO_AMBIENTAL.md`

---

## 📊 Próximos Passos Após Carregamento

1. **Testar Agentes Especialistas**
   ```bash
   # Testar webhook do agente econômico
   curl -X POST https://galactic-ai.app.n8n.cloud/webhook/agent-econ \
     -H "Content-Type: application/json" \
     -d '{"territory_id": "1721000", "analysis_type": "economic"}'
   ```

2. **Verificar Knowledge Base**
   ```bash
   psql $DATABASE_URL -c "SELECT COUNT(*) FROM knowledge_base;"
   ```

3. **Integrar com Dashboard**
   - Testar `n8n-client.js`
   - Validar visualizações

---

## 🎯 Resumo Rápido

```bash
# 1. Abrir Replit
# 2. Sincronizar com GitHub (git pull)
# 3. Abrir Shell
# 4. Executar:

cd scripts/data_collection
bash 00_verify_environment.sh
bash RUN_ALL_DIMENSIONS.sh

# 5. Aguardar ~90 minutos
# 6. Verificar resultado
# 7. Pronto! 🎉
```

---

**Boa execução no Replit! 🚀**

---

**Framework de Inteligência Territorial V6.0**  
Henrique M. Ribeiro  
22 de novembro de 2025
