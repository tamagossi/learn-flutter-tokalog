import 'package:flutter/material.dart';
import 'package:tokalog/models/cart.dart';
import 'package:tokalog/models/product.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _carts = {};

  Map<String, Cart> get carts {
    return {..._carts};
  }

  void addToCart(Product product) {
    if (_carts.containsKey(product.id)) {
      _carts.update(
        product.id,
        (item) => Cart(
          id: item.id,
          price: item.price,
          quantity: item.quantity + 1,
          title: item.title,
        ),
      );
    } else {
      _carts.putIfAbsent(
        product.id,
        () => Cart(
          id: DateTime.now().toString(),
          price: product.price,
          quantity: 1,
          title: product.title,
        ),
      );
    }

    notifyListeners();
  }

  int get cartCount {
    var count = 0;
    if (_carts.isNotEmpty) {
      _carts.forEach((key, value) {
        count += value.quantity;
      });
    }

    return count;
  }

  double get totalAmount {
    var total = 0.0;

    if (_carts.isNotEmpty) {
      _carts.forEach((key, value) {
        total += value.price;
      });
    }
    return total;
  }
}
