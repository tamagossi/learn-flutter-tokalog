import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tokalog/models/exceptions/authentication.dart';
import 'package:tokalog/services/auth.dart';

class AuthProvider with ChangeNotifier {
  DateTime _expireDate;
  String _token;
  String _userId;

  final String _errorMessage = 'auth provider error';
  final String _firebaseAuthUrl = dotenv.env['FIREBASE_AUTH_URL'];
  final String _apiKey = dotenv.env['FIREBASE_KEY'];

  bool get isAuthenticated {
    return token != null;
  }

  String get token {
    if (_expireDate != null &&
        _expireDate.isAfter(DateTime.now()) &&
        token != null) {
      return _token;
    } else {
      return null;
    }
  }

  Future<void> login(Map<String, String> credential) async {
    this._authenticate(credential, 'LOGIN');
  }

  Future<void> signup(Map<String, String> credential) async {
    this._authenticate(credential, 'SIGNUP');
  }

  Future<void> _authenticate(
    Map<String, String> credential,
    String authType,
  ) async {
    try {
      AuthService _authService = new AuthService();
      const Map<String, String> AUTH_TYPE = {
        'LOGIN': 'signInWithPassword',
        'SIGNUP': 'signUp'
      };

      String url = '$_firebaseAuthUrl${AUTH_TYPE[authType]}?key=$_apiKey';
      final response = await _authService.sendCustomPostUrlRequest(
        url,
        {
          'email': credential['email'],
          'password': credential['password'],
          'returnSecureToken': true,
        },
      );

      _handleErroResponse(response);

      _storeResponseData(
        expiresIn: response['expiresIn'],
        id: response['localId'],
        token: response['idToken'],
      );
    } catch (error) {
      throw ('$_errorMessage - $authType: \n$error');
    }
  }

  void _handleErroResponse(response) {
    if (response['error'] != null) {
      throw AuthenticationException(
        message: response['error']['message'],
        code: response['error']['code'],
      );
    }
  }

  void _storeResponseData({String token, String id, String expiresIn}) {
    _token = token;
    _userId = id;
    _expireDate = DateTime.now().add(
      Duration(
        seconds: int.parse(expiresIn),
      ),
    );
  }
}
