import 'package:dio/dio.dart';
import 'package:freedomtree_mobile/core/storage/token_storage.dart';
import 'package:freedomtree_mobile/features/auth/auth_models.dart';

class AuthException implements Exception {
  AuthException(this.message);
  final String message;
  @override
  String toString() => message;
}

/// Handles login/logout against the explicit mobile JWT endpoints
/// (/api/auth/login, /logout, /me) — distinct from the dashboard's NextAuth
/// cookie session, but backed by the same User table on the server.
class AuthRepository {
  AuthRepository({required Dio dio, required TokenStorage tokenStorage})
      : _dio = dio,
        _tokenStorage = tokenStorage;

  final Dio _dio;
  final TokenStorage _tokenStorage;

  Future<CurrentUser> login(String username, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });
      await _tokenStorage.save(
        accessToken: response.data['accessToken'] as String,
        refreshToken: response.data['refreshToken'] as String,
      );
      return CurrentUser.fromJson(response.data['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AuthException('Invalid username or password.');
      }
      throw AuthException('Could not reach the server. Check your connection.');
    }
  }

  Future<void> logout() async {
    final refreshToken = await _tokenStorage.refreshToken;
    if (refreshToken != null) {
      try {
        await _dio.post('/auth/logout', data: {'refreshToken': refreshToken});
      } catch (_) {
        // best-effort server-side revoke; clear local tokens regardless
      }
    }
    await _tokenStorage.clear();
  }

  Future<CurrentUser?> fetchCurrentUser() async {
    final token = await _tokenStorage.accessToken;
    if (token == null) return null;
    try {
      final response = await _dio.get('/auth/me');
      return CurrentUser.fromJson(response.data as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<bool> get isLoggedIn async => (await _tokenStorage.accessToken) != null;
}
