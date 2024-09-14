import 'package:flutter/material.dart';
import 'package:job_search_app/features/job_search/presentation/screens/job_search_screen.dart';
import 'package:job_search_app/features/job_search/presentation/screens/salary_estimation_screen.dart';
import 'package:job_search_app/features/job_search/presentation/screens/saved_jobs_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Text(
              'Hi!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search Job'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return JobSearchScreen();
                }),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('Salary Estimation'),
            onTap: () {
              // Navigator.pop(context);
              // Navigator.pushNamed(context, '/salary-estimation');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SalaryEstimationScreen();
                }),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Saved Jobs'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SavedJobsScreen();
                }),
              );
              // Navigator.pushNamed(context, '/saved-jobs');
            },
          ),
        ],
      ),
    );
  }
}
