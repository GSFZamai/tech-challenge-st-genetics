import 'package:flutter/material.dart';
import 'package:good_hamburger/models/entities/product.dart';

class OrderCardWidget extends StatelessWidget {
  final Product product;

  const OrderCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 8,
              children: [
                Text(
                  '1x ${product.name}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [Text('\$ ${product.price.toStringAsFixed(2)}')],
            ),
          ],
        ),
      ),
    );
  }
}
