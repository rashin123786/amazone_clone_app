import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/wishlist_entity.dart';
import '../provider/wishlist_controller.dart';

class WishlistButton extends StatelessWidget {
  final WishlistEntity product;

  final double size;

  const WishlistButton({super.key, required this.product, this.size = 28});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistController>();

    final isLiked = wishlist.isLiked(product.productId);

    return GestureDetector(
      onTap: () {
        wishlist.toggleWishlist(
          FirebaseAuth.instance.currentUser!.uid,
          product,
        );
      },
      child: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.grey,
        size: size,
      ),
    );
  }
}
