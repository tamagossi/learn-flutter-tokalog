import 'package:tokalog/services/request_adapter.dart';

class AuthService extends RequestAdapter {
  String _url = 'products.json';
  String _errorMessage = "auth http request error";

  Future<dynamic> signup(Map<String, String> payload) async {
    try {
      var response = await this.sendPostRequest(_url, payload);
      return response;
    } catch (error) {
      throw ('$_errorMessage - user sign up: \n$error');
    }
  }
}
