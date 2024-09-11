import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:job_search_app/features/job_search/presentation/pages/job_search_screen.dart';
import 'features/job_search/presentation/blocs/job_search_bloc.dart';

import 'package:job_search_app/core/di/dependency_injection.dart' as di;

import 'core/firebase/firebase_options.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyJobApp());
}

class MyJobApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => GetIt.instance<JobSearchBloc>(),
        child: JobSearchScreen(),
      ),
    );
  }
}
