import 'package:dartz/dartz.dart';

import '../../../../core/errors/falilures.dart';
import '../entities/product.dart';

abstract class ProductRepository  {
  Future<Either<Failure, Product>> getProduct(String productid);

  Future<Either<Failure, void>> insertProduct(Product product);
  Future<Either<Failure, void>> updateProduct(Product product);
  Future<Either<Failure, int>> deleteProduct(String productid);
}
