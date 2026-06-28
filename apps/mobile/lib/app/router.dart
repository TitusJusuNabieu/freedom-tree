import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:freedomtree_mobile/core/storage/surveys_dao.dart';
import 'package:freedomtree_mobile/core/sync/sync_engine.dart';
import 'package:freedomtree_mobile/features/auth/auth_controller.dart';
import 'package:freedomtree_mobile/features/auth/login_screen.dart';
import 'package:freedomtree_mobile/features/home/home_screen.dart';
import 'package:freedomtree_mobile/features/reports/reports_repository.dart';
import 'package:freedomtree_mobile/features/surveys/surveys_repository.dart';

GoRouter buildRouter({
  required AuthController authController,
  required ReportsRepository reportsRepository,
  required SyncEngine syncEngine,
  required SurveysDao surveysDao,
  required SurveysRepository surveysRepository,
  required Dio apiDio,
}) {
  return GoRouter(
    refreshListenable: authController,
    initialLocation: '/',
    redirect: (context, state) {
      if (authController.status == AuthStatus.unknown) return null;
      final loggingIn = state.matchedLocation == '/login';
      final authenticated = authController.status == AuthStatus.authenticated;
      if (!authenticated && !loggingIn) return '/login';
      if (authenticated && loggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(authController: authController),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(
          authController: authController,
          reportsRepository: reportsRepository,
          syncEngine: syncEngine,
          surveysDao: surveysDao,
          apiDio: apiDio,
        ),
      ),
    ],
  );
}
