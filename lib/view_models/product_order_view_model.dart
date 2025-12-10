import 'package:flutter/widgets.dart';
import 'package:good_hamburger/models/entities/product.dart';
import 'package:good_hamburger/models/product_order_model.dart';

class ProductOrderViewModel extends ChangeNotifier {
  final ProductOrderModel productOrderModel = ProductOrderModel();

  ProductOrderViewModel();

  void addProduct(Product product) {
    productOrderModel.addProduct(product);
    notifyListeners();
  }

  void removeProduct(int productId) {
    productOrderModel.removeProduct(productId);
    isSelected(productId);
    notifyListeners();
  }

  bool isSelected(int productId) {
    return productOrderModel.productList.any(
      (product) => product.id == productId,
    );
  }
}
