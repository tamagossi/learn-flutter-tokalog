import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokalog/providers/orders.dart';
import 'package:tokalog/widgets/organism/order_item.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: SafeArea(
        child: ListView.builder(
          itemCount: orderProvider.orders.length,
          itemBuilder: (ctx, index) => OrganismOrderItem(
            order: orderProvider.orders[index],
          ),
        ),
      ),
    );
  }
}
