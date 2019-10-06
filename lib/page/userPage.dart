import 'package:first_flutter_poject/models/Product.dart';
import 'package:first_flutter_poject/page/home.dart';
import 'package:first_flutter_poject/page/product_list.dart';
import 'package:first_flutter_poject/page/product_edit.dart';
import 'package:first_flutter_poject/scoped_models/main_model.dart';
import 'package:flutter/material.dart';

class ProductAdminPage extends StatefulWidget {
  final MainModel model;

  ProductAdminPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductAdminPage();
  }


}


  class _ProductAdminPage extends State<ProductAdminPage>{


    @override
    void initState() {
      widget.model.fetchProducts();
      super.initState();
    }

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
              ProductEditPage(), ProductListPage()
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
