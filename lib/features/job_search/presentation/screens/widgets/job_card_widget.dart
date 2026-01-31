import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../domain/entities/job_entity.dart';
import '../../../domain/enums/job_experience.dart';
import '../job_details_screen.dart';

class JobCardWidgetNew extends StatelessWidget {
  final JobEntity job;
  final VoidCallback? onBookmarkTap;

  const JobCardWidgetNew({
    Key? key,
    required this.job,
    this.onBookmarkTap,
  }) : super(key: key);

  String getExperience() {
    if (job.experience == null) return 'N/A';
    switch (job.experience!) {
      case JobExperience.noExperience:
        return 'No Experience';
      case JobExperience.under3Years:
        return 'Under 3 Years';
      case JobExperience.over3Years:
        return 'Over 3 Years';
    }
  }

  String getSalary() {
    if (job.jobSalaryCurrency != null && job.jobSalaryPeriod != null) {
      return '${job.jobSalaryCurrency} / ${job.jobSalaryPeriod}';
    }
    return '';
  }

  String getPostedTime() {
    if (job.jobPostedAtUtc == null) return '';
    final now = DateTime.now().toUtc();
    final difference = now.difference(job.jobPostedAtUtc!);
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    return '${(difference.inDays / 7).floor()}w ago';
  }

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
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  job.employerLogo != null
                      ? (job.employerLogo!.toLowerCase().endsWith('.svg')
                      ? SvgPicture.network(
                    job.employerLogo!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    placeholderBuilder: (context) =>
                        Icon(Icons.work, size: 50, color: Colors.blueAccent),
                  )
                      : Image.network(
                    job.employerLogo!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error, size: 50, color: Colors.redAccent),
                  ))
                      : Icon(Icons.work, size: 50, color: Colors.blueAccent),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.jobTitle ?? 'Unknown Job',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          job.employerName ?? 'Unknown Company',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      job.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.blueAccent,
                    ),
                    onPressed: onBookmarkTap,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (job.jobIsRemote == true)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Remote', style: TextStyle(color: Colors.blueAccent)),
                    ),
                  if (job.employmentType != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(job.employmentType!.label),
                    ),
                  if (job.experience != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(getExperience()),
                    ),
                  if (job.country != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      margin: const EdgeInsets.only(left: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(job.country!.label),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              if (job.jobDescription != null)
                Text(
                  job.jobDescription!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getSalary(),
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Text(
                    getPostedTime(),
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
