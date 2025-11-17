import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/presentation/provider/cart_controller.dart';

import 'package:test/presentation/provider/product_controller.dart';
import 'package:test/presentation/screens/cart_screen.dart';
import 'package:test/presentation/screens/profile_screen.dart';
import 'package:test/presentation/screens/wishlist_screen.dart';
import 'package:test/presentation/widgets/product_card.dart';

import '../provider/wishlist_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WishlistController>().listenToWishlist(
        FirebaseAuth.instance.currentUser?.uid ?? '',
      );
      context.read<CartController>().listenToCart(
        FirebaseAuth.instance.currentUser?.uid ?? '',
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF232f3e),
        leading: Icon(Icons.menu, color: Colors.white),
        title: CachedNetworkImage(
          width: 80,

          imageUrl:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKY8W-m3gCpB6ppQcxGq-GuWJd_71Hu2ckig&s",
          errorWidget: (context, url, error) => SizedBox(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            icon: Icon(Icons.person, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WishlistScreen()),
              );
            },
            icon: Icon(Icons.favorite, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search products",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      controller.searchProducts(value);
                    },
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.filter_alt_outlined),
                  onSelected: (value) {
                    controller.filterByCategory(value);
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(value: "All", child: Text("All")),
                    PopupMenuItem(value: "Mobiles", child: Text("Mobiles")),
                    PopupMenuItem(value: "Clothes", child: Text("Clothes")),
                  ],
                ),
              ],
            ),
          ),

          // Product List / Loading / Empty
          Expanded(
            child: controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : controller.filteredProducts.isEmpty
                ? Center(child: Text("No products found"))
                : RefreshIndicator(
                    onRefresh: () => controller.loadProducts(),
                    child: ListView.builder(
                      itemCount: controller.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = controller.filteredProducts[index];
                        return ProductCard(product: product);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
