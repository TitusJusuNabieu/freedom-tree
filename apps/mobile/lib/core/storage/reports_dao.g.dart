// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_dao.dart';

// ignore_for_file: type=lint
mixin _$ReportsDaoMixin on DatabaseAccessor<AppDatabase> {
  $LocalReportsTable get localReports => attachedDatabase.localReports;
  ReportsDaoManager get managers => ReportsDaoManager(this);
}

class ReportsDaoManager {
  final _$ReportsDaoMixin _db;
  ReportsDaoManager(this._db);
  $$LocalReportsTableTableManager get localReports =>
      $$LocalReportsTableTableManager(_db.attachedDatabase, _db.localReports);
}
