import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/falilures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class ProductUsecase extends Equatable {
  final ProductRepository productRepository;
  const ProductUsecase({required this.productRepository});

  Future<Either<Failure, List<Product>>> getAllProducts() async {
    return productRepository.getAllProduct();
  }

  Future<Either<Failure, Product>> getProduct(String productId) async {
    return productRepository.getProduct(productId);
  }

  Future<Either<Failure, void>> addProduct(Product product) async {
    return productRepository.insertProduct(product);
  }

  Future<Either<Failure, void>> updateProduct(String productid , Product product) async {
    return productRepository.updateProduct(productid,product);
  }

  Future<Either<Failure, void>> deleteProduct(String productId) async {
    return productRepository.deleteProduct(productId);
  }

   // get data by id
  Future<Either<Failure, Product>> dataById(String productId) async{
    return productRepository.getProduct(productId);
  }

  Future<Either<Failure, List<Product>>> dataForAll(){
    return productRepository.getAllProduct();
  }

  @override
  List<Object> get props => throw UnimplementedError();


}
