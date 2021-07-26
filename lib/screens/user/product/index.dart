import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokalog/providers/product.dart';
import 'package:tokalog/screens/user/product/add.dart';
import 'package:tokalog/widgets/organism/user_product_item.dart';

class UserProductScreen extends StatefulWidget {
  @override
  _UserProductScreenState createState() => _UserProductScreenState();
}

class _UserProductScreenState extends State<UserProductScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => UserProductAddScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (_, index) {
              return OrganismUserProductItem(
                product: productProvider.products[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
