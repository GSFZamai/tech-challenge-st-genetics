import 'package:flutter_test/flutter_test.dart';
import 'package:good_hamburger/infra/products_repository.dart';
import 'package:good_hamburger/models/enums/product_category_enum.dart';
import 'package:good_hamburger/models/product.dart';

void main() {
  late ProductsRepository productRepository;

  group('Product', () {
    setUp(() async {
      productRepository = ProductsRepository();
      await productRepository.getProducts();
    });
    test('If product inicialize correctly', () async {
      final burger = await productRepository.getProductById(1);

      expect(burger, isInstanceOf<Product>());
      expect(burger.id, 1);
      expect(burger.name, 'Burger');
      expect(burger.category, ProductCategoryEnum.sandwich);
      expect(burger.price, 5.00);
    });
  });
}
