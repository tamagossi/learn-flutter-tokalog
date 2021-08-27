import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
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
  bool _isLoading = false;
  final GlobalKey<OrganismUserProductFormState> _userProductFormKey =
      new GlobalKey<OrganismUserProductFormState>();

  void editProduct() async {
    try {
      final Product value = _userProductFormKey.currentState.getFormValues();
      var productProvider =
          Provider.of<ProductProvider>(context, listen: false);

      await productProvider.editProduct(widget.product.id, value);
      await productProvider.getProducts();

      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => UserProductScreen()),
      );
    } catch (error) {
      print(error);
    } finally {
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit ${widget.product.title}')),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
            child: Column(
              children: [
                OrganismUserProductForm(
                  key: _userProductFormKey,
                  initialValues: widget.product,
                ),
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
      ),
    );
  }
}
