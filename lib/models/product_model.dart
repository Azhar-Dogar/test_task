import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// A simple Product model class
class ProductModel {
  final int id;
  final String title;
  final String description;
  final num price;
  final String thumbnail;
  final String category;
   final double rating;
   final int stock;
   final String? brand;
   final List<String> images;
  ProductModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.stock,
    required this.description,
    required this.category,
    required this.price,
    required this.thumbnail,
    required this.images,
    this.brand
  });

  // Factory constructor to create from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      rating: json['rating'],
      stock: json['stock'],
      images: (json['images'] as List<dynamic>).map((e) => e.toString()).toList(),
      brand: json['brand'],
      category: json['category'],
      description: json['description'] as String,
      price: json['price'] as num,
      thumbnail: json['thumbnail'] as String,
    );
  }
}
