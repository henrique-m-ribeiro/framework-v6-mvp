# Guia de Execução Manual - Dimensões Territorial e Ambiental

## 🎯 Objetivo

Este guia fornece o **passo-a-passo completo** para você executar diretamente os scripts de coleta das dimensões **Territorial** e **Ambiental**, sem intermediação de outras IAs.

---

## 📋 Pré-requisitos

Antes de começar, certifique-se de que:

✅ Você está no ambiente Replit do projeto  
✅ O banco de dados PostgreSQL está ativo  
✅ As dimensões Econômica e Social já foram carregadas  
✅ Python 3 está disponível (`python3 --version`)  
✅ Biblioteca `requests` está instalada (`pip3 install requests`)

---

## 🗂️ Estrutura de Arquivos

Os scripts estão localizados em:

```
/scripts/data_collection/
├── 01_collect_territories_with_coordinates.py (✅ Executado)
├── 02_collect_economic_indicators.py (✅ Executado)
├── 03_collect_social_indicators.py (✅ Executado)
├── 04_collect_territorial_indicators.py (🎯 Próximo)
├── 05_collect_environmental_indicators.py (🎯 Próximo)
└── insert_*.sql (Arquivos gerados)
```

---

## 📊 FASE 7: Dimensão Territorial

### **Passo 1: Navegar até o diretório**

```bash
cd /scripts/data_collection
```

### **Passo 2: Verificar arquivos necessários**

```bash
ls -lh insert_territories_with_coordinates.sql
ls -lh insert_territorial_indicators.sql 2>/dev/null || echo "Arquivo ainda não existe (será criado)"
```

**Importante:** O script precisa do arquivo `insert_territories_with_coordinates.sql` para ler a lista de territórios.

### **Passo 3: Executar o script de coleta**

```bash
python3 04_collect_territorial_indicators.py
```

**O que vai acontecer:**
- O script vai processar 140 territórios × 5 anos = 700 registros
- Vai consultar a API do IBGE para área territorial
- Vai calcular densidade demográfica
- Vai estimar dados de saneamento e infraestrutura
- Vai gerar o arquivo `insert_territorial_indicators.sql`

**Tempo estimado:** 15-20 minutos

**Acompanhamento:**
- O script mostra progresso no console: `[1/700] Território 1700301, Ano 2019`
- Um arquivo de log é criado: `collect_territorial_indicators.log`

### **Passo 4: Verificar o SQL gerado**

```bash
# Ver tamanho do arquivo
ls -lh insert_territorial_indicators.sql

# Ver primeiras linhas
head -50 insert_territorial_indicators.sql

# Contar número de INSERTs
grep -c "INSERT INTO" insert_territorial_indicators.sql
```

**Resultado esperado:** ~700 linhas de INSERT

### **Passo 5: Inserir dados no PostgreSQL**

```bash
psql $DATABASE_URL -f insert_territorial_indicators.sql
```

**Saída esperada:**
```
BEGIN
INSERT 0 1
INSERT 0 1
...
COMMIT
```

### **Passo 6: Verificar inserção**

```bash
psql $DATABASE_URL -c "SELECT COUNT(*) FROM territorial_indicators;"
psql $DATABASE_URL -c "SELECT year, COUNT(*) FROM territorial_indicators GROUP BY year ORDER BY year;"
```

**Resultado esperado:**
```
 count 
-------
   700

 year | count 
------+-------
 2019 |   140
 2020 |   140
 2021 |   140
 2022 |   140
 2023 |   140
```

### **Passo 7: Ver amostra dos dados**

```bash
psql $DATABASE_URL -c "SELECT territory_id, year, area_km2, density_per_km2, water_supply_pct, sewage_pct FROM territorial_indicators LIMIT 5;"
```

---

## 🌳 FASE 8: Dimensão Ambiental

### **Passo 1: Confirmar que está no diretório correto**

```bash
pwd
# Deve mostrar: /scripts/data_collection
```

### **Passo 2: Verificar dependências**

```bash
# O script precisa dos dados de área (da dimensão territorial)
ls -lh insert_territorial_indicators.sql
```

### **Passo 3: Executar o script de coleta**

```bash
python3 05_collect_environmental_indicators.py
```

**O que vai acontecer:**
- O script vai processar 140 territórios × 5 anos = 700 registros
- Vai estimar dados de desmatamento baseado em médias do Cerrado
- Vai estimar focos de queimadas baseado em histórico do Tocantins
- Vai calcular cobertura vegetal (MapBiomas)
- Vai estimar áreas protegidas e recursos hídricos
- Vai gerar o arquivo `insert_environmental_indicators.sql`

**Tempo estimado:** 20-25 minutos

**Acompanhamento:**
- O script mostra progresso: `[1/700] Palmas, Ano 2019`
- Um arquivo de log é criado: `collect_environmental_indicators.log`

### **Passo 4: Verificar o SQL gerado**

```bash
# Ver tamanho do arquivo
ls -lh insert_environmental_indicators.sql

# Ver primeiras linhas
head -50 insert_environmental_indicators.sql

# Contar número de INSERTs
grep -c "INSERT INTO" insert_environmental_indicators.sql
```

**Resultado esperado:** ~700 linhas de INSERT

### **Passo 5: Inserir dados no PostgreSQL**

```bash
psql $DATABASE_URL -f insert_environmental_indicators.sql
```

**Saída esperada:**
```
BEGIN
INSERT 0 1
INSERT 0 1
...
COMMIT
```

### **Passo 6: Verificar inserção**

```bash
psql $DATABASE_URL -c "SELECT COUNT(*) FROM environmental_indicators;"
psql $DATABASE_URL -c "SELECT year, COUNT(*) FROM environmental_indicators GROUP BY year ORDER BY year;"
```

**Resultado esperado:**
```
 count 
-------
   700

 year | count 
------+-------
 2019 |   140
 2020 |   140
 2021 |   140
 2022 |   140
 2023 |   140
```

### **Passo 7: Ver estatísticas ambientais**

```bash
# Estatísticas de desmatamento
psql $DATABASE_URL -c "SELECT year, ROUND(AVG(deforestation_km2), 2) as avg_deforestation, ROUND(AVG(deforestation_rate_pct), 2) as avg_rate FROM environmental_indicators GROUP BY year ORDER BY year;"

# Estatísticas de queimadas
psql $DATABASE_URL -c "SELECT year, SUM(fire_spots) as total_fire_spots, ROUND(SUM(burned_area_km2), 2) as total_burned_area FROM environmental_indicators GROUP BY year ORDER BY year;"
```

---

## ✅ Verificação Final - Todas as 4 Dimensões

Após concluir ambas as fases, execute esta verificação completa:

```bash
psql $DATABASE_URL << 'EOF'
-- Resumo geral de todas as dimensões
SELECT 'territories' as table_name, COUNT(*) as records FROM territories
UNION ALL
SELECT 'economic_indicators', COUNT(*) FROM economic_indicators
UNION ALL
SELECT 'social_indicators', COUNT(*) FROM social_indicators
UNION ALL
SELECT 'territorial_indicators', COUNT(*) FROM territorial_indicators
UNION ALL
SELECT 'environmental_indicators', COUNT(*) FROM environmental_indicators
ORDER BY table_name;
EOF
```

**Resultado esperado:**
```
        table_name         | records 
---------------------------+---------
 economic_indicators       |     700
 environmental_indicators  |     700
 social_indicators         |     700
 territorial_indicators    |     700
 territories               |     140
```

---

## 🐛 Solução de Problemas

### **Erro: "No such file or directory"**

```bash
# Verificar se está no diretório correto
pwd

# Listar arquivos disponíveis
ls -la
```

### **Erro: "requests module not found"**

```bash
pip3 install requests
```

### **Erro: "DATABASE_URL not set"**

```bash
# Verificar variável de ambiente
echo $DATABASE_URL

# Se vazio, definir manualmente (Replit geralmente define automaticamente)
export DATABASE_URL="postgresql://..."
```

### **Erro: "File already exists"**

```bash
# Remover arquivos SQL antigos se quiser reexecutar
rm insert_territorial_indicators.sql
rm insert_environmental_indicators.sql
```

### **Script travou ou está muito lento**

```bash
# Verificar se o script ainda está rodando
ps aux | grep python3

# Ver o log em tempo real
tail -f collect_territorial_indicators.log
# ou
tail -f collect_environmental_indicators.log

# Se necessário, interromper com Ctrl+C
```

### **Dados duplicados no banco**

```bash
# Verificar se há duplicatas
psql $DATABASE_URL -c "SELECT territory_id, year, COUNT(*) FROM territorial_indicators GROUP BY territory_id, year HAVING COUNT(*) > 1;"

# Se houver, limpar e reinserir
psql $DATABASE_URL -c "DELETE FROM territorial_indicators;"
psql $DATABASE_URL -f insert_territorial_indicators.sql
```

---

## 📊 Comandos Úteis de Consulta

### **Ver dados de um município específico**

```bash
# Palmas (capital)
psql $DATABASE_URL -c "SELECT * FROM territorial_indicators WHERE territory_id = '1721000' ORDER BY year;"
psql $DATABASE_URL -c "SELECT * FROM environmental_indicators WHERE territory_id = '1721000' ORDER BY year;"
```

### **Ver médias estaduais**

```bash
# Dimensão Territorial
psql $DATABASE_URL -c "SELECT year, ROUND(AVG(density_per_km2), 2) as avg_density, ROUND(AVG(water_supply_pct), 2) as avg_water FROM territorial_indicators GROUP BY year ORDER BY year;"

# Dimensão Ambiental
psql $DATABASE_URL -c "SELECT year, ROUND(AVG(native_vegetation_pct), 2) as avg_vegetation, ROUND(AVG(deforestation_rate_pct), 2) as avg_deforestation FROM environmental_indicators GROUP BY year ORDER BY year;"
```

### **Exportar dados para CSV**

```bash
# Dimensão Territorial
psql $DATABASE_URL -c "COPY (SELECT * FROM territorial_indicators ORDER BY territory_id, year) TO STDOUT WITH CSV HEADER" > territorial_data.csv

# Dimensão Ambiental
psql $DATABASE_URL -c "COPY (SELECT * FROM environmental_indicators ORDER BY territory_id, year) TO STDOUT WITH CSV HEADER" > environmental_data.csv
```

---

## 🎯 Checklist de Execução

### **Fase 7: Territorial**
- [ ] Navegar para `/scripts/data_collection`
- [ ] Executar `python3 04_collect_territorial_indicators.py`
- [ ] Aguardar conclusão (~15-20 min)
- [ ] Verificar arquivo `insert_territorial_indicators.sql`
- [ ] Executar `psql $DATABASE_URL -f insert_territorial_indicators.sql`
- [ ] Verificar 700 registros inseridos
- [ ] Conferir amostra dos dados

### **Fase 8: Ambiental**
- [ ] Confirmar que está em `/scripts/data_collection`
- [ ] Executar `python3 05_collect_environmental_indicators.py`
- [ ] Aguardar conclusão (~20-25 min)
- [ ] Verificar arquivo `insert_environmental_indicators.sql`
- [ ] Executar `psql $DATABASE_URL -f insert_environmental_indicators.sql`
- [ ] Verificar 700 registros inseridos
- [ ] Conferir estatísticas ambientais

### **Verificação Final**
- [ ] Executar query de resumo geral
- [ ] Confirmar 2.800 registros totais (700 × 4 dimensões)
- [ ] Testar consultas de exemplo
- [ ] Documentar qualquer problema encontrado

---

## 📞 Suporte

Se encontrar qualquer problema durante a execução:

1. **Verifique os logs:** `cat collect_*.log`
2. **Consulte a seção de Solução de Problemas** acima
3. **Documente o erro** (mensagem completa, comando executado)
4. **Reporte para análise** com contexto completo

---

## 🎉 Próximos Passos

Após concluir o carregamento das 4 dimensões:

1. **Testar os agentes especialistas** com dados reais
2. **Criar o Orquestrador (Meta-LLM)** para coordenar os 4 agentes
3. **Integrar com o dashboard** para consultas interativas
4. **Implementar o sistema RAG** na knowledge base
5. **Preparar apresentação** para o senador com dados reais

---

**Boa execução! 🚀**

---

**Henrique M. Ribeiro**  
Framework de Inteligência Territorial V6.0  
22 de novembro de 2025
