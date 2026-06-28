export const ROLES = ["FIELD_WORKER", "ADMIN"] as const;
export type Role = (typeof ROLES)[number];

export const PLACE_OF_DEATH = [
  "HEALTH_FACILITY",
  "HOME",
  "OTHER",
  "NOT_APPLICABLE",
] as const;
export type PlaceOfDeath = (typeof PLACE_OF_DEATH)[number];

export const PLACE_OF_DEATH_LABELS: Record<PlaceOfDeath, string> = {
  HEALTH_FACILITY: "Health facility",
  HOME: "Home",
  OTHER: "Other (specify)",
  NOT_APPLICABLE: "Not Applicable",
};

export const INFANT_DEATH_CAUSES = [
  "LACK_OF_SKILLED_BIRTH_ATTENDANT",
  "DELAY_ACCESSING_HEALTH_FACILITY",
  "LACK_OF_TRANSPORTATION_POOR_ROAD",
  "POOR_NUTRITION",
  "BAD_CULTURAL_PRACTICES",
  "OTHER",
  "NOT_APPLICABLE",
] as const;
export type InfantDeathCause = (typeof INFANT_DEATH_CAUSES)[number];

export const INFANT_DEATH_CAUSE_LABELS: Record<InfantDeathCause, string> = {
  LACK_OF_SKILLED_BIRTH_ATTENDANT: "Lack of skilled birth attendant",
  DELAY_ACCESSING_HEALTH_FACILITY: "Delay in accessing health facility",
  LACK_OF_TRANSPORTATION_POOR_ROAD: "Lack of transportation/poor road network",
  POOR_NUTRITION: "Poor nutrition",
  BAD_CULTURAL_PRACTICES: "Bad cultural practices",
  OTHER: "Other (specify)",
  NOT_APPLICABLE: "Not Applicable",
};

export const REPORTING_MONTHS = [
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December",
] as const;
