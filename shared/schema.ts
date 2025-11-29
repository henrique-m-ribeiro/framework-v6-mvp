import { sql } from "drizzle-orm";
import { pgTable, text, varchar, integer, real, json, jsonb, numeric } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod";

export const territories = pgTable("territories", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  name: text("name").notNull(),
  type: text("type").notNull(),
  parentId: varchar("parent_id"),
  area: real("area"),
  metadata: json("metadata"),
});

export const economicIndicators = pgTable("economic_indicators", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  territoryId: varchar("territory_id").notNull().references(() => territories.id),
  year: integer("year").notNull(),
  // Campos legados (mantidos para compatibilidade temporária)
  gdp: real("gdp"),
  gdpPerCapita: real("gdp_per_capita"),
  employmentRate: real("employment_rate"),
  revenue: real("revenue"),
  sectorDistribution: json("sector_distribution"),
  // Novos campos (Modelo Conceitual v4.0)
  gdpCurrentPrices: numeric("gdp_current_prices", { precision: 20, scale: 2 }),
  totalWageMass: numeric("total_wage_mass", { precision: 20, scale: 2 }),
  activeCompaniesCount: integer("active_companies_count"),
  municipalTaxRevenue: numeric("municipal_tax_revenue", { precision: 20, scale: 2 }),
  source: varchar("source", { length: 255 }),
  metadata: jsonb("metadata"),
});

export const socialIndicators = pgTable("social_indicators", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  territoryId: varchar("territory_id").notNull().references(() => territories.id),
  year: integer("year").notNull(),
  idhm: real("idhm"),
  population: integer("population"),
  literacyRate: real("literacy_rate"),
  incomePerCapita: real("income_per_capita"),
  educationMetrics: json("education_metrics"),
  healthMetrics: json("health_metrics"),
});

export const territorialIndicators = pgTable("territorial_indicators", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  territoryId: varchar("territory_id").notNull().references(() => territories.id),
  year: integer("year").notNull(),
  urbanizedArea: real("urbanized_area"),
  density: real("density"),
  sanitationCoverage: real("sanitation_coverage"),
  landUse: json("land_use"),
});

export const environmentalIndicators = pgTable("environmental_indicators", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  territoryId: varchar("territory_id").notNull().references(() => territories.id),
  year: integer("year").notNull(),
  vegetationCoverage: real("vegetation_coverage"),
  deforestedArea: real("deforested_area"),
  waterQuality: real("water_quality"),
  co2Emissions: real("co2_emissions"),
});

export const knowledgeBase = pgTable("knowledge_base", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  territoryId: varchar("territory_id").references(() => territories.id),
  dimension: text("dimension").notNull(),
  content: text("content").notNull(),
  embedding: text("embedding").notNull(),
  metadata: json("metadata"),
});

export const indicatorMetadata = pgTable("indicator_metadata", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  dimension: text("dimension").notNull(),
  indicatorKey: text("indicator_key").notNull(),
  indicatorName: text("indicator_name").notNull(),
  description: text("description").notNull(),
  unit: text("unit").notNull(),
  interpretationGuide: text("interpretation_guide"),
});

export const insertTerritorySchema = createInsertSchema(territories).omit({ id: true });
export const insertEconomicIndicatorSchema = createInsertSchema(economicIndicators).omit({ id: true });
export const insertSocialIndicatorSchema = createInsertSchema(socialIndicators).omit({ id: true });
export const insertTerritorialIndicatorSchema = createInsertSchema(territorialIndicators).omit({ id: true });
export const insertEnvironmentalIndicatorSchema = createInsertSchema(environmentalIndicators).omit({ id: true });
export const insertKnowledgeBaseSchema = createInsertSchema(knowledgeBase).omit({ id: true });
export const insertIndicatorMetadataSchema = createInsertSchema(indicatorMetadata).omit({ id: true });

export type Territory = typeof territories.$inferSelect;
export type InsertTerritory = z.infer<typeof insertTerritorySchema>;

export type EconomicIndicator = typeof economicIndicators.$inferSelect;
export type InsertEconomicIndicator = z.infer<typeof insertEconomicIndicatorSchema>;

export type SocialIndicator = typeof socialIndicators.$inferSelect;
export type InsertSocialIndicator = z.infer<typeof insertSocialIndicatorSchema>;

export type TerritorialIndicator = typeof territorialIndicators.$inferSelect;
export type InsertTerritorialIndicator = z.infer<typeof insertTerritorialIndicatorSchema>;

export type EnvironmentalIndicator = typeof environmentalIndicators.$inferSelect;
export type InsertEnvironmentalIndicator = z.infer<typeof insertEnvironmentalIndicatorSchema>;

export type KnowledgeBase = typeof knowledgeBase.$inferSelect;
export type InsertKnowledgeBase = z.infer<typeof insertKnowledgeBaseSchema>;

export type IndicatorMetadata = typeof indicatorMetadata.$inferSelect;
export type InsertIndicatorMetadata = z.infer<typeof insertIndicatorMetadataSchema>;
