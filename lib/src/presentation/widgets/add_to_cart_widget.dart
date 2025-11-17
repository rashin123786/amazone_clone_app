import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/src/domain/entities/product_entity.dart';

import '../provider/cart_controller.dart';

class AddToCartButtonWidget extends StatelessWidget {
  AddToCartButtonWidget({super.key, required this.product});

  final ProductEntity product;

  final uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cartController, _) {
        final qty = cartController.getQuantity(product.id);

        // NOT IN CART → show Add button
        if (qty == 0) {
          return ElevatedButton(
            onPressed: () async {
              await cartController.addToCart(product, uid ?? '');
            },
            child: Text("Add to cart"),
          );
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () async {
                await cartController.updateQty(product.id, qty - 1, uid ?? '');
              },
            ),
            Text(qty.toString()),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                await cartController.updateQty(product.id, qty + 1, uid ?? '');
              },
            ),
          ],
        );
      },
    );
  }
}
