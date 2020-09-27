import 'package:flutter/material.dart';
import 'package:msi_app/utils/constants.dart';

ThemeData themeData() {
  return ThemeData(
      primaryColor: kPrimaryColor,
      accentColor: kAccentColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonTheme: ButtonThemeData(
        buttonColor: kPrimaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: inputDecorationTheme());
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(kMedium),
    borderSide: BorderSide(color: kPrimaryColor, width: kTiny),
    gapPadding: kSmall,
  );
  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: kLarge),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
    // counterStyle: const TextStyle(height: 0),
    errorStyle: const TextStyle(height: 0),
  );
}
