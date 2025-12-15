# Observações sobre a API SICONFI

**Data:** 30 de novembro de 2025  
**Contexto:** Tentativa de coleta de dados de Receita Tributária via API SICONFI

---

## Documentação da API RREO

A API RREO (Relatório Resumido de Execução Orçamentária) possui os seguintes parâmetros obrigatórios:

| Parâmetro | Tipo | Descrição | Obrigatório |
|:---|:---|:---|:---:|
| `an_exercicio` | Long (int64) | Exercício do relatório | ✅ |
| `nr_periodo` | Integer | Bimestre de referência do relatório dentro de um exercício | ✅ |
| `co_tipo_demonstrativo` | String | Tipo do Demonstrativo. RREO Simplificado aplica-se apenas aos municípios com menos de 50 mil habitantes que optaram pela publicação simplificada | ✅ |
| `no_anexo` | String | Os diversos demonstrativos do RREO são agrupados em anexos | ❌ (Opcional) |
| `co_esfera` | String | Filtro de esfera M = Municípios, E = Estados e DF, U = União e C = Consórcio | ✅ |
| `id_ente` | Integer | Código IBGE do Ente | ✅ |

**Valores possíveis para `co_tipo_demonstrativo`:**
- `RREO`
- `RREO Simplificado`

---

## Problema Identificado na Tentativa Anterior

Na tentativa anterior, a URL usada foi:
```
https://apidatalake.tesouro.gov.br/ords/siconfi/get/rreo?an_exercicio=2022&nr_periodo=6&co_tipo_demonstrativo=RRE&co_esfera=M&co_poder=E&id_ente=17
```

**Erros identificados:**
1. ❌ `co_tipo_demonstrativo=RRE` (valor inválido, deveria ser `RREO` ou `RREO Simplificado`)
2. ❌ `co_poder=E` (parâmetro inexistente na API RREO)
3. ❌ `id_ente=17` (código do estado do Tocantins, não de um município)

---

## Correção Necessária

Para coletar dados de **Receita Tributária Municipal**, a URL correta deve ser:

```
https://apidatalake.tesouro.gov.br/ords/siconfi/get/rreo?an_exercicio=2022&nr_periodo=6&co_tipo_demonstrativo=RREO&co_esfera=M&id_ente={CODIGO_IBGE_MUNICIPIO}
```

**Exemplo para Palmas (TO) - Código IBGE 1721000:**
```
https://apidatalake.tesouro.gov.br/ords/siconfi/get/rreo?an_exercicio=2022&nr_periodo=6&co_tipo_demonstrativo=RREO&co_esfera=M&id_ente=1721000
```

---

## Anexos Relevantes para Receita Tributária

Os dados de Receita Tributária estão tipicamente nos seguintes anexos do RREO:
- **RREO-Anexo 01:** Balanço Orçamentário
- **RREO-Anexo 02:** Demonstrativo da Execução das Despesas por Função/Subfunção
- **RREO-Anexo 03:** Demonstrativo da Receita Corrente Líquida

Para obter apenas os dados de Receita Tributária, seria ideal especificar o anexo correto no parâmetro `no_anexo`.

---

## Próximos Passos

1. Testar a URL corrigida com um município do Tocantins
2. Identificar o anexo específico que contém os dados de Receita Tributária
3. Adaptar o script de coleta com os parâmetros corretos
