import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:job_search_app/core/constants/app_strings.dart';
import 'package:job_search_app/features/job_search/presentation/blocs/blocs.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/job_entity.dart';
import 'package:get_it/get_it.dart';
import '../widgets/show_field_widget.dart';

final sl = GetIt.instance;

class JobDetailsScreen extends StatefulWidget {
  final JobEntity jobEntity;

  const JobDetailsScreen({required this.jobEntity, super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  final jobSearchBloc = sl<JobSearchBloc>();

  @override
  void initState() {
    super.initState();
    jobSearchBloc.add(JobDetailsRequested(jobId: widget.jobEntity.jobId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: jobSearchBloc,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          title: Text(widget.jobEntity.jobTitle ?? AppStrings.notApplicable),
          actions: [
            IconButton(
              onPressed: () {
                final link = widget.jobEntity.jobApplyLink;
                if (link != null && link.isNotEmpty) {
                  Share.share(link,
                      subject: 'Check out this job: ${widget.jobEntity.jobTitle}');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Job link is not available')),
                  );
                }
              },
              icon: const Icon(Ionicons.share_social_outline),
            ),
          ],
        ),
        body: Stack(
          children: [
            BlocBuilder<JobSearchBloc, JobSearchState>(
              builder: (context, state) {
                if (state is JobDetailsLoading) {
                  return Center(
                    child: Lottie.asset(
                      'assets/loading.json',
                      width: 300,
                      height: 300,
                    ),
                  );
                } else if (state is JobSearchError) {
                  return Center(child: Text(state.failure.toString()));
                } else if (state is JobDetailsLoaded ||
                    state is BookmarkAddedState ||
                    state is BookmarkRemovedState) {
                  final job = state is JobDetailsLoaded
                      ? state.job
                      : state is BookmarkAddedState
                      ? state.job
                      : (state as BookmarkRemovedState).job;
                  return JobDetailsWidget(job: job);
                }
                return const Center(child: Text("Nothing found"));
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BlocConsumer<JobSearchBloc, JobSearchState>(
                listener: (context, state) {
                  if (state is BookmarkAddedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Added to bookmarks'),
                        backgroundColor: Colors.blueAccent,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                  if (state is BookmarkRemovedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Removed from bookmarks'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  JobEntity job = widget.jobEntity;
                  if (state is BookmarkAddedState || state is BookmarkRemovedState) {
                    job = state is BookmarkAddedState ? state.job : (state as BookmarkRemovedState).job;
                  } else if (state is JobDetailsLoaded) {
                    job = state.job;
                  }
                  return Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          jobSearchBloc.add(BookmarkJobEvent(job: job));
                        },
                        icon: Icon(
                          job.isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                          size: 38,
                          color: job.isBookmarked ? Colors.red : null,
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: const Text('Apply Now'),
                          onPressed: () async {
                            final link = job.jobApplyLink;
                            if (link != null && link.isNotEmpty) {
                              final url = Uri.parse(link);
                              if (!await launchUrl(url,
                                  mode: LaunchMode.externalApplication)) {
                                throw Exception('Could not launch $url');
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobDetailsWidget extends StatelessWidget {
  final JobEntity job;

  const JobDetailsWidget({required this.job, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (job.employerLogo != null)
            Image.network(job.employerLogo!, height: 100, width: 100),
          const SizedBox(height: 16),
          const Text('Job Title:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(job.jobTitle ?? 'N/A', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Employer Name:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(job.employerName ?? 'N/A', style: TextStyle(fontSize: 18, color: Colors.grey[700])),
          const SizedBox(height: 16),
          ShowFieldInfo(
            fieldName: 'Employment Type:',
            value: job.employmentType?.label ?? 'N/A',
          ),
          ShowFieldInfo(
            fieldName: 'Remote:',
            value: job.jobIsRemote != null ? (job.jobIsRemote! ? 'Yes' : 'No') : 'N/A',
          ),
          ShowFieldInfo(
            fieldName: 'Location:',
            value: job.jobCity != null && job.country != null
                ? '${job.jobCity}, ${job.country?.label ?? ''}'
                : 'N/A',
          ),
          ShowFieldInfo(
            fieldName: 'Experience:',
            value: job.experience != null ? job.experience!.label : 'N/A',
          ),
          const SizedBox(height: 16),
          const Text('Description:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(job.jobDescription ?? 'N/A'),
          const SizedBox(height: 16),
          if (job.jobSalaryCurrency != null && job.jobSalaryPeriod != null)
            ShowFieldInfo(
              fieldName: 'Salary:',
              value: '${job.jobSalaryCurrency!} per ${job.jobSalaryPeriod!}',
            ),
          if (job.jobHighlights?.qualifications != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Qualifications:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                for (var q in job.jobHighlights?.qualifications ?? [])
                  Text('- ${q ?? 'N/A'}'),
              ],
            ),
          if (job.jobHighlights?.responsibilities != null && job.jobHighlights!.responsibilities!.isNotEmpty)
            const SizedBox(height: 10),
          if (job.jobHighlights?.responsibilities != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Responsibilities:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                for (var r in job.jobHighlights?.responsibilities ?? [])
                  Text('- ${r ?? 'N/A'}'),
              ],
            ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
