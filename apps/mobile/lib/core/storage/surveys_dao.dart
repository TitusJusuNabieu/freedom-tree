import 'package:drift/drift.dart';
import 'package:freedomtree_mobile/core/storage/app_database.dart';

part 'surveys_dao.g.dart';

@DriftAccessor(tables: [LocalEducationSurveys, LocalMaternalSurveys])
class SurveysDao extends DatabaseAccessor<AppDatabase> with _$SurveysDaoMixin {
  SurveysDao(super.db);

  Stream<List<LocalEducationSurvey>> watchAllEducation() =>
      (select(localEducationSurveys)
            ..orderBy([(r) => OrderingTerm.desc(r.surveyDate)]))
          .watch();

  Stream<List<LocalMaternalSurvey>> watchAllMaternal() =>
      (select(localMaternalSurveys)
            ..orderBy([(r) => OrderingTerm.desc(r.surveyDate)]))
          .watch();

  Future<List<LocalEducationSurvey>> getPendingEducation() =>
      (select(localEducationSurveys)
            ..where((r) => r.syncStatus.isIn(['pending', 'failed']))
            ..orderBy([(r) => OrderingTerm.asc(r.clientCreatedAt)]))
          .get();

  Future<List<LocalMaternalSurvey>> getPendingMaternal() =>
      (select(localMaternalSurveys)
            ..where((r) => r.syncStatus.isIn(['pending', 'failed']))
            ..orderBy([(r) => OrderingTerm.asc(r.clientCreatedAt)]))
          .get();

  Future<void> saveEducation({
    required String clientId,
    required String enumeratorName,
    required DateTime surveyDate,
    required String communityOrSchool,
    required String district,
    required String respondentName,
    required String respondentCategory,
    required String sex,
    required String answersJson,
    required DateTime clientCreatedAt,
    SyncStatus status = SyncStatus.pending,
  }) async {
    final now = DateTime.now();
    await into(localEducationSurveys).insertOnConflictUpdate(
      LocalEducationSurveysCompanion.insert(
        clientId: clientId,
        syncStatus: status,
        enumeratorName: enumeratorName,
        surveyDate: surveyDate,
        communityOrSchool: communityOrSchool,
        district: district,
        respondentName: respondentName,
        respondentCategory: respondentCategory,
        sex: sex,
        answersJson: answersJson,
        clientCreatedAt: clientCreatedAt,
        clientUpdatedAt: now,
      ),
    );
  }

  Future<void> saveMaternal({
    required String clientId,
    required String enumeratorName,
    required DateTime surveyDate,
    required String community,
    String? healthFacility,
    required String district,
    required String respondentName,
    required String respondentCategory,
    required String sex,
    required String answersJson,
    required DateTime clientCreatedAt,
    SyncStatus status = SyncStatus.pending,
  }) async {
    final now = DateTime.now();
    await into(localMaternalSurveys).insertOnConflictUpdate(
      LocalMaternalSurveysCompanion.insert(
        clientId: clientId,
        syncStatus: status,
        enumeratorName: enumeratorName,
        surveyDate: surveyDate,
        community: community,
        healthFacility: Value(healthFacility),
        district: district,
        respondentName: respondentName,
        respondentCategory: respondentCategory,
        sex: sex,
        answersJson: answersJson,
        clientCreatedAt: clientCreatedAt,
        clientUpdatedAt: now,
      ),
    );
  }

  Future<void> markEducationSynced(String clientId, String serverId) =>
      (update(localEducationSurveys)..where((r) => r.clientId.equals(clientId))).write(
        LocalEducationSurveysCompanion(
          serverId: Value(serverId),
          syncStatus: const Value(SyncStatus.synced),
          syncError: const Value(null),
          lastSyncAttemptAt: Value(DateTime.now()),
        ),
      );

  Future<void> markMaternalSynced(String clientId, String serverId) =>
      (update(localMaternalSurveys)..where((r) => r.clientId.equals(clientId))).write(
        LocalMaternalSurveysCompanion(
          serverId: Value(serverId),
          syncStatus: const Value(SyncStatus.synced),
          syncError: const Value(null),
          lastSyncAttemptAt: Value(DateTime.now()),
        ),
      );

  Future<void> markEducationFailed(String clientId, String error) =>
      (update(localEducationSurveys)..where((r) => r.clientId.equals(clientId))).write(
        LocalEducationSurveysCompanion(
          syncStatus: const Value(SyncStatus.failed),
          syncError: Value(error),
          lastSyncAttemptAt: Value(DateTime.now()),
        ),
      );

  Future<void> markMaternalFailed(String clientId, String error) =>
      (update(localMaternalSurveys)..where((r) => r.clientId.equals(clientId))).write(
        LocalMaternalSurveysCompanion(
          syncStatus: const Value(SyncStatus.failed),
          syncError: Value(error),
          lastSyncAttemptAt: Value(DateTime.now()),
        ),
      );

  Future<void> markEducationSyncing(String clientId) =>
      (update(localEducationSurveys)..where((r) => r.clientId.equals(clientId))).write(
        const LocalEducationSurveysCompanion(syncStatus: Value(SyncStatus.syncing)),
      );

  Future<void> markMaternalSyncing(String clientId) =>
      (update(localMaternalSurveys)..where((r) => r.clientId.equals(clientId))).write(
        const LocalMaternalSurveysCompanion(syncStatus: Value(SyncStatus.syncing)),
      );
}
