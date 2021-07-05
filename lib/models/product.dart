import 'package:flutter/material.dart';

class Product {
  bool isFavorite;
  final double price;
  final String description;
  final String id;
  final String image;
  final String title;

  Product({
    @required this.price,
    @required this.description,
    @required this.id,
    @required this.image,
    @required this.title,
    this.isFavorite = false,
  });
}
