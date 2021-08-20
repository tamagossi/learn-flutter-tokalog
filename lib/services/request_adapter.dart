import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAdapter {
  final String baseURL =
      'https://flutter-firebase-demo-90f4d-default-rtdb.asia-southeast1.firebasedatabase.app/';

  dynamic sendPostRequest(url, payload) {
    var response = http.post(
      Uri.parse((url)),
      body: json.encode(payload ??= {}),
    );

    return response;
  }
}
