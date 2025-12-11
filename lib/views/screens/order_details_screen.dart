import 'package:flutter/material.dart';
import 'package:good_hamburger/view_models/order_view_model.dart';
import 'package:good_hamburger/views/screens/previous_order_screen.dart';
import 'package:good_hamburger/views/widgets/order_list_card.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderViewModel orderViewModel;
  const OrderDetailsScreen({super.key, required this.orderViewModel});

  Future<void> handleTapSubmitButton(BuildContext context) async {
    await orderViewModel.submitOrder();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PreviousOrderScreen(orderViewModel: orderViewModel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Align(
          alignment: AlignmentGeometry.center,
          child: Column(
            children: [
              Text(
                'Order #${orderViewModel.orderId}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(24),
              child: Column(
                spacing: 8,
                children: [
                  ...orderViewModel.orderProductList.map(
                    (product) => OrderListCard(product: product),
                  ),
                  ListenableBuilder(
                    listenable: orderViewModel,
                    builder: (context, child) => TextFormField(
                      onChanged: orderViewModel.updateName,
                      initialValue: orderViewModel.name.trim(),
                      decoration: InputDecoration(
                        hintText: "Fill your name to place order",
                        helperText: "Name is required to place order.",
                        icon: Icon(Icons.assignment_ind_rounded),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.all(24),
                child: Column(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal:'),
                        Text(orderViewModel.formattedSubtotal),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Discount:'),
                        Text(orderViewModel.formattedPercentageDiscount),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total discount:'),
                        Text(orderViewModel.formattedTotalDiscount),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total:'),
                        Text(orderViewModel.formattedTotal),
                      ],
                    ),
                    SizedBox(height: 16),
                    ListenableBuilder(
                      listenable: orderViewModel,
                      builder: (context, child) {
                        return ElevatedButton(
                          onPressed: orderViewModel.name.isEmpty
                              ? null
                              : () => handleTapSubmitButton(context),
                          child: Text("Place Order"),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
