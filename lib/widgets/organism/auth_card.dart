import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokalog/models/exceptions/authentication.dart';
import 'package:tokalog/providers/auth.dart';
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

  void _submit() async {
    try {
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (!_formKey.currentState.validate()) return;

      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });

      if (widget.authMode == AuthMode.Login) {
        print('You are here right?');
        await authProvider.login(_authData);
      } else {
        await authProvider.signup(_authData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Sucesfully sign up as a new user..'),
          ),
        );

        widget.setAuthMode(AuthMode.Login);
      }
    } on AuthenticationException catch (error) {
      _handleError(error.toString());
    } catch (error) {
      _handleError(error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleError(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error occured'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('Okay'),
            onPressed: () => Navigator.of(ctx).pop(),
          )
        ],
      ),
    );
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
    final containerHeight =
        (widget.authMode == AuthMode.Signup ? 300 : 240).toDouble();

    return Container(
      height: 400,
      child: Column(
        children: [
          Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: _isLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    height: containerHeight,
                  )
                : Container(
                    height: containerHeight,
                    padding: EdgeInsets.all(16.0),
                    width: deviceSize.width * 0.75,
                    constraints: BoxConstraints(
                      minHeight: containerHeight,
                    ),
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
                              decoration:
                                  InputDecoration(labelText: 'password'),
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
                                decoration: InputDecoration(
                                    labelText: 'confirm password'),
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
                              ElevatedButton(
                                onPressed: _submit,
                                child: Text(
                                  widget.authMode == AuthMode.Login
                                      ? 'LOGIN'
                                      : 'SIGN UP',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).accentColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
          TextButton(
            onPressed: _switchAuthMode,
            child: Text(
              '${widget.authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
