"use client";

import { useRef, useState } from "react";
import { Download, Upload, FileSpreadsheet, AlertCircle, CheckCircle2 } from "lucide-react";

interface Props {
  exportParams: string; // pre-built query string from current filters
}

export function ReportsToolbar({ exportParams }: Props) {
  const fileRef = useRef<HTMLInputElement>(null);
  const [importing, setImporting] = useState(false);
  const [result, setResult] = useState<{ total: number; imported: number; errors: { row: number; error?: string }[] } | null>(null);

  async function handleImport(e: React.ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0];
    if (!file) return;
    setImporting(true);
    setResult(null);
    const fd = new FormData();
    fd.append("file", file);
    const res = await fetch("/api/reports/import", { method: "POST", body: fd });
    const data = await res.json();
    setResult(data);
    setImporting(false);
    if (fileRef.current) fileRef.current.value = "";
  }

  return (
    <div className="space-y-3">
      <div className="flex flex-wrap items-center gap-2">
        {/* Download template */}
        <a
          href="/api/reports/template?format=xlsx"
          className="flex items-center gap-1.5 rounded-lg border border-ft-grey-light px-3 py-2 text-xs font-medium text-ft-grey-dark transition hover:border-ft-orange hover:text-ft-orange"
        >
          <FileSpreadsheet size={14} />
          Download template
        </a>

        {/* Upload filled template */}
        <button
          onClick={() => fileRef.current?.click()}
          disabled={importing}
          className="flex items-center gap-1.5 rounded-lg border border-ft-grey-light px-3 py-2 text-xs font-medium text-ft-grey-dark transition hover:border-ft-orange hover:text-ft-orange disabled:opacity-50"
        >
          <Upload size={14} />
          {importing ? "Importing…" : "Import from file"}
        </button>
        <input ref={fileRef} type="file" accept=".csv,.xlsx,.xls" className="hidden" onChange={handleImport} />

        <div className="ml-auto flex gap-2">
          {/* Export current view */}
          <a
            href={`/api/reports/export?format=xlsx${exportParams}`}
            className="flex items-center gap-1.5 rounded-lg bg-ft-orange px-3 py-2 text-xs font-semibold text-white transition hover:bg-ft-dark-orange"
          >
            <Download size={14} />
            Export Excel
          </a>
          <a
            href={`/api/reports/export?format=csv${exportParams}`}
            className="flex items-center gap-1.5 rounded-lg border border-ft-orange px-3 py-2 text-xs font-semibold text-ft-orange transition hover:bg-ft-orange/10"
          >
            <Download size={14} />
            Export CSV
          </a>
        </div>
      </div>

      {/* Import result feedback */}
      {result && (
        <div
          className={`flex items-start gap-3 rounded-lg border px-4 py-3 text-sm ${
            result.errors.length === 0
              ? "border-ft-green/40 bg-ft-green/5 text-ft-grey-darker"
              : "border-ft-dark-orange/30 bg-ft-dark-orange/5 text-ft-grey-darker"
          }`}
        >
          {result.errors.length === 0 ? (
            <CheckCircle2 size={16} className="mt-0.5 shrink-0 text-ft-green" />
          ) : (
            <AlertCircle size={16} className="mt-0.5 shrink-0 text-ft-dark-orange" />
          )}
          <div>
            <p>
              Imported {result.imported} of {result.total} rows successfully.
            </p>
            {result.errors.length > 0 && (
              <ul className="mt-1 space-y-0.5 text-xs text-ft-dark-orange">
                {result.errors.slice(0, 5).map((e) => (
                  <li key={e.row}>Row {e.row}: {e.error}</li>
                ))}
                {result.errors.length > 5 && <li>…and {result.errors.length - 5} more errors</li>}
              </ul>
            )}
          </div>
        </div>
      )}
    </div>
  );
}
