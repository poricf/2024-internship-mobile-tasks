

import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/product/Domain/usecases/delete_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helper/test_helper.mocks.dart';
void main () {
  late MockProductRepository mockProductRepository;
  late DeleteProductUseCase deleteProductUseCase;

  setUp((){
    mockProductRepository =  MockProductRepository(); //
    deleteProductUseCase = DeleteProductUseCase(mockProductRepository); //
  });

  test('', ()async {
    when(
      mockProductRepository.deleteProduct("luck")
    ).thenAnswer((_) async => Right(1));
    final result = await  deleteProductUseCase.call("luck");
    expect(result, Right(1));
  });
  
}
