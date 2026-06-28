import 'package:uuid/uuid.dart';
import 'package:freedomtree_mobile/features/reports/report_enums.dart';

const _uuid = Uuid();

/// Mutable in-memory form state for one report. `clientId` is generated once
/// at creation and never changes — it's the dedup key the server upserts on.
class ReportDraft {
  ReportDraft({String? clientId, DateTime? clientCreatedAt})
      : clientId = clientId ?? _uuid.v4(),
        clientCreatedAt = clientCreatedAt ?? DateTime.now();

  final String clientId;
  final DateTime clientCreatedAt;

  // Section 1 — General Information
  DateTime? reportingMonth;
  String community = '';
  String submittedByName = '';
  String submittedByPosition = '';
  DateTime dateSubmitted = DateTime.now();

  // Section 2 — Maternal Health
  int pregnantWomenCount = 0;
  int deliveriesTotal = 0;
  int deliveriesAtFacility = 0;
  int deliveriesAtHome = 0;
  int maternalDeaths = 0;
  Set<PlaceOfDeath> placeOfDeath = {};
  String placeOfDeathOtherNote = '';
  String suspectedMaternalCause = '';

  // Section 3 — Infant Health
  int liveBirths = 0;
  int infantDeathsTotal = 0;
  int infantDeathsWithin24h = 0;
  int infantDeathsWithin1Month = 0;
  int infantDeathsWithin12Months = 0;

  // Section 4 — Contributing Factors
  Set<InfantDeathCause> infantDeathCauses = {};
  String infantDeathCausesOtherNote = '';

  // Section 5 — Community Actions & Recommendations
  String keyChallenges = '';
  String actionsTaken = '';
  String additionalComments = '';

  Map<String, dynamic> toJson(DateTime clientUpdatedAt) {
    final month = DateTime(reportingMonth!.year, reportingMonth!.month, 1);
    return {
      'clientId': clientId,
      'reportingMonth': month.toUtc().toIso8601String(),
      'community': community,
      'submittedByName': submittedByName,
      'submittedByPosition': submittedByPosition,
      'dateSubmitted': dateSubmitted.toUtc().toIso8601String(),
      'pregnantWomenCount': pregnantWomenCount,
      'deliveriesTotal': deliveriesTotal,
      'deliveriesAtFacility': deliveriesAtFacility,
      'deliveriesAtHome': deliveriesAtHome,
      'maternalDeaths': maternalDeaths,
      'placeOfDeath': placeOfDeath.map((e) => e.wireValue).toList(),
      'placeOfDeathOtherNote': placeOfDeathOtherNote.isEmpty ? null : placeOfDeathOtherNote,
      'suspectedMaternalCause': suspectedMaternalCause.isEmpty ? null : suspectedMaternalCause,
      'liveBirths': liveBirths,
      'infantDeathsTotal': infantDeathsTotal,
      'infantDeathsWithin24h': infantDeathsWithin24h,
      'infantDeathsWithin1Month': infantDeathsWithin1Month,
      'infantDeathsWithin12Months': infantDeathsWithin12Months,
      'infantDeathCauses': infantDeathCauses.map((e) => e.wireValue).toList(),
      'infantDeathCausesOtherNote': infantDeathCausesOtherNote.isEmpty ? null : infantDeathCausesOtherNote,
      'keyChallenges': keyChallenges,
      'actionsTaken': actionsTaken,
      'additionalComments': additionalComments,
      'clientCreatedAt': clientCreatedAt.toUtc().toIso8601String(),
      'clientUpdatedAt': clientUpdatedAt.toUtc().toIso8601String(),
    };
  }
}
