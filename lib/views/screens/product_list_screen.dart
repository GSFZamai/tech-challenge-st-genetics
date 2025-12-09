import 'package:flutter/material.dart';
import 'package:good_hamburger/models/enums/product_category_enum.dart';
import 'package:good_hamburger/models/entities/product.dart';
import 'package:good_hamburger/views/screens/widgets/product_widget.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Align(
          alignment: AlignmentGeometry.center,
          child: Column(
            children: [
              Icon(Icons.lunch_dining),
              Text(
                'Good Burger',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: const Column(
          children: [
            ProductWidget(
              product: Product(
                id: 1,
                name: 'Burger',
                category: ProductCategoryEnum.sandwich,
                price: 5.00,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
