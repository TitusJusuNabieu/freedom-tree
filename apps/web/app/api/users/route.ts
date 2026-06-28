import { NextRequest, NextResponse } from "next/server";
import bcrypt from "bcryptjs";
import { Prisma } from "@prisma/client";
import { prisma } from "@/lib/prisma";
import { requireAuth } from "@/lib/auth/requireAuth";

// Omit passwordHash from all responses
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
  if (identity.role !== "SUPER_ADMIN") return NextResponse.json({ error: "Forbidden" }, { status: 403 });

  const { searchParams } = new URL(req.url);
  const page = Math.max(1, parseInt(searchParams.get("page") ?? "1", 10) || 1);
  const pageSize = Math.min(100, Math.max(1, parseInt(searchParams.get("pageSize") ?? "20", 10) || 20));
  const role = searchParams.get("role");
  const activeParam = searchParams.get("active");
  const search = searchParams.get("search");

  const where: Prisma.UserWhereInput = {};
  if (role) where.role = role as Prisma.EnumRoleFilter;
  if (activeParam !== null) where.active = activeParam === "true";
  if (search) {
    where.OR = [
      { name: { contains: search, mode: "insensitive" } },
      { username: { contains: search, mode: "insensitive" } },
    ];
  }

  const [users, total] = await Promise.all([
    prisma.user.findMany({
      where,
      select: userSelect,
      orderBy: { createdAt: "desc" },
      skip: (page - 1) * pageSize,
      take: pageSize,
    }),
    prisma.user.count({ where }),
  ]);

  return NextResponse.json({ users, total, page, pageSize });
}

export async function POST(req: NextRequest) {
  const identity = await requireAuth(req);
  if (!identity) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  if (identity.role !== "SUPER_ADMIN") return NextResponse.json({ error: "Forbidden" }, { status: 403 });

  const body = await req.json().catch(() => null);
  if (!body) return NextResponse.json({ error: "Invalid JSON" }, { status: 400 });

  const { username, password, name, position, role, community } = body;
  if (
    typeof username !== "string" ||
    typeof password !== "string" ||
    typeof name !== "string" ||
    typeof position !== "string" ||
    typeof role !== "string"
  ) {
    return NextResponse.json({ error: "username, password, name, position, and role are required" }, { status: 400 });
  }

  const existing = await prisma.user.findUnique({ where: { username } });
  if (existing) return NextResponse.json({ error: "Username already exists" }, { status: 409 });

  const passwordHash = await bcrypt.hash(password, 10);

  const user = await prisma.user.create({
    data: {
      username,
      passwordHash,
      name,
      position,
      role: role as Prisma.EnumRoleFieldUpdateOperationsInput["set"],
      community: community ?? null,
    },
    select: userSelect,
  });

  return NextResponse.json(user, { status: 201 });
}
