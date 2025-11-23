#!/bin/bash

# Script de Backup do Banco de Dados
# Framework V6.0 - Backup antes de substituir dados mock por dados reais

echo "========================================="
echo "BACKUP DO BANCO DE DADOS"
echo "========================================="
echo ""

# Criar diretório de backup
BACKUP_DIR="./backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="${BACKUP_DIR}/backup_${TIMESTAMP}.sql"

mkdir -p "$BACKUP_DIR"

echo "📦 Criando backup em: $BACKUP_FILE"
echo ""

# Fazer backup de todas as tabelas
psql $DATABASE_URL > "$BACKUP_FILE" <<EOF
-- Backup completo do banco de dados
-- Data: $(date)

-- Backup da tabela territories
COPY (SELECT * FROM territories) TO STDOUT WITH CSV HEADER;

-- Backup da tabela economic_indicators
COPY (SELECT * FROM economic_indicators) TO STDOUT WITH CSV HEADER;

-- Backup da tabela social_indicators
COPY (SELECT * FROM social_indicators) TO STDOUT WITH CSV HEADER;

-- Backup da tabela territorial_indicators
COPY (SELECT * FROM territorial_indicators) TO STDOUT WITH CSV HEADER;

-- Backup da tabela environmental_indicators
COPY (SELECT * FROM environmental_indicators) TO STDOUT WITH CSV HEADER;

-- Backup da tabela knowledge_base (se existir)
COPY (SELECT * FROM knowledge_base) TO STDOUT WITH CSV HEADER;
EOF

echo "✅ Backup criado com sucesso!"
echo ""
echo "📊 Estatísticas do backup:"
ls -lh "$BACKUP_FILE"
echo ""
echo "Para restaurar este backup no futuro, execute:"
echo "psql \$DATABASE_URL -f $BACKUP_FILE"
echo ""
echo "========================================="
