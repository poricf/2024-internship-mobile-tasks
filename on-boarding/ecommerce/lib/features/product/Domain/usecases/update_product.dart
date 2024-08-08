import 'package:dartz/dartz.dart';

import '../../../../core/errors/falilures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProduct {
  final ProductRepository productRepository;

  UpdateProduct(this.productRepository);

  Future<Either<Failure, void>> execute(Product product) {
    return productRepository.insertProduct(product);
  }
}
