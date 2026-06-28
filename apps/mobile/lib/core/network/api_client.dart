import 'package:dio/dio.dart';
import 'package:freedomtree_mobile/core/network/api_config.dart';
import 'package:freedomtree_mobile/core/storage/token_storage.dart';

/// Dio client for all authenticated API calls. A single interceptor attaches
/// the access token to every request and, on a 401, refreshes once and
/// retries the original request — if the refresh also fails, [onAuthFailure]
/// is invoked so the app can route to the login screen.
class ApiClient {
  ApiClient({required TokenStorage tokenStorage, required this.onAuthFailure})
      : _tokenStorage = tokenStorage,
        dio = Dio(BaseOptions(baseUrl: apiBaseUrl, connectTimeout: const Duration(seconds: 15))) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStorage.accessToken;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          final isAuthError = error.response?.statusCode == 401;
          final alreadyRetried = error.requestOptions.extra['retried'] == true;
          if (isAuthError && !alreadyRetried) {
            final refreshed = await _tryRefresh();
            if (refreshed) {
              final retryOptions = error.requestOptions..extra['retried'] = true;
              try {
                final response = await dio.fetch(retryOptions);
                return handler.resolve(response);
              } catch (_) {
                // fall through to auth failure below
              }
            }
            await _tokenStorage.clear();
            onAuthFailure();
          }
          handler.next(error);
        },
      ),
    );
  }

  final Dio dio;
  final TokenStorage _tokenStorage;
  final void Function() onAuthFailure;

  Future<bool> _tryRefresh() async {
    final refreshToken = await _tokenStorage.refreshToken;
    if (refreshToken == null) return false;

    try {
      final plainDio = Dio(BaseOptions(baseUrl: apiBaseUrl));
      final response = await plainDio.post('/auth/refresh', data: {'refreshToken': refreshToken});
      await _tokenStorage.save(
        accessToken: response.data['accessToken'] as String,
        refreshToken: response.data['refreshToken'] as String,
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}
