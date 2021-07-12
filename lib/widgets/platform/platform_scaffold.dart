import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformScaffold extends StatelessWidget {
  final Widget appBarText;
  final Widget content;
  final Widget trailing;
  final List<Widget> actions;

  PlatformScaffold({
    @required this.appBarText,
    this.actions,
    this.content,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: content,
            navigationBar: CupertinoNavigationBar(
              middle: appBarText,
              trailing: trailing ?? null,
            ),
          )
        : Scaffold(
            body: content,
            appBar: AppBar(
              title: appBarText,
              actions: actions ?? null,
            ),
          );
  }
}
