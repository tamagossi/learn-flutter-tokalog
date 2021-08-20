import 'package:tokalog/services/request_adapter.dart';

class ProductService extends RequestAdapter {
  dynamic addNewProduct(Map<String, dynamic> payload) async {
    var response = await this.sendPostRequest(
      this.baseURL + 'products.json',
      payload,
    );

    return response;
  }
}
