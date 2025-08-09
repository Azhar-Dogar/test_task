import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:test_task/extras/constants.dart';

import '../models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  ProductsProvider() {
    fetchProducts();
  }

  List<ProductModel> totalProducts = [];
  List<ProductModel> filteredProducts = []; // search results
  List<ProductModel> categoryProducts = [];
  List<ProductModel> favourites = [];

  void updateFavourites(ProductModel product) {
    if(favourites.contains(product)){
      favourites.remove(product);
    }else{
      favourites.add(product);
    }
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    totalProducts = [];
    filteredProducts = [];
    String url = "${Constants.baseUrl}?limit=100";

    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // print(response.body);
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      final List<dynamic> productsJson = decoded['products'] ?? [];
      totalProducts = productsJson
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
      filteredProducts = totalProducts;
      print("totsl products");
      print(totalProducts.length);

      notifyListeners();
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }

  void getCategoryProducts(String category) {
    categoryProducts = [];
    categoryProducts = totalProducts
        .where((e) => e.category == category)
        .toList();
    notifyListeners();
  }
}
