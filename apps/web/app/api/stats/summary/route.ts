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
  const month = searchParams.get("month");
  const community = searchParams.get("community");

  const where: Prisma.ReportWhereInput = {};
  if (month) where.reportingMonth = new Date(month);
  if (community) where.community = community;

  const agg = await prisma.report.aggregate({
    where,
    _sum: {
      pregnantWomenCount: true,
      deliveriesTotal: true,
      maternalDeaths: true,
      liveBirths: true,
      infantDeathsTotal: true,
    },
    _count: { id: true },
  });

  return NextResponse.json({
    reportCount: agg._count.id,
    pregnantWomenCount: agg._sum.pregnantWomenCount ?? 0,
    deliveriesTotal: agg._sum.deliveriesTotal ?? 0,
    maternalDeaths: agg._sum.maternalDeaths ?? 0,
    liveBirths: agg._sum.liveBirths ?? 0,
    infantDeathsTotal: agg._sum.infantDeathsTotal ?? 0,
  });
}
