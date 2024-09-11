import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../blocs/job_search_bloc.dart';
import '../blocs/job_search_event.dart';
import '../blocs/job_search_state.dart';
import '../widgets/job_list_widget.dart';

class JobSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Search'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: JobSearchBody(),
    );
  }
}

class JobSearchBody extends StatefulWidget {
  @override
  _JobSearchBodyState createState() => _JobSearchBodyState();
}

class _JobSearchBodyState extends State<JobSearchBody> {
  final TextEditingController _queryController = TextEditingController();
  bool _remoteJobsOnly = false;
  String _employmentType = 'FULLTIME';
  String _datePosted = 'all';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              TextField(
                controller: _queryController,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search your next Job...',
                  suffixIcon: Icon(Icons.search, color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                ),
                onSubmitted: (_) => _searchJobs(),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: FilterChip(
                      label: Text('Remote Jobs Only'),
                      selected: _remoteJobsOnly,
                      onSelected: (bool selected) {
                        setState(() {
                          _remoteJobsOnly = selected;
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: Colors.blueAccent.withOpacity(0.2),
                      checkmarkColor: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _employmentType,
                      items: [
                        DropdownMenuItem(
                          child: Text('Full-Time'),
                          value: 'FULLTIME',
                        ),
                        DropdownMenuItem(
                          child: Text('Part-Time'),
                          value: 'PARTTIME',
                        ),
                        DropdownMenuItem(
                          child: Text('Contract'),
                          value: 'CONTRACT',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _employmentType = value!;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _searchJobs,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(30.0),
                  // ),
                  side: BorderSide(color: Colors.blueAccent),
                ),
                child: Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<JobSearchBloc, JobSearchState>(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: Colors.red, size: 48),
                      SizedBox(height: 8),
                      Text(
                        'Something went wrong!',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                      SizedBox(height: 4),
                      Text(
                        state.failure.toString(),
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              } else if (state is JobSearchLoaded) {
                return JobListWidget(jobs: state.jobs);
              }
              return Center(child: Text('Start your job search'));
            },
          ),
        ),
      ],
    );
  }

  void _searchJobs() {
    BlocProvider.of<JobSearchBloc>(context).add(
      SearchJobsEvent(
        query: _queryController.text,
        remoteJobsOnly: _remoteJobsOnly,
        employmentType: _employmentType,
        datePosted: _datePosted,
      ),
    );
  }
}
