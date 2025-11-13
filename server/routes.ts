import type { Express } from "express";
import { createServer, type Server } from "http";
import { storage } from "./storage";
import { 
  insertTerritorySchema,
  insertEconomicIndicatorSchema,
  insertSocialIndicatorSchema,
  insertTerritorialIndicatorSchema,
  insertEnvironmentalIndicatorSchema
} from "@shared/schema";

export async function registerRoutes(app: Express): Promise<Server> {
  app.get("/api/territories", async (req, res) => {
    try {
      const territories = await storage.getTerritories();
      res.json(territories);
    } catch (error) {
      res.status(500).json({ error: "Failed to fetch territories" });
    }
  });

  app.get("/api/territories/:id", async (req, res) => {
    try {
      const territory = await storage.getTerritory(req.params.id);
      if (!territory) {
        return res.status(404).json({ error: "Territory not found" });
      }
      res.json(territory);
    } catch (error) {
      res.status(500).json({ error: "Failed to fetch territory" });
    }
  });

  app.post("/api/territories", async (req, res) => {
    try {
      const validatedData = insertTerritorySchema.parse(req.body);
      const territory = await storage.createTerritory(validatedData);
      res.status(201).json(territory);
    } catch (error) {
      res.status(400).json({ error: "Invalid territory data" });
    }
  });

  app.get("/api/territories/:id/indicators/economic", async (req, res) => {
    try {
      const indicators = await storage.getEconomicIndicators(req.params.id);
      res.json(indicators);
    } catch (error) {
      res.status(500).json({ error: "Failed to fetch economic indicators" });
    }
  });

  app.post("/api/territories/:id/indicators/economic", async (req, res) => {
    try {
      const validatedData = insertEconomicIndicatorSchema.parse({
        ...req.body,
        territoryId: req.params.id
      });
      const indicator = await storage.createEconomicIndicator(validatedData);
      res.status(201).json(indicator);
    } catch (error) {
      res.status(400).json({ error: "Invalid economic indicator data" });
    }
  });

  app.get("/api/territories/:id/indicators/social", async (req, res) => {
    try {
      const indicators = await storage.getSocialIndicators(req.params.id);
      res.json(indicators);
    } catch (error) {
      res.status(500).json({ error: "Failed to fetch social indicators" });
    }
  });

  app.post("/api/territories/:id/indicators/social", async (req, res) => {
    try {
      const validatedData = insertSocialIndicatorSchema.parse({
        ...req.body,
        territoryId: req.params.id
      });
      const indicator = await storage.createSocialIndicator(validatedData);
      res.status(201).json(indicator);
    } catch (error) {
      res.status(400).json({ error: "Invalid social indicator data" });
    }
  });

  app.get("/api/territories/:id/indicators/territorial", async (req, res) => {
    try {
      const indicators = await storage.getTerritorialIndicators(req.params.id);
      res.json(indicators);
    } catch (error) {
      res.status(500).json({ error: "Failed to fetch territorial indicators" });
    }
  });

  app.post("/api/territories/:id/indicators/territorial", async (req, res) => {
    try {
      const validatedData = insertTerritorialIndicatorSchema.parse({
        ...req.body,
        territoryId: req.params.id
      });
      const indicator = await storage.createTerritorialIndicator(validatedData);
      res.status(201).json(indicator);
    } catch (error) {
      res.status(400).json({ error: "Invalid territorial indicator data" });
    }
  });

  app.get("/api/territories/:id/indicators/environmental", async (req, res) => {
    try {
      const indicators = await storage.getEnvironmentalIndicators(req.params.id);
      res.json(indicators);
    } catch (error) {
      res.status(500).json({ error: "Failed to fetch environmental indicators" });
    }
  });

  app.post("/api/territories/:id/indicators/environmental", async (req, res) => {
    try {
      const validatedData = insertEnvironmentalIndicatorSchema.parse({
        ...req.body,
        territoryId: req.params.id
      });
      const indicator = await storage.createEnvironmentalIndicator(validatedData);
      res.status(201).json(indicator);
    } catch (error) {
      res.status(400).json({ error: "Invalid environmental indicator data" });
    }
  });

  app.post("/api/chat", async (req, res) => {
    try {
      const { message, history, dimension } = req.body;
      
      if (!message) {
        return res.status(400).json({ error: "Message is required" });
      }

      const { chatWithRAG } = await import("./services/rag");
      const response = await chatWithRAG(message, history || [], dimension);
      
      res.json({ response });
    } catch (error) {
      console.error("Chat error:", error);
      res.status(500).json({ error: "Failed to generate response" });
    }
  });

  app.post("/api/generate-analysis", async (req, res) => {
    try {
      const { territoryId, dimension } = req.body;
      
      if (!territoryId || !dimension) {
        return res.status(400).json({ error: "Territory ID and dimension are required" });
      }

      const { generateAIAnalysis } = await import("./services/rag");
      const analysis = await generateAIAnalysis(territoryId, dimension);
      
      res.json({ analysis });
    } catch (error) {
      console.error("Analysis error:", error);
      res.status(500).json({ error: "Failed to generate analysis" });
    }
  });

  const httpServer = createServer(app);

  return httpServer;
}
