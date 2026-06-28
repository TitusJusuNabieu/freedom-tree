import jwt from "jsonwebtoken";
import { randomBytes, createHash } from "crypto";
import { prisma } from "@/lib/prisma";
import type { Role, User } from "@prisma/client";

const ACCESS_TOKEN_TTL = "15m";
const REFRESH_TOKEN_TTL_MS = 30 * 24 * 60 * 60 * 1000; // 30 days

export interface AccessTokenClaims {
  sub: string;
  role: Role;
  name: string;
  position: string;
  community: string | null;
}

function getAccessSecret(): string {
  const secret = process.env.JWT_ACCESS_SECRET;
  if (!secret) throw new Error("JWT_ACCESS_SECRET is not set");
  return secret;
}

export function signAccessToken(user: User): string {
  const claims: AccessTokenClaims = {
    sub: user.id,
    role: user.role,
    name: user.name,
    position: user.position,
    community: user.community ?? null,
  };
  return jwt.sign(claims, getAccessSecret(), { expiresIn: ACCESS_TOKEN_TTL });
}

export function verifyAccessToken(token: string): AccessTokenClaims {
  return jwt.verify(token, getAccessSecret()) as AccessTokenClaims;
}

function hashToken(token: string): string {
  return createHash("sha256").update(token).digest("hex");
}

export async function issueRefreshToken(userId: string): Promise<string> {
  const raw = randomBytes(40).toString("hex");
  await prisma.refreshToken.create({
    data: {
      token: hashToken(raw),
      userId,
      expiresAt: new Date(Date.now() + REFRESH_TOKEN_TTL_MS),
    },
  });
  return raw;
}

/** Verifies a raw refresh token, rotates it (revoke old, issue new), and returns the new raw token + user. */
export async function rotateRefreshToken(rawToken: string) {
  const hashed = hashToken(rawToken);
  const existing = await prisma.refreshToken.findUnique({
    where: { token: hashed },
    include: { user: true },
  });

  if (!existing || existing.revokedAt || existing.expiresAt < new Date()) {
    return null;
  }

  await prisma.refreshToken.update({
    where: { id: existing.id },
    data: { revokedAt: new Date() },
  });

  const newRawToken = await issueRefreshToken(existing.userId);
  return { user: existing.user, refreshToken: newRawToken };
}

export async function revokeRefreshToken(rawToken: string): Promise<void> {
  const hashed = hashToken(rawToken);
  await prisma.refreshToken.updateMany({
    where: { token: hashed, revokedAt: null },
    data: { revokedAt: new Date() },
  });
}
