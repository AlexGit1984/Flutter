

import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function addProduct;

  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        addProduct({'title': 'Hi1' , 'imageUrl' : 'assets/a.jpg'});
      },
      child: Text('Add Product'),
    );
  }
}