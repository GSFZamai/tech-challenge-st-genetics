import 'package:flutter_test/flutter_test.dart';
import 'package:good_hamburger/infra/products_repository.dart';
import 'package:good_hamburger/models/product.dart';

void main() {
  group('ProductsRepository', () {
    late ProductsRepository productsRepository;

    setUp(() {
      productsRepository = ProductsRepository();
    });

    test("if productRepository instantiates correctly", () {
      expect(productsRepository, isInstanceOf<ProductsRepository>());
      expect(productsRepository.productList, isInstanceOf<List<Product>>());
      expect(productsRepository.productList, hasLength(0));
    });

    group("getProducts", () {
      test('if getProducts method gets products from products.json', () async {
        final List<Product> productsList = await productsRepository
            .getProducts();

        expect(productsList, equals(productsRepository.productList));
        expect(productsList, hasLength(5));
      });
    });

    group("getProductById", () {
      setUp(() async {
        await productsRepository.getProducts();
      });
      test('if getProductById return a Product', () async {
        final burger = await productsRepository.getProductById(1);
        expect(burger, isInstanceOf<Product>());
        expect(burger.id, 1);
      });
    });
  });
}
