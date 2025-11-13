import OpenAI from "openai";

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

export async function generateEmbedding(text: string): Promise<number[]> {
  try {
    const response = await openai.embeddings.create({
      model: "text-embedding-3-small",
      input: text,
    });
    return response.data[0].embedding;
  } catch (error) {
    console.error("Error generating embedding:", error);
    throw new Error("Failed to generate embedding");
  }
}

export async function generateChatCompletion(
  messages: Array<{ role: "system" | "user" | "assistant"; content: string }>,
  context?: string
): Promise<string> {
  try {
    const systemMessage = context
      ? {
          role: "system" as const,
          content: `Você é um assistente especializado em análise territorial do estado do Tocantins, Brasil. Você fornece insights detalhados sobre indicadores econômicos, sociais, territoriais e ambientais. Use o seguinte contexto para responder:\n\n${context}`,
        }
      : {
          role: "system" as const,
          content:
            "Você é um assistente especializado em análise territorial do estado do Tocantins, Brasil. Você fornece insights detalhados sobre indicadores econômicos, sociais, territoriais e ambientais.",
        };

    const response = await openai.chat.completions.create({
      model: "gpt-4o-mini",
      messages: [systemMessage, ...messages],
      temperature: 0.7,
      max_tokens: 1000,
    });

    return response.choices[0].message.content || "";
  } catch (error) {
    console.error("Error generating chat completion:", error);
    throw new Error("Failed to generate response");
  }
}

export function cosineSimilarity(a: number[], b: number[]): number {
  if (a.length !== b.length) {
    throw new Error("Vectors must have the same length");
  }

  let dotProduct = 0;
  let normA = 0;
  let normB = 0;

  for (let i = 0; i < a.length; i++) {
    dotProduct += a[i] * b[i];
    normA += a[i] * a[i];
    normB += b[i] * b[i];
  }

  return dotProduct / (Math.sqrt(normA) * Math.sqrt(normB));
}

export async function findSimilarDocuments(
  queryEmbedding: number[],
  documents: Array<{ id: string; embedding: number[]; content: string }>,
  topK: number = 5
): Promise<Array<{ id: string; content: string; similarity: number }>> {
  const similarities = documents.map((doc) => ({
    id: doc.id,
    content: doc.content,
    similarity: cosineSimilarity(queryEmbedding, doc.embedding),
  }));

  similarities.sort((a, b) => b.similarity - a.similarity);

  return similarities.slice(0, topK);
}
