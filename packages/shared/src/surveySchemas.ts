import { z } from "zod";

const syncMeta = z.object({
  clientId: z.string().uuid(),
  clientCreatedAt: z.coerce.date(),
  clientUpdatedAt: z.coerce.date(),
});

const enumeratorBase = z.object({
  enumeratorName: z.string().min(1),
  surveyDate: z.coerce.date(),
  respondentName: z.string().min(1),
  district: z.string().min(1),
  sex: z.enum(["male", "female"]),
});

export const educationSurveySchema = syncMeta.merge(enumeratorBase).extend({
  communityOrSchool: z.string().min(1),
  respondentCategory: z.enum([
    "scholarship_beneficiary",
    "bam_participant",
    "gam_participant",
    "parent_guardian",
    "teacher",
    "school_admin",
    "community_leader",
    "other",
  ]),
  answers: z.record(z.unknown()),
});

export type EducationSurveyInput = z.infer<typeof educationSurveySchema>;

export const maternalHealthSurveySchema = syncMeta.merge(enumeratorBase).extend({
  community: z.string().min(1),
  healthFacility: z.string().optional().nullable(),
  respondentCategory: z.enum([
    "pregnant_woman",
    "lactating_mother",
    "mother_child_under_5",
    "father_caregiver",
    "community_health_worker",
    "nurse_midwife",
    "traditional_birth_attendant",
    "community_leader",
    "other",
  ]),
  answers: z.record(z.unknown()),
});

export type MaternalHealthSurveyInput = z.infer<typeof maternalHealthSurveySchema>;
