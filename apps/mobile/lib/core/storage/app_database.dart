import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// --- Type converters ---

/// Stores a set of strings as a pipe-separated TEXT column. Used for the
/// placeOfDeath and infantDeathCauses multi-select fields.
class StringSetConverter extends TypeConverter<Set<String>, String> {
  const StringSetConverter();

  @override
  Set<String> fromSql(String fromDb) =>
      fromDb.isEmpty ? {} : fromDb.split('|').toSet();

  @override
  String toSql(Set<String> value) => value.join('|');
}

enum SyncStatus { draft, pending, syncing, synced, failed }

class SyncStatusConverter extends TypeConverter<SyncStatus, String> {
  const SyncStatusConverter();

  @override
  SyncStatus fromSql(String fromDb) =>
      SyncStatus.values.firstWhere((e) => e.name == fromDb, orElse: () => SyncStatus.draft);

  @override
  String toSql(SyncStatus value) => value.name;
}

// --- Table definition ---

class LocalReports extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get clientId => text().unique()();
  TextColumn get serverId => text().nullable()();
  TextColumn get syncStatus => text().map(const SyncStatusConverter())();
  TextColumn get syncError => text().nullable()();
  DateTimeColumn get lastSyncAttemptAt => dateTime().nullable()();

  // Section 1
  DateTimeColumn get reportingMonth => dateTime()();
  TextColumn get community => text()();
  TextColumn get submittedByName => text()();
  TextColumn get submittedByPosition => text()();
  DateTimeColumn get dateSubmitted => dateTime()();

  // Section 2 — Maternal Health
  IntColumn get pregnantWomenCount => integer()();
  IntColumn get deliveriesTotal => integer()();
  IntColumn get deliveriesAtFacility => integer()();
  IntColumn get deliveriesAtHome => integer()();
  IntColumn get maternalDeaths => integer()();
  TextColumn get placeOfDeath => text().map(const StringSetConverter())();
  TextColumn get placeOfDeathOtherNote => text().nullable()();
  TextColumn get suspectedMaternalCause => text().nullable()();

  // Section 3 — Infant Health
  IntColumn get liveBirths => integer()();
  IntColumn get infantDeathsTotal => integer()();
  IntColumn get infantDeathsWithin24h => integer()();
  IntColumn get infantDeathsWithin1Month => integer()();
  IntColumn get infantDeathsWithin12Months => integer()();

  // Section 4 — Contributing Factors
  TextColumn get infantDeathCauses => text().map(const StringSetConverter())();
  TextColumn get infantDeathCausesOtherNote => text().nullable()();

  // Section 5 — Narrative
  TextColumn get keyChallenges => text()();
  TextColumn get actionsTaken => text()();
  TextColumn get additionalComments => text()();

  DateTimeColumn get clientCreatedAt => dateTime()();
  DateTimeColumn get clientUpdatedAt => dateTime()();
}

// --- Education Survey table ---

class LocalEducationSurveys extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get clientId => text().unique()();
  TextColumn get serverId => text().nullable()();
  TextColumn get syncStatus => text().map(const SyncStatusConverter())();
  TextColumn get syncError => text().nullable()();
  DateTimeColumn get lastSyncAttemptAt => dateTime().nullable()();
  TextColumn get enumeratorName => text()();
  DateTimeColumn get surveyDate => dateTime()();
  TextColumn get communityOrSchool => text()();
  TextColumn get district => text()();
  TextColumn get respondentName => text()();
  TextColumn get respondentCategory => text()();
  TextColumn get sex => text()();
  TextColumn get answersJson => text()();
  DateTimeColumn get clientCreatedAt => dateTime()();
  DateTimeColumn get clientUpdatedAt => dateTime()();
}

// --- Maternal Health Survey table ---

class LocalMaternalSurveys extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get clientId => text().unique()();
  TextColumn get serverId => text().nullable()();
  TextColumn get syncStatus => text().map(const SyncStatusConverter())();
  TextColumn get syncError => text().nullable()();
  DateTimeColumn get lastSyncAttemptAt => dateTime().nullable()();
  TextColumn get enumeratorName => text()();
  DateTimeColumn get surveyDate => dateTime()();
  TextColumn get community => text()();
  TextColumn get healthFacility => text().nullable()();
  TextColumn get district => text()();
  TextColumn get respondentName => text()();
  TextColumn get respondentCategory => text()();
  TextColumn get sex => text()();
  TextColumn get answersJson => text()();
  DateTimeColumn get clientCreatedAt => dateTime()();
  DateTimeColumn get clientUpdatedAt => dateTime()();
}

// --- Database ---

@DriftDatabase(tables: [LocalReports, LocalEducationSurveys, LocalMaternalSurveys])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(super.executor) : super();

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(localEducationSurveys);
        await m.createTable(localMaternalSurveys);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'freedomtree.db'));
    return NativeDatabase.createInBackground(file);
  });
}
