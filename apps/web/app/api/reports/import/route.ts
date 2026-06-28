import { NextRequest, NextResponse } from "next/server";
import * as XLSX from "xlsx";
import { prisma } from "@/lib/prisma";
import { requireAuth } from "@/lib/auth/requireAuth";
import { reportSchema } from "@freedomtree/shared";
import { randomUUID } from "crypto";

function parseEnumArray(raw: string): string[] {
  if (!raw) return [];
  return raw.split(",").map((s) => s.trim().toUpperCase()).filter(Boolean);
}

function toInt(v: unknown): number {
  const n = parseInt(String(v ?? "0"), 10);
  return isNaN(n) ? 0 : n;
}

function parseDate(v: unknown): Date | null {
  if (!v) return null;
  const d = new Date(String(v));
  return isNaN(d.getTime()) ? null : d;
}

export async function POST(req: NextRequest) {
  const identity = await requireAuth(req);
  if (!identity || identity.role !== "ADMIN") {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  const formData = await req.formData();
  const file = formData.get("file") as File | null;
  if (!file) return NextResponse.json({ error: "No file provided" }, { status: 400 });

  const arrayBuffer = await file.arrayBuffer();
  const workbook = XLSX.read(arrayBuffer, { type: "array" });
  const sheet = workbook.Sheets[workbook.SheetNames[0]];
  const rawRows = XLSX.utils.sheet_to_json<Record<string, unknown>>(sheet, { defval: "" });

  // Skip rows where the first cell looks like the notes row (not a date)
  const rows = rawRows.filter((r) => {
    const month = String(r.reportingMonth ?? "");
    return /^\d{4}-\d{2}/.test(month);
  });

  const results: { row: number; status: "ok" | "error"; error?: string }[] = [];
  let successCount = 0;

  for (let i = 0; i < rows.length; i++) {
    const r = rows[i];
    const rowNum = i + 3; // header=1, notes=2, data starts at 3

    const reportingMonthStr = String(r.reportingMonth ?? "");
    const reportingMonth = parseDate(reportingMonthStr + "-01") ?? parseDate(reportingMonthStr);
    if (!reportingMonth) {
      results.push({ row: rowNum, status: "error", error: "Invalid reportingMonth format" });
      continue;
    }

    const dateSubmitted = parseDate(r.dateSubmitted) ?? new Date();

    const payload = {
      clientId: randomUUID(),
      reportingMonth,
      community: String(r.community ?? "").trim(),
      submittedByName: String(r.submittedByName ?? "").trim(),
      submittedByPosition: String(r.submittedByPosition ?? "").trim(),
      dateSubmitted,
      pregnantWomenCount: toInt(r.pregnantWomenCount),
      deliveriesTotal: toInt(r.deliveriesTotal),
      deliveriesAtFacility: toInt(r.deliveriesAtFacility),
      deliveriesAtHome: toInt(r.deliveriesAtHome),
      maternalDeaths: toInt(r.maternalDeaths),
      placeOfDeath: parseEnumArray(String(r.placeOfDeath ?? "")),
      placeOfDeathOtherNote: String(r.placeOfDeathOtherNote ?? "") || undefined,
      suspectedMaternalCause: String(r.suspectedMaternalCause ?? "") || undefined,
      liveBirths: toInt(r.liveBirths),
      infantDeathsTotal: toInt(r.infantDeathsTotal),
      infantDeathsWithin24h: toInt(r.infantDeathsWithin24h),
      infantDeathsWithin1Month: toInt(r.infantDeathsWithin1Month),
      infantDeathsWithin12Months: toInt(r.infantDeathsWithin12Months),
      infantDeathCauses: parseEnumArray(String(r.infantDeathCauses ?? "")),
      infantDeathCausesOtherNote: String(r.infantDeathCausesOtherNote ?? "") || undefined,
      keyChallenges: String(r.keyChallenges ?? ""),
      actionsTaken: String(r.actionsTaken ?? ""),
      additionalComments: String(r.additionalComments ?? ""),
      clientCreatedAt: new Date(),
      clientUpdatedAt: new Date(),
    };

    const validation = reportSchema.safeParse(payload);
    if (!validation.success) {
      results.push({ row: rowNum, status: "error", error: validation.error.issues[0]?.message ?? "Validation failed" });
      continue;
    }

    try {
      await prisma.report.upsert({
        where: { clientId: payload.clientId },
        create: {
          ...validation.data,
          submittedById: identity.userId,
          origin: "WEB",
        },
        update: {
          ...validation.data,
          origin: "WEB",
        },
      });
      results.push({ row: rowNum, status: "ok" });
      successCount++;
    } catch (err) {
      const message = err instanceof Error ? err.message : "Database error";
      results.push({ row: rowNum, status: "error", error: message });
    }
  }

  return NextResponse.json({
    total: rows.length,
    imported: successCount,
    errors: results.filter((r) => r.status === "error"),
  });
}
