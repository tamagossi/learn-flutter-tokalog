import 'package:flutter/material.dart';
import 'package:tokalog/mock/product.dart';
import 'package:tokalog/widgets/organism/product_item.dart';
import 'package:tokalog/widgets/platform/platform_scaffold.dart';

class ProductsScreen extends StatelessWidget {
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBarText: Text('Takalog'),
      content: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: products.length,
          itemBuilder: (ctx, index) => OrganismProductItem(
            product: products[index],
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}