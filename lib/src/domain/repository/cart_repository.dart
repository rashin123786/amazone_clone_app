import '../entities/cart_entity.dart';

abstract class CartRepository {
  Future<void> addToCart(CartEntity entity, String uid);

  Future<void> updateQuantity(String productId, int qty, String uid);

  Stream<List<CartEntity>> getCart(String uid);
  Future<void> clearCart(String uid);
}
