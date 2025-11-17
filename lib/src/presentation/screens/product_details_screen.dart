import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test/src/domain/entities/product_entity.dart';
import 'package:test/src/presentation/screens/checkout_screen.dart';
import 'package:test/src/presentation/widgets/add_to_cart_widget.dart';

// Mock Product Entity

// Mock Review Entity
class Review {
  final String username;
  final String comment;
  final double rating;

  Review({required this.username, required this.comment, required this.rating});
}

// Product Detail Screen
class ProductDetailScreen extends StatelessWidget {
  final ProductEntity product;

  ProductDetailScreen({super.key, required this.product});

  final List<Review> mockReviews = [
    Review(username: "Alice", comment: "Great product!", rating: 4.5),
    Review(username: "Bob", comment: "Worth the price.", rating: 4.0),
    Review(username: "Charlie", comment: "Average quality.", rating: 3.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  errorWidget: (context, url, error) => Icon(Icons.info),
                  fit: BoxFit.cover,
                  height: 250,
                ),
              ),
              SizedBox(height: 12),
              ListTile(
                title: Text(
                  product.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(product.description),
                trailing: Text(
                  "₹${product.price.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ),
              // Product Name

              // Product Price

              // Product Description

              // Buttons: Add to Cart & Buy Now
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    AddToCartButtonWidget(product: product),
                    SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to Checkout Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CheckoutScreen(
                              amount: product.price,
                              isCartScreen: false,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(),
                      child: Text("Buy Now"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Reviews Section
              Text(
                "Customer Reviews",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),

              // List of Reviews
              ...mockReviews.map((review) {
                return ListTile(
                  leading: CircleAvatar(child: Text(review.username[0])),
                  title: Text(review.username),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < review.rating.round()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(review.comment),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
