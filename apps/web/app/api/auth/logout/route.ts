import { NextRequest, NextResponse } from "next/server";
import { revokeRefreshToken } from "@/lib/auth/jwt";

export async function POST(req: NextRequest) {
  const body = await req.json().catch(() => null);
  const refreshToken = body?.refreshToken;

  if (typeof refreshToken === "string") {
    await revokeRefreshToken(refreshToken);
  }

  return NextResponse.json({ ok: true });
}
