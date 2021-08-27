import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tokalog/models/product.dart';
import 'package:tokalog/providers/cart.dart';
import 'package:tokalog/providers/product.dart';
import 'package:tokalog/screens/cart.dart';
import 'package:tokalog/screens/menu.dart';
import 'package:tokalog/widgets/molecules/badge.dart';
import 'package:tokalog/widgets/organism/product_item.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String selectedFilter = 'All';
  bool _loading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) => _getProducts());
    super.initState();
  }

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

  Future<void> _getProducts() async {
    try {
      setState(() {
        _loading = true;
      });

      await Provider.of<ProductProvider>(context, listen: false).getProducts();
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        _loading = false;
      });
    }
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
          Row(
            children: [
              Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => CartScreen()),
                    );
                  },
                  child: Consumer<CartProvider>(
                    builder: (_, cartProvider, __) => MoleculeBadge(
                      value: cartProvider.cartCount.toString(),
                      child: Icon(
                        Platform.isIOS
                            ? CupertinoIcons.cart
                            : Icons.shopping_cart,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: GestureDetector(
                  child: Icon(Icons.menu_outlined),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => MenuScreen()),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
              _loading
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: _getProducts,
                      child: Container(
                        height: 80 / 100 * deviceHeight,
                        child: GridView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: products.length,
                          itemBuilder: (ctx, index) => OrganismProductItem(
                            product: products[index],
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
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
