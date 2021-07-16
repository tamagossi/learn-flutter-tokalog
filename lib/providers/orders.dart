import 'package:flutter/material.dart';
import 'package:tokalog/models/cart.dart';
import 'package:tokalog/models/order.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  bool get isHasIncompleteOrder {
    return _orders.isNotEmpty;
  }

  void addOrder(List<Cart> products, double total) {
    _orders.insert(
      0,
      Order(
        amount: total,
        id: DateTime.now().toString(),
        products: products,
        dateTime: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
