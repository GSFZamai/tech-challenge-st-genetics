import 'package:flutter/material.dart';
import 'package:good_hamburger/models/entities/product.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;
  final bool isSelected;

  const ProductWidget({
    super.key,
    required this.product,
    required this.onPressed,
    required this.onLongPress,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: TextButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
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
                isSelected
                    ? Icon(Icons.remove_circle, color: Colors.red)
                    : Icon(Icons.add_circle, color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
