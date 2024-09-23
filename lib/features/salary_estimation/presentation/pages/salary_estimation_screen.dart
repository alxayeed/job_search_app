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
        SalarySearchFormWidget(
          jobTitleController: _jobTitleController,
          locationController: _locationController,
          buildContext: context,
        ),
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
}
