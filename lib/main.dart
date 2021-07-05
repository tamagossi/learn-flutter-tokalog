import 'package:flutter/material.dart';
import 'package:tokalog/screens/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tokalog',
      home: ProductsScreen(),
      routes: {},
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
