import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

import '../../domain/entities/job_entity.dart';
import '../blocs/job_search_bloc.dart';
import '../blocs/job_search_event.dart';
import '../blocs/job_search_state.dart';
import '../widgets/widgets.dart';

class BookmarkedJobsScreen extends StatelessWidget {
  const BookmarkedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sl = GetIt.instance;

    return Scaffold(
      drawer: AppDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CustomAppBar(appBarTitle: "Saved Jobs"),
        ],
        body: BlocProvider.value(
          value: sl<JobSearchBloc>()..add(GetBookmarkedJobsEvent()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: BlocBuilder<JobSearchBloc, JobSearchState>(
                  builder: (context, state) {
                    if (state is BookmarkedJobsLoading) {
                      return Center(
                        child: Lottie.asset(
                          'assets/loading.json',
                          width: 200,
                          height: 200,
                        ),
                      );
                    } else if (state is BookmarkedJobsErrorState) {
                      return _buildErrorState(state);
                    } else if (state is BookmarkedJobsLoaded) {
                      if (state.jobs.isNotEmpty) {
                        return ListView.builder(
                          padding: EdgeInsets.all(16.0),
                          itemCount: state.jobs.length,
                          itemBuilder: (context, index) {
                            final JobEntity job = state.jobs[index];
                            return JobCard(job: job);
                          },
                        );
                      } else {
                        print("NO JOBS FOUND");
                        return Center(
                          child: Text(
                            'No jobs found in bookmark',
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }
                    }
                    return Center(
                      child: Text(
                        'No jobs found in bookmark',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ), // Main content goes here
      ),
    );
  }

  Widget _buildErrorState(BookmarkedJobsErrorState state) {
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
            state.message.toString(),
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
