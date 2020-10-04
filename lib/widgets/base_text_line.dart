import 'package:flutter/material.dart';

class BaseTextLine extends StatelessWidget {
  final String label;
  final String value;

  const BaseTextLine(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Text(value)
      ],
    );
  }
}
