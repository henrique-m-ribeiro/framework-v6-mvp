# Guia de Execução dos Scripts de Coleta de Dados

## 🎯 Objetivo

Este guia explica como executar os scripts Python para coletar dados reais de APIs governamentais e popular o banco de dados PostgreSQL do Framework V6.0.

---

## 📋 Pré-requisitos

1. **Ambiente Python 3.11+**
2. **Bibliotecas instaladas:** `requests`, `openpyxl`
3. **Banco de dados PostgreSQL** com as tabelas criadas (ver `database/migrations`)
4. **Credenciais do PostgreSQL** configuradas no Replit

---

## 🚀 Ordem de Execução

Os scripts devem ser executados na seguinte ordem:

1. **`01_collect_territories.py`** - Coleta dados básicos dos 140 territórios
2. **`02_collect_economic_indicators.py`** - Coleta dados econômicos (SICONFI)
3. **`03_collect_social_indicators.py`** - Coleta dados sociais (INEP, IBGE)
4. **`04_collect_territorial_environmental.py`** - Coleta dados territoriais e ambientais (IBGE, INPE)

---

## ⚙️ Como Executar

### **Passo 1: Navegar para o diretório**

```bash
cd /home/ubuntu/framework-v6-mvp/scripts/data_collection
```

### **Passo 2: Tornar scripts executáveis**

```bash
chmod +x *.py
```

### **Passo 3: Executar o primeiro script (Territórios)**

```bash
python3 01_collect_territories.py
```

**O que acontece:**
- Gera o arquivo `insert_territories.sql`
- Leva ~1 minuto

### **Passo 4: Executar o SQL no Replit**

1. Abra o arquivo `insert_territories.sql`
2. Copie todo o conteúdo
3. Cole no console SQL do PostgreSQL no Replit
4. Execute

### **Passo 5: Executar o segundo script (Econômico)**

```bash
python3 02_collect_economic_indicators.py
```

**O que acontece:**
- Gera o arquivo `insert_economic_indicators.sql`
- **Leva ~20-30 minutos** (SICONFI é lento)

### **Passo 6: Executar o SQL no Replit**

1. Abra o arquivo `insert_economic_indicators.sql`
2. Copie todo o conteúdo
3. Cole no console SQL do PostgreSQL no Replit
4. Execute

### **Passo 7: Repetir para os outros scripts**

Repita os passos 5 e 6 para os scripts `03` e `04`.

---

## ⚠️ ATENÇÃO

- **Tempo de Execução:** A coleta completa pode levar **mais de 1 hora**.
- **APIs:** As APIs governamentais podem estar lentas ou indisponíveis. Os scripts têm tratamento de erros, mas verifique os logs se houver problemas.
- **Ordem:** É **crucial** executar os scripts na ordem correta, pois os scripts de indicadores dependem dos territórios já existirem no banco.

---

## 🔍 Verificação

Após executar cada SQL, verifique no Replit se os dados foram inseridos corretamente:

```sql
-- Verificar territórios
SELECT COUNT(*) FROM territories; -- Deve ser 140

-- Verificar indicadores econômicos
SELECT COUNT(*) FROM economic_indicators; -- Deve ser ~700
```

---

## 🆘 Suporte

Se encontrar algum erro, verifique os arquivos de log (`.log`) gerados em cada etapa para mais detalhes.
