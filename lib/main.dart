import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'core/services/services.dart';
import 'features/job_search/presentation/blocs/job_search_bloc.dart';

import 'package:job_search_app/core/di/dependency_injection.dart' as di;

import 'core/firebase/firebase_options.dart';
import 'features/job_search/presentation/screens/job_search_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final storageService = GetStorageService();
  await storageService.init();
  Bloc.observer = AppBlocObserver();
  runApp(MyJobApp());
}

class MyJobApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<JobSearchBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: JobSearchScreen(), // Initial screen
      ),
    );
  }
}
