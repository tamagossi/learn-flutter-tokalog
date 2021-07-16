import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tokalog/models/product.dart';
import 'package:tokalog/providers/cart.dart';
import 'package:tokalog/providers/orders.dart';
import 'package:tokalog/providers/product.dart';
import 'package:tokalog/screens/cart.dart';
import 'package:tokalog/screens/order.dart';
import 'package:tokalog/widgets/molecules/badge.dart';
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
    final bool hasIncompleteOrder =
        Provider.of<OrderProvider>(context).isHasIncompleteOrder;
    final List<Product> products = selectedFilter == 'All'
        ? Provider.of<ProductProvider>(context).products
        : Provider.of<ProductProvider>(context).favoriteProduct;

    return Scaffold(
      appBar: AppBar(
        title: Text('Takalog'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => CartScreen(),
                  ),
                );
              },
              child: Consumer<CartProvider>(
                builder: (_, cartProvider, __) => MoleculeBadge(
                  value: cartProvider.cartCount.toString(),
                  child: Icon(
                    Platform.isIOS ? CupertinoIcons.cart : Icons.shopping_cart,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              hasIncompleteOrder
                  ? Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('You have some incomplete order'),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => OrderScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Order!',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                    )
                  : null,
              Container(
                height: 6 / 100 * deviceHeight,
                padding: const EdgeInsets.all(10),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: buildSliderItem(context),
                ),
              ),
              Container(
                height: 60 / 100 * deviceHeight,
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
      ),
    );
  }
}
