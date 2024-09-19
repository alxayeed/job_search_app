import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_search_app/core/constants/app_strings.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/entities.dart';
import 'package:job_search_app/features/salary_estimation/presentation/bloc/bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../job_search/presentation/widgets/widgets.dart';
import '../widgets/widgets.dart';

class SalaryEstimationScreen extends StatelessWidget {
  const SalaryEstimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<SalaryEstimationBloc>()..add(ResetSalaryEstimationsEvent()),
      child: Scaffold(
        drawer: AppDrawer(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            CustomAppBar(appBarTitle: AppStrings.salaryEstimation),
          ],
          body: SalaryEstimationBody(),
        ),
      ),
    );
  }
}

class SalaryEstimationBody extends StatefulWidget {
  @override
  _JobSearchBodyState createState() => _JobSearchBodyState();
}

class _JobSearchBodyState extends State<SalaryEstimationBody> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFloatingFilters(),
        Expanded(
          child: BlocBuilder<SalaryEstimationBloc, SalaryEstimationState>(
            builder: (context, state) {
              if (state is SalaryEstimationLoading) {
                return Center(
                  child: Lottie.asset(
                    'assets/loading.json',
                    width: 200,
                    height: 200,
                  ),
                );
              } else if (state is SalaryEstimationError) {
                return _buildErrorState(state);
              } else if (state is SalaryEstimationLoaded) {
                return ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  itemCount: state.salaryEstimations.length,
                  itemBuilder: (context, index) {
                    final SalaryEstimationEntity salaryEstimation =
                        state.salaryEstimations[index];

                    return SalaryEstimationCard(entity: salaryEstimation);
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
              TextField(
                controller: _jobTitleController,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: 'Enter Job Title...',
                  prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                ),
                // onSubmitted: (_) => _searchSalaryEstimation(),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _locationController,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: 'Enter Location...',
                  prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                ),
                onSubmitted: (_) => _searchSalaryEstimation(),
              ),

              SizedBox(height: 10),

              // Search Button
              Center(
                child: ElevatedButton(
                  onPressed: _searchSalaryEstimation,
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
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(SalaryEstimationError state) {
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

  void _searchSalaryEstimation() {
    BlocProvider.of<SalaryEstimationBloc>(context).add(
      //NodeJS Developer
      //New-York, NY, USA
      GetSalaryEstimationsEvent(
        jobTitle: _jobTitleController.text,
        location: _locationController.text,
      ),
    );
  }
}
