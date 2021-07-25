import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoleculeNumberInput extends StatelessWidget {
  final dynamic prefix;
  final Function onSaved;
  final Function validator;
  final String inputHelp;
  final String label;
  final String name;
  final String placeholder;
  final TextInputAction textInputAction;

  MoleculeNumberInput(
      {@required this.label,
      @required this.name,
      this.inputHelp,
      this.onSaved,
      this.placeholder,
      this.prefix,
      this.textInputAction = TextInputAction.next,
      this.validator});

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
        Row(
          children: [
            if (prefix != null)
              Container(
                width: 25,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    prefix.runtimeType == String
                        ? Text(
                            prefix,
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 18,
                            ),
                          )
                        : Icon(
                            prefix,
                            color: Colors.black54,
                            size: 18,
                          ),
                    SizedBox(width: 5),
                  ],
                ),
              ),
            Flexible(
              child: TextFormField(
                keyboardType: TextInputType.number,
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
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'^ ?\d*')),
                ],
              ),
            ),
          ],
        ),
        if (inputHelp != null)
          Column(children: [
            SizedBox(height: 7),
            Row(
              children: [
                Text(
                  inputHelp,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ])
      ],
    );
  }
}
