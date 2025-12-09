import 'package:flutter/material.dart';
import 'package:good_hamburger/models/entities/product.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(Icons.lunch_dining),
                Text(
                  product.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                Text('\$ ${product.price.toStringAsFixed(2)}'),
                Icon(Icons.add_circle, color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
