import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokalog/models/product.dart';
import 'package:tokalog/widgets/platform/platform_progress_indicator.dart';

class OrganismProductItem extends StatelessWidget {
  final Product product;

  OrganismProductItem({this.product});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: CachedNetworkImage(
        imageUrl: product.image,
        errorWidget: (_, __, error) => Icon(Icons.error),
        progressIndicatorBuilder: (context, url, progress) =>
            PlatformProgressIndicator(progress: progress.progress),
      ),
    );
  }
}
