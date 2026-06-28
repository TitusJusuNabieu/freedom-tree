import { z } from "zod";
import { PLACE_OF_DEATH, INFANT_DEATH_CAUSES } from "./enums";

/**
 * Single source of truth for the 15-field monthly mortality report.
 * Mirrors prisma/schema.prisma `Report` model field-for-field.
 * Mobile (Dart) mirrors this by hand — see docs/form-field-mapping.md.
 */
export const reportSchema = z.object({
  clientId: z.string().uuid(),

  // Section 1 — General Information
  reportingMonth: z.coerce.date(),
  community: z.string().min(1),
  submittedByName: z.string().min(1),
  submittedByPosition: z.string().min(1),
  dateSubmitted: z.coerce.date(),

  // Section 2 — Maternal Health
  pregnantWomenCount: z.number().int().min(0),
  deliveriesTotal: z.number().int().min(0),
  deliveriesAtFacility: z.number().int().min(0),
  deliveriesAtHome: z.number().int().min(0),
  maternalDeaths: z.number().int().min(0),
  placeOfDeath: z.array(z.enum(PLACE_OF_DEATH)).default([]),
  placeOfDeathOtherNote: z.string().optional().nullable(),
  suspectedMaternalCause: z.string().optional().nullable(),

  // Section 3 — Infant Health
  liveBirths: z.number().int().min(0),
  infantDeathsTotal: z.number().int().min(0),
  infantDeathsWithin24h: z.number().int().min(0),
  infantDeathsWithin1Month: z.number().int().min(0),
  infantDeathsWithin12Months: z.number().int().min(0),

  // Section 4 — Contributing Factors
  infantDeathCauses: z.array(z.enum(INFANT_DEATH_CAUSES)).default([]),
  infantDeathCausesOtherNote: z.string().optional().nullable(),

  // Section 5 — Community Actions & Recommendations
  keyChallenges: z.string().default(""),
  actionsTaken: z.string().default(""),
  additionalComments: z.string().default(""),

  // Sync metadata supplied by the client
  clientCreatedAt: z.coerce.date(),
  clientUpdatedAt: z.coerce.date(),
});

export type ReportInput = z.infer<typeof reportSchema>;

export const reportPatchSchema = reportSchema.partial().omit({ clientId: true });
