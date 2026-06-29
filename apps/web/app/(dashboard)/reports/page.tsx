import Link from "next/link";
import { Prisma } from "@prisma/client";
import { getServerSession } from "next-auth";
import { prisma } from "@/lib/prisma";
import { authOptions } from "@/lib/auth/nextAuthOptions";
import { ReportFilters } from "@/components/ReportFilters";
import { ReportsToolbar } from "@/components/ReportsToolbar";

const PAGE_SIZE = 20;

export default async function ReportsPage({
  searchParams,
}: {
  searchParams: Promise<{ community?: string; month?: string; dateFrom?: string; dateTo?: string; page?: string }>;
}) {
  const session = await getServerSession(authOptions);
  const role = session?.user?.role;
  const isAdmin = role === "ADMIN" || role === "SUPER_ADMIN";
  const isSupervisor = role === "SUPERVISOR";

  const params = await searchParams;
  const page = Math.max(1, parseInt(params.page ?? "1", 10) || 1);

  const where: Prisma.ReportWhereInput = {};

  // Supervisors are locked to their own community; admins/analysts can filter freely
  if (isSupervisor && session?.user?.community) {
    where.community = session.user.community;
  } else if (params.community) {
    where.community = params.community;
  }

  if (params.month) where.reportingMonth = new Date(params.month);
  if (params.dateFrom || params.dateTo) {
    where.reportingMonth = {
      ...(typeof where.reportingMonth === "object" ? where.reportingMonth : {}),
      ...(params.dateFrom ? { gte: new Date(params.dateFrom) } : {}),
      ...(params.dateTo ? { lte: new Date(params.dateTo) } : {}),
    };
  }

  const [reports, total, communities] = await Promise.all([
    prisma.report.findMany({
      where,
      orderBy: { reportingMonth: "desc" },
      skip: (page - 1) * PAGE_SIZE,
      take: PAGE_SIZE,
    }),
    prisma.report.count({ where }),
    prisma.report.findMany({ select: { community: true }, distinct: ["community"] }),
  ]);

  const totalPages = Math.max(1, Math.ceil(total / PAGE_SIZE));

  const exportQs = [
    params.community ? `&community=${encodeURIComponent(params.community)}` : "",
    params.dateFrom ? `&dateFrom=${params.dateFrom}` : "",
    params.dateTo ? `&dateTo=${params.dateTo}` : "",
  ].join("");

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-semibold text-ft-grey-darker">Reports</h1>
        <p className="mt-1 text-sm text-ft-grey-medium">
          {isSupervisor && session?.user?.community ? `${session.user.community} · ` : ""}
          {total} report{total === 1 ? "" : "s"}
        </p>
      </div>

      {/* Community filter only for admins/analysts — supervisors are locked to theirs */}
      {!isSupervisor && <ReportFilters communities={communities.map((c) => c.community)} />}

      {/* Import/export toolbar: admins only */}
      {isAdmin && <ReportsToolbar exportParams={exportQs} />}

      <div className="overflow-x-auto rounded-lg border border-ft-grey-light">
        <table className="w-full text-left text-sm">
          <thead className="bg-ft-grey-darker text-white">
            <tr>
              <th className="px-4 py-2">Month</th>
              <th className="px-4 py-2">Community</th>
              <th className="px-4 py-2">Submitted by</th>
              <th className="px-4 py-2">Live births</th>
              <th className="px-4 py-2">Maternal deaths</th>
              <th className="px-4 py-2">Infant deaths</th>
              <th className="px-4 py-2">Received</th>
            </tr>
          </thead>
          <tbody>
            {reports.map((r) => (
              <tr key={r.id} className="border-t border-ft-grey-light hover:bg-ft-grey-light/20">
                <td className="px-4 py-2">
                  <Link href={`/reports/${r.id}`} className="text-ft-orange hover:text-ft-dark-orange">
                    {r.reportingMonth.toISOString().slice(0, 7)}
                  </Link>
                </td>
                <td className="px-4 py-2">{r.community}</td>
                <td className="px-4 py-2">{r.submittedByName}</td>
                <td className="px-4 py-2">{r.liveBirths}</td>
                <td className="px-4 py-2">{r.maternalDeaths}</td>
                <td className="px-4 py-2">{r.infantDeathsTotal}</td>
                <td className="px-4 py-2 text-ft-grey-medium">
                  {r.serverReceivedAt.toISOString().slice(0, 10)}
                </td>
              </tr>
            ))}
            {reports.length === 0 && (
              <tr>
                <td colSpan={7} className="px-4 py-8 text-center text-ft-grey-medium">
                  No reports match these filters.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {totalPages > 1 && (
        <div className="flex justify-center gap-2 text-sm">
          {Array.from({ length: totalPages }, (_, i) => i + 1).map((p) => (
            <Link
              key={p}
              href={{ pathname: "/reports", query: { ...params, page: p } }}
              className={`rounded px-3 py-1 ${p === page ? "bg-ft-orange text-white" : "text-ft-grey-dark hover:bg-ft-grey-light/30"}`}
            >
              {p}
            </Link>
          ))}
        </div>
      )}
    </div>
  );
}
