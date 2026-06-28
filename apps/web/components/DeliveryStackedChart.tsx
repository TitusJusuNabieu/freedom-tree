"use client";

import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer,
} from "recharts";

export interface DeliveryPoint {
  month: string;
  deliveriesAtFacility: number;
  deliveriesAtHome: number;
}

export function DeliveryStackedChart({ data }: { data: DeliveryPoint[] }) {
  return (
    <ResponsiveContainer width="100%" height={280}>
      <BarChart data={data} margin={{ top: 4, right: 8, left: 0, bottom: 4 }}>
        <CartesianGrid strokeDasharray="3 3" stroke="#e2e8f0" />
        <XAxis dataKey="month" stroke="#6b859e" fontSize={11} />
        <YAxis stroke="#6b859e" fontSize={11} />
        <Tooltip />
        <Legend wrapperStyle={{ fontSize: 12 }} />
        <Bar dataKey="deliveriesAtFacility" name="At facility" stackId="a" fill="#90b6ad" />
        <Bar dataKey="deliveriesAtHome" name="At home" stackId="a" fill="#f6b94f" radius={[3, 3, 0, 0]} />
      </BarChart>
    </ResponsiveContainer>
  );
}
