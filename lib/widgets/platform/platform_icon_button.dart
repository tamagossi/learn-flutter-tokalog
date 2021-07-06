import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformIconButton extends StatelessWidget {
  final Function onPressed;
  final Widget icon;

  PlatformIconButton({
    @required this.icon,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            padding: EdgeInsets.all(0),
            child: icon,
            onPressed: onPressed,
            minSize: 10,
          )
        : IconButton(
            padding: EdgeInsets.all(0),
            icon: icon,
            onPressed: onPressed,
            iconSize: 10,
          );
  }
}
