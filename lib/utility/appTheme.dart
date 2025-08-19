import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';

var themData = ThemeData(
  useMaterial3: false,
  textTheme: TextTheme(
    bodySmall: TextStyle(color: AppColors.text_color),
    bodyMedium: TextStyle(color: AppColors.text_color),
    bodyLarge: TextStyle(color: AppColors.text_color),
  ),
  scaffoldBackgroundColor: AppColors.main_background_color,
  appBarTheme: AppBarTheme(color: AppColors.primaryColor),
  iconTheme: IconThemeData(color: AppColors.icon_color),
  primaryColor: AppColors.icon_color,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      // backgroundColor: AppColors.primaryColor,
      textStyle: TextStyle(
        color: AppColors.text_color,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  buttonTheme: ButtonThemeData(buttonColor: AppColors.button3Color),
);
