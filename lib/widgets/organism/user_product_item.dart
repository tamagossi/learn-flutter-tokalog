import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokalog/models/product.dart';
import 'package:tokalog/providers/product.dart';
import 'package:tokalog/screens/user/product/edit.dart';

class OrganismUserProductItem extends StatefulWidget {
  final Product product;

  OrganismUserProductItem({@required this.product});

  @override
  _OrganismUserProductItemState createState() =>
      _OrganismUserProductItemState();
}

class _OrganismUserProductItemState extends State<OrganismUserProductItem> {
  bool _isLoading = false;

  void deleteProduct(String id) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);

      await productProvider.deleteProduct(widget.product.id);
      await productProvider.getProducts();
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
                width: width * 0.5,
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundImage: NetworkImage(widget.product.image)),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        widget.product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
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
                                product: widget.product,
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
                          deleteProduct(widget.product.id);
                        },
                        child: Icon(
                          _isLoading ? Icons.schedule : Icons.delete,
                          color: Theme.of(context).accentColor,
                          size: 17,
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
