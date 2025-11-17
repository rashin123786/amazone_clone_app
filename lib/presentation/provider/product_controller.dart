import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test/domain/usecases/product_usecases.dart';
import '../../domain/entities/product_entity.dart';

class ProductController with ChangeNotifier {
  final GetProductsUsecase getProductsUsecase;

  List<ProductEntity> allProducts = [];
  List<ProductEntity> filteredProducts = [];
  bool isLoading = false;

  ProductController(this.getProductsUsecase);

  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    allProducts = await getProductsUsecase.call();
    log("ee${allProducts.length}");
    filteredProducts = allProducts;

    isLoading = false;
    notifyListeners();
  }

  String selectedCategory = "All";

  void filterByCategory(String category) {
    selectedCategory = category;
    _applyFilters();
  }

  String searchQuery = "";

  void searchProducts(String query) {
    searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    // Start with all products
    List<ProductEntity> temp = allProducts;

    // Filter by category
    if (selectedCategory.toLowerCase() != "all") {
      temp = temp
          .where(
            (p) => p.category.toLowerCase() == selectedCategory.toLowerCase(),
          )
          .toList();
    }

    // Filter by search
    if (searchQuery.isNotEmpty) {
      temp = temp
          .where(
            (p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()),
          )
          .toList();
    }

    filteredProducts = temp;
    notifyListeners();
  }
}
