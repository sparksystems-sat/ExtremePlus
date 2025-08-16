import 'package:flutter/material.dart';

class medium_text_page extends StatefulWidget {
  final String text_value;

  medium_text_page({super.key, required this.text_value});

  @override
  State<medium_text_page> createState() => medium_text();
}

class medium_text extends State<medium_text_page> {
  Widget build(BuildContext context) {
    return Text(widget.text_value);
  }
}
