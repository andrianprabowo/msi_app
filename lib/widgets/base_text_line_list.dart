import 'package:flutter/material.dart';

class BaseTextLineList extends StatelessWidget {
  final String label;
  final String value;
  final double px;

  const BaseTextLineList(this.label, this.value, this.px);

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
        SizedBox(
          width: px,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
