import 'package:first_flutter_poject/page/authPage.dart';
import 'package:first_flutter_poject/page/home.dart';
import 'package:first_flutter_poject/page/userPage.dart';
import 'package:first_flutter_poject/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
  @override
  Widget build(BuildContext context) {
    MainModel mainModel = new MainModel();
    return ScopedModel<MainModel>(
      model: mainModel,
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepPurple,
            buttonColor: Colors.deepPurple),

        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/products': (BuildContext context) => ProductsPage(mainModel),
          '/admin': (BuildContext context) => ProductAdminPage(mainModel)
        },
        onGenerateRoute: (RouteSettings rout) {
          final List<String> pathElements = rout.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'products') {
            final String productId = pathElements[2];
            mainModel.selectProduct(productId);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  ProductPage(productId),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(mainModel));
        },
      ),
    );
  }
}
