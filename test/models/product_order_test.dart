import 'package:flutter_test/flutter_test.dart';
import 'package:good_hamburger/models/product_model.dart';
import 'package:good_hamburger/models/entities/product.dart';
import 'package:good_hamburger/models/order_model.dart';
import 'package:good_hamburger/models/shared/custom_exception.dart';

void main() {
  late OrderModel order;
  late ProductModel productRepository;
  setUp(() async {
    order = OrderModel();
    productRepository = ProductModel();
    await productRepository.getProducts();
  });

  group("ProductOrder", () {
    testWidgets("if order instantiates correctly", (tester) async {
      expect(order, isInstanceOf<OrderModel>());
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

      testWidgets("add one Product", (tester) async {
        order.addProduct(burger);
        expect(order.productList, hasLength(1));
        expect(order.productList, containsOnce(burger));
      });

      testWidgets("cannot add more than one sandwich product", (tester) async {
        order.addProduct(burger);
        expect(
          () => order.addProduct(burger),
          throwsA(
            isA<CustomException>().having(
              (e) => e.message,
              'message',
              'Only one sandwich can be added on order.',
            ),
          ),
        );
        expect(order.productList, hasLength(1));
        expect(order.productList, containsOnce(burger));
      });

      testWidgets("cannot add the same product", (testes) async {
        order.addProduct(fries);
        expect(
          () => order.addProduct(fries),
          throwsA(
            isA<CustomException>().having(
              (e) => e.message,
              'message',
              'Product already on order.',
            ),
          ),
        );
        expect(order.productList, hasLength(1));
        expect(order.productList, containsOnce(fries));
      });

      testWidgets("can add more than one extra", (tester) async {
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
      testWidgets('remove the right product', (tester) async {
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
      testWidgets('cleanList', (tester) async {
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

      testWidgets(
        "If the customer selects a sandwich, fries, and a soft drink, they will receive a 20% discount",
        (testes) async {
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
      testWidgets(
        "If the customer selects a sandwich and a soft drink, they will receive a 15% discount;",
        (tester) async {
          order.addProduct(burger);
          order.addProduct(softDrink);

          expect(order.productList, hasLength(2));
          expect(order.productList, containsAllInOrder([burger, softDrink]));
          expect(order.calculateDiscount(), 0.15);
        },
      );
      testWidgets(
        "If the customer selects a sandwich and fries, they will receive a 10% discount",
        (tester) async {
          order.addProduct(burger);
          order.addProduct(fries);

          expect(order.productList, hasLength(2));
          expect(order.productList, containsAllInOrder([burger, fries]));
          expect(order.calculateDiscount(), 0.1);
        },
      );
      testWidgets("If the customer only a sandwich there is no discount", (
        tester,
      ) async {
        order.addProduct(burger);

        expect(order.productList, hasLength(1));
        expect(order.productList, containsAllInOrder([burger]));
        expect(order.calculateDiscount(), isZero);
      });
    });
  });
}
