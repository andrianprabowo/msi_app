import 'package:flutter/material.dart';

class BaseTitleColor extends StatelessWidget {
  final String title;

  const BaseTitleColor(this.title);

  @override
  Widget build(BuildContext context ) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.red[600],
      ),
    );
  }
}
