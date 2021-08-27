import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tokalog/models/product.dart';
import 'package:tokalog/services/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  String _errorMessage = 'product providers error';
  var _productService = new ProductService();

  Future<void> addProduct(Product value) async {
    try {
      await _productService
          .addProduct(convertProductInstanceToProductJSON(value));

      notifyListeners();
    } catch (error) {
      throw ('$_errorMessage - adding product: \n$error');
    }
  }

  Future<void> editProduct(String id, Product value) async {
    try {
      await _productService.editProduct(
          id, convertProductInstanceToProductJSON(value));
      notifyListeners();
    } catch (error) {
      throw ('$_errorMessage - edit product: \n$error');
    }
  }

  Map<String, dynamic> convertProductInstanceToProductJSON(Product value) {
    return {
      'description': value.description,
      'id': value.id,
      'image': value.image,
      'isFavorite': value.isFavorite ?? false,
      'price': value.price,
      'title': value.title,
    };
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _productService.deleteProduct(id);
      notifyListeners();
    } catch (error) {
      throw ('$_errorMessage - delete product: \n$error');
    }
  }

  Product getById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }

  Future<void> getProducts() async {
    try {
      var response = await _productService.getProducts();
      List<Product> products = [];

      response.forEach((key, value) {
        products.add(Product(
          price: value['price'],
          description: value['description'],
          id: key,
          isFavorite: value['isFavorite'],
          image: value['image'],
          title: value['title'],
        ));
      });

      _products = products;
      notifyListeners();
    } catch (error) {
      throw ('$_errorMessage - getting product: \n$error');
    }
  }

  void setProductFavoriteStatus(String id) {
    List<Product> products = [..._products];

    int selectedProductIndex = products.indexWhere((prod) => prod.id == id);
    products[selectedProductIndex].isFavorite =
        !products[selectedProductIndex].isFavorite;
    _products = products;
    notifyListeners();
  }

  List<Product> get favoriteProduct {
    return _products.where((prod) => prod.isFavorite).toList();
  }

  List<Product> get products {
    return [..._products];
  }
}
