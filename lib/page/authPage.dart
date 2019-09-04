import 'package:first_flutter_poject/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formDate = {
    "emailValue" : "",
    "passwordValue": "",
    "acceptTerms": false
  };
  final GlobalKey<FormState> _valdate = new GlobalKey<FormState>();

  Widget _button() {
    return ScopedModelDescendant<MainModel>(
      builder : (BuildContext context, Widget widget, MainModel model){
       return RaisedButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: Text('LOGIN'),
          onPressed: () {
            if(!_valdate.currentState.validate()|| !_formDate["acceptTerms"]){
              return;
            }
            _valdate.currentState.save();
            model.login(_formDate['email'], _formDate['password']);
            Navigator.pushReplacementNamed(context, '/products');
          },
        );
      }
    );
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

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
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
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value) {
                    if (value.isEmpty ||
                        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(value)) return "Error email";
                  },
                  onSaved: (String value) {
                    setState(() {
                      _formDate ["emailValue"]= value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (String value) {
                    if (value.isEmpty || value.length > 4)
                      return "Error password";
                  },
                  onSaved: (String value) {
                    _formDate ["passwordValue"]= value;
                  },
                ),
                _switch(),
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
