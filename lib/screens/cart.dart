import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokalog/providers/cart.dart';
import 'package:tokalog/providers/orders.dart';
import 'package:tokalog/screens/order.dart';
import 'package:tokalog/widgets/organism/cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    void order() {
      orderProvider.addOrder(
        cartProvider.carts.values.toList(),
        cartProvider.totalAmount,
      );
      cartProvider.flushCart();

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => OrderScreen()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: [
                      Text('Total', style: TextStyle(fontSize: 20)),
                      SizedBox(width: 15),
                      Chip(label: Text('\$${cartProvider.totalAmount}')),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: order,
                  child: Text(
                    'Order Now',
                    style: TextStyle(color: Colors.black87),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.carts.length,
              itemBuilder: (_, index) => OrganismCartItem(
                cart: cartProvider.carts.values.toList()[index],
              ),
            ),
          )
        ],
      ),
    );
  }
}
