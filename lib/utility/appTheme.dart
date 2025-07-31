import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';
var themData = ThemeData(
  useMaterial3: false,
  scaffoldBackgroundColor: AppColors.primaryColor,
  appBarTheme: AppBarTheme(color: AppColors.primaryColor),
  cardTheme: const CardTheme(color: Colors.white, elevation: 2
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      textStyle: TextStyle(
        color: AppColors.primaryColor,
        backgroundColor: AppColors.primaryColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  buttonTheme: ButtonThemeData(buttonColor: AppColors.button3Color),
);
