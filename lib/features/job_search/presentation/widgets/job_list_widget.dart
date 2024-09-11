import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/job_entity.dart';

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
        return Container(
          margin: EdgeInsets.only(bottom: 16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 2),
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
                          placeholderBuilder: (context) => Icon(Icons.work,
                              size: 50, color: Colors.blueAccent),
                        )
                      : Image.network(
                          job.employerLogo!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.error,
                              size: 50,
                              color: Colors.redAccent),
                        ))
                  : Icon(Icons.work, size: 50, color: Colors.blueAccent),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.jobTitle ?? 'No title',
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      job.employerName ?? 'No employer',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.0),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
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
        );
      },
    );
  }
}
