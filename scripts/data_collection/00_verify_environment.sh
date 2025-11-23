#!/bin/bash
# Script de Verificação do Ambiente
# Framework V6.0 - Pré-requisitos para execução manual

echo "=========================================="
echo "VERIFICAÇÃO DO AMBIENTE"
echo "=========================================="
echo ""

# 1. Verificar Python
echo "1. Verificando Python..."
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version)
    echo "   ✓ $PYTHON_VERSION"
else
    echo "   ✗ Python3 não encontrado"
    exit 1
fi
echo ""

# 2. Verificar pip
echo "2. Verificando pip..."
if command -v pip3 &> /dev/null; then
    PIP_VERSION=$(pip3 --version)
    echo "   ✓ $PIP_VERSION"
else
    echo "   ✗ pip3 não encontrado"
    exit 1
fi
echo ""

# 3. Verificar biblioteca requests
echo "3. Verificando biblioteca requests..."
if python3 -c "import requests" 2>/dev/null; then
    REQUESTS_VERSION=$(python3 -c "import requests; print(requests.__version__)")
    echo "   ✓ requests $REQUESTS_VERSION instalado"
else
    echo "   ✗ requests não instalado"
    echo "   → Instalando: pip3 install requests"
    pip3 install requests
fi
echo ""

# 4. Verificar PostgreSQL
echo "4. Verificando PostgreSQL..."
if command -v psql &> /dev/null; then
    PSQL_VERSION=$(psql --version)
    echo "   ✓ $PSQL_VERSION"
else
    echo "   ✗ psql não encontrado"
    exit 1
fi
echo ""

# 5. Verificar DATABASE_URL
echo "5. Verificando DATABASE_URL..."
if [ -z "$DATABASE_URL" ]; then
    echo "   ✗ DATABASE_URL não definida"
    echo "   → Defina com: export DATABASE_URL='postgresql://...'"
    exit 1
else
    echo "   ✓ DATABASE_URL definida"
    # Testar conexão
    if psql "$DATABASE_URL" -c "SELECT 1;" &> /dev/null; then
        echo "   ✓ Conexão com banco OK"
    else
        echo "   ✗ Erro ao conectar no banco"
        exit 1
    fi
fi
echo ""

# 6. Verificar diretório
echo "6. Verificando diretório..."
CURRENT_DIR=$(pwd)
echo "   Diretório atual: $CURRENT_DIR"
if [ -f "01_collect_territories_with_coordinates.py" ]; then
    echo "   ✓ Scripts encontrados"
else
    echo "   ⚠ Scripts não encontrados neste diretório"
    echo "   → Navegue para: cd /scripts/data_collection"
fi
echo ""

# 7. Verificar arquivos necessários
echo "7. Verificando arquivos necessários..."
if [ -f "insert_territories_with_coordinates.sql" ]; then
    echo "   ✓ insert_territories_with_coordinates.sql"
else
    echo "   ✗ insert_territories_with_coordinates.sql não encontrado"
    echo "   → Execute primeiro: python3 01_collect_territories_with_coordinates.py"
fi

if [ -f "insert_social_indicators.sql" ]; then
    echo "   ✓ insert_social_indicators.sql"
else
    echo "   ⚠ insert_social_indicators.sql não encontrado (necessário para densidade)"
fi
echo ""

# 8. Verificar status do banco
echo "8. Verificando status do banco de dados..."
echo ""
psql "$DATABASE_URL" << 'EOF'
SELECT 
    'territories' as tabela, 
    COUNT(*) as registros,
    CASE WHEN COUNT(*) = 140 THEN '✓' ELSE '✗' END as status
FROM territories
UNION ALL
SELECT 
    'economic_indicators', 
    COUNT(*),
    CASE WHEN COUNT(*) >= 700 THEN '✓' ELSE '✗' END
FROM economic_indicators
UNION ALL
SELECT 
    'social_indicators', 
    COUNT(*),
    CASE WHEN COUNT(*) >= 700 THEN '✓' ELSE '✗' END
FROM social_indicators
UNION ALL
SELECT 
    'territorial_indicators', 
    COUNT(*),
    CASE WHEN COUNT(*) >= 700 THEN '✓' ELSE '⏳' END
FROM territorial_indicators
UNION ALL
SELECT 
    'environmental_indicators', 
    COUNT(*),
    CASE WHEN COUNT(*) >= 700 THEN '✓' ELSE '⏳' END
FROM environmental_indicators
ORDER BY tabela;
EOF

echo ""
echo "=========================================="
echo "VERIFICAÇÃO CONCLUÍDA"
echo "=========================================="
echo ""
echo "Próximos passos:"
echo "  1. cd /scripts/data_collection"
echo "  2. python3 04_collect_territorial_indicators.py"
echo "  3. psql \$DATABASE_URL -f insert_territorial_indicators.sql"
echo "  4. python3 05_collect_environmental_indicators.py"
echo "  5. psql \$DATABASE_URL -f insert_environmental_indicators.sql"
echo ""
