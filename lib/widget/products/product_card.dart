import 'package:first_flutter_poject/models/product.dart';
import 'package:first_flutter_poject/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCard extends StatelessWidget {
  final Product products;
  final int productIndex;

  ProductCard(this.products, this.productIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: <Widget>[
        Image.asset(products.image),
        Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  child: Text(products.title),
                ),
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).accentColor),
                    child: Text(products.price.toString()),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).accentColor),
                    child: Text(products.description.toString()),
                  ),
                )
              ]),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(4.0)),
          child: Text("text"),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.info),
              color: Theme.of(context).primaryColor,
              onPressed: () => Navigator.pushNamed<bool>(
                  context, '/products/' + productIndex.toString()),
            ),
            ScopedModelDescendant(builder:
                (BuildContext contex, Widget child, MainModel model) {
              return IconButton(
                  icon: Icon(model.allProducts[productIndex].isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  color: Colors.red,
                  onPressed: () {
                    model.selectProduct(productIndex);
                    model.toggleProductFavoriteStatus();
                  });
            }),
          ],
        ),
      ],
    ));
  }
}
