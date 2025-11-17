class CartEntity {
  final String productId;
  final String name;
  final double price;
  final String imageUrl;
  final int quantity;

  CartEntity({
    required this.productId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  CartEntity copyWith({int? quantity}) {
    return CartEntity(
      productId: productId,
      name: name,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CartEntity.empty() {
    return CartEntity(
      productId: "",
      name: "",
      price: 0,
      imageUrl: "",
      quantity: 0,
    );
  }
}
