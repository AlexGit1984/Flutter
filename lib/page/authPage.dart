import 'dart:convert';

import 'package:first_flutter_poject/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

enum AuthMode { SignUp, Login }

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formDate = {
    "email": "",
    "password": "",
    "acceptTerms": false
  };
  final GlobalKey<FormState> _valdate = new GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  AuthMode _authMode = AuthMode.Login;


  Widget _button() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget widget, MainModel model) {
          return model.isLoading ? CircularProgressIndicator() : RaisedButton(
            color: Theme
                .of(context)
                .primaryColor,
            textColor: Colors.white,
            child: Text(_authMode== AuthMode.Login ?'LOGIN':"SignUP"),
            onPressed: () {
              _submit(model);
            },
          );
        });
  }

  void _submit(MainModel model) async {
    if (!_valdate.currentState.validate() || !_formDate["acceptTerms"]) {
      return;
    }
    _valdate.currentState.save();
     Map<String, dynamic> succesInformation;
    if (_authMode == AuthMode.Login) {
      succesInformation = await model.login(_formDate['email'], _formDate['password']);
    } else {
      succesInformation =
      await model.signUp(_formDate['email'], _formDate['password']);
    }
      if (succesInformation['success']) {
        Navigator.pushReplacementNamed(context, '/products');
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('An Error Occured'),
                content: Text(succesInformation['message']),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
  }

  Widget _switch() {
    return SwitchListTile(
      value: _formDate["acceptTerms"],
      onChanged: (bool value) {
        setState(() {
          _formDate["acceptTerms"] = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  Widget _passwordConfirm() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Confirm password'),
      controller: _passwordController,
      obscureText: true,
      validator: (String value) {
        if (_passwordController.text != value) {
          return 'Please don\'t match password';
        }
      },
    );
  }

  Widget _passwordWidget() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 4) return "Error password";
      },
      onSaved: (String value) {
        _formDate["password"] = value;
      },
    );
  }

  Widget _emailTextWidget() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'E-Mail'),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) return "Error email";
      },
      onSaved: (String value) {
        setState(() {
          _formDate["email"] = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    final double targetWidth = deviceWidth > 550.0 ? 500 : deviceWidth * 0.95;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        width: targetWidth,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                image: AssetImage('assets/back.jpg'))),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Form(
            key: _valdate,
            child: Column(
              children: <Widget>[
                _emailTextWidget(),
                SizedBox(
                  height: 10.0,
                ),
                _passwordWidget(),
                SizedBox(
                  height: 10.0,
                ),
                _authMode == AuthMode.SignUp ? _passwordConfirm() : Container(),
                SizedBox(
                  height: 10.0,
                ),
                _switch(),
                FlatButton(
                  child: Text(
                      'Switch to ${_authMode == AuthMode.Login
                          ? 'Signup'
                          : 'Login'}'),
                  onPressed: () {
                    setState(() {
                      _authMode = _authMode == AuthMode.Login
                          ? AuthMode.SignUp
                          : AuthMode.Login;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                _button(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
