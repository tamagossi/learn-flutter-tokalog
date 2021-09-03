import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:tokalog/models/product.dart';
import 'package:tokalog/providers/cart.dart';
import 'package:tokalog/providers/product.dart';
import 'package:tokalog/screens/products/detail.dart';
import 'package:tokalog/widgets/platform/platform_icon_button.dart';
import 'package:tokalog/widgets/platform/platform_progress_indicator.dart';

class OrganismProductItem extends StatelessWidget {
  final Product product;
  OrganismProductItem({this.product});

  void addToCart(BuildContext context, CartProvider cartProvider) {
    BuildContext dialogContext;
    final content = Text('Sucessfully add item to the cart');

    cartProvider.addToCart(product);
    Platform.isIOS
        ? showCupertinoDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext ctx) {
              dialogContext = ctx;

              return CupertinoAlertDialog(
                content: content,
                actions: [
                  CupertinoDialogAction(
                    child: Text('Oke'),
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                  ),
                ],
              );
            },
          )
        : showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext ctx) {
              dialogContext = ctx;

              return AlertDialog(
                content: content,
                actions: [
                  TextButton(
                    child: Text('Oke'),
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                  ),
                ],
              );
            },
          );
  }

  Icon buildIcon(BuildContext context, IconData icon) {
    return Icon(
      icon,
      color: Theme.of(context).accentColor,
      size: 18,
    );
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    var productProvider = Provider.of<ProductProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailScreen(
                  id: product.id,
                ),
              ),
            );
          },
          child: GridTile(
            child: CachedNetworkImage(
              imageUrl: product.image,
              errorWidget: (_, __, error) => Icon(Icons.error),
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) =>
                  PlatformProgressIndicator(progress: progress.progress),
            ),
            footer: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: GoogleFonts.lato(
                        color: Colors.black87,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 7),
                  Text(
                    '\$ ${product.price}',
                    style: GoogleFonts.lato(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PlatformIconButton(
                        icon: buildIcon(context, Icons.shopping_cart),
                        onPressed: () => addToCart(context, cartProvider),
                      ),
                      SizedBox(width: 10),
                      PlatformIconButton(
                        onPressed: () {
                          productProvider.setProductFavoriteStatus(product.id);
                        },
                        icon: buildIcon(
                          context,
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
