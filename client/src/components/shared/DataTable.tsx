import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import { ArrowUpDown, Download } from "lucide-react";
import { useState } from "react";

export interface Column {
  key: string;
  label: string;
  sortable?: boolean;
}

export interface DataTableProps {
  columns: Column[];
  data: Record<string, any>[];
  onExport?: () => void;
}

export default function DataTable({ columns, data, onExport }: DataTableProps) {
  const [sortKey, setSortKey] = useState<string | null>(null);
  const [sortDirection, setSortDirection] = useState<"asc" | "desc">("asc");

  const handleSort = (key: string) => {
    if (sortKey === key) {
      setSortDirection(sortDirection === "asc" ? "desc" : "asc");
    } else {
      setSortKey(key);
      setSortDirection("asc");
    }
  };

  const sortedData = sortKey 
    ? [...data].sort((a, b) => {
        const aVal = a[sortKey];
        const bVal = b[sortKey];
        const modifier = sortDirection === "asc" ? 1 : -1;
        return aVal > bVal ? modifier : aVal < bVal ? -modifier : 0;
      })
    : data;

  return (
    <div className="space-y-4">
      {onExport && (
        <div className="flex justify-end">
          <Button 
            variant="outline" 
            size="sm"
            onClick={onExport}
            data-testid="button-export-csv"
          >
            <Download className="w-4 h-4 mr-2" />
            Exportar CSV
          </Button>
        </div>
      )}
      
      <div className="border rounded-md">
        <Table>
          <TableHeader>
            <TableRow>
              {columns.map((column) => (
                <TableHead key={column.key} className="font-semibold">
                  {column.sortable ? (
                    <button
                      onClick={() => handleSort(column.key)}
                      className="flex items-center gap-2 hover:text-secondary transition-colors"
                      data-testid={`button-sort-${column.key}`}
                    >
                      {column.label}
                      <ArrowUpDown className="w-4 h-4" />
                    </button>
                  ) : (
                    column.label
                  )}
                </TableHead>
              ))}
            </TableRow>
          </TableHeader>
          <TableBody>
            {sortedData.map((row, index) => (
              <TableRow key={index} data-testid={`row-data-${index}`}>
                {columns.map((column) => (
                  <TableCell key={column.key} data-testid={`cell-${column.key}-${index}`}>
                    {row[column.key]}
                  </TableCell>
                ))}
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>
    </div>
  );
}
