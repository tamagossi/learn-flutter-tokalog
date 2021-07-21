import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoleculeNumberInput extends StatelessWidget {
  final dynamic prefix;
  final String label;
  final String placeholder;
  final String inputHelp;
  final TextInputAction textInputAction;

  MoleculeNumberInput({
    @required this.label,
    this.inputHelp,
    this.placeholder,
    this.prefix,
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
