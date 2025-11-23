#!/bin/bash

# ============================================
# Script de Teste Simplificado - Integração Dashboard ↔ n8n
# Framework de Inteligência Territorial V6.0
# 
# Este script testa os webhooks do n8n usando curl.
# Mais simples que o script Node.js, ideal para testes rápidos.
# 
# Uso:
#   chmod +x test-n8n-integration.sh
#   ./test-n8n-integration.sh
# 
# @author Manus AI
# @version 1.0.0
# @date 2025-11-16
# ============================================

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

# Configuração
N8N_BASE_URL="https://galactic-ai.app.n8n.cloud"

# Contadores
PASSED=0
FAILED=0

# ============================================
# FUNÇÕES AUXILIARES
# ============================================

print_header() {
  echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
  echo -e "${BLUE}║  Teste de Integração Dashboard ↔ n8n Cloud                ║${NC}"
  echo -e "${BLUE}║  Framework de Inteligência Territorial V6.0                ║${NC}"
  echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
  echo ""
  echo -e "${GRAY}Base URL: ${N8N_BASE_URL}${NC}"
  echo ""
}

test_webhook() {
  local test_name="$1"
  local endpoint="$2"
  local payload="$3"
  local expect_error="${4:-false}"
  
  echo -e "${BLUE}[TESTE]${NC} $test_name"
  echo -e "${GRAY}  Endpoint: $endpoint${NC}"
  
  # Fazer requisição
  local response=$(curl -s -w "\n%{http_code}" -X POST \
    "${N8N_BASE_URL}${endpoint}" \
    -H "Content-Type: application/json" \
    -d "$payload")
  
  # Separar body e status code
  local http_code=$(echo "$response" | tail -n1)
  local body=$(echo "$response" | sed '$d')
  
  # Validar resposta
  if [ "$expect_error" = "true" ]; then
    # Esperamos erro (400 ou campo "error": true)
    if [ "$http_code" = "400" ] || echo "$body" | grep -q '"error".*true'; then
      echo -e "  ${GREEN}✓ PASSOU${NC} (HTTP $http_code)"
      ((PASSED++))
    else
      echo -e "  ${RED}✗ FALHOU${NC} (Esperava erro mas recebeu sucesso)"
      ((FAILED++))
    fi
  else
    # Esperamos sucesso (200)
    if [ "$http_code" = "200" ]; then
      echo -e "  ${GREEN}✓ PASSOU${NC} (HTTP $http_code)"
      ((PASSED++))
    else
      echo -e "  ${RED}✗ FALHOU${NC} (HTTP $http_code)"
      echo -e "  ${RED}  Resposta: $body${NC}"
      ((FAILED++))
    fi
  fi
  
  echo ""
  sleep 1 # Aguardar 1 segundo entre testes
}

print_summary() {
  local total=$((PASSED + FAILED))
  local success_rate=$(awk "BEGIN {printf \"%.1f\", ($PASSED/$total)*100}")
  
  echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
  echo -e "${BLUE}║  RESUMO DOS TESTES                                         ║${NC}"
  echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
  echo ""
  echo "Total de testes:    $total"
  echo -e "${GREEN}Testes aprovados:   $PASSED${NC}"
  echo -e "${RED}Testes falhados:    $FAILED${NC}"
  echo "Taxa de sucesso:    ${success_rate}%"
  echo ""
  
  if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ✓ TODOS OS TESTES PASSARAM!                               ║${NC}"
    echo -e "${GREEN}║  Integração dashboard ↔ n8n funcionando perfeitamente.     ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
    exit 0
  else
    echo -e "${RED}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║  ✗ ALGUNS TESTES FALHARAM                                  ║${NC}"
    echo -e "${RED}║  Verifique os erros acima e corrija antes de prosseguir.   ║${NC}"
    echo -e "${RED}╚════════════════════════════════════════════════════════════╝${NC}"
    exit 1
  fi
}

# ============================================
# EXECUTAR TESTES
# ============================================

print_header

# Teste 1: Integração Básica
test_webhook \
  "Teste 1: Integração Básica" \
  "/webhook/test-integration" \
  '{
    "territory_id": 1,
    "territory_name": "Tocantins",
    "test_message": "Teste automatizado"
  }' \
  false

# Teste 2: Receptor Principal - Análise Econômica
test_webhook \
  "Teste 2: Receptor Principal - Análise Econômica" \
  "/webhook/dashboard-request" \
  '{
    "request_type": "analysis",
    "territory_id": 1,
    "territory_name": "Palmas",
    "dimension": "economic",
    "parameters": {"year": 2023}
  }' \
  false

# Teste 3: Receptor Principal - Coleta de Dados
test_webhook \
  "Teste 3: Receptor Principal - Coleta de Dados" \
  "/webhook/dashboard-request" \
  '{
    "request_type": "data_collection",
    "territory_id": 1,
    "territory_name": "Palmas",
    "dimension": "social",
    "parameters": {"year": 2023}
  }' \
  false

# Teste 4: Receptor Principal - Comparação
test_webhook \
  "Teste 4: Receptor Principal - Comparação" \
  "/webhook/dashboard-request" \
  '{
    "request_type": "comparison",
    "territory_id": 1,
    "territory_name": "Palmas",
    "dimension": "economic",
    "parameters": {
      "comparison_territories": [2, 3],
      "year": 2023
    }
  }' \
  false

# Teste 5: Análise Territorial Completa (pode demorar)
echo -e "${YELLOW}⚠ Teste 5 pode demorar 30-60 segundos (análise com LLM)${NC}"
test_webhook \
  "Teste 5: Análise Territorial Completa" \
  "/webhook/analise-territorial" \
  '{
    "territory_id": 1,
    "territory_name": "Palmas",
    "year": 2023
  }' \
  false

# Teste 6: Validação - Request Type Inválido (deve falhar)
test_webhook \
  "Teste 6: Validação - Request Type Inválido" \
  "/webhook/dashboard-request" \
  '{
    "request_type": "invalid_type",
    "territory_id": 1,
    "territory_name": "Palmas",
    "dimension": "economic"
  }' \
  true

# Teste 7: Validação - Campos Obrigatórios Ausentes (deve falhar)
test_webhook \
  "Teste 7: Validação - Campos Obrigatórios Ausentes" \
  "/webhook/dashboard-request" \
  '{
    "request_type": "analysis"
  }' \
  true

# Resumo final
print_summary
