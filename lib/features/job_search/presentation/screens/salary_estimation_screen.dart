import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/app_drawer.dart';

class SalaryEstimationScreen extends StatelessWidget {
  const SalaryEstimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(), // Make sure the drawer is included here
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CustomAppBar(appBarTitle: "Salary Estimation"),
        ],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Center(child: Text("Salary Estimation Screen"))],
        ), // Main content goes here
      ),
    );
  }
}
