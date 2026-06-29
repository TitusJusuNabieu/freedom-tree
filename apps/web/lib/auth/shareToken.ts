import jwt from "jsonwebtoken";

export interface ShareTokenClaims {
  type: "donor-share";
  label: string;
  community: string | null; // null = all communities
  expiryDays: number;
}

function secret(): string {
  const s = process.env.JWT_ACCESS_SECRET;
  if (!s) throw new Error("JWT_ACCESS_SECRET is not set");
  return s;
}

export function signShareToken(claims: Omit<ShareTokenClaims, "type">, expiryDays: number): string {
  return jwt.sign(
    { type: "donor-share", ...claims },
    secret(),
    { expiresIn: `${expiryDays}d`, audience: "donor-share" },
  );
}

export function verifyShareToken(token: string): ShareTokenClaims {
  return jwt.verify(token, secret(), { audience: "donor-share" }) as ShareTokenClaims;
}
