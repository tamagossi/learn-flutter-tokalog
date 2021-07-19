import 'package:flutter/material.dart';

class MoleculeMenuItem extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String text;

  MoleculeMenuItem({
    this.icon,
    this.onTap,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
