import 'package:flutter/material.dart';
import 'package:todo_app/res/colors.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: "Nunito",
    brightness: Brightness.dark,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.black,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kPrimaryColor,
    ),
  );
}
