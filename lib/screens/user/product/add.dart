import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tokalog/models/product.dart';
import 'package:tokalog/providers/product.dart';
import 'package:tokalog/screens/user/product/index.dart';
import 'package:tokalog/widgets/organism/user_product_form.dart';

class UserProductAddScreen extends StatefulWidget {
  @override
  _UserProductAddScreenState createState() => _UserProductAddScreenState();
}

class _UserProductAddScreenState extends State<UserProductAddScreen> {
  bool _isLoading = false;
  final GlobalKey<OrganismUserProductFormState> _userProductFormKey =
      new GlobalKey<OrganismUserProductFormState>();

  void addProduct() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final Product product = _userProductFormKey.currentState.getFormValues();
      var productProvider =
          Provider.of<ProductProvider>(context, listen: false);

      await productProvider.addProduct(product);
      await productProvider.getProducts();

      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => UserProductScreen()),
      );
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OrganismUserProductForm(
                    key: _userProductFormKey,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: addProduct,
                      child: Text(
                        'Add Product',
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
      ),
    );
  }
}
