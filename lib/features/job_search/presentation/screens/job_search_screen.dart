import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:job_search_app/features/job_search/presentation/blocs/blocs.dart';
import 'package:job_search_app/features/job_search/presentation/widgets/custom_app_bar.dart';
import 'package:job_search_app/features/job_search/presentation/widgets/app_drawer.dart';
import 'package:job_search_app/features/job_search/presentation/widgets/job_card.dart';
import 'package:lottie/lottie.dart';
import '../../domain/entities/job_entity.dart';
import '../../domain/enums/date_posted.dart';
import '../../domain/enums/employment_type.dart';
import '../../domain/enums/job_country.dart';
import '../../domain/enums/job_experience.dart';

final sl = GetIt.instance;

class JobSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<JobSearchBloc>()..add(ResetJobSearchEvent()),
      child: Scaffold(
        drawer: AppDrawer(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            CustomAppBar(appBarTitle: "Job Search"),
          ],
          body: JobSearchBody(),
        ),
      ),
    );
  }
}

class JobSearchBody extends StatefulWidget {
  @override
  _JobSearchBodyState createState() => _JobSearchBodyState();
}

class _JobSearchBodyState extends State<JobSearchBody> {
  final TextEditingController _queryController =
  TextEditingController(text: "Software Engineer");
  bool _remoteJobsOnly = false;
  EmploymentType? _employmentType = EmploymentType.fullTime;
  DatePosted? _datePosted = DatePosted.all;
  JobExperience? _jobExperience = JobExperience.under3Years;
  JobCountry? _jobCountry = JobCountry.bangladesh;

  bool _filtersExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFloatingFilters(),
        Expanded(
          child: BlocBuilder<JobSearchBloc, JobSearchState>(
            builder: (context, state) {
              if (state is JobSearchLoading) {
                return Center(
                  child: Lottie.asset(
                    'assets/loading.json',
                    width: 200,
                    height: 200,
                  ),
                );
              } else if (state is JobSearchError) {
                return _buildErrorState(state);
              } else if (state is JobSearchLoaded) {
                return ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  itemCount: state.jobs.length,
                  itemBuilder: (context, index) {
                    final JobEntity job = state.jobs[index];
                    return JobCard(job: job);
                  },
                );
              }
              return Center(
                child: Text(
                  'Start your job search',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingFilters() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      margin: EdgeInsets.only(top: 10),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Box with Filter Icon
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _queryController,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Search your next Job...',
                        prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      ),
                      onSubmitted: (_) => _searchJobs(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _filtersExpanded ? Icons.filter_alt_off : Icons.filter_alt,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {
                      setState(() {
                        _filtersExpanded = !_filtersExpanded;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Filters Section (Expandable)
              if (_filtersExpanded) ...[
                SwitchListTile(
                  title: Text('Remote Jobs Only',
                      style: TextStyle(color: Colors.blueAccent)),
                  value: _remoteJobsOnly,
                  onChanged: (bool selected) {
                    setState(() {
                      _remoteJobsOnly = selected;
                    });
                  },
                  activeThumbColor: Colors.blueAccent,
                  contentPadding: EdgeInsets.zero,
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<EmploymentType>(
                  initialValue: _employmentType,
                  items: EmploymentType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.label, style: TextStyle(color: Colors.blueAccent)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _employmentType = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<DatePosted>(
                  initialValue: _datePosted,
                  items: DatePosted.values.map((date) {
                    return DropdownMenuItem(
                      value: date,
                      child: Text(date.label, style: TextStyle(color: Colors.blueAccent)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _datePosted = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<JobExperience>(
                  initialValue: _jobExperience,
                  items: JobExperience.values.map((exp) {
                    return DropdownMenuItem(
                      value: exp,
                      child: Text(exp.label, style: TextStyle(color: Colors.blueAccent)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _jobExperience = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<JobCountry>(
                  initialValue: _jobCountry,
                  items: JobCountry.values.map((country) {
                    return DropdownMenuItem(
                      value: country,
                      child: Text(country.label, style: TextStyle(color: Colors.blueAccent)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _jobCountry = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: _searchJobs,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(JobSearchError state) {
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
  }

  void _searchJobs() {
    BlocProvider.of<JobSearchBloc>(context).add(
      SearchJobsEvent(
        query: _queryController.text,
        remoteJobsOnly: _remoteJobsOnly,
        employmentType: _employmentType,
        datePosted: _datePosted,
        jobExperience: _jobExperience,
        jobCountry: _jobCountry,
      ),
    );
  }
}
