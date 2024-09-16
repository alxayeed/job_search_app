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
import 'package:job_search_app/core/utils/experience_month_to_year.dart';

final sl = GetIt.instance;

class JobDetailsScreen extends StatelessWidget {
  final JobEntity jobEntity;

  JobDetailsScreen({required this.jobEntity});

  @override
  Widget build(BuildContext context) {
    final jobSearchBloc = sl<JobSearchBloc>();

    jobSearchBloc.add(JobDetailsRequested(jobId: jobEntity.jobId));

    return BlocProvider.value(
      value: jobSearchBloc,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          title: Text('${jobEntity.jobTitle ?? AppStrings.notApplicable}'),
          actions: [
            IconButton(
              onPressed: () {
                if (jobEntity.jobApplyLink != null) {
                  Share.share(
                    jobEntity.jobApplyLink!,
                    subject: 'Check out this job: ${jobEntity.jobTitle}',
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Job link is not available')),
                  );
                }
              },
              icon: Icon(
                Ionicons.share_social_outline,
              ),
            ),
          ],
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
              JobEntity job = state.job;
              print(job.isBookmarked);
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (job.employerLogo != null)
                          Image.network(
                            job.employerLogo!,
                            height: 100,
                            width: 100,
                          ),
                        SizedBox(height: 16),
                        Text(
                          'Job Title:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          job.jobTitle ?? 'N/A',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Employer Name:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          job.employerName ?? 'N/A',
                          style:
                          TextStyle(fontSize: 18, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 16),
                        ShowFieldInfo(
                          fieldName: 'Employment Type:',
                          value: job.jobEmploymentType ?? 'N/A',
                        ),
                        ShowFieldInfo(
                          fieldName: 'Remote:',
                          value: job.jobIsRemote != null
                              ? (job.jobIsRemote! ? 'Yes' : 'No')
                              : 'N/A',
                        ),
                        ShowFieldInfo(
                          fieldName: 'Location:',
                          value: job.jobCity != null && job.jobCountry != null
                              ? '${job.jobCity}, ${job.jobCountry}'
                              : 'N/A',
                        ),
                        ShowFieldInfo(
                          fieldName: 'Experience:',
                          value: job.jobRequiredExperience != null
                              ? job.jobRequiredExperience!.noExperienceRequired!
                              ? 'No Experience Required'
                              : '${job.jobRequiredExperience!.requiredExperienceInMonths?.convertToYear()} years'
                              : 'N/A',
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Description:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(job.jobDescription ?? 'N/A'),
                        SizedBox(height: 16),
                        if (job.jobSalaryCurrency != null &&
                            job.jobSalaryPeriod != null)
                          ShowFieldInfo(
                            fieldName: 'Salary:',
                            value:
                            '${job.jobSalaryCurrency ?? ''} per ${job.jobSalaryPeriod ?? ''}',
                          ),
                        if (job.jobHighlights?.qualifications != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Qualifications:',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              for (var qualification
                              in job.jobHighlights?.qualifications ?? [])
                                Text('- ${qualification ?? 'N/A'}'),
                            ],
                          ),
                        if (job.jobHighlights?.responsibilities != null &&
                            job.jobHighlights!.responsibilities!.isNotEmpty)
                          SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Responsibilities:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            for (var responsibility
                            in job.jobHighlights?.responsibilities ?? [])
                              Text('- ${responsibility ?? 'N/A'}'),
                          ],
                        ),
                        SizedBox(
                            height: 80), // To ensure button does not overlap
                      ],
                    ),
                  ),
                  if (job.jobApplyLink != null)
                    BlocBuilder<JobSearchBloc, JobSearchState>(
                      builder: (context, state) {
                        if (state is JobDetailsLoaded) {
                          return Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.only(right: 8.0),
                              color: Colors.white,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      jobSearchBloc.add(BookmarkJobEvent(job: job));
                                    },
                                    icon: Icon(
                                      job.isBookmarked
                                          ? Icons.bookmark
                                          : Icons.bookmark_outline,
                                      size: 38,
                                      color: job.isBookmarked ? Colors.red : null,
                                    ),
                                  ),
                                  Expanded(
                                    child: MaterialButton(
                                      color: Colors.blue, // Button color
                                      textColor: Colors.white,
                                      child: Text('Apply Now'),
                                      onPressed: () async {
                                        final url = Uri.parse(job.jobApplyLink!);
                                        if (!await launchUrl(
                                          url,
                                          mode: LaunchMode.externalApplication,
                                        )) {
                                          throw Exception('Could not launch $url');
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return SizedBox
                            .shrink(); // Return an empty widget if the button should not be shown
                      },
                    ),
                ],
              );
            }
            return Center(
              child: Text('No details available.'),
            );
          },
        ),
      ),
    );
  }
}
