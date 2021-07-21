import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoleculeTextInput extends StatelessWidget {
  final String label;
  final String placeholder;
  final String inputHelp;
  final TextInputAction textInputAction;

  MoleculeTextInput({
    @required this.label,
    this.inputHelp,
    this.placeholder,
    this.textInputAction = TextInputAction.next,
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
          keyboardType: TextInputType.text,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 10, top: 8),
            enabledBorder: underlineInputBorder,
            focusedBorder: underlineInputBorder,
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
            hintText: placeholder ?? label,
            isDense: true,
          ),
          style: TextStyle(height: 1, fontSize: 15),
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
