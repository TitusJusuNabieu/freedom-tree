import { NextRequest, NextResponse } from "next/server";
import { Prisma } from "@prisma/client";
import { prisma } from "@/lib/prisma";
import { requireAuth } from "@/lib/auth/requireAuth";

export async function GET(req: NextRequest) {
  const identity = await requireAuth(req);
  if (!identity || identity.role !== "ADMIN") {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  const { searchParams } = new URL(req.url);
  const community = searchParams.get("community");

  const where: Prisma.ReportWhereInput = {};
  if (community) where.community = community;

  const reports = await prisma.report.findMany({
    where,
    select: {
      reportingMonth: true,
      maternalDeaths: true,
      infantDeathsTotal: true,
      liveBirths: true,
      deliveriesTotal: true,
    },
    orderBy: { reportingMonth: "asc" },
  });

  const byMonth = new Map<string, { month: string; maternalDeaths: number; infantDeathsTotal: number; liveBirths: number; deliveriesTotal: number }>();
  for (const r of reports) {
    const key = r.reportingMonth.toISOString().slice(0, 7); // YYYY-MM
    const bucket = byMonth.get(key) ?? { month: key, maternalDeaths: 0, infantDeathsTotal: 0, liveBirths: 0, deliveriesTotal: 0 };
    bucket.maternalDeaths += r.maternalDeaths;
    bucket.infantDeathsTotal += r.infantDeathsTotal;
    bucket.liveBirths += r.liveBirths;
    bucket.deliveriesTotal += r.deliveriesTotal;
    byMonth.set(key, bucket);
  }

  return NextResponse.json({ trends: Array.from(byMonth.values()) });
}
