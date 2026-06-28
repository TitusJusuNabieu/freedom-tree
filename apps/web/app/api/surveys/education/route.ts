import { NextRequest, NextResponse } from "next/server";
import type { Prisma } from "@prisma/client";
import { prisma } from "@/lib/prisma";
import { requireAuth } from "@/lib/auth/requireAuth";
import { z } from "zod";

const schema = z.object({
  clientId: z.string().uuid(),
  enumeratorName: z.string().min(1),
  surveyDate: z.string().datetime(),
  communityOrSchool: z.string().min(1),
  district: z.string().min(1),
  respondentName: z.string().min(1),
  respondentCategory: z.string().min(1),
  sex: z.string().min(1),
  answers: z.record(z.unknown()),
  clientCreatedAt: z.string().datetime(),
  clientUpdatedAt: z.string().datetime(),
});

export async function POST(req: NextRequest) {
  const identity = await requireAuth(req);
  if (!identity) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  if (!["FIELD_WORKER", "SUPER_ADMIN"].includes(identity.role)) {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  const parsed = schema.safeParse(await req.json());
  if (!parsed.success) {
    return NextResponse.json({ error: parsed.error.issues[0]?.message }, { status: 422 });
  }
  const d = parsed.data;

  const survey = await prisma.educationSurvey.upsert({
    where: { clientId: d.clientId },
    create: {
      clientId: d.clientId,
      enumeratorName: d.enumeratorName,
      surveyDate: new Date(d.surveyDate),
      communityOrSchool: d.communityOrSchool,
      district: d.district,
      respondentName: d.respondentName,
      respondentCategory: d.respondentCategory,
      sex: d.sex,
      answers: d.answers as Prisma.InputJsonValue,
      submittedById: identity.userId,
      origin: "MOBILE",
      clientCreatedAt: new Date(d.clientCreatedAt),
      clientUpdatedAt: new Date(d.clientUpdatedAt),
    },
    update: {
      enumeratorName: d.enumeratorName,
      surveyDate: new Date(d.surveyDate),
      communityOrSchool: d.communityOrSchool,
      district: d.district,
      respondentName: d.respondentName,
      respondentCategory: d.respondentCategory,
      sex: d.sex,
      answers: d.answers as Prisma.InputJsonValue,
      clientUpdatedAt: new Date(d.clientUpdatedAt),
    },
  });
  return NextResponse.json({ id: survey.id }, { status: 201 });
}

export async function GET(req: NextRequest) {
  const identity = await requireAuth(req);
  if (!identity) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const allowedRoles = ["ADMIN", "SUPER_ADMIN", "DATA_ANALYST", "SUPERVISOR", "FIELD_WORKER"];
  if (!allowedRoles.includes(identity.role)) {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  const page = Math.max(1, parseInt(new URL(req.url).searchParams.get("page") ?? "1", 10));
  const PAGE_SIZE = 20;

  const where: Prisma.EducationSurveyWhereInput = {};
  if (identity.role === "FIELD_WORKER") {
    where.submittedById = identity.userId;
  } else if (identity.role === "SUPERVISOR" && identity.community) {
    where.communityOrSchool = identity.community;
  }

  const [surveys, total] = await Promise.all([
    prisma.educationSurvey.findMany({ where, orderBy: { surveyDate: "desc" }, skip: (page - 1) * PAGE_SIZE, take: PAGE_SIZE }),
    prisma.educationSurvey.count({ where }),
  ]);
  return NextResponse.json({ surveys, total, page, pageSize: PAGE_SIZE });
}
