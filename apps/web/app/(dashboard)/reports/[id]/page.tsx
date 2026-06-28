import { notFound } from "next/navigation";
import { prisma } from "@/lib/prisma";
import { ReportEditForm } from "@/components/ReportEditForm";

export default async function ReportDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const report = await prisma.report.findUnique({ where: { id } });
  if (!report) notFound();

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
      <ReportEditForm report={report} />
    </div>
  );
}
