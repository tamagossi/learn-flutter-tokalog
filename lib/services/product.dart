
import 'package:tokalog/services/request_adapter.dart';

class ProductService extends RequestAdapter {
  String url;

  ProductService() {
    this.url = "products.json";
  }

  Future<dynamic> addNewProduct(Map<String, dynamic> payload) async {
    try {
      var response = await this.sendPostRequest(url, payload);
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getProducts() async {
    try {
      var response = await this.sendGetRequest(url);
      return response as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
  }
}
