import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/network_info.dart';
import 'features/product/data/data_source/local_data_source/product_local_data_source.dart';
import 'features/product/data/data_source/remote_data_source/product_remote_data_source.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/use_case/delete_product_usecase.dart';
import 'features/product/domain/use_case/get_product_by_id_usecase.dart';
import 'features/product/domain/use_case/get_products_usecase.dart';
import 'features/product/domain/use_case/insert_product_usecase.dart';
import 'features/product/domain/use_case/update_product_usecase.dart';
import 'features/product/presentation/bloc/product_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async{
  // Features - Product

  
  // Bloc
  sl.registerFactory(() => ProductBloc(
      getProductsUsecase: sl(),
      getProductByIdUsecase: sl(),
      insertProductUsecase: sl(),
      updateProductUsecase: sl(),
      deleteProductUsecase: sl()));




  // Usecases
  sl.registerLazySingleton(() => GetProductsUsecase(productRepository: sl()));
  sl.registerLazySingleton(() => GetProductByIdUsecase(productRepository: sl()));
  sl.registerLazySingleton(() => InsertProductUsecase (productRepository: sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase (productRepository: sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase   (productRepository: sl()));




  // Repositories
  sl.registerLazySingleton<ProductRepositories>(() => ProductRepositoryImpl(
      productRemoteDataSource: sl(),
      productLocalDataSource: sl(),
      networkInfo: sl()));



  // Data sources

  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));




  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));




  //external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(()  => sharedPreferences);
  sl.registerLazySingleton(()  => http.Client());
  sl.registerLazySingleton(()  => InternetConnectionChecker());


}
