import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireAuth } from "@/lib/auth/requireAuth";

export async function GET(req: NextRequest) {
  const identity = await requireAuth(req);
  if (!identity || identity.role !== "ADMIN") {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  const grouped = await prisma.report.groupBy({
    by: ["community"],
    _sum: {
      maternalDeaths: true,
      infantDeathsTotal: true,
      liveBirths: true,
      deliveriesTotal: true,
    },
    _count: { id: true },
    orderBy: { community: "asc" },
  });

  return NextResponse.json({
    byCommunity: grouped.map((g) => ({
      community: g.community,
      reportCount: g._count.id,
      maternalDeaths: g._sum.maternalDeaths ?? 0,
      infantDeathsTotal: g._sum.infantDeathsTotal ?? 0,
      liveBirths: g._sum.liveBirths ?? 0,
      deliveriesTotal: g._sum.deliveriesTotal ?? 0,
    })),
  });
}
