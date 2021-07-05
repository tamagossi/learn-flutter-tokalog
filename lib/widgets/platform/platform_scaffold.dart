import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformScaffold extends StatelessWidget {
  final Widget appBarText;
  final Widget content;

  PlatformScaffold({
    this.appBarText,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: content,
            navigationBar: CupertinoNavigationBar(
              middle: appBarText,
            ),
          )
        : Scaffold(
            body: content,
            appBar: AppBar(
              title: appBarText,
            ),
          );
  }
}
