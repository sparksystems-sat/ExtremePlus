import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';

class body_text_page extends StatefulWidget {
  final String text_value;
  const body_text_page({super.key, required this.text_value});
  @override
  State<body_text_page> createState() => body_samll_text();
}

class body_samll_text extends State<body_text_page> {
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.justify,
      widget.text_value,
      style: TextStyle(
        color: AppColors.text_color,
        fontSize: 15.0, 
        letterSpacing: 0.5,
   
        // Recommended size for readability
        // Nearly black, but slightly softer
        height: 1.4, // Line height for better readability (CSS line-height)
      
      ),
    );
  }
}
