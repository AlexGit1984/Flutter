
import 'package:first_flutter_poject/widget/products/product.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductsPage(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose'),
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text('Manage Products'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('My Page'),
        actions: <Widget>[
          IconButton(
            icon: IconButton(icon: Icon(Icons.favorite), onPressed: (){
              Icon(Icons.favorite_border);
            }),
          )
        ],
      ),
      body: Product(this.products),
    );
  }
}
