import 'package:flutter/material.dart';
import 'package:good_hamburger/view_models/order_view_model.dart';
import 'package:good_hamburger/views/screens/order_details_screen.dart';

class OrderWidget extends StatelessWidget {
  final OrderViewModel orderViewModel;
  const OrderWidget({super.key, required this.orderViewModel});

  void onTapButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OrderDetailsScreen(orderViewModel: orderViewModel),
      ),
    );
  }

  @override
  Widget build(context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.white,
      tooltip: "Navigate to order list",
      icon: Icon(Icons.lunch_dining_rounded),
      onPressed: () => onTapButton(context),
      label: Text(
        "View order (${orderViewModel.orderProductList.length.toString()} Items)",
      ),
    );
  }
}
