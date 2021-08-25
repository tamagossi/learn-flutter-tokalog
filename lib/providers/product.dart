import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tokalog/models/product.dart';
import 'package:tokalog/services/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  var productService = new ProductService();

  Future<void> addProduct(Product value) async {
    try {
      var response = await productService.addNewProduct({
        'description': value.description,
        'id': value.id,
        'image': value.image,
        'isFavorite': false,
        'price': value.price,
        'title': value.title,
      });

      var newProduct = new Product(
        description: value.description,
        id: response.name,
        image: value.image,
        price: value.price,
        title: value.title,
      );
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void editProduct(String id, Product value) {
    List<Product> products = [..._products];

    int selectedProductIndex = products.indexWhere((prod) => prod.id == id);
    products[selectedProductIndex] = value;
    _products = products;

    notifyListeners();
  }

  void deleteProduct(String id) {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  Product getById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }

  Future<void> getProducts() async {
    var response = await productService.getProducts();
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
