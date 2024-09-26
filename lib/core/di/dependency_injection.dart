import 'package:get_it/get_it.dart';
import 'package:job_search_app/features/job_search/data/datasources/job_local_data_source.dart';
import 'package:job_search_app/features/salary_estimation/data/datasources/datasources.dart';
import 'package:job_search_app/features/salary_estimation/domain/repositories/repositories.dart';
import 'package:job_search_app/features/salary_estimation/domain/usecases/get_salary_estimation_use_case.dart';
import 'package:job_search_app/features/salary_estimation/presentation/bloc/bloc.dart';

import '../../features/job_search/data/datasources/job_remote_data_source.dart';
import '../../features/job_search/data/repositories/job_repository_impl.dart';
import '../../features/job_search/domain/repositories/job_repository.dart';
import '../../features/job_search/domain/usecases/usecases.dart';
import '../../features/job_search/presentation/blocs/job_search_bloc.dart';
import '../../features/salary_estimation/data/repositories/salary_estimation_repository_impl.dart';
import '../services/services.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize Dio service
  sl.registerLazySingleton<DioService>(() => DioService());

  // Initialize StorageService
  sl.registerSingleton<GetStorageService>(GetStorageService());

// Initialize remote data sources using the singleton Dio instance
  sl.registerLazySingleton<JobRemoteDataSource>(
      () => JobRemoteDataSourceImpl(sl<DioService>().dio));

  sl.registerLazySingleton<SalaryEstimationRemoteDatasource>(
      () => SalaryEstimationRemoteDatasource(sl<DioService>().dio));

  // Initialize local data source
  sl.registerLazySingleton<JobLocalDataSource>(
      () => JobLocalDataSourceImpl.new());

  // Initialize repository
  sl.registerLazySingleton<JobRepository>(
    () => JobRepositoryImpl(
      remoteDataSource: sl<JobRemoteDataSource>(),
      localDataSource: sl<JobLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<SalaryEstimationRepository>(
    () => SalaryEstimationRepositoryImpl(
      remoteDataSource: sl<SalaryEstimationRemoteDatasource>(),
    ),
  );

  // Initialize use cases
  sl.registerLazySingleton(() => FetchJobsUseCase(sl<JobRepository>()));
  sl.registerLazySingleton(() => GetJobDetailsUseCase(sl<JobRepository>()));
  sl.registerLazySingleton(() => ToggleBookmarkUseCase(sl<JobRepository>()));
  sl.registerLazySingleton(() => GetBookmarkedJobsUseCase(sl<JobRepository>()));

  sl.registerLazySingleton(
      () => GetSalaryEstimationUseCase(sl<SalaryEstimationRepository>()));

  // Initialize BLoC
  sl.registerFactory(() => JobSearchBloc(
        searchJobs: sl<FetchJobsUseCase>(),
        getJobDetailsUseCase: sl<GetJobDetailsUseCase>(),
        toggleBookmarkUseCase: sl<ToggleBookmarkUseCase>(),
        getBookmarkedJobs: sl<GetBookmarkedJobsUseCase>(),
      ));

  sl.registerFactory(() => SalaryEstimationBloc(
        getSalaryEstimationUseCase: sl<GetSalaryEstimationUseCase>(),
      ));
}
