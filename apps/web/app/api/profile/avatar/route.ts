import { NextRequest, NextResponse } from "next/server";
import fs from "fs/promises";
import path from "path";
import { prisma } from "@/lib/prisma";
import { requireAuth } from "@/lib/auth/requireAuth";

const AVATARS_DIR = path.join(process.cwd(), "public", "uploads", "avatars");
const MAX_SIZE = 2 * 1024 * 1024; // 2MB

function extFromMime(mime: string): string | null {
  if (mime === "image/jpeg" || mime === "image/jpg") return "jpg";
  if (mime === "image/png") return "png";
  if (mime === "image/gif") return "gif";
  if (mime === "image/webp") return "webp";
  return null;
}

export async function POST(req: NextRequest) {
  const identity = await requireAuth(req);
  if (!identity) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const formData = await req.formData().catch(() => null);
  if (!formData) return NextResponse.json({ error: "Invalid form data" }, { status: 400 });

  const file = formData.get("file") as File | null;
  if (!file) return NextResponse.json({ error: "No file provided" }, { status: 400 });

  if (!file.type.startsWith("image/")) {
    return NextResponse.json({ error: "File must be an image" }, { status: 400 });
  }

  const ext = extFromMime(file.type);
  if (!ext) return NextResponse.json({ error: "Unsupported image type" }, { status: 400 });

  if (file.size > MAX_SIZE) {
    return NextResponse.json({ error: "File must be under 2MB" }, { status: 400 });
  }

  const bytes = await file.arrayBuffer();
  const buffer = Buffer.from(bytes);

  await fs.mkdir(AVATARS_DIR, { recursive: true });

  const filename = `${identity.userId}.${ext}`;
  await fs.writeFile(path.join(AVATARS_DIR, filename), buffer);

  const avatarUrl = `/uploads/avatars/${filename}`;
  await prisma.user.update({ where: { id: identity.userId }, data: { avatarUrl } });

  return NextResponse.json({ avatarUrl });
}
