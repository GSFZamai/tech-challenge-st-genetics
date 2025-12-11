import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:good_hamburger/models/entities/order.dart';
import 'package:good_hamburger/models/entities/product.dart';
import 'package:good_hamburger/models/order_model.dart';
import 'package:good_hamburger/models/shared/custom_exception.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderModel _orderModel = OrderModel();
  String name = "";
  int get orderId => _orderModel.id;
  double get decimalDiscount => _orderModel.calculateDiscount();
  double get percentageDiscount => decimalDiscount * 100;
  double get totalDiscount => subTotal * decimalDiscount;
  double get total => subTotal - totalDiscount;
  double get subTotal => _orderModel.productList.fold(
    0.0,
    (value, product) => value + product.price,
  );
  String get formattedSubtotal => "\$ ${subTotal.toStringAsFixed(2)}";
  String get formattedPercentageDiscount =>
      "${percentageDiscount.toStringAsFixed(0)}%";
  String get formattedTotalDiscount => "\$ ${totalDiscount.toStringAsFixed(2)}";
  String get formattedTotal => "\$ ${total.toStringAsFixed(2)}";

  List<Product> get orderProductList => _orderModel.productList;

  OrderViewModel();

  void addProduct(Product product) {
    try {
      _orderModel.addProduct(product);
      notifyListeners();
    } catch (e) {
      if (e is CustomException) {
        throw CustomException(
          "${e.message} LongPress on product card to remove it from order.",
        );
      }
    }
  }

  void removeProduct(int productId) {
    _orderModel.removeProduct(productId);
    isSelected(productId);
    notifyListeners();
  }

  void updateName(String name) {
    this.name = name.trim();
    notifyListeners();
  }

  Future<void> submitOrder() async {
    await _orderModel.submitOrder(name);
    updateName("");
    notifyListeners();
  }

  Future<List<Order>> getSubmittedOrderList() async {
    final orderList = await _orderModel.getSubmittedOrderList();
    return orderList;
  }

  bool isSelected(int productId) {
    return _orderModel.productList.any((product) => product.id == productId);
  }
}
