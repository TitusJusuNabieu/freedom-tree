"use client";

import { useState } from "react";
import { Share2, Copy, Check, X } from "lucide-react";

interface Props {
  communities: string[];
}

export function ShareLinkDialog({ communities }: Props) {
  const [open, setOpen] = useState(false);
  const [label, setLabel] = useState("");
  const [community, setCommunity] = useState<string>("all");
  const [expiryDays, setExpiryDays] = useState(90);
  const [loading, setLoading] = useState(false);
  const [shareUrl, setShareUrl] = useState<string | null>(null);
  const [copied, setCopied] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function generate() {
    if (!label.trim()) { setError("Please enter a label."); return; }
    setLoading(true);
    setError(null);
    try {
      const res = await fetch("/api/share", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          label: label.trim(),
          community: community === "all" ? null : community,
          expiryDays,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error ?? "Failed to generate link");
      setShareUrl(`${window.location.origin}/share/${data.token}`);
    } catch (e) {
      setError((e as Error).message);
    } finally {
      setLoading(false);
    }
  }

  async function copy() {
    if (!shareUrl) return;
    await navigator.clipboard.writeText(shareUrl);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  }

  function reset() {
    setOpen(false);
    setLabel("");
    setCommunity("all");
    setExpiryDays(90);
    setShareUrl(null);
    setError(null);
    setCopied(false);
  }

  return (
    <>
      <button
        onClick={() => setOpen(true)}
        className="flex items-center gap-2 rounded-md bg-ft-grey-dark px-4 py-2 text-sm font-medium text-white hover:bg-ft-grey-darker"
      >
        <Share2 size={16} />
        Share dashboard
      </button>

      {open && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40">
          <div className="w-full max-w-md rounded-xl bg-white p-6 shadow-xl">
            <div className="mb-4 flex items-center justify-between">
              <h2 className="text-lg font-semibold text-ft-grey-darker">Generate read-only share link</h2>
              <button onClick={reset} className="text-ft-grey-medium hover:text-ft-grey-darker"><X size={18} /></button>
            </div>

            {!shareUrl ? (
              <div className="space-y-4">
                <div>
                  <label className="mb-1 block text-sm font-medium text-ft-grey-dark">Label</label>
                  <input
                    className="w-full rounded-md border border-ft-grey-light px-3 py-2 text-sm focus:border-ft-orange focus:outline-none"
                    placeholder="e.g. Q2 2026 Donor Report"
                    value={label}
                    onChange={(e) => setLabel(e.target.value)}
                  />
                </div>

                <div>
                  <label className="mb-1 block text-sm font-medium text-ft-grey-dark">Community scope</label>
                  <select
                    className="w-full rounded-md border border-ft-grey-light px-3 py-2 text-sm focus:border-ft-orange focus:outline-none"
                    value={community}
                    onChange={(e) => setCommunity(e.target.value)}
                  >
                    <option value="all">All communities</option>
                    {communities.map((c) => <option key={c} value={c}>{c}</option>)}
                  </select>
                </div>

                <div>
                  <label className="mb-1 block text-sm font-medium text-ft-grey-dark">Expires in</label>
                  <select
                    className="w-full rounded-md border border-ft-grey-light px-3 py-2 text-sm focus:border-ft-orange focus:outline-none"
                    value={expiryDays}
                    onChange={(e) => setExpiryDays(Number(e.target.value))}
                  >
                    <option value={30}>30 days</option>
                    <option value={60}>60 days</option>
                    <option value={90}>90 days</option>
                    <option value={180}>6 months</option>
                    <option value={365}>1 year</option>
                  </select>
                </div>

                {error && <p className="text-sm text-red-600">{error}</p>}

                <button
                  onClick={generate}
                  disabled={loading}
                  className="w-full rounded-md bg-ft-orange px-4 py-2 text-sm font-medium text-white hover:bg-ft-dark-orange disabled:opacity-60"
                >
                  {loading ? "Generating…" : "Generate link"}
                </button>
              </div>
            ) : (
              <div className="space-y-4">
                <p className="text-sm text-ft-grey-medium">
                  Share this link. It gives read-only access to the dashboard with no login required.
                  It expires in <strong>{expiryDays} days</strong>.
                </p>
                <div className="flex items-center gap-2 rounded-md border border-ft-grey-light bg-ft-grey-light/20 p-3">
                  <span className="flex-1 truncate text-xs text-ft-grey-darker">{shareUrl}</span>
                  <button
                    onClick={copy}
                    className="shrink-0 rounded-md bg-ft-orange px-3 py-1.5 text-xs font-medium text-white hover:bg-ft-dark-orange"
                  >
                    {copied ? <Check size={14} /> : <Copy size={14} />}
                  </button>
                </div>
                <button
                  onClick={reset}
                  className="w-full rounded-md border border-ft-grey-light px-4 py-2 text-sm text-ft-grey-dark hover:bg-ft-grey-light/30"
                >
                  Done
                </button>
              </div>
            )}
          </div>
        </div>
      )}
    </>
  );
}
