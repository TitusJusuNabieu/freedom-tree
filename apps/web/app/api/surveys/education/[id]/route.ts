import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireAuth } from "@/lib/auth/requireAuth";

export async function GET(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const identity = await requireAuth(req);
  if (!identity) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { id } = await params;
  const survey = await prisma.educationSurvey.findUnique({ where: { id } });
  if (!survey) {
    return NextResponse.json({ error: "Not found" }, { status: 404 });
  }
  return NextResponse.json(survey);
}
