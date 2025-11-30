# Necessidade de Acesso aos Microdados da RAIS

**Data:** 29 de novembro de 2025  
**Projeto:** Framework de Superinteligência Territorial V6.0  
**Autor:** Manus AI

---

## 📋 Contexto

Durante a implementação da coleta de dados para os novos indicadores econômicos (Sessão #7), identificamos a necessidade de acesso aos **microdados da RAIS (Relação Anual de Informações Sociais)** para obter dados precisos de **Massa Salarial Total** por município.

## 🎯 Objetivo

Obter acesso aos microdados da RAIS para coletar dados municipais de:
- **Massa Salarial Total** (remuneração dos trabalhadores formais)
- **Número de vínculos empregatícios**
- **Distribuição setorial do emprego**
- **Perfil dos trabalhadores** (idade, escolaridade, gênero)

Esses dados são fundamentais para análises econômicas territoriais mais precisas e para o funcionamento otimizado do **Agente ECON**.

## 🔍 Situação Atual

### Fonte de Dados Disponível

- **Portal:** Ministério do Trabalho e Emprego - PDET (Programa de Disseminação das Estatísticas do Trabalho)
- **URL:** https://www.gov.br/trabalho-e-emprego/pt-br/assuntos/estatisticas-trabalho/microdados-rais-e-caged
- **Formato:** Arquivos .txt via FTP (ftp://ftp.mtps.gov.br/pdet/microdados/)
- **Acesso:** Público, mas requer download e processamento local

### Limitações Atuais

1. **Sem API REST:** Não há API pública para acesso programático direto aos dados
2. **Arquivos Grandes:** Os microdados são arquivos .txt muito grandes (vários GB por ano)
3. **Processamento Local:** Requer infraestrutura para download, extração e processamento
4. **Protocolo FTP:** Muitos navegadores modernos não suportam mais FTP nativamente

### Solução Temporária Implementada

Por ora, estamos usando dados do **IBGE SIDRA** (Pesquisa Nacional por Amostra de Domicílios Contínua - PNAD Contínua) como **proxy**:
- **Indicador:** Rendimento médio mensal do trabalho principal
- **Granularidade:** Estadual (Tocantins)
- **Limitação:** Não fornece dados municipais específicos

## 📝 Ações Necessárias

### Curto Prazo (1-2 semanas)

1. **Configurar Acesso FTP:**
   - Instalar cliente FTP (FileZilla ou similar)
   - Testar acesso ao servidor: `ftp://ftp.mtps.gov.br/pdet/microdados/`
   - Documentar estrutura de diretórios e arquivos disponíveis

2. **Desenvolver Pipeline de Processamento:**
   - Script para download automatizado dos arquivos da RAIS
   - Script para extração e parsing dos dados (formato .txt com delimitador ";")
   - Script para agregação dos dados por município
   - Script para cálculo da massa salarial total

3. **Implementar Armazenamento:**
   - Criar tabela intermediária no banco de dados para armazenar dados brutos da RAIS
   - Implementar processo de ETL (Extract, Transform, Load)
   - Atualizar tabela `economic_indicators` com dados processados

### Médio Prazo (1-2 meses)

4. **Explorar Acesso Online ao PDET:**
   - Investigar ferramenta de "Acesso Online" mencionada no portal do governo
   - URL: https://www.gov.br/pt-br/servicos/solicitar-consulta-as-estatisticas-da-rais-e-do-caged
   - Avaliar se permite consultas programáticas ou apenas interface web

5. **Considerar Fontes Alternativas:**
   - **Base dos Dados:** https://basedosdados.org/dataset/3e7c4d58-96ba-448e-b053-d385a829ef00
   - Plataforma que disponibiliza dados da RAIS em formato SQL/Python/R
   - Verificar se tem dados atualizados e completos para o Tocantins

### Longo Prazo (3-6 meses)

6. **Automatizar Coleta Periódica:**
   - Implementar job agendado para download mensal/anual dos novos dados da RAIS
   - Integrar com sistema de auditoria para rastrear atualizações
   - Notificar equipe quando novos dados estiverem disponíveis

7. **Expandir Análises:**
   - Usar dados detalhados da RAIS para análises setoriais
   - Cruzar com dados de empresas ativas para calcular produtividade
   - Alimentar modelos de IA do Agente ECON com dados históricos

## 🛠️ Recursos Necessários

### Infraestrutura

- **Armazenamento:** ~50 GB para armazenar microdados de 5 anos (2018-2022)
- **Processamento:** Servidor com pelo menos 8 GB RAM para processar arquivos grandes
- **Banda:** Conexão estável para download de arquivos de vários GB

### Ferramentas

- **Cliente FTP:** FileZilla, WinSCP ou similar
- **Linguagem:** Python (pandas, dask para processamento de grandes volumes)
- **Banco de Dados:** PostgreSQL (já disponível)

### Tempo Estimado

- **Configuração inicial:** 2-3 dias
- **Desenvolvimento de scripts:** 1 semana
- **Testes e validação:** 3-5 dias
- **Total:** ~2 semanas de trabalho dedicado

## 📊 Benefícios Esperados

1. **Precisão:** Dados municipais reais em vez de proxies estaduais
2. **Granularidade:** Análises por setor econômico, faixa salarial, perfil do trabalhador
3. **Histórico:** Séries temporais de 2006 até o presente (RAIS disponibiliza desde 2006)
4. **Confiabilidade:** Dados oficiais e auditados do Ministério do Trabalho
5. **Análises Avançadas:** Possibilita análises de dinâmica do mercado de trabalho, mobilidade setorial, etc.

## 🔗 Referências

- [Portal de Microdados RAIS e CAGED](https://www.gov.br/trabalho-e-emprego/pt-br/assuntos/estatisticas-trabalho/microdados-rais-e-caged)
- [Solicitar Consulta às Estatísticas da RAIS e do CAGED](https://www.gov.br/pt-br/servicos/solicitar-consulta-as-estatisticas-da-rais-e-do-caged)
- [Base dos Dados - RAIS](https://basedosdados.org/dataset/3e7c4d58-96ba-448e-b053-d385a829ef00)
- [Análise dos dados da RAIS usando R](http://cemin.wikidot.com/raisr)

---

## 📌 Status

- **Prioridade:** Alta
- **Status:** Pendente
- **Responsável:** A definir
- **Prazo sugerido:** 2 semanas após aprovação

---

**Nota:** Este documento deve ser revisado e atualizado conforme o progresso na obtenção e processamento dos dados da RAIS.
