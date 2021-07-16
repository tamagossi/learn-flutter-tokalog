import 'package:flutter/material.dart';

class Cart {
  final double price;
  final int quantity;
  final String id;
  final String productId;
  final String title;

  Cart({
    @required this.price,
    @required this.quantity,
    @required this.id,
    @required this.productId,
    @required this.title,
  });
}
