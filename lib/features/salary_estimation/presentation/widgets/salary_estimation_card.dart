import 'package:flutter/material.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/salary_estimation_entity.dart';

import '../pages/salary_estimation_details_screen.dart';

class SalaryEstimationCard extends StatelessWidget {
  final SalaryEstimationEntity entity;

  const SalaryEstimationCard({Key? key, required this.entity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalaryEstimationDetailsScreen(entity: entity),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.monetization_on,
                    size: 36.0, color: Colors.white),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entity.jobTitle ?? 'No Title',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Location: ${entity.location ?? 'No Location'}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Publisher: ${entity.publisherName ?? 'No Publisher'}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Min Salary: \$${entity.minimumSalary?.toStringAsFixed(2) ?? '0.00'}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.green),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Max Salary: \$${entity.maximumSalary?.toStringAsFixed(2) ?? '0.00'}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
