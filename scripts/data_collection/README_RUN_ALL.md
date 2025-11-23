# Script de Execução Automática - Todas as Dimensões

## 🎯 Visão Geral

O script `RUN_ALL_DIMENSIONS.sh` executa **automaticamente** o carregamento completo de dados reais para todas as 4 dimensões do Framework V6.0.

---

## ⚡ Uso Rápido

```bash
cd /scripts/data_collection
bash RUN_ALL_DIMENSIONS.sh
```

**Tempo total estimado:** 60-90 minutos

---

## 📋 O que o Script Faz

### **Fase 0: Verificação do Ambiente**
- ✓ Verifica Python 3
- ✓ Verifica biblioteca `requests`
- ✓ Verifica PostgreSQL
- ✓ Testa conexão com banco de dados
- ✓ Valida `DATABASE_URL`

### **Fase 1: Backup Automático**
- 💾 Cria backup completo do banco antes de qualquer alteração
- 📁 Arquivo: `backup_before_load_YYYYMMDD_HHMMSS.sql`

### **Fase 2: Coleta de Territórios**
- 🗺️ Coleta 140 territórios (139 municípios + 1 estado)
- 📍 Obtém coordenadas geográficas via Nominatim
- 💾 Insere no banco de dados

### **Fase 3: Dimensão Econômica**
- 💰 Coleta receitas e despesas via SICONFI
- 📊 5 anos de dados (2019-2023)
- 🎯 ~700 registros

### **Fase 4: Dimensão Social**
- 👥 Coleta população, IDH-M, educação, saúde
- 🏫 APIs: IBGE + INEP
- 🎯 ~700 registros

### **Fase 5: Dimensão Territorial**
- 🏘️ Coleta área, densidade, saneamento, infraestrutura
- 🚰 Dados de conectividade
- 🎯 ~700 registros

### **Fase 6: Dimensão Ambiental**
- 🌳 Coleta desmatamento, queimadas, cobertura vegetal
- 🔥 Áreas protegidas e recursos hídricos
- 🎯 ~700 registros

### **Fase 7: Verificação Final**
- ✅ Valida todos os dados inseridos
- 📊 Gera relatório completo
- 📈 Mostra estatísticas por dimensão e ano
- 🔍 Exibe amostra de dados (Palmas)

---

## 📊 Resultado Esperado

```
=== RESUMO GERAL ===
        tabela         | registros | status 
-----------------------+-----------+--------
 economic_indicators       |     700 | ✓ OK
 environmental_indicators  |     700 | ✓ OK
 social_indicators         |     700 | ✓ OK
 territorial_indicators    |     700 | ✓ OK
 territories               |     140 | ✓ OK

📈 TOTAL DE INDICADORES: 2.800
```

---

## 🎛️ Recursos do Script

### **1. Logs Detalhados**
- Console colorido com status em tempo real
- Arquivo de log completo: `logs/run_all_YYYYMMDD_HHMMSS.log`
- Registro de todas as operações e erros

### **2. Proteção contra Reexecução**
- Detecta arquivos SQL já existentes
- Pergunta se deseja reexecutar cada fase
- Evita duplicação de dados

### **3. Backup Automático**
- Backup completo antes de qualquer alteração
- Permite restauração em caso de erro
- Preservado mesmo após limpeza

### **4. Verificação de Integridade**
- Valida contagem de registros
- Verifica distribuição por ano
- Mostra amostra de dados reais

### **5. Limpeza Opcional**
- Pergunta se deseja remover SQLs temporários
- Preserva backup e logs
- Libera espaço em disco

---

## 🚀 Exemplo de Execução

```bash
$ cd /scripts/data_collection
$ bash RUN_ALL_DIMENSIONS.sh

==========================================
FRAMEWORK V6.0 - CARREGAMENTO AUTOMÁTICO DE DADOS
==========================================

Início: 2025-11-22 14:30:00
Log: logs/run_all_20251122_143000.log

------------------------------------------

==========================================
FASE 0: VERIFICAÇÃO DO AMBIENTE
==========================================

[INFO] Verificando Python...
[✓] Python 3.11.0
[INFO] Verificando biblioteca requests...
[✓] requests instalado
[INFO] Verificando PostgreSQL...
[✓] PostgreSQL disponível
[INFO] Verificando DATABASE_URL...
[✓] DATABASE_URL definida
[INFO] Testando conexão com banco...
[✓] Conexão OK

------------------------------------------

==========================================
FASE 1: BACKUP DO BANCO DE DADOS
==========================================

[INFO] Criando backup: backup_before_load_20251122_143000.sql
[✓] Backup criado: 2.5M

------------------------------------------

[... continua com todas as fases ...]

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
  • Backup: backup_before_load_20251122_143000.sql
  • Log completo: logs/run_all_20251122_143000.log
  • SQLs: insert_*.sql

🎯 PRÓXIMOS PASSOS:
  1. Testar os agentes especialistas com dados reais
  2. Criar o Orquestrador (Meta-LLM)
  3. Integrar com o dashboard
  4. Implementar sistema RAG na knowledge base

Término: 2025-11-22 15:45:00

[✓] Todos os dados foram carregados com sucesso! 🎉
```

---

## ⚠️ Tratamento de Erros

O script usa `set -e`, o que significa que **para imediatamente** se qualquer comando falhar.

### **Erros Comuns:**

**1. DATABASE_URL não definida**
```bash
export DATABASE_URL="postgresql://user:pass@host:port/database"
```

**2. Biblioteca requests não instalada**
```bash
pip3 install requests
```

**3. Sem permissão para criar backup**
```bash
chmod +x RUN_ALL_DIMENSIONS.sh
```

**4. Erro de conexão com banco**
- Verifique se o PostgreSQL está ativo
- Teste: `psql $DATABASE_URL -c "SELECT 1;"`

---

## 📁 Estrutura de Arquivos Gerados

```
/scripts/data_collection/
├── RUN_ALL_DIMENSIONS.sh (script principal)
├── logs/
│   └── run_all_20251122_143000.log
├── backup_before_load_20251122_143000.sql
├── insert_territories_with_coordinates.sql
├── insert_economic_indicators.sql
├── insert_social_indicators.sql
├── insert_territorial_indicators.sql
└── insert_environmental_indicators.sql
```

---

## 🔄 Reexecutar o Script

Se precisar reexecutar:

### **Opção 1: Reexecutar Tudo**
```bash
rm -f insert_*.sql
bash RUN_ALL_DIMENSIONS.sh
```

### **Opção 2: Reexecutar Apenas Algumas Fases**
O script detecta arquivos existentes e pergunta se deseja reexecutar cada fase.

### **Opção 3: Restaurar Backup**
```bash
psql $DATABASE_URL < backup_before_load_20251122_143000.sql
```

---

## 🎓 Vantagens do Script Automatizado

✅ **Sem intervenção manual** - Executa tudo automaticamente  
✅ **Backup automático** - Segurança antes de qualquer alteração  
✅ **Logs completos** - Rastreabilidade total  
✅ **Verificação integrada** - Valida dados ao final  
✅ **Proteção contra duplicação** - Detecta execuções anteriores  
✅ **Relatório detalhado** - Estatísticas completas  
✅ **Código limpo** - Fácil de entender e modificar  

---

## 📞 Suporte

Se encontrar problemas:

1. Verifique o arquivo de log: `logs/run_all_*.log`
2. Execute o script de verificação: `bash 00_verify_environment.sh`
3. Consulte o guia manual: `/docs/GUIA_EXECUCAO_MANUAL_DIMENSOES.md`

---

## 🎯 Próximos Passos Após Execução

1. **Testar Agentes Especialistas**
   - Enviar requisições para os 4 webhooks n8n
   - Verificar análises geradas

2. **Criar Orquestrador**
   - Workflow Meta-LLM no n8n
   - Coordenação dos 4 agentes

3. **Integrar Dashboard**
   - Testar consultas via n8n-client.js
   - Validar visualizações

4. **Implementar RAG**
   - Popular knowledge_base
   - Testar busca semântica

---

**Boa execução! 🚀**

---

**Framework de Inteligência Territorial V6.0**  
Henrique M. Ribeiro  
22 de novembro de 2025
