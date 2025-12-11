import 'package:flutter/material.dart';
import 'package:good_hamburger/view_models/order_view_model.dart';
import 'package:good_hamburger/view_models/past_order_view_model.dart';
import 'package:good_hamburger/views/widgets/past_order_shimmer_widget.dart';
import 'package:good_hamburger/views/widgets/past_order_card_widget.dart';

class PastOrderScreen extends StatelessWidget {
  final OrderViewModel orderViewModel;
  final PastOrderViewModel pastOrderViewModel = PastOrderViewModel();

  PastOrderScreen({super.key, required this.orderViewModel});

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
          child: ListenableBuilder(
            listenable: pastOrderViewModel,
            builder: (context, child) {
              final orderList = pastOrderViewModel.orderList;
              final isLoading = pastOrderViewModel.isLoading;
              if (isLoading)
                return ListView(
                  children: [PastOrderShimmerWidget(listSize: 2)],
                );

              return orderList.isEmpty
                  ? Center(child: Text("The list is empty..."))
                  : ListView(
                      children: orderList
                          .map((order) => PastOrderCardWidget(order: order))
                          .toList(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
