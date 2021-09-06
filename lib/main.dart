import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:tokalog/configs/colors.dart';
import 'package:tokalog/providers/auth.dart';
import 'package:tokalog/providers/index.dart';
import 'package:tokalog/screens/auth.dart';
import 'package:tokalog/screens/products/index.dart';

Future main() async {
  await dotenv.load(fileName: '.env');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MainProvider.providers,
      child: Consumer<AuthProvider>(
        builder: (ctx, authProvider, _) => MaterialApp(
          title: 'Tokalog',
          home: authProvider.isAuthenticated ? ProductsScreen() : AuthScreen(),
          routes: {},
          theme: ThemeData(
            accentColor: AppColor.rose,
            canvasColor: AppColor.white,
            fontFamily: GoogleFonts.lato().toString(),
            primarySwatch: AppColor.white,
          ),
        ),
      ),
    );
  }
}
