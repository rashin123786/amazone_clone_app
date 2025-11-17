import 'package:flutter/material.dart';
import '../../domain/entities/wishlist_entity.dart';
import '../../domain/repositor/wishlist_repository.dart';

class WishlistController extends ChangeNotifier {
  final WishlistRepository repo;
  WishlistController(this.repo);

  List<WishlistEntity> wishlist = [];

  void listenToWishlist(String uid) {
    repo.getWishlist(uid).listen((list) {
      wishlist = list;
      notifyListeners();
    });
  }

  Future<void> toggleWishlist(String uid, WishlistEntity product) async {
    await repo.toggleWishlist(uid, product);
  }

  bool isLiked(String productId) {
    return wishlist.any((item) => item.productId == productId);
  }
}
