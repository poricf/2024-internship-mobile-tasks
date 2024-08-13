import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/exceptions.dart';
import 'package:ecommerce/core/errors/falilures.dart';
import 'package:ecommerce/features/product/Data/models/product_model.dart';
import 'package:ecommerce/features/product/Data/repositories/product_repo_implementation.dart';
import 'package:ecommerce/features/product/Domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helper/test_helper.mocks.dart';

void main() {
  late ProductRepositoryImpl productRepositoryImpl;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockRemoteDataSource();
    productRepositoryImpl = ProductRepositoryImpl(
        remoteDataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo);
  });

  const productmodel = ProductModel(
      productid: '1',
      name: 'shoe',
      description: 'Leather shoe',
      price: 200,
      imageUrl: '');

  const productEntity = Product(
      productid: '1',
      name: 'shoe',
      description: 'Leather shoe',
      price: 200,
      imageUrl: '');
  const productid = '1';

  group('should get current product', () {
    test('should return product entity', () async {
      //arrange

      when(mockRemoteDataSource.getProductById(productid))
          .thenAnswer((realInvocation) async => productmodel);

      //act

      final result = await productRepositoryImpl.getProduct(productid);

      //assert

      expect(result, Right(productEntity));
    });

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getProductById(productid))
            .thenThrow(ServerException());

        // act
        final result = await productRepositoryImpl.getProduct(productid);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occurred'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockRemoteDataSource.getProductById(productid))
            .thenThrow(SocketException());

        // act
        final result = await productRepositoryImpl.getProduct(productid);

        // assert
        expect(
            result,
            equals(
                const Left(ConnectionFailure('try again', message: 'Hello'))));
      },
    );
  });
}
