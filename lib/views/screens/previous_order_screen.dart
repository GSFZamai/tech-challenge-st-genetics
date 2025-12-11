import 'package:flutter/material.dart';
import 'package:good_hamburger/models/entities/order.dart';
import 'package:good_hamburger/view_models/order_view_model.dart';

class PreviousOrderScreen extends StatefulWidget {
  final OrderViewModel orderViewModel;

  PreviousOrderScreen({super.key, required this.orderViewModel});

  @override
  State<PreviousOrderScreen> createState() => _PreviousOrderScreen();
}

class _PreviousOrderScreen extends State<PreviousOrderScreen> {
  late List<Order>? orderList;

  void handleGetOrderList() async {
    final list = await widget.orderViewModel.getSubmittedOrderList();
    setState(() {
      orderList = list;
    });
  }

  @override
  void initState() {
    super.initState();
    handleGetOrderList();
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
                'Past Orders',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(24),
          child: Scrollable(
            viewportBuilder: (context, offset) => Column(
              children: orderList!
                  .map(
                    (order) => Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        child: Column(
                          spacing: 8,
                          children: [
                            Row(children: [Text("Order #${order.id}")]),
                            Divider(),
                            Column(
                              children: [
                                Text("Order details"),
                                ...order.productList.map(
                                  (product) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("1x ${product.name}"),
                                      Text(
                                        "\$ ${product.price.toStringAsFixed(2)}",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Text("Total"),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
