import { NextRequest } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth/nextAuthOptions";
import { verifyAccessToken } from "@/lib/auth/jwt";
import type { Role } from "@prisma/client";

export interface AuthIdentity {
  userId: string;
  role: Role;
  name: string;
  position: string;
  community: string | null;
}

/**
 * Resolves the caller's identity from either a mobile Bearer JWT or a
 * dashboard NextAuth session cookie, so route handlers don't need to know
 * which client called them.
 */
export async function requireAuth(req: NextRequest): Promise<AuthIdentity | null> {
  const authHeader = req.headers.get("authorization");
  if (authHeader?.startsWith("Bearer ")) {
    try {
      const claims = verifyAccessToken(authHeader.slice("Bearer ".length));
      return { userId: claims.sub, role: claims.role, name: claims.name, position: claims.position, community: claims.community ?? null };
    } catch {
      return null;
    }
  }

  const session = await getServerSession(authOptions);
  if (session?.user) {
    return {
      userId: session.user.id,
      role: session.user.role,
      name: session.user.name ?? "",
      position: session.user.position ?? "",
      community: session.user.community ?? null,
    };
  }

  return null;
}
