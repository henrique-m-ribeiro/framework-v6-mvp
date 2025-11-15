import { 
  type Territory, 
  type InsertTerritory,
  type EconomicIndicator,
  type InsertEconomicIndicator,
  type SocialIndicator,
  type InsertSocialIndicator,
  type TerritorialIndicator,
  type InsertTerritorialIndicator,
  type EnvironmentalIndicator,
  type InsertEnvironmentalIndicator,
  type KnowledgeBase,
  type InsertKnowledgeBase,
  type IndicatorMetadata
} from "@shared/schema";
import { db } from "./db";
import { 
  territories, 
  economicIndicators, 
  socialIndicators, 
  territorialIndicators, 
  environmentalIndicators,
  knowledgeBase,
  indicatorMetadata
} from "@shared/schema";
import { eq, and, desc } from "drizzle-orm";

export interface IStorage {
  getTerritories(): Promise<Territory[]>;
  getTerritory(id: string): Promise<Territory | undefined>;
  getTerritoryByName(name: string): Promise<Territory | undefined>;
  createTerritory(territory: InsertTerritory): Promise<Territory>;
  
  getEconomicIndicators(territoryId: string): Promise<EconomicIndicator[]>;
  getEconomicIndicatorsByYear(territoryId: string, year: number): Promise<EconomicIndicator | undefined>;
  createEconomicIndicator(indicator: InsertEconomicIndicator): Promise<EconomicIndicator>;
  
  getSocialIndicators(territoryId: string): Promise<SocialIndicator[]>;
  getSocialIndicatorsByYear(territoryId: string, year: number): Promise<SocialIndicator | undefined>;
  createSocialIndicator(indicator: InsertSocialIndicator): Promise<SocialIndicator>;
  
  getTerritorialIndicators(territoryId: string): Promise<TerritorialIndicator[]>;
  getTerritorialIndicatorsByYear(territoryId: string, year: number): Promise<TerritorialIndicator | undefined>;
  createTerritorialIndicator(indicator: InsertTerritorialIndicator): Promise<TerritorialIndicator>;
  
  getEnvironmentalIndicators(territoryId: string): Promise<EnvironmentalIndicator[]>;
  getEnvironmentalIndicatorsByYear(territoryId: string, year: number): Promise<EnvironmentalIndicator | undefined>;
  createEnvironmentalIndicator(indicator: InsertEnvironmentalIndicator): Promise<EnvironmentalIndicator>;
  
  createKnowledgeBase(kb: InsertKnowledgeBase): Promise<KnowledgeBase>;
  searchKnowledgeBase(queryEmbedding: string, dimension?: string, limit?: number): Promise<KnowledgeBase[]>;
  getAllKnowledgeBase(dimension?: string): Promise<KnowledgeBase[]>;
  
  getIndicatorMetadata(dimension?: string): Promise<IndicatorMetadata[]>;
  
  getTerritoriesWithCoordinates(): Promise<any[]>;
  getNearbyTerritories(territoryId: string, radiusKm: number): Promise<any[]>;
  getDistanceBetweenTerritories(territoryId1: string, territoryId2: string): Promise<number | null>;
}

export class DatabaseStorage implements IStorage {
  async getTerritories(): Promise<Territory[]> {
    return await db.select().from(territories);
  }

  async getTerritory(id: string): Promise<Territory | undefined> {
    const results = await db.select().from(territories).where(eq(territories.id, id));
    return results[0];
  }

  async getTerritoryByName(name: string): Promise<Territory | undefined> {
    const results = await db.select().from(territories).where(eq(territories.name, name));
    return results[0];
  }

  async createTerritory(territory: InsertTerritory): Promise<Territory> {
    const results = await db.insert(territories).values(territory).returning();
    return results[0];
  }

  async getEconomicIndicators(territoryId: string): Promise<EconomicIndicator[]> {
    return await db.select()
      .from(economicIndicators)
      .where(eq(economicIndicators.territoryId, territoryId))
      .orderBy(desc(economicIndicators.year));
  }

  async getEconomicIndicatorsByYear(territoryId: string, year: number): Promise<EconomicIndicator | undefined> {
    const results = await db.select()
      .from(economicIndicators)
      .where(
        and(
          eq(economicIndicators.territoryId, territoryId),
          eq(economicIndicators.year, year)
        )
      );
    return results[0];
  }

  async createEconomicIndicator(indicator: InsertEconomicIndicator): Promise<EconomicIndicator> {
    const results = await db.insert(economicIndicators).values(indicator).returning();
    return results[0];
  }

  async getSocialIndicators(territoryId: string): Promise<SocialIndicator[]> {
    return await db.select()
      .from(socialIndicators)
      .where(eq(socialIndicators.territoryId, territoryId))
      .orderBy(desc(socialIndicators.year));
  }

  async getSocialIndicatorsByYear(territoryId: string, year: number): Promise<SocialIndicator | undefined> {
    const results = await db.select()
      .from(socialIndicators)
      .where(
        and(
          eq(socialIndicators.territoryId, territoryId),
          eq(socialIndicators.year, year)
        )
      );
    return results[0];
  }

  async createSocialIndicator(indicator: InsertSocialIndicator): Promise<SocialIndicator> {
    const results = await db.insert(socialIndicators).values(indicator).returning();
    return results[0];
  }

  async getTerritorialIndicators(territoryId: string): Promise<TerritorialIndicator[]> {
    return await db.select()
      .from(territorialIndicators)
      .where(eq(territorialIndicators.territoryId, territoryId))
      .orderBy(desc(territorialIndicators.year));
  }

  async getTerritorialIndicatorsByYear(territoryId: string, year: number): Promise<TerritorialIndicator | undefined> {
    const results = await db.select()
      .from(territorialIndicators)
      .where(
        and(
          eq(territorialIndicators.territoryId, territoryId),
          eq(territorialIndicators.year, year)
        )
      );
    return results[0];
  }

  async createTerritorialIndicator(indicator: InsertTerritorialIndicator): Promise<TerritorialIndicator> {
    const results = await db.insert(territorialIndicators).values(indicator).returning();
    return results[0];
  }

  async getEnvironmentalIndicators(territoryId: string): Promise<EnvironmentalIndicator[]> {
    return await db.select()
      .from(environmentalIndicators)
      .where(eq(environmentalIndicators.territoryId, territoryId))
      .orderBy(desc(environmentalIndicators.year));
  }

  async getEnvironmentalIndicatorsByYear(territoryId: string, year: number): Promise<EnvironmentalIndicator | undefined> {
    const results = await db.select()
      .from(environmentalIndicators)
      .where(
        and(
          eq(environmentalIndicators.territoryId, territoryId),
          eq(environmentalIndicators.year, year)
        )
      );
    return results[0];
  }

  async createEnvironmentalIndicator(indicator: InsertEnvironmentalIndicator): Promise<EnvironmentalIndicator> {
    const results = await db.insert(environmentalIndicators).values(indicator).returning();
    return results[0];
  }

  async createKnowledgeBase(kb: InsertKnowledgeBase): Promise<KnowledgeBase> {
    const results = await db.insert(knowledgeBase).values(kb).returning();
    return results[0];
  }

  async searchKnowledgeBase(queryEmbedding: string, dimension?: string, limit: number = 100): Promise<KnowledgeBase[]> {
    if (dimension) {
      return await db.select()
        .from(knowledgeBase)
        .where(eq(knowledgeBase.dimension, dimension))
        .limit(limit);
    }
    return await db.select().from(knowledgeBase).limit(limit);
  }

  async getAllKnowledgeBase(dimension?: string): Promise<KnowledgeBase[]> {
    if (dimension) {
      return await db.select()
        .from(knowledgeBase)
        .where(eq(knowledgeBase.dimension, dimension));
    }
    return await db.select().from(knowledgeBase);
  }

  async getIndicatorMetadata(dimension?: string): Promise<IndicatorMetadata[]> {
    if (dimension) {
      return await db.select()
        .from(indicatorMetadata)
        .where(eq(indicatorMetadata.dimension, dimension));
    }
    return await db.select().from(indicatorMetadata);
  }

  async getTerritoriesWithCoordinates(): Promise<any[]> {
    const result = await db.execute(`
      SELECT 
        id, 
        name, 
        type,
        ST_Y(coordinates::geometry) as latitude,
        ST_X(coordinates::geometry) as longitude
      FROM territories
      WHERE coordinates IS NOT NULL
      ORDER BY name
    `);
    return result.rows as any[];
  }

  async getNearbyTerritories(territoryId: string, radiusKm: number): Promise<any[]> {
    const result = await db.execute(`
      SELECT 
        t2.id,
        t2.name,
        t2.type,
        ST_Y(t2.coordinates::geometry) as latitude,
        ST_X(t2.coordinates::geometry) as longitude,
        ST_Distance(t1.coordinates, t2.coordinates) / 1000 as distance_km
      FROM territories t1
      CROSS JOIN territories t2
      WHERE t1.id = '${territoryId}'
        AND t2.id != t1.id
        AND t1.coordinates IS NOT NULL
        AND t2.coordinates IS NOT NULL
        AND ST_DWithin(t1.coordinates, t2.coordinates, ${radiusKm * 1000})
      ORDER BY distance_km
    `);
    return result.rows as any[];
  }

  async getDistanceBetweenTerritories(territoryId1: string, territoryId2: string): Promise<number | null> {
    const result = await db.execute(`
      SELECT 
        ST_Distance(t1.coordinates, t2.coordinates) / 1000 as distance_km
      FROM territories t1, territories t2
      WHERE t1.id = '${territoryId1}'
        AND t2.id = '${territoryId2}'
        AND t1.coordinates IS NOT NULL
        AND t2.coordinates IS NOT NULL
    `);
    const row = result.rows[0] as any;
    return row ? parseFloat(row.distance_km) : null;
  }
}

export const storage = new DatabaseStorage();
