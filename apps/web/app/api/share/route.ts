import { NextRequest, NextResponse } from "next/server";
import { requireAuth } from "@/lib/auth/requireAuth";
import { signShareToken } from "@/lib/auth/shareToken";

export async function POST(req: NextRequest) {
  const identity = await requireAuth(req);
  if (!identity) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  if (identity.role !== "ADMIN" && identity.role !== "SUPER_ADMIN") {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  const { label, community, expiryDays } = await req.json() as {
    label: string;
    community: string | null;
    expiryDays: number;
  };

  if (!label?.trim()) return NextResponse.json({ error: "label is required" }, { status: 400 });
  const days = Math.min(Math.max(Number(expiryDays) || 90, 1), 365);

  const token = signShareToken({ label: label.trim(), community: community ?? null, expiryDays: days }, days);
  return NextResponse.json({ token });
}
