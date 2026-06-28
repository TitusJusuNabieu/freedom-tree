import 'package:drift/drift.dart';
import 'package:freedomtree_mobile/core/storage/app_database.dart';
import 'package:freedomtree_mobile/features/reports/report_draft.dart';
import 'package:freedomtree_mobile/features/reports/report_enums.dart';

part 'reports_dao.g.dart';

@DriftAccessor(tables: [LocalReports])
class ReportsDao extends DatabaseAccessor<AppDatabase> with _$ReportsDaoMixin {
  ReportsDao(super.db);

  /// All reports ordered by reporting month desc — used by the home screen.
  Stream<List<LocalReport>> watchAll() =>
      (select(localReports)..orderBy([(r) => OrderingTerm.desc(r.reportingMonth)])).watch();

  /// All reports not yet successfully synced — processed by the sync engine.
  Future<List<LocalReport>> getPending() =>
      (select(localReports)
            ..where((r) => r.syncStatus.isIn(['pending', 'failed']))
            ..orderBy([(r) => OrderingTerm.asc(r.clientCreatedAt)]))
          .get();

  /// Upsert from a [ReportDraft] — insert on new, update on edit.
  Future<void> saveFromDraft(ReportDraft draft, {SyncStatus status = SyncStatus.pending}) async {
    final now = DateTime.now();
    await into(localReports).insertOnConflictUpdate(
      LocalReportsCompanion.insert(
        clientId: draft.clientId,
        syncStatus: status,
        reportingMonth: draft.reportingMonth ?? now,
        community: draft.community,
        submittedByName: draft.submittedByName,
        submittedByPosition: draft.submittedByPosition,
        dateSubmitted: draft.dateSubmitted,
        pregnantWomenCount: draft.pregnantWomenCount,
        deliveriesTotal: draft.deliveriesTotal,
        deliveriesAtFacility: draft.deliveriesAtFacility,
        deliveriesAtHome: draft.deliveriesAtHome,
        maternalDeaths: draft.maternalDeaths,
        placeOfDeath: draft.placeOfDeath.map((e) => e.wireValue).toSet(),
        placeOfDeathOtherNote: Value(draft.placeOfDeathOtherNote.isEmpty ? null : draft.placeOfDeathOtherNote),
        suspectedMaternalCause: Value(draft.suspectedMaternalCause.isEmpty ? null : draft.suspectedMaternalCause),
        liveBirths: draft.liveBirths,
        infantDeathsTotal: draft.infantDeathsTotal,
        infantDeathsWithin24h: draft.infantDeathsWithin24h,
        infantDeathsWithin1Month: draft.infantDeathsWithin1Month,
        infantDeathsWithin12Months: draft.infantDeathsWithin12Months,
        infantDeathCauses: draft.infantDeathCauses.map((e) => e.wireValue).toSet(),
        infantDeathCausesOtherNote: Value(draft.infantDeathCausesOtherNote.isEmpty ? null : draft.infantDeathCausesOtherNote),
        keyChallenges: draft.keyChallenges,
        actionsTaken: draft.actionsTaken,
        additionalComments: draft.additionalComments,
        clientCreatedAt: draft.clientCreatedAt,
        clientUpdatedAt: now,
      ),
    );
  }

  /// Mark a report as synced and store the server-assigned id.
  Future<void> markSynced(String clientId, String serverId) =>
      (update(localReports)..where((r) => r.clientId.equals(clientId))).write(
        LocalReportsCompanion(
          serverId: Value(serverId),
          syncStatus: const Value(SyncStatus.synced),
          syncError: const Value(null),
          lastSyncAttemptAt: Value(DateTime.now()),
        ),
      );

  Future<void> markFailed(String clientId, String error) =>
      (update(localReports)..where((r) => r.clientId.equals(clientId))).write(
        LocalReportsCompanion(
          syncStatus: const Value(SyncStatus.failed),
          syncError: Value(error),
          lastSyncAttemptAt: Value(DateTime.now()),
        ),
      );

  Future<void> markSyncing(String clientId) =>
      (update(localReports)..where((r) => r.clientId.equals(clientId))).write(
        const LocalReportsCompanion(syncStatus: Value(SyncStatus.syncing)),
      );

  /// Check if a report already exists for a given (community, month) pair.
  Future<bool> existsForCommunityMonth(String community, DateTime month) async {
    final start = DateTime(month.year, month.month);
    final end = DateTime(month.year, month.month + 1);
    final rows = await (select(localReports)
          ..where((r) =>
              r.community.equals(community) &
              r.reportingMonth.isBiggerOrEqualValue(start) &
              r.reportingMonth.isSmallerThanValue(end)))
        .get();
    return rows.isNotEmpty;
  }

  /// Convert a stored [LocalReport] back into a [ReportDraft] for editing.
  ReportDraft toDraft(LocalReport row) {
    final draft = ReportDraft(clientId: row.clientId, clientCreatedAt: row.clientCreatedAt)
      ..reportingMonth = row.reportingMonth
      ..community = row.community
      ..submittedByName = row.submittedByName
      ..submittedByPosition = row.submittedByPosition
      ..dateSubmitted = row.dateSubmitted
      ..pregnantWomenCount = row.pregnantWomenCount
      ..deliveriesTotal = row.deliveriesTotal
      ..deliveriesAtFacility = row.deliveriesAtFacility
      ..deliveriesAtHome = row.deliveriesAtHome
      ..maternalDeaths = row.maternalDeaths
      ..placeOfDeath = row.placeOfDeath.map(_parsePlaceOfDeath).whereType<PlaceOfDeath>().toSet()
      ..placeOfDeathOtherNote = row.placeOfDeathOtherNote ?? ''
      ..suspectedMaternalCause = row.suspectedMaternalCause ?? ''
      ..liveBirths = row.liveBirths
      ..infantDeathsTotal = row.infantDeathsTotal
      ..infantDeathsWithin24h = row.infantDeathsWithin24h
      ..infantDeathsWithin1Month = row.infantDeathsWithin1Month
      ..infantDeathsWithin12Months = row.infantDeathsWithin12Months
      ..infantDeathCauses = row.infantDeathCauses.map(_parseInfantDeathCause).whereType<InfantDeathCause>().toSet()
      ..infantDeathCausesOtherNote = row.infantDeathCausesOtherNote ?? ''
      ..keyChallenges = row.keyChallenges
      ..actionsTaken = row.actionsTaken
      ..additionalComments = row.additionalComments;
    return draft;
  }

  PlaceOfDeath? _parsePlaceOfDeath(String v) {
    try {
      return PlaceOfDeath.values.firstWhere((e) => e.wireValue == v);
    } catch (_) {
      return null;
    }
  }

  InfantDeathCause? _parseInfantDeathCause(String v) {
    try {
      return InfantDeathCause.values.firstWhere((e) => e.wireValue == v);
    } catch (_) {
      return null;
    }
  }
}
