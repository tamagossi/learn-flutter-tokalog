import 'package:flutter/material.dart';
import 'package:tokalog/screens/order.dart';
import 'package:tokalog/screens/user_product.dart';
import 'package:tokalog/widgets/molecules/menu_item.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        leading: GestureDetector(
          child: Icon(Icons.close),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activity',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 20),
            MoleculeMenuItem(
              icon: Icons.receipt_outlined,
              text: 'My Order',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => OrderScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 15),
            MoleculeMenuItem(
              icon: Icons.inventory_2_outlined,
              text: 'Product Management',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => UserProductScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
