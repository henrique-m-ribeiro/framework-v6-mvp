# Instruções: Popular indicator_metadata no Replit

## 🎯 Objetivo

Executar o script `POPULATE_METADATA_REPLIT.py` no Replit para popular a tabela `indicator_metadata` com 12 metadados de indicadores.

---

## 📋 Passo a Passo

### **1. Sincronizar com GitHub**

No Shell do Replit:

```bash
git pull origin main
```

### **2. Instalar Dependência**

```bash
pip install psycopg2-binary
```

### **3. Executar o Script**

```bash
python3 POPULATE_METADATA_REPLIT.py
```

---

## ✅ Resultado Esperado

Você verá algo como:

```
======================================================================
POPULAR TABELA indicator_metadata
======================================================================

📊 Total de metadados: 12
🗄️  Banco: ep-noisy-math-aeyq5dvn.us-east-2.aws.neon.tech
✓ Conexão estabelecida

Inserindo metadados...

  ✓ gdp
  ✓ gdp_per_capita
  ✓ employment_rate
  ✓ revenue
  ✓ idhm
  ✓ population
  ✓ literacy_rate
  ✓ income_per_capita
  ✓ area_km2
  ✓ density_per_km2
  ✓ deforestation_km2
  ✓ fire_spots

======================================================================
CONCLUÍDO!
======================================================================

✓ Inseridos com sucesso: 12/12
✓ Total na tabela: 12

🎉 Metadados prontos para uso no dashboard!
======================================================================
```

---

## 🔍 Verificar no Banco

Para confirmar que os dados foram inseridos:

```bash
psql $DATABASE_URL -c "SELECT indicator_code, name FROM indicator_metadata;"
```

---

## 📊 Metadados Incluídos

| Código | Nome | Dimensão |
|--------|------|----------|
| `gdp` | PIB Municipal | Econômica |
| `gdp_per_capita` | PIB per capita | Econômica |
| `employment_rate` | Taxa de Ocupação Formal | Econômica |
| `revenue` | Receita Total | Econômica |
| `idhm` | IDH-M | Social |
| `population` | População Residente | Social |
| `literacy_rate` | Taxa de Alfabetização | Social |
| `income_per_capita` | Renda per capita | Social |
| `area_km2` | Área Territorial | Territorial |
| `density_per_km2` | Densidade Demográfica | Territorial |
| `deforestation_km2` | Desmatamento Anual | Ambiental |
| `fire_spots` | Focos de Calor | Ambiental |

---

## 🚀 Próximos Passos

Após popular os metadados:

1. **Testar no dashboard** - Verificar se os tooltips aparecem
2. **Adicionar mais indicadores** - Editar o script e adicionar novos metadados
3. **Popular knowledge_base** - Executar script de geração de análises

---

**Framework de Inteligência Territorial V6.0**  
Henrique M. Ribeiro
