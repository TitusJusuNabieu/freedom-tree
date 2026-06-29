import { notFound } from "next/navigation";
import { getServerSession } from "next-auth";
import { prisma } from "@/lib/prisma";
import { authOptions } from "@/lib/auth/nextAuthOptions";
import { ReportEditForm } from "@/components/ReportEditForm";

const PLACE_LABELS: Record<string, string> = {
  HEALTH_FACILITY: "Health facility", HOME: "Home", OTHER: "Other", NOT_APPLICABLE: "Not applicable",
};
const CAUSE_LABELS: Record<string, string> = {
  LACK_OF_SKILLED_BIRTH_ATTENDANT: "No skilled birth attendant",
  DELAY_ACCESSING_HEALTH_FACILITY: "Delayed access to facility",
  LACK_OF_TRANSPORTATION_POOR_ROAD: "Poor transport / roads",
  POOR_NUTRITION: "Poor nutrition",
  BAD_CULTURAL_PRACTICES: "Bad cultural practices",
  OTHER: "Other",
  NOT_APPLICABLE: "Not applicable",
};

function Row({ label, value }: { label: string; value: React.ReactNode }) {
  return (
    <div className="grid grid-cols-2 gap-4 border-b border-ft-grey-light py-2 text-sm last:border-0">
      <span className="font-medium text-ft-grey-dark">{label}</span>
      <span className="text-ft-grey-darker">{value}</span>
    </div>
  );
}

export default async function ReportDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const [report, session] = await Promise.all([
    prisma.report.findUnique({ where: { id } }),
    getServerSession(authOptions),
  ]);
  if (!report) notFound();

  const role = session?.user?.role;
  const canEdit = role === "ADMIN" || role === "SUPER_ADMIN";

  return (
    <div className="max-w-3xl space-y-6">
      <div>
        <h1 className="text-2xl font-semibold text-ft-grey-darker">
          {report.community} — {report.reportingMonth.toISOString().slice(0, 7)}
        </h1>
        <p className="mt-1 text-sm text-ft-grey-medium">
          Submitted by {report.submittedByName} ({report.submittedByPosition}) on{" "}
          {report.dateSubmitted.toISOString().slice(0, 10)}
        </p>
      </div>

      {canEdit ? (
        <ReportEditForm report={report} />
      ) : (
        <div className="rounded-lg border border-ft-grey-light p-6 space-y-1">
          <p className="mb-4 text-xs font-medium uppercase tracking-wide text-ft-grey-medium">Maternal Health</p>
          <Row label="Pregnant women" value={report.pregnantWomenCount} />
          <Row label="Total deliveries" value={report.deliveriesTotal} />
          <Row label="At facility" value={report.deliveriesAtFacility} />
          <Row label="At home" value={report.deliveriesAtHome} />
          <Row label="Maternal deaths" value={report.maternalDeaths} />
          <Row label="Place of death" value={report.placeOfDeath.map((p) => PLACE_LABELS[p] ?? p).join(", ") || "—"} />
          <Row label="Suspected cause" value={report.suspectedMaternalCause || "—"} />

          <p className="mb-4 mt-6 text-xs font-medium uppercase tracking-wide text-ft-grey-medium">Infant Health</p>
          <Row label="Live births" value={report.liveBirths} />
          <Row label="Infant deaths (total)" value={report.infantDeathsTotal} />
          <Row label="Within 24 h" value={report.infantDeathsWithin24h} />
          <Row label="Within 1 month" value={report.infantDeathsWithin1Month} />
          <Row label="Within 12 months" value={report.infantDeathsWithin12Months} />
          <Row label="Contributing factors" value={report.infantDeathCauses.map((c) => CAUSE_LABELS[c] ?? c).join(", ") || "—"} />

          <p className="mb-4 mt-6 text-xs font-medium uppercase tracking-wide text-ft-grey-medium">Narrative</p>
          <Row label="Key challenges" value={report.keyChallenges || "—"} />
          <Row label="Actions taken" value={report.actionsTaken || "—"} />
          <Row label="Additional comments" value={report.additionalComments || "—"} />
        </div>
      )}
    </div>
  );
}
