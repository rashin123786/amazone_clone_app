import 'package:confirmation_success/confirmation_success.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/presentation/provider/cart_controller.dart';
import 'package:test/presentation/screens/home_screen.dart';

void showSuccessAlert(BuildContext context, bool isCartScreen) async {
  return showDialog(
    context: context,
    routeSettings: RouteSettings(),

    builder: (BuildContext context) {
      return ConfirmationSuccess(
        reactColor: Colors.green,
        child: Text("Success"),
      );
    },
  ).then((value) async {
    // 1️⃣ Clear cart
    if (isCartScreen) {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final CartController cartController = context.read<CartController>();
      await cartController.clearCart(uid);
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );
  });
}
