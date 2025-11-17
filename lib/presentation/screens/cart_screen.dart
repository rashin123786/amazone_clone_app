import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/presentation/screens/checkout_screen.dart';

import '../provider/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CartController>(context);
    final uid = FirebaseAuth.instance.currentUser!.uid;

    controller.listenToCart(uid);

    return Scaffold(
      appBar: AppBar(title: Text("My Cart")),

      body: controller.isLoading
          ? Center(child: CircularProgressIndicator())
          : controller.totalAmount == 0
          ? Center(child: Text("No Cart items"))
          : ListView.builder(
              itemCount: controller.cartItems.length,
              itemBuilder: (context, index) {
                final item = controller.cartItems[index];

                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: item.imageUrl,
                    errorWidget: (context, url, error) => Icon(Icons.info),
                  ),
                  title: Text(item.name),
                  subtitle: Text("₹${item.price}"),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () async {
                          await controller.updateQty(
                            item.productId,
                            item.quantity - 1,
                            uid,
                          );
                        },
                      ),
                      Text(item.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () async {
                          await controller.updateQty(
                            item.productId,
                            item.quantity + 1,
                            uid,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: Visibility(
        visible: controller.totalAmount != 0,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewPadding.bottom + 40,
            left: 12,
            right: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: ₹${controller.totalAmount.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutScreen(
                        isCartScreen: true,
                        amount: controller.totalAmount.toDouble(),
                      ),
                    ),
                  );
                },
                child: Text("Checkout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
