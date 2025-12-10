import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  final int items;
  const OrderWidget({super.key, required this.items});

  void onTapButton() {}

  @override
  Widget build(context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.white,
      tooltip: "Navigate to order list",
      icon: Icon(Icons.lunch_dining_rounded),
      onPressed: onTapButton,
      label: Text("View order (${items.toString()} Items)"),
    );
  }
}
