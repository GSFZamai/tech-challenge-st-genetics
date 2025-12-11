import 'package:flutter/widgets.dart';
import 'package:good_hamburger/models/enums/product_category_enum.dart';
import 'package:good_hamburger/models/product_model.dart';

import '../models/entities/product.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductModel productModel = ProductModel();
  List<Product> _productList = [];
  bool isLoading = false;
  List<Product> productList = [];

  ProductViewModel() {
    _init();
  }

  Future<void> _init() async {
    try {
      isLoading = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 2));
      _productList = await productModel.getProducts();
      productList = _productList;
      isLoading = false;
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
