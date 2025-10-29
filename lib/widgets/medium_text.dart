import 'package:flutter/material.dart';
class medium_text_page extends StatefulWidget {
  final String textValue;
  const medium_text_page({super.key, required this.textValue});
  @override
  State<medium_text_page> createState() => medium_text();
}
class medium_text extends State<medium_text_page> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.textValue);
  }
}
