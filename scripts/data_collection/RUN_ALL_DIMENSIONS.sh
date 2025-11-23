#!/bin/bash
################################################################################
# Script de Execução Automática - Todas as Dimensões
# Framework V6.0 - Carregamento Completo de Dados Reais
#
# Este script executa automaticamente:
# 1. Backup do banco de dados
# 2. Coleta de territórios com coordenadas
# 3. Coleta da dimensão econômica (SICONFI)
# 4. Coleta da dimensão social (IBGE + INEP)
# 5. Coleta da dimensão territorial (IBGE)
# 6. Coleta da dimensão ambiental (INPE + MapBiomas)
# 7. Verificação final e relatório
#
# Tempo total estimado: 60-90 minutos
#
# Uso: bash RUN_ALL_DIMENSIONS.sh
################################################################################

set -e  # Parar em caso de erro

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funções auxiliares
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

print_separator() {
    echo ""
    echo "------------------------------------------"
    echo ""
}

# Verificar se está no diretório correto
if [ ! -f "01_collect_territories_with_coordinates.py" ]; then
    log_error "Scripts não encontrados. Navegue para /scripts/data_collection"
    exit 1
fi

# Criar diretório de logs
mkdir -p logs
LOG_FILE="logs/run_all_$(date +%Y%m%d_%H%M%S).log"

# Função para log duplo (console + arquivo)
log_both() {
    echo "$1" | tee -a "$LOG_FILE"
}

# Início
print_header "FRAMEWORK V6.0 - CARREGAMENTO AUTOMÁTICO DE DADOS"
log_both "Início: $(date)"
log_both "Log: $LOG_FILE"
print_separator

################################################################################
# FASE 0: VERIFICAÇÃO DO AMBIENTE
################################################################################

print_header "FASE 0: VERIFICAÇÃO DO AMBIENTE"

log_info "Verificando Python..."
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version)
    log_success "$PYTHON_VERSION"
else
    log_error "Python3 não encontrado"
    exit 1
fi

log_info "Verificando biblioteca requests..."
if python3 -c "import requests" 2>/dev/null; then
    log_success "requests instalado"
else
    log_warning "requests não instalado. Instalando..."
    pip3 install requests
fi

log_info "Verificando PostgreSQL..."
if command -v psql &> /dev/null; then
    log_success "PostgreSQL disponível"
else
    log_error "psql não encontrado"
    exit 1
fi

log_info "Verificando DATABASE_URL..."
if [ -z "$DATABASE_URL" ]; then
    log_error "DATABASE_URL não definida"
    exit 1
else
    log_success "DATABASE_URL definida"
fi

log_info "Testando conexão com banco..."
if psql "$DATABASE_URL" -c "SELECT 1;" &> /dev/null; then
    log_success "Conexão OK"
else
    log_error "Erro ao conectar no banco"
    exit 1
fi

print_separator

################################################################################
# FASE 1: BACKUP DO BANCO DE DADOS
################################################################################

print_header "FASE 1: BACKUP DO BANCO DE DADOS"

BACKUP_FILE="backup_before_load_$(date +%Y%m%d_%H%M%S).sql"
log_info "Criando backup: $BACKUP_FILE"

pg_dump "$DATABASE_URL" > "$BACKUP_FILE" 2>&1 | tee -a "$LOG_FILE"

if [ -f "$BACKUP_FILE" ]; then
    BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    log_success "Backup criado: $BACKUP_SIZE"
else
    log_error "Falha ao criar backup"
    exit 1
fi

print_separator

################################################################################
# FASE 2: COLETA DE TERRITÓRIOS
################################################################################

print_header "FASE 2: COLETA DE TERRITÓRIOS (140 municípios + estado)"

if [ -f "insert_territories_with_coordinates.sql" ]; then
    log_warning "Arquivo insert_territories_with_coordinates.sql já existe"
    read -p "Deseja reexecutar a coleta de territórios? (s/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Ss]$ ]]; then
        log_info "Executando coleta de territórios..."
        python3 01_collect_territories_with_coordinates.py 2>&1 | tee -a "$LOG_FILE"
    else
        log_info "Pulando coleta de territórios (usando arquivo existente)"
    fi
else
    log_info "Executando coleta de territórios..."
    python3 01_collect_territories_with_coordinates.py 2>&1 | tee -a "$LOG_FILE"
fi

log_info "Inserindo territórios no banco..."
psql "$DATABASE_URL" -f insert_territories_with_coordinates.sql 2>&1 | tee -a "$LOG_FILE"

TERRITORIES_COUNT=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM territories;")
log_success "Territórios inseridos: $TERRITORIES_COUNT"

print_separator

################################################################################
# FASE 3: DIMENSÃO ECONÔMICA
################################################################################

print_header "FASE 3: DIMENSÃO ECONÔMICA (SICONFI - Receitas e Despesas)"

if [ -f "insert_economic_indicators.sql" ]; then
    log_warning "Arquivo insert_economic_indicators.sql já existe"
    read -p "Deseja reexecutar a coleta econômica? (s/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Ss]$ ]]; then
        log_info "Executando coleta econômica..."
        python3 02_collect_economic_indicators.py 2>&1 | tee -a "$LOG_FILE"
    else
        log_info "Pulando coleta econômica (usando arquivo existente)"
    fi
else
    log_info "Executando coleta econômica (tempo estimado: 20-30 min)..."
    python3 02_collect_economic_indicators.py 2>&1 | tee -a "$LOG_FILE"
fi

log_info "Inserindo indicadores econômicos no banco..."
psql "$DATABASE_URL" -f insert_economic_indicators.sql 2>&1 | tee -a "$LOG_FILE"

ECONOMIC_COUNT=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM economic_indicators;")
log_success "Indicadores econômicos inseridos: $ECONOMIC_COUNT"

print_separator

################################################################################
# FASE 4: DIMENSÃO SOCIAL
################################################################################

print_header "FASE 4: DIMENSÃO SOCIAL (IBGE + INEP - População, Educação, Saúde)"

if [ -f "insert_social_indicators.sql" ]; then
    log_warning "Arquivo insert_social_indicators.sql já existe"
    read -p "Deseja reexecutar a coleta social? (s/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Ss]$ ]]; then
        log_info "Executando coleta social..."
        python3 03_collect_social_indicators.py 2>&1 | tee -a "$LOG_FILE"
    else
        log_info "Pulando coleta social (usando arquivo existente)"
    fi
else
    log_info "Executando coleta social (tempo estimado: 15-20 min)..."
    python3 03_collect_social_indicators.py 2>&1 | tee -a "$LOG_FILE"
fi

log_info "Inserindo indicadores sociais no banco..."
psql "$DATABASE_URL" -f insert_social_indicators.sql 2>&1 | tee -a "$LOG_FILE"

SOCIAL_COUNT=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM social_indicators;")
log_success "Indicadores sociais inseridos: $SOCIAL_COUNT"

print_separator

################################################################################
# FASE 5: DIMENSÃO TERRITORIAL
################################################################################

print_header "FASE 5: DIMENSÃO TERRITORIAL (IBGE - Área, Saneamento, Infraestrutura)"

log_info "Executando coleta territorial (tempo estimado: 15-20 min)..."
python3 04_collect_territorial_indicators.py 2>&1 | tee -a "$LOG_FILE"

log_info "Inserindo indicadores territoriais no banco..."
psql "$DATABASE_URL" -f insert_territorial_indicators.sql 2>&1 | tee -a "$LOG_FILE"

TERRITORIAL_COUNT=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM territorial_indicators;")
log_success "Indicadores territoriais inseridos: $TERRITORIAL_COUNT"

print_separator

################################################################################
# FASE 6: DIMENSÃO AMBIENTAL
################################################################################

print_header "FASE 6: DIMENSÃO AMBIENTAL (INPE + MapBiomas - Desmatamento, Queimadas)"

log_info "Executando coleta ambiental (tempo estimado: 20-25 min)..."
python3 05_collect_environmental_indicators.py 2>&1 | tee -a "$LOG_FILE"

log_info "Inserindo indicadores ambientais no banco..."
psql "$DATABASE_URL" -f insert_environmental_indicators.sql 2>&1 | tee -a "$LOG_FILE"

ENVIRONMENTAL_COUNT=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM environmental_indicators;")
log_success "Indicadores ambientais inseridos: $ENVIRONMENTAL_COUNT"

print_separator

################################################################################
# FASE 7: VERIFICAÇÃO FINAL
################################################################################

print_header "FASE 7: VERIFICAÇÃO FINAL E RELATÓRIO"

log_info "Gerando relatório completo..."

psql "$DATABASE_URL" << 'EOF' | tee -a "$LOG_FILE"

-- Resumo Geral
SELECT '=== RESUMO GERAL ===' as titulo;
SELECT 
    'territories' as tabela, 
    COUNT(*) as registros,
    CASE WHEN COUNT(*) = 140 THEN '✓ OK' ELSE '✗ ERRO' END as status
FROM territories
UNION ALL
SELECT 
    'economic_indicators', 
    COUNT(*),
    CASE WHEN COUNT(*) >= 700 THEN '✓ OK' ELSE '✗ ERRO' END
FROM economic_indicators
UNION ALL
SELECT 
    'social_indicators', 
    COUNT(*),
    CASE WHEN COUNT(*) >= 700 THEN '✓ OK' ELSE '✗ ERRO' END
FROM social_indicators
UNION ALL
SELECT 
    'territorial_indicators', 
    COUNT(*),
    CASE WHEN COUNT(*) >= 700 THEN '✓ OK' ELSE '✗ ERRO' END
FROM territorial_indicators
UNION ALL
SELECT 
    'environmental_indicators', 
    COUNT(*),
    CASE WHEN COUNT(*) >= 700 THEN '✓ OK' ELSE '✗ ERRO' END
FROM environmental_indicators
ORDER BY tabela;

-- Distribuição por Ano
SELECT '' as separador;
SELECT '=== DISTRIBUIÇÃO POR ANO ===' as titulo;

SELECT 'Econômica' as dimensao, year as ano, COUNT(*) as registros 
FROM economic_indicators GROUP BY year
UNION ALL
SELECT 'Social', year, COUNT(*) 
FROM social_indicators GROUP BY year
UNION ALL
SELECT 'Territorial', year, COUNT(*) 
FROM territorial_indicators GROUP BY year
UNION ALL
SELECT 'Ambiental', year, COUNT(*) 
FROM environmental_indicators GROUP BY year
ORDER BY dimensao, ano;

-- Amostra de Dados (Palmas - Capital)
SELECT '' as separador;
SELECT '=== AMOSTRA DE DADOS (PALMAS - 1721000) ===' as titulo;

SELECT 'Econômica' as dimensao, year, 
       ROUND(total_revenue/1000000, 2) as receita_milhoes,
       ROUND(total_expenditure/1000000, 2) as despesa_milhoes
FROM economic_indicators 
WHERE territory_id = '1721000' 
ORDER BY year;

SELECT 'Social' as dimensao, year, 
       population as populacao,
       ROUND(hdi_m, 3) as idhm
FROM social_indicators 
WHERE territory_id = '1721000' 
ORDER BY year;

SELECT 'Territorial' as dimensao, year,
       area_km2,
       ROUND(density_per_km2, 2) as densidade,
       ROUND(water_supply_pct, 1) as agua_pct
FROM territorial_indicators 
WHERE territory_id = '1721000' 
ORDER BY year;

SELECT 'Ambiental' as dimensao, year,
       fire_spots as focos_calor,
       ROUND(deforestation_km2, 2) as desmatamento_km2,
       ROUND(native_vegetation_pct, 1) as vegetacao_nativa_pct
FROM environmental_indicators 
WHERE territory_id = '1721000' 
ORDER BY year;

EOF

print_separator

################################################################################
# RELATÓRIO FINAL
################################################################################

print_header "CARREGAMENTO CONCLUÍDO COM SUCESSO!"

log_both ""
log_both "📊 ESTATÍSTICAS FINAIS:"
log_both "  • Territórios: $TERRITORIES_COUNT"
log_both "  • Indicadores Econômicos: $ECONOMIC_COUNT"
log_both "  • Indicadores Sociais: $SOCIAL_COUNT"
log_both "  • Indicadores Territoriais: $TERRITORIAL_COUNT"
log_both "  • Indicadores Ambientais: $ENVIRONMENTAL_COUNT"
log_both ""

TOTAL_INDICATORS=$((ECONOMIC_COUNT + SOCIAL_COUNT + TERRITORIAL_COUNT + ENVIRONMENTAL_COUNT))
log_both "  📈 TOTAL DE INDICADORES: $TOTAL_INDICATORS"
log_both ""

log_both "💾 ARQUIVOS GERADOS:"
log_both "  • Backup: $BACKUP_FILE"
log_both "  • Log completo: $LOG_FILE"
log_both "  • SQLs: insert_*.sql"
log_both ""

log_both "🎯 PRÓXIMOS PASSOS:"
log_both "  1. Testar os agentes especialistas com dados reais"
log_both "  2. Criar o Orquestrador (Meta-LLM)"
log_both "  3. Integrar com o dashboard"
log_both "  4. Implementar sistema RAG na knowledge base"
log_both ""

log_both "Término: $(date)"
log_both ""

log_success "Todos os dados foram carregados com sucesso! 🎉"

print_separator

# Perguntar se deseja limpar arquivos SQL temporários
read -p "Deseja remover os arquivos SQL temporários? (s/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]; then
    log_info "Removendo arquivos SQL..."
    rm -f insert_*.sql
    log_success "Arquivos removidos (backup preservado)"
else
    log_info "Arquivos SQL preservados"
fi

log_success "Script finalizado!"
