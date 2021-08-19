import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoleculeTextInput extends StatelessWidget {
  final FocusNode focusNode;
  final Function onChange;
  final Function onSaved;
  final Function validator;
  final int maxLines;
  final String initialValue;
  final String inputHelp;
  final String label;
  final String name;
  final String placeholder;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  MoleculeTextInput({
    @required this.label,
    @required this.name,
    this.controller,
    this.focusNode,
    this.initialValue,
    this.inputHelp,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.onChange,
    this.onSaved,
    this.placeholder,
    this.textInputAction = TextInputAction.next,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    var underlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).accentColor,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          initialValue: initialValue,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChange,
          onSaved: onSaved,
          style: TextStyle(height: 1, fontSize: 15),
          textInputAction: textInputAction,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 10, top: 8),
            enabledBorder: underlineInputBorder,
            focusedBorder: underlineInputBorder,
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
            hintText: placeholder ?? label,
            isDense: true,
          ),
        ),
        if (inputHelp != null)
          Column(children: [
            SizedBox(height: 4),
            Text(inputHelp, style: TextStyle(color: Colors.grey, fontSize: 12)),
          ])
      ],
    );
  }
}
