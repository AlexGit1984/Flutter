

import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> products;
  final int productIndex;

  ProductCard(this.products, this.productIndex);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: Column(
          children: <Widget>[
            Image.asset(products['imageUrl']),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      child: Text(products['title']),
                    ),
                    Expanded(
                      child: Container(
                        decoration:
                        BoxDecoration(color: Theme
                            .of(context)
                            .accentColor),
                        child: Text(products['price'].toString()),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration:
                        BoxDecoration(color: Theme
                            .of(context)
                            .accentColor),
                        child: Text(products['description'].toString()),
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
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onPressed: () =>
                      Navigator.pushNamed<bool>(
                          context, '/products/' + productIndex.toString()),
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Colors.red,
                  onPressed: () =>
                      Navigator.pushNamed<bool>(
                          context, '/products/' + productIndex.toString()),
                ),
              ],
            ),
          ],
        ));
  }
}