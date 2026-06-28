import 'package:dio/dio.dart';
import 'package:freedomtree_mobile/core/storage/app_database.dart';
import 'package:freedomtree_mobile/core/storage/surveys_dao.dart';

class SurveySubmitException implements Exception {
  SurveySubmitException(this.message);
  final String message;
  @override
  String toString() => message;
}

/// Handles survey persistence and server submission. Primary write path is
/// local-first: save to Drift as PENDING, let the [SyncEngine] sync later.
class SurveysRepository {
  SurveysRepository({required Dio dio, required SurveysDao dao})
      : _dio = dio,
        _dao = dao;

  final Dio _dio;
  final SurveysDao _dao;

  /// Called only by the sync engine to POST an education survey payload.
  Future<String> submitEducationForSync(Map<String, dynamic> payload) async {
    try {
      final response = await _dio.post('/surveys/education', data: payload);
      return response.data['id'] as String;
    } on DioException catch (e) {
      throw SurveySubmitException(
        e.response?.data is Map
            ? (e.response!.data['error']?.toString() ?? 'Submission failed')
            : 'Could not reach the server.',
      );
    }
  }

  /// Called only by the sync engine to POST a maternal health survey payload.
  Future<String> submitMaternalForSync(Map<String, dynamic> payload) async {
    try {
      final response = await _dio.post('/surveys/maternal', data: payload);
      return response.data['id'] as String;
    } on DioException catch (e) {
      throw SurveySubmitException(
        e.response?.data is Map
            ? (e.response!.data['error']?.toString() ?? 'Submission failed')
            : 'Could not reach the server.',
      );
    }
  }

  Stream<List<LocalEducationSurvey>> watchAllEducation() => _dao.watchAllEducation();
  Stream<List<LocalMaternalSurvey>> watchAllMaternal() => _dao.watchAllMaternal();
}
