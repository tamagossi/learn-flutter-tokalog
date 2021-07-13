import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tokalog/models/product.dart';
import 'package:tokalog/providers/product.dart';
import 'package:tokalog/widgets/organism/product_item.dart';

class ProductsScreen extends StatefulWidget {
  static const route = '/';

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String selectedFilter = 'All';

  Widget buildFilterSliderText(BuildContext context, String text) {
    return GestureDetector(
      onTap: () => setSelectedFilter(text),
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              color: text == selectedFilter
                  ? Colors.white
                  : Theme.of(context).accentColor),
        )),
        decoration: BoxDecoration(
          color: text == selectedFilter
              ? Theme.of(context).accentColor
              : Colors.white70,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Theme.of(context).accentColor,
            width: 0.8,
          ),
        ),
      ),
    );
  }

  List<Widget> buildSliderItem(BuildContext context) {
    const sliderItems = ['All', 'Favorite'];
    List<Widget> items = [];

    sliderItems.forEach((item) {
      items.add(buildFilterSliderText(context, item));
      items.add(SizedBox(width: 10));
    });

    return items;
  }

  void setSelectedFilter(text) {
    setState(() {
      selectedFilter = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final List<Product> products = selectedFilter == 'All'
        ? Provider.of<ProductProvider>(context).products
        : Provider.of<ProductProvider>(context).favoriteProduct;

    return Scaffold(
      appBar: AppBar(
        title: Text('Takalog'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Platform.isIOS ? CupertinoIcons.cart : Icons.shopping_cart,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 6 / 100 * deviceHeight,
              padding: const EdgeInsets.all(10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: buildSliderItem(context),
              ),
            ),
            Container(
              height: 77 / 100 * deviceHeight,
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
          ],
        ),
      ),
    );
  }
}
