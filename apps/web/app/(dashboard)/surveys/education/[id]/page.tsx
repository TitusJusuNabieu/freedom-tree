import Link from "next/link";
import { notFound } from "next/navigation";
import { prisma } from "@/lib/prisma";

function renderAnswerValue(value: unknown): React.ReactNode {
  if (value === null || value === undefined) return <span className="text-ft-grey-medium">—</span>;
  if (typeof value === "boolean") return value ? "Yes" : "No";
  if (typeof value === "number" || typeof value === "string") return String(value);
  if (Array.isArray(value)) {
    if (value.length === 0) return <span className="text-ft-grey-medium">None</span>;
    return (
      <ul className="list-disc pl-4">
        {value.map((item, i) => (
          <li key={i}>{renderAnswerValue(item)}</li>
        ))}
      </ul>
    );
  }
  if (typeof value === "object") {
    return (
      <dl className="space-y-1 pl-4">
        {Object.entries(value as Record<string, unknown>).map(([k, v]) => (
          <div key={k} className="grid grid-cols-[auto,1fr] gap-x-4">
            <dt className="font-medium text-ft-grey-dark capitalize">{k.replace(/_/g, " ")}</dt>
            <dd>{renderAnswerValue(v)}</dd>
          </div>
        ))}
      </dl>
    );
  }
  return String(value);
}

export default async function EducationSurveyDetailPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const survey = await prisma.educationSurvey.findUnique({ where: { id } });
  if (!survey) notFound();

  const answers = survey.answers as Record<string, unknown>;

  return (
    <div className="max-w-3xl space-y-8">
      <div>
        <Link
          href="/surveys/education"
          className="text-sm text-ft-orange hover:text-ft-dark-orange"
        >
          ← Back to Education Surveys
        </Link>
        <h1 className="mt-3 text-2xl font-semibold text-ft-grey-darker">
          Education Survey — {survey.communityOrSchool}
        </h1>
        <p className="mt-1 text-sm text-ft-grey-medium">
          {survey.surveyDate.toISOString().slice(0, 10)}
        </p>
      </div>

      <section className="rounded-lg border border-ft-grey-light p-6">
        <h2 className="mb-4 text-lg font-semibold text-ft-grey-darker">Survey Metadata</h2>
        <dl className="grid grid-cols-1 gap-3 sm:grid-cols-2">
          {(
            [
              ["Enumerator", survey.enumeratorName],
              ["Date", survey.surveyDate.toISOString().slice(0, 10)],
              ["Community / School", survey.communityOrSchool],
              ["District", survey.district],
              ["Respondent", survey.respondentName],
              [
                "Category",
                survey.respondentCategory
                  .split("_")
                  .map((w) => w.charAt(0).toUpperCase() + w.slice(1))
                  .join(" "),
              ],
              ["Sex", survey.sex.charAt(0).toUpperCase() + survey.sex.slice(1)],
            ] as [string, string][]
          ).map(([label, val]) => (
            <div key={label}>
              <dt className="text-xs font-medium uppercase tracking-wide text-ft-grey-medium">
                {label}
              </dt>
              <dd className="mt-0.5 text-sm text-ft-grey-darker">{val}</dd>
            </div>
          ))}
        </dl>
      </section>

      {Object.entries(answers).map(([sectionKey, sectionValue]) => (
        <section key={sectionKey} className="rounded-lg border border-ft-grey-light p-6">
          <h2 className="mb-4 text-lg font-semibold text-ft-grey-darker capitalize">
            {sectionKey.replace(/_/g, " ")}
          </h2>
          <div className="text-sm text-ft-grey-darker">{renderAnswerValue(sectionValue)}</div>
        </section>
      ))}
    </div>
  );
}
