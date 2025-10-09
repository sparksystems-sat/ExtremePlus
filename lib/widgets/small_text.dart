import 'package:flutter/material.dart';

class samll_text_page extends StatefulWidget {
  final String text_value;

  const samll_text_page({super.key, required this.text_value});

  @override
  State<samll_text_page> createState() => samll_text();
}
class samll_text extends State<samll_text_page> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text_value);
  }
}
