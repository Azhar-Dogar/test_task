import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:test_task/models/category_model.dart';

import '../extras/constants.dart';

class CategoriesProvider with ChangeNotifier{

  CategoriesProvider(){
    fetchCategories();
  }

  List<CategoryModel> categories = [];

  Future<void> fetchCategories() async {
    String url = "${Constants.baseUrl}/categories";

    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print(response.body);
      var decoded = jsonDecode(response.body);
      final List<dynamic> categoriesList = decoded ?? [];
      categoriesList.forEach((e){
        CategoryModel categoryModel = CategoryModel.fromJson(e);
        categories.add(categoryModel);
      });
      // totalProducts = productsJson
      //     .map((json) => Product.fromJson(json as Map<String, dynamic>))
      //     .toList();
      // filteredProducts = totalProducts;
      print("totsl categories");
      print(categories.length);

      notifyListeners();
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }
}