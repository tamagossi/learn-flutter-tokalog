import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAdapter {
  final String baseURL =
      'https://flutter-firebase-demo-90f4d-default-rtdb.asia-southeast1.firebasedatabase.app/';

  Future<dynamic> sendGetRequest(url, {params = '?'}) async {
    try {
      final response = await http.get(
        Uri.parse(baseURL + url + params),
      );

      return json.decode(response.body);
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> sendPostRequest(url, payload) async {
    try {
      final response = await http.post(
        Uri.parse(baseURL + url),
        body: json.encode(payload ??= {}),
      );

      return json.decode(response.body);
    } catch (error) {
      print(error);
    }
  }
}
