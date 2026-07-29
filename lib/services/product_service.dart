import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    try {
      // Simulate network delay to show loading state
      await Future.delayed(const Duration(milliseconds: 800));
      
      final String response = await rootBundle.loadString(
        'assets/products.json',
      );
      
      final List<dynamic> data = jsonDecode(response);
      
      if (data.isEmpty) {
        throw Exception('No products available');
      }
      
      return data.map((item) => Product.fromJson(item)).toList();
      
    } on PlatformException {
      throw Exception('Failed to load assets');
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}