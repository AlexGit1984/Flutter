import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCreate extends StatefulWidget {
  final Function addProduct;

  ProductCreate(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreate();
  }
}

class _ProductCreate extends State<ProductCreate> {
  String title = "";
  String description = "";
  double price;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _submit() {
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();
    final Map<String, dynamic> value = {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': 'assets/a.jpg'
    };
    widget.addProduct(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Title"),
              onSaved: (String value) {
                setState(() {
                  title = value;
                });
              },
            ),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(labelText: "Description"),
              onSaved: (String value) {
                setState(() {
                  if(value.length>0) {
                    description = value;
                  }else{
                    return "Error description";
                  }
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
              onSaved: (String value) {
                setState(() {
                  price = double.parse(value);
                });
              },
            ),
            RaisedButton(
              child: Text("Pressed"),
              onPressed: () {
                _submit;
              },
            )
          ],
        ),
      ),
    );
  }
}
