"use client";

import { PieChart, Pie, Cell, Tooltip, Legend, ResponsiveContainer } from "recharts";

export interface PlaceCount {
  name: string;
  value: number;
}

const COLORS: Record<string, string> = {
  "Health facility": "#90b6ad",
  "Home": "#ee5b4d",
  "Other": "#f6b94f",
  "Not Applicable": "#9cadbf",
};

export function PlaceOfDeathChart({ data }: { data: PlaceCount[] }) {
  const filtered = data.filter((d) => d.value > 0);
  if (filtered.length === 0) {
    return <p className="py-16 text-center text-sm text-ft-grey-medium">No data available</p>;
  }
  return (
    <ResponsiveContainer width="100%" height={280}>
      <PieChart>
        <Pie
          data={filtered}
          dataKey="value"
          nameKey="name"
          cx="50%"
          cy="50%"
          outerRadius={100}
          innerRadius={50}
          paddingAngle={2}
          label={({ name, percent }) => `${name} ${(percent * 100).toFixed(0)}%`}
          labelLine={false}
        >
          {filtered.map((entry) => (
            <Cell key={entry.name} fill={COLORS[entry.name] ?? "#9cadbf"} />
          ))}
        </Pie>
        <Tooltip />
        <Legend wrapperStyle={{ fontSize: 12 }} />
      </PieChart>
    </ResponsiveContainer>
  );
}
