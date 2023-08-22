// ignore: camel_case_types
import 'package:flutter/material.dart';

class add_link_widget extends StatelessWidget {
  final Color color;
  final Color textColor;
  final Color iconColor;
  const add_link_widget({
    super.key,
    required this.color,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.add,
              size: 32,
              color: iconColor,
            ),
            Text(
              "Add Link",
              style: TextStyle(
                  color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
