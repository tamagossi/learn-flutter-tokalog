import 'package:tokalog/services/request_adapter.dart';

class ProductService extends RequestAdapter {
  String _url = 'products.json';
  String _errorMessage = "product http request error";

  Future<dynamic> addNewProduct(Map<String, dynamic> payload) async {
    try {
      var response = await this.sendPostRequest(_url, payload);
      return response;
    } catch (error) {
      throw ('$_errorMessage - adding product: \n$error');
    }
  }

  Future<dynamic> getProducts() async {
    try {
      var response = await this.sendGetRequest(_url);
      return response as Map<String, dynamic>;
    } catch (error) {
      throw ('$_errorMessage - getting product: \n$error');
    }
  }
}
