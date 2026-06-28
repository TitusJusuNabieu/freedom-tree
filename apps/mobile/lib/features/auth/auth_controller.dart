import 'package:flutter/foundation.dart';
import 'package:freedomtree_mobile/features/auth/auth_models.dart';
import 'package:freedomtree_mobile/features/auth/auth_repository.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

/// Drives go_router's redirect logic via [ChangeNotifier] — when the API
/// client's interceptor calls [signOut] after a failed refresh, the router
/// reacts and sends the user back to /login.
class AuthController extends ChangeNotifier {
  AuthController(this._repository) {
    _restore();
  }

  final AuthRepository _repository;

  AuthStatus status = AuthStatus.unknown;
  CurrentUser? currentUser;

  Future<void> _restore() async {
    final user = await _repository.fetchCurrentUser();
    currentUser = user;
    status = user != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    final user = await _repository.login(username, password);
    currentUser = user;
    status = AuthStatus.authenticated;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _repository.logout();
    currentUser = null;
    status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  void updateUser(CurrentUser user) {
    currentUser = user;
    notifyListeners();
  }
}
