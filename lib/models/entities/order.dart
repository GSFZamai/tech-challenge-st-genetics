import 'package:good_hamburger/models/entities/product.dart';

class Order {
  final int id;
  final List<Product> productList;
  final String name;

  Order({required this.id, required this.productList, required this.name});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json['id'] as int,
    productList: (json['productList'] as List<dynamic>)
        .map((d) => Product.fromJson(d))
        .toList(),
    name: json['name'] as String,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productList": productList,
    "name": name,
  };
}
