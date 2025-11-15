import { storage } from "../storage";
import { generateEmbedding, findSimilarDocuments, generateChatCompletion } from "./openai";
import type { KnowledgeBase } from "@shared/schema";

export async function indexTerritoryData(
  territoryId: string,
  dimension: string,
  content: string,
  metadata?: any
): Promise<void> {
  const embedding = await generateEmbedding(content);
  const embeddingString = JSON.stringify(embedding);

  await storage.createKnowledgeBase({
    territoryId,
    dimension,
    content,
    embedding: embeddingString,
    metadata,
  });
}

export async function searchRelevantContext(
  query: string,
  dimension?: string,
  topK: number = 5
): Promise<string> {
  const queryEmbedding = await generateEmbedding(query);
  const queryEmbeddingString = JSON.stringify(queryEmbedding);
  
  const knowledgeBaseEntries = await storage.searchKnowledgeBaseOptimized(
    queryEmbeddingString, 
    dimension, 
    topK
  );

  if (knowledgeBaseEntries.length === 0) {
    return "Nenhum dado encontrado na base de conhecimento.";
  }

  const context = knowledgeBaseEntries
    .map((entry: any, index: number) => 
      `[${index + 1}] (similaridade: ${(entry.similarity * 100).toFixed(1)}%) ${entry.content}`
    )
    .join("\n\n");

  return context;
}

export async function generateAIAnalysis(
  territoryId: string,
  dimension: string,
  specificQuery?: string
): Promise<string> {
  const query = specificQuery || `Faça uma análise completa da dimensão ${dimension}`;
  
  const context = await searchRelevantContext(query, dimension, 3);

  const messages = [
    {
      role: "user" as const,
      content: query,
    },
  ];

  const response = await generateChatCompletion(messages, context);
  return response;
}

export async function chatWithRAG(
  userMessage: string,
  conversationHistory: Array<{ role: "user" | "assistant"; content: string }>,
  dimension?: string
): Promise<string> {
  const context = await searchRelevantContext(userMessage, dimension, 5);

  const messages = [
    ...conversationHistory,
    {
      role: "user" as const,
      content: userMessage,
    },
  ];

  const response = await generateChatCompletion(messages, context);
  return response;
}
