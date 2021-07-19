import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tokalog/models/product.dart';

class OrganismUserProductItem extends StatelessWidget {
  final Product product;

  OrganismUserProductItem({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(product.image)),
                  SizedBox(width: 15),
                  Text(
                    product.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  ElevatedButton(
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                    ),
                  ),
                  SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.delete,
                      color: Theme.of(context).accentColor,
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Theme.of(context).accentColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
