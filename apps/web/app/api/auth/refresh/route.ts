import { NextRequest, NextResponse } from "next/server";
import { rotateRefreshToken, signAccessToken } from "@/lib/auth/jwt";

export async function POST(req: NextRequest) {
  const body = await req.json().catch(() => null);
  const refreshToken = body?.refreshToken;

  if (typeof refreshToken !== "string") {
    return NextResponse.json({ error: "refreshToken is required" }, { status: 400 });
  }

  const result = await rotateRefreshToken(refreshToken);
  if (!result) {
    return NextResponse.json({ error: "Invalid or expired refresh token" }, { status: 401 });
  }

  const accessToken = signAccessToken(result.user);

  return NextResponse.json({ accessToken, refreshToken: result.refreshToken });
}
