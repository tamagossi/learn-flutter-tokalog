import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:tokalog/services/local_storage.dart';

class RequestAdapter {
  final String baseURL = dotenv.env['FIREBASE_URL'];
  String token = '';

  RequestAdapter() {
    final tokenLocalStorage = new LocalStorage(fileName: 'tokalog_token');

    tokenLocalStorage.readContent().then(
      (storedToken) {
        token = storedToken;
      },
    );
  }

  Future<dynamic> sendDeleteRequest(url) async {
    final response = await http.delete(
      Uri.parse(baseURL + url + '?auth=$token'),
    );

    return json.decode(response.body);
  }

  Future<dynamic> sendGetRequest(
    String url, {
    Map<String, dynamic> params = const {},
  }) async {
    final response = await http.get(
      Uri.parse(baseURL + url + parseParams(params) + '?auth=$token'),
    );

    return json.decode(response.body);
  }

  Future<dynamic> sendPatchRequest(url, payload) async {
    final response = await http.patch(
      Uri.parse(baseURL + url + '?auth=$token'),
      body: json.encode(payload ??= {}),
    );

    return json.decode(response.body);
  }

  Future<dynamic> sendCustomPostUrlRequest(url, payload) async {
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(payload),
    );

    return json.decode(response.body);
  }

  Future<dynamic> sendPostRequest(url, payload, {auth = false}) async {
    final response = await http.post(
      Uri.parse(baseURL + url + '?auth=$token'),
      body: json.encode(payload ??= {}),
    );

    return json.decode(response.body);
  }

  String parseParams(params) {
    if (params == {}) return '';

    return '';
  }
}
