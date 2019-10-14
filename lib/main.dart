import 'package:first_flutter_poject/page/authPage.dart';
import 'package:first_flutter_poject/page/home.dart';
import 'package:first_flutter_poject/page/userPage.dart';
import 'package:first_flutter_poject/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';
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
  MainModel _mainModel = new MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _mainModel.autoAuthenticate();
    _mainModel.userSubject.listen((bool isAuthenticated){
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _mainModel,
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepPurple,
            buttonColor: Colors.deepPurple),

        routes: {
          '/': (BuildContext context) =>
          !_isAuthenticated ? AuthPage() : ProductsPage(_mainModel),
          '/admin': (BuildContext context) => ProductAdminPage(_mainModel)
        },
        onGenerateRoute: (RouteSettings rout) {
          if(!_isAuthenticated){
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => AuthPage(),
            );
          }
          final List<String> pathElements = rout.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'products') {
            final String productId = pathElements[2];
            _mainModel.selectProduct(productId);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
              !_isAuthenticated ? AuthPage() :
                  ProductPage(productId),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(_mainModel));
        },
      ),
    );
  }

}
