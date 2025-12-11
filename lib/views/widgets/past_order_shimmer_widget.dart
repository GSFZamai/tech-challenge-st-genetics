import 'package:flutter/material.dart';

class PastOrderShimmerWidget extends StatelessWidget {
  final int listSize;
  const PastOrderShimmerWidget({super.key, required this.listSize});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.filled(listSize, 1)
          .map(
            (toElement) => Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                child: Column(
                  spacing: 8,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Icon(Icons.receipt),
                        Container(
                          width: 100,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade100,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Column(
                      spacing: 8,
                      children: [
                        Text(
                          "Products",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...[1, 2].map(
                          (_) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 100,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade100,
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade100,
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Name"),
                        Container(
                          width: 100,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade100,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("SubTotal"),
                        Container(
                          width: 100,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade100,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount"),
                        Container(
                          width: 100,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade100,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 10,
                      children: [
                        Text("Total Discount"),
                        Expanded(
                          child: Container(
                            width: 100,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade100,
                              shape: BoxShape.rectangle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 100,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade100,
                              shape: BoxShape.rectangle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
