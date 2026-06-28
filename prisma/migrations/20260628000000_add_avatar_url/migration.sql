-- AlterEnum: add new role values that were added to schema.prisma after the init migration
ALTER TYPE "Role" ADD VALUE IF NOT EXISTS 'SUPERVISOR';
ALTER TYPE "Role" ADD VALUE IF NOT EXISTS 'DATA_ANALYST';
ALTER TYPE "Role" ADD VALUE IF NOT EXISTS 'SUPER_ADMIN';

-- AlterTable: add avatarUrl column to User
ALTER TABLE "User" ADD COLUMN IF NOT EXISTS "avatarUrl" TEXT;
