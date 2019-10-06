import 'package:first_flutter_poject/models/product.dart';
import 'package:first_flutter_poject/scoped_models/main_model.dart';
import 'package:first_flutter_poject/ui_elements/address_tag.dart';
import 'package:first_flutter_poject/widget/products/price_tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductPage extends StatelessWidget {
  String indexProduct;

  ProductPage(this.indexProduct);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      Navigator.pop(context, false);
      return Future.value(false);
    }, child: ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel product) {
        final Product prodctModel = product.selectedProduct;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text('Choose'),
            actions: <Widget>[
              ScopedModelDescendant<MainModel>(
                builder:
                    (BuildContext context, Widget child, MainModel model) {
                  return IconButton(
                    icon: Icon(model.displayOnlyFavorite()? Icons.favorite: Icons.favorite_border),
                    onPressed: () {
                      model.toggleDisplayMode();
                    },
                  );
                },
              ),
            ],
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.edit),
                ),
                FadeInImage(
                  image: NetworkImage(prodctModel.image),
                  height: 300.0,
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/a.jpg'),
                ),
                Text(
                  prodctModel.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.info),
                    ),
                  ],
                ),
                PriceTag(prodctModel.price.toString()),
                AddressTag("Square San Franciso"),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(prodctModel.description.toString()),
                  alignment: Alignment.center,
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}
