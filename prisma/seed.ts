import { PrismaClient, PlaceOfDeath, InfantDeathCause, Role } from "@prisma/client";
import bcrypt from "bcryptjs";
import { randomUUID } from "crypto";

const prisma = new PrismaClient();

function monthStart(year: number, month: number) {
  return new Date(Date.UTC(year, month, 1));
}

async function main() {
  const passwordHash = await bcrypt.hash("password123", 10);

  const admin = await prisma.user.upsert({
    where: { username: "admin" },
    update: {},
    create: {
      username: "admin",
      passwordHash,
      name: "Aminata Kamara",
      position: "Program Manager",
      role: Role.ADMIN,
    },
  });

  const fieldWorker = await prisma.user.upsert({
    where: { username: "fieldworker1" },
    update: {},
    create: {
      username: "fieldworker1",
      passwordHash,
      name: "Mohamed Sesay",
      position: "Community Health Worker",
      role: Role.FIELD_WORKER,
      community: "Bo Town",
    },
  });

  const communities = ["Bo Town", "Kenema", "Makeni", "Koidu"];
  const now = new Date();

  for (let i = 0; i < 6; i++) {
    const month = monthStart(now.getUTCFullYear(), now.getUTCMonth() - i);
    for (const community of communities) {
      await prisma.report.upsert({
        where: { one_report_per_community_per_month: { community, reportingMonth: month } },
        update: {},
        create: {
          clientId: randomUUID(),
          reportingMonth: month,
          community,
          submittedByName: fieldWorker.name,
          submittedByPosition: fieldWorker.position,
          dateSubmitted: month,

          pregnantWomenCount: 20 + Math.floor(Math.random() * 15),
          deliveriesTotal: 10 + Math.floor(Math.random() * 10),
          deliveriesAtFacility: 7,
          deliveriesAtHome: 3,
          maternalDeaths: Math.random() < 0.2 ? 1 : 0,
          placeOfDeath: Math.random() < 0.2 ? [PlaceOfDeath.HEALTH_FACILITY] : [],
          suspectedMaternalCause: null,

          liveBirths: 10 + Math.floor(Math.random() * 10),
          infantDeathsTotal: Math.random() < 0.3 ? 1 : 0,
          infantDeathsWithin24h: 0,
          infantDeathsWithin1Month: Math.random() < 0.3 ? 1 : 0,
          infantDeathsWithin12Months: 0,

          infantDeathCauses: Math.random() < 0.3 ? [InfantDeathCause.POOR_NUTRITION] : [],

          keyChallenges: "Limited transportation to the nearest health facility.",
          actionsTaken: "Coordinated with district health office for outreach visit.",
          additionalComments: "",

          submittedById: fieldWorker.id,
          clientCreatedAt: month,
          clientUpdatedAt: month,
        },
      });
    }
  }

  console.log("Seeded users:", {
    admin: admin.username,
    fieldWorker: fieldWorker.username,
  });
  console.log("Login with password: password123");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
