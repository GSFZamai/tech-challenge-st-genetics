import 'package:flutter/cupertino.dart';
import 'package:good_hamburger/models/entities/product.dart';
import 'package:good_hamburger/models/product_model.dart';
import 'package:good_hamburger/models/product_order_model.dart';

class ProductOrderViewModel extends ChangeNotifier {
  final ProductModel productModel = ProductModel();
  final ProductOrderModel productOrderModel = ProductOrderModel();
  List<Product>? productList;

  ProductOrderViewModel();

  Future<void> init() async {
    productList = await productModel.getProducts();
    notifyListeners();
  }
}
