import 'package:flutter/material.dart';
import 'package:tokalog/models/product.dart';
import 'package:tokalog/widgets/platform/platform_scaffold.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = 'product-detail';
  final Product product;

  ProductDetailScreen({
    @required this.product,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBarText: Text(widget.product.title),
      content: Center(
        child: Text('Hallo from product detail page'),
      ),
    );
  }
}
