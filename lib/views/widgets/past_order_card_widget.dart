import 'package:flutter/material.dart';
import 'package:good_hamburger/models/entities/order.dart';
import 'package:good_hamburger/view_models/past_order_view_model.dart';

class PastOrderCardWidget extends StatelessWidget {
  final Order order;
  final PastOrderViewModel previousOrdersViewModel = PastOrderViewModel();
  PastOrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          spacing: 8,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                Icon(Icons.receipt),
                Text(
                  "Order #${order.id}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            Divider(),
            Column(
              children: [
                Text(
                  "Products",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ...order.productList.map(
                  (product) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("1x ${product.name}"),
                      Text("\$ ${product.price.toStringAsFixed(2)}"),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Text(
              "Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Name"), Text(order.name)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("SubTotal"),
                Text(previousOrdersViewModel.formattedSubTotal(order)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discount"),
                Text(
                  previousOrdersViewModel.formattedPercentageDiscount(order),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Discount"),
                Text(previousOrdersViewModel.formattedValueDiscount(order)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  previousOrdersViewModel.formattedTotal(order),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
