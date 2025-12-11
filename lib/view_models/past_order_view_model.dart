import 'package:flutter/foundation.dart';
import 'package:good_hamburger/models/entities/order.dart';
import 'package:good_hamburger/models/order_model.dart';

class PastOrderViewModel extends ChangeNotifier {
  OrderModel orderModel = OrderModel();
  late List<Order> orderList = [];
  bool isLoading = false;

  PastOrderViewModel() {
    getPastOrderList();
  }

  Future<void> getPastOrderList() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    orderList = await orderModel.getSubmittedOrderList();
    isLoading = false;
    notifyListeners();
  }

  double _subTotal(Order order) => order.productList.fold(
    0.0,
    (prevValue, product) => prevValue + product.price,
  );

  double _total(Order order) => _subTotal(order) - _valueDiscount(order);

  double _percentageDiscount(Order order) => order.calculateDiscount() * 100;

  double _valueDiscount(Order order) =>
      _subTotal(order) * order.calculateDiscount();

  String formattedSubTotal(Order order) =>
      "\$ ${_subTotal(order).toStringAsFixed(2)}";

  String formattedPercentageDiscount(Order order) =>
      "${_percentageDiscount(order).toInt()}%";

  String formattedValueDiscount(Order order) =>
      "\$ ${_valueDiscount(order).toStringAsFixed(2)}";

  String formattedTotal(Order order) =>
      "\$ ${_total(order).toStringAsFixed(2)}";
}
