import 'package:test/src/data/datasource/product_datasource.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDatasource datasource;

  ProductRepositoryImpl(this.datasource);

  @override
  Future<List<ProductEntity>> getProducts() async {
    final products = await datasource.fetchProducts();

    return products
        .map(
          (p) => ProductEntity(
            id: p.id,
            name: p.name,
            category: p.category,
            price: p.price,
            imageUrl: p.imageUrl,
            description: p.description,
          ),
        )
        .toList();
  }
}
