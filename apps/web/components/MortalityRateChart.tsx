"use client";

import {
  ComposedChart, Bar, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer,
} from "recharts";

export interface MortalityPoint {
  month: string;
  liveBirths: number;
  maternalDeaths: number;
  infantDeathsTotal: number;
  maternalRate: number;
  infantRate: number;
}

export function MortalityRateChart({ data }: { data: MortalityPoint[] }) {
  return (
    <ResponsiveContainer width="100%" height={300}>
      <ComposedChart data={data} margin={{ top: 4, right: 32, left: 0, bottom: 4 }}>
        <CartesianGrid strokeDasharray="3 3" stroke="#e2e8f0" />
        <XAxis dataKey="month" stroke="#6b859e" fontSize={11} />
        <YAxis yAxisId="left" stroke="#6b859e" fontSize={11} />
        <YAxis yAxisId="right" orientation="right" stroke="#ee5b4d" fontSize={11} unit="%" />
        <Tooltip
          formatter={(value: number, name: string) =>
            name.includes("Rate") ? [`${value.toFixed(1)}%`, name] : [value, name]
          }
        />
        <Legend wrapperStyle={{ fontSize: 12 }} />
        <Bar yAxisId="left" dataKey="liveBirths" name="Live births" fill="#90b6ad" opacity={0.7} radius={[3, 3, 0, 0]} />
        <Line yAxisId="right" type="monotone" dataKey="maternalRate" name="Maternal mortality rate %" stroke="#ee5b4d" strokeWidth={2} dot={{ r: 3 }} />
        <Line yAxisId="right" type="monotone" dataKey="infantRate" name="Infant mortality rate %" stroke="#c62f14" strokeWidth={2} dot={{ r: 3 }} />
      </ComposedChart>
    </ResponsiveContainer>
  );
}
