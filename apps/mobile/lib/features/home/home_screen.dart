import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freedomtree_mobile/app/theme.dart';
import 'package:freedomtree_mobile/core/storage/app_database.dart';
import 'package:freedomtree_mobile/core/storage/surveys_dao.dart';
import 'package:freedomtree_mobile/core/sync/sync_engine.dart';
import 'package:freedomtree_mobile/features/auth/auth_controller.dart';
import 'package:freedomtree_mobile/features/profile/profile_screen.dart';
import 'package:freedomtree_mobile/features/reports/report_enums.dart';
import 'package:freedomtree_mobile/features/reports/report_form_screen.dart';
import 'package:freedomtree_mobile/features/reports/reports_repository.dart';
import 'package:freedomtree_mobile/features/surveys/education_survey_form_screen.dart';
import 'package:freedomtree_mobile/features/surveys/maternal_survey_form_screen.dart';
import 'package:freedomtree_mobile/shared/ft_logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.authController,
    required this.reportsRepository,
    required this.syncEngine,
    required this.surveysDao,
    required this.apiDio,
  });

  final AuthController authController;
  final ReportsRepository reportsRepository;
  final SyncEngine syncEngine;
  final SurveysDao surveysDao;
  final Dio apiDio;

  @override
  Widget build(BuildContext context) {
    final user = authController.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const FtLogo(height: 18),
        actions: [
          // Profile icon
          IconButton(
            icon: const Icon(Icons.person_outline),
            tooltip: 'Profile',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(
                    authController: authController,
                    apiDio: apiDio,
                  ),
                ),
              );
            },
          ),
          // Sync status indicator + manual sync trigger
          ListenableBuilder(
            listenable: syncEngine,
            builder: (context2, child) {
              if (syncEngine.state == SyncState.syncing) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: FtColors.orange)),
                );
              }
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: const Icon(Icons.sync),
                    tooltip: 'Sync now',
                    onPressed: syncEngine.syncPending,
                  ),
                  if (syncEngine.pendingCount > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(color: FtColors.orange, shape: BoxShape.circle),
                        child: Text('${syncEngine.pendingCount}', style: const TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                    ),
                ],
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
            onPressed: authController.signOut,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user != null) ...[
                  Text('Welcome, ${user.name}', style: Theme.of(context).textTheme.titleLarge),
                  Text(user.position, style: const TextStyle(color: FtColors.greyMedium)),
                  const SizedBox(height: 16),
                ],
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('New monthly report'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ReportFormScreen(
                          authController: authController,
                          reportsRepository: reportsRepository,
                        ),
                      ),
                    ).then((_) => syncEngine.syncPending());
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.school),
                  label: const Text('New education survey'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EducationSurveyFormScreen(
                          authController: authController,
                          surveysDao: surveysDao,
                        ),
                      ),
                    ).then((_) => syncEngine.syncPending());
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.favorite),
                  label: const Text('New maternal health survey'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MaternalSurveyFormScreen(
                          authController: authController,
                          surveysDao: surveysDao,
                        ),
                      ),
                    ).then((_) => syncEngine.syncPending());
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: StreamBuilder<List<LocalReport>>(
              stream: reportsRepository.watchAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final reports = snapshot.data ?? [];
                if (reports.isEmpty) {
                  return const Center(
                    child: Text('No reports yet.\nTap "New monthly report" to get started.',
                        textAlign: TextAlign.center),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: reports.length,
                  separatorBuilder: (context2, i2) => const Divider(height: 1),
                  itemBuilder: (context, i) => _ReportTile(report: reports[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportTile extends StatelessWidget {
  const _ReportTile({required this.report});
  final LocalReport report;

  @override
  Widget build(BuildContext context) {
    final month = reportingMonths[report.reportingMonth.month - 1];
    final year = report.reportingMonth.year;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('$month $year — ${report.community}'),
      subtitle: Text('${report.maternalDeaths} maternal · ${report.infantDeathsTotal} infant deaths'),
      trailing: _SyncBadge(status: report.syncStatus),
    );
  }
}

class _SyncBadge extends StatelessWidget {
  const _SyncBadge({required this.status});
  final SyncStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      SyncStatus.synced => ('Synced', FtColors.green),
      SyncStatus.pending => ('Pending', FtColors.yellow),
      SyncStatus.syncing => ('Syncing…', FtColors.orange),
      SyncStatus.failed => ('Failed', FtColors.darkOrange),
      SyncStatus.draft => ('Draft', FtColors.greyLight),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withAlpha(30), border: Border.all(color: color), borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}
