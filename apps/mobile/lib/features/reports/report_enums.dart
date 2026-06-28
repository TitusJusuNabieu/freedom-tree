/// Mirrors packages/shared/src/enums.ts — see docs/form-field-mapping.md for
/// the full field-by-field contract between server, dashboard, and mobile.
enum PlaceOfDeath {
  healthFacility,
  home,
  other,
  notApplicable,
}

extension PlaceOfDeathX on PlaceOfDeath {
  String get wireValue => switch (this) {
        PlaceOfDeath.healthFacility => 'HEALTH_FACILITY',
        PlaceOfDeath.home => 'HOME',
        PlaceOfDeath.other => 'OTHER',
        PlaceOfDeath.notApplicable => 'NOT_APPLICABLE',
      };

  String get label => switch (this) {
        PlaceOfDeath.healthFacility => 'Health facility',
        PlaceOfDeath.home => 'Home',
        PlaceOfDeath.other => 'Other (specify)',
        PlaceOfDeath.notApplicable => 'Not Applicable',
      };
}

enum InfantDeathCause {
  lackOfSkilledBirthAttendant,
  delayAccessingHealthFacility,
  lackOfTransportationPoorRoad,
  poorNutrition,
  badCulturalPractices,
  other,
  notApplicable,
}

extension InfantDeathCauseX on InfantDeathCause {
  String get wireValue => switch (this) {
        InfantDeathCause.lackOfSkilledBirthAttendant => 'LACK_OF_SKILLED_BIRTH_ATTENDANT',
        InfantDeathCause.delayAccessingHealthFacility => 'DELAY_ACCESSING_HEALTH_FACILITY',
        InfantDeathCause.lackOfTransportationPoorRoad => 'LACK_OF_TRANSPORTATION_POOR_ROAD',
        InfantDeathCause.poorNutrition => 'POOR_NUTRITION',
        InfantDeathCause.badCulturalPractices => 'BAD_CULTURAL_PRACTICES',
        InfantDeathCause.other => 'OTHER',
        InfantDeathCause.notApplicable => 'NOT_APPLICABLE',
      };

  String get label => switch (this) {
        InfantDeathCause.lackOfSkilledBirthAttendant => 'Lack of skilled birth attendant',
        InfantDeathCause.delayAccessingHealthFacility => 'Delay in accessing health facility',
        InfantDeathCause.lackOfTransportationPoorRoad => 'Lack of transportation/poor road network',
        InfantDeathCause.poorNutrition => 'Poor nutrition',
        InfantDeathCause.badCulturalPractices => 'Bad cultural practices',
        InfantDeathCause.other => 'Other (specify)',
        InfantDeathCause.notApplicable => 'Not Applicable',
      };
}

const reportingMonths = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];
