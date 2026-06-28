"use client";

import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Cell,
} from "recharts";

export interface CauseCount {
  cause: string;
  count: number;
}

const BAR_COLORS = ["#ee5b4d", "#c62f14", "#f6b94f", "#90b6ad", "#6b859e", "#9cadbf", "#374655"];

export function InfantCausesChart({ data }: { data: CauseCount[] }) {
  const sorted = [...data].sort((a, b) => b.count - a.count).filter((d) => d.count > 0);
  if (sorted.length === 0) {
    return <p className="py-16 text-center text-sm text-ft-grey-medium">No data available</p>;
  }
  return (
    <ResponsiveContainer width="100%" height={Math.max(220, sorted.length * 42)}>
      <BarChart data={sorted} layout="vertical" margin={{ top: 4, right: 20, left: 8, bottom: 4 }}>
        <CartesianGrid strokeDasharray="3 3" stroke="#e2e8f0" horizontal={false} />
        <XAxis type="number" stroke="#6b859e" fontSize={11} />
        <YAxis dataKey="cause" type="category" stroke="#6b859e" fontSize={11} width={180} />
        <Tooltip />
        <Bar dataKey="count" name="Reports" radius={[0, 3, 3, 0]}>
          {sorted.map((_, i) => (
            <Cell key={i} fill={BAR_COLORS[i % BAR_COLORS.length]} />
          ))}
        </Bar>
      </BarChart>
    </ResponsiveContainer>
  );
}
