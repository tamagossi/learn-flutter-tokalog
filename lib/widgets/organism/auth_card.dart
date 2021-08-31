import 'package:flutter/material.dart';
import 'package:tokalog/screens/auth.dart';

class AuthCard extends StatefulWidget {
  final AuthMode authMode;
  final Function setAuthMode;

  AuthCard({
    this.authMode,
    this.setAuthMode,
  });

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _submit() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if (widget.authMode == AuthMode.Login) {
      // Log user in
    } else {
      // Sign user up
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (widget.authMode == AuthMode.Login) {
      widget.setAuthMode(AuthMode.Signup);
    } else {
      widget.setAuthMode(AuthMode.Login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: widget.authMode == AuthMode.Signup ? 320 : 260,
        padding: EdgeInsets.all(16.0),
        width: deviceSize.width * 0.75,
        constraints: BoxConstraints(
            minHeight: widget.authMode == AuthMode.Signup ? 320 : 260),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'e-mail'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'password'),
                  obscureText: true,
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                ),
                if (widget.authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'confirm password'),
                    enabled: widget.authMode == AuthMode.Signup,
                    obscureText: true,
                    validator: widget.authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _submit,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                    child: Text(widget.authMode == AuthMode.Login
                        ? 'LOGIN'
                        : 'SIGN UP'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                  ),
                FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                      '${widget.authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
