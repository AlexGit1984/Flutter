import 'package:first_flutter_poject/widget/products/product_card.dart';
import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Product(this.products);

  @override
  Widget build(BuildContext context) {
    print("build StatelessWidget");
//    debugger();
    return _buildProduct();
  }

  Widget _buildProduct() {
    if (products.length > 0) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) => ProductCard(products[index], index),
        itemCount: products.length,
      );
    } else
      return Center(child: Text("No items"));
  }
}
