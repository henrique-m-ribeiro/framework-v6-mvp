import { Card } from "@/components/ui/card";
import { Sparkles, RefreshCw } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Skeleton } from "@/components/ui/skeleton";

interface AIAnalysisBoxProps {
  title: string;
  content: string;
  loading?: boolean;
  onRegenerate?: () => void;
}

export default function AIAnalysisBox({ title, content, loading, onRegenerate }: AIAnalysisBoxProps) {
  return (
    <Card 
      className="p-6 bg-secondary/5 border-t-4 border-t-secondary relative overflow-visible" 
      data-testid="card-ai-analysis"
    >
      <div className="absolute -top-2 -right-2">
        <div className="w-8 h-8 rounded-full bg-secondary flex items-center justify-center shadow-lg animate-pulse">
          <Sparkles className="w-4 h-4 text-white" />
        </div>
      </div>

      <div className="flex items-start justify-between mb-4">
        <div className="flex items-center gap-2">
          <Sparkles className="w-5 h-5 text-secondary" />
          <h3 className="text-lg font-semibold text-secondary" data-testid="text-analysis-title">
            {title}
          </h3>
        </div>
        {onRegenerate && !loading && (
          <Button 
            variant="ghost" 
            size="sm"
            onClick={onRegenerate}
            className="h-8"
            data-testid="button-regenerate-analysis"
          >
            <RefreshCw className="w-4 h-4" />
          </Button>
        )}
      </div>

      {loading ? (
        <div className="space-y-3">
          <Skeleton className="h-4 w-full" />
          <Skeleton className="h-4 w-full" />
          <Skeleton className="h-4 w-3/4" />
        </div>
      ) : (
        <p className="text-sm leading-relaxed text-foreground" data-testid="text-analysis-content">
          {content}
        </p>
      )}
    </Card>
  );
}
