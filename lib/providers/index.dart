import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:tokalog/providers/cart.dart';
import 'package:tokalog/providers/orders.dart';
import 'package:tokalog/providers/product.dart';

class MainProvider {
  static List<SingleChildWidget> get providers {
    return [
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => OrderProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
    ];
  }
}
