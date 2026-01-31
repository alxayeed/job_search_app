import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:job_search_app/features/job_search/presentation/widgets/search_bar_widget.dart';
import 'package:lottie/lottie.dart';
import '../../domain/entities/job_filter_entity.dart';
import '../blocs/job_search_bloc.dart';
import '../blocs/job_search_event.dart';
import '../blocs/job_search_state.dart';
import '../widgets/job_card.dart';
import '../widgets/job_filter_drawer.dart';

final sl = GetIt.instance;

class JobSearchScreen extends StatelessWidget {
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
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87),
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
  final TextEditingController _queryController =
  TextEditingController(text: "Software Engineer");

  JobFilterEntity _filters = JobFilterEntity();

  void _searchJobs() {
    final bloc = BlocProvider.of<JobSearchBloc>(context);
    bloc.add(SearchJobsEvent(
      query: _queryController.text,
      filters: _filters,
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
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .animate(animation),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarWidget(
          controller: _queryController,
          onSearch: _searchJobs,
          onFilterTap: _openFilterDrawer,
          filters: _filters,
        ),
        Expanded(
          child: BlocBuilder<JobSearchBloc, JobSearchState>(
            builder: (context, state) {
              if (state is JobSearchLoading) {
                return Center(
                    child: Lottie.asset('assets/loading.json', width: 200));
              } else if (state is JobSearchError) {
                return Center(child: Text('Error: ${state.failure}'));
              } else if (state is JobSearchLoaded) {
                if (state.jobs.isEmpty)
                  return const Center(child: Text('No jobs found'));
                return ListView.builder(
                  key: ValueKey(state),
                  padding: const EdgeInsets.all(16),
                  itemCount: state.jobs.length,
                  itemBuilder: (context, index) =>
                      JobCard(job: state.jobs[index]),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/search_job.json',),
                  const SizedBox(height: 8),
                  Text(
                    'Search for your next career move',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
                    ),
                  ),
                ],
              );

            },
          ),
        ),
      ],
    );
  }
}
