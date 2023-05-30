import 'package:flutter/material.dart';
import 'package:youapp_test/helper/color_helper.dart';

final ThemeData AppTheme = ThemeData(
  appBarTheme: AppBarTheme(
      backgroundColor: ColorHelper.scaffoldBackground,
      shadowColor: Colors.transparent),
  scaffoldBackgroundColor: ColorHelper.scaffoldBackground,
  textTheme: TextTheme(
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),
);
