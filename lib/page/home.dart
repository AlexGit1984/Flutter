
import 'package:first_flutter_poject/scoped_models/main_model.dart';
import 'package:first_flutter_poject/widget/products/product.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsPage extends StatelessWidget {
//  final List<Product> products;
//
//  ProductsPage(this.products);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('My Page'),
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
      body: ProductWidget(),
    );
  }
}
