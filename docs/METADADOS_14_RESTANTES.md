# Metadados dos 14 Indicadores Restantes

## 📊 Lista Completa

### **Dimensão Social (2 indicadores)**

| # | Código | Nome | Prioridade |
|---|--------|------|------------|
| 1 | `taxa_conclusao_fundamental` | Taxa de Conclusão Ensino Fundamental | MÉDIA |
| 2 | `taxa_conclusao_medio` | Taxa de Conclusão Ensino Médio | MÉDIA |

### **Dimensão Territorial (5 indicadores)**

| # | Código | Nome | Prioridade |
|---|--------|------|------------|
| 3 | `urbanized_area` | Área Urbanizada | MÉDIA |
| 4 | `land_use_agricultura` | Uso do Solo: Agricultura | MÉDIA |
| 5 | `land_use_pecuaria` | Uso do Solo: Pecuária | MÉDIA |
| 6 | `land_use_florestal` | Uso do Solo: Florestal | MÉDIA |
| 7 | `land_use_urbano` | Uso do Solo: Urbano | BAIXA |

### **Dimensão Ambiental (2 indicadores)**

| # | Código | Nome | Prioridade |
|---|--------|------|------------|
| 8 | `water_quality` | Qualidade da Água | MÉDIA |
| 9 | `co2_emissions` | Emissões de CO2 | MÉDIA |

### **Outros Campos (5 indicadores)**

| # | Código | Nome | Prioridade |
|---|--------|------|------------|
| 10 | `paved_roads_pct` | Vias Pavimentadas | MÉDIA |
| 11 | `street_lighting_pct` | Iluminação Pública | MÉDIA |
| 12 | `internet_access_pct` | Acesso à Internet | ALTA |
| 13 | `mobile_coverage_pct` | Cobertura de Telefonia Móvel | ALTA |
| 14 | `protected_areas_pct` | Áreas Protegidas | ALTA |

---

## 📝 Metadados Detalhados

### **1. taxa_conclusao_fundamental**
- **Nome:** Taxa de Conclusão do Ensino Fundamental
- **Descrição:** Percentual de alunos que concluem o ensino fundamental na idade esperada. Mede a eficiência do fluxo escolar.
- **Unidade:** %
- **Fonte:** INEP - Censo Escolar
- **Guia:** Acima de 80% é bom. Abaixo de 60% é crítico.

### **2. taxa_conclusao_medio**
- **Nome:** Taxa de Conclusão do Ensino Médio
- **Descrição:** Percentual de jovens que concluem o ensino médio na idade esperada. Indica o sucesso na retenção escolar.
- **Unidade:** %
- **Fonte:** INEP - Censo Escolar
- **Guia:** Acima de 70% é bom. Abaixo de 50% é crítico.

### **3. urbanized_area**
- **Nome:** Área Urbanizada
- **Descrição:** Percentual da área total do município que é considerada área urbana consolidada.
- **Unidade:** %
- **Fonte:** IBGE / MapBiomas
- **Guia:** Varia muito. Em cidades, pode ser >80%. Em áreas rurais, <10%.

### **4. land_use_agricultura**
- **Nome:** Uso do Solo: Agricultura
- **Descrição:** Percentual da área do município destinada à agricultura.
- **Unidade:** %
- **Fonte:** MapBiomas
- **Guia:** Importante para entender a vocação econômica e a pressão sobre o meio ambiente.

### **5. land_use_pecuaria**
- **Nome:** Uso do Solo: Pecuária
- **Descrição:** Percentual da área do município destinada à pastagem para pecuária.
- **Unidade:** %
- **Fonte:** MapBiomas
- **Guia:** Grandes áreas de pastagem podem indicar desmatamento histórico.

### **6. land_use_florestal**
- **Nome:** Uso do Solo: Florestal
- **Descrição:** Percentual da área do município com cobertura florestal (nativa ou plantada).
- **Unidade:** %
- **Fonte:** MapBiomas
- **Guia:** Essencial para análise ambiental e cumprimento do Código Florestal.

### **7. land_use_urbano**
- **Nome:** Uso do Solo: Urbano
- **Descrição:** Percentual da área do município com mancha urbana.
- **Unidade:** %
- **Fonte:** MapBiomas
- **Guia:** Similar a `urbanized_area`, mas com metodologia diferente.

### **8. water_quality**
- **Nome:** Índice de Qualidade da Água (IQA)
- **Descrição:** Indicador que avalia a qualidade dos corpos d'água do município, baseado em parâmetros físico-químicos e biológicos.
- **Unidade:** índice (0-100)
- **Fonte:** Agência Nacional de Águas (ANA) / Agências Estaduais
- **Guia:** >80: Ótima | 52-79: Boa | 37-51: Razoável | 20-36: Ruim | <19: Péssima.

### **9. co2_emissions**
- **Nome:** Emissões de CO2 (Dióxido de Carbono)
- **Descrição:** Total de emissões de gases de efeito estufa (GEE) em toneladas de CO2 equivalente. Inclui energia, indústria, agropecuária e desmatamento.
- **Unidade:** tCO2e
- **Fonte:** SEEG (Sistema de Estimativas de Emissões e Remoções de Gases de Efeito Estufa)
- **Guia:** Valores altos indicam grande contribuição para o aquecimento global. Comparar emissões per capita é mais justo.

### **10. paved_roads_pct**
- **Nome:** Percentual de Vias Pavimentadas
- **Descrição:** Percentual de vias públicas na área urbana que possuem pavimentação.
- **Unidade:** %
- **Fonte:** IBGE - Pesquisa de Informações Básicas Municipais (MUNIC)
- **Guia:** >90% é bom. <50% indica déficit de infraestrutura.

### **11. street_lighting_pct**
- **Nome:** Percentual de Domicílios com Iluminação Pública
- **Descrição:** Percentual de domicílios urbanos em ruas com iluminação pública.
- **Unidade:** %
- **Fonte:** IBGE - Censo Demográfico
- **Guia:** Ideal é 100%. Abaixo de 95% indica falhas na infraestrutura.

### **12. internet_access_pct**
- **Nome:** Percentual de Domicílios com Acesso à Internet
- **Descrição:** Percentual de domicílios particulares permanentes com acesso à internet (banda larga ou móvel).
- **Unidade:** %
- **Fonte:** IBGE - Censo Demográfico / PNAD Contínua
- **Guia:** >80% é bom. <50% indica exclusão digital.

### **13. mobile_coverage_pct**
- **Nome:** Cobertura de Telefonia Móvel
- **Descrição:** Percentual da área do município com cobertura de pelo menos uma operadora de telefonia móvel (2G, 3G, 4G ou 5G).
- **Unidade:** %
- **Fonte:** ANATEL
- **Guia:** >95% é bom. <70% indica áreas de sombra e exclusão.

### **14. protected_areas_pct**
- **Nome:** Percentual de Áreas Protegidas
- **Descrição:** Percentual da área do município que está dentro de Unidades de Conservação (UCs) ou Terras Indígenas (TIs).
- **Unidade:** %
- **Fonte:** Ministério do Meio Ambiente (MMA) / FUNAI
- **Guia:** Importante para conservação da biodiversidade. Não há um valor "bom" ou "ruim", depende da localização.
