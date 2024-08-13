

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../Domain/entities/product.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  
  @override
  List<Object ?> get props => [];
} 

class LoadAllProductsEvent extends ProductEvent {

  const LoadAllProductsEvent();

  @override
  List<Object ?> get props => [];

}

class GetSingleProductEvent extends ProductEvent {
  final String productid;
  const GetSingleProductEvent({
    required this.productid
  });

  @override
  List<Object ?> get props => [productid];
}

class CreateProductEvent extends ProductEvent {

  final Product product;
  const CreateProductEvent({
    required this.product
  });
  @override
  List<Object?> get props => [product];


}

class UpdateProductEvent  extends ProductEvent {
  final Product product;
  final String productid;
  const UpdateProductEvent ({
    required this.product,
    required this.productid

  });
  @override
  List<Object?> get props => [product , productid];
}

class DeleteProductEvent extends ProductEvent {
  final String productid;
  const DeleteProductEvent({
    required this.productid
  });

  @override
  List<Object?> get props => [productid];

}

