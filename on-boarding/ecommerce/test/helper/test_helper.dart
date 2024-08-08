import 'package:ecommerce/core/network/connectivity_checker.dart';
import 'package:ecommerce/features/product/Data/datasources/remote/remote_datasource.dart';
import 'package:ecommerce/features/product/Domain/repositories/product_repository.dart';
import 'package:ecommerce/features/product/Domain/usecases/get_product.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';


@GenerateMocks(
  [
    ProductRepository,
    GetProductUseCase,
    RemoteDataSource,
    NetworkInfo,
    InternetConnectionChecker,
    SharedPreferences,
  ],
customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)

void main(){}


  