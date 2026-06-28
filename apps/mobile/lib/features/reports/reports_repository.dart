import 'package:dio/dio.dart';
import 'package:freedomtree_mobile/core/storage/app_database.dart';
import 'package:freedomtree_mobile/core/storage/reports_dao.dart';
import 'package:freedomtree_mobile/features/reports/report_draft.dart';

class ReportConflictException implements Exception {
  ReportConflictException(this.existing);
  final Map<String, dynamic> existing;
}

class ReportSubmitException implements Exception {
  ReportSubmitException(this.message);
  final String message;
  @override
  String toString() => message;
}

/// Handles all report persistence. The primary write path is local-first:
/// [save] writes to Drift as PENDING, then the [SyncEngine] picks it up.
/// [submitForSync] is called only by the sync engine — it talks to the
/// server and returns the server-assigned id on success.
class ReportsRepository {
  ReportsRepository({required Dio dio, required ReportsDao dao}) : _dio = dio, _dao = dao;

  final Dio _dio;
  final ReportsDao _dao;

  /// Save a draft locally as PENDING. Returns immediately (offline-safe).
  /// The sync engine will deliver it to the server when connectivity allows.
  Future<void> save(ReportDraft draft) => _dao.saveFromDraft(draft);

  /// Used by [SyncEngine] to POST one report payload to the server.
  /// Returns the server-assigned `id` on success.
  Future<String> submitForSync(Map<String, dynamic> payload) async {
    try {
      final response = await _dio.post('/reports', data: payload);
      return response.data['id'] as String;
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw ReportConflictException(
          (e.response!.data['existing'] ?? {}) as Map<String, dynamic>,
        );
      }
      throw ReportSubmitException(
        e.response?.data is Map
            ? (e.response!.data['error']?.toString() ?? 'Submission failed')
            : 'Could not reach the server.',
      );
    }
  }

  Stream<List<LocalReport>> watchAll() => _dao.watchAll();

  Future<bool> existsForCommunityMonth(String community, DateTime month) =>
      _dao.existsForCommunityMonth(community, month);
}
