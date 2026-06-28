// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surveys_dao.dart';

// ignore_for_file: type=lint
mixin _$SurveysDaoMixin on DatabaseAccessor<AppDatabase> {
  $LocalEducationSurveysTable get localEducationSurveys =>
      attachedDatabase.localEducationSurveys;
  $LocalMaternalSurveysTable get localMaternalSurveys =>
      attachedDatabase.localMaternalSurveys;
  SurveysDaoManager get managers => SurveysDaoManager(this);
}

class SurveysDaoManager {
  final _$SurveysDaoMixin _db;
  SurveysDaoManager(this._db);
  $$LocalEducationSurveysTableTableManager get localEducationSurveys =>
      $$LocalEducationSurveysTableTableManager(
        _db.attachedDatabase,
        _db.localEducationSurveys,
      );
  $$LocalMaternalSurveysTableTableManager get localMaternalSurveys =>
      $$LocalMaternalSurveysTableTableManager(
        _db.attachedDatabase,
        _db.localMaternalSurveys,
      );
}
