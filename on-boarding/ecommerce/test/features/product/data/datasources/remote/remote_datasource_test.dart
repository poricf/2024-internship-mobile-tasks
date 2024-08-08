// import 'package:ecommerce/core/constants/constants.dart';
// import 'package:ecommerce/core/errors/exceptions.dart';
// import 'package:ecommerce/features/product/data/datasources/remote/remote_datasource.dart';
// import 'package:ecommerce/features/product/data/models/product_model.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';
//
// import '../../../../../helper/json_reader.dart';
//
// void main() {
//   late MockHttpClient mockHttpClient;
//   late RemoteDataSourceImpl remoteDataSourceImpl;
//
//   setUp(() {
//     mockHttpClient = MockHttpClient();
//     remoteDataSourceImpl = RemoteDataSourceImpl(client: mockHttpClient);
//   });
//
//   const productid = '1';
//
//   group('get product data', () {
//     test('should return 200 as status ok', () async {
//       //arrange
//       when(mockHttpClient.get(Uri.parse(Urls.getProductbyId(productid))))
//           .thenAnswer((_) async => http.Response(
//               readJson('helpers/fixtures/product_model.json'), 200));
//
//       //act
//
//       final result = await remoteDataSourceImpl.getProduct(productid);
//
//       //assert
//       expect(result, isA<ProductModel>());
//     });
//
//     test('should return 404 as status wrong', () async {
//       // arrange
//       when(mockHttpClient.get(Uri.parse(Urls.getProductbyId(productid))))
//           .thenAnswer((_) async => http.Response('Not found', 404));
//
//       //act
//       final result = remoteDataSourceImpl.getProduct(productid);
//
//       //assert
//       expect(result, throwsA(isA<ServerException>()));
//     });
//   });
// }
