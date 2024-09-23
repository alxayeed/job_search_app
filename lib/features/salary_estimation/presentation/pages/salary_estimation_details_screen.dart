import 'package:flutter/material.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/salary_estimation_entity.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_strings.dart';

class SalaryEstimationDetailsScreen extends StatelessWidget {
  final SalaryEstimationEntity entity;

  const SalaryEstimationDetailsScreen({Key? key, required this.entity})
      : super(key: key);

  Future<void> _launchURL() async {
    final url = Uri.parse(entity.publisherLink!);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Salary Details'),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: Text('${entity.jobTitle ?? AppStrings.notApplicable}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.grey[300],
              padding: const EdgeInsets.all(16.0),
              child: Text(
                entity.jobTitle ?? 'No Title',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            _buildSection(context, Icons.location_on, 'Location',
                entity.location ?? 'No Location'),
            const SizedBox(height: 8.0),
            _buildClickableSection(context, Icons.business, 'Publisher',
                entity.publisherName ?? 'No Publisher',
                onTap: _launchURL),
            const SizedBox(height: 8.0),
            _buildSection(context, Icons.trending_down, 'Min Salary',
                '${entity.minimumSalary?.toStringAsFixed(2) ?? '0.00'}',
                color: Colors.green),
            const SizedBox(height: 8.0),
            _buildSection(context, Icons.trending_up, 'Max Salary',
                '${entity.maximumSalary?.toStringAsFixed(2) ?? '0.00'}',
                color: Colors.red),
            const SizedBox(height: 8.0),
            _buildSection(context, Icons.trending_flat, 'Median Salary',
                '${entity.medianSalary?.toStringAsFixed(2) ?? '0.00'}',
                color: Colors.blue),
            const SizedBox(height: 8.0),
            _buildSection(context, Icons.calendar_today, 'Salary Period',
                entity.salaryPeriod ?? 'Not Specified'),
            const SizedBox(height: 8.0),
            _buildSection(context, Icons.money, 'Currency',
                entity.salaryCurrency ?? 'USD'),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, IconData icon, String title, String content,
      {Color color = Colors.black87}) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 24.0),
          const SizedBox(width: 16.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text(content,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableSection(
    BuildContext context,
    IconData icon,
    String title,
    String content, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 24.0),
            const SizedBox(width: 16.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    content,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
