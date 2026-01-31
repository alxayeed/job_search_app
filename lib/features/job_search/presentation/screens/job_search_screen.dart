import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:job_search_app/features/job_search/presentation/blocs/blocs.dart';
import 'package:job_search_app/features/job_search/presentation/widgets/custom_app_bar.dart';
import 'package:job_search_app/features/job_search/presentation/widgets/app_drawer.dart';
import 'package:job_search_app/features/job_search/presentation/widgets/job_card.dart';
import 'package:lottie/lottie.dart';
import '../../domain/entities/job_entity.dart';
import '../../domain/entities/job_filter_entity.dart';
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

  JobFilterEntity _currentFilters = JobFilterEntity(
    employmentType: EmploymentType.fullTime,
    datePosted: DatePosted.all,
    jobExperience: JobExperience.under3Years,
    jobCountry: JobCountry.bangladesh,
    remoteJobsOnly: false,
    radius: 25.0,
  );

  bool _filtersExpanded = true;

  void _onFilterChanged(JobFilterEntity newFilters) {
    setState(() {
      _currentFilters = newFilters;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchWithFilters(),
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

  Widget _buildSearchWithFilters() {
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
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _queryController,
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Search your next Job...',
                        prefixIcon:
                        Icon(Icons.search, color: Colors.blueAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      ),
                      onSubmitted: (_) => _searchJobs(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _filtersExpanded
                          ? Icons.filter_alt_off
                          : Icons.filter_alt,
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

              if (_filtersExpanded) ...[
                SwitchListTile(
                  title: Text('Remote Jobs Only',
                      style: TextStyle(color: Colors.blueAccent)),
                  value: _currentFilters.remoteJobsOnly,
                  onChanged: (selected) => _onFilterChanged(
                      _currentFilters.copyWith(remoteJobsOnly: selected)),
                  activeThumbColor: Colors.blueAccent,
                  contentPadding: EdgeInsets.zero,
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<EmploymentType>(
                  value: _currentFilters.employmentType,
                  items: EmploymentType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.label,
                          style: TextStyle(color: Colors.blueAccent)),
                    );
                  }).toList(),
                  onChanged: (value) => _onFilterChanged(
                      _currentFilters.copyWith(employmentType: value)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<DatePosted>(
                  value: _currentFilters.datePosted,
                  items: DatePosted.values.map((date) {
                    return DropdownMenuItem(
                      value: date,
                      child: Text(date.label,
                          style: TextStyle(color: Colors.blueAccent)),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      _onFilterChanged(_currentFilters.copyWith(datePosted: value)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<JobExperience>(
                  value: _currentFilters.jobExperience,
                  items: JobExperience.values.map((exp) {
                    return DropdownMenuItem(
                      value: exp,
                      child: Text(exp.label,
                          style: TextStyle(color: Colors.blueAccent)),
                    );
                  }).toList(),
                  onChanged: (value) => _onFilterChanged(
                      _currentFilters.copyWith(jobExperience: value)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<JobCountry>(
                  value: _currentFilters.jobCountry,
                  items: JobCountry.values.map((country) {
                    return DropdownMenuItem(
                      value: country,
                      child: Text(country.label,
                          style: TextStyle(color: Colors.blueAccent)),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      _onFilterChanged(_currentFilters.copyWith(jobCountry: value)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                      padding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'Search',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        remoteJobsOnly: _currentFilters.remoteJobsOnly,
        employmentType: _currentFilters.employmentType,
        datePosted: _currentFilters.datePosted,
        jobExperience: _currentFilters.jobExperience,
        jobCountry: _currentFilters.jobCountry,
      ),
    );
  }
}
