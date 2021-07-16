import 'package:flutter/material.dart';
import 'package:tokalog/models/cart.dart';

class Order {
  final double amount;
  final String id;
  final List<Cart> products;
  final DateTime dateTime;

  Order({
    @required this.amount,
    @required this.id,
    @required this.products,
    @required this.dateTime,
  });
}
