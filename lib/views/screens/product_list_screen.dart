import 'package:flutter/material.dart';
import 'package:good_hamburger/models/entities/product.dart';
import 'package:good_hamburger/models/enums/product_category_enum.dart';
import 'package:good_hamburger/models/shared/custom_exception.dart';
import 'package:good_hamburger/view_models/order_view_model.dart';
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
  OrderViewModel orderViewModel = OrderViewModel();
  ProductCategoryEnum? productCategory;
  void handlePressProductCard(Product product) {
    try {
      orderViewModel.addProduct(product);
    } catch (e) {
      if (e is CustomException) {
        ScaffoldMessenger.maybeOf(
          context,
        )?.showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

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
          padding: EdgeInsetsGeometry.all(24),

          child: Column(
            spacing: 16,
            children: [
              SegmentedButton(
                showSelectedIcon: false,
                segments: [
                  ButtonSegment(
                    value: ProductCategoryEnum.sandwich,
                    enabled: true,
                    label: Text("Sandwich"),
                  ),
                  ButtonSegment(
                    value: ProductCategoryEnum.extras,
                    enabled: true,
                    label: Text("Extras"),
                  ),
                  ButtonSegment(value: null, enabled: true, label: Text("All")),
                ],
                onSelectionChanged: (newSelection) {
                  productViewModel.filterProductsByCategory(newSelection.first);
                  setState(() {
                    productCategory = newSelection.first;
                  });
                },
                selected: {productCategory},
                emptySelectionAllowed: true,
              ),

              ListenableBuilder(
                listenable: productViewModel,
                builder: (context, child) {
                  final productList = productViewModel.productList;
                  if (productList.isEmpty) {
                    return Text("Fetching data...");
                  }
                  return ListenableBuilder(
                    listenable: orderViewModel,
                    builder: (context, child) {
                      return Column(
                        children: productList
                            .map(
                              (product) => ProductWidget(
                                onPressed: () =>
                                    handlePressProductCard(product),
                                onLongPress: () =>
                                    orderViewModel.removeProduct(product.id),
                                isSelected: orderViewModel.isSelected(
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
              Expanded(
                child: Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: ListenableBuilder(
                    listenable: orderViewModel,
                    builder: (context, child) {
                      final orderProductList = orderViewModel.orderProductList;
                      if (orderProductList.isEmpty) return Container();
                      return OrderWidget(orderViewModel: orderViewModel);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
