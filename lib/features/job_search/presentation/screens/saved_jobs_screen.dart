import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CustomAppBar(appBarTitle: "Saved Jobs"),
        ],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Center(child: Text("Saved Jobs Screen"))],
        ), // Main content goes here
      ),
    );
  }
}
