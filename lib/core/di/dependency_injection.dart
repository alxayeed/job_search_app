import 'package:get_it/get_it.dart';

import '../../features/job_search/data/datasources/job_remote_data_source.dart';
import '../../features/job_search/data/repositories/job_repository_impl.dart';
import '../../features/job_search/domain/repositories/job_repository.dart';
import '../../features/job_search/domain/usecases/fetch_job_use_case.dart';
import '../../features/job_search/presentation/blocs/job_search_bloc.dart';
import '../services/dio_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize Dio service
  sl.registerLazySingleton<DioService>(() => DioService());

  // Initialize remote data source
  sl.registerLazySingleton<JobRemoteDataSource>(
      () => JobRemoteDataSource(sl<DioService>().createDio()));

  // Initialize repository
  sl.registerLazySingleton<JobRepository>(
      () => JobRepositoryImpl(sl<JobRemoteDataSource>()));

  // Initialize use cases
  sl.registerLazySingleton(() => FetchJobsUseCase(sl<JobRepository>()));

  // Initialize BLoC
  sl.registerFactory(() => JobSearchBloc(searchJobs: sl<FetchJobsUseCase>()));
}
