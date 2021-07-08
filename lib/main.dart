import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:tokalog/configs/colors.dart';
import 'package:tokalog/providers/product.dart';
import 'package:tokalog/screens/products/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider(),
      child: MaterialApp(
        title: 'Tokalog',
        home: ProductsScreen(),
        routes: {},
        theme: ThemeData(
          accentColor: AppColor.pink,
          canvasColor: AppColor.white,
          primarySwatch: AppColor.rose,
          fontFamily: GoogleFonts.lato().toString(),
        ),
      ),
    );
  }
}
