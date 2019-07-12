import 'package:first_flutter_poject/ui_elements/class%20TitleDefault.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final String _price;

  PriceTag(this._price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      child: TitleDefault('\$$_price')
    );
  }
}
