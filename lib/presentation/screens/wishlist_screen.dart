import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/domain/entities/product_entity.dart';
import 'package:test/presentation/screens/product_details_screen.dart';

import '../../domain/entities/wishlist_entity.dart';
import '../provider/wishlist_controller.dart';
import '../widgets/wishlist_widget.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WishlistController>();
    final wishlist = controller.wishlist;

    if (wishlist.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Wishlist")),
        body: Center(
          child: Text(
            "Your wishlist is empty",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Wishlist")),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: wishlist.length,
        itemBuilder: (_, i) {
          final item = wishlist[i];

          return WishlistTile(item: item);
        },
      ),
    );
  }
}

class WishlistTile extends StatelessWidget {
  final WishlistEntity item;

  const WishlistTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              product: ProductEntity(
                id: item.productId,
                name: item.title,
                price: item.price,
                description: item.image,
                imageUrl: item.image,
                category: "",
              ),
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        elevation: 1.2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: item.image,
                  height: 95,
                  width: 95,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(width: 12),

              // Right side
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      "₹${item.price.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // Wishlist Button (heart icon)
              WishlistButton(product: item, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
