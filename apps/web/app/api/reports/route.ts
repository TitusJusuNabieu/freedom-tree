import { NextRequest, NextResponse } from "next/server";
import { Prisma } from "@prisma/client";
import { prisma } from "@/lib/prisma";
import { requireAuth } from "@/lib/auth/requireAuth";
import { reportSchema } from "@freedomtree/shared";

/**
 * Idempotent upsert keyed on clientId — this is the ONLY write path mobile
 * uses, for both initial submission and later edits/retries. See
 * docs/form-field-mapping.md and the plan doc for the dedup contract.
 */
export async function POST(req: NextRequest) {
  const identity = await requireAuth(req);
  if (!identity) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  if (!["FIELD_WORKER", "SUPER_ADMIN"].includes(identity.role)) {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  const body = await req.json().catch(() => null);
  const parsed = reportSchema.safeParse(body);
  if (!parsed.success) {
    return NextResponse.json({ error: "Invalid report payload", issues: parsed.error.issues }, { status: 400 });
  }
  const data = parsed.data;
  const submittedById = identity.userId;

  try {
    const report = await prisma.report.upsert({
      where: { clientId: data.clientId },
      create: {
        ...data,
        submittedById,
        origin: "MOBILE",
      },
      update: {
        ...data,
        submittedById,
      },
    });
    return NextResponse.json(report, { status: 201 });
  } catch (err) {
    if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002") {
      // Unique constraint hit on (community, reportingMonth) for a DIFFERENT clientId.
      const existing = await prisma.report.findUnique({
        where: {
          one_report_per_community_per_month: {
            community: data.community,
            reportingMonth: data.reportingMonth,
          },
        },
      });
      return NextResponse.json(
        { error: "A report for this community and month already exists", existing },
        { status: 409 }
      );
    }
    throw err;
  }
}

export async function GET(req: NextRequest) {
  const identity = await requireAuth(req);
  if (!identity) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { searchParams } = new URL(req.url);
  const month = searchParams.get("month");
  const community = searchParams.get("community");
  const dateFrom = searchParams.get("dateFrom");
  const dateTo = searchParams.get("dateTo");
  const page = Math.max(1, parseInt(searchParams.get("page") ?? "1", 10) || 1);
  const pageSize = Math.min(100, Math.max(1, parseInt(searchParams.get("pageSize") ?? "20", 10) || 20));

  const where: Prisma.ReportWhereInput = {};
  if (identity.role === "FIELD_WORKER") {
    where.submittedById = identity.userId;
  } else if (identity.role === "SUPERVISOR" && identity.community) {
    where.community = identity.community;
  }
  // ADMIN, SUPER_ADMIN, DATA_ANALYST: see all — no additional filter
  if (community) where.community = community;
  if (month) where.reportingMonth = new Date(month);
  if (dateFrom || dateTo) {
    where.reportingMonth = {
      ...(typeof where.reportingMonth === "object" ? where.reportingMonth : {}),
      ...(dateFrom ? { gte: new Date(dateFrom) } : {}),
      ...(dateTo ? { lte: new Date(dateTo) } : {}),
    };
  }

  const [reports, total] = await Promise.all([
    prisma.report.findMany({
      where,
      orderBy: { reportingMonth: "desc" },
      skip: (page - 1) * pageSize,
      take: pageSize,
    }),
    prisma.report.count({ where }),
  ]);

  return NextResponse.json({ reports, total, page, pageSize });
}
