import { NextRequest, NextResponse } from "next/server";
import { Prisma } from "@prisma/client";
import { prisma } from "@/lib/prisma";
import { requireAuth } from "@/lib/auth/requireAuth";

const userSelect = {
  id: true,
  username: true,
  name: true,
  position: true,
  role: true,
  community: true,
  avatarUrl: true,
  active: true,
  createdAt: true,
  updatedAt: true,
} satisfies Prisma.UserSelect;

export async function GET(req: NextRequest) {
  const identity = await requireAuth(req);
  if (!identity) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const user = await prisma.user.findUnique({ where: { id: identity.userId }, select: userSelect });
  if (!user) return NextResponse.json({ error: "User not found" }, { status: 404 });

  return NextResponse.json(user);
}

export async function PUT(req: NextRequest) {
  const identity = await requireAuth(req);
  if (!identity) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const body = await req.json().catch(() => null);
  if (!body) return NextResponse.json({ error: "Invalid JSON" }, { status: 400 });

  const updateData: Prisma.UserUpdateInput = {};
  if (typeof body.name === "string") updateData.name = body.name;
  if (typeof body.position === "string") updateData.position = body.position;
  if ("community" in body) updateData.community = body.community ?? null;

  const user = await prisma.user.update({
    where: { id: identity.userId },
    data: updateData,
    select: userSelect,
  });

  return NextResponse.json(user);
}
