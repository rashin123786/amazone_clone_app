import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/wishlist_model.dart';

class WishlistDatasource {
  final FirebaseFirestore firestore;

  WishlistDatasource(this.firestore);

  Future<void> toggleWishlist(String uid, WishlistModel model) async {
    final ref = firestore
        .collection("users")
        .doc(uid)
        .collection("wishlist")
        .doc(model.productId);

    final doc = await ref.get();

    if (doc.exists) {
      await ref.delete(); // remove
    } else {
      await ref.set(model.toMap()); // add
    }
  }

  Stream<List<WishlistModel>> getWishlist(String uid) {
    return firestore
        .collection("users")
        .doc(uid)
        .collection("wishlist")
        .snapshots()
        .map(
          (snap) =>
              snap.docs.map((e) => WishlistModel.fromMap(e.data())).toList(),
        );
  }
}
