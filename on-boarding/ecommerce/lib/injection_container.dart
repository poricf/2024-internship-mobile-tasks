import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/connectivity_checker.dart';
import 'features/product/Data/datasources/local/local_data_sources.dart';
import 'features/product/Data/datasources/remote/remote_datasource.dart';
import 'features/product/Data/repositories/product_repo_implementation.dart';
import 'features/product/Domain/repositories/product_repository.dart';
import 'features/product/Domain/usecases/product_usecase.dart';
import 'features/product/Presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Register InternetConnectionChecker
  sl.registerLazySingleton(() => InternetConnectionChecker());

  // Register NetworkInfo
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  // Register http.Client
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Register DataSources
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));

  // Register Repository
  sl.registerFactory<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ) as ProductRepository,
  );

  // Register Usecases
  sl.registerLazySingleton(() => ProductUsecase(productRepository: sl()));

  // Register BLoC
  sl.registerFactory(() => ProductBloc(productUsecases: sl()));
}
