import 'package:good_hamburger/infra/path_provider.dart';
import 'package:good_hamburger/models/entities/order.dart';
import 'package:good_hamburger/models/enums/product_category_enum.dart';
import 'package:good_hamburger/models/entities/product.dart';
import 'package:good_hamburger/models/shared/custom_exception.dart';

class OrderModel {
  late int id = 1;
  late String name;
  late List<Product> productList = [];
  PathProvider pathProvider = PathProvider();

  OrderModel();

  void addProduct(Product product) {
    if (product.category == ProductCategoryEnum.sandwich && _hasSandwich()) {
      throw CustomException("Only one sandwich can be added on order.");
    }
    if (_hasProductOnList(product.id)) {
      throw CustomException(CustomExceptionType.productAlreadyOnOrder.message);
    }

    productList.add(product);
  }

  void removeProduct(int productId) {
    productList.removeWhere((product) => product.id == productId);
  }

  void cleanList() {
    productList.clear();
  }

  Future<void> submitOrder(String name) async {
    try {
      await pathProvider.writeOrder(
        Order(id: id, productList: productList, name: name),
      );
      _startNewOrder();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Order>> getSubmittedOrderList() async {
    final List<Order> orderList = await pathProvider.getOrderList();
    return orderList;
  }

  double calculateDiscount() {
    if (productList.isEmpty) return 0;

    if (_hasSandwich() && _hasSoftDrink() && _hasFries()) {
      return 0.2;
    }

    if (_hasSandwich() && _hasSoftDrink()) {
      return 0.15;
    }

    if (_hasSandwich() && _hasFries()) {
      return 0.1;
    }

    return 0;
  }

  void _startNewOrder() {
    id = ++id;
    cleanList();
    name = "";
  }

  ///
  ///Validates if the product already exists on list;
  bool _hasProductOnList(int productId) {
    return productList.any((product) => product.id == productId);
  }

  ///
  ///Validates if the list already have a SandwichType Product;
  bool _hasSandwich() {
    return productList.any(
      (product) => product.category == ProductCategoryEnum.sandwich,
    );
  }

  bool _hasSoftDrink() {
    return productList.any((product) => product.id == 5);
  }

  bool _hasFries() {
    return productList.any((product) => product.id == 4);
  }
}
