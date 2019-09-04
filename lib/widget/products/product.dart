
import 'package:first_flutter_poject/models/product.dart';
import 'package:first_flutter_poject/scoped_models/main_model.dart';
import 'package:first_flutter_poject/widget/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductWidget  extends StatelessWidget {
  Widget _buildProductList(List<Product> products) {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        itemCount: products.length,
      );
    } else {
      productCards = Container();
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build()');
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
//      Widget buildProduct = _buildProductList(model.products);
//      return model.selectedProduct == null ? buildProduct : Scaffold(
//        appBar: AppBar(
//          title: Text('Edit Product'),
//      ));
      return  _buildProductList(model.displayedProducts);
    },);
  }
}
