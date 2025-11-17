import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test/src/presentation/screens/product_details_screen.dart';
import 'package:test/src/presentation/widgets/add_to_cart_widget.dart';
import 'package:test/src/presentation/widgets/wishlist_widget.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/entities/wishlist_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Card(
        color: Colors.white,
        elevation: 1.5,
        margin: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------------- Product Image ----------------------
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  errorWidget: (context, url, error) => Icon(Icons.info),
                  height: 110,
                  width: 110,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(width: 10),

              // ---------------------- Right Side Content ----------------------
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------------------- Price Row ----------------------
                    Row(
                      children: [
                        Text(
                          "₹${product.price.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(width: 8),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "30% off",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        Spacer(),
                        WishlistButton(
                          product: WishlistEntity(
                            description: product.description,
                            productId: product.id,
                            title: product.name,
                            image: product.imageUrl,
                            price: product.price,
                          ),
                        ),
                      ],
                    ),

                    // ---------------------- Old Price ----------------------
                    Text(
                      "₹${(product.price - 100).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),

                    SizedBox(height: 5),

                    // ---------------------- Free Shipping ----------------------
                    Text(
                      "Eligible for FREE shipping",
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),

                    SizedBox(height: 4),

                    // ---------------------- Stock ----------------------
                    Text(
                      "In stock",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AddToCartButtonWidget(product: product),
                        // Go to product details
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailScreen(product: product),
                              ),
                            );
                          },
                          icon: Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
