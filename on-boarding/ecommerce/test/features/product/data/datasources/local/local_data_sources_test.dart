import 'package:ecommerce/core/errors/exceptions.dart';
import 'package:ecommerce/features/product/Data/datasources/local/local_data_sources.dart';
import 'package:ecommerce/features/product/Data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helper/Dummy/json_reader.dart';
import '../../../../../helper/test_helper.mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late LocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSourceImpl =
        LocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('get last product', () {
    test('should return product model if there is one in shared preference',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(readJson('helper/Dummy/product_model.json'));

      //act
      final result = await localDataSourceImpl.getProduct();

      //assert
      expect(result, isA<ProductModel>());
    });

    test('should return exception if the cache is empty', () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      //act
      final call = localDataSourceImpl.getProduct;

      //assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });
}
