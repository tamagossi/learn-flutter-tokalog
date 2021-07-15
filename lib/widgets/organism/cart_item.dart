import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tokalog/models/cart.dart';
import 'package:tokalog/widgets/platform/platform_progress_indicator.dart';

class OrganismCartItem extends StatelessWidget {
  final Cart cart;

  OrganismCartItem({@required this.cart});

  @override
  Widget build(BuildContext context) {
    print(cart);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          subtitle: Text('Total: \$${cart.price * cart.quantity}'),
          trailing: Text('${cart.quantity} x'),
          title: Text(cart.title),
          leading: CircleAvatar(
            child: Text(
              '\$${cart.price}',
              style: TextStyle(fontSize: 12),
            ),
            backgroundColor: Theme.of(context).accentColor,
            radius: 30,
          ),
        ),
      ),
    );
  }
}
