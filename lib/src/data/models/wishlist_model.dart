import '../../domain/entities/wishlist_entity.dart';

class WishlistModel extends WishlistEntity {
  WishlistModel({
    required super.productId,
    required super.title,
    required super.image,
    required super.price,
    required super.description,
  });

  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "title": title,
      "image": image,
      "price": price,
      "description": description,
    };
  }

  factory WishlistModel.fromMap(Map<String, dynamic> map) {
    return WishlistModel(
      description: map['description'] ?? '',
      productId: map["productId"],
      title: map["title"] ?? '',
      image: map["image"] ?? '',
      price: (map["price"] ?? 0).toDouble(),
    );
  }
}
