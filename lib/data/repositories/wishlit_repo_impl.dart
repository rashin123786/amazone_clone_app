import '../../domain/entities/wishlist_entity.dart';
import '../../domain/repositor/wishlist_repository.dart';
import '../datasource/wishlist_datasource.dart';

import '../models/wishlist_model.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistDatasource datasource;

  WishlistRepositoryImpl(this.datasource);

  @override
  Future<void> toggleWishlist(String uid, WishlistEntity entity) {
    return datasource.toggleWishlist(
      uid,
      WishlistModel(
        description: entity.description,
        productId: entity.productId,
        title: entity.title,
        image: entity.image,
        price: entity.price,
      ),
    );
  }

  @override
  Stream<List<WishlistEntity>> getWishlist(String uid) {
    return datasource.getWishlist(uid);
  }
}
