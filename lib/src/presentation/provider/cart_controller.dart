import 'package:flutter/material.dart';

import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repository/cart_repository.dart';

class CartController with ChangeNotifier {
  final CartRepository repo;

  CartController(this.repo);

  List<CartEntity> cartItems = [];
  bool isLoading = true;

  void listenToCart(String uid) {
    repo.getCart(uid).listen((cart) {
      cartItems = cart;
      isLoading = false;
      notifyListeners();
    });
  }

  double get totalAmount {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  Future<void> addToCart(ProductEntity p, String uid) async {
    final item = CartEntity(
      productId: p.id,
      name: p.name,
      price: p.price,
      imageUrl: p.imageUrl,
      quantity: 1,
    );

    await repo.addToCart(item, uid);
  }

  Future<void> updateQty(String productId, int qty, String uid) async {
    await repo.updateQuantity(productId, qty, uid);
  }

  int getQuantity(String productId) {
    final item = cartItems.firstWhere(
      (e) => e.productId == productId,
      orElse: () => CartEntity.empty(),
    );
    return item.quantity;
  }

  bool isInCart(String productId) {
    return cartItems.any((e) => e.productId == productId);
  }

  Future<void> clearCart(String uid) async {
    await repo.clearCart(uid);
  }
}
