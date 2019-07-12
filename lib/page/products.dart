import 'package:first_flutter_poject/ui_elements/address_tag.dart';
import 'package:first_flutter_poject/widget/products/price_tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  String _imageUrl;
  String _title;
  double _price;
  String _description;

  ProductPage(this._title, this._imageUrl, this._price, this._description);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Choose'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.edit),
              ),
              Image.asset(_imageUrl),
              Text(
                _title,
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
              PriceTag(_price.toString()),
              AddressTag("Square San Franciso"),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(_description.toString()),
                alignment: Alignment.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
