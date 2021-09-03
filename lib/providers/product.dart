import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tokalog/models/product.dart';
import 'package:tokalog/services/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      image:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      image: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  var productService = new ProductService();

  List<Product> get favoriteProduct {
    return _products.where((prod) => prod.isFavorite).toList();
  }

  List<Product> get products {
    return [..._products];
  }

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

  void setProductFavoriteStatus(String id) {
    List<Product> products = [..._products];

    int selectedProductIndex = products.indexWhere((prod) => prod.id == id);
    products[selectedProductIndex].isFavorite =
        !products[selectedProductIndex].isFavorite;
    _products = products;
    notifyListeners();
  }
}
