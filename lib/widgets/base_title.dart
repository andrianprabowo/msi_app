import 'package:flutter/material.dart';
import 'package:msi_app/utils/constants.dart';

class BaseTitle extends StatelessWidget {
  final String title;

  const BaseTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: kPrimaryColor,
      ),
    );
  }
}
