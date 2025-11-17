import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cart_model.dart';

class CartDatasource {
  final FirebaseFirestore firestore;

  CartDatasource(this.firestore);

  String userId(String uid) => "users/$uid/cart";

  Future<void> addToCart(String uid, CartModel model) async {
    final ref = firestore
        .collection("users")
        .doc(uid)
        .collection("cart")
        .doc(model.productId);

    await ref.set(model.toMap(), SetOptions(merge: true));
  }

  Future<void> updateQuantity(String uid, String productId, int qty) async {
    final ref = firestore
        .collection("users")
        .doc(uid)
        .collection("cart")
        .doc(productId);

    if (qty == 0) {
      await ref.delete();
    } else {
      await ref.update({'quantity': qty});
    }
  }

  Stream<List<CartModel>> getCart(String uid) {
    return firestore
        .collection("users")
        .doc(uid)
        .collection("cart")
        .snapshots()
        .map(
          (snap) => snap.docs.map((e) => CartModel.fromMap(e.data())).toList(),
        );
  }

  Future<void> clearCart(String uid) async {
    final ref = firestore.collection("users").doc(uid).collection("cart");

    final batch = firestore.batch();

    final docs = await ref.get();
    for (var doc in docs.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
