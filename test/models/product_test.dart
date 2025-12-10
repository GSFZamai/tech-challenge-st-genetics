import 'package:flutter_test/flutter_test.dart';
import 'package:good_hamburger/models/product_model.dart';
import 'package:good_hamburger/models/enums/product_category_enum.dart';
import 'package:good_hamburger/models/entities/product.dart';

void main() {
  late ProductModel productRepository;

  group('Product', () {
    setUp(() async {
      productRepository = ProductModel();
      await productRepository.getProducts();
    });
    testWidgets('If product inicialize correctly', (tester) async {
      final burger = await productRepository.getProductById(1);

      expect(burger, isInstanceOf<Product>());
      expect(burger.id, 1);
      expect(burger.name, 'Burger');
      expect(burger.category, ProductCategoryEnum.sandwich);
      expect(burger.price, 5.00);
    });
  });
}
