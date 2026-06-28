"use client";

import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from "recharts";

export interface TrendPoint {
  month: string;
  maternalDeaths: number;
  infantDeathsTotal: number;
  liveBirths: number;
  deliveriesTotal: number;
}

export function TrendChart({ data }: { data: TrendPoint[] }) {
  return (
    <ResponsiveContainer width="100%" height={320}>
      <LineChart data={data}>
        <CartesianGrid strokeDasharray="3 3" stroke="#e2e8f0" />
        <XAxis dataKey="month" stroke="#6b859e" fontSize={12} />
        <YAxis stroke="#6b859e" fontSize={12} />
        <Tooltip />
        <Legend />
        <Line type="monotone" dataKey="liveBirths" name="Live births" stroke="#90b6ad" strokeWidth={2} />
        <Line type="monotone" dataKey="maternalDeaths" name="Maternal deaths" stroke="#ee5b4d" strokeWidth={2} />
        <Line type="monotone" dataKey="infantDeathsTotal" name="Infant deaths" stroke="#c62f14" strokeWidth={2} />
      </LineChart>
    </ResponsiveContainer>
  );
}
