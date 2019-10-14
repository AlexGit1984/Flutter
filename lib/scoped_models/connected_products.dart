import 'dart:async';
import 'dart:convert';

import 'package:first_flutter_poject/models/auth.dart';
import 'package:first_flutter_poject/models/product.dart';
import 'package:first_flutter_poject/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectedProductsModel extends Model {
  List<Product> _products = [];
  String _selProductId;
  bool showFavorites = false;
  User _authenticatedUser;
  bool _isLoading = false;


  User get user {
    return _authenticatedUser;
  }

  Future<bool> addProduct(String title, String description, String image,
      double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
      'http://money24.kharkov.ua/wp-content/uploads/2015/04/img-currency15.png',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };
    return http
        .post(
        'https://testflutter-dfaea.firebaseio.com/products2.json?auth=${_authenticatedUser
            .token}',
        body: json.encode(productData))
        .then((http.Response response) {
      if (response.statusCode != 201 || response.statusCode != 200) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          price: price,
          image: image,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((onError) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> fetchProducts() {
    _isLoading = true;
    notifyListeners();
    final List<Product> fetchedProductList = [];
    http
        .get(
        'https://testflutter-dfaea.firebaseio.com/products.json?auth=${_authenticatedUser
            .token}')
        .then((http.Response response) {
      print(json.decode(response.body));
      final Map<String, dynamic> map = json.decode(response.body);
      if (map == null) {
        _isLoading = false;
        notifyListeners();
        print("Map  =" + map.toString());
        return;
      }
      map.forEach(
            (String productId, dynamic productDate) {
          final Product product = Product(
              id: productId,
              title: productDate['title'],
              description: productDate['description'],
              price: productDate['price'],
              image: productDate['image'],
              userEmail: productDate['userEmail'],
              userId: productDate['uderId']);
          fetchedProductList.add(product);
        },
      );
      _isLoading = false;
      _products = fetchedProductList;
      notifyListeners();
      _selProductId = null;
    }).catchError((onError) {
      _isLoading = false;
      notifyListeners();
      _selProductId = null;
      return false;
    });
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

  String get selectedProductId {
    return _selProductId;
  }

  Product get selectedProduct {
    if (selectedProductId == null) {
      return null;
    }
    return _products.firstWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  int get selectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  Future<bool> updateProduct(String title, String description, String image,
      double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image':
      'http://money24.kharkov.ua/wp-content/uploads/2015/04/img-currency15.png',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id,
    };
    return http
        .put(
        'https://testflutter-dfaea.firebaseio.com/products/${selectedProduct
            .id}.json?auth=${_authenticatedUser.token}',
        body: json.encode(updateData))
        .then((http.Response response) {
      print(json.decode(response.body));
      final Product updateProduct = Product(
          id: selectedProduct.id,
          title: title,
          description: description,
          price: price,
          image: image,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      print(_products[selectProductIndex]);
      _products[selectProductIndex] = updateProduct;
//    _selProductIndex = null;
      _isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      _isLoading = false;
      notifyListeners();
      _selProductId = null;
      return false;
    });
  }

  int get selectProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  void deleteProduct() {
//    _selProductIndex = null;
    final deleteProductId = selectedProduct.id;
    _products.removeAt(selectProductIndex);
    notifyListeners();
    _isLoading = true;
    http
        .delete(
        'https://testflutter-dfaea.firebaseio.com/products/${deleteProductId}.json?auth=${_authenticatedUser
            .token}')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
    });
  }

  void selectProduct(String index) {
    _selProductId = index;
    notifyListeners();
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavourite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavourite;
    final Product updateProduct = Product(
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavorite: newFavoriteStatus,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    _products[selectProductIndex] = updateProduct;
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
mixin UserModel on ConnectedProductsModel {
  Timer _authTime;
  PublishSubject<bool> _publishUserSubject = PublishSubject();

  PublishSubject<bool> get userSubject{
    return _publishUserSubject;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyCNGcR4ya-nkaRK3Gi1beP25ZB_2kq3Egc',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyCNGcR4ya-nkaRK3Gi1beP25ZB_2kq3Egc',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }
    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Authentification succeeded';
    if (responseData.containsKey('idToken')) {
      hasError = false;
      _authenticatedUser =
          User(id: responseData['localId'],
              email: email,
              token: responseData['idToken']);
      final DateTime now = DateTime.now();
      final DateTime expiryTime = now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
      setAuthTimeOut(int.parse(responseData['expiresIn']));
      userSubject.add(true);
      final SharedPreferences preferences = await SharedPreferences
          .getInstance();
      preferences.setString('token', responseData['idToken']);
      preferences.setString('userEmail', email);
      preferences.setString('userId', responseData['localId']);
      preferences.setString('expiryTime',expiryTime.toIso8601String());
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This email was not found';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'This password is invalid';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email exist';
    }
    print(json.decode(response.body));
    notifyListeners();
    _isLoading = false;
    return {'success': !hasError, 'message': message};
  }

  void autoAuthenticate() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String token = preferences.get('token');
    final String expiryTime = preferences.get('expiryTime');
    if (token != null) {
      final DateTime now = DateTime.now();
      final parsedExpiryTime  = DateTime.parse(expiryTime);
      if(parsedExpiryTime.isBefore(now)){
        _authenticatedUser = null;
        notifyListeners();
        return;
      }
      final String email = preferences.get('userEmail');
      final String userId = preferences.get('userId');
      final int tokenLifespan = parsedExpiryTime.difference(now).inSeconds;
      _authenticatedUser = new User(id: userId, email: email, token: token);
      setAuthTimeOut(tokenLifespan);
      notifyListeners();
    }
  }

  void setAuthTimeOut(int time) {
   _authTime =  Timer(Duration(seconds: time), () {
        logout();
        _publishUserSubject.add(false);
   });
  }

  void logout() async {
    print("Logout");
    _authenticatedUser = null;
    _authTime.cancel();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
    _publishUserSubject.add(true);
  }
}
mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
