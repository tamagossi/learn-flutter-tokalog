import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokalog/providers/product.dart';
import 'package:tokalog/widgets/platform/platform_progress_indicator.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = 'product-detail';
  final String id;

  ProductDetailScreen({
    @required this.id,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final product =
        Provider.of<ProductProvider>(context, listen: false).getById(widget.id);

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  errorWidget: (_, __, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, progress) =>
                      PlatformProgressIndicator(progress: progress.progress),
                ),
              ),
              SizedBox(height: 10),
              Text(
                '\$${product.price}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
