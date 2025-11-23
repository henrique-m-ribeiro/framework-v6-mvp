# Guia de Resolução: Conflito Git entre Replit e GitHub

## 🎯 Situação Atual

Você tem **duas estruturas divergentes**:

1. **GitHub (framework-v6-mvp):** Estrutura que criamos com documentação completa
2. **Replit (InteligenciaTerritorial):** Estrutura criada pelo Agente do Replit com aplicação web

---

## 📊 Análise das Estruturas

### **GitHub (Nossa Estrutura)**
```
framework-v6-mvp/
├── docs/                    ← 70 arquivos de documentação
├── scripts/data_collection/ ← Scripts novos (04, 05, RUN_ALL)
├── database/migrations/     ← Schemas SQL
├── n8n/workflows/          ← 4 agentes especialistas
├── dashboard/integration/   ← Cliente JavaScript
└── README.md
```

### **Replit (Estrutura Existente)**
```
InteligenciaTerritorial/
├── client/                  ← Frontend React/Next.js
├── server/                  ← Backend Node.js
├── scripts/data_collection/ ← Scripts antigos (01, 02, 03)
├── database_exports/        ← Backups e exports
├── backups/                ← Backup de 298KB
└── main.py
```

---

## 🔍 Diferenças Críticas

| Aspecto | GitHub | Replit |
|---------|--------|--------|
| **Scripts** | 5 scripts + RUN_ALL.sh | 9 scripts (alguns sintéticos) |
| **Documentação** | 70 arquivos (~60k palavras) | Nenhuma |
| **Frontend** | Apenas cliente JS | Aplicação React completa |
| **Backend** | n8n workflows | Servidor Node.js |
| **Dados** | Scripts preparados | Dados já inseridos (SQLs) |

---

## ✅ Estratégia de Resolução (RECOMENDADA)

### **Opção 1: Merge Inteligente (MELHOR)**

Combinar o melhor dos dois mundos:
- ✅ Manter aplicação web do Replit (client/ + server/)
- ✅ Adicionar documentação do GitHub (docs/)
- ✅ Atualizar scripts com versões novas do GitHub
- ✅ Preservar dados já inseridos no Replit

---

## 🚀 Passo-a-Passo da Resolução

### **Passo 1: Backup Completo no Replit**

No Shell do Replit:

```bash
# Criar backup da estrutura atual
cd ~/workspace
tar -czf backup_replit_$(date +%Y%m%d_%H%M%S).tar.gz .

# Criar backup do banco
pg_dump $DATABASE_URL > backup_database_$(date +%Y%m%d_%H%M%S).sql

# Confirmar backups
ls -lh backup_*
```

---

### **Passo 2: Configurar Estratégia de Merge**

```bash
cd ~/workspace

# Configurar para fazer merge (não rebase)
git config pull.rebase false

# Verificar configuração
git config --list | grep pull
```

---

### **Passo 3: Fazer Pull com Merge**

```bash
# Fazer pull permitindo merge
git pull origin main --allow-unrelated-histories
```

**O que vai acontecer:**
- Git vai tentar fazer merge automático
- Alguns arquivos podem ter conflitos
- Você precisará resolver conflitos manualmente

---

### **Passo 4: Resolver Conflitos (se houver)**

Se aparecer mensagem de conflito:

```bash
# Ver quais arquivos têm conflito
git status

# Para cada arquivo com conflito, escolher versão:

# Opção A: Manter versão do GitHub
git checkout --theirs <arquivo>

# Opção B: Manter versão do Replit
git checkout --ours <arquivo>

# Opção C: Editar manualmente
# (abrir arquivo e resolver marcadores <<<< ==== >>>>)
```

---

### **Passo 5: Reorganizar Estrutura**

Após o merge, reorganizar para combinar o melhor:

```bash
cd ~/workspace

# Criar estrutura híbrida
mkdir -p docs
mkdir -p n8n/workflows
mkdir -p database/migrations

# Mover documentação do GitHub (se veio no merge)
# (já deve estar em docs/ após o merge)

# Atualizar scripts
cp scripts/data_collection/04_collect_territorial_indicators.py scripts/data_collection/
cp scripts/data_collection/05_collect_environmental_indicators.py scripts/data_collection/
cp scripts/data_collection/RUN_ALL_DIMENSIONS.sh scripts/data_collection/
cp scripts/data_collection/00_verify_environment.sh scripts/data_collection/

# Adicionar tudo
git add .
git commit -m "merge: combine GitHub documentation with Replit application"
git push origin main
```

---

## 🎯 Opção 2: Substituição Completa (ALTERNATIVA)

Se preferir começar do zero com a estrutura do GitHub:

### **No Replit:**

```bash
cd ~/workspace

# Backup completo
tar -czf backup_completo_$(date +%Y%m%d_%H%M%S).tar.gz .

# Salvar dados importantes
cp -r database_exports ~/backup_dados/
cp -r backups ~/backup_dados/
cp -r scripts/data_collection/*.sql ~/backup_dados/

# Remover tudo exceto .git
find . -maxdepth 1 ! -name '.git' ! -name '.' ! -name '..' -exec rm -rf {} +

# Fazer pull limpo
git pull origin main

# Restaurar dados importantes
cp ~/backup_dados/*.sql scripts/data_collection/
```

---

## 🎯 Opção 3: Manter Separado (NÃO RECOMENDADA)

Manter dois repositórios:
- `framework-v6-mvp` → Documentação e scripts
- `InteligenciaTerritorial` → Aplicação web

**Desvantagens:**
- ❌ Duplicação de esforço
- ❌ Sincronização manual necessária
- ❌ Confusão sobre qual usar

---

## 📋 Checklist de Resolução

### **Antes de Começar:**
- [ ] Criar backup completo do Replit
- [ ] Criar backup do banco de dados
- [ ] Verificar quais dados já foram inseridos
- [ ] Decidir qual estratégia usar

### **Durante o Merge:**
- [ ] Configurar `git config pull.rebase false`
- [ ] Executar `git pull origin main --allow-unrelated-histories`
- [ ] Resolver conflitos (se houver)
- [ ] Verificar estrutura resultante
- [ ] Testar scripts importantes

### **Após o Merge:**
- [ ] Commit das mudanças
- [ ] Push para GitHub
- [ ] Verificar que tudo está sincronizado
- [ ] Testar execução dos scripts
- [ ] Atualizar documentação se necessário

---

## 🔧 Comandos Úteis

### **Ver Status do Merge:**
```bash
git status
git log --oneline --graph --all -10
```

### **Abortar Merge (se algo der errado):**
```bash
git merge --abort
```

### **Ver Diferenças:**
```bash
git diff HEAD origin/main
```

### **Listar Arquivos em Conflito:**
```bash
git diff --name-only --diff-filter=U
```

---

## 💡 Recomendação Final

**Eu recomendo a Opção 1 (Merge Inteligente)** porque:

1. ✅ Preserva a aplicação web do Replit (client + server)
2. ✅ Adiciona toda a documentação do GitHub
3. ✅ Mantém dados já inseridos
4. ✅ Atualiza scripts com versões novas
5. ✅ Combina o melhor dos dois mundos

---

## 🎯 Estrutura Final Ideal

Após o merge, você terá:

```
workspace/
├── client/                  ← Frontend React (Replit)
├── server/                  ← Backend Node.js (Replit)
├── docs/                    ← Documentação completa (GitHub)
│   ├── COMO_EXECUTAR_NO_REPLIT.md
│   ├── INDEX_DOCUMENTACAO.md
│   ├── apis/
│   ├── prompts/
│   └── ...
├── scripts/
│   └── data_collection/
│       ├── 01_collect_territories_with_coordinates.py
│       ├── 02_collect_economic_indicators.py
│       ├── 03_collect_social_indicators.py
│       ├── 04_collect_territorial_indicators.py ← Novo
│       ├── 05_collect_environmental_indicators.py ← Novo
│       ├── RUN_ALL_DIMENSIONS.sh ← Novo
│       └── 00_verify_environment.sh ← Novo
├── database/
│   └── migrations/          ← Schemas SQL (GitHub)
├── n8n/
│   └── workflows/          ← 4 agentes (GitHub)
├── database_exports/        ← Backups (Replit)
├── backups/                ← Backups (Replit)
└── README.md
```

---

## 🆘 Se Algo Der Errado

### **Restaurar Estado Anterior:**
```bash
# Abortar merge
git merge --abort

# Restaurar do backup
cd ~/workspace
tar -xzf backup_replit_*.tar.gz

# Restaurar banco
psql $DATABASE_URL < backup_database_*.sql
```

---

## 📞 Próximos Passos

Após resolver o conflito:

1. **Verificar estrutura final**
2. **Testar scripts de coleta**
3. **Atualizar README principal**
4. **Executar carregamento de dados**
5. **Testar aplicação web**

---

**Quer que eu prepare um script automatizado para fazer o merge?**

---

**Framework de Inteligência Territorial V6.0**  
Henrique M. Ribeiro  
23 de novembro de 2025
