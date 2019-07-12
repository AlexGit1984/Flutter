import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue;
  String _passwordValue;
  bool _acceptTerms = false;


  Widget _button() {
    return RaisedButton(
      color: Theme
          .of(context)
          .primaryColor,
      textColor: Colors.white,
      child: Text('LOGIN'),
      onPressed: () {
        print(_emailValue);
        print(_passwordValue);
        Navigator.pushReplacementNamed(context, '/products');
      },
    );
  }

  Widget _switch() {
    return SwitchListTile(
      value: _acceptTerms,
      onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
        });
      },
      title: Text('Accept Terms'),
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
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) {
                    setState(() {
                      _emailValue = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: (String value) {
                    setState(() {
                      _passwordValue = value;
                    });
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
