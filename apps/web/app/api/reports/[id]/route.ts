import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireAuth } from "@/lib/auth/requireAuth";
import { reportPatchSchema } from "@freedomtree/shared";

export async function GET(req: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  const identity = await requireAuth(req);
  if (!identity) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { id } = await params;
  const report = await prisma.report.findUnique({ where: { id } });
  if (!report) {
    return NextResponse.json({ error: "Not found" }, { status: 404 });
  }
  if (identity.role !== "ADMIN" && report.submittedById !== identity.userId) {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  return NextResponse.json(report);
}

/** Dashboard-side correction path — distinct from mobile's upsert-by-clientId POST. */
export async function PATCH(req: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  const identity = await requireAuth(req);
  if (!identity || identity.role !== "ADMIN") {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  const { id } = await params;
  const body = await req.json().catch(() => null);
  const parsed = reportPatchSchema.safeParse(body);
  if (!parsed.success) {
    return NextResponse.json({ error: "Invalid report payload", issues: parsed.error.issues }, { status: 400 });
  }

  const report = await prisma.report.update({
    where: { id },
    data: { ...parsed.data, origin: "WEB" },
  });

  return NextResponse.json(report);
}
