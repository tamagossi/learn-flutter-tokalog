import 'package:cached_network_image/cached_network_image.dart';
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
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit ${widget.product.title}')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          child: Form(
            onChanged: () {},
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  MoleculeTextInput(
                    label: 'Name',
                    name: 'name',
                    placeholder: 'Product Name',
                  ),
                  SizedBox(height: 20),
                  MoleculeNumberInput(
                    label: 'Price',
                    name: 'price',
                    placeholder: 'Product Price',
                    prefix: '\$',
                  ),
                  SizedBox(height: 20),
                  MoleculeTextInput(
                    keyboardType: TextInputType.multiline,
                    label: 'Description',
                    maxLines: 3,
                    name: 'description',
                    placeholder: 'Product Description',
                    textInputAction: TextInputAction.newline,
                  ),
                  SizedBox(height: 20),
                  MoleculeTextInput(
                    keyboardType: TextInputType.url,
                    label: 'Image',
                    name: 'image',
                    placeholder: 'Product Image',
                    onChange: (value) {
                      setState(() {
                        imageUrl = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 300,
                    child:
                        imageUrl.contains('.jpg') || imageUrl.contains('.png')
                            ? CachedNetworkImage(
                                imageUrl: imageUrl,
                                errorWidget: (_, __, error) => Container(),
                                fit: BoxFit.cover,
                              )
                            : Container(),
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
