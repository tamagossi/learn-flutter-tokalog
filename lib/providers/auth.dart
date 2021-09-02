import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tokalog/services/auth.dart';

class AuthProvider with ChangeNotifier {
  DateTime _expireDate;
  String _token;
  String _userId;

  final String signupURL = dotenv.env['FIREBASE_SIGNUP_URL'];
  var _authService = new AuthService();
  String _errorMessage = 'auth provider error';

  Future<void> signup(Map<String, String> credential) async {
    try {
      _authService = new AuthService();

      await _authService.sendCustomPostUrlRequest(signupURL, {
        'email': credential['email'],
        'password': credential['password'],
        'returnSecureToken': true,
      });
    } catch (error) {
      throw ('$_errorMessage - sign up: \n$error');
    }
  }
}
