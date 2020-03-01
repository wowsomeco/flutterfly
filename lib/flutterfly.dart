library flutterfly;

import 'package:flutter/material.dart';

export 'src/form/index.dart';
export 'src/ui/components/index.dart';

final ThemeData Function() flyThemeData = () {
  Color primaryColor = Color.fromARGB(255, 36, 123, 160);
  Color errorColor = Color.fromARGB(255, 235, 84, 124);
  Color accentColor = Color.fromARGB(255, 112, 193, 179);
  Color enabledBorderColor = Color.fromARGB(255, 235, 235, 235);
  TextStyle labelStyle = TextStyle(
      fontSize: 16,
      color: Color.fromARGB(255, 134, 134, 134),
      fontWeight: FontWeight.bold);
  BorderSide inputBorder = BorderSide(width: 1.5);
  // returns our wonderful theme
  return ThemeData(
      fontFamily: 'JosefinSans',
      primaryColor: primaryColor,
      accentColor: accentColor,
      errorColor: errorColor,
      cardTheme: CardTheme(
          elevation: 0,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(color: enabledBorderColor))),
      buttonTheme: ButtonThemeData(
          buttonColor: primaryColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0))),
      inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          labelStyle: labelStyle,
          prefixStyle: labelStyle,
          focusedErrorBorder: OutlineInputBorder(
              borderSide: inputBorder.copyWith(color: errorColor)),
          errorBorder: OutlineInputBorder(
              borderSide: inputBorder.copyWith(color: errorColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: inputBorder.copyWith(color: primaryColor)),
          enabledBorder: OutlineInputBorder(
              borderSide: inputBorder.copyWith(color: enabledBorderColor))));
};
