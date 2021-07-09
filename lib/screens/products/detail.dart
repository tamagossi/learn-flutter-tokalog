import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokalog/models/product.dart';
import 'package:tokalog/providers/product.dart';
import 'package:tokalog/widgets/platform/platform_scaffold.dart';

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

    return PlatformScaffold(
      appBarText: Text(product.title),
      content: Center(
        child: Text('Hallo from product detail page'),
      ),
    );
  }
}
