"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import type { Report } from "@prisma/client";
import {
  PLACE_OF_DEATH,
  PLACE_OF_DEATH_LABELS,
  INFANT_DEATH_CAUSES,
  INFANT_DEATH_CAUSE_LABELS,
  type PlaceOfDeath,
  type InfantDeathCause,
} from "@freedomtree/shared";

const NUMBER_FIELDS = [
  ["pregnantWomenCount", "Total pregnant women"],
  ["deliveriesTotal", "Total deliveries"],
  ["deliveriesAtFacility", "Deliveries at health facility"],
  ["deliveriesAtHome", "Deliveries at home"],
  ["maternalDeaths", "Maternal deaths"],
  ["liveBirths", "Live births"],
  ["infantDeathsTotal", "Infant deaths (0-12 months)"],
  ["infantDeathsWithin24h", "Infant deaths within 24 hours"],
  ["infantDeathsWithin1Month", "Infant deaths within 1 month"],
  ["infantDeathsWithin12Months", "Infant deaths within 0-12 months"],
] as const;

const TEXT_FIELDS = [
  ["suspectedMaternalCause", "Suspected maternal cause(s)"],
  ["placeOfDeathOtherNote", "Place of death — other note"],
  ["infantDeathCausesOtherNote", "Infant death cause — other note"],
] as const;

const PARAGRAPH_FIELDS = [
  ["keyChallenges", "Key challenges faced this month"],
  ["actionsTaken", "Actions taken/planned"],
  ["additionalComments", "Additional comments/suggestions"],
] as const;

type FormState = {
  [K in (typeof NUMBER_FIELDS)[number][0]]: number;
} & {
  [K in (typeof TEXT_FIELDS)[number][0]]: string;
} & {
  [K in (typeof PARAGRAPH_FIELDS)[number][0]]: string;
} & {
  placeOfDeath: PlaceOfDeath[];
  infantDeathCauses: InfantDeathCause[];
};

export function ReportEditForm({ report }: { report: Report }) {
  const router = useRouter();
  const [form, setForm] = useState<FormState>({
    pregnantWomenCount: report.pregnantWomenCount,
    deliveriesTotal: report.deliveriesTotal,
    deliveriesAtFacility: report.deliveriesAtFacility,
    deliveriesAtHome: report.deliveriesAtHome,
    maternalDeaths: report.maternalDeaths,
    liveBirths: report.liveBirths,
    infantDeathsTotal: report.infantDeathsTotal,
    infantDeathsWithin24h: report.infantDeathsWithin24h,
    infantDeathsWithin1Month: report.infantDeathsWithin1Month,
    infantDeathsWithin12Months: report.infantDeathsWithin12Months,
    suspectedMaternalCause: report.suspectedMaternalCause ?? "",
    placeOfDeathOtherNote: report.placeOfDeathOtherNote ?? "",
    infantDeathCausesOtherNote: report.infantDeathCausesOtherNote ?? "",
    keyChallenges: report.keyChallenges,
    actionsTaken: report.actionsTaken,
    additionalComments: report.additionalComments,
    placeOfDeath: report.placeOfDeath as PlaceOfDeath[],
    infantDeathCauses: report.infantDeathCauses as InfantDeathCause[],
  });
  const [saving, setSaving] = useState(false);
  const [savedAt, setSavedAt] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  function toggle(field: "placeOfDeath" | "infantDeathCauses", value: string) {
    setForm((f) => {
      const list = f[field] as string[];
      const next = list.includes(value) ? list.filter((v) => v !== value) : [...list, value];
      return { ...f, [field]: next };
    });
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setSaving(true);
    setError(null);
    try {
      const res = await fetch(`/api/reports/${report.id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(form),
      });
      if (!res.ok) {
        const body = await res.json().catch(() => ({}));
        throw new Error(body.error ?? "Failed to save");
      }
      setSavedAt(new Date().toLocaleTimeString());
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to save");
    } finally {
      setSaving(false);
    }
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-8">
      <section className="space-y-3">
        <h2 className="font-heading text-lg font-semibold text-ft-grey-darker">Maternal & Infant Health</h2>
        <div className="grid grid-cols-2 gap-4">
          {NUMBER_FIELDS.map(([key, label]) => (
            <div key={key}>
              <label className="mb-1 block text-xs font-medium text-ft-grey-dark">{label}</label>
              <input
                type="number"
                min={0}
                value={form[key]}
                onChange={(e) => setForm((f) => ({ ...f, [key]: Number(e.target.value) }))}
                className="w-full rounded-md border border-ft-grey-light px-2 py-1 text-sm outline-none focus:border-ft-orange"
              />
            </div>
          ))}
        </div>
      </section>

      <section className="space-y-3">
        <h2 className="font-heading text-lg font-semibold text-ft-grey-darker">Place of Death</h2>
        <div className="flex flex-wrap gap-3">
          {PLACE_OF_DEATH.map((value) => (
            <label key={value} className="flex items-center gap-2 text-sm text-ft-grey-dark">
              <input
                type="checkbox"
                checked={form.placeOfDeath.includes(value)}
                onChange={() => toggle("placeOfDeath", value)}
                className="accent-ft-orange"
              />
              {PLACE_OF_DEATH_LABELS[value]}
            </label>
          ))}
        </div>
      </section>

      <section className="space-y-3">
        <h2 className="font-heading text-lg font-semibold text-ft-grey-darker">
          Contributing Factors (infant death)
        </h2>
        <div className="flex flex-wrap gap-3">
          {INFANT_DEATH_CAUSES.map((value) => (
            <label key={value} className="flex items-center gap-2 text-sm text-ft-grey-dark">
              <input
                type="checkbox"
                checked={form.infantDeathCauses.includes(value)}
                onChange={() => toggle("infantDeathCauses", value)}
                className="accent-ft-orange"
              />
              {INFANT_DEATH_CAUSE_LABELS[value]}
            </label>
          ))}
        </div>
      </section>

      <section className="space-y-3">
        {TEXT_FIELDS.map(([key, label]) => (
          <div key={key}>
            <label className="mb-1 block text-xs font-medium text-ft-grey-dark">{label}</label>
            <input
              type="text"
              value={form[key]}
              onChange={(e) => setForm((f) => ({ ...f, [key]: e.target.value }))}
              className="w-full rounded-md border border-ft-grey-light px-2 py-1 text-sm outline-none focus:border-ft-orange"
            />
          </div>
        ))}
      </section>

      <section className="space-y-3">
        <h2 className="font-heading text-lg font-semibold text-ft-grey-darker">
          Community Actions & Recommendations
        </h2>
        {PARAGRAPH_FIELDS.map(([key, label]) => (
          <div key={key}>
            <label className="mb-1 block text-xs font-medium text-ft-grey-dark">{label}</label>
            <textarea
              value={form[key]}
              onChange={(e) => setForm((f) => ({ ...f, [key]: e.target.value }))}
              rows={3}
              className="w-full rounded-md border border-ft-grey-light px-2 py-1 text-sm outline-none focus:border-ft-orange"
            />
          </div>
        ))}
      </section>

      {error && <p className="text-sm text-ft-dark-orange">{error}</p>}
      <div className="flex items-center gap-4">
        <button
          type="submit"
          disabled={saving}
          className="rounded-md bg-ft-orange px-4 py-2 font-medium text-white transition hover:bg-ft-dark-orange disabled:opacity-60"
        >
          {saving ? "Saving..." : "Save corrections"}
        </button>
        {savedAt && <span className="text-sm text-ft-green">Saved at {savedAt}</span>}
      </div>
    </form>
  );
}
