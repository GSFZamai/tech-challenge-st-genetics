import 'package:flutter/widgets.dart';
import 'package:good_hamburger/models/product_model.dart';

import '../models/entities/product.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductModel productModel = ProductModel();
  List<Product> productList = [];
  ProductViewModel();

  Future<void> init() async {
    try {
      productList = await productModel.getProducts();
      notifyListeners();
    } catch (e) {
      ///
    }
  }
}
