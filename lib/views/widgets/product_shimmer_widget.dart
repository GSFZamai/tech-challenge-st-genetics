import 'package:flutter/material.dart';

class ProductShimmerWidget extends StatelessWidget {
  final int listSize;
  const ProductShimmerWidget({super.key, required this.listSize});
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Icon(Icons.lunch_dining),
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

                    Container(
                      width: 50,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade100,
                        shape: BoxShape.rectangle,
                      ),
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
