import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tokalog/models/product.dart';
import 'package:tokalog/widgets/platform/platform_icon_button.dart';
import 'package:tokalog/widgets/platform/platform_progress_indicator.dart';

class OrganismProductItem extends StatelessWidget {
  final Product product;

  OrganismProductItem({this.product});

  Icon buildIcon(BuildContext context, IconData icon) {
    return Icon(
      icon,
      color: Theme.of(context).accentColor,
      size: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
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
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PlatformIconButton(
                      onPressed: () {},
                      icon: buildIcon(context, Icons.shopping_cart),
                    ),
                    SizedBox(width: 5),
                    PlatformIconButton(
                      onPressed: () {},
                      icon: buildIcon(context, Icons.favorite),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
