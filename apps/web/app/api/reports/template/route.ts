import { NextRequest, NextResponse } from "next/server";
import * as XLSX from "xlsx";
import { requireAuth } from "@/lib/auth/requireAuth";

const HEADERS = [
  "reportingMonth", "community", "submittedByName", "submittedByPosition", "dateSubmitted",
  "pregnantWomenCount", "deliveriesTotal", "deliveriesAtFacility", "deliveriesAtHome",
  "maternalDeaths", "placeOfDeath", "placeOfDeathOtherNote", "suspectedMaternalCause",
  "liveBirths", "infantDeathsTotal", "infantDeathsWithin24h", "infantDeathsWithin1Month",
  "infantDeathsWithin12Months", "infantDeathCauses", "infantDeathCausesOtherNote",
  "keyChallenges", "actionsTaken", "additionalComments",
];

const NOTES: Record<string, string> = {
  reportingMonth: "YYYY-MM format e.g. 2026-06",
  community: "Community or district name",
  submittedByName: "Full name of the reporter",
  submittedByPosition: "e.g. Community Health Worker",
  dateSubmitted: "YYYY-MM-DD format e.g. 2026-06-15",
  pregnantWomenCount: "Integer",
  deliveriesTotal: "Integer",
  deliveriesAtFacility: "Integer",
  deliveriesAtHome: "Integer",
  maternalDeaths: "Integer",
  placeOfDeath: "Comma-separated: HEALTH_FACILITY, HOME, OTHER, NOT_APPLICABLE",
  placeOfDeathOtherNote: "Optional text if OTHER selected",
  suspectedMaternalCause: "Optional free text",
  liveBirths: "Integer",
  infantDeathsTotal: "Integer",
  infantDeathsWithin24h: "Integer",
  infantDeathsWithin1Month: "Integer",
  infantDeathsWithin12Months: "Integer",
  infantDeathCauses: "Comma-separated: LACK_OF_SKILLED_BIRTH_ATTENDANT, DELAY_ACCESSING_HEALTH_FACILITY, LACK_OF_TRANSPORTATION_POOR_ROAD, POOR_NUTRITION, BAD_CULTURAL_PRACTICES, OTHER, NOT_APPLICABLE",
  infantDeathCausesOtherNote: "Optional text if OTHER selected",
  keyChallenges: "Free text",
  actionsTaken: "Free text",
  additionalComments: "Free text",
};

const EXAMPLE: Record<string, string | number> = {
  reportingMonth: "2026-06",
  community: "Bo Town",
  submittedByName: "Mohamed Sesay",
  submittedByPosition: "Community Health Worker",
  dateSubmitted: "2026-06-30",
  pregnantWomenCount: 15,
  deliveriesTotal: 10,
  deliveriesAtFacility: 7,
  deliveriesAtHome: 3,
  maternalDeaths: 0,
  placeOfDeath: "NOT_APPLICABLE",
  placeOfDeathOtherNote: "",
  suspectedMaternalCause: "",
  liveBirths: 9,
  infantDeathsTotal: 1,
  infantDeathsWithin24h: 1,
  infantDeathsWithin1Month: 0,
  infantDeathsWithin12Months: 0,
  infantDeathCauses: "LACK_OF_SKILLED_BIRTH_ATTENDANT",
  infantDeathCausesOtherNote: "",
  keyChallenges: "Limited transport to clinic",
  actionsTaken: "Community awareness session held",
  additionalComments: "",
};

export async function GET(req: NextRequest) {
  const identity = await requireAuth(req);
  if (!identity) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const format = new URL(req.url).searchParams.get("format") === "csv" ? "csv" : "xlsx";

  const ws = XLSX.utils.aoa_to_sheet([
    HEADERS,
    HEADERS.map((h) => NOTES[h] ?? ""),
    HEADERS.map((h) => EXAMPLE[h] ?? ""),
  ]);

  // Style row 2 (index 1) as notes in grey — set cell types so Excel shows it correctly
  for (let c = 0; c < HEADERS.length; c++) {
    const addr = XLSX.utils.encode_cell({ r: 1, c });
    if (ws[addr]) ws[addr].t = "s";
  }

  ws["!cols"] = HEADERS.map(() => ({ wch: 28 }));

  const wb = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(wb, ws, "Template");

  if (format === "csv") {
    const csv = XLSX.utils.sheet_to_csv(ws);
    return new NextResponse(csv, {
      headers: {
        "Content-Type": "text/csv",
        "Content-Disposition": `attachment; filename="freedomtree-report-template.csv"`,
      },
    });
  }

  const buf = XLSX.write(wb, { type: "buffer", bookType: "xlsx" });
  return new NextResponse(buf, {
    headers: {
      "Content-Type": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      "Content-Disposition": `attachment; filename="freedomtree-report-template.xlsx"`,
    },
  });
}
