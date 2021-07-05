import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformProgressIndicator extends StatelessWidget {
  final double progress;
  final Color materialBackgroundColor;
  final Color materialColor;

  PlatformProgressIndicator({
    this.progress,
    this.materialBackgroundColor,
    this.materialColor,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoActivityIndicator()
        : CircularProgressIndicator(
            value: progress,
          );
  }
}
