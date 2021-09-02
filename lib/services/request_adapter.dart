import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class RequestAdapter {
  final String baseURL = dotenv.env['FIREBASE_URL'];

  Future<dynamic> sendDeleteRequest(url) async {
    final response = await http.delete(
      Uri.parse(baseURL + url),
    );

    return json.decode(response.body);
  }

  Future<dynamic> sendGetRequest(
    String url, {
    Map<String, dynamic> params = const {},
  }) async {
    final response = await http.get(
      Uri.parse(baseURL + url + parseParams(params)),
    );

    return json.decode(response.body);
  }

  Future<dynamic> sendPatchRequest(url, payload) async {
    final response = await http.patch(
      Uri.parse(baseURL + url),
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
