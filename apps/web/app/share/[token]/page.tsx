import { notFound } from "next/navigation";
import { Prisma } from "@prisma/client";
import { prisma } from "@/lib/prisma";
import { verifyShareToken } from "@/lib/auth/shareToken";
import { StatCard } from "@/components/StatCard";
import { TrendChart, type TrendPoint } from "@/components/TrendChart";
import { DownloadableChart } from "@/components/DownloadableChart";
import { CommunityBarChart, type CommunityPoint } from "@/components/CommunityBarChart";
import { DeliveryStackedChart, type DeliveryPoint } from "@/components/DeliveryStackedChart";
import { MortalityRateChart, type MortalityPoint } from "@/components/MortalityRateChart";
import { PlaceOfDeathChart, type PlaceCount } from "@/components/PlaceOfDeathChart";
import { InfantCausesChart, type CauseCount } from "@/components/InfantCausesChart";
import { Logo } from "@/components/Logo";

async function getData(communityFilter: string | null) {
  const where: Prisma.ReportWhereInput = communityFilter ? { community: communityFilter } : {};

  const [agg, reports, communityGroups] = await Promise.all([
    prisma.report.aggregate({
      where,
      _sum: { pregnantWomenCount: true, deliveriesTotal: true, maternalDeaths: true, liveBirths: true, infantDeathsTotal: true, deliveriesAtFacility: true, deliveriesAtHome: true },
      _count: { id: true },
    }),
    prisma.report.findMany({
      where,
      select: { reportingMonth: true, maternalDeaths: true, infantDeathsTotal: true, liveBirths: true, deliveriesTotal: true, deliveriesAtFacility: true, deliveriesAtHome: true, placeOfDeath: true, infantDeathCauses: true },
      orderBy: { reportingMonth: "asc" },
    }),
    prisma.report.groupBy({
      by: ["community"],
      where,
      _sum: { deliveriesTotal: true, liveBirths: true, maternalDeaths: true, infantDeathsTotal: true },
      orderBy: { community: "asc" },
    }),
  ]);

  const trendMap = new Map<string, TrendPoint>();
  const deliveryMap = new Map<string, DeliveryPoint>();
  const mortalityMap = new Map<string, { liveBirths: number; maternalDeaths: number; infantDeathsTotal: number }>();

  for (const r of reports) {
    const key = r.reportingMonth.toISOString().slice(0, 7);
    const tb = trendMap.get(key) ?? { month: key, maternalDeaths: 0, infantDeathsTotal: 0, liveBirths: 0, deliveriesTotal: 0 };
    tb.maternalDeaths += r.maternalDeaths; tb.infantDeathsTotal += r.infantDeathsTotal;
    tb.liveBirths += r.liveBirths; tb.deliveriesTotal += r.deliveriesTotal;
    trendMap.set(key, tb);
    const db = deliveryMap.get(key) ?? { month: key, deliveriesAtFacility: 0, deliveriesAtHome: 0 };
    db.deliveriesAtFacility += r.deliveriesAtFacility; db.deliveriesAtHome += r.deliveriesAtHome;
    deliveryMap.set(key, db);
    const mb = mortalityMap.get(key) ?? { liveBirths: 0, maternalDeaths: 0, infantDeathsTotal: 0 };
    mb.liveBirths += r.liveBirths; mb.maternalDeaths += r.maternalDeaths; mb.infantDeathsTotal += r.infantDeathsTotal;
    mortalityMap.set(key, mb);
  }

  const placeCount: Record<string, number> = { "Health facility": 0, "Home": 0, "Other": 0, "Not Applicable": 0 };
  const placeMap: Record<string, string> = { HEALTH_FACILITY: "Health facility", HOME: "Home", OTHER: "Other", NOT_APPLICABLE: "Not Applicable" };
  for (const r of reports) for (const p of r.placeOfDeath) { const l = placeMap[p as string] ?? p; placeCount[l] = (placeCount[l] ?? 0) + 1; }
  const placeData: PlaceCount[] = Object.entries(placeCount).map(([name, value]) => ({ name, value }));

  const causeLabels: Record<string, string> = { LACK_OF_SKILLED_BIRTH_ATTENDANT: "No skilled attendant", DELAY_ACCESSING_HEALTH_FACILITY: "Delayed facility access", LACK_OF_TRANSPORTATION_POOR_ROAD: "Poor transport/roads", POOR_NUTRITION: "Poor nutrition", BAD_CULTURAL_PRACTICES: "Cultural practices", OTHER: "Other", NOT_APPLICABLE: "Not Applicable" };
  const causeCount: Record<string, number> = {};
  for (const r of reports) for (const c of r.infantDeathCauses) { const l = causeLabels[c as string] ?? c; causeCount[l] = (causeCount[l] ?? 0) + 1; }
  const causeData: CauseCount[] = Object.entries(causeCount).map(([cause, count]) => ({ cause, count }));

  const communityData: CommunityPoint[] = communityGroups.map((g) => ({
    community: g.community,
    deliveriesTotal: g._sum.deliveriesTotal ?? 0,
    liveBirths: g._sum.liveBirths ?? 0,
    maternalDeaths: g._sum.maternalDeaths ?? 0,
    infantDeathsTotal: g._sum.infantDeathsTotal ?? 0,
  }));

  const mortalityPoints: MortalityPoint[] = Array.from(mortalityMap.entries()).map(([month, v]) => ({
    month, liveBirths: v.liveBirths, maternalDeaths: v.maternalDeaths, infantDeathsTotal: v.infantDeathsTotal,
    maternalRate: v.liveBirths > 0 ? (v.maternalDeaths / v.liveBirths) * 100 : 0,
    infantRate: v.liveBirths > 0 ? (v.infantDeathsTotal / v.liveBirths) * 100 : 0,
  }));

  return {
    summary: {
      reportCount: agg._count.id,
      pregnantWomenCount: agg._sum.pregnantWomenCount ?? 0,
      deliveriesTotal: agg._sum.deliveriesTotal ?? 0,
      maternalDeaths: agg._sum.maternalDeaths ?? 0,
      liveBirths: agg._sum.liveBirths ?? 0,
      infantDeathsTotal: agg._sum.infantDeathsTotal ?? 0,
      deliveriesAtFacility: agg._sum.deliveriesAtFacility ?? 0,
    },
    trends: Array.from(trendMap.values()),
    deliveryTrend: Array.from(deliveryMap.values()),
    mortalityPoints,
    placeData,
    causeData,
    communityData,
  };
}

export default async function SharePage({ params }: { params: Promise<{ token: string }> }) {
  const { token } = await params;

  let claims;
  try {
    claims = verifyShareToken(token);
  } catch {
    notFound();
  }

  const { summary, trends, deliveryTrend, mortalityPoints, placeData, causeData, communityData } =
    await getData(claims.community);

  const facilityPct = summary.deliveriesTotal > 0
    ? Math.round((summary.deliveriesAtFacility / summary.deliveriesTotal) * 100)
    : 0;

  const scopeLabel = claims.community ?? "All communities";

  return (
    <div className="min-h-screen bg-white">
      {/* Minimal branded header */}
      <header className="border-b border-ft-grey-light bg-white px-6 py-4">
        <div className="mx-auto flex max-w-7xl items-center justify-between">
          <Logo />
          <div className="text-right">
            <p className="text-sm font-medium text-ft-grey-darker">{claims.label}</p>
            <p className="text-xs text-ft-grey-medium">{scopeLabel} · Read-only view</p>
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-7xl space-y-8 px-6 py-8">
        <div>
          <h1 className="text-2xl font-semibold text-ft-grey-darker">Maternal &amp; Infant Health Report</h1>
          <p className="mt-1 text-sm text-ft-grey-medium">
            {scopeLabel} · {summary.reportCount} report{summary.reportCount === 1 ? "" : "s"} · Prepared by Freedom Tree
          </p>
        </div>

        <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-6">
          <StatCard label="Pregnant women" value={summary.pregnantWomenCount} />
          <StatCard label="Deliveries" value={summary.deliveriesTotal} />
          <StatCard label="Live births" value={summary.liveBirths} />
          <StatCard label="Maternal deaths" value={summary.maternalDeaths} />
          <StatCard label="Infant deaths" value={summary.infantDeathsTotal} />
          <StatCard label="Facility deliveries" value={facilityPct} suffix="%" />
        </div>

        <div className="grid gap-6 xl:grid-cols-2">
          <DownloadableChart title="Monthly trends">
            <TrendChart data={trends} />
          </DownloadableChart>
          <DownloadableChart title="Mortality rates over time">
            <MortalityRateChart data={mortalityPoints} />
          </DownloadableChart>
        </div>

        <div className="grid gap-6 xl:grid-cols-2">
          <DownloadableChart title="Delivery location by month">
            <DeliveryStackedChart data={deliveryTrend} />
          </DownloadableChart>
          <DownloadableChart title="Place of maternal death">
            <PlaceOfDeathChart data={placeData} />
          </DownloadableChart>
        </div>

        <DownloadableChart title="Community comparison">
          <CommunityBarChart data={communityData} />
        </DownloadableChart>

        <DownloadableChart title="Infant death contributing factors">
          <InfantCausesChart data={causeData} />
        </DownloadableChart>

        <footer className="border-t border-ft-grey-light pt-6 text-center text-xs text-ft-grey-medium">
          This is a read-only report generated by Freedom Tree. Data is confidential and intended for the recipient only.
        </footer>
      </main>
    </div>
  );
}
