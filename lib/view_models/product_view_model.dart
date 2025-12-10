import 'package:flutter/widgets.dart';
import 'package:good_hamburger/models/enums/product_category_enum.dart';
import 'package:good_hamburger/models/product_model.dart';

import '../models/entities/product.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductModel productModel = ProductModel();
  List<Product> _productList = [];
  List<Product> productList = [];
  ProductViewModel();

  Future<void> init() async {
    try {
      _productList = await productModel.getProducts();
      productList = _productList;
      notifyListeners();
    } catch (e) {
      ///
    }
  }

  void filterProductsByCategory(ProductCategoryEnum? category) {
    if (category == null) {
      productList = _productList;
      notifyListeners();
      return;
    }
    productList = _productList.where((p) => p.category == category).toList();
    notifyListeners();
  }
}
