import 'dart:developer';

import 'package:tokalog/services/request_adapter.dart';

class ProductService extends RequestAdapter {
  Future<dynamic> addNewProduct(Map<String, dynamic> payload) async {
    try {
      var response = await this.sendPostRequest(
        this.baseURL + 'products.json',
        payload,
      );

      return response;
    } catch (e) {
      print(e);
    }
  }
}
