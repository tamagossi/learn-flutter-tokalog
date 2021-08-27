import 'package:tokalog/services/request_adapter.dart';

class ProductService extends RequestAdapter {
  String _url = 'products.json';
  String _errorMessage = "product http request error";

  Future<dynamic> addProduct(Map<String, dynamic> payload) async {
    try {
      var response = await this.sendPostRequest(_url, payload);
      return response;
    } catch (error) {
      throw ('$_errorMessage - adding product: \n$error');
    }
  }

  Future<dynamic> deleteProduct(String id) async {
    try {
      var response = await this.sendDeleteRequest('products/$id.json');
      return response;
    } catch (error) {
      throw ('$_errorMessage - delete product: \n$error');
    }
  }

  Future<dynamic> editProduct(String id, Map<String, dynamic> payload) async {
    try {
      var response = await this.sendPatchRequest('products/$id.json', payload);
      return response;
    } catch (error) {
      throw ('$_errorMessage - edit product: \n$error');
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
