import 'dart:convert';

import 'package:ecommerce/features/product/Data/models/product_model.dart';
import 'package:ecommerce/features/product/Domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/Dummy/json_reader.dart';

void main() {
  ProductModel productModel = ProductModel(
      productid: '1',
      name: 'Shoe',
      description: 'Leather Shoe',
      price: 200,
      imageUrl: 'gg');

  test('should be an instance of product entity', () {
    expect(productModel, isA<Product>());
  });

  test('should map correctly', () async {
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helper/Dummy/product_model.json'));
    final result = ProductModel.fromJson(jsonMap);
    expect(result, equals(productModel));
  });

  test('should map tojson correctly', () async {
    final result = productModel.toJson();
    final expectedMap = {
      'productid': '1',
      'name': 'Shoe',
      'description': 'Leather Shoe',
      'price': 200,
      'imageUrl': 'gg'
    };

    expect(result, equals(expectedMap));
  });
}
