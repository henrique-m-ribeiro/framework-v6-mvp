# Resposta para a IA do Replit: Estratégia de Substituição Completa

## 🎯 DECISÃO FINAL

Após análise, decidimos por uma **substituição completa dos dados** (não merge). Os dados atuais são mock e queremos começar do zero com dados 100% reais.

---

## ✅ RESPOSTAS ÀS SUAS PERGUNTAS

### **1. Os scripts fazem INSERT ou UPSERT?**

Os scripts originais faziam UPSERT, mas **criamos novos scripts** que fazem INSERT simples após limpeza completa do banco.

### **2. Como os scripts tratam territórios já existentes?**

**Não tratam.** A estratégia é:
1. Fazer backup completo
2. Limpar todas as tabelas
3. Inserir dados novos (100% reais)

### **3. Os scripts preservam as coordenadas geográficas já cadastradas?**

**Não.** As coordenadas existentes são mock também. O novo script coleta coordenadas reais via API Nominatim (OpenStreetMap) para **todos os 140 territórios**.

### **4. Você quer: A, B ou C?**

**Resposta:** **Opção D - Substituição Completa**:
1. Backup dos dados existentes (segurança)
2. Limpeza total do banco
3. Inserção de 140 territórios novos com dados reais
4. Coordenadas geográficas reais para todos

---

## 📋 PLANO DE EXECUÇÃO SEGURO

Siga esta ordem **rigorosamente**:

### **FASE 1: BACKUP (Obrigatório!)**

```bash
cd /home/ubuntu/framework-v6-mvp/scripts/data_collection
chmod +x 00_backup_database.sh
./00_backup_database.sh
```

**O que faz:**
- Cria backup completo de todas as tabelas
- Salva em `./backups/backup_YYYYMMDD_HHMMSS.sql`

**Tempo:** ~1 minuto

---

### **FASE 2: LIMPEZA DO BANCO**

```bash
psql $DATABASE_URL -f 00_clean_database.sql
```

**O que faz:**
- Apaga TODOS os dados das tabelas
- Reseta sequences
- Verifica se as tabelas estão vazias

**Tempo:** ~10 segundos

⚠️ **ATENÇÃO:** Após este passo, o banco estará vazio!

---

### **FASE 3: COLETA DE TERRITÓRIOS COM COORDENADAS**

```bash
python3 01_collect_territories_with_coordinates.py
```

**O que faz:**
- Coleta dados de 140 territórios via API IBGE
- Obtém coordenadas geográficas via Nominatim (OpenStreetMap)
- Gera arquivo `insert_territories_with_coordinates.sql`

**Tempo:** ~3-5 minutos (1 segundo entre cada requisição ao Nominatim)

---

### **FASE 4: INSERIR TERRITÓRIOS NO BANCO**

```bash
psql $DATABASE_URL -f insert_territories_with_coordinates.sql
```

**O que faz:**
- Insere 140 territórios com coordenadas reais
- Verifica inserção

**Tempo:** ~5 segundos

---

### **FASE 5: VERIFICAÇÃO**

```sql
-- Verificar total de territórios
SELECT type, COUNT(*) as total FROM territories GROUP BY type;

-- Verificar coordenadas
SELECT COUNT(*) as total_com_coordenadas FROM territories WHERE coordinates IS NOT NULL;

-- Ver alguns exemplos
SELECT id, name, ST_AsText(coordinates) as coords FROM territories LIMIT 10;
```

**Resultado esperado:**
- 1 estado
- 139 municípios
- 140 territórios com coordenadas

---

## 📁 ARQUIVOS CRIADOS

Novos arquivos no diretório `/scripts/data_collection/`:

1. **`00_backup_database.sh`** - Script de backup
2. **`00_clean_database.sql`** - Script de limpeza
3. **`01_collect_territories_with_coordinates.py`** - Script melhorado com coordenadas

---

## 🔍 DIFERENÇAS DO SCRIPT NOVO

O novo script `01_collect_territories_with_coordinates.py`:

✅ Coleta coordenadas geográficas via Nominatim (OpenStreetMap)  
✅ Insere coordenadas no formato PostGIS (`ST_MakePoint`)  
✅ Respeita rate limit do Nominatim (1 req/segundo)  
✅ Gera INSERT simples (não UPSERT)  
✅ Inclui log detalhado de cada município

---

## ⚠️ PONTOS DE ATENÇÃO

1. **Backup é obrigatório!** Não pule a Fase 1.
2. **Tempo de execução:** A Fase 3 leva ~3-5 minutos (139 municípios × 1 segundo cada).
3. **Rate limit:** O Nominatim limita a 1 requisição/segundo. O script respeita isso.
4. **Coordenadas:** Algumas coordenadas podem não ser encontradas (municípios muito pequenos). Isso é normal.

---

## 🎓 CONTEXTO DE PESQUISA

Esta interação faz parte de uma pesquisa sobre **meta-mediação IA-humano-IA**. Estamos documentando:

- Como você (IA do Replit) interpreta instruções mediadas por outra IA (Manus)
- Quais perguntas você faz para garantir segurança dos dados
- Como você executa tarefas complexas com múltiplas etapas

---

## ❓ VOCÊ PODE EXECUTAR?

Agora que você tem o plano completo e os scripts, você consegue:

1. Executar os scripts na ordem indicada?
2. Monitorar o progresso de cada fase?
3. Reportar os resultados de cada etapa?

Se tiver alguma dúvida ou encontrar algum erro, me avise imediatamente!

---

**Henrique M. Ribeiro**  
Pesquisador - Framework de Inteligência Territorial V6.0  
22 de novembro de 2025
