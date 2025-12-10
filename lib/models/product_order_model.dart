import 'package:good_hamburger/models/enums/product_category_enum.dart';
import 'package:good_hamburger/models/entities/product.dart';

class ProductOrderModel {
  static int lastId = 0;
  late int id;
  late List<Product> productList = [];

  ProductOrderModel() {
    id = ++ProductOrderModel.lastId;
    ProductOrderModel.lastId = id;
  }

  void addProduct(Product product) {
    if (_hasProductOnList(product.id)) return;
    if (product.category == ProductCategoryEnum.sandwich && _hasSandwich()) {
      return;
    }

    productList.add(product);
  }

  void removeProduct(int productId) {
    productList.removeWhere((product) => product.id == productId);
  }

  void cleanList() {
    productList = [];
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
