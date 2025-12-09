import 'dart:convert';
import 'dart:io';
import 'package:good_hamburger/models/entities/product.dart';

class ProductModel {
  ProductModel();

  Future<List<Product>> getProducts() async {
    try {
      final file = File('assets/data/products.json');
      final jsonString = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((product) => Product.fromJson(product)).toList();
    } catch (e) {
      return [];
    }
  }

  // ///
  // /// | Id | Name       | Price | Category |
  // /// | -- | ---------- | ----- | -------- |
  // /// | 1  | Burger     | 5.0   | Sandwich |
  // /// | 2  | Egg        | 4.5   | Sandwich |
  // /// | 3  | Bacon      | 7.0   | Sandwich |
  // /// | 4  | Fries      | 2.0   | Extras   |
  // /// | 5  | Soft Drink | 2.5   | Extras   |
  // ///
  Future<Product> getProductById(int productId) async {
    final productList = await getProducts();
    return productList.firstWhere((e) => e.id == productId);
  }
}
