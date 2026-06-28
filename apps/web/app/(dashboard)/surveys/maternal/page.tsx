import Link from "next/link";
import { prisma } from "@/lib/prisma";
import { StatCard } from "@/components/StatCard";

const PAGE_SIZE = 20;

const CATEGORY_LABELS: Record<string, string> = {
  pregnant_woman: "Pregnant Woman",
  lactating_mother: "Lactating Mother",
  mother_child_under_5: "Mother of Child Under Five",
  father_caregiver: "Father/Caregiver",
  community_health_worker: "Community Health Worker",
  nurse_midwife: "Nurse/Midwife",
  traditional_birth_attendant: "Traditional Birth Attendant",
  community_leader: "Community Leader",
  other: "Other",
};

function formatCategory(raw: string) {
  return (
    CATEGORY_LABELS[raw] ??
    raw
      .split("_")
      .map((w) => w.charAt(0).toUpperCase() + w.slice(1))
      .join(" ")
  );
}

export default async function MaternalSurveysPage({
  searchParams,
}: {
  searchParams: Promise<{ community?: string; category?: string; page?: string }>;
}) {
  const params = await searchParams;
  const page = Math.max(1, parseInt(params.page ?? "1", 10) || 1);

  const where: { community?: string; respondentCategory?: string } = {};
  if (params.community) where.community = params.community;
  if (params.category) where.respondentCategory = params.category;

  const [surveys, total, categoryCounts] = await Promise.all([
    prisma.maternalHealthSurvey.findMany({
      where,
      orderBy: { surveyDate: "desc" },
      skip: (page - 1) * PAGE_SIZE,
      take: PAGE_SIZE,
    }),
    prisma.maternalHealthSurvey.count({ where }),
    prisma.maternalHealthSurvey.groupBy({
      by: ["respondentCategory"],
      _count: { respondentCategory: true },
    }),
  ]);

  const totalPages = Math.max(1, Math.ceil(total / PAGE_SIZE));

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-semibold text-ft-grey-darker">Maternal Health Surveys</h1>
        <p className="mt-1 text-sm text-ft-grey-medium">
          {total} survey{total === 1 ? "" : "s"}
        </p>
      </div>

      <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4">
        {categoryCounts.map((c) => (
          <StatCard
            key={c.respondentCategory}
            label={formatCategory(c.respondentCategory)}
            value={c._count.respondentCategory}
          />
        ))}
      </div>

      <div className="overflow-x-auto rounded-lg border border-ft-grey-light">
        <table className="w-full text-left text-sm">
          <thead className="bg-ft-grey-darker text-white">
            <tr>
              <th className="px-4 py-2">Date</th>
              <th className="px-4 py-2">Community</th>
              <th className="px-4 py-2">Category</th>
              <th className="px-4 py-2">Respondent</th>
              <th className="px-4 py-2">Actions</th>
            </tr>
          </thead>
          <tbody>
            {surveys.map((s) => (
              <tr key={s.id} className="border-t border-ft-grey-light hover:bg-ft-grey-light/20">
                <td className="px-4 py-2">{s.surveyDate.toISOString().slice(0, 10)}</td>
                <td className="px-4 py-2">{s.community}</td>
                <td className="px-4 py-2">{formatCategory(s.respondentCategory)}</td>
                <td className="px-4 py-2">{s.respondentName}</td>
                <td className="px-4 py-2">
                  <Link
                    href={`/surveys/maternal/${s.id}`}
                    className="text-ft-orange hover:text-ft-dark-orange"
                  >
                    View
                  </Link>
                </td>
              </tr>
            ))}
            {surveys.length === 0 && (
              <tr>
                <td colSpan={5} className="px-4 py-8 text-center text-ft-grey-medium">
                  No surveys found.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {totalPages > 1 && (
        <div className="flex justify-center gap-2 text-sm">
          {Array.from({ length: totalPages }, (_, i) => i + 1).map((p) => (
            <Link
              key={p}
              href={{ pathname: "/surveys/maternal", query: { ...params, page: p } }}
              className={`rounded px-3 py-1 ${
                p === page
                  ? "bg-ft-orange text-white"
                  : "text-ft-grey-dark hover:bg-ft-grey-light/30"
              }`}
            >
              {p}
            </Link>
          ))}
        </div>
      )}
    </div>
  );
}
