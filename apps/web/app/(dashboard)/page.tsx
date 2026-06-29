import { getServerSession } from "next-auth";
import { Prisma } from "@prisma/client";
import { prisma } from "@/lib/prisma";
import { authOptions } from "@/lib/auth/nextAuthOptions";
import { StatCard } from "@/components/StatCard";
import { TrendChart, type TrendPoint } from "@/components/TrendChart";
import { DownloadableChart } from "@/components/DownloadableChart";
import { CommunityBarChart, type CommunityPoint } from "@/components/CommunityBarChart";
import { DeliveryStackedChart, type DeliveryPoint } from "@/components/DeliveryStackedChart";
import { MortalityRateChart, type MortalityPoint } from "@/components/MortalityRateChart";
import { PlaceOfDeathChart, type PlaceCount } from "@/components/PlaceOfDeathChart";
import { InfantCausesChart, type CauseCount } from "@/components/InfantCausesChart";
import { ShareLinkDialog } from "@/components/ShareLinkDialog";

async function getData(communityFilter: string | null) {
  const where: Prisma.ReportWhereInput = communityFilter ? { community: communityFilter } : {};

  const [agg, reports, communityGroups] = await Promise.all([
    prisma.report.aggregate({
      where,
      _sum: {
        pregnantWomenCount: true,
        deliveriesTotal: true,
        maternalDeaths: true,
        liveBirths: true,
        infantDeathsTotal: true,
        deliveriesAtFacility: true,
        deliveriesAtHome: true,
      },
      _count: { id: true },
    }),
    prisma.report.findMany({
      where,
      select: {
        reportingMonth: true,
        maternalDeaths: true,
        infantDeathsTotal: true,
        liveBirths: true,
        deliveriesTotal: true,
        deliveriesAtFacility: true,
        deliveriesAtHome: true,
        placeOfDeath: true,
        infantDeathCauses: true,
      },
      orderBy: { reportingMonth: "asc" },
    }),
    prisma.report.groupBy({
      by: ["community"],
      where,
      _sum: {
        deliveriesTotal: true,
        liveBirths: true,
        maternalDeaths: true,
        infantDeathsTotal: true,
      },
      orderBy: { community: "asc" },
    }),
  ]);

  const trendMap = new Map<string, TrendPoint>();
  const deliveryMap = new Map<string, DeliveryPoint>();
  const mortalityMap = new Map<string, { liveBirths: number; maternalDeaths: number; infantDeathsTotal: number }>();

  for (const r of reports) {
    const key = r.reportingMonth.toISOString().slice(0, 7);

    const tb = trendMap.get(key) ?? { month: key, maternalDeaths: 0, infantDeathsTotal: 0, liveBirths: 0, deliveriesTotal: 0 };
    tb.maternalDeaths += r.maternalDeaths;
    tb.infantDeathsTotal += r.infantDeathsTotal;
    tb.liveBirths += r.liveBirths;
    tb.deliveriesTotal += r.deliveriesTotal;
    trendMap.set(key, tb);

    const db = deliveryMap.get(key) ?? { month: key, deliveriesAtFacility: 0, deliveriesAtHome: 0 };
    db.deliveriesAtFacility += r.deliveriesAtFacility;
    db.deliveriesAtHome += r.deliveriesAtHome;
    deliveryMap.set(key, db);

    const mb = mortalityMap.get(key) ?? { liveBirths: 0, maternalDeaths: 0, infantDeathsTotal: 0 };
    mb.liveBirths += r.liveBirths;
    mb.maternalDeaths += r.maternalDeaths;
    mb.infantDeathsTotal += r.infantDeathsTotal;
    mortalityMap.set(key, mb);
  }

  const trends = Array.from(trendMap.values());
  const deliveryTrend = Array.from(deliveryMap.values());
  const mortalityPoints: MortalityPoint[] = Array.from(mortalityMap.entries()).map(([month, v]) => ({
    month,
    liveBirths: v.liveBirths,
    maternalDeaths: v.maternalDeaths,
    infantDeathsTotal: v.infantDeathsTotal,
    maternalRate: v.liveBirths > 0 ? (v.maternalDeaths / v.liveBirths) * 100 : 0,
    infantRate: v.liveBirths > 0 ? (v.infantDeathsTotal / v.liveBirths) * 100 : 0,
  }));

  const placeCount: Record<string, number> = { "Health facility": 0, "Home": 0, "Other": 0, "Not Applicable": 0 };
  const labelMap: Record<string, string> = { HEALTH_FACILITY: "Health facility", HOME: "Home", OTHER: "Other", NOT_APPLICABLE: "Not Applicable" };
  for (const r of reports) {
    for (const p of r.placeOfDeath) {
      const label = labelMap[p as string] ?? p;
      placeCount[label] = (placeCount[label] ?? 0) + 1;
    }
  }
  const placeData: PlaceCount[] = Object.entries(placeCount).map(([name, value]) => ({ name, value }));

  const causeLabels: Record<string, string> = {
    LACK_OF_SKILLED_BIRTH_ATTENDANT: "No skilled attendant",
    DELAY_ACCESSING_HEALTH_FACILITY: "Delayed facility access",
    LACK_OF_TRANSPORTATION_POOR_ROAD: "Poor transport/roads",
    POOR_NUTRITION: "Poor nutrition",
    BAD_CULTURAL_PRACTICES: "Cultural practices",
    OTHER: "Other",
    NOT_APPLICABLE: "Not Applicable",
  };
  const causeCount: Record<string, number> = {};
  for (const r of reports) {
    for (const c of r.infantDeathCauses) {
      const label = causeLabels[c as string] ?? c;
      causeCount[label] = (causeCount[label] ?? 0) + 1;
    }
  }
  const causeData: CauseCount[] = Object.entries(causeCount).map(([cause, count]) => ({ cause, count }));

  const communityData: CommunityPoint[] = communityGroups.map((g) => ({
    community: g.community,
    deliveriesTotal: g._sum.deliveriesTotal ?? 0,
    liveBirths: g._sum.liveBirths ?? 0,
    maternalDeaths: g._sum.maternalDeaths ?? 0,
    infantDeathsTotal: g._sum.infantDeathsTotal ?? 0,
  }));

  const allCommunities = await prisma.report.findMany({ select: { community: true }, distinct: ["community"] });

  return {
    summary: {
      reportCount: agg._count.id,
      pregnantWomenCount: agg._sum.pregnantWomenCount ?? 0,
      deliveriesTotal: agg._sum.deliveriesTotal ?? 0,
      maternalDeaths: agg._sum.maternalDeaths ?? 0,
      liveBirths: agg._sum.liveBirths ?? 0,
      infantDeathsTotal: agg._sum.infantDeathsTotal ?? 0,
      deliveriesAtFacility: agg._sum.deliveriesAtFacility ?? 0,
      deliveriesAtHome: agg._sum.deliveriesAtHome ?? 0,
    },
    trends,
    deliveryTrend,
    mortalityPoints,
    placeData,
    causeData,
    communityData,
    allCommunities: allCommunities.map((c) => c.community),
  };
}

export default async function OverviewPage() {
  const session = await getServerSession(authOptions);
  const role = session?.user?.role;
  const isAdmin = role === "ADMIN" || role === "SUPER_ADMIN";
  const isSupervisor = role === "SUPERVISOR";
  const communityFilter = isSupervisor ? (session?.user?.community ?? null) : null;

  const { summary, trends, deliveryTrend, mortalityPoints, placeData, causeData, communityData, allCommunities } =
    await getData(communityFilter);

  const facilityPct = summary.deliveriesTotal > 0
    ? Math.round((summary.deliveriesAtFacility / summary.deliveriesTotal) * 100)
    : 0;

  const scopeLabel = communityFilter
    ? communityFilter
    : "All communities";

  return (
    <div className="space-y-8">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-2xl font-semibold text-ft-grey-darker">Overview</h1>
          <p className="mt-1 text-sm text-ft-grey-medium">
            {scopeLabel} · all reporting periods · {summary.reportCount} report{summary.reportCount === 1 ? "" : "s"}
          </p>
        </div>
        {isAdmin && <ShareLinkDialog communities={allCommunities} />}
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
        <DownloadableChart title="Mortality rates over time (per live births)">
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
    </div>
  );
}
