import 'package:first_flutter_poject/page/authPage.dart';
import 'package:first_flutter_poject/page/home.dart';
import 'package:first_flutter_poject/page/userPage.dart';
import 'package:flutter/material.dart';

import 'page/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];

//  @override
//  void initState() {
//    print('[ProductManager State] initState()');
//    if (widget.startingProduct != null) {
//      _products.add(widget.startingProduct);
//    }
//    super.initState();
//
//
//  @override
//  void didUpdateWidget(ProductManager oldWidget) {
//    print('[ProductManager State] didUpdateWidget()');
//    super.didUpdateWidget(oldWidget);
//  }

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      if (product != null) {
        _products.add(product);
        print(_products);
      }
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
      print(_products);
    });
  }

  build(context) {
    return MaterialApp(
//      home: AuthPage(),
      //MaterialApp
      routes: {
        '/': (BuildContext context) =>
            AuthPage(),
        '/products': (BuildContext context) =>
            ProductsPage(_products),
        '/admin': (BuildContext context) => UserPage(_addProduct, _deleteProduct)
      },
      onGenerateRoute: (RouteSettings rout) {
        final List<String> pathElements = rout.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'products') {
          final int index = int.parse(pathElements[2]);
          print(_products[index]['title']);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(
                _products[index]['title'], _products[index]['imageUrl'], _products[index]['price'], _products[index]['description']),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                AuthPage());
      },
    );
  }
}
