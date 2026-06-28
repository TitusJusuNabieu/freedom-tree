import 'package:flutter/material.dart';
import 'package:freedomtree_mobile/app/router.dart';
import 'package:freedomtree_mobile/app/theme.dart';
import 'package:freedomtree_mobile/core/network/api_client.dart';
import 'package:freedomtree_mobile/core/storage/app_database.dart';
import 'package:freedomtree_mobile/core/storage/reports_dao.dart';
import 'package:freedomtree_mobile/core/storage/surveys_dao.dart';
import 'package:freedomtree_mobile/core/storage/token_storage.dart';
import 'package:freedomtree_mobile/core/sync/sync_engine.dart';
import 'package:freedomtree_mobile/features/auth/auth_controller.dart';
import 'package:freedomtree_mobile/features/auth/auth_repository.dart';
import 'package:freedomtree_mobile/features/reports/reports_repository.dart';
import 'package:freedomtree_mobile/features/surveys/surveys_repository.dart';

void main() {
  runApp(const FreedomTreeApp());
}

class FreedomTreeApp extends StatefulWidget {
  const FreedomTreeApp({super.key});

  @override
  State<FreedomTreeApp> createState() => _FreedomTreeAppState();
}

class _FreedomTreeAppState extends State<FreedomTreeApp> with WidgetsBindingObserver {
  late final AppDatabase _db;
  late final ReportsDao _reportsDao;
  late final SurveysDao _surveysDao;
  late final TokenStorage _tokenStorage;
  late final ApiClient _apiClient;
  late final AuthController _authController;
  late final ReportsRepository _reportsRepository;
  late final SurveysRepository _surveysRepository;
  late final SyncEngine _syncEngine;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _db = AppDatabase();
    _reportsDao = ReportsDao(_db);
    _surveysDao = SurveysDao(_db);
    _tokenStorage = TokenStorage();
    _apiClient = ApiClient(
      tokenStorage: _tokenStorage,
      onAuthFailure: () => _authController.signOut(),
    );
    final authRepository = AuthRepository(dio: _apiClient.dio, tokenStorage: _tokenStorage);
    _authController = AuthController(authRepository);
    _reportsRepository = ReportsRepository(dio: _apiClient.dio, dao: _reportsDao);
    _surveysRepository = SurveysRepository(dio: _apiClient.dio, dao: _surveysDao);
    _syncEngine = SyncEngine(
      dao: _reportsDao,
      repository: _reportsRepository,
      surveysDao: _surveysDao,
      surveysRepository: _surveysRepository,
    )..startListening();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Kick off sync when the app returns to the foreground.
    if (state == AppLifecycleState.resumed) {
      _syncEngine.syncPending();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _syncEngine.dispose();
    _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = buildRouter(
      authController: _authController,
      reportsRepository: _reportsRepository,
      syncEngine: _syncEngine,
      surveysDao: _surveysDao,
      surveysRepository: _surveysRepository,
      apiDio: _apiClient.dio,
    );
    return MaterialApp.router(
      title: 'Freedom Tree Field Reporting',
      theme: buildFtTheme(),
      routerConfig: router,
    );
  }
}
