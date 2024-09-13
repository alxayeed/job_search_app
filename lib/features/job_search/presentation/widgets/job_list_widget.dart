import 'package:flutter/material.dart';
import '../../domain/entities/job_entity.dart';
import 'job_card.dart';

class JobListWidget extends StatelessWidget {
  final List<JobEntity> jobs;

  JobListWidget({required this.jobs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final JobEntity job = jobs[index];
        return JobCard(job: job);
      },
    );
  }
}
