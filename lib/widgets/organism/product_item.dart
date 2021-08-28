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

class OrganismProductItem extends StatefulWidget {
  final Product product;
  OrganismProductItem({this.product});

  @override
  _OrganismProductItemState createState() => _OrganismProductItemState();
}

class _OrganismProductItemState extends State<OrganismProductItem> {
  bool loading = false;

  void addToCart(BuildContext context) {
    BuildContext dialogContext;
    final content = Text('Sucessfully add item to the cart');

    Provider.of<CartProvider>(context, listen: false).addToCart(widget.product);
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

  void setFavoriteProduct(BuildContext context) {
    try {
      setState(() {
        loading = true;
      });

      Provider.of<ProductProvider>(context, listen: false)
          .setProductFavoriteStatus(widget.product.id);
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailScreen(
                  id: widget.product.id,
                ),
              ),
            );
          },
          child: GridTile(
            child: CachedNetworkImage(
              imageUrl: widget.product.image,
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
                    widget.product.title,
                    style: GoogleFonts.lato(
                        color: Colors.black87,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 7),
                  Text(
                    '\$ ${widget.product.price}',
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
                        onPressed: () => addToCart(context),
                      ),
                      SizedBox(width: 10),
                      PlatformIconButton(
                        onPressed: () {
                          setFavoriteProduct(context);
                        },
                        icon: buildIcon(
                          context,
                          loading
                              ? Icons.change_circle_outlined
                              : widget.product.isFavorite
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
