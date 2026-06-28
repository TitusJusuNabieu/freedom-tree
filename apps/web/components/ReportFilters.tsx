"use client";

import { useRouter, useSearchParams } from "next/navigation";

export function ReportFilters({ communities }: { communities: string[] }) {
  const router = useRouter();
  const searchParams = useSearchParams();

  function update(key: string, value: string) {
    const params = new URLSearchParams(searchParams.toString());
    if (value) params.set(key, value);
    else params.delete(key);
    params.delete("page");
    router.push(`/reports?${params.toString()}`);
  }

  return (
    <div className="flex flex-wrap gap-4 rounded-lg border border-ft-grey-light p-4">
      <div>
        <label className="mb-1 block text-xs font-medium text-ft-grey-dark">Community</label>
        <select
          defaultValue={searchParams.get("community") ?? ""}
          onChange={(e) => update("community", e.target.value)}
          className="rounded-md border border-ft-grey-light px-2 py-1 text-sm outline-none focus:border-ft-orange"
        >
          <option value="">All communities</option>
          {communities.map((c) => (
            <option key={c} value={c}>
              {c}
            </option>
          ))}
        </select>
      </div>
      <div>
        <label className="mb-1 block text-xs font-medium text-ft-grey-dark">From</label>
        <input
          type="month"
          defaultValue={searchParams.get("dateFrom")?.slice(0, 7) ?? ""}
          onChange={(e) => update("dateFrom", e.target.value ? `${e.target.value}-01` : "")}
          className="rounded-md border border-ft-grey-light px-2 py-1 text-sm outline-none focus:border-ft-orange"
        />
      </div>
      <div>
        <label className="mb-1 block text-xs font-medium text-ft-grey-dark">To</label>
        <input
          type="month"
          defaultValue={searchParams.get("dateTo")?.slice(0, 7) ?? ""}
          onChange={(e) => update("dateTo", e.target.value ? `${e.target.value}-01` : "")}
          className="rounded-md border border-ft-grey-light px-2 py-1 text-sm outline-none focus:border-ft-orange"
        />
      </div>
    </div>
  );
}
