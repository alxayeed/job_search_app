import 'package:flutter/material.dart';
import 'package:job_search_app/core/services/app_info_service.dart';
import 'package:job_search_app/features/job_search/presentation/screens/bookmarked_jobs_screen.dart';
import '../../../../core/screens/settings_screen.dart';
import '../../../salary_estimation/presentation/pages/salary_estimation_screen.dart';
import '../screens/job_search_screen.dart';
import '../screens/job_search_screen_new.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.lightBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Text(
                    'Job Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('Search Job'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JobSearchScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('Search Job(New)'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JobSearchScreenNew(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.monetization_on),
                  title: const Text('Salary Estimation'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SalaryEstimationScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.bookmark),
                  title: const Text('Saved Jobs'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookmarkedJobsScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: FutureBuilder<AppVersion>(
              future: AppInfoService().getVersion(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }
                return Text(
                  snapshot.data.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
