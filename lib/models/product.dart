import 'package:good_hamburger/models/enums/product_category_enum.dart';

class Product {
  final int id;
  final String name;
  final ProductCategoryEnum category;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as int,
    name: json['name'] as String,
    category: json['category'] == "extras"
        ? ProductCategoryEnum.extras
        : ProductCategoryEnum.sandwich,
    price: json["price"] as double,
  );
}
