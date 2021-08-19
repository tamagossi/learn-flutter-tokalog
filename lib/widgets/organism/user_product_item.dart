import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokalog/models/product.dart';
import 'package:tokalog/providers/product.dart';
import 'package:tokalog/screens/user/product/edit.dart';

class OrganismUserProductItem extends StatelessWidget {
  final Product product;

  OrganismUserProductItem({@required this.product});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(product.image)),
                    SizedBox(width: 15),
                    Text(
                      product.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      height: 25,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => UserProductEditScreen(
                                product: product,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Edit Product',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 60,
                      height: 25,
                      child: OutlinedButton(
                        onPressed: () {
                          productProvider.deleteProduct(product.id);
                        },
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).accentColor,
                          size: 17,
                        ),
                        style: OutlinedButton.styleFrom(
                          side:
                              BorderSide(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
