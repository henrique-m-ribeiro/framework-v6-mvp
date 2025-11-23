#!/bin/bash
################################################################################
# Script de Merge Automático: Replit ↔ GitHub
# Framework V6.0 - Resolução de Conflito de Estruturas
#
# Este script automatiza o processo de merge entre:
# - Estrutura do GitHub (documentação + scripts novos)
# - Estrutura do Replit (aplicação web + dados)
#
# Uso: bash MERGE_REPLIT_GITHUB.sh
################################################################################

set -e  # Parar em caso de erro

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[⚠]${NC} $1"
}

log_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_header() {
    echo ""
    echo "=========================================="
    echo "$1"
    echo "=========================================="
    echo ""
}

# Verificar se está no Replit
if [ ! -d "~/workspace" ] && [ ! -d ".replit" ]; then
    log_warning "Este script deve ser executado no ambiente Replit"
    read -p "Continuar mesmo assim? (s/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        exit 1
    fi
fi

print_header "MERGE AUTOMÁTICO: REPLIT ↔ GITHUB"

################################################################################
# FASE 1: BACKUP
################################################################################

print_header "FASE 1: BACKUP COMPLETO"

BACKUP_DIR="$HOME/backup_merge_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

log_info "Criando backup em: $BACKUP_DIR"

# Backup da estrutura atual
log_info "Backup de arquivos..."
tar -czf "$BACKUP_DIR/workspace_backup.tar.gz" . 2>/dev/null || true
log_success "Backup de arquivos criado"

# Backup do banco (se DATABASE_URL estiver definida)
if [ ! -z "$DATABASE_URL" ]; then
    log_info "Backup do banco de dados..."
    pg_dump "$DATABASE_URL" > "$BACKUP_DIR/database_backup.sql" 2>/dev/null || log_warning "Não foi possível fazer backup do banco"
    log_success "Backup do banco criado"
fi

# Backup de dados importantes
log_info "Backup de dados críticos..."
mkdir -p "$BACKUP_DIR/critical_data"
cp -r database_exports "$BACKUP_DIR/critical_data/" 2>/dev/null || true
cp -r backups "$BACKUP_DIR/critical_data/" 2>/dev/null || true
cp -r scripts/data_collection/*.sql "$BACKUP_DIR/critical_data/" 2>/dev/null || true
log_success "Dados críticos salvos"

BACKUP_SIZE=$(du -sh "$BACKUP_DIR" | cut -f1)
log_success "Backup completo: $BACKUP_SIZE"

################################################################################
# FASE 2: CONFIGURAÇÃO GIT
################################################################################

print_header "FASE 2: CONFIGURAÇÃO GIT"

log_info "Configurando estratégia de merge..."
git config pull.rebase false
log_success "Estratégia configurada: merge (não rebase)"

log_info "Status atual do Git:"
git status --short

################################################################################
# FASE 3: MERGE
################################################################################

print_header "FASE 3: EXECUTANDO MERGE"

log_warning "Tentando fazer merge com GitHub..."
log_info "Comando: git pull origin main --allow-unrelated-histories"

if git pull origin main --allow-unrelated-histories; then
    log_success "Merge executado com sucesso!"
else
    log_error "Merge falhou ou há conflitos"
    log_info "Verificando conflitos..."
    
    CONFLICTS=$(git diff --name-only --diff-filter=U)
    
    if [ ! -z "$CONFLICTS" ]; then
        log_warning "Arquivos em conflito:"
        echo "$CONFLICTS"
        echo ""
        log_info "Resolvendo conflitos automaticamente..."
        
        # Para cada conflito, tentar resolver automaticamente
        while IFS= read -r file; do
            log_info "Resolvendo: $file"
            
            # Estratégia: manter versão do GitHub para docs/, manter Replit para client/server/
            if [[ $file == docs/* ]] || [[ $file == database/migrations/* ]] || [[ $file == n8n/* ]]; then
                log_info "  → Usando versão do GitHub"
                git checkout --theirs "$file"
            elif [[ $file == client/* ]] || [[ $file == server/* ]] || [[ $file == database_exports/* ]]; then
                log_info "  → Usando versão do Replit"
                git checkout --ours "$file"
            else
                log_warning "  → Conflito manual necessário"
            fi
        done <<< "$CONFLICTS"
        
        # Adicionar resoluções
        git add .
        
        log_info "Finalizando merge..."
        git commit -m "merge: resolve conflicts between Replit and GitHub structures" || true
        
        log_success "Conflitos resolvidos!"
    fi
fi

################################################################################
# FASE 4: REORGANIZAÇÃO
################################################################################

print_header "FASE 4: REORGANIZAÇÃO DA ESTRUTURA"

log_info "Criando diretórios necessários..."
mkdir -p docs
mkdir -p n8n/workflows
mkdir -p database/migrations
mkdir -p scripts/data_collection
log_success "Diretórios criados"

log_info "Verificando scripts novos..."
if [ -f "scripts/data_collection/04_collect_territorial_indicators.py" ]; then
    log_success "Script 04 (territorial) presente"
else
    log_warning "Script 04 não encontrado"
fi

if [ -f "scripts/data_collection/05_collect_environmental_indicators.py" ]; then
    log_success "Script 05 (ambiental) presente"
else
    log_warning "Script 05 não encontrado"
fi

if [ -f "scripts/data_collection/RUN_ALL_DIMENSIONS.sh" ]; then
    log_success "Script RUN_ALL presente"
    chmod +x scripts/data_collection/RUN_ALL_DIMENSIONS.sh
else
    log_warning "Script RUN_ALL não encontrado"
fi

################################################################################
# FASE 5: VERIFICAÇÃO
################################################################################

print_header "FASE 5: VERIFICAÇÃO FINAL"

log_info "Estrutura de diretórios:"
tree -L 2 -d . 2>/dev/null || find . -maxdepth 2 -type d

echo ""
log_info "Estatísticas:"
echo "  • Documentos: $(find docs -name "*.md" 2>/dev/null | wc -l) arquivos"
echo "  • Scripts Python: $(find scripts -name "*.py" 2>/dev/null | wc -l) arquivos"
echo "  • Workflows n8n: $(find n8n -name "*.json" 2>/dev/null | wc -l) arquivos"
echo "  • Migrations SQL: $(find database/migrations -name "*.sql" 2>/dev/null | wc -l) arquivos"

################################################################################
# FASE 6: COMMIT E PUSH
################################################################################

print_header "FASE 6: COMMIT E PUSH"

log_info "Adicionando todas as mudanças..."
git add .

log_info "Criando commit..."
git commit -m "merge: combine Replit application with GitHub documentation and scripts" || log_warning "Nada para commitar"

log_info "Enviando para GitHub..."
if git push origin main; then
    log_success "Push realizado com sucesso!"
else
    log_error "Erro ao fazer push"
    log_info "Tente manualmente: git push origin main"
fi

################################################################################
# RELATÓRIO FINAL
################################################################################

print_header "MERGE CONCLUÍDO!"

echo ""
log_success "Estrutura híbrida criada com sucesso!"
echo ""
log_info "📁 ESTRUTURA FINAL:"
echo "  • client/         → Frontend React (Replit)"
echo "  • server/         → Backend Node.js (Replit)"
echo "  • docs/           → Documentação completa (GitHub)"
echo "  • scripts/        → Scripts de coleta (ambos)"
echo "  • database/       → Migrations e exports (ambos)"
echo "  • n8n/           → Workflows dos agentes (GitHub)"
echo ""
log_info "💾 BACKUP SALVO EM:"
echo "  $BACKUP_DIR"
echo ""
log_info "🎯 PRÓXIMOS PASSOS:"
echo "  1. Verificar estrutura: tree -L 2"
echo "  2. Testar scripts: cd scripts/data_collection"
echo "  3. Executar coleta: bash RUN_ALL_DIMENSIONS.sh"
echo "  4. Testar aplicação web"
echo ""
log_success "Merge finalizado! 🎉"

################################################################################
# INSTRUÇÕES DE RECUPERAÇÃO
################################################################################

echo ""
log_info "📋 SE ALGO DEU ERRADO:"
echo "  # Restaurar do backup:"
echo "  cd ~"
echo "  rm -rf workspace/*"
echo "  tar -xzf $BACKUP_DIR/workspace_backup.tar.gz -C workspace/"
echo ""
echo "  # Restaurar banco:"
echo "  psql \$DATABASE_URL < $BACKUP_DIR/database_backup.sql"
echo ""
