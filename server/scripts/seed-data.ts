import { db } from "../db";
import { 
  territories, 
  economicIndicators, 
  socialIndicators, 
  territorialIndicators, 
  environmentalIndicators 
} from "@shared/schema";
import { indexTerritoryData } from "../services/rag";

const tocantinsMunicipalities = [
  "Palmas", "Araguaína", "Gurupi", "Porto Nacional", "Paraíso do Tocantins",
  "Araguatins", "Colinas do Tocantins", "Guaraí", "Formoso do Araguaia",
  "Miracema do Tocantins", "Tocantinópolis", "Dianópolis", "Pedro Afonso",
  "Araguaçu", "Augustinópolis", "Xambioá", "Wanderlândia", "Taguatinga",
  "Nova Olinda", "Arraias"
];

async function seedDatabase() {
  console.log("Starting database seeding...");

  const stateTerritory = await db.insert(territories).values({
    name: "Tocantins",
    type: "estado",
    parentId: null,
    area: 277423.0,
    metadata: { 
      capital: "Palmas",
      regiao: "Norte",
      fundacao: "1988-10-05"
    }
  }).returning();

  console.log(`Created state territory: ${stateTerritory[0].name}`);

  const municipalityTerritories = [];
  for (const municipalityName of tocantinsMunicipalities) {
    const area = 1000 + Math.random() * 4000;
    const municipality = await db.insert(territories).values({
      name: municipalityName,
      type: "municipio",
      parentId: stateTerritory[0].id,
      area,
      metadata: { estado: "Tocantins" }
    }).returning();

    municipalityTerritories.push(municipality[0]);
    console.log(`Created municipality: ${municipalityName}`);
  }

  const currentYear = 2023;
  const yearsToGenerate = 5;

  for (const territory of [stateTerritory[0], ...municipalityTerritories]) {
    const isState = territory.type === "estado";
    const basePop = isState ? 1600000 : 50000 + Math.random() * 250000;

    for (let i = 0; i < yearsToGenerate; i++) {
      const year = currentYear - i;
      const growth = 1 + (0.015 * i);
      
      const economicData = {
        territoryId: territory.id,
        year,
        gdp: isState ? 45.2 - (i * 0.6) : (2.0 - i * 0.15) + Math.random() * 3,
        gdpPerCapita: 28134 - (i * 800) + Math.random() * 2000,
        employmentRate: 65.4 - (i * 0.5) + Math.random() * 3,
        revenue: isState ? 3245 - (i * 80) : 150 - (i * 10) + Math.random() * 50,
        sectorDistribution: {
          agropecuaria: 25 + Math.random() * 10,
          industria: 18 + Math.random() * 8,
          servicos: 50 + Math.random() * 12
        }
      };

      await db.insert(economicIndicators).values(economicData);

      const socialData = {
        territoryId: territory.id,
        year,
        idhm: 0.743 - (i * 0.008) + Math.random() * 0.02,
        population: Math.floor(basePop / growth),
        literacyRate: 89.2 - (i * 0.4) + Math.random() * 2,
        incomePerCapita: 1245 - (i * 30) + Math.random() * 80,
        educationMetrics: {
          ideb: 4.8 + Math.random() * 1.5,
          matriculas: Math.floor(basePop * 0.18)
        },
        healthMetrics: {
          leitos: Math.floor(basePop * 0.002),
          mortalidadeInfantil: 12 + Math.random() * 5
        }
      };

      await db.insert(socialIndicators).values(socialData);

      const territorialData = {
        territoryId: territory.id,
        year,
        urbanizedArea: (territory.area || 1000) * (0.005 + Math.random() * 0.015),
        density: basePop / (territory.area || 1000) / growth,
        sanitationCoverage: 62.4 - (i * 1.2) + Math.random() * 5,
        landUse: {
          urbano: 2 + Math.random() * 3,
          agropecuaria: 35 + Math.random() * 15,
          preservacao: 55 + Math.random() * 10
        }
      };

      await db.insert(territorialIndicators).values(territorialData);

      const environmentalData = {
        territoryId: territory.id,
        year,
        vegetationCoverage: 87.3 + (i * 0.8) - Math.random() * 2,
        deforestedArea: 35212 - (i * 2500) + Math.random() * 1000,
        waterQuality: 68 + (i * 1.5) - Math.random() * 3,
        co2Emissions: 12450000 - (i * 300000) + Math.random() * 200000
      };

      await db.insert(environmentalIndicators).values(environmentalData);
    }

    console.log(`Generated indicators for ${territory.name}`);
  }

  console.log("Generating embeddings for RAG system...");
  
  const economicContent = `${stateTerritory[0].name} apresenta PIB de R$ 45,2 bilhões com crescimento de 5,2% anual, impulsionado pelos setores de agropecuária (28%), serviços (52%) e indústria (20%). PIB per capita de R$ 28.134 está acima da média regional.`;
  await indexTerritoryData(stateTerritory[0].id, "econômica", economicContent, { type: "summary", year: 2023 });

  const socialContent = `O IDH-M do ${stateTerritory[0].name} é 0,743 (alto desenvolvimento humano), com população de 1.607.363 habitantes. Taxa de alfabetização de 89,2% e renda per capita de R$ 1.245.`;
  await indexTerritoryData(stateTerritory[0].id, "social", socialContent, { type: "summary", year: 2023 });

  const territorialContent = `${stateTerritory[0].name} possui área de 277.423 km², com densidade demográfica de 5,8 hab/km². Cobertura de saneamento básico em 62,4% dos domicílios.`;
  await indexTerritoryData(stateTerritory[0].id, "territorial", territorialContent, { type: "summary", year: 2023 });

  const environmentalContent = `Cobertura vegetal de 87,3% do território, com área desmatada de 35.212 km². Qualidade da água (IQA) em 68 pontos. Emissões de CO₂ em 12,45 milhões de toneladas anuais.`;
  await indexTerritoryData(stateTerritory[0].id, "ambiental", environmentalContent, { type: "summary", year: 2023 });

  console.log("Database seeding completed successfully!");
}

seedDatabase().catch((error) => {
  console.error("Error seeding database:", error);
  process.exit(1);
});
