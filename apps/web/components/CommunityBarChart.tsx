"use client";

import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer,
} from "recharts";

export interface CommunityPoint {
  community: string;
  deliveriesTotal: number;
  liveBirths: number;
  maternalDeaths: number;
  infantDeathsTotal: number;
}

export function CommunityBarChart({ data }: { data: CommunityPoint[] }) {
  return (
    <ResponsiveContainer width="100%" height={300}>
      <BarChart data={data} margin={{ top: 4, right: 8, left: 0, bottom: 4 }}>
        <CartesianGrid strokeDasharray="3 3" stroke="#e2e8f0" />
        <XAxis dataKey="community" stroke="#6b859e" fontSize={11} />
        <YAxis stroke="#6b859e" fontSize={11} />
        <Tooltip />
        <Legend wrapperStyle={{ fontSize: 12 }} />
        <Bar dataKey="deliveriesTotal" name="Deliveries" fill="#90b6ad" radius={[3, 3, 0, 0]} />
        <Bar dataKey="liveBirths" name="Live births" fill="#f6b94f" radius={[3, 3, 0, 0]} />
        <Bar dataKey="maternalDeaths" name="Maternal deaths" fill="#ee5b4d" radius={[3, 3, 0, 0]} />
        <Bar dataKey="infantDeathsTotal" name="Infant deaths" fill="#c62f14" radius={[3, 3, 0, 0]} />
      </BarChart>
    </ResponsiveContainer>
  );
}
