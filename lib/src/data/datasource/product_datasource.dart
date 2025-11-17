import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductDatasource {
  final FirebaseFirestore firestore;

  ProductDatasource(this.firestore);

  Future<List<ProductModel>> fetchProducts() async {
    final query = await firestore.collection("products").get();
    return query.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();
  }
}
