"use client";

import { useRef } from "react";
import { Download } from "lucide-react";
import { toPng } from "html-to-image";

interface Props {
  title: string;
  children: React.ReactNode;
}

export function DownloadableChart({ title, children }: Props) {
  const ref = useRef<HTMLDivElement>(null);

  async function handleDownload() {
    if (!ref.current) return;
    const dataUrl = await toPng(ref.current, { backgroundColor: "#ffffff", pixelRatio: 2 });
    const link = document.createElement("a");
    link.download = `${title.toLowerCase().replace(/\s+/g, "-")}.png`;
    link.href = dataUrl;
    link.click();
  }

  return (
    <div className="rounded-lg border border-ft-grey-light bg-white">
      <div className="flex items-center justify-between border-b border-ft-grey-light px-5 py-3">
        <h3 className="text-sm font-semibold text-ft-grey-darker">{title}</h3>
        <button
          onClick={handleDownload}
          className="flex items-center gap-1.5 rounded-md px-2.5 py-1.5 text-xs font-medium text-ft-grey-medium transition hover:bg-ft-grey-light/30 hover:text-ft-grey-darker"
        >
          <Download size={13} />
          Download PNG
        </button>
      </div>
      <div ref={ref} className="bg-white p-4">
        {children}
      </div>
    </div>
  );
}
