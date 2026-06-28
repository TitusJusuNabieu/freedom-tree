import { NextRequest, NextResponse } from "next/server";
import { verifyCredentials } from "@/lib/auth/verifyCredentials";
import { signAccessToken, issueRefreshToken } from "@/lib/auth/jwt";

export async function POST(req: NextRequest) {
  const body = await req.json().catch(() => null);
  const username = body?.username;
  const password = body?.password;

  if (typeof username !== "string" || typeof password !== "string") {
    return NextResponse.json({ error: "username and password are required" }, { status: 400 });
  }

  const user = await verifyCredentials(username, password);
  if (!user) {
    return NextResponse.json({ error: "Invalid username or password" }, { status: 401 });
  }

  const accessToken = signAccessToken(user);
  const refreshToken = await issueRefreshToken(user.id);

  return NextResponse.json({
    accessToken,
    refreshToken,
    user: {
      id: user.id,
      username: user.username,
      name: user.name,
      position: user.position,
      role: user.role,
      community: user.community,
      avatarUrl: user.avatarUrl,
    },
  });
}
