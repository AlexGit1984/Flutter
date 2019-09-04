
import 'dart:convert';

import 'package:first_flutter_poject/models/product.dart';
import 'package:first_flutter_poject/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import 'main_model.dart';

class ConnectedProductsModel extends Model {

  List<Product> _products = [];
  int _selProductIndex;
  bool showFavorites = false;
  User _authenticatedUser;

  void addProduct(String title, String description , double price,  String image) {
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image': '',
      'price': 3
    };
    http.post('https://testflutter-dfaea.firebaseio.com/product', body: json.encode(productData));
    final Product newProduct = Product(title: title, description: description, price: price, image: image, userEmail: _authenticatedUser.email, userId: _authenticatedUser.id);
    _products.add(newProduct);
    _selProductIndex = null;
    notifyListeners();
  }
}

mixin ProductsModel on ConnectedProductsModel {

  List<Product> get allProducts {
    if (showFavorites) {
      return List.from(
          _products.where((Product product) => product.isFavorite).toList());
    }
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }
    return _products[selectedProductIndex];
  }

  void updateProduct(String title, String description , String image, double price) {
    final Product updateProduct = Product(title: title, description: description, price: price, image: image, userEmail: _authenticatedUser.email, userId: _authenticatedUser.id);
    _products[selectedProductIndex] = updateProduct;
//    _selProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(selectedProductIndex);
//    _selProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    notifyListeners();
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavourite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavourite;
    final Product updateProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavorite: newFavoriteStatus,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    _products[selectedProductIndex] = updateProduct;
    _selProductIndex = null;
    notifyListeners();
  }

  void toggleDisplayMode() {
    showFavorites = !showFavorites;
    notifyListeners();
  }

  bool displayOnlyFavorite() {
    return showFavorites;
  }
}
mixin UserModel on ConnectedProductsModel{

  void login(String email, String password){
    _authenticatedUser = User(id: '1', email : email, password: password);
  }
}