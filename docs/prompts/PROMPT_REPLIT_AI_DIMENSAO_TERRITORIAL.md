# Prompt para IA do Replit: Coleta da Dimensão Territorial

## 🎯 CONTEXTO

Excelente progresso! Já concluímos as dimensões **Econômica** e **Social**. Agora vamos prosseguir para a **Dimensão Territorial**.

---

## 📊 PROGRESSO ATUAL

✅ **Concluído:**
- Fase 1: Backup do banco de dados
- Fase 2: Limpeza das tabelas
- Fase 3: Coleta de 140 territórios com coordenadas
- Fase 4: Inserção de territórios no banco
- Fase 5: Coleta de indicadores econômicos (SICONFI)
- Fase 6: Coleta de indicadores sociais (IBGE + INEP)

🎯 **Próximo:**
- Fase 7: Coleta de indicadores territoriais (IBGE)

---

## 📋 TAREFA

Coletar dados da **Dimensão Territorial** para os 140 territórios do Tocantins (2019-2023).

### **Dados a Coletar:**

1. **Área e Geografia (IBGE)**
   - Área territorial (km²)
   - Densidade demográfica (hab/km²)
   - Altitude média
   - Bioma predominante

2. **Infraestrutura Urbana (IBGE Cidades)**
   - Saneamento básico:
     - % domicílios com água encanada
     - % domicílios com esgoto sanitário
     - % domicílios com coleta de lixo
   - Pavimentação de vias urbanas
   - Iluminação pública

3. **Conectividade (IBGE)**
   - % domicílios com internet
   - % domicílios com telefone
   - Distância à capital (km)

---

## 🔧 SCRIPT A EXECUTAR

O script já foi criado e está em:
```
/scripts/data_collection/04_collect_territorial_indicators.py
```

### **O que o script faz:**

1. Lê a lista de 140 territórios
2. Para cada território e cada ano (2019-2023):
   - Coleta área territorial via API IBGE
   - Calcula densidade demográfica (população/área)
   - Coleta dados de saneamento via IBGE Cidades
   - Coleta dados de conectividade
3. Gera arquivo `insert_territorial_indicators.sql`

### **Tempo estimado:** 15-20 minutos

---

## 📝 INSTRUÇÕES DE EXECUÇÃO

### **Passo 1: Executar o Script**

```bash
cd /scripts/data_collection
python3 04_collect_territorial_indicators.py
```

**Aguarde:** O script vai mostrar progresso no console.

---

### **Passo 2: Verificar o SQL Gerado**

Após a execução, verifique:

```bash
ls -lh insert_territorial_indicators.sql
head -50 insert_territorial_indicators.sql
```

---

### **Passo 3: Inserir no Banco de Dados**

```bash
psql $DATABASE_URL -f insert_territorial_indicators.sql
```

---

### **Passo 4: Verificar Inserção**

```sql
SELECT COUNT(*) FROM territorial_indicators;
SELECT year, COUNT(*) FROM territorial_indicators GROUP BY year ORDER BY year;
```

**Resultado esperado:** ~700 registros (140 territórios × 5 anos)

---

## ⚠️ PONTOS DE ATENÇÃO

1. **Área Territorial:** Alguns dados podem vir da planilha fornecida (DivisaoRegionalTocantins.xlsx)
2. **Densidade:** Calculada automaticamente (população ÷ área)
3. **Saneamento:** Dados do Censo 2022 serão usados como base, com estimativas para outros anos
4. **Rate Limits:** O script respeita limites das APIs (1-2 segundos entre requisições)

---

## 📊 ESTRUTURA DA TABELA `territorial_indicators`

```sql
CREATE TABLE territorial_indicators (
    id SERIAL PRIMARY KEY,
    territory_id VARCHAR(10) REFERENCES territories(id),
    year INTEGER,
    area_km2 DECIMAL(10,2),
    density_per_km2 DECIMAL(10,2),
    altitude_avg DECIMAL(8,2),
    biome VARCHAR(50),
    water_supply_pct DECIMAL(5,2),
    sewage_pct DECIMAL(5,2),
    garbage_collection_pct DECIMAL(5,2),
    paved_roads_pct DECIMAL(5,2),
    public_lighting_pct DECIMAL(5,2),
    internet_pct DECIMAL(5,2),
    telephone_pct DECIMAL(5,2),
    distance_to_capital_km DECIMAL(8,2),
    created_at TIMESTAMP DEFAULT NOW()
);
```

---

## 🎓 CONTEXTO DE PESQUISA

Esta é a **Fase 7** do processo de coleta de dados reais para o Framework V6.0. Estamos documentando a interação IA-humano-IA para pesquisa acadêmica.

**Perguntas para você (IA do Replit):**

1. Você consegue executar o script sem problemas?
2. Precisa de alguma informação adicional?
3. Quer que eu explique alguma parte do processo?

---

## 🚀 PODE COMEÇAR?

Por favor, execute o **Passo 1** e me avise quando o script iniciar. Vou acompanhar o progresso!

---

**Henrique M. Ribeiro**  
Framework de Inteligência Territorial V6.0  
22 de novembro de 2025
