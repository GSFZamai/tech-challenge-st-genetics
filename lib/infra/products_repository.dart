import 'dart:convert';
import 'dart:io';
import 'package:good_hamburger/models/product.dart';

class ProductsRepository {
  late List<Product> productList = [];

  ProductsRepository();

  Future<List<Product>> getProducts() async {
    if (productList.isNotEmpty) return productList;
    try {
      final file = File('assets/data/products.json');
      final jsonString = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(jsonString);
      productList = jsonList
          .map((product) => Product.fromJson(product))
          .toList();
      return productList;
    } catch (e) {
      return [];
    }
  }

  ///
  /// | Id | Name       | Price | Category |
  /// | -- | ---------- | ----- | -------- |
  /// | 1  | Burger     | 5.0   | Sandwich |
  /// | 2  | Egg        | 4.5   | Sandwich |
  /// | 3  | Bacon      | 7.0   | Sandwich |
  /// | 4  | Fries      | 2.0   | Extras   |
  /// | 5  | Soft Drink | 2.5   | Extras   |
  ///
  Future<Product> getProductById(int productId) async {
    await getProducts();
    return productList.firstWhere((e) => e.id == productId);
  }
}
