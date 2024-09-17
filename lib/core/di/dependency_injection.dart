import 'package:get_it/get_it.dart';
import 'package:job_search_app/features/job_search/data/datasources/job_local_data_source.dart';
import 'package:job_search_app/features/job_search/domain/usecases/toggle_bookmark_use_case.dart';

import '../../features/job_search/data/datasources/job_remote_data_source.dart';
import '../../features/job_search/data/repositories/job_repository_impl.dart';
import '../../features/job_search/domain/repositories/job_repository.dart';
import '../../features/job_search/domain/usecases/fetch_job_use_case.dart';
import '../../features/job_search/domain/usecases/get_job_details_use_case.dart';
import '../../features/job_search/presentation/blocs/job_search_bloc.dart';
import '../services/dio_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize Dio service
  sl.registerLazySingleton<DioService>(() => DioService());
  // sl.registerLazySingleton<IsarService>(() => IsarService());

  // Initialize remote data source
  sl.registerLazySingleton<JobRemoteDataSource>(
      () => JobRemoteDataSource(sl<DioService>().createDio()));

  // Initialize local data source
  sl.registerLazySingleton<JobLocalDataSource>(() => JobLocalDataSource.new());

  // Initialize repository
  sl.registerLazySingleton<JobRepository>(
    () => JobRepositoryImpl(
      remoteDataSource: sl<JobRemoteDataSource>(),
      localDataSource: sl<JobLocalDataSource>(),
    ),
  );

  // Initialize use cases
  sl.registerLazySingleton(() => FetchJobsUseCase(sl<JobRepository>()));
  sl.registerLazySingleton(() => GetJobDetailsUseCase(sl<JobRepository>()));
  sl.registerLazySingleton(() => ToggleBookmarkUseCase(sl<JobRepository>()));

  // Initialize BLoC
  sl.registerFactory(() => JobSearchBloc(
        searchJobs: sl<FetchJobsUseCase>(),
        getJobDetailsUseCase: sl<GetJobDetailsUseCase>(),
        toggleBookmarkUseCase: sl<ToggleBookmarkUseCase>(),
      ));
}
