# Prompt para IA do Replit: Coleta da Dimensão Social

## 🎯 CONTEXTO

Acabamos de concluir a coleta da **Dimensão Econômica** com sucesso! Agora vamos prosseguir para a **Dimensão Social**.

---

## 📊 PROGRESSO ATUAL

✅ **Concluído:**
- Fase 1: Backup do banco de dados
- Fase 2: Limpeza das tabelas
- Fase 3: Coleta de 140 territórios com coordenadas
- Fase 4: Inserção de territórios no banco
- Fase 5: Coleta de indicadores econômicos (SICONFI)

🎯 **Próximo:**
- Fase 6: Coleta de indicadores sociais (IBGE + INEP)

---

## 📋 TAREFA

Coletar dados da **Dimensão Social** para os 140 territórios do Tocantins (2019-2023).

### **Dados a Coletar:**

1. **População e Demografia (IBGE)**
   - População total
   - População urbana/rural
   - Densidade demográfica

2. **Educação (INEP)**
   - IDEB (Índice de Desenvolvimento da Educação Básica)
   - Estimativas para MVP

3. **Saúde (IBGE Cidades)**
   - Indicadores básicos de saúde

---

## 🔧 SCRIPT A EXECUTAR

```bash
cd /scripts/data_collection
python3 03_collect_social_indicators.py
```

**Tempo estimado:** 15-20 minutos

---

## 📝 APÓS A EXECUÇÃO

```bash
psql $DATABASE_URL -f insert_social_indicators.sql
```

---

**Pode começar?**
