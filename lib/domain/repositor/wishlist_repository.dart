import '../entities/wishlist_entity.dart';

abstract class WishlistRepository {
  Future<void> toggleWishlist(String uid, WishlistEntity entity);
  Stream<List<WishlistEntity>> getWishlist(String uid);
}
