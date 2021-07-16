import 'package:flutter/material.dart';
import 'package:tokalog/models/cart.dart';
import 'package:tokalog/models/product.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _carts = {};

  Map<String, Cart> get carts {
    return {..._carts};
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

  void addToCart(Product product) {
    if (_carts.containsKey(product.id)) {
      _carts.update(
        product.id,
        (item) => Cart(
          id: item.id,
          productId: product.id,
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
          productId: product.id,
          price: product.price,
          quantity: 1,
          title: product.title,
        ),
      );
    }

    notifyListeners();
  }

  void flushCart() {
    _carts = {};
    notifyListeners();
  }

  void removeFromCart(cartId) {
    _carts.remove(cartId);
    notifyListeners();
  }
}
