import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_search_app/core/constants/app_strings.dart';
import 'package:lottie/lottie.dart';
import '../../domain/entities/job_entity.dart';
import '../blocs/job_search_bloc.dart';
import '../blocs/job_search_event.dart';
import '../blocs/job_search_state.dart';
import 'package:get_it/get_it.dart';

// Access the service locator instance
final sl = GetIt.instance;

class JobDetailsScreen extends StatelessWidget {
  final JobEntity job;

  JobDetailsScreen({required this.job});

  @override
  Widget build(BuildContext context) {
    // Retrieve the JobSearchBloc instance using sl<>
    final jobSearchBloc = sl<JobSearchBloc>();

    // Trigger the event for fetching job details
    jobSearchBloc.add(JobDetailsRequested(jobId: job.jobId));

    return BlocProvider.value(
      value: jobSearchBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${job.jobTitle ?? AppStrings.notApplicable}'),
        ),
        body: BlocBuilder<JobSearchBloc, JobSearchState>(
          builder: (context, state) {
            if (state is JobSearchLoading) {
              return Center(
                child: Lottie.asset(
                  'assets/loading.json',
                  width: 300,
                  height: 300,
                ),
              );
            } else if (state is JobSearchError) {
              return Center(
                child: Text(state.failure.toString()),
              );
            } else if (state is JobDetailsLoaded) {
              return _buildJobDetails(state.job);
            }
            return Center(
              child: Text('No details available.'),
            );
          },
        ),
      ),
    );
  }

  Widget _buildJobDetails(JobEntity job) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            job.jobTitle ?? 'N/A',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            job.employerName ?? 'N/A',
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
          SizedBox(height: 16),
          Text(job.jobDescription ?? 'N/A'),
        ],
      ),
    );
  }
}
