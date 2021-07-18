import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tokalog/models/order.dart';

class OrganismOrderItem extends StatelessWidget {
  final Order order;

  OrganismOrderItem({this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              subtitle: Text(DateFormat('dd MM yyyy').format(order.dateTime)),
              title: Text('\$${order.amount}'),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.expand_more),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
