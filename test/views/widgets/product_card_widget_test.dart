import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:good_hamburger/models/entities/product.dart';
import 'package:good_hamburger/models/enums/product_category_enum.dart';
import 'package:good_hamburger/views/widgets/product_card_widget.dart';

void main() {
  final Product sandwichTypeProduct = Product(
    id: 1,
    name: "Burger",
    category: ProductCategoryEnum.sandwich,
    price: 5.00,
  );
  final Product extraTypeProduct = Product(
    id: 5,
    name: "Fries",
    category: ProductCategoryEnum.extras,
    price: 3.50,
  );

  group("ProductCardWidget", () {
    group("ProductCategoryEnum.sandwich", () {
      testWidgets('ProductCardWidget not Selected', (tester) async {
        await tester.pumpWidget(
          ProductCardWidgetMainApp(
            product: sandwichTypeProduct,
            isSelected: false,
          ),
        );
        final value = find.text("\$ 5.00");
        final name = find.text("Burger");
        final icon = find.byIcon(Icons.lunch_dining);
        final plusIcon = find.byIcon(Icons.add_circle);

        expect(value, findsOneWidget);
        expect(name, findsOneWidget);
        expect(icon, findsOneWidget);
        expect(plusIcon, findsOneWidget);
      });

      testWidgets('ProductCardWidget Selected', (tester) async {
        await tester.pumpWidget(
          ProductCardWidgetMainApp(
            product: sandwichTypeProduct,
            isSelected: true,
          ),
        );
        final value = find.text("\$ 5.00");
        final name = find.text("Burger");
        final icon = find.byIcon(Icons.lunch_dining);
        final removeIcon = find.byIcon(Icons.remove_circle);

        expect(value, findsOneWidget);
        expect(name, findsOneWidget);
        expect(icon, findsOneWidget);
        expect(removeIcon, findsOneWidget);
      });
    });

    group("ProductCategoryEnum.extras", () {
      testWidgets('ProductCardWidget not Selected', (tester) async {
        await tester.pumpWidget(
          ProductCardWidgetMainApp(
            product: extraTypeProduct,
            isSelected: false,
          ),
        );
        final value = find.text("\$ 3.50");
        final name = find.text("Fries");
        final icon = find.byIcon(Icons.fastfood);
        final plusIcon = find.byIcon(Icons.add_circle);

        expect(value, findsOneWidget);
        expect(name, findsOneWidget);
        expect(icon, findsOneWidget);
        expect(plusIcon, findsOneWidget);
      });

      testWidgets('ProductCardWidget Selected', (tester) async {
        await tester.pumpWidget(
          ProductCardWidgetMainApp(product: extraTypeProduct, isSelected: true),
        );
        final value = find.text("\$ 3.50");
        final name = find.text("Fries");
        final icon = find.byIcon(Icons.fastfood);
        final removeIcon = find.byIcon(Icons.remove_circle);

        expect(value, findsOneWidget);
        expect(name, findsOneWidget);
        expect(icon, findsOneWidget);
        expect(removeIcon, findsOneWidget);
      });
    });
  });
}

class ProductCardWidgetMainApp extends StatelessWidget {
  const ProductCardWidgetMainApp({
    super.key,
    required this.product,
    required this.isSelected,
  });

  final Product product;
  final bool isSelected;

  @override
  Widget build(context) {
    return MaterialApp(
      home: ProductCardWidget(
        product: product,
        onPressed: () {},
        onLongPress: () {},
        isSelected: isSelected,
      ),
    );
  }
}
