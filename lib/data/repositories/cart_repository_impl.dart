import 'package:test/data/datasource/cart_datasource.dart';

import '../../domain/entities/cart_entity.dart';
import '../../domain/repositor/cart_repository.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDatasource datasource;

  CartRepositoryImpl(this.datasource);

  @override
  Future<void> addToCart(CartEntity entity, String uid) {
    return datasource.addToCart(
      uid,
      CartModel(
        productId: entity.productId,
        name: entity.name,
        price: entity.price,
        imageUrl: entity.imageUrl,
        quantity: entity.quantity,
      ),
    );
  }

  @override
  Future<void> updateQuantity(String productId, int qty, String uid) {
    return datasource.updateQuantity(uid, productId, qty);
  }

  @override
  Stream<List<CartEntity>> getCart(String uid) {
    return datasource
        .getCart(uid)
        .map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<void> clearCart(String uid) {
    return datasource.clearCart(uid);
  }
}
