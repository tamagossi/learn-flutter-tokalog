import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tokalog/widgets/organism/auth_card.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _authMode = AuthMode.Login;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
                colors: [
                  Color.fromRGBO(233, 94, 166, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _authMode == AuthMode.Login ? 'Login' : 'Sign Up',
                      style: GoogleFonts.anton(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      'Please sign ${_authMode == AuthMode.Login ? 'in' : 'up'} to continue',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: AuthCard(
                          authMode: _authMode,
                          setAuthMode: (mode) {
                            setState(() {
                              _authMode = mode;
                            });
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
