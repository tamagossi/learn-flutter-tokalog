import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tokalog/models/product.dart';
import 'package:tokalog/widgets/molecules/input_group/number_input.dart';
import 'package:tokalog/widgets/molecules/input_group/text_input.dart';

class OrganismUserProductForm extends StatefulWidget {
  final Product initialValues;

  OrganismUserProductForm({
    Key key,
    this.initialValues,
  }) : super(key: key);

  @override
  OrganismUserProductFormState createState() => OrganismUserProductFormState();
}

class OrganismUserProductFormState extends State<OrganismUserProductForm> {
  final _imageFocus = FocusNode();
  final _imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _product = Product(
    id: null,
    description: '',
    image: '',
    price: 0,
    title: '',
  );

  @override
  void initState() {
    super.initState();
    _imageFocus.addListener(_setImageUrlOnInputBlur);
  }

  @override
  void dispose() {
    super.dispose();

    _imageController.dispose();
    _imageFocus.removeListener(_setImageUrlOnInputBlur);
  }

  Product getFormValues() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) return null;

    _formKey.currentState.save();
    return _product;
  }

  void _setImageUrlOnInputBlur() {
    if (!_imageFocus.hasFocus) {
      this.setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          MoleculeTextInput(
            initialValue: widget.initialValues?.title,
            label: 'Name',
            name: 'name',
            placeholder: 'Product Name',
            validator: (value) =>
                value.isEmpty ? 'Please provide a value' : null,
            onSaved: (value) {
              _product = Product(
                id: null,
                description: _product.description,
                image: _product.image,
                price: _product.price,
                title: value,
              );
            },
          ),
          SizedBox(height: 20),
          MoleculeNumberInput(
            initialValue: widget.initialValues?.price.toString(),
            label: 'Price',
            name: 'price',
            placeholder: 'Product Price',
            prefix: '\$',
            validator: (value) {
              if (value.isEmpty) return 'Please enter a price';
              if (double.tryParse(value) == null)
                return 'Please enter a valid number';
              if (double.parse(value) <= 0) return 'Please enter a number > 0';

              return null;
            },
            onSaved: (value) {
              _product = Product(
                id: null,
                description: _product.description,
                image: _product.image,
                price: double.parse(value),
                title: _product.title,
              );
            },
          ),
          SizedBox(height: 20),
          MoleculeTextInput(
            initialValue: widget.initialValues?.description,
            keyboardType: TextInputType.multiline,
            label: 'Description',
            maxLines: 3,
            name: 'description',
            placeholder: 'Product Description',
            textInputAction: TextInputAction.newline,
            validator: (value) {
              if (value.isEmpty) return 'Please enter a description.';
              if (value.length < 10)
                return 'Should be at least 10 characters long.';

              return null;
            },
            onSaved: (value) {
              _product = Product(
                id: null,
                description: value,
                image: _product.image,
                price: _product.price,
                title: _product.title,
              );
            },
          ),
          SizedBox(height: 20),
          MoleculeTextInput(
            initialValue: widget.initialValues?.image,
            controller: _imageController == null ? _imageController : null,
            focusNode: _imageFocus,
            keyboardType: TextInputType.url,
            label: 'Image',
            name: 'image',
            placeholder: 'Product Image',
            textInputAction: TextInputAction.send,
            validator: (value) {
              if (value.isEmpty) return 'Please enter an image URL.';
              if (!value.startsWith('http') && !value.startsWith('https')) {
                return 'Please enter a valid URL.';
              }
              if (!value.endsWith('.png') &&
                  !value.endsWith('.jpg') &&
                  !value.endsWith('.jpeg')) {
                return 'Please enter a valid image URL.';
              }

              return null;
            },
            onSaved: (value) {
              _product = Product(
                id: null,
                description: _product.description,
                image: value,
                price: _product.price,
                title: _product.title,
              );
            },
          ),
          SizedBox(height: 10),
          _imageController.text.isNotEmpty
              ? Container(
                  height: 300,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: _imageController.text,
                    errorWidget: (_, __, error) => Container(),
                    fit: BoxFit.cover,
                  ))
              : Container(),
        ],
      ),
    );
  }
}
