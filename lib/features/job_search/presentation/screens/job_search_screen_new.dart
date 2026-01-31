import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import '../../domain/entities/job_filter_entity.dart';
import '../../domain/enums/date_posted.dart';
import '../../domain/enums/employment_type.dart';
import '../../domain/enums/job_country.dart';
import '../../domain/enums/job_experience.dart';
import '../blocs/job_search_bloc.dart';
import '../blocs/job_search_event.dart';
import '../blocs/job_search_state.dart';
import 'widgets/job_card_widget.dart';
import 'widgets/job_filter_drawer.dart';

final sl = GetIt.instance;

class JobSearchScreenNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<JobSearchBloc>()..add(ResetJobSearchEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: const Text(
                'Job Search',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              floating: true,
              pinned: true,
              centerTitle: true,
            ),
          ],
          body: JobSearchBodyNew(),
        ),
      ),
    );
  }
}

class JobSearchBodyNew extends StatefulWidget {
  @override
  _JobSearchBodyNewState createState() => _JobSearchBodyNewState();
}

class _JobSearchBodyNewState extends State<JobSearchBodyNew> {
  final TextEditingController _queryController = TextEditingController(text: "Software Engineer");

  JobFilterEntity _filters = JobFilterEntity(
    jobCountry: JobCountry.bangladesh,
    datePosted: DatePosted.all,
    employmentType: EmploymentType.fullTime,
    jobExperience: JobExperience.under3Years,
    remoteJobsOnly: false,
    radius: 25,
  );

  void _searchJobs() {
    final bloc = BlocProvider.of<JobSearchBloc>(context);
    bloc.add(SearchJobsEvent(
      query: _queryController.text,
      jobCountry: _filters.jobCountry,
      datePosted: _filters.datePosted,
      employmentType: _filters.employmentType,
      jobExperience: _filters.jobExperience,
      remoteJobsOnly: _filters.remoteJobsOnly,
    ));
  }

  void _openFilterDrawer() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Filter',
      barrierColor: Colors.black.withValues(alpha: 0.4),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: JobFilterDrawer(
              currentFilters: _filters,
              onChange: (updatedFilters) {
                setState(() {
                  _filters = updatedFilters;
                });
              },
              onApply: () {
                Navigator.of(context).pop();
                _searchJobs();
              },
              onReset: () {
                setState(() {
                  _filters = JobFilterEntity(
                    jobCountry: JobCountry.bangladesh,
                    datePosted: DatePosted.all,
                    employmentType: EmploymentType.fullTime,
                    jobExperience: JobExperience.under3Years,
                    remoteJobsOnly: false,
                    radius: 25,
                  );
                });
                Navigator.of(context).pop();
                _searchJobs();
              },
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarWidgetNew(
          controller: _queryController,
          onSearch: _searchJobs,
          onFilterTap: _openFilterDrawer,
        ),
        Expanded(
          child: BlocBuilder<JobSearchBloc, JobSearchState>(
            builder: (context, state) {
              if (state is JobSearchLoading) {
                return Center(child: Lottie.asset('assets/loading.json', width: 200));
              } else if (state is JobSearchError) {
                return Center(child: Text('Error: ${state.failure}'));
              } else if (state is JobSearchLoaded) {
                if (state.jobs.isEmpty) return const Center(child: Text('No jobs found'));
                return ListView.builder(
                  key: ValueKey(state),
                  padding: const EdgeInsets.all(16),
                  itemCount: state.jobs.length,
                  itemBuilder: (context, index) => JobCardWidgetNew(job: state.jobs[index]),
                );
              }
              return const Center(child: Text('Search for your next career move'));
            },
          ),
        ),
      ],
    );
  }
}

class SearchBarWidgetNew extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onFilterTap;

  const SearchBarWidgetNew({
    required this.controller,
    required this.onSearch,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Job title or keywords',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onFilterTap,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Icon(Icons.tune, color: Color(0xFF0066FF)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onSearch,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text(
                "Search Jobs",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
