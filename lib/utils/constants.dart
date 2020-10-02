import 'package:flutter/material.dart';

// Base URL
const kBaseUrl = 'http://103.87.86.29:12950';

// Color
const kPrimaryColor = Color.fromRGBO(73, 112, 191, 1.0);
const kAccentColor = Color.fromRGBO(191, 164, 84, 1.0);

// Dimension
const kElevation = 1.0;
const kTiny = 2.0;
const kSmall = 4.0;
const kMedium = 8.0;
const kLarge = 16.0;

// Decoration
final kBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(kSmall)),
  border: Border.all(
    width: kTiny,
    color: kPrimaryColor,
    style: BorderStyle.solid,
  ),
);
