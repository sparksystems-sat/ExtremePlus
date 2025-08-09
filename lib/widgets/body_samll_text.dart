import 'package:flutter/material.dart';

class body_samll_text_page extends StatefulWidget {
  final String text_value;

  body_samll_text_page({super.key, required this.text_value});

  @override
  State<body_samll_text_page> createState() => body_samll_text();
}

class body_samll_text extends State<body_samll_text_page> {
  Widget build(BuildContext context) {
    return Text(widget.text_value);
  }
}
