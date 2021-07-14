import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokalog/providers/cart.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(22),
            child: Row(children: <Widget>[
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 15),
              Chip(
                label: Text('\$${cartProvider.totalAmount}'),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
