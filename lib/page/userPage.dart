import 'package:first_flutter_poject/page/home.dart';
import 'package:first_flutter_poject/page/product_admin.dart';
import 'package:first_flutter_poject/page/product_create.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final Function addProduct;
  final Function deleteProduct;

  UserPage(this.addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text('User Details'),
        bottom: TabBar(tabs: <Widget>[
          Tab(text: 'Create product'),
          Tab(text: 'My product',)
        ]),),

        body: TabBarView(
            children: <Widget>[
              ProductCreate(addProduct), ProductCreatePage()
            ],
          ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.edit),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, '/product');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
