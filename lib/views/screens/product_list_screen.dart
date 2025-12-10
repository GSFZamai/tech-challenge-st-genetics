import 'package:flutter/material.dart';
import 'package:good_hamburger/models/entities/product.dart';
import 'package:good_hamburger/view_models/product_order_view_model.dart';
import 'package:good_hamburger/view_models/product_view_model.dart';
import 'package:good_hamburger/views/widgets/order_widget.dart';
import 'package:good_hamburger/views/widgets/product_widget.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreen();
}

class _ProductListScreen extends State<ProductListScreen> {
  ProductViewModel productViewModel = ProductViewModel();
  ProductOrderViewModel productOrderViewModel = ProductOrderViewModel();

  @override
  void initState() {
    super.initState();
    productViewModel.init();
  }

  @override
  void dispose() {
    super.dispose();
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
              Icon(Icons.lunch_dining),
              Text(
                'Good Burger',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: Column(
            spacing: 20,
            children: [
              ListenableBuilder(
                listenable: productViewModel,
                builder: (context, child) {
                  final productList = productViewModel.productList;
                  if (productList.isEmpty) {
                    return Text("Lista vazia...");
                  }
                  return ListenableBuilder(
                    listenable: productOrderViewModel,
                    builder: (context, child) {
                      return Column(
                        children: productList
                            .map(
                              (product) => ProductWidget(
                                onPressed: () =>
                                    productOrderViewModel.addProduct(product),
                                onLongPress: () => productOrderViewModel
                                    .removeProduct(product.id),
                                isSelected: productOrderViewModel.isSelected(
                                  product.id,
                                ),
                                product: Product(
                                  id: product.id,
                                  name: product.name,
                                  category: product.category,
                                  price: product.price,
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  );
                },
              ),
              ListenableBuilder(
                listenable: productOrderViewModel,
                builder: (context, child) {
                  final orderProductList =
                      productOrderViewModel.productOrderModel.productList;
                  if (orderProductList.isEmpty) return Placeholder();
                  return OrderWidget(items: orderProductList.length);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
