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
  bool isLoading = false;
  final GlobalKey<OrganismUserProductFormState> _userProductFormKey =
      new GlobalKey<OrganismUserProductFormState>();

  void addNewProduct() async {
    try {
      setState(() {
        isLoading = true;
      });

      final Product product = _userProductFormKey.currentState.getFormValues();
      await Provider.of<ProductProvider>(context, listen: false)
          .addProduct(product);

      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => UserProductScreen()),
      );
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: LoadingOverlay(
        isLoading: isLoading,
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
                      onPressed: addNewProduct,
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
