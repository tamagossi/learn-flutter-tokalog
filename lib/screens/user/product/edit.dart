import 'package:flutter/material.dart';
import 'package:tokalog/models/product.dart';
import 'package:tokalog/widgets/molecules/input_group/number_input.dart';
import 'package:tokalog/widgets/molecules/input_group/text_input.dart';

class UserProductEditScreen extends StatefulWidget {
  final Product product;

  UserProductEditScreen({this.product});

  @override
  _UserProductEditScreenState createState() => _UserProductEditScreenState();
}

class _UserProductEditScreenState extends State<UserProductEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit ${widget.product.title}')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  MoleculeTextInput(
                    label: 'Name',
                    placeholder: 'Product Name',
                  ),
                  SizedBox(height: 20),
                  MoleculeNumberInput(
                    label: 'Price',
                    placeholder: 'Product Price',
                    prefix: '\$',
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
