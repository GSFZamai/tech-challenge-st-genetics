import 'package:flutter_test/flutter_test.dart';
import 'package:good_hamburger/models/product_model.dart';
import 'package:good_hamburger/models/entities/product.dart';

void main() {
  group('ProductModel', () {
    late ProductModel productModel;

    setUp(() {
      productModel = ProductModel();
    });

    test("if productRepository instantiates correctly", () {
      expect(productModel, isInstanceOf<ProductModel>());
    });

    group("getProducts", () {
      testWidgets('if getProducts method gets products from products.json', (
        tester,
      ) async {
        final List<Product> productsList = await productModel.getProducts();
        expect(productsList, hasLength(5));
      });
    });

    group("getProductById", () {
      setUp(() async {
        await productModel.getProducts();
      });
      testWidgets('if getProductById return a Product', (tester) async {
        final burger = await productModel.getProductById(1);
        expect(burger, isInstanceOf<Product>());
        expect(burger.id, 1);
      });
    });
  });
}
