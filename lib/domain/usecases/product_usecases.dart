import 'package:test/domain/repositor/product_repository.dart';

import '../entities/product_entity.dart';

class GetProductsUsecase {
  final ProductRepository repository;

  GetProductsUsecase(this.repository);

  Future<List<ProductEntity>> call() {
    return repository.getProducts();
  }
}
