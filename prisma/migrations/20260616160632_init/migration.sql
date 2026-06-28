-- CreateEnum
CREATE TYPE "Role" AS ENUM ('FIELD_WORKER', 'ADMIN');

-- CreateEnum
CREATE TYPE "PlaceOfDeath" AS ENUM ('HEALTH_FACILITY', 'HOME', 'OTHER', 'NOT_APPLICABLE');

-- CreateEnum
CREATE TYPE "InfantDeathCause" AS ENUM ('LACK_OF_SKILLED_BIRTH_ATTENDANT', 'DELAY_ACCESSING_HEALTH_FACILITY', 'LACK_OF_TRANSPORTATION_POOR_ROAD', 'POOR_NUTRITION', 'BAD_CULTURAL_PRACTICES', 'OTHER', 'NOT_APPLICABLE');

-- CreateEnum
CREATE TYPE "SyncOrigin" AS ENUM ('MOBILE', 'WEB');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "position" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'FIELD_WORKER',
    "community" TEXT,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RefreshToken" (
    "id" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "revokedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RefreshToken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Report" (
    "id" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "reportingMonth" TIMESTAMP(3) NOT NULL,
    "community" TEXT NOT NULL,
    "submittedByName" TEXT NOT NULL,
    "submittedByPosition" TEXT NOT NULL,
    "dateSubmitted" TIMESTAMP(3) NOT NULL,
    "pregnantWomenCount" INTEGER NOT NULL,
    "deliveriesTotal" INTEGER NOT NULL,
    "deliveriesAtFacility" INTEGER NOT NULL,
    "deliveriesAtHome" INTEGER NOT NULL,
    "maternalDeaths" INTEGER NOT NULL,
    "placeOfDeath" "PlaceOfDeath"[],
    "placeOfDeathOtherNote" TEXT,
    "suspectedMaternalCause" TEXT,
    "liveBirths" INTEGER NOT NULL,
    "infantDeathsTotal" INTEGER NOT NULL,
    "infantDeathsWithin24h" INTEGER NOT NULL,
    "infantDeathsWithin1Month" INTEGER NOT NULL,
    "infantDeathsWithin12Months" INTEGER NOT NULL,
    "infantDeathCauses" "InfantDeathCause"[],
    "infantDeathCausesOtherNote" TEXT,
    "keyChallenges" TEXT NOT NULL,
    "actionsTaken" TEXT NOT NULL,
    "additionalComments" TEXT NOT NULL,
    "submittedById" TEXT NOT NULL,
    "origin" "SyncOrigin" NOT NULL DEFAULT 'MOBILE',
    "clientCreatedAt" TIMESTAMP(3) NOT NULL,
    "clientUpdatedAt" TIMESTAMP(3) NOT NULL,
    "serverReceivedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "serverUpdatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Report_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "RefreshToken_token_key" ON "RefreshToken"("token");

-- CreateIndex
CREATE INDEX "RefreshToken_userId_idx" ON "RefreshToken"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Report_clientId_key" ON "Report"("clientId");

-- CreateIndex
CREATE INDEX "Report_reportingMonth_idx" ON "Report"("reportingMonth");

-- CreateIndex
CREATE INDEX "Report_community_idx" ON "Report"("community");

-- CreateIndex
CREATE INDEX "Report_submittedById_idx" ON "Report"("submittedById");

-- CreateIndex
CREATE UNIQUE INDEX "Report_community_reportingMonth_key" ON "Report"("community", "reportingMonth");

-- AddForeignKey
ALTER TABLE "RefreshToken" ADD CONSTRAINT "RefreshToken_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_submittedById_fkey" FOREIGN KEY ("submittedById") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
