import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:good_hamburger/infra/products_repository.dart';
import 'package:good_hamburger/models/product.dart';
import 'package:good_hamburger/models/product_order.dart';

void main() {
  late ProductOrder order;
  late ProductsRepository productRepository;
  setUp(() async {
    order = ProductOrder();
    productRepository = ProductsRepository();
    await productRepository.getProducts();
  });

  group("ProductOrder", () {
    test("if order instantiates correctly", () {
      expect(order, isInstanceOf<ProductOrder>());
      expect(order.id, 1);
    });

    group("addProduct", () {
      late Product burger;
      late Product egg;
      late Product fries;
      late Product softDrink;

      setUp(() async {
        burger = await productRepository.getProductById(1);
        egg = await productRepository.getProductById(2);
        fries = await productRepository.getProductById(4);
        softDrink = await productRepository.getProductById(5);
      });

      test("add one Product", () {
        order.addProduct(burger);
        expect(order.productList, hasLength(1));
        expect(order.productList, containsOnce(burger));
      });

      test("cannot add more than one sandwich product", () {
        order.addProduct(burger);
        order.addProduct(egg);
        expect(order.productList, hasLength(1));
        expect(order.productList, containsOnce(burger));
      });

      test("cannot add the same product", () {
        order.addProduct(fries);
        order.addProduct(fries);
        expect(order.productList, hasLength(1));
        expect(order.productList, containsOnce(fries));
      });

      test("can add more than one extra", () {
        order.addProduct(fries);
        order.addProduct(softDrink);
        expect(order.productList, hasLength(2));
        expect(order.productList, containsAllInOrder([fries, softDrink]));
      });
    });

    group('removeProduct', () {
      late Product burger;
      late Product fries;
      setUp(() async {
        burger = await productRepository.getProductById(1);
        fries = await productRepository.getProductById(4);
      });
      test('remove the right product', () async {
        order.addProduct(burger);
        expect(order.productList, hasLength(1));
        order.addProduct(fries);
        expect(order.productList, hasLength(2));
        expect(order.productList, containsAllInOrder([burger, fries]));
        order.removeProduct(1);
        expect(order.productList, hasLength(1));
        expect(order.productList, containsAllInOrder([fries]));
      });
    });

    group('cleanList', () {
      late Product burger;
      late Product fries;
      late Product softDrink;

      setUp(() async {
        burger = await productRepository.getProductById(1);
        fries = await productRepository.getProductById(4);
        softDrink = await productRepository.getProductById(5);

        order.addProduct(burger);
        order.addProduct(fries);
        order.addProduct(softDrink);
      });
      test('cleanList', () {
        expect(order.productList, hasLength(3));
        expect(
          order.productList,
          containsAllInOrder([burger, fries, softDrink]),
        );
        order.cleanList();
        expect(order.productList, isEmpty);
      });
    });

    group('calculateDiscount', () {
      late Product burger;
      late Product fries;
      late Product softDrink;

      setUp(() async {
        burger = await productRepository.getProductById(1);
        fries = await productRepository.getProductById(4);
        softDrink = await productRepository.getProductById(5);
      });

      test(
        "If the customer selects a sandwich, fries, and a soft drink, they will receive a 20% discount",
        () {
          order.addProduct(burger);
          order.addProduct(fries);
          order.addProduct(softDrink);

          expect(order.productList, hasLength(3));
          expect(
            order.productList,
            containsAllInOrder([burger, fries, softDrink]),
          );
          expect(order.calculateDiscount(), 0.2);
        },
      );
      test(
        "If the customer selects a sandwich and a soft drink, they will receive a 15% discount;",
        () {
          order.addProduct(burger);
          order.addProduct(softDrink);

          expect(order.productList, hasLength(2));
          expect(order.productList, containsAllInOrder([burger, softDrink]));
          expect(order.calculateDiscount(), 0.15);
        },
      );
      test(
        "If the customer selects a sandwich and fries, they will receive a 10% discount",
        () {
          order.addProduct(burger);
          order.addProduct(fries);

          expect(order.productList, hasLength(2));
          expect(order.productList, containsAllInOrder([burger, fries]));
          expect(order.calculateDiscount(), 0.1);
        },
      );
      test("If the customer only a sandwich there is no discount", () {
        order.addProduct(burger);

        expect(order.productList, hasLength(1));
        expect(order.productList, containsAllInOrder([burger]));
        expect(order.calculateDiscount(), isZero);
      });
    });
  });
}
