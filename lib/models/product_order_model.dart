import 'package:good_hamburger/models/enums/product_category_enum.dart';
import 'package:good_hamburger/models/entities/product.dart';
import 'package:good_hamburger/models/shared/custom_exception.dart';

class OrderModel {
  static int lastId = 0;
  late int id;
  late List<Product> productList = [];

  OrderModel() {
    id = ++OrderModel.lastId;
    OrderModel.lastId = id;
  }

  void addProduct(Product product) {
    if (product.category == ProductCategoryEnum.sandwich && _hasSandwich()) {
      throw CustomException("Only one sandwich can be added on order.");
    }
    if (_hasProductOnList(product.id)) {
      throw CustomException("Product already on order.");
    }

    productList.add(product);
  }

  void removeProduct(int productId) {
    productList.removeWhere((product) => product.id == productId);
  }

  void cleanList() {
    productList.clear();
  }

  void submitOrder() {}

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
