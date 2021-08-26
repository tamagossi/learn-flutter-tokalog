import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAdapter {
  final String baseURL =
      'https://flutter-firebase-demo-90f4d-default-rtdb.asia-southeast1.firebasedatabase.app/';

  Future<dynamic> sendGetRequest(
    String url, {
    Map<String, dynamic> params = const {},
  }) async {
    final response = await http.get(
      Uri.parse(baseURL + url + parseParams(params)),
    );

    return json.decode(response.body);
  }

  Future<dynamic> sendPostRequest(url, payload) async {
    final response = await http.post(
      Uri.parse(baseURL + url),
      body: json.encode(payload ??= {}),
    );

    return json.decode(response.body);
  }

  String parseParams(params) {
    if (params == {}) return '';

    return '';
  }
}
