# Prompt para IA do Replit: Coleta da Dimensão Ambiental

## 🎯 CONTEXTO

Excelente! Estamos na reta final da coleta de dados. Já concluímos as dimensões **Econômica**, **Social** e **Territorial**. Agora vamos finalizar com a **Dimensão Ambiental**.

---

## 📊 PROGRESSO ATUAL

✅ **Concluído:**
- Fase 1: Backup do banco de dados
- Fase 2: Limpeza das tabelas
- Fase 3: Coleta de 140 territórios com coordenadas
- Fase 4: Inserção de territórios no banco
- Fase 5: Coleta de indicadores econômicos (SICONFI)
- Fase 6: Coleta de indicadores sociais (IBGE + INEP)
- Fase 7: Coleta de indicadores territoriais (IBGE)

🎯 **Próximo:**
- Fase 8: Coleta de indicadores ambientais (INPE + IBGE)

---

## 📋 TAREFA

Coletar dados da **Dimensão Ambiental** para os 140 territórios do Tocantins (2019-2023).

### **Dados a Coletar:**

1. **Desmatamento (INPE - PRODES)**
   - Área desmatada anual (km²)
   - Taxa de desmatamento (% da área total)
   - Desmatamento acumulado

2. **Queimadas (INPE - BDQueimadas)**
   - Número de focos de calor detectados
   - Área queimada estimada (km²)
   - Meses de maior incidência

3. **Cobertura Vegetal (IBGE)**
   - % de área com vegetação nativa
   - % de área com pastagem
   - % de área com agricultura
   - % de área com reflorestamento

4. **Áreas Protegidas**
   - % do território em Unidades de Conservação
   - % do território em Terras Indígenas
   - % do território em Áreas de Preservação Permanente

5. **Recursos Hídricos (ANA)**
   - Número de corpos d'água
   - Qualidade da água (quando disponível)

---

## 🔧 SCRIPT A EXECUTAR

O script já foi criado e está em:
```
/scripts/data_collection/05_collect_environmental_indicators.py
```

### **O que o script faz:**

1. Lê a lista de 140 territórios
2. Para cada território e cada ano (2019-2023):
   - Consulta dados de desmatamento via API INPE/TerraBrasilis
   - Consulta focos de queimadas via BDQueimadas
   - Estima cobertura vegetal baseado em dados do MapBiomas
   - Calcula % de áreas protegidas
3. Gera arquivo `insert_environmental_indicators.sql`

### **Tempo estimado:** 20-25 minutos

---

## 📝 INSTRUÇÕES DE EXECUÇÃO

### **Passo 1: Executar o Script**

```bash
cd /scripts/data_collection
python3 05_collect_environmental_indicators.py
```

**Aguarde:** O script vai mostrar progresso no console.

---

### **Passo 2: Verificar o SQL Gerado**

Após a execução, verifique:

```bash
ls -lh insert_environmental_indicators.sql
head -50 insert_environmental_indicators.sql
```

---

### **Passo 3: Inserir no Banco de Dados**

```bash
psql $DATABASE_URL -f insert_environmental_indicators.sql
```

---

### **Passo 4: Verificar Inserção**

```sql
SELECT COUNT(*) FROM environmental_indicators;
SELECT year, COUNT(*) FROM environmental_indicators GROUP BY year ORDER BY year;
```

**Resultado esperado:** ~700 registros (140 territórios × 5 anos)

---

## ⚠️ PONTOS DE ATENÇÃO

1. **APIs do INPE:**
   - TerraBrasilis (PRODES): Dados de desmatamento
   - BDQueimadas: Focos de calor
   - Podem ter rate limits mais rigorosos (2-3 segundos entre requisições)

2. **Dados Anuais vs. Mensais:**
   - Desmatamento: Dados anuais (agosto a julho)
   - Queimadas: Dados mensais agregados por ano

3. **Estimativas:**
   - Alguns dados podem não estar disponíveis para todos os anos
   - Script usa interpolação linear quando necessário
   - Dados do Cerrado serão usados como baseline

4. **Coordenadas Geográficas:**
   - Script usa as coordenadas já coletadas para filtrar dados espaciais
   - Importante para consultas na API do INPE

---

## 📊 ESTRUTURA DA TABELA `environmental_indicators`

```sql
CREATE TABLE environmental_indicators (
    id SERIAL PRIMARY KEY,
    territory_id VARCHAR(10) REFERENCES territories(id),
    year INTEGER,
    deforestation_km2 DECIMAL(10,2),
    deforestation_rate_pct DECIMAL(5,2),
    accumulated_deforestation_km2 DECIMAL(10,2),
    fire_spots INTEGER,
    burned_area_km2 DECIMAL(10,2),
    native_vegetation_pct DECIMAL(5,2),
    pasture_pct DECIMAL(5,2),
    agriculture_pct DECIMAL(5,2),
    reforestation_pct DECIMAL(5,2),
    conservation_units_pct DECIMAL(5,2),
    indigenous_lands_pct DECIMAL(5,2),
    permanent_preservation_pct DECIMAL(5,2),
    water_bodies_count INTEGER,
    water_quality_index DECIMAL(5,2),
    created_at TIMESTAMP DEFAULT NOW()
);
```

---

## 🌳 CONTEXTO AMBIENTAL DO TOCANTINS

O Tocantins está no **bioma Cerrado**, considerado a savana mais biodiversa do mundo, mas também um dos mais ameaçados:

- **Desmatamento:** Principalmente para expansão agropecuária
- **Queimadas:** Concentradas no período seco (junho a outubro)
- **Áreas Protegidas:** Parque Nacional do Araguaia, Ilha do Bananal, terras indígenas
- **Recursos Hídricos:** Bacias do Tocantins e Araguaia

Esses dados são **cruciais** para políticas públicas de conservação e desenvolvimento sustentável.

---

## 🎓 CONTEXTO DE PESQUISA

Esta é a **Fase 8 (FINAL)** do processo de coleta de dados reais para o Framework V6.0. Estamos documentando a interação IA-humano-IA para pesquisa acadêmica.

**Perguntas para você (IA do Replit):**

1. Você consegue executar o script sem problemas?
2. Precisa de alguma informação adicional sobre as APIs do INPE?
3. Quer que eu explique alguma parte do processo?

---

## 🚀 PODE COMEÇAR?

Por favor, execute o **Passo 1** e me avise quando o script iniciar. Vou acompanhar o progresso!

Após concluir esta fase, teremos **TODOS os dados reais** das 4 dimensões prontos para alimentar os agentes especialistas! 🎉

---

**Henrique M. Ribeiro**  
Framework de Inteligência Territorial V6.0  
22 de novembro de 2025
