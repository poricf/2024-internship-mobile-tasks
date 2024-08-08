import 'package:dartz/dartz.dart';

import '../../../../core/errors/falilures.dart';
import '../repositories/product_repository.dart';

class DeleteProductUseCase {
  ProductRepository productRepository;

  DeleteProductUseCase(this.productRepository);

  Future<Either<Failure, int>> call(String productid) {
    return productRepository.deleteProduct(productid);
  }
}
