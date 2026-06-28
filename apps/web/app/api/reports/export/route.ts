import { NextRequest, NextResponse } from "next/server";
import * as XLSX from "xlsx";
import { prisma } from "@/lib/prisma";
import { requireAuth } from "@/lib/auth/requireAuth";

const COLUMNS = [
  "reportingMonth", "community", "submittedByName", "submittedByPosition", "dateSubmitted",
  "pregnantWomenCount", "deliveriesTotal", "deliveriesAtFacility", "deliveriesAtHome",
  "maternalDeaths", "placeOfDeath", "placeOfDeathOtherNote", "suspectedMaternalCause",
  "liveBirths", "infantDeathsTotal", "infantDeathsWithin24h", "infantDeathsWithin1Month",
  "infantDeathsWithin12Months", "infantDeathCauses", "infantDeathCausesOtherNote",
  "keyChallenges", "actionsTaken", "additionalComments",
];

export async function GET(req: NextRequest) {
  const identity = await requireAuth(req);
  if (!identity || identity.role !== "ADMIN") {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  const { searchParams } = new URL(req.url);
  const format = searchParams.get("format") === "csv" ? "csv" : "xlsx";
  const community = searchParams.get("community") ?? undefined;
  const dateFrom = searchParams.get("dateFrom") ?? undefined;
  const dateTo = searchParams.get("dateTo") ?? undefined;

  const reports = await prisma.report.findMany({
    where: {
      ...(community ? { community } : {}),
      ...(dateFrom || dateTo ? { reportingMonth: { ...(dateFrom ? { gte: new Date(dateFrom) } : {}), ...(dateTo ? { lte: new Date(dateTo) } : {}) } } : {}),
    },
    orderBy: [{ reportingMonth: "desc" }, { community: "asc" }],
  });

  const rows = reports.map((r) => ({
    reportingMonth: r.reportingMonth.toISOString().slice(0, 7),
    community: r.community,
    submittedByName: r.submittedByName,
    submittedByPosition: r.submittedByPosition,
    dateSubmitted: r.dateSubmitted.toISOString().slice(0, 10),
    pregnantWomenCount: r.pregnantWomenCount,
    deliveriesTotal: r.deliveriesTotal,
    deliveriesAtFacility: r.deliveriesAtFacility,
    deliveriesAtHome: r.deliveriesAtHome,
    maternalDeaths: r.maternalDeaths,
    placeOfDeath: (r.placeOfDeath as string[]).join(", "),
    placeOfDeathOtherNote: r.placeOfDeathOtherNote ?? "",
    suspectedMaternalCause: r.suspectedMaternalCause ?? "",
    liveBirths: r.liveBirths,
    infantDeathsTotal: r.infantDeathsTotal,
    infantDeathsWithin24h: r.infantDeathsWithin24h,
    infantDeathsWithin1Month: r.infantDeathsWithin1Month,
    infantDeathsWithin12Months: r.infantDeathsWithin12Months,
    infantDeathCauses: (r.infantDeathCauses as string[]).join(", "),
    infantDeathCausesOtherNote: r.infantDeathCausesOtherNote ?? "",
    keyChallenges: r.keyChallenges,
    actionsTaken: r.actionsTaken,
    additionalComments: r.additionalComments,
  }));

  const ws = XLSX.utils.json_to_sheet(rows, { header: COLUMNS });
  const wb = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(wb, ws, "Reports");

  if (format === "csv") {
    const csv = XLSX.utils.sheet_to_csv(ws);
    return new NextResponse(csv, {
      headers: {
        "Content-Type": "text/csv",
        "Content-Disposition": `attachment; filename="freedomtree-reports.csv"`,
      },
    });
  }

  const buf = XLSX.write(wb, { type: "buffer", bookType: "xlsx" });
  return new NextResponse(buf, {
    headers: {
      "Content-Type": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      "Content-Disposition": `attachment; filename="freedomtree-reports.xlsx"`,
    },
  });
}
