import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:job_search_app/core/utils/date_time_extensions.dart';

import '../../domain/entities/job_entity.dart';
import '../screens/job_details_screen.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    required this.job,
  });

  final JobEntity job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailsScreen(jobEntity: job),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: [
            job.employerLogo != null
                ? (job.employerLogo!.toLowerCase().endsWith('.svg')
                ? SvgPicture.network(
              job.employerLogo!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              placeholderBuilder: (context) =>
              const Icon(Icons.work, size: 50, color: Colors.blueAccent),
            )
                : Image.network(
              job.employerLogo!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error, size: 50, color: Colors.redAccent),
            ))
                : const Icon(Icons.work, size: 50, color: Colors.blueAccent),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.jobTitle ?? 'No title',
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    job.employerName ?? 'No employer',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    job.jobCity != null && job.country != null
                        ? "${job.jobCity}, ${job.country?.label ?? ''}"
                        : job.country?.label ?? 'Unknown location',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  if (job.employmentType != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        job.employmentType?.label ?? '',
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    job.jobPostedAtUtc?.format() ?? 'Unknown date',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            if (job.jobApplyLink != null && job.jobApplyLink!.isNotEmpty)
              GestureDetector(
                onTap: () async {
                  final url = Uri.parse(job.jobApplyLink!);
                  if (!await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  )) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Apply Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
