library flutterfly;

import 'package:flutter/material.dart';

export 'src/form/index.dart';
export 'src/ui/components/index.dart';

final ThemeData Function(String fontFamily) flyThemeData = (String fontFamily) {
  Color primaryColor = Color.fromARGB(255, 36, 123, 160);
  Color errorColor = Color.fromARGB(255, 235, 84, 124);
  Color accentColor = Color.fromARGB(255, 112, 193, 179);
  Color enabledBorderColor = Color.fromARGB(255, 235, 235, 235);
  TextStyle labelStyle = TextStyle(
      fontSize: 16,
      color: Color.fromARGB(255, 134, 134, 134),
      fontWeight: FontWeight.bold);
  BorderSide inputBorder = BorderSide(width: 1.5);
  Color textColor = Colors.black87;
  // returns our wonderful theme
  return ThemeData(
      fontFamily: fontFamily,
      primaryColor: primaryColor,
      accentColor: accentColor,
      errorColor: errorColor,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(color: textColor),
      ),
      primaryTextTheme: TextTheme(
          headline1: TextStyle(color: textColor),
          headline2: TextStyle(color: textColor),
          headline3: TextStyle(color: textColor),
          headline4: TextStyle(color: textColor),
          headline5: TextStyle(color: textColor),
          headline6: TextStyle(color: textColor),
          bodyText1: TextStyle(color: textColor),
          bodyText2: TextStyle(color: textColor),
          subtitle1: TextStyle(color: textColor),
          subtitle2: TextStyle(color: textColor)),
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
