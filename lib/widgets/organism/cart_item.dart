import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokalog/models/cart.dart';
import 'package:tokalog/providers/cart.dart';

class OrganismCartItem extends StatelessWidget {
  final Cart cart;

  OrganismCartItem({@required this.cart});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(cart.id),
      onDismissed: (direction) {
        Provider.of<CartProvider>(
          context,
          listen: false,
        ).removeFromCart(cart.productId);
      },
      background: Container(
        alignment: Alignment.centerRight,
        color: Theme.of(context).errorColor,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
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
      ),
    );
  }
}
