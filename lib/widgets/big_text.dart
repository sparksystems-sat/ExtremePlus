import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';

class big_text_page extends StatefulWidget {
  final String text_value;
  big_text_page({super.key, required this.text_value});
  @override
  State<big_text_page> createState() => big_text();
}

class big_text extends State<big_text_page> {
  Widget build(BuildContext context) {
    return Text(
      widget.text_value,
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: AppColors.icon_color,
      ),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
  }
}
