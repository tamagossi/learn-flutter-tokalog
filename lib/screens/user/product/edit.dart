import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokalog/models/product.dart';
import 'package:tokalog/providers/product.dart';
import 'package:tokalog/screens/user/product/index.dart';
import 'package:tokalog/widgets/organism/user_product_form.dart';

class UserProductEditScreen extends StatefulWidget {
  final Product product;

  UserProductEditScreen({this.product});

  @override
  _UserProductEditScreenState createState() => _UserProductEditScreenState();
}

class _UserProductEditScreenState extends State<UserProductEditScreen> {
  final GlobalKey<OrganismUserProductFormState> _userProductFormKey =
      new GlobalKey<OrganismUserProductFormState>();

  void editProduct() {
    final Product value = _userProductFormKey.currentState.getFormValues();
    Provider.of<ProductProvider>(context, listen: false)
        .editProduct(widget.product.id, value);

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => UserProductScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit ${widget.product.title}')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          child: Column(
            children: [
              OrganismUserProductForm(initialValues: widget.product),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: editProduct,
                  child: Text(
                    'Edit Product',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
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
