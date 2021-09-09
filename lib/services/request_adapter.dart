import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:tokalog/services/local_storage.dart';

class RequestAdapter {
  final String baseURL = dotenv.env['FIREBASE_URL'];

  Future<dynamic> sendDeleteRequest(url) async {
    final String endpoint = await concateAuthToken(baseURL + url);

    final response = await http.delete(
      Uri.parse(endpoint),
    );

    return json.decode(response.body);
  }

  Future<dynamic> sendGetRequest(
    String url, {
    Map<String, dynamic> params = const {},
  }) async {
    final String endpoint =
        await concateAuthToken(baseURL + url + parseParams(params));

    final response = await http.get(
      Uri.parse(endpoint),
    );

    return json.decode(response.body);
  }

  Future<dynamic> sendPatchRequest(
    String url,
    Map<String, dynamic> payload,
  ) async {
    final String endpoint = await concateAuthToken(baseURL + url);

    final response = await http.patch(
      Uri.parse(endpoint),
      body: json.encode(payload ??= {}),
    );

    return json.decode(response.body);
  }

  Future<dynamic> sendCustomPostUrlRequest(
    String url,
    Map<String, dynamic> payload,
  ) async {
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(payload),
    );

    return json.decode(response.body);
  }

  Future<dynamic> sendPostRequest(
    String url,
    Map<String, dynamic> payload, {
    auth = false,
  }) async {
    final String endpoint = await concateAuthToken(baseURL + url);

    final response = await http.post(
      Uri.parse(endpoint),
      body: json.encode(payload ??= {}),
    );

    return json.decode(response.body);
  }

  Future<String> concateAuthToken(String url) async {
    final tokenLocalStorage = new LocalStorage(fileName: 'tokalog_token');

    final token = await tokenLocalStorage.readContent();
    return '$url?auth=$token';
  }

  String parseParams(params) {
    if (params == {}) return '';

    return '';
  }
}
